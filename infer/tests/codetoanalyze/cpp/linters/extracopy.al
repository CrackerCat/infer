// Copyright (c) 2018-present, Facebook, Inc.
//
// This source code is licensed under the MIT license found in the
// LICENSE file in the root directory of this source tree.
DEFINE-CHECKER EXTRA_COPY = {
  LET name_not_contains_copy = NOT declaration_has_name(REGEXP("[cC]opy"));

  LET is_local_var = NOT is_global_var AND NOT is_static_local_var;

  LET is_copy_contructor =
    HOLDS-NEXT WITH-TRANSITION InitExpr
    (is_node("CXXConstructExpr") AND is_cxx_copy_constructor);

  SET report_when  =
    WHEN name_not_contains_copy AND is_local_var AND is_copy_contructor
    HOLDS-IN-NODE VarDecl;

  SET message = "Potentially unnecessary to copy var %name%";
  SET severity = "WARNING";
  SET mode = "ON";
  //SET whitelist_path = {
  //  REGEXP("admarket/.*"),
  //  REGEXP("multifeed/.*")
  //};

};
