# This is an autogenerated function, ported from the original legacy version.
# It /should work/ as is, but will not have all the benefits of the modern
# function API. You should see the function docs to learn how to add function
# signatures for type safety and to document this function using puppet-strings.
#
# https://puppet.com/docs/puppet/latest/custom_functions_ruby.html
#
# ---- original file header ----
# got it via https://github.com/camptocamp/puppet-common
# written by David Schmitt
# Copyright (C) 2007 David Schmitt
# <david@schmitt.edv-bus.at>
# ---- original file header ----
#
# @summary
#   Summarise what the function does here
#
Puppet::Functions.create_function(:'installJubula') do
  # @param args
  #   The original array of arguments. Port this to individually managed params
  #   to get the full benefit of the modern function API.
  #
  # @return [Data type]
  #   Describe what the function returns here
  #
  dispatch :default_impl do
    # Call the method named 'default_impl' when this is matched
    # Port this to match individual params for better type safety
    repeated_param 'Any', :args
  end


  def default_impl(*args)
    
    Puppet::Parser::Functions.autoloader.loadall
    puts "in installJubula"
    url           = args[0]
    setupLocation = args[1]
    installPath   = args[2]
    scriptFile    = args[3]
    p url
    dir = File.dirname(setupLocation)
    FileUtils.makedirs(dir) if !File.directory?(dir)
    cmd1  = "curl -s -o #{setupLocation} #{url}"
    cmd2 = "#{scriptFile} #{setupLocation} #{installPath}"
    if !File.exists?(setupLocation)
      if Puppet[:noop]
	puts "#{__FILE__}: noop: #{cmd1}"
      else
	puts "#{__FILE__}: #{cmd1}"
	res = system(cmd1)
	puts res
      end
    else
	puts "#{__FILE__}: skipping get : #{setupLocation}"
    end
    if !File.directory?(installPath+'/jubula')
      Dir.chdir(File.dirname(setupLocation))
      if Puppet[:noop]
	puts "#{__FILE__}: noop: #{cmd2}"
      else
	puts "#{__FILE__}: #{cmd2}"
	res = system(cmd2)
	puts res
      end
    else
	puts "#{__FILE__}: skipping inst: #{installPath}"
    end
  
  end
end