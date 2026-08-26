Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB103FFACC
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764490; cv=none; b=LqtN306TZcumE+vXQTtotTQ/7mNLe+icuumVBLKEpk5SISJznMSoAHtjTXqGbTVHAlbPDFIxy9ZsrrvMoHFLgJQAiJr0RuxGkoykd7fqDRGcUGKkfg+1oDW3rCL1GAcQgXyiccBdEgrWOMpDyWZXqH2YDJ03flKqHTUMfb3MFBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764490; c=relaxed/simple;
	bh=M8+7JWOdEYT95B5KxsxXeqCq2g+xERyT47Nv0fcLi/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/KlrdSpeGeL/aaZQaNtvZtVkfYGXuOUANQu/9slJrH3wm77NSjZPq3S/N/eCfU+z/gPktkDQjvW6H/SeUc3/pzkv33BNYdN8sB7FhlPW8O8rN/OnoKEuu6AI2KRlif5+nro8XP0FKxjRs1dqU79f/bhEr2iIeS8u9B1q55If9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1kOm3mJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1kOm3mJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76A51F0155A;
	Wed, 26 Aug 2026 17:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787764452;
	bh=2813CSk61E8k4CB1jjOBMi0MfnvnpGVUW9OHBP5TwZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M1kOm3mJWDBX5+YOPWPIEsr8x9j+lyDOiyfFQrmyiEZj10/l1Fc9WG6RRe89cNkYO
	 d1kmTvPAx1EaE+5YtFeWFnh1uXm2R8Hb7FsKP6LJ0f4umGTsqLjeu3yYqPIR0qUirx
	 gZJ95ppZbuYDMb199FOyudScIKqZa7NJW7cLzd0g+oLCS9BQpT8tKjF77apiKFgFLL
	 1skNo/7QLxXPcLPL2pwZOQvNH9+8FgeL+GlKHf+voNwvSd6KTJwDOmOmJwg02mSlwQ
	 GyXnIl9IlWC5R0Jn5UyL33dIsYXLbMoRMPYs0zE983uoyM4SqGv5Nkof8HsPLCSan2
	 A5wFuXXzPHv+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baul Lee <baul.lee@xbow.com>,
	Federico Kirschbaum <federico.kirschbaum@xbow.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] HID: pidff: fix OOB write when hid->inputs is empty
Date: Wed, 26 Aug 2026 13:14:08 -0400
Message-ID: <20260826171408.2245886-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826171408.2245886-1-sashal@kernel.org>
References: <2026082518-countless-imply-6af9@gregkh>
 <20260826171408.2245886-1-sashal@kernel.org>
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
index ad0636ca71776..cf03400a47381 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -1298,13 +1298,20 @@ static int pidff_check_autocenter(struct pidff_device *pidff,
 int hid_pidff_init_with_quirks(struct hid_device *hid, __u32 initial_quirks)
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

