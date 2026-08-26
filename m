Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E5D3B9930
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 12:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787748298; cv=none; b=lbsbKWR394KhmNW7FjHx2GM7N/bUv36rhkH6/j3RjaJYt1EJIIiktPkQdDwRZ1PhKOlxxVbuRro7qYXZPHtrf6NGKY4ivyjUyP//WPtY8UgfZdaqiQ2EvvPw0X59eKxajgPK6AH/Qy0ckkUpcY5kPzdZpzOTXqoxp7g31npfrHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787748298; c=relaxed/simple;
	bh=liqzemktnoTHNfGU/+OrbcIe3xxIblR3kneBfjOLUKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0aoaK/29My1vbECE6/9s+Ri9rcHmh0rR8QUuSk13h2emX2wJ4lr+udVkqHvsnLFVey50ruthxuKmvs5JcBWDkHc0/lFEd4YITVenXTCjbhDPt4iDfpCRw70DsfBXOdiHrLNW4uWuKbZFw/JezFBBWZX8ESAw8J4Kg4BT52x4lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhJiy6v1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhJiy6v1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920A11F000E9;
	Wed, 26 Aug 2026 12:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787748297;
	bh=xtIxpwTYJ0U7QlTOTEMfLH39GGKDgU5qyRiVR+MSjyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GhJiy6v1lGc6zfwVFwlhAcrFtEiTjB+YAOvpILPULa+b+ERKx6OzUJwxpxKlgSTQA
	 xPbg2ie+TU4tAiSaL0/i6fUpTittY6Ap/gbyXjz/Nh2Cjeb7C4Jy4iM+ImMdml9/YK
	 YAwC8qDfIVDem5S+UPa8Kdn25l09917CjDZHk3oJWm1Wf2yKoR332od5E+PLcyAVu2
	 jI0i7A7kcG9gDe7TmdUg823I5pSaJNnoy68k8+QodYYIKXR62JFgnPPUqDvIJMh7ld
	 XRUHwT0g9djcG4doAfJP/ySlXle0Bv6InAneJ1prw/IozVq7mNVld/B3F+jRW/ys8i
	 heKma1oXzLvnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrei Fed <andfed.net@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] HID: magicmouse: fix battery reporting for Bluetooth Magic Trackpad USB-C
Date: Wed, 26 Aug 2026 08:44:54 -0400
Message-ID: <20260826124454.2941202-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082558-accuracy-duplex-8568@gregkh>
References: <2026082558-accuracy-duplex-8568@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrei Fed <andfed.net@gmail.com>

[ Upstream commit a1556b48efc157fdda07b52ecc56c7bd1e1786f0 ]

The Apple Magic Trackpad 2 (USB-C) reports a wildly wrong battery
capacity over Bluetooth, for example a constant 4% for a pack that is
actually at 74%.

The device's battery input report (0x90) is laid out as
[report-id][status][charge]. hid-input's synchronous capacity query,
hidinput_query_battery_capacity(), assumes the common
[report-id][capacity] layout and returns buf[1], which for this device
is the status byte rather than the charge (buf[2]).

magicmouse_fetch_battery(), which requests the battery report through
hid_hw_request() so the reply is decoded via the report descriptor at
the correct field offset, is gated to the USB models and never runs
over Bluetooth. The device does not push battery reports on its own
either, except a single one at connect time, which is delivered while
probe holds driver_input_lock and is silently dropped. All userspace
reads therefore go through the misparsing query, and the device is
stuck reporting its status byte as the capacity.

Enabling the fetch for Bluetooth is not sufficient on its own: user
space reacts to the power_supply registration immediately, so a query
is typically already in flight when the fetch reply is parsed.
hidinput_get_battery_property() stores the query result and marks the
battery as queried without rechecking whether a report arrived while
it was waiting, clobbering the just-reported correct value with the
misparsed one.

Fix this by adding HID_BATTERY_QUIRK_AVOID_QUERY for the Bluetooth
Magic Trackpad USB-C so the misparsing query path is never used, and
by fetching the battery at the end of probe for this device. hidp has
no asynchronous request() callback, so the fetch is serviced
synchronously via __hid_request() while probe still holds
driver_input_lock; call hid_device_io_start() first so the reply is
processed instead of being discarded.

Tested with a Magic Trackpad USB-C (004c:0324) over Bluetooth on
6.18.37: the reported capacity now matches the device (verified against
a raw GET_REPORT of report 0x90) and updates on reconnect.

Fixes: 87a2f10395c8 ("HID: magicmouse: Apple Magic Trackpad 2 USB-C driver support")
Cc: stable@vger.kernel.org
Signed-off-by: Andrei Fed <andfed.net@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
[ Kept only the new quirk entry from the conflicting hunk, dropping the adjacent Magic Trackpad 1 entry absent from this tree. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-input.c      |  3 +++
 drivers/hid/hid-magicmouse.c | 19 ++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 7c53a94106169..c7bea3868114c 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -358,6 +358,9 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
 		USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI),
 	  HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
+	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE,
+		USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC),
+	  HID_BATTERY_QUIRK_AVOID_QUERY },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM,
 		USB_DEVICE_ID_ELECOM_BM084),
 	  HID_BATTERY_QUIRK_IGNORE },
diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index d5df2745f3da4..dea5f358efb71 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -792,6 +792,12 @@ static bool is_usb_magictrackpad2(__u32 vendor, __u32 product)
 	       product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC;
 }
 
+static bool is_bt_magictrackpad2(__u32 vendor, __u32 product)
+{
+	return vendor == BT_VENDOR_ID_APPLE &&
+	       product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC;
+}
+
 static int magicmouse_fetch_battery(struct hid_device *hdev)
 {
 #ifdef CONFIG_HID_BATTERY_STRENGTH
@@ -800,7 +806,8 @@ static int magicmouse_fetch_battery(struct hid_device *hdev)
 
 	if (!hdev->battery ||
 	    (!is_usb_magicmouse2(hdev->vendor, hdev->product) &&
-	     !is_usb_magictrackpad2(hdev->vendor, hdev->product)))
+	     !is_usb_magictrackpad2(hdev->vendor, hdev->product) &&
+	     !is_bt_magictrackpad2(hdev->vendor, hdev->product)))
 		return -1;
 
 	report_enum = &hdev->report_enum[hdev->battery_report_type];
@@ -926,6 +933,16 @@ static int magicmouse_probe(struct hid_device *hdev,
 		schedule_delayed_work(&msc->work, msecs_to_jiffies(500));
 	}
 
+	/*
+	 * Query the Bluetooth Magic Trackpad USB-C battery as done for USB.
+	 * Start io first: probe holds driver_input_lock and the synchronous
+	 * GET_REPORT reply would otherwise be dropped.
+	 */
+	if (is_bt_magictrackpad2(id->vendor, id->product)) {
+		hid_device_io_start(hdev);
+		magicmouse_fetch_battery(hdev);
+	}
+
 	return 0;
 err_stop_hw:
 	if (is_usb_magicmouse2(id->vendor, id->product) ||
-- 
2.53.0

