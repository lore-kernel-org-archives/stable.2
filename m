Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E69A387364
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 01:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201220; cv=none; b=ap+JZon6/qTPjyayaZRLIC/EsFYziks0/5VMwYfCbrIpo4cGGtWyG5QaCWRzx90nVhUPLXNdwI9lKK6B/3YpL+xzebcDFQ16EsYnU0E3Jv/SjUMyGmeAxjatZw+eCY8GFlE4/t76HJuNeEPTONz6RWQdtoM+aSa3eDWgCWeJrxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201220; c=relaxed/simple;
	bh=dKpCuDcIaAlFeaJIq+wf4HiiDBn18O4xZ8TfrUaGjXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pzr/BjRMs4E4UNsQtRWdbkb2nplrqWgVbM61URftt5Vm7bbPe7jLuobPL6yrz68YB9slFUn0x7GGVQdkz/0w9wn2CYKtu5rcu9p6f/Avc4gP/WHOLXSJd8GumAi6iPTo6UGzzxY2p4x2gcOSeA5RbrYqWUoCVu1WMFB41aBd+8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJjV7b3R; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJjV7b3R"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso23856eec.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 18:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792201214; x=1792806014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kVLlyzwOJqlF1TKXGrKuWzHy+TQSA/0kGnM9v3Xwg88=;
        b=LJjV7b3RCNPi/Zfxw7ErmTJkXALgirgr/ZhtepSpWjLiBtbyZGxxH4vZcuxSWe0mZw
         EbEy9l+ocieKxk8iv0DwWBG55OmamfnFGjc505duUl8PQxX47o+LwWkMVfijDP/3wIRC
         nHK4f8PFxSECFSPWJXJVdbx88mW+KK1X37KCvzD5xyzysZYIYGu7lkxsMmHdLPiegBR3
         STcIbtYhvFfrRjaFvWEdL4P2FFa7RBQTb36lw2Ax11ipOzMJ33TT0opvJnKi9SrhWf0j
         TbF8JCbYcqvzikp5DDuxcnTRMKauRvDCcnCgRtdsErG8xQpdZkYiGZnNVg0Mn3ojcMmT
         KNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792201214; x=1792806014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kVLlyzwOJqlF1TKXGrKuWzHy+TQSA/0kGnM9v3Xwg88=;
        b=HpdcVkivTY5XCIsBskXUwCuJz3ZVz63yBbibqXNADWAG8IX5OwG84KiI+w5hMXT1X/
         mhiX8GlHj1lj+ZJbRN4Vs2v7HXD97ZntWubRpsKY/UJGjF7Enz7KhYSqKBF4zyjSYW/W
         uM4YMDdKhbEoEruwctR+XixHy5zQoZ+QTJc1YRfuSdEpjql2nRl5Oke0HE9CHPF/ZW5h
         EX/svpugcbjkbeGOl4RsJSqpcOCHmkhhisLq/D8+hUa+9Nun9ixcnLc82KAC2NOdEhiM
         VdL3afPTlPmVgg6KPJPCGmgCrHnyYg4zhGdmcHeGYYhLlnLMMBE84IW1YN7tNiHVokmQ
         M3lQ==
X-Forwarded-Encrypted: i=1; AKwUvBzjkteQDxQKArC5+9yWJAbD49nEEciMS4fbQ8qX+GfR7J4LeIdO5Nj7FPH8fQJmxYhmFbZgJ4A=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKh7LEFyyaENMg8R6xOPpM49I7pkUu9zAfcjTjhAkXX7DvzwPk
	ihCRvU+o+AYLYxhDqPYSwoxilY5cvwCf/v3dxA1r//NR9GAjyq4505H8
X-Gm-Gg: AYBFou3OQHA7Sj3wVPieAR22dDiBibxOYgYY6woqGxwi2EEG147HeOsUAfu4G575tY5
	XChjjYApnAiZaMO/9rpJ0oNYWqu+p3Ve9DA18yC3I9UC/5hOTeBb519x7rw9zLwcZ9ez4cf3Ylu
	8lAiBmR1TQ4t9bb/BPYMEHV64PnbRlGU9DRO1C7Ref44VjCaf4CMAIIWwWYN8VBdHx7k0X6fle+
	qiawbdgjJnfgQsE7NTRIZldHwJDH82qwQRtXe8W6aGGyz9ngqet+YVYjGr5+vXjYIywEN9Hgsqx
	IoxsKG5RO4TJMvvqi0yJoi92dS9bnYjpclPSNFUlY0g9kswE8gDN+MdoqbjC45bTBXTg6gUjiv3
	DvHyszC0RTPlNmNKgTRoqOQ0lh2Gjh8+2T1HXldpnEAiwxPw4hVspYguFK0u7k2BJBvMc6HHmg/
	k5o+imbz1Dj8uncIw0A6GM7305AfWx8g8mrOQjFCyVucGsX2C82Sk5MzI/oWcTNVaNeqREQfz8C
	PdqihfLs/G7OgmKuPdeifrUfI216I6MsjdOWjXMRziqb2pfc2scFRzrzwkyCypU45nAaXHgk3U=
