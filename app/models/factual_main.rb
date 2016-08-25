
class FactualMain

  @@client = Factual.new(Rails.application.secrets.factual_key,
                         Rails.application.secrets.factual_secret)

  def self.get_poi(neighborhood)
    @@client.table("places-us")
                .filters("locality" => "san francisco")
                .filters("neighborhood" => { "$includes" => neighborhood }).rows
  end

  def self.count_num(neighborhood)
    @@client.facets("places-us").select("category_ids")
                  .filters("locality" => "san francisco")
                  .filters("neighborhood" => { "$includes" => neighborhood }).rows
  end

end
