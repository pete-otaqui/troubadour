require 'rubygems'
require 'sinatra'
require 'haml'

set :views, File.dirname(__FILE__) + '/templates'
set :haml, {:format => :html5}



get '/' do
  ps = projects
  p = project('index')
  haml :index, :locals => {:projects => ps, :project =>p}
end


get '/:project' do
  p = project(params[:project])
  haml :project, :locals => {:project => p, :title => " - " + p["title"]}
end



helpers do
  def projects
    projects = {
      'troubadour' => {
        'title' => 'Troubadour',
        'github' => 'http://github.com/pete-otaqui/troubadour'
      },
      'gravity-well' => {
        'title' => 'Gravity. Well...',
        'svn' => 'http://svn.otaqui.com/gravity-well/',
        'template' => 'gravity-well'
      },
      'index' => {
        'title' => 'Code'
      }
    }
    projects
  end
  def project(name)
    ps = projects
    ps[name]
  end
end

