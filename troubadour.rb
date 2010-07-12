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
  if project["git"]
    url = project['repo'] + '/commits/master.atom'
    puts "GETTING #{url}"
    rss = SimpleRSS.parse open(url)
  end
  haml :"#{template}", :locals => {
    :projects => projects,
    :project => project,
    :home => home,
    :rss => rss
  }
end


helpers do
  def all_projects
    projects = {
      'troubadour' => {
        'title' => 'Troubadour',
        'repo' => 'http://github.com/pete-otaqui/troubadour',
        'git' => true,
        'description' => 'Troubadour runs this site - it allows you to quickly put up a page about a code project, and customize this easily.'
      },
      'gravity-well' => {
        'title' => 'Gravity. Well...',
        'repo' => 'http://svn.otaqui.com/gravity-well/',
        'svn' => true,
        'description' => 'An experiment with Base2, SVG and Raphael JS.',
        'template' => 'gravity-well'
      },
      'vonnegut' => {
        'title' => 'Vonnegut',
        'repo' => 'http://github.com/bbc-frameworks/vonnegut',
        'git' => true,
        'description' => 'A Zend_Reflection based PHP documentation generator/'
      },
      
    }
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

