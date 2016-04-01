require 'rake/testtask'

Rake::TestTask.new :spec do |t|
  t.test_files = ['spec/cant_even_spec.rb']
end

task :default do
  launcher = case RUBY_PLATFORM
             when /darwin/i ; 'open'
             when /win/i    ; 'start'
             else           ; 'xdg-open'
             end
  `#{launcher} https://www.youtube.com/watch?v=dQw4w9WgXcQ`
end
