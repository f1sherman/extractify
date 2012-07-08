require 'extractify/version'
require 'nokogiri'

module Extractify
  def self.extract(doc, instructions = {})
    results = []

    doc = Nokogiri.parse(doc) unless doc.is_a?(Nokogiri::XML::Document)

    results = extract_nodes(doc, instructions)

    results
  end

  private

  def self.extract_nodes(doc, instructions)
    extracted_nodes = []

    instructions.each_pair do |container_selector, element_selectors|
      doc.search(container_selector).each do |container|
        container_nodes = {}

        element_selectors.each_pair do |label, selector|
          selector = ".#{selector}" if selector[0] == '/'

          node = container.search(selector).first
          container_nodes[label] = node.to_s if node
        end

        extracted_nodes << container_nodes if container_nodes.any?
      end
    end

    extracted_nodes
  end
end
