Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B13F43CE76
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787752043; cv=none; b=O/JY84znlc3tlm3fqKdGsIyPCErmU34dqwpG8xtF7UKrP2e7/wcB46hei+6/ZtglIeGWcn+M1ndACYHVljvgDt54ECwu1uunFT4zDFhet1vVwb7KWFJ1OVfL6NjxPTFCHjBxrLY0jb39F4V2cotKFgbnfoeEr+LZEzYOfB5/UMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787752043; c=relaxed/simple;
	bh=D+/pzhpch6/SKPu+P++wIgwOegNFS3aHHk1MutxllQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmejaPBWFyV077BCBoasq+Tf9H5GZ7E4MtebyedoOyPm5AaUnes9qQMloEzMVt3UNAwftDD+gR4406F4hKNdmSdQL6ps14IfqPwesvXjTBGrLYPGt6jeelTPcLgfcRfJ7HokJwmxFGjWo3QCGUl8phNgoonM2jZXY03dFB9KGtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMTuMzfM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMTuMzfM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE251F00A3E;
	Wed, 26 Aug 2026 13:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787752040;
	bh=G0W4RsLOVDkQJgAaZcSDGP0SKS+yZ6ZewuneX5I0Mbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XMTuMzfMEnkYje3/F/bExGOaLjhJ+zUTOXyQK9zG1My5vbKlF0PVhtV6FuxOnM41p
	 LAvrcb0VvYXmn//76ENJZEFEZ1nM12kzDpaKN5r7cTZyLw4ZwAbVyKZ1igGgSLem7F
	 N7WrNugBE58dSwwB/sqPlInAqQ2X7NIRTS+t2Qys35Id0h2vis8y+4Dbt7R0EfX7nK
	 7WucGMC3dCT/WqxuEcynFWcRiIzYiu0Ra4QOgZJ4T1q3EA4svJQsAnnqEcvEWBv6Ig
	 wsbyjQj4oegMcQjDJq2JNecdjmMW6UJiNXx829/MJLpDPEW+hYlb60xs+9UYcnphy0
	 iv+xzP3mTtJHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baul Lee <baul.lee@xbow.com>,
	Federico Kirschbaum <federico.kirschbaum@xbow.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] HID: pidff: fix OOB write when hid->inputs is empty
Date: Wed, 26 Aug 2026 09:47:15 -0400
Message-ID: <20260826134715.3968449-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826134715.3968449-1-sashal@kernel.org>
References: <2026082517-petroleum-anaerobic-3fd3@gregkh>
 <20260826134715.3968449-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Baul Lee <baul.lee@xbow.com>

[ Upstream commit 67bb1074e3d2d12fa059a9cc707e89398a4e4704 ]

hid_pidff_init_with_quirks() derives its input_dev from

	list_entry(hid->inputs.next, struct hid_input, list)

without first checking that hid->inputs is non-empty.  The list member
of struct hid_input is at offset 0, so on an empty list list_entry()
yields &hid->inputs itself and the following hidinput->input load reads
an unrelated member of struct hid_device.  dev is then a type-confused
pointer, and force-feedback init writes through it: each
set_bit(FF_*, dev->ffbit) stores 8 bytes at dev + 192, past the end of
the object dev actually aliases, and input_ff_create() adds further
writes of a heap pointer and two function pointers.

Until hid-universal-pidff the only caller was hid_pidff_init() from
usbhid, which runs under HID_CLAIMED_INPUT and therefore always has at
least one hid_input.  universal_pidff_probe() starts the device with
HID_CONNECT_DEFAULT & ~HID_CONNECT_FF and then calls
hid_pidff_init_with_quirks() directly whenever the descriptor carries a
PID usage page, bypassing that gate.  A report descriptor whose only
application collection is on HID_UP_PID leaves hid->inputs empty while
hid_connect() still succeeds through the hidraw claim, so probe reaches
the unguarded list_entry().

The write happens in the USB probe path, on the hotplug workqueue, so
plugging in a malicious device is enough to trigger it; no attacker
software and no logged-in user are required.  KASAN reports an 8-byte
out-of-bounds write in hid_pidff_init_with_quirks() reached from
universal_pidff_probe().

Check for an empty list before deriving dev and return -ENODEV, as the
other HID force-feedback drivers already do.  universal_pidff_probe()
propagates the error and unwinds.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: f06bf8d94fff ("HID: Add hid-universal-pidff driver and supported device ids")
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Reported-by: Baul Lee <baul.lee@xbow.com>
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/usbhid/hid-pidff.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 72ed11e054665..751570de7f52a 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -1405,13 +1405,20 @@ static int pidff_check_autocenter(struct pidff_device *pidff,
 int hid_pidff_init_with_quirks(struct hid_device *hid, u32 initial_quirks)
 {
 	struct pidff_device *pidff;
-	struct hid_input *hidinput =
-		list_entry(hid->inputs.next, struct hid_input, list);
-	struct input_dev *dev = hidinput->input;
+	struct hid_input *hidinput;
+	struct input_dev *dev;
 	struct ff_device *ff;
 	int max_effects;
 	int error;
 
+	if (list_empty(&hid->inputs)) {
+		hid_err(hid, "no inputs found\n");
+		return -ENODEV;
+	}
+
+	hidinput = list_first_entry(&hid->inputs, struct hid_input, list);
+	dev = hidinput->input;
+
 	hid_dbg(hid, "starting pid init\n");
 
 	if (list_empty(&hid->report_enum[HID_OUTPUT_REPORT].report_list)) {
-- 
2.53.0

