Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C3F437847
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 17:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360528; cv=none; b=Gr0xwJwssDpYBrbeEQlti/YDLLhx9tXhQbNUcT9XYAY60vOOAKpDcPuefsOqawwZr5kjzTjG/w7rP1uLE++vcqZKdCElq3CtTIizVr1chPi+VFp8Ti1PZjdQ5T/gl44gK/GLcPdoh+40vMRLTEwIhMZ+j3mikeQbaTJM20xyRX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360528; c=relaxed/simple;
	bh=SA+7qoByX2i3ZbXhf/xYf8HfYh5roodIPFQZpxNv6tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YZ8jmNaN5QRRZTH1BuERkJo5XvQJ8OI3EA3dk/76nnjawdsxgN6M32cvH+Dt81X/iXfSHaBS7hwQN1xFDAsAcVwek/f5LzSp6ph5XjdUUlNTECA0o/62+VPo3YQcvxh0PgDB/7gvlHNa6hIM/uBrat26LG7wkoa5WJocsgpC/Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUhS0T0l; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUhS0T0l"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c126e47a82cso398058566b.2
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 10:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783360525; x=1783965325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kmSKkj5hOXJj95w1wKmp14gv5ekFNxv0d27UUCnYNkE=;
        b=DUhS0T0lNrQdzH9petmXNDkMaBL7JqScU7qqRO9ia3XP0NMCvD4irhnIvVzNFcmewk
         OGq3cxjIBlmDSbareFj7mvonX8sbFx0/hxcl3lZWcghbIp+0kizWtDthl3MVkChfG1AZ
         gZGGsRasgkJBNxtwNFSpmpQ2vy9cC0QVo9JwTPUWxgK40ZZOGfBVvfOokNV712BsR0hm
         m8nffXiEP+4FVw74GVz7h/I4JvyB0Fw2mIVOhoPvlKHuLFNZXy9arld5jc+XJvpCnEIp
         opWI4iiF471cDyTfLIvyAze/1zwyq3ItbYNaYG9sIYaVy+5TyCIClI7knMJIurOMDet9
         yJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783360525; x=1783965325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kmSKkj5hOXJj95w1wKmp14gv5ekFNxv0d27UUCnYNkE=;
        b=dmGnh1hVkC3wu8SN4bms7h6g6xAE330mgZKF9Ul3bbK3hUxve7hqiNpicjyeeZYyig
         wlti3rb8SgsRZTMQ7aCDXFY8WuK7s5vFEJihZNyRmpbrleTkrPGihS4HFBqRzGhBy1sU
         5zpet6kBaXq7fqLL5xFaskslSALPY+ie5HWjbcJkefTlReMrPQgg0d/3KCqCEQdYO6/D
         WVdF6g8EFLouGW65lfD4TfpLS23avPTvIzR5NPMOAju217P+qq1oo+YRxUw9y2lwzeDA
         jo77rOX1I6kkzTYxRaTg/LsqNhSKp+5QtsoGFamNPC2NluOMWAUmZA9xnMoUT5D35z0O
         G93Q==
X-Forwarded-Encrypted: i=1; AHgh+RoiF47YcIly+Mk/ViHPPqNDf7Jx/VvhA/o8jstrdu8ks3INkDI5mkSY3nyLhS5PsiREvvfgJ8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi8N9534nzrBQqQe8GxxfrLSY5M1hrHhOJd34tDH1CG7JkzuK9
	+ARsDQ9wxjXmldFh8tm2KK0jn1Kfu0BUDARFevWPI6+XyyaU8u/c46NfB/I7SmqC
X-Gm-Gg: AfdE7cnPsLGQkbBM3T7ts+Af4Qp+0Ysb4ZocxcaVvMFPx5x+XfSq/tu5DNA9V7gKL8A
	6+mRwhsDGISgPfaeOBCLKUYq5dXymJ8wXXRLIxNJQGoeb3ZFk3yXYVxA+3N6Jg9BSBvfsFf10/f
	Jl08IlhlkiXk11A3CDXgIC/bEiM4s/hfvhJZkBDVyZZUVq/iX3Qi5soUdMllIrSO+gS2yY1OjKP
	mtvL42slRRGunQtpf2POvhoV50wEETdtNP5WoNmUpms94JVAlYdXmA/FxE+1M+00LohldnxQZlC
	C6TTomGimS9cxbXgXZYDYZTxuYMAoG7WVmoyKKSzc04KErYvyIkwpAj9avtXfguOjv/AMwhr3QU
	p/sNTfkMf5SRJCRJF1rkURxGexpLKJRqXX1Kqp7fH6nldpImxU2SibXHYbLCT7UsZXRIdsrv7R1
	RMzvSNgsQZe9s9POQIqzoa6+K6y9+xjxNPyoFsuorkyNQ=
X-Received: by 2002:a17:906:b352:b0:c12:9927:4378 with SMTP id a640c23a62f3a-c15a66b53e7mr69153066b.8.1783360525254;
        Mon, 06 Jul 2026 10:55:25 -0700 (PDT)
Received: from andfed.netbird.selfhosted ([188.146.162.78])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6093794sm793698566b.21.2026.07.06.10.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:55:24 -0700 (PDT)
From: Andrei Fed <andfed.net@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Andrei Fed <andfed.net@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: magicmouse: fix battery reporting for Bluetooth Magic Trackpad USB-C
Date: Mon,  6 Jul 2026 19:55:07 +0200
Message-ID: <20260706175507.47288-1-andfed.net@gmail.com>
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

