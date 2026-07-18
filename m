Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de [91.216.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9611374A0E;
	Sat, 18 Jul 2026 12:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784377348; cv=none; b=g//6PsveIxUQWnKoUjZrrm/BvH0w83bfbLzpROyeHAYHggcfEBoweNAr0pSL68+/EjWWNIuiB1YbYkltneIkBVY8iVqqPiQdWpjjrQLqL8j1kwiRC6Vbc6ltdt8BGbpWPiXJb5te31p+hghZ3/C3vNwWFpiAmPDaKHm6AfMbXPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784377348; c=relaxed/simple;
	bh=s4WP1WzsZU26sY99HAth2G8R98jfdSkHxiyV38po4/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VatpiFFu6zmJ71eNCoelNOyXABpJK5z1R/ia70jbl47jYvIsvsLeXNUiylCa0MHzfRi0V5iWR2HV7vsJ2zzPzKwNamdQy7HPR4rjCqEUI3r6jhlS15gKlVXngqF7YY7Chi/xIVULma7cndbKDWEQNA3pD3DoqRw8yArAyghh47Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks; spf=none smtp.mailfrom=deq.rocks; dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.b=gy5ynHeO; arc=none smtp.client-ip=91.216.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.b="gy5ynHeO"
From: Andre Eikmeyer <dev@deq.rocks>
X-Lima-ML-UUID: 2512b6ff-dae7-41ca-b2c8-abc7fa4f48a8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1784376940;
	bh=s4WP1WzsZU26sY99HAth2G8R98jfdSkHxiyV38po4/E=;
	h=From:To:Cc:Subject:Date:From;
	b=gy5ynHeOzYQNVWbxVNFb+P1aPXVhAvgNbrID0nGG62lZB6+0DkopA2RQhF3R4sHZe
	 9HXp9ut582daM65Lfml5qBoRLdLt3wbAy5MS8mKjcUvxnST4/UBzoDLazDXPywhqqe
	 4BqnK1lC7J9YGXXBukPb+X8WDS0RDz20dW0p1nV9sjyuckJG4r2UI1LO3NwPuQx4CA
	 Q6qxMNviLQaMBFhHhs5y1JE4Y2F5B3MUUO4dAXB8lkUp1oocFmfH4RfErRv2cZJNL/
	 vhOMKftFvxPDVcMnOm6/zK8cmPECTEn5KkJtvUSdca7SMGaEAHiM1NKZRzWFHjkqqc
	 iQxmcauVo845Q==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	Aditya Garg <gargaditya08@live.com>,
	Andre Eikmeyer <dev@deq.rocks>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] HID: apple: preserve keyboard backlight across T2 resume
Date: Sat, 18 Jul 2026 14:15:26 +0200
Message-ID: <20260718121527.15924-1-dev@deq.rocks>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The T2 virtual USB host controller re-enumerates the internal keyboard
after system resume. The butterfly keyboard backlight currently uses
LED_CORE_SUSPENDRESUME, so the LED core sends a blocking request to the
old HID device while it is disappearing. That request fails with -ENODEV
and the newly probed device starts with its backlight off.

To fix this, we cache the requested brightness when the old HID device is
removed and restore it when the replacement is probed. We let
re-enumeration handle restoration instead of issuing a request through the
stale device.

Fixes: 1f95a6cd5ad7 ("HID: apple: ensure the keyboard backlight is off if suspending")
Cc: stable@vger.kernel.org
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 drivers/hid/hid-apple.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index bf7dd0fbf249..a5f232cc2b66 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -91,6 +91,9 @@ struct apple_sc_backlight {
 	struct hid_device *hdev;
 };
 
+/* T2 VHCI re-enumerates the internal keyboard across system resume. */
+static int apple_backlight_resume_brightness = -1;
+
 struct apple_backlight_config_report {
 	u8 report_id;
 	u8 version;
@@ -825,6 +828,7 @@ static int apple_backlight_led_set(struct led_classdev *led_cdev,
 static int apple_backlight_init(struct hid_device *hdev)
 {
 	int ret;
+	int brightness;
 	struct apple_sc *asc = hid_get_drvdata(hdev);
 	struct apple_backlight_config_report *rep;
 
@@ -860,13 +864,20 @@ static int apple_backlight_init(struct hid_device *hdev)
 	asc->backlight->cdev.name = "apple::kbd_backlight";
 	asc->backlight->cdev.max_brightness = rep->backlight_on_max;
 	asc->backlight->cdev.brightness_set_blocking = apple_backlight_led_set;
-	asc->backlight->cdev.flags = LED_CORE_SUSPENDRESUME;
+	/* VHCI re-enumeration restores the cached brightness in the next probe. */
+
+	brightness = READ_ONCE(apple_backlight_resume_brightness);
+	if (brightness < 0)
+		brightness = LED_OFF;
+	else
+		brightness = min_t(int, brightness, rep->backlight_on_max);
 
-	ret = apple_backlight_set(hdev, 0, 0);
+	ret = apple_backlight_set(hdev, brightness, 0);
 	if (ret < 0) {
 		hid_err(hdev, "backlight set request failed: %d\n", ret);
 		goto cleanup_and_exit;
 	}
+	asc->backlight->cdev.brightness = brightness;
 
 	ret = devm_led_classdev_register(&hdev->dev, &asc->backlight->cdev);
 
@@ -999,6 +1010,9 @@ static void apple_remove(struct hid_device *hdev)
 
 	if (asc->quirks & APPLE_RDESC_BATTERY)
 		timer_delete_sync(&asc->battery_timer);
+	if (asc->backlight)
+		WRITE_ONCE(apple_backlight_resume_brightness,
+			   asc->backlight->cdev.brightness);
 
 	hid_hw_stop(hdev);
 }
-- 
2.55.0

