require 'rake'
require 'doc_site_builder'

include DocSiteBuilder::Helpers

task :build, :build_distro do |task,args|
  # Figure out which distros we are building.
  # A blank value here == all distros
  build_distro = args[:build_distro] || ''
  generate_docs(build_distro)
end

task :package, :package_site do |task,args|
  package_site = args[:package_site] || ''
  Rake::Task["clean"].invoke
  Rake::Task["build"].invoke
  package_docs(package_site)
end

task :refresh_page, :single_page do |task,args|
  generate_docs('',args[:single_page])
end

task :clean do
  sh "rm -rf _preview/* _package/*" do |ok,res|
    if ! ok
      puts "Nothing to clean."
    end
  end
end
