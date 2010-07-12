require 'rubygems'
require 'sinatra'
require 'haml'
require 'simple-rss'
require 'open-uri'
require 'ruby-debug'

set :views, File.dirname(__FILE__) + '/templates'
set :haml, {:format => :html5}



get '/' do
  projects = all_projects
  haml :index, :locals => {:projects => projects, :project => home, :home => home}
end

get '/style/troubadour.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :troubadour, :syntax => 'scss'
end


get '/:project' do
  projects = all_projects
  project = one_project(params[:project])
  template = project['template']
  template ||= 'project'
  rss = false
  # if project["git"]
  #   url = project['repo'] + '/commits/master.atom'
  #   puts "GETTING #{url}"
  #   rss = SimpleRSS.parse open(url)
  # end
  haml :"#{template}", :locals => {
    :projects => projects,
    :project => project,
    :home => home,
    :rss => rss
  }
end


helpers do
  def all_projects
    projects = {}
    Dir.foreach("projects") do |yml|
      if yml != '.' && yml != '..' 
        project_name = yml.sub(/\.yml$/, '')
        file_name = File.dirname(__FILE__) + "/projects/#{yml}"
        contents = YAML.load_file(file_name)
        projects[project_name] = contents
      end
    end
    pp projects
    projects
  end
  def one_project(name)
    ps = all_projects
    ps[name]
  end
  def home
    project = {
      'title' => 'Code'
    }
  end
end

