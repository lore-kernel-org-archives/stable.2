Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF4A503BC9
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788797084; cv=none; b=qn9vTHNAeS6wS2hh8cz9D05iD/8lboKSVYcZHtwhQmHnUMSvZoKq0tlaETi9b8lrB/hB1BPEbSm3zu89kvcrjrJ09E5opLAZ/KmlbqofcMlCPi3Jq9X3y1MRnXD7Oe181KFlaz4a48wXWzuI5MiBPw2YaFX+05HalcTm8kHPJxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788797084; c=relaxed/simple;
	bh=GPkYuAUMHpcLuYBjVXnyZOVuDhZusFgUBlUX6m+pLgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtGdaTE5mxFwJlQRqMRAgS/UZzDHI6udNSkDPb8WvLVn/e0CM3kRbHBpZNmHsSfBTQvML/6KgnreeQZL2/0n7Hs56a7VKBx2Mf3AAU9FD9Wq0mjirANQ8MQMx8MhxPkIfqVomPtAD4r7jMazIbK785iGTeZFPYW3Y8cqH0E1x6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYpd2iWq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYpd2iWq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC091F00A3D;
	Mon,  7 Sep 2026 16:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788797080;
	bh=zx5/Nu4i/N8D7zOS7qAuWwTLTAyQBlfoT5QXQOgONDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SYpd2iWqMZHIP5+GpcgPfdH1Oe1eE35DkT/hCD2lW5B1bo9OQO9VhxuEVNTydEFKS
	 AcEHTIQSMH9e+X5viAMVlGnuxbnxAUejMX16dlt+ZTC41O8mH8Gq5W4ld2VOZPN/H4
	 dGXyUJsarKc4MuUeFPyBu8H68vUg36v0pSY/1S2Ruf/yydY41jocSYNgT/AmN6BJb9
	 WqxQxU2U6UKbbvGgW3BjUg0Yt8MqPE0zRkJC9PqxrMAda07kZCeXNddGFeCidysSk/
	 HxNqjurduEKBn/X8R3FHS0bLH7fiee7w6OYcXiVxL9951BL54596C1nt2iIhFI7+6w
	 pCuSLXm/WD23Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Doruk Tan Ozturk <doruk@0sec.ai>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] HID: sony: fix UAF of ghl_poke_timer / ghl_urb at driver unbind
Date: Mon,  7 Sep 2026 12:04:38 -0400
Message-ID: <20260907160438.4159812-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090333-composer-outlook-0c0a@gregkh>
References: <2026090333-composer-outlook-0c0a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Doruk Tan Ozturk <doruk@0sec.ai>

[ Upstream commit a26705bd2e2728833e7a538ce91e58a5eeff496a ]

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
[ changed the old del_timer_sync() call to timer_shutdown_sync() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-sony.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index f7f7252d839ee..01745b5df2e4e 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -3085,7 +3085,9 @@ static void sony_remove(struct hid_device *hdev)
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
 	if (sc->quirks & (GHL_GUITAR_PS3WIIU | GHL_GUITAR_PS4)) {
-		del_timer_sync(&sc->ghl_poke_timer);
+		/* poison, not kill: a pending timer must not re-submit during teardown */
+		usb_poison_urb(sc->ghl_urb);
+		timer_shutdown_sync(&sc->ghl_poke_timer);
 		usb_free_urb(sc->ghl_urb);
 	}
 
-- 
2.53.0

