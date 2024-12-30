# frozen_string_literal: true

desc "Generate the picture of the behavior of the code"
task :brutal do
  Dir.chdir("test") do # rubocop:disable ThreadSafety/DirChdir
    paths = %w[
      .
      ..
      helper.rb
    ]

    Dir.entries(".").reject { |name| paths.include?(name) }.each do |test|
      Dir.chdir(test) do # rubocop:disable ThreadSafety/DirChdir
        print "Generating #{test} test suite... "

        `bundle exec brutal`
        `chmod +x test.rb`

        puts "Done."
      end
    end
  end
end
