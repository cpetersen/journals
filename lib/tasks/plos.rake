require "plos"

namespace :plos do
  namespace :search do
    desc 'Import all references from search'
    task :import do
      client = PLOS::Client.new(ENV['API_KEY'])
      ROWS = 200
      start = 0
      total = ROWS+1
      while(total > (start+ROWS)) do
        hits = client.all(start, ROWS)
        hits.each_with_index do |hit, index|
          article = Article.new
          article.plos_i = hit.id
          article.sequence = start+index
          article.ref_xml = hit.node.to_s
          article.save!
        end
        start = start+ROWS
        total = hits.total
      end
    end
  end
end