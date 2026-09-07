Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E95A5013A8
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792819; cv=none; b=iCcdDVHzkReondq0RIhyjpbSr+WZN4ZYfr9CLwX5mqODZI1BNXxFRKsNwUHgj9u0FvyY2u/MXdwHU66lEwZS+ZQhVvNXlqMvZxUbyycsiSLSeRcVGipR030eir3OwuXSbjwGc0119M1abZGx55tctuMD5H/2pgTAFj2xkONZovo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792819; c=relaxed/simple;
	bh=JVOXjFveCz08ds8FDrLxtm0ytiMRHFXZ/fOwmmZ5dfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCOYUvhPX7TMOAefA3jJgIKAT2IpQ95Y/5fNQ2+iLGVYLWfCqPDgoWZPBRJRCN0sENEBT87NB2EB42zkWmnKn6nWXT+mlyQNHW43/mcZqN9D9y9LrVqkieBfM7n+p8HRsM2L3mnW0vsRototY2N2QBdMrDwtkJ9CytFWUoAoY4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2XXBl/R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2XXBl/R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F8F1F00A3D;
	Mon,  7 Sep 2026 14:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788792804;
	bh=6MiBmAE2iXV6O1QMAat+SKsYA4/rZyY3v8kbGLiLjAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T2XXBl/RkPgkXsdwUp4a5Opdz7CJoWPULgYG9psC4c3ISZtiTqcMCqFno+2rHuSOD
	 xY/HUtKjMPIiyDimnftK2vMsyys35BDMfRQAQPJX+b9SVt2BR4U78jy4jtwFKacMdS
	 TzYEXWTbqdRopyv429J4v9fiSHu/KX9jr9m1CP/J/AZ4UEQ2+5A5el8m/3jOVP1zbn
	 3ddZeyqQSmsdFY5IYoJd8d62j1MiZrbmpNBahuKCiTw+ypjTSx5ER2tPLl5WPIko2m
	 oCVlC3xV5rEw9tD7yC97y6k4Kn0JmRCOOvtY6JV2/cW5E+UiuRXTU+7PkeGegWBkgd
	 WAOGtb2Tu9GWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andre Eikmeyer <dev@deq.rocks>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] HID: apple: preserve keyboard backlight across T2 resume
Date: Mon,  7 Sep 2026 10:53:22 -0400
Message-ID: <20260907145322.3690246-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090353-legal-vanish-db81@gregkh>
References: <2026090353-legal-vanish-db81@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andre Eikmeyer <dev@deq.rocks>

[ Upstream commit 2b5d1495bd101f3d9c13caf3923754f48ee7371a ]

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
Signed-off-by: Jiri Kosina <jkosina@suse.com>
[ preserved 6.12 structure placement and del_timer_sync() API while adding the upstream cached-brightness state and logic. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-apple.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 03ffd669eb6df..c45688a773549 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -89,6 +89,9 @@ struct apple_sc_backlight {
 	struct hid_device *hdev;
 };
 
+/* T2 VHCI re-enumerates the internal keyboard across system resume. */
+static int apple_backlight_resume_brightness = -1;
+
 struct apple_magic_backlight {
 	struct led_classdev cdev;
 	struct hid_report *brightness;
@@ -797,6 +800,7 @@ static int apple_backlight_led_set(struct led_classdev *led_cdev,
 static int apple_backlight_init(struct hid_device *hdev)
 {
 	int ret;
+	int brightness;
 	struct apple_sc *asc = hid_get_drvdata(hdev);
 	struct apple_backlight_config_report *rep;
 
@@ -832,13 +836,20 @@ static int apple_backlight_init(struct hid_device *hdev)
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
 
@@ -971,6 +982,9 @@ static void apple_remove(struct hid_device *hdev)
 
 	if (asc->quirks & APPLE_RDESC_BATTERY)
 		del_timer_sync(&asc->battery_timer);
+	if (asc->backlight)
+		WRITE_ONCE(apple_backlight_resume_brightness,
+			   asc->backlight->cdev.brightness);
 
 	hid_hw_stop(hdev);
 }
-- 
2.53.0

