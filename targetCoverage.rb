#!/usr/bin/ruby
#encoding: utf-8

require 'json'
require 'find'
require 'yaml'
require 'fileutils'
require_relative 'trollop'

#author: jerrychu

=begin
    
 统计整体代码覆盖率和各个target的代码覆盖率数据 
 按html形式输出统计结果

=end

# 解析覆盖率报告
def parse_xcresult_json(cov_json_path)
    json = File.read(cov_json_path)
    return JSON.parse(json)
end

# 格式化输出信息
def format_coverage(coverage)
    return ((coverage * 1000).to_i / 10.0).to_s + '%'
end

if __FILE__ == $0
    opts = Trollop::options do
        opt :cov_json_path, 'Path for xcresult json file', :type => :string
        opt :output_file, 'Path for result file', :type => :string
    end

    Trollop::die :cov_json_path, 'must be provided' if opts[:cov_json_path].nil?

    result_path = if opts[:output_file].nil? then 'targetCov.html' else opts[:output_file] end
    html = File.new(result_path, "w+")

    html.puts '<html>'
    html.puts '<meta charset="utf-8">'
    html.puts '<table style="text-align: center;">'
    html.puts '<tr>'
    html.puts '<th>target</th>' + '<th>可执行代码行数</th>' + '<th>覆盖代码行数</th>' + '<th>代码覆盖率</th>'
    html.puts '<tr/>'

    # 解析json文件，获取增量代码覆盖率数据
    root_dict = parse_xcresult_json(opts[:cov_json_path])

    # 输出整体数据，用于shell读取
    data_file = File.new('tmpCov.txt', "w+")
    data_file.puts(root_dict['executableLines'])
    data_file.puts(root_dict['coveredLines'])
    data_file.puts(format_coverage(root_dict['lineCoverage']))

    # 输出html
    html.puts '<tr>'
    html.puts '<td>' + 'All' + '</td><td>' + root_dict['executableLines'].to_s + '</td><td>' + root_dict['coveredLines'].to_s + '</td><td>' + format_coverage(root_dict['lineCoverage']) +'</td>'
    html.puts '<tr/>'

    targets = root_dict['targets']
    targets.each do |target_dict| 
        html.puts '<tr>'
        html.puts '<td>' + target_dict['name'] + '</td><td>' + target_dict['executableLines'].to_s + '</td><td>' + target_dict['coveredLines'].to_s + '</td><td>' + format_coverage(target_dict['lineCoverage']) +'</td>'
        html.puts '<tr/>'
    end

    html.puts '</table>'
    html.puts '</html>'

end
