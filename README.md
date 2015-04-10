# AirDrop Off

## What were we trying to solve?

While troubleshooting wireless issues for our staff who had migrated to OS X Yosemite, the Enterprise Services team came across a number of posts that went in-depth on changes in networking for OS X as of the 10.10 update and how that affected wireless (see [https://medium.com/@mariociabarra/wifriedx-in-depth-look-at-yosemite-wifi-and-awdl-airdrop-41a93eb22e48](https://medium.com/@mariociabarra/wifriedx-in-depth-look-at-yosemite-wifi-and-awdl-airdrop-41a93eb22e48) as an example). Based on this information they began testing with small groups turning off AirDrop. After positive feedback on increased wireless performance and reliability, we went to enact this across the board as a policy.

## What does it do?

Rather than outright disabling a cool feature like AirDrop, we wrote our script to flip AirDrop's "DiscoverableMode" setting for all local user accounts on a Mac to "No One" so it would no longer be broadcasting. Set to run once a day, the policy ensured that our managed clients would not be discoverable (and broadcasting to everything listening) but still allow staff to turn the feature back on to quickly move files between Macs wirelessly.

## How to deploy this script in a policy

Upload the script to your JSS and create a policy. At JAMF Software we have this script executing once per day for all managed computers. You may adjust the frequency and the scope according to your preference. This script has been tested against 10.10 clients.

## License

```
JAMF Software Standard License

Copyright (c) 2015, JAMF Software, LLC. All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice,
      this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice,
      this list of conditions and the following disclaimer in the documentation
      and/or other materials provided with the distribution.
    * Neither the name of the JAMF Software, LLC nor the names of its contributors
      may be used to endorse or promote products derived from this software without
      specific prior written permission.

THIS SOFTWARE IS PROVIDED BY JAMF SOFTWARE, LLC "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL JAMF SOFTWARE, LLC BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
```
