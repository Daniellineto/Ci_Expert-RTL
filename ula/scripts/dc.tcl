# -----------------------------------------------------------------------------
# 1) Search Path and Logic Library Setup
# -----------------------------------------------------------------------------
set_app_var search_path    "$search_path . ../rtl ../libs"
set_app_var target_library "sky130_fd_sc_hd__ff_100C_1v95.db sky130_fd_sc_hd__ss_100C_1v40.db"
set_app_var link_library   "* $target_library"