X-Received: by 2002:a05:7022:170a:b0:180:2b3d:57b4 with SMTP id a92af1059eb24-18513b97e53mr1922190c88.33.1792201213482;
        Fri, 16 Oct 2026 18:40:13 -0700 (PDT)
Received: from lappy.taila8a9bd.ts.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831acba710sm12128429c88.13.2026.10.16.18.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:40:13 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH v2 07/11] HID: hid-lenovo-go-s: Move attribute init to after device query
Date: Fri, 16 Oct 2026 18:39:52 -0700
Message-ID: <20261017013956.2440130-8-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
References: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently this driver registers attributes before the MCU is ready to
accept commands. This can lead to attribute access that blocks the MCU
in some rare cases.

Move attribute construction to gos_cfg_setup, after the device has been
queried. Gate creation to drvdata.gp_registered and
drvdata.rgb_registered so a resume before setup has run doesn't prevent
attribute creation or attempt to re-register the same attributes.

Query failures reschedule the setup work, up to 5 attempts 50 ms apart,
since the MCU may not be ready to accept commands immediately after
probe.

The registered flags are set before the matching registration steps and
cleared on failure, so a failed run leaves no state that blocks a later
run from retrying. The LED classdev is registered without devres because
the failure and remove paths unregister it manually.

