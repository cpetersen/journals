require "plos"

namespace :plos do
  namespace :search do
    desc 'Import all references from search'
    task :import => [:environment] do
      client = PLOS::Client.new(ENV['API_KEY'])
      ROWS = 200
      start = 542600
      total = start+ROWS+1
      # stopper = 600
      # while(stopper >= (start+ROWS)) do
      while(total >= (start+ROWS)) do
        puts "GETTING #{start} to #{start+ROWS}"
        hits = client.all(start, ROWS)
        hits.each_with_index do |hit, index|
          article_ref = ArticleRef.new
          article_ref.plos_id = hit.article_id
          article_ref.plos_part = hit.article_part
          article_ref.sequence = start+index
          article_ref.xml = hit.node.to_s
          article_ref.save!
        end
        start = start+ROWS
        total = hits.num_found
      end
    end
  end

  namespace :articles do
    desc 'Import all references from search'
    task :import => [:environment] do
      client = PLOS::Client.new(ENV['API_KEY'])
      ids = ArticleRef.count(:group => "plos_id")
      ids.keys.each_with_index do |plos_id, index|
        unless Article.find_by_plos_id(plos_id) # skip existing
          article = Article.new(:plos_id => plos_id)
          begin
            article.xml = PLOS::Article.content(plos_id)
            puts "Importing #{index} of #{ids.keys.size}"
          rescue Exception => e
            puts "Error on #{index} of #{ids.keys.size}"
            article.error = e.inspect
          end
          article.save
        end
      end
    end
  end
end

# 195400
# 379000
# 428800
# 542800