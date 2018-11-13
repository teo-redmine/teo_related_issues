# encoding: utf-8
require 'redmine'
#require 'issues_controller_patch'
require 'issue_relations_helper_patch'

Redmine::Plugin.register :teo_related_issues do
  name 'Teo Related Issues plugin'
  author 'Junta de Andalucía'
  description 'Muestra las peticiones relacionadas agrupadas por proyecto (contenedor)'
  version '0.0.2'
  url 'https://github.com/teo-redmine/teo_related_issues'
  author_url "http://www.juntadeandalucia.es"
end
