guard 'sass', input: 'sass', output: 'public/css'
guard 'coffeescript', input: 'coffee', output: "public/js"
guard 'livereload' do
  watch %r{views/.+.(erb|haml|slim|md|markdown)}
  watch %r{public/css/.+.css}
  watch %r{public/js/.+.js}
end

guard :concat, type: "js", files: %w(jquery jq_fancybox respond app), input_dir: "public/js", output: "public/js/all"

guard :concat, type: "css", files: %w(jq_fancybox main), input_dir: "public/css", output: "public/css/all"
