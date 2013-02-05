require "plos"

namespace :plos do
  namespace :search do
    desc 'Import all references from search'
    task :import => [:environment] do
      client = PLOS::Client.new(ENV['API_KEY'])
      ROWS = 200
      start = 0
      total = ROWS+1
      # stopper = 600
      # while(stopper >= (start+ROWS)) do
      while(total >= (start+ROWS)) do
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
end