// Filename: asyncTaskChain.I
// Created by:  drose (23Aug06)
//
////////////////////////////////////////////////////////////////////
//
// PANDA 3D SOFTWARE
// Copyright (c) Carnegie Mellon University.  All rights reserved.
//
// All use of this software is subject to the terms of the revised BSD
// license.  You should have received a copy of this license along
// with this source code in a file named "LICENSE."
//
////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////
//     Function: AsyncTaskChain::is_started
//       Access: Published
//  Description: Returns true if the thread(s) have been started and
//               are ready to service requests, false otherwise.  If
//               this is false, the next call to add() or add_and_do()
//               will automatically start the threads.
////////////////////////////////////////////////////////////////////
INLINE bool AsyncTaskChain::
is_started() const {
  return (_state == S_started);
}

////////////////////////////////////////////////////////////////////
//     Function: AsyncTaskChain::do_get_next_wake_time
//       Access: Protected
//  Description: Returns the time at which the next sleeping thread
//               will awaken, or -1 if there are no sleeping threads.
//               Assumes the lock is already held.
////////////////////////////////////////////////////////////////////
INLINE double AsyncTaskChain::
do_get_next_wake_time() const {
  if (!_sleeping.empty()) {
    return _sleeping.front()->_wake_time;
  }
  return -1.0;
}

////////////////////////////////////////////////////////////////////
//     Function: AsyncTaskChain::get_wake_time
//       Access: Protected, Static
//  Description: Returns the time at which the indicated thread
//               will awaken. Assumes the lock is already held.
////////////////////////////////////////////////////////////////////
INLINE double AsyncTaskChain::
get_wake_time(AsyncTask *task) {
  return task->_wake_time;
}
