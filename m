Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2B03EC803
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787752025; cv=none; b=Erw1nUVvYhxfmb1ou8pq52fa2jd8z8dIAOirdgMMMAWlo9REwQ88zgOrjvj8RZyRUYk/KqfIyUCLwyonz2YnnUSas+7D62x/oIURbfvLMXcwdmstcob9W5QPKGZPzsRQlEAKLc4JDj6qp/7JsdXTcXN7JAyxXzxg6U2xfKm4sDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787752025; c=relaxed/simple;
	bh=B6VwNBWiTuntjuDWYReoSqZP+B08PSlKElK9MuJiX4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWrJh4zDJ3kXAVnbeoALjNLUQQ3wrYaYB//iYRvjznC6X/gLyHZoE0SZLyGZd62AWF18qpJHZbw0nBNN90igLxujdL5bt1Ae80n9U2M0Nvc8Uk9PH6l5nEQI0EMGfQGD7H5fwb+hzgKS4oBfN3Kg/znVOA3/9lico+3Iof92YAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARwXuMeQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARwXuMeQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8A51F000E9;
	Wed, 26 Aug 2026 13:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787752020;
	bh=9Yqq/LquNSE2Z8ZstUXlm6FLvjSJicvahIJ9x3dB6yY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ARwXuMeQF76M9IXB2G8r/jZz5xBvBpQtvnD9MnBFtWN6Y+iTb62Gjl2p6kjrbZIVi
	 m/zdI5Puw4KXGbu01Oj9Rf1HjDjTnSRvGsqm8ngnNT8gFTf7ApLPEHHxbTQLEsjpWh
	 xm0ciEMp1gyWsBFdg5//7W1zOTKyVKXLATnffWaCK9Q+WitS7WwPT07mAqUz8iTIZX
	 J6w296KXFf1bervLAQkILHGWo6t7hSQS+AEQxNbUtXCfnp5MrD45FwWxaClcPh4WAM
	 8EYJrlP1M4BPFxcAY3p/gmV15+e3Lo4HnCy3X23TZJyGy2KpnMb/lPAar2GNN/EiAD
	 lZpU8n6tS8fUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Antheas Kapenekakis <lkml@antheas.dev>,
	Benjamin Tissoires <bentiss@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] HID: asus: simplify RGB init sequence
Date: Wed, 26 Aug 2026 09:46:55 -0400
Message-ID: <20260826134657.3953358-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082550-stinging-mushily-fa27@gregkh>
References: <2026082550-stinging-mushily-fa27@gregkh>
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
index 1746e8ea50ddf..e1ae518bfb217 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -638,13 +638,20 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
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
@@ -652,34 +659,19 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
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

