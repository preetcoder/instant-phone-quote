#!/usr/bin/env ruby

# data collected from gist https://gist.github.com/preetcoder/54281a17f61e98e8c0f8e84eda7d9b1e
require 'json'

brand_file = File.read("brand.json")
series_with_models = File.read("series_with_models.json")
model_issues = File.read("model_issues.json")

brands = JSON.parse(brand_file, symbolize_names: true)
models_and_series = JSON.parse(series_with_models, symbolize_names: true)
issues = JSON.parse(model_issues, symbolize_names: true)


# print brands
puts "Select brand from below list:"

puts "#####################################"

#sort 
brands.sort_by { |key, value| value }.to_h.each do |key, value|
  puts "#{value} - #{key}"
end

puts "#####################################"

selectedBrand = gets.chomp

puts "Please select model of selected #{brands.key(selectedBrand.to_i)} brand"
puts "#####################################"

modelsFromAboveBrand = models_and_series.select do |model|
    model[:brand] == selectedBrand
end

if modelsFromAboveBrand.count > 0
    modelNameWithId = {}
    modelsFromAboveBrand.map {
        |ele| ele[:models].map {
            |model|  modelNameWithId[:"#{model[:name]}"] = model[:id].to_i
        }
    }.flatten
    modelNameWithId.sort_by { |key, value| value }.to_h.each do |key, value|
        puts "#{value} - #{key}"
    end
end
puts "#####################################"

selectedModel = gets.chomp
puts "Here are prices with issue for selected #{modelNameWithId.key(selectedModel.to_i)} model"
puts "#####################################"
issuesFromAboveModel = issues.select do |issue|
    issue[:model] == selectedModel
end

if issuesFromAboveModel.count > 0
    issuesInModelWithPrice = []
    issuesFromAboveModel.map {
        |ele| issuesInModelWithPrice << [ele[:name], ele[:price].round]
    }

    issuesInModelWithPrice.each {
        |ele| puts "Price for #{ele[0]} - $#{ele[1]}"
    }
    
end
