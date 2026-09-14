Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0011A4279FE
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 22:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426406; cv=none; b=BFdbT+AhkJ43UHM58HE9FJa0dpB+NKQnwX5LZqIU4lZuxr325wdBNCt3mCGzQPmjGg/vNo0svmaE2BEhMtodzNVgbIsboOhnpawLdhWS5ltZsH+FRPEp8NM73AN2s0zcuv7fech/ZHesEMmH02I1fLswKUB7/d5J18CxZgkhlHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426406; c=relaxed/simple;
	bh=eyt+ppwhkUqrSgeJN9x9DLCKQamEARKPRcmwmhUJpd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqGN7yeVXXQcYWxrmd9//NQ8u2JG7enRsnrnLiJ1UAai1N/o97ZQ9yB7SYQDjzSjNELdsEnpSK/oHGbH/AAWBnh7Ij+xkSh8RlLOJy7PUNcwnUM6S8lUlbqt9v6C9JDX2r3gd1wdU7EnYGF8fpSFYcK/4Iz3TR5kVvureH4Fgi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLdj//LK; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLdj//LK"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b350c6920so2391674a91.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 15:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789426397; x=1790031197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=35j8vQkkYqsz76V+DGGdzZvbead1bZhTtdILBUHQZCY=;
        b=DLdj//LKcTKnXKIHAaV4WkjHyDyhd7rdVbWgjYcY7nf5sqxdJJhSLWkwz/o9a2NiOx
         /9wr8C6Q0OO/mxhhpn8Lic3RC0rZ5h9m0bIGyu/H8yf34lLxtI1J0gbimmNV4RbOXFBA
         eF2XHs1tod/mBQ/ZvjFk24XAiqCX+Kvp0e2vSoHPnPr9GtW8uMjsOWDPjs0uz4qH1u4e
         0AV5OWfVR3tAWqjL0g3Y+wXwGgXSUUqQBPs7W/DWWw0xu7iCS96y+XjZ/PO/qhHa1ml+
         xKulXVeIhWowTfU66GIkVeoQajvE/ThbeUYGPtK353n3ZlsnU7yky5I4J+37EfCx7fWd
         uIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789426397; x=1790031197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=35j8vQkkYqsz76V+DGGdzZvbead1bZhTtdILBUHQZCY=;
        b=vynb2mggOHDTjXryqpUqT7QsZcGPZGCd1fWT2P4R6ZJQwQa8lExoOAffckmuvS29cg
         YZf3kL8vrsTt+vJtXZqCyfBoSSTnXhWC+olkZQUilA1tM7T8f/RQc/SlwJu6YfMpY4H4
         Q0L2mHaq9YMTbwAi+rLkIoSzyxBMzQVL4y1wJLibTj1Xb7Qr6miPFjU902eKPW3tS66X
         L/hLfud+rVrL6+lt7IAIckd//QBhzDP9H4cl4mnk10SahZ5yKfGWyhF7woWztz42zpRj
         c2tIzVwDGWoO4DmSa1brGqHDmosLArn4m9T9DoebLV7pRRTmcLDiM8N/UWDKl5nlbTC3
         EkOA==
X-Forwarded-Encrypted: i=1; AKwUvByqW0hW3DS//5Ef26Tsk3AfiiRtYYQ9hPa9xoE4m1tTmTEnM597zDa9ZkXuagHXxPJ0bqwd/0Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lyo52VGVKccZy27JzKfEzyeS1mlAF3PLApWw0djHYB4in3PG9T
	oZv/NDSTDeJmgdfJqwRSxXrrkt3eKj+slvzJ/PNGQbC8G6pdxgA3W+GJ
X-Gm-Gg: AYBFou29ODevLT7+offf+MD+qmoU42oyb7n1C0zOcNb+AHJ3Ol5qX92cnGvTXZUx3so
	LAne8E8qcZ59kIIDQwj+aiHDW1+EunzAHF3zHS8edKjfPeTDvWhB0dfzqBJkIFBjdexYX+XXuYf
	miM8MfeJfC9/EnAGfaTspfeBmLXb4dYa7WoiLxCb/OiozG9nN1UcnIdAIsbhkIepr/t9NmkdIAc
	SoYb9OnYmzJsuWhjrrqYNs4vGSxNs9LW/goBl7aQQ4egA5tgUXJfIawesxNdG/fcSBXc2/H83dh
	9gilxTZEinuYIGOaBJYO7ksRYux+WmRvgFNH5DQHS9DH3ooHvvFkM+/MY/slUJIGcRcPoYlhsDO
	tBs/r+Q+co7LBuaZqWyAbupDAGmgMyww2dMAnt+eAKQXY+BF5uoKIf5NkP8VawCfiosBQzAtjiA
	aimjOpaxkHVdal/f84BWRteC1M0ZHyPNnxNIxH8XIGouxsCfzv3KeE2Ofd+Z27A2vBIsVNZZtRT
	/MgzEyDjjKqb8rJWtqWFvLgUY+XNtQSGTAMBAvxCxBG3WcDdtne3jTMamEcdSQ=
