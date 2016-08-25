class FactualMain

  def initialize
    @@client = Factual.new(Rails.application.secrets.factual_key,
                        Rails.application.secrets.factual_secret)
  end

  def self.get_poi(neighborhood)
    total_poi= []
    page = 1
    1.upto(7) do |count|
      poi = @@client.table("places-us")
                .filters("locality" => "sanfrancisco")
                .filters("neighborhood" => { "$includes" => neighborhood })
                .page(count, :per => 50).rows
      break if poi.empty?
      page += 1
      total_poi << poi
    end
    total_poi.flatten
  end

end