Fixes: a23f3497bf208c59ad ("HID: hid-lenovo-go-s: Add Lenovo Legion Go S Series HID Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 134 ++++++++++++++++++++++++----------
 1 file changed, 95 insertions(+), 39 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index 14aeddd65704..cefb243800b6 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -42,6 +42,7 @@ static struct hid_gos_cfg {
 	bool gp_registered;
 	bool rgb_registered;
 	int cmd_status;
+	int setup_attempts;
 	u8 gp_auto_sleep_time;
 	u8 gp_dpad_mode;
 	u8 gp_mode;
@@ -1453,57 +1454,127 @@ static struct led_classdev_mc gos_cdev_rgb = {
 	.subled_info = gos_rgb_subled_info,
 };
 
-static void cfg_setup(struct work_struct *work)
+static int cfg_query_device(void)
 {
 	int ret;
 
 	/* MCU */
 	ret = mcu_property_out(drvdata.hdev, GET_MCU_ID, FEATURE_NONE, NULL, 0);
 	if (ret) {
-		dev_err(&drvdata.hdev->dev, "Failed to retrieve MCU ID: %i\n",
-			ret);
-		return;
+		dev_err(&drvdata.hdev->dev, "Failed to retrieve MCU ID: %i\n", ret);
+		return ret;
 	}
 
 	ret = mcu_property_out(drvdata.hdev, GET_VERSION, FEATURE_NONE, NULL, 0);
 	if (ret) {
 		dev_err(&drvdata.hdev->dev, "Failed to retrieve MCU Version: %i\n", ret);
-		return;
+		return ret;
 	}
 
 	ret = mcu_property_out(drvdata.hdev, GET_PL_TEST, TEST_TP_MFR, NULL, 0);
 	if (ret) {
 		dev_err(&drvdata.hdev->dev,
 			"Failed to retrieve Touchpad Manufacturer: %i\n", ret);
-		return;
+		return ret;
 	}
 
 	ret = mcu_property_out(drvdata.hdev, GET_PL_TEST, TEST_TP_VER, NULL, 0);
 	if (ret) {
 		dev_err(&drvdata.hdev->dev,
 			"Failed to retrieve Touchpad Firmware Version: %i\n", ret);
-		return;
+		return ret;
 	}
 
 	ret = mcu_property_out(drvdata.hdev, GET_PL_TEST, TEST_IMU_MFR, NULL, 0);
 	if (ret) {
 		dev_err(&drvdata.hdev->dev,
 			"Failed to retrieve IMU Manufacturer: %i\n", ret);
-		return;
+		return ret;
 	}
 
-	ret = mcu_property_out(drvdata.hdev, GET_GAMEPAD_CFG, FEATURE_OS_MODE,
-			       NULL, 0);
+	return mcu_property_out(drvdata.hdev, GET_GAMEPAD_CFG, FEATURE_OS_MODE,
+				 NULL, 0);
+}
+
+static void cfg_setup(struct work_struct *work)
+{
+	bool gp_registered = false;
+	bool rgb_registered = false;
+	int ret;
+
+	ret = cfg_query_device();
 	if (ret) {
-		dev_err(&drvdata.hdev->dev,
-			"Failed to retrieve OS Mode: %i\n", ret);
+		/* The MCU may not be ready yet. Retry a bounded number of
+		 * times before giving up.
+		 */
+		drvdata.setup_attempts++;
+		if (drvdata.setup_attempts >= 5) {
+			dev_err(&drvdata.hdev->dev,
+				"Giving up on device setup after %d attempts\n",
+				drvdata.setup_attempts);
+			return;
+		}
+
+		schedule_delayed_work(&drvdata.gos_cfg_setup, msecs_to_jiffies(50));
 		return;
 	}
 
-	/* Pairs with smp_load_acquire in attribute show/store functions */
-	smp_store_release(&drvdata.gp_registered, true);
-	/* Pairs with smp_load_acquire in attribute show/store functions */
-	smp_store_release(&drvdata.rgb_registered, true);
+	drvdata.setup_attempts = 0;
+
+	if (!drvdata.gp_registered) {
+		/* Pairs with smp_load_acquire in attribute show/store functions */
+		smp_store_release(&drvdata.gp_registered, true);
+		gp_registered = true;
+
+		ret = sysfs_create_groups(&drvdata.hdev->dev.kobj, top_level_attr_groups);
+		if (ret) {
+			dev_err(&drvdata.hdev->dev,
+				"Failed to create gamepad configuration attributes: %i\n",
+				ret);
+
+			/* Pairs with smp_load_acquire in attribute show/store functions */
+			smp_store_release(&drvdata.gp_registered, false);
+			gp_registered = false;
+		}
+	}
+
+	if (!drvdata.rgb_registered) {
+		drvdata.led_cdev = &gos_cdev_rgb.led_cdev;
+
+		/* Pairs with smp_load_acquire in attribute show/store functions */
+		smp_store_release(&drvdata.rgb_registered, true);
+		rgb_registered = true;
+
+		ret = led_classdev_multicolor_register(&drvdata.hdev->dev,
+						       &gos_cdev_rgb);
+		if (ret) {
+			dev_err(&drvdata.hdev->dev, "Failed to create RGB device: %i\n",
+				ret);
+
+			/* Pairs with smp_load_acquire in attribute show/store functions */
+			smp_store_release(&drvdata.rgb_registered, false);
+			rgb_registered = false;
+		} else {
+			ret = devm_device_add_group(gos_cdev_rgb.led_cdev.dev,
+						    &rgb_attr_group);
+			if (ret) {
+				dev_err(&drvdata.hdev->dev,
+					"Failed to create RGB configuration attributes: %i\n",
+					ret);
+
+				led_classdev_multicolor_unregister(&gos_cdev_rgb);
+
+				/* Pairs with smp_load_acquire in attribute show/store functions */
+				smp_store_release(&drvdata.rgb_registered, false);
+				rgb_registered = false;
+			}
+		}
+	}
+
+	if (gp_registered)
+		kobject_uevent(&drvdata.hdev->dev.kobj, KOBJ_CHANGE);
+	if (rgb_registered)
+		kobject_uevent(&drvdata.led_cdev->dev->kobj, KOBJ_CHANGE);
 }
 
 static int hid_gos_cfg_probe(struct hid_device *hdev,
@@ -1513,30 +1584,8 @@ static int hid_gos_cfg_probe(struct hid_device *hdev,
 
 	hid_set_drvdata(hdev, &drvdata);
 	drvdata.hdev = hdev;
-	mutex_init(&drvdata.cfg_mutex);
-
-	ret = sysfs_create_groups(&hdev->dev.kobj, top_level_attr_groups);
-	if (ret) {
-		dev_err_probe(&hdev->dev, ret,
-			      "Failed to create gamepad configuration attributes\n");
-		return ret;
-	}
-
-	ret = devm_led_classdev_multicolor_register(&hdev->dev, &gos_cdev_rgb);
-	if (ret) {
-		dev_err_probe(&hdev->dev, ret, "Failed to create RGB device\n");
-		return ret;
-	}
-
-	ret = devm_device_add_group(gos_cdev_rgb.led_cdev.dev, &rgb_attr_group);
-	if (ret) {
-		dev_err_probe(&hdev->dev, ret,
-			      "Failed to create RGB configuration attributes\n");
-		return ret;
-	}
-
-	drvdata.led_cdev = &gos_cdev_rgb.led_cdev;
 
+	mutex_init(&drvdata.cfg_mutex);
 	init_completion(&drvdata.send_cmd_complete);
 
 	/* Executing calls prior to returning from probe will lock the MCU. Schedule
@@ -1554,9 +1603,16 @@ static int hid_gos_cfg_probe(struct hid_device *hdev,
 
 static void hid_gos_cfg_remove(struct hid_device *hdev)
 {
+	bool rgb_registered;
+
 	disable_delayed_work_sync(&drvdata.gos_cfg_setup);
 	sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);
 
+	/* Pairs with smp_store_release in cfg_setup */
+	rgb_registered = smp_load_acquire(&drvdata.rgb_registered);
+	if (rgb_registered)
+		led_classdev_multicolor_unregister(&gos_cdev_rgb);
+
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 	hid_set_drvdata(hdev, NULL);
-- 
2.55.0

