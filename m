Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2DE3932D3
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787655433; cv=none; b=QBEVdx6+mMOW5z07JYeb8KA5UCA6KEaFIrnCdlKQI+6w/LyEPq3+W0cV+8DWP7TivFwfPGcE0mLJFcNI1oOQmev/x7IMQ1Hq7J7ETW4SR5x7l/8+sm9dH4gBgYOhOYo9kfTfH/64Or0bIDgZc6OORaSldJMHVr+AZ0h+z9rkIZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787655433; c=relaxed/simple;
	bh=xn7RtMu/tpQVV37VA1Pb8wh0KsNDYJt/hw/B5XqiPaA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JkuTu+myFnDRmXA+yEetfMCgGbtnmYg7uJVKD+DXOiCZ5UnB/lOU6hWfNvvEat9zMzCzGam3xrXkg+bcpkYJF4S2EfaN0j+ocxQHO9Xct2PnQhPqW+GBazxDXIXYSlBYDQS64r0fYaZxu9Sj12ieYRakslB8G0+RAcVYtcBdgUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IJghGs2J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IJghGs2J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78441F000E9;
	Tue, 25 Aug 2026 10:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787655432;
	bh=xjavgrseFBUxeruNmZkHFI0NkSzoDttTeofibUwr3BY=;
	h=Subject:To:Cc:From:Date;
	b=IJghGs2JBsubBmCTJm7cXEkyFX+Y2Oc3oodYIHqSXHOxS4OzRsXo3Gc24IM7qxPII
	 NmU1+hmcHtLtprATLCAkAz9tcR91htfVV31BdczvFN28DycmlR45cWIDmi7p1sBxFC
	 SJ1mw6tY3v7gskUGrRgm6W60beYYqxIqVMA+vEoQ=
Subject: FAILED: patch "[PATCH] HID: magicmouse: fix battery reporting for Bluetooth Magic" failed to apply to 6.1-stable tree
To: andfed.net@gmail.com,jkosina@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 25 Aug 2026 12:56:58 +0200
Message-ID: <2026082558-accuracy-duplex-8568@gregkh>
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
git cherry-pick -x a1556b48efc157fdda07b52ecc56c7bd1e1786f0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082558-accuracy-duplex-8568@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a1556b48efc157fdda07b52ecc56c7bd1e1786f0 Mon Sep 17 00:00:00 2001
From: Andrei Fed <andfed.net@gmail.com>
Date: Mon, 6 Jul 2026 19:55:07 +0200
Subject: [PATCH] HID: magicmouse: fix battery reporting for Bluetooth Magic
 Trackpad USB-C

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

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 3487600cadb4..f78166f97229 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -375,6 +375,9 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
 		USB_DEVICE_ID_APPLE_MAGICTRACKPAD),
 	  HID_BATTERY_QUIRK_IGNORE },
+	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE,
+		USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC),
+	  HID_BATTERY_QUIRK_AVOID_QUERY },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM,
 		USB_DEVICE_ID_ELECOM_BM084),
 	  HID_BATTERY_QUIRK_IGNORE },
diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index d2f95658a383..7be01cb103d2 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -843,6 +843,12 @@ static bool is_usb_magictrackpad2(__u32 vendor, __u32 product)
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
@@ -853,7 +859,8 @@ static int magicmouse_fetch_battery(struct hid_device *hdev)
 	bat = hid_get_battery(hdev);
 	if (!bat ||
 	    (!is_usb_magicmouse2(hdev->vendor, hdev->product) &&
-	     !is_usb_magictrackpad2(hdev->vendor, hdev->product)))
+	     !is_usb_magictrackpad2(hdev->vendor, hdev->product) &&
+	     !is_bt_magictrackpad2(hdev->vendor, hdev->product)))
 		return -1;
 
 	report_enum = &hdev->report_enum[bat->report_type];
@@ -996,6 +1003,16 @@ static int magicmouse_probe(struct hid_device *hdev,
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

