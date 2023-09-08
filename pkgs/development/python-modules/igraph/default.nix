{ lib
, buildPythonPackage
, pythonOlder
, fetchFromGitHub
, pkg-config
, igraph
, texttable
, unittestCheckHook
}:

buildPythonPackage rec {
  pname = "igraph";
  version = "0.10.7";

  disabled = pythonOlder "3.7";

  format = "setuptools";

  src = fetchFromGitHub {
    owner = "igraph";
    repo = "python-igraph";
    rev = "refs/tags/${version}";
    hash = "sha256-BdMybNo2CiC0Yv9jfiFVuiwBRy4eMtz654JRvaPph9E=";
  };

  postPatch = ''
    rm -r vendor
  '';

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    igraph
  ];

  propagatedBuildInputs = [
    texttable
  ];

  # NB: We want to use our igraph, not vendored igraph, but even with
  # pkg-config on the PATH, their custom setup.py still needs to be explicitly
  # told to do it. ~ C.
  setupPyGlobalFlags = [ "--use-pkg-config" ];

  nativeCheckInputs = [
    unittestCheckHook
  ];

  pythonImportsCheck = [ "igraph" ];

  meta = with lib; {
    description = "High performance graph data structures and algorithms";
    homepage = "https://igraph.org/python/";
    changelog = "https://github.com/igraph/python-igraph/blob/${src.rev}/CHANGELOG.md";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ MostAwesomeDude dotlambda ];
  };
}
