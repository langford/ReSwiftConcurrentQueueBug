
##Build Instructions:

Download

Open XcWorkspace file

Run on iPhone 7 Plus simulator on a computer with Xcode 8.2.1

Do not update cocoapods

This uses a reletively recent version of ReSwift, but this same problem is
observed in earlier versions as well.

##Testing Instructions:

Tap the "Launch Them!" button many times. It will work fine.

Tap the switch to start using the DispatchQueue.global() queue, which is a
concurrent queue.

Tap the "Launch Them!" button several times in rapid succession. It will fail as
the label describes, triggering "ReSwift:IllegalDispatchFromReducer - Reducers
may not dispatch actions" from merely the concurrent queue. 




