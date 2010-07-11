require 'rubygems'
require 'sinatra'
require 'haml'
#require 'ruby-debug'

set :views, File.dirname(__FILE__) + '/templates'
set :haml, {:format => :html5}



get '/' do
  projects = all_projects
  haml :index, :locals => {:projects => projects, :project =>home}
end

get '/style/troubadour.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :troubadour
end


get '/:project' do
  project = one_project(params[:project])
  template = project['template']
  template ||= 'project'
  haml :"#{template}", :locals => {:project => project}
end


helpers do
  def all_projects
    projects = {
      'troubadour' => {
        'title' => 'Troubadour',
        'git' => 'http://github.com/pete-otaqui/troubadour',
        'description' => 'Troubadour runs this site - it allows you to quickly put up a page about a code project, and customize this easily'
      },
      'gravity-well' => {
        'title' => 'Gravity. Well...',
        'svn' => 'http://svn.otaqui.com/gravity-well/',
        'description' => 'An experiment with Base2, SVG and Raphael JS.',
        'template' => 'gravity-well'
      }
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

