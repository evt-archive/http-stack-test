# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'http_stack_test'
  s.version = '0.0.0.0'
  s.summary = 'Test suite for the HTTP stack, including cooperative multitasking and SSL'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/eventide-project/http-stack-test'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.3.3'

  s.add_runtime_dependency 'connection'
  s.add_runtime_dependency 'process_host'
  s.add_runtime_dependency 'http-commands'
  s.add_runtime_dependency 'http-protocol'
  s.add_runtime_dependency 'http-server'
end
