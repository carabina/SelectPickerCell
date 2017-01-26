Pod::Spec.new do |s|
  s.name             = 'SelectPickerCell'
  s.version          = '0.1.0'
  s.summary          = 'SelectPickerCell is a UITableviewCell with a UIPicker'

  s.description      = <<-DESC
										Inline/Expanding uitableviewcell that shows a UIPicker.
										Adapted from DylanVann's DatePickerCell.
										This is meant to be very easy to configure.
                   DESC

  s.homepage         = 'https://github.com/oclef/SelectPickerCell'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Phong Le' => 'phong@oclef.com' }
  s.source           = { :git => 'https://github.com/oclef/SelectPickerCell.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'SelectPickerCell/Classes/**/*'

end
