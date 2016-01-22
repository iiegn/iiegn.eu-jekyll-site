#!/usr/bin/env ruby2.0
# encoding: utf-8
#
# accompany jekyll site-generator with jekyll-scholar and (mendeley) .bib files to
# symbolically link bib entries with a file field to targets in the assets dir.
#
# https://gist.github.com/iiegn/3220bde415ff94d464a1

require 'bibtex'
require 'fileutils'
require 'optparse'

options = {:bibfile => nil, :field_file => 'file', :field_filter =>
           'mendeley-groups:Synced', :target_dir => nil}

parser = OptionParser.new do |opts|
    opts.banner = "Usage: this.rb [options]"

    opts.on('', '--bibfile file', 'BibTeX filename') { |val| options[:bibfile] = val }
    opts.on('', '--field_file fieldname', 'Field name containing the path to the file') { 
        |val| options[:field_file] = val }
    opts.on('', '--field_filter fieldname:value', 'Include Filter: Field name to seperate by \',\' and look for value') { |val| options[:field_filter] = val }
    opts.on('', '--target_dir dir', 'Target Directory') { |val| options[:target_dir] = val }
    opts.on_tail('-h', '--help', 'Show this Message') do
        puts opts
        exit
    end
end

parser.parse!

missing = options.select{ |k, v| v.nil? }.map{ |k, v| k }
unless missing.empty?
    puts "Missing options: #{missing.join(', ')}"
    puts parser
    exit
end

bf = BibTeX.open(options[:bibfile])
filter_field_name, filter_field_value = options[:field_filter].split(':')
bf.each do |bf_entry|
    if bf_entry.respond_to?(filter_field_name)
        filter_field_vals = bf_entry[filter_field_name].split(',').map( &:strip )
        if filter_field_vals.include?(filter_field_value)
            ln_target_dec = ::LaTeX.decode(bf_entry[options[:field_file]].split(':')[1])
            # LaTeX.decode alters "'" to "’" - and we need to invert this
            ln_target_dec.gsub! '’', "'"
            ln_target = File::SEPARATOR+ln_target_dec
            ln_target_ftype = bf_entry[options[:field_file]].split(':')[2]
            ln_name = File.join(options[:target_dir],bf_entry.key+'.'+ln_target_ftype)
            puts ln_name
            FileUtils.ln_s(ln_target, ln_name, {:force => true})
        end
    end
end
