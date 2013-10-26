| gitPath gitCache |
Transcript cr; show: 'travis---->travisCI.st'.

gitCache := 'git_cache'.
gitPath := (Smalltalk at: #'FileDirectory' ifAbsent: [  ])
  ifNil: [ ((Smalltalk at: #'FileSystem') workingDirectory / gitCache) pathString ]
  ifNotNil: [:fileDirectoryClass | (fileDirectoryClass default directoryNamed: gitCache ) fullName].

"Sample travisCI.st file:

  Edit the Metacello api and test harness invocation
  using the correct configuration name and repository 
  location.

See https://github.com/dalehenrich/filetree/blob/pharo1.4/tests/travisCI.st for example"

Metacello new
  repository: 'http://smalltalkhub.com/mc/Seaside/MetacelloConfigurations/main';
  configuration:'Seaside3';
  get.

(Smalltalk at: #ConfigurationOfSeaside3) project stableVersion load: #('Tests').

"Run the tests"
TravisCIHarness
  value: #( 'ConfigurationOfSeaside3' )
  value: 'TravisCISuccess.txt' 
  value: 'TravisCIFailure.txt'.

