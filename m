Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AA8384233
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360398; cv=none; b=Sm7UWJHwj036TQR/HzJEiotrW7O4cldZoWynz5YRfbOwT3CLN2tgQcSBAnGepp7blmC4XPG2AUzMAG1brlH+RI1KjtFa8wrOfgm5sjx64qX18xi0B5JLogS819QhSKSkfqR+Eag3lW6TZR68L/JVwtBs5qI+0a7+4iJkv25TJt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360398; c=relaxed/simple;
	bh=SA+7qoByX2i3ZbXhf/xYf8HfYh5roodIPFQZpxNv6tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CRBcFVwxQxvpFaWno+FQ7RPmKwbLQrKaoMnVhZrIxrc+4I1zAcJxIEMKJ+RbvceBJWgU9D7CEhG5MfhhA7i847wbxdbE1hWWm9usfpTWo5A5RLz3ZoPxVjxG/iEm6LIBUaM/TDc4os+kNTd6I/A8S4ZDd0JcuAoXDxwFp3fUeC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rfsCI60G; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfsCI60G"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6983f20a8bfso5572185a12.1
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 10:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783360395; x=1783965195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kmSKkj5hOXJj95w1wKmp14gv5ekFNxv0d27UUCnYNkE=;
        b=rfsCI60GVZPQsBzmv0KhH3Af+yi31YgVKx82zFTc5ktvz+tkZDBbtLKyEEj3t+82kK
         iNVIcfSqbQP5tA332Xlxcdlpm4D09D3kOT6hCaOjljBLd+rRpzaDNgSGMiGbyVJlYF3r
         C2rhPK8dKaEEaGXWtS0GTZ97QDiFjFgcjEgfw+Q9eOBNr+n8frYepu6mJElnzaHDcCDV
         Fb1+AFuC8r0atAURNe3kBI1CIzF8NjK5gd7W5W3kTJ1PIDuQnuFFRUBNpXNdXlHFQo15
         kR9AheGJIYz/7IipIlpkqto8+D9BMAxpNU0XI7RFBQoHe9uDMDO5ZsX9evZNJWvTAIZt
         75pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783360395; x=1783965195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmSKkj5hOXJj95w1wKmp14gv5ekFNxv0d27UUCnYNkE=;
        b=nlvao2TCL87go57HDmgZwVs98iWXZ2/tewZyNoVmDaP6xzMSfIw3chQC6+D7GHHjnf
         JWFBbw465kvoMACId5B9eUEewzBeP5t8JTuWJZQelmJioYC8Kn+ZYZZL9PUawSDbk+em
         yDxvv81FxdhZ7wfeeG/eUyi1s+UF8x9MTiBo5+06F/ek+FZcSqoB0aWKPMtGgW2ULr/m
         qleLdlsGDIJY7HEACDd8/FEa4FRnYfZe8uRnj+JHSCVosBLSXQifEOozVKRmNNnhsnBS
         y/A+y4hE56YH1kzNnb9FPOBBzvR+ZXeMo0fYRRUNmToNW0sPyKhVLOH9Fe7vlHu9vHFL
         +gJQ==
X-Gm-Message-State: AOJu0YyV+R5wljsezq7JT7nCVya6phOqSdiLBEC8yViIR48TX+8+1caw
	BWj8RbT3Opdd59nR9BPb1ZtYynHasLRDcfdfS5WGxAdCjU+giyNTSm+Z/AU9ow==
X-Gm-Gg: AfdE7cmd4YV10bP76wDgm8ofBUGJ0cDR3F1zutJnz9i+yXBVhcZG3GOq5idulBYbjEs
	2EY4mDATTV4yVuZtxYysBT2UxRy9Lpl3XtehhxzOEmAuOYRFEkYUbHTSig6LCfN8twTWjvUg/B8
	EArXSoKGJ+K98HJhpxt+c/vtUHebL0UWWehBQ/hNYWRz5SIQjLqbb9vzZXE2WxEBCwQ4Y8DH5e0
	r8XakcmN+KxWg5ucfDeX1fzt/7BkdPU/GVw8SRHH0JEuHFcCp4nZfVwziU7WrZTk/0GExk67R9V
	LNiuzMpo7r/Q4xXWQttrqowRLfHmCh9LjngLzVipH4J5Kzd2zVuA0a0YTN4+pF0gVFhxqoro6TI
	0y1moFv6CsfrgfPf8kiAR0BRZmNxKAgEBmHs7iKrkz1p/sgYx2nUBn9NPxblRO3k2A/ljNX+UtO
	AiGpKE3+9VqP2BpMYTWmIE21Q8rTw+3FCX
X-Received: by 2002:a17:906:bced:b0:c12:34ed:da0a with SMTP id a640c23a62f3a-c15a6949174mr70032866b.54.1783360395009;
        Mon, 06 Jul 2026 10:53:15 -0700 (PDT)
Received: from andfed.netbird.selfhosted ([188.146.162.78])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b60f5e1asm772190266b.27.2026.07.06.10.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:53:14 -0700 (PDT)
From: Andrei Fed <andfed.net@gmail.com>
To: andfed.net@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] HID: magicmouse: fix battery reporting for Bluetooth Magic Trackpad USB-C
Date: Mon,  6 Jul 2026 19:53:09 +0200
Message-ID: <20260706175309.46459-1-andfed.net@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/hid/hid-input.c      |  3 +++
 drivers/hid/hid-magicmouse.c | 19 ++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 3487600..f78166f 100644
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
index 802a347..0c4e959 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -828,6 +828,12 @@ static bool is_usb_magictrackpad2(__u32 vendor, __u32 product)
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
@@ -838,7 +844,8 @@ static int magicmouse_fetch_battery(struct hid_device *hdev)
 	bat = hid_get_battery(hdev);
 	if (!bat ||
 	    (!is_usb_magicmouse2(hdev->vendor, hdev->product) &&
-	     !is_usb_magictrackpad2(hdev->vendor, hdev->product)))
+	     !is_usb_magictrackpad2(hdev->vendor, hdev->product) &&
+	     !is_bt_magictrackpad2(hdev->vendor, hdev->product)))
 		return -1;
 
 	report_enum = &hdev->report_enum[bat->report_type];
@@ -971,6 +978,16 @@ static int magicmouse_probe(struct hid_device *hdev,
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
2.54.0

