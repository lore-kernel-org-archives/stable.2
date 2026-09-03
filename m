Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3674A4B1478
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443394; cv=none; b=iNDQFtBdd78ssAoucFaJxXo2OBbouKrinDRtpPKmgCWUcBixtp9xFfXwgcaxUYKMBbLEKg2Uxkt6B5LRb2+AfY4SiBu9JlTDyg54vBDUu0jfdlOESetfS2QRumfRlJcrO6mYSsdc82UvNHosLH/M4jFPcYoslHdO9GVzhEWYkPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443394; c=relaxed/simple;
	bh=eI78euwA2zuJXXmmE6HdX+b76kpf4lLp1PZ5ZuDH4fI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GbmEO8L3SOcP8iq7kerdCSL0ra3zvXP0GOObezoiQ6bswfCMlJnzZSEJl14NLDeHSNm1zZszQBf+AyhS041GbAh/Hd3oBRIbmIwgRI3meIhBy/MzBMtmIw7NH8njN20D7Oyd/fQnmA7UMfKg/iUTWjjPzmHWqFidBAR9JRdEEpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ia/O0WzH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ia/O0WzH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C811F00ACF;
	Thu,  3 Sep 2026 13:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443381;
	bh=wrK3I6Jvfbjmwr6viktRgIm3mdku46TkBAja3u1Lu0U=;
	h=Subject:To:Cc:From:Date;
	b=Ia/O0WzHVNCCx3IbHYZPtibVCBuDwGYhx58ijc5vfIF+hLifW/bqk9xtA8q4Keeic
	 49kSoJhPgSXgwxU3ykzB+4A7K/dfoAmBHbkQQvX6uSxgSYzlsdeT6yHxXArehlQJeJ
	 qdwg6PNBU6JAkUKMD+pxckGMgC1fGMGItlvhNiww=
Subject: FAILED: patch "[PATCH] HID: sony: fix UAF of ghl_poke_timer / ghl_urb at driver" failed to apply to 6.1-stable tree
To: doruk@0sec.ai,jkosina@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:28:33 +0200
Message-ID: <2026090333-composer-outlook-0c0a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a26705bd2e2728833e7a538ce91e58a5eeff496a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090333-composer-outlook-0c0a@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a26705bd2e2728833e7a538ce91e58a5eeff496a Mon Sep 17 00:00:00 2001
From: Doruk Tan Ozturk <doruk@0sec.ai>
Date: Fri, 24 Jul 2026 16:27:03 +0200
Subject: [PATCH] HID: sony: fix UAF of ghl_poke_timer / ghl_urb at driver
 unbind

For GHL (Guitar Hero Live) dongles, sony_probe() arms a periodic timer:
ghl_magic_poke() (the timer callback) submits sc->ghl_urb, and the URB
completion ghl_magic_poke_cb() re-arms the timer with mod_timer().

sony_remove() drained the timer with timer_delete_sync() and then freed
the URB with usb_free_urb():

	timer_delete_sync(&sc->ghl_poke_timer);
	usb_free_urb(sc->ghl_urb);

timer_delete_sync() does not block re-arming, and while the URB is in
flight the timer is not pending, so the sync delete is a no-op. A URB
completion that runs after the delete re-arms the timer, and usb_free_urb()
only drops a reference -- it does not kill an in-flight URB. sc is
allocated with devm_kzalloc() and freed once sony_remove() returns, so the
re-armed ghl_poke_timer (embedded in sc) then fires on freed memory, a
use-after-free from timer softirq. This is a disconnect/rmmod race.

Poison the URB first, then shut the timer down, before freeing the URB.
usb_poison_urb() kills any in-flight URB and permanently rejects further
submissions, so a poke timer that is still pending cannot re-submit the
URB from ghl_magic_poke() in the window before timer_shutdown_sync() runs.
usb_kill_urb() would not suffice: it only cancels the in-flight URB and
leaves it submittable once it returns, so the pending timer could
re-submit it and put a fresh URB in flight over the freed sc.
timer_shutdown_sync() then drains any last callback and blocks re-arming.
The probe error path is unaffected: it is only reached before the timer
is armed.

Reproduced under KASAN on next-20260710 via dummy_hcd + raw-gadget
emulation of the GHL PS4 dongle (VID 0x1430 / PID 0x07bb): hid-sony binds
and arms the poke timer, the poke URB is held in flight, the driver is
unbound (freeing sc), then the URB is released. The completion re-arms the
timer on the freed sc, and the re-armed timer fires ~8 s later:

  BUG: KASAN: slab-use-after-free in ghl_magic_poke+0x98/0xb0
  Read of size 8 at addr ffff88810b02fd50 by task swapper/0/0
   ghl_magic_poke+0x98/0xb0
   call_timer_fn+0x35/0x2b0
   __run_timers+0x69c/0x9a0
   run_timer_softirq+0x173/0x2a0
  Allocated by task 169:  sony_probe
  Freed by task 338:      devres_release_group <- hid_device_remove (sony_remove)

Found by 0sec (https://0sec.ai) using automated source analysis.

Fixes: cc894ac55360 ("HID: sony: support for ghlive ps3/wii u dongles")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
Signed-off-by: Jiri Kosina <jkosina@suse.com>

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 5a7ab08cb825..52d156e1db39 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2424,7 +2424,9 @@ static void sony_remove(struct hid_device *hdev)
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
 	if (sc->quirks & (GHL_GUITAR_PS3WIIU | GHL_GUITAR_PS4)) {
-		timer_delete_sync(&sc->ghl_poke_timer);
+		/* poison, not kill: a pending timer must not re-submit during teardown */
+		usb_poison_urb(sc->ghl_urb);
+		timer_shutdown_sync(&sc->ghl_poke_timer);
 		usb_free_urb(sc->ghl_urb);
 	}
 