X-Received: by 2002:a17:90b:17c3:b0:39d:eda9:fac2 with SMTP id 98e67ed59e1d1-39dedaa0e10mr8126543a91.18.1789426397299;
        Mon, 14 Sep 2026 15:53:17 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bbeb053a5sm14924296eec.27.2026.09.14.15.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:53:16 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH 09/10] HID: hid-lenovo-go-s: Move static led_classdev_mc to drvdata struct
Date: Mon, 14 Sep 2026 15:53:02 -0700
Message-ID: <20260914225303.868569-10-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914225303.868569-1-derekjohn.clark@gmail.com>
References: <20260914225303.868569-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the next patch I will switch drvdata from static global to a
devm_kzalloc struct. In preparation for that, move the led_classdev_mc
to be a member of the gos_cfg_drvdata struct. As part of that effort,
provide a constant name when accessing it and access the led_classdev
through the led_classdev_mc.

Fixes: be6d7dbb368ba840d7 ("HID: hid-lenovo-go-s: Add RGB LED control interface")
Cc: stable@vger.kernel.org
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 73 +++++++++++++++++------------------
 1 file changed, 36 insertions(+), 37 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index e5c4104a3adb..c77c297a04cb 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -60,7 +60,7 @@ static struct gos_cfg_drvdata {
 	u8 tp_en;
 
 	/* RGB Variables */
-	struct led_classdev *led_cdev;
+	struct led_classdev_mc led_mc;
 	bool rgb_registered;
 	u8 rgb_profile;
 	u8 rgb_effect;
@@ -347,7 +347,7 @@ static int hid_gos_pl_test_event(struct command_report *cmd_rep)
 
 static int hid_gos_light_event(struct command_report *cmd_rep)
 {
-	struct led_classdev_mc *mc_cdev;
+	struct led_classdev_mc *led_mc;
 	int ret = 0;
 
 	switch (cmd_rep->sub_cmd) {
@@ -362,12 +362,12 @@ static int hid_gos_light_event(struct command_report *cmd_rep)
 	case USR_LIGHT_PROFILE_1:
 	case USR_LIGHT_PROFILE_2:
 	case USR_LIGHT_PROFILE_3:
-		mc_cdev = lcdev_to_mccdev(drvdata.led_cdev);
+		led_mc = &drvdata.led_mc;
 		drvdata.rgb_effect = cmd_rep->data[0];
-		mc_cdev->subled_info[0].intensity = cmd_rep->data[1];
-		mc_cdev->subled_info[1].intensity = cmd_rep->data[2];
-		mc_cdev->subled_info[2].intensity = cmd_rep->data[3];
-		drvdata.led_cdev->brightness = cmd_rep->data[4];
+		led_mc->subled_info[0].intensity = cmd_rep->data[1];
+		led_mc->subled_info[1].intensity = cmd_rep->data[2];
+		led_mc->subled_info[2].intensity = cmd_rep->data[3];
+		led_mc->led_cdev.brightness = cmd_rep->data[4];
 		drvdata.rgb_speed = cmd_rep->data[5];
 		ret = 0;
 		break;
@@ -927,7 +927,7 @@ static ssize_t rgb_effect_store(struct device *dev,
 				struct device_attribute *attr, const char *buf,
 				size_t count)
 {
-	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(drvdata.led_cdev);
+	struct led_classdev_mc *led_mc = &drvdata.led_mc;
 	enum rgb_config_index index;
 	bool rgb_registered;
 	u8 effect;
@@ -945,10 +945,10 @@ static ssize_t rgb_effect_store(struct device *dev,
 	effect = ret;
 	index = drvdata.rgb_profile + 2;
 	u8 rgb_profile[6] = { effect,
-			      mc_cdev->subled_info[0].intensity,
-			      mc_cdev->subled_info[1].intensity,
-			      mc_cdev->subled_info[2].intensity,
-			      drvdata.led_cdev->brightness,
+			      led_mc->subled_info[0].intensity,
+			      led_mc->subled_info[1].intensity,
+			      led_mc->subled_info[2].intensity,
+			      led_mc->led_cdev.brightness,
 			      drvdata.rgb_speed };
 
 	ret = rgb_cfg_call(drvdata.hdev, SET_RGB_CFG, index, rgb_profile, 6);
@@ -999,7 +999,7 @@ static ssize_t rgb_speed_store(struct device *dev,
 			       struct device_attribute *attr, const char *buf,
 			       size_t count)
 {
-	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(drvdata.led_cdev);
+	struct led_classdev_mc *led_mc = &drvdata.led_mc;
 	enum rgb_config_index index;
 	bool rgb_registered;
 	int val = 0;
@@ -1019,10 +1019,10 @@ static ssize_t rgb_speed_store(struct device *dev,
 
 	index = drvdata.rgb_profile + 2;
 	u8 rgb_profile[6] = { drvdata.rgb_effect,
-			      mc_cdev->subled_info[0].intensity,
-			      mc_cdev->subled_info[1].intensity,
-			      mc_cdev->subled_info[2].intensity,
-			      drvdata.led_cdev->brightness,
+			      led_mc->subled_info[0].intensity,
+			      led_mc->subled_info[1].intensity,
+			      led_mc->subled_info[2].intensity,
+			      led_mc->led_cdev.brightness,
 			      val };
 
 	ret = rgb_cfg_call(drvdata.hdev, SET_RGB_CFG, index, rgb_profile, 6);
@@ -1185,7 +1185,7 @@ static ssize_t rgb_profile_range_show(struct device *dev,
 static void hid_gos_brightness_set(struct led_classdev *led_cdev,
 				   enum led_brightness brightness)
 {
-	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(drvdata.led_cdev);
+	struct led_classdev_mc *led_mc = &drvdata.led_mc;
 	enum rgb_config_index index;
 	bool rgb_registered;
 	int ret;
@@ -1202,9 +1202,9 @@ static void hid_gos_brightness_set(struct led_classdev *led_cdev,
 
 	index = drvdata.rgb_profile + 2;
 	u8 rgb_profile[6] = { drvdata.rgb_effect,
-			      mc_cdev->subled_info[0].intensity,
-			      mc_cdev->subled_info[1].intensity,
-			      mc_cdev->subled_info[2].intensity,
+			      led_mc->subled_info[0].intensity,
+			      led_mc->subled_info[1].intensity,
+			      led_mc->subled_info[2].intensity,
 			      brightness,
 			      drvdata.rgb_speed };
 
@@ -1444,17 +1444,6 @@ static struct mc_subled gos_rgb_subled_info[] = {
 	},
 };
 
-static struct led_classdev_mc gos_cdev_rgb = {
-	.led_cdev = {
-		.name = "go_s:rgb:joystick_rings",
-		.brightness = 0x50,
-		.max_brightness = 0x64,
-		.brightness_set = hid_gos_brightness_set,
-	},
-	.num_colors = ARRAY_SIZE(gos_rgb_subled_info),
-	.subled_info = gos_rgb_subled_info,
-};
-
 static void cfg_setup(struct work_struct *work)
 {
 	bool gp_registered, rgb_registered;
@@ -1525,22 +1514,20 @@ static void cfg_setup(struct work_struct *work)
 	if (rgb_registered)
 		goto update_kobjects;
 
-	ret = devm_led_classdev_multicolor_register(&drvdata.hdev->dev, &gos_cdev_rgb);
+	ret = devm_led_classdev_multicolor_register(&drvdata.hdev->dev, &drvdata.led_mc);
 	if (ret) {
 		dev_err(&drvdata.hdev->dev,
 			"Failed to create RGB device: %i\n", ret);
 		goto update_kobjects;
 	}
 
-	ret = devm_device_add_group(gos_cdev_rgb.led_cdev.dev, &rgb_attr_group);
+	ret = devm_device_add_group(drvdata.led_mc.led_cdev.dev, &rgb_attr_group);
 	if (ret) {
 		dev_err(&drvdata.hdev->dev,
 			"Failed to create RGB configuration attributes: %i\n", ret);
 		goto update_kobjects;
 	}
 
-	drvdata.led_cdev = &gos_cdev_rgb.led_cdev;
-
 	/* Pairs with smp_load_acquire in attribute show/store functions */
 	smp_store_release(&drvdata.rgb_registered, true);
 	rgb_registered = true;
@@ -1549,7 +1536,7 @@ static void cfg_setup(struct work_struct *work)
 	if (gp_registered)
 		kobject_uevent(&drvdata.hdev->dev.kobj, KOBJ_CHANGE);
 	if (rgb_registered)
-		kobject_uevent(&drvdata.led_cdev->dev->kobj, KOBJ_CHANGE);
+		kobject_uevent(&drvdata.led_mc.led_cdev.dev->kobj, KOBJ_CHANGE);
 }
 
 static int hid_gos_cfg_probe(struct hid_device *hdev,
@@ -1563,6 +1550,18 @@ static int hid_gos_cfg_probe(struct hid_device *hdev,
 	mutex_init(&drvdata.cfg_mutex);
 	init_completion(&drvdata.send_cmd_complete);
 
+	/* Device is hardwired and name is guaranteed to be unique */
+	drvdata.led_mc.led_cdev.name = "go_s:rgb:joystick_rings";
+	drvdata.led_mc.led_cdev.brightness = 0x50;
+	drvdata.led_mc.led_cdev.max_brightness = 0x64;
+	drvdata.led_mc.led_cdev.color = LED_COLOR_ID_RGB;
+	drvdata.led_mc.led_cdev.brightness_set = hid_gos_brightness_set;
+	drvdata.led_mc.num_colors = 3;
+	drvdata.led_mc.subled_info = devm_kmemdup(&hdev->dev, gos_rgb_subled_info,
+						  sizeof(gos_rgb_subled_info), GFP_KERNEL);
+	if (!drvdata.led_mc.subled_info)
+		return -ENOMEM;
+
 	/* Executing calls prior to returning from probe will lock the MCU. Schedule
 	 * initial data call after probe has completed and MCU can accept calls.
 	 */
-- 
2.55.0

