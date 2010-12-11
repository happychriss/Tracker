# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Tracker::Application.initialize!


TT_LINEAR = 1
TT_ESTIMATE = 2
TT_ONETIME = 3

ESTIMATION_TYPE_SELECT = { :Linear => TT_LINEAR, :Estimate => TT_ESTIMATE, :OneTime => TT_ONETIME}
ESTIMATION_TYPE_SHOW = ESTIMATION_TYPE_SELECT.invert

#
#EST_STATUS_REQUESTED = 0
#EST_STATUS_ESTIMATED = 1
#EST_STATUS_PM_ESTIMATED= 2
#EST_STATUS_CLOSED= 3
#EST_STATUS_ONGOING= 4
#
#EST_STATUS_SELECT = {
#        :requested => EST_STATUS_REQUESTED,
#        :estimated => EST_STATUS_ESTIMATED,
#        :pm_estimated => EST_STATUS_PM_ESTIMATED,
#        :closed => EST_STATUS_CLOSED,
#        :ongoing => EST_STATUS_ONGOING}
#
#EST_STATUS_SHOW = EST_STATUS_SELECT.invert

# Type of Estimation / Baseline
BL_YES=1
BL_NO=0

WORK_TIME_FRAME = 7

