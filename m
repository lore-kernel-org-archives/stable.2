Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966583C1A
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787752922; cv=none; b=nNyeUTurrwfj7Ad5Bf7YcEYknHQyjFTiXNpFoI6w5lKNpE0PP+y524HJxiTa5p0d5o7ZQHnYImB1M9pdXT+vINv7nZu0MD+GEuOmEDMcUpU3Eoi7f8ik0AW/BT3zXSOxBp1OwtBukRqu3BA6S1FU3mxaFeOiJUFoVFm5DPHri1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787752922; c=relaxed/simple;
	bh=ZlbQq/w/APgl83OqlYZs1hGsh0ckmZhYx00JNw2xXkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sDYDIVhBf+9Ay0Ux54lEbOwWDPZoiYiKgvLMVyIPgJIB63LrSXne3qsTVsyb0C3KK59YA/vbA9TOu9keD6aUJ6aCu6O9eoytyzHL64HfWnj+3AuBggGYSS8IXJzHXzMVldZ+S9CH2uJ4Plrl8E4P8UCh8qMUql73DCDkRBKMlsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evKcqdlh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evKcqdlh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B88A1F000E9;
	Wed, 26 Aug 2026 14:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787752919;
	bh=wzo7uFs3n5uKZ30CsLxzcp0FZPL8Xggl/RK1RvZu9mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=evKcqdlh7uqZIPnqg5fo1AJ3kK0H40F1nagAnzUcfAI/j83wwhzlWTCb+8QTcW/Ad
	 nywhvBztua1I/nPyFhDRZGmTMuS5EvYnvxtGPHhC3qzNbcO9cNS3LTf9aDp+048kBm
	 /hdCIiuofrl83mPNhubPk2i+5J3hhU3MSe874e0BjYmEgr1oUU7xlPmvE0wjteDKzK
	 26XCvcWH4l+UgMKUM46+Y4lwgC/5w8bgfVK+1+itMAP/7FI1bPz3U2zrL2xJOW8ais
	 2Oyiu+2P1RKBKM12GoOTPtdH8Bx5Qc5r+lQWW6pr8SelnNnDUiAClHX4Z31zqRp+tK
	 i3nG/yFVFqn4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Antheas Kapenekakis <lkml@antheas.dev>,
	Benjamin Tissoires <bentiss@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] HID: asus: simplify RGB init sequence
Date: Wed, 26 Aug 2026 10:01:53 -0400
Message-ID: <20260826140155.107206-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082550-county-disabled-f55a@gregkh>
References: <2026082550-county-disabled-f55a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Antheas Kapenekakis <lkml@antheas.dev>

[ Upstream commit 56d1b33e644cca1bedffbc73d28778ed4ae30f64 ]

Currently, RGB initialization forks depending on whether a device is
NKEY. However, in reality both initialization forks are the same, other
than the NKEY initialization initializing the LED_REPORT_ID1,
LED_REPORT_ID2 endpoints, and the non-NKEY initialization having a
functionality check which is skipped for the NKEY path.

Therefore, merge the if blocks, gate the ID1/ID2 initializations
behind the NKEY quirk instead, and introduce the functionality check
for NKEY devices (it is supported by them).

There should be no functional change with this patch.

Acked-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
Link: https://patch.msgid.link/20260122075044.5070-2-lkml@antheas.dev
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Stable-dep-of: 02bf61dfb44f ("HID: asus: fix missing hid_is_usb() check")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-asus.c | 52 ++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 30 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 552a049c7d148..c9097e91f891d 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -635,13 +635,20 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
 	unsigned char kbd_func;
 	int ret;
 
-	if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD) {
-		/* Initialize keyboard */
-		ret = asus_kbd_init(hdev, FEATURE_KBD_REPORT_ID);
-		if (ret < 0)
-			return ret;
+	ret = asus_kbd_init(hdev, FEATURE_KBD_REPORT_ID);
+	if (ret < 0)
+		return ret;
 
-		/* The LED endpoint is initialised in two HID */
+	/* Get keyboard functions */
+	ret = asus_kbd_get_functions(hdev, &kbd_func, FEATURE_KBD_REPORT_ID);
+	if (ret < 0)
+		return ret;
+
+	/* Check for backlight support */
+	if (!(kbd_func & SUPPORT_KBD_BACKLIGHT))
+		return -ENODEV;
+
+	if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD) {
 		ret = asus_kbd_init(hdev, FEATURE_KBD_LED_REPORT_ID1);
 		if (ret < 0)
 			return ret;
@@ -649,34 +656,19 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
 		ret = asus_kbd_init(hdev, FEATURE_KBD_LED_REPORT_ID2);
 		if (ret < 0)
 			return ret;
+	}
 
-		if (dmi_match(DMI_PRODUCT_FAMILY, "ProArt P16")) {
-			ret = asus_kbd_disable_oobe(hdev);
-			if (ret < 0)
-				return ret;
-		}
-
-		if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
-			intf = to_usb_interface(hdev->dev.parent);
-			udev = interface_to_usbdev(intf);
-			validate_mcu_fw_version(hdev,
-				le16_to_cpu(udev->descriptor.idProduct));
-		}
-
-	} else {
-		/* Initialize keyboard */
-		ret = asus_kbd_init(hdev, FEATURE_KBD_REPORT_ID);
-		if (ret < 0)
-			return ret;
-
-		/* Get keyboard functions */
-		ret = asus_kbd_get_functions(hdev, &kbd_func, FEATURE_KBD_REPORT_ID);
+	if (dmi_match(DMI_PRODUCT_FAMILY, "ProArt P16")) {
+		ret = asus_kbd_disable_oobe(hdev);
 		if (ret < 0)
 			return ret;
+	}
 
-		/* Check for backlight support */
-		if (!(kbd_func & SUPPORT_KBD_BACKLIGHT))
-			return -ENODEV;
+	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
+		intf = to_usb_interface(hdev->dev.parent);
+		udev = interface_to_usbdev(intf);
+		validate_mcu_fw_version(hdev,
+			le16_to_cpu(udev->descriptor.idProduct));
 	}
 
 	drvdata->kbd_backlight = devm_kzalloc(&hdev->dev,
-- 
2.53.0

