Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F1442E407
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 22:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426401; cv=none; b=QfzLO2XZ2c5zJPvL5p/8lAHqfXqyOkms6XgiWyZkA7qgVZMimkeaYBpa8wVzj5V750NV991iCljPWSNJrYKW85Y0UMSiNiCtrFSX/MEE5zw2D6OTMYWFn7nxAD1Ju8iA50TfrAwEZwABOfr7Tg9+B3IvN41A8xCyhFtt3z/QWMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426401; c=relaxed/simple;
	bh=dVhByGe/R2Ltv+gLa/s9pmWMXmW9Mf4W3MMuoMAtBuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ermffG3L3M+FS5xJlj8xGoUDoBkNwNBb+5EMW2QRYkfEv0nAs2gs38YDrfT2ITxkCw5aJar4K8ICfVGru0fSxF2EOS35Kj0CmifEGfx8fW/1HekFm4pfaVtIfWY0ilRQLa64jL7d+s4eT9T2froDVDGZ5NURloJ3l7pWOz0t4ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flKwQxKw; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flKwQxKw"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccafb751so2623494a91.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 15:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789426394; x=1790031194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x4I3Z8i7r4FjC6E4wBF2wiO14cWOcQrrX+u+7iuw0Ek=;
        b=flKwQxKwyR9j6vwU7hdegZGYqmXgdHvAnVQIzioAbiq2doeQJuhOmq9nW4lvUXqpAX
         hxgGBO/WnTvTPmrbF/+wUubEf+0PfO2b2gSe3XwtMfCBS66V07krkJiG/OvJf2KX3PcH
         /yMHqYd/mtphxDmeZxEfXLfCNYBpnqI3OMHpaNlIUEhAltqzC6QsviMcOVhxY4wf67ev
         Uqv02UNP8MC9pLHbV41qY9NeGgZbXGnooEBsdtySWJYrQhxgbhOzEnoF7ptOEwwSliYG
         +5FuColNousJhPVj6Q5j4vLf6C99urO3QxkrBfvAFXjonL2AB6tU8gFeQAJVpqv2jM4x
         sJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789426394; x=1790031194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x4I3Z8i7r4FjC6E4wBF2wiO14cWOcQrrX+u+7iuw0Ek=;
        b=ziW4aAtF9OSiY7rXf8Hlyzmd7X7CqrOnU8YTsttrH92+Xt0XgNCfwa48OlEUX90nCL
         Nj9EjbwOwspY7IB1k7Ezb7auLWCtw1KR5q3lbavWypfieBdfGawsypmyg2gTbw12cKIW
         qXcJ36s+YgQ4ncoNLKlFXtjjN20EoADgs6gdmgoDnJa/wu630HmrWIkBN4v9/zrb3xqs
         y69ni6zCnrZW7eIgJBBKy4UTLoZuY7EUmZ84r6hRivY0sSLX2hjjz0EDHHSMksXl5V4r
         9KfGcBWul7p+J7oMpCuzr3fHkbdi/8RlYEblpzeFAnGvb//ZtQm7QEDi2vkXmyROWZtE
         y+kQ==
X-Forwarded-Encrypted: i=1; AKwUvBw3v0A/DIWEOsKqXzl1fZNhftODZUkprwiBNSJNnbSy1LSRn164kPdnOz3kZevE7kSWzrslEQQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lkVFZgU0gar8WUlg4qWe8lv/0osz2xIJythZ0BBnISstCghJgo
	CldNv0QFd1+2pYmcUU7xzu2Hjjp0neIek0uAJHrMU8q8ZbFCGTaAB0fJ
X-Gm-Gg: AYBFou0eWSPowwF3DcUM97CGvYDRV73LxCOQmcRTXPrBSmcPATPotCDYQFgY4vrpzUF
	igWk0JWhoUz+PbszgKiBSOJwVZymsQrj7tZ32SQc2UKvAxzEYoelK2fSZGdeT5EAPkh6frGuYTM
	fISoZg2ngY81o4sDykRY1VCm6e+P3Vq3OCOeq93WGVlLfa6eTRM6PQO3Az3fF18u1Maq7ys1Zsd
	vs1+x2omJsOJ4egiv5XyL2D4f3QuiFIsD+ck5fOxQ2qwUP1CXwcPQv6r7FUeFtnVhfDXJYSBs7W
	2HdyjwJ9b8ctRr6h++sFOqAmQXNgZ0cgx4oTjvaNpWXlFU6oJRATCTbiImq2lYxjxjnlWHsQ3VQ
	MKr2GnmNVAJ4dkmtyAW8aCYzwIh29dQiYVz2I0ZxrC2m+wOlmW52Y88iUPPxcMsRVX6D/tOiSBI
	69RQIkgTNuCD/81rPs9uW6TI4iVJ6NfXdOi6vU2QAUoa6qy+aPM2MSxMLon6Zov8OjJWuRhHJgn
	ts8T6LPJYYCRYU0aHn1hVueUWY7CJIwhEg+yEJzlP2drpYbl0JS
X-Received: by 2002:a17:90b:57cb:b0:39d:f130:f8fd with SMTP id 98e67ed59e1d1-39df13108cdmr8639486a91.11.1789426394397;
        Mon, 14 Sep 2026 15:53:14 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bbeb053a5sm14924296eec.27.2026.09.14.15.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:53:13 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH 06/10] HID: hid-lenovo-go-s: Add suspend function and gate access under bool.
Date: Mon, 14 Sep 2026 15:52:59 -0700
Message-ID: <20260914225303.868569-7-derekjohn.clark@gmail.com>
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

Currently a device can suspend while delayed work is pending or
executing. Cancel delayed work if it was pending and restart it if it
hasn't run yet. Gate access to show/store functions behind a bool to
prevent access prior to cfg_setup() being completed.

Fixes: a23f3497bf208c59ad ("HID: hid-lenovo-go-s: Add Lenovo Legion Go S Series HID Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 149 ++++++++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index 712823e22bea..6d98fff6d987 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -39,6 +39,8 @@ static struct hid_gos_cfg {
 	struct hid_device *hdev;
 	bool orphan_ack_pending;
 	struct mutex cfg_mutex; /*ensure single synchronous output report*/
+	bool gp_registered;
+	bool rgb_registered;
 	int cmd_status;
 	u8 gp_auto_sleep_time;
 	u8 gp_dpad_mode;
@@ -504,10 +506,22 @@ static ssize_t gamepad_property_store(struct device *dev,
 				      const char *buf, size_t count,
 				      enum feature_status_index index)
 {
+	bool dev_registered;
 	size_t size = 1;
 	u8 val = 0;
 	int ret;
 
+	/* rgb_enabled is attached to led_classdev, not hid_device */
+	if (index == FEATURE_RGB_ENABLE)
+		/* Pairs with smp_store_release from gos_cfg_setup */
+		dev_registered = smp_load_acquire(&drvdata.rgb_registered);
+	else
+		/* Pairs with smp_store_release from gos_cfg_setup */
+		dev_registered = smp_load_acquire(&drvdata.gp_registered);
+
+	if (!dev_registered)
+		return -ENODEV;
+
 	switch (index) {
 	case FEATURE_GAMEPAD_MODE:
 		ret = sysfs_match_string(gamepad_mode_text, buf);
@@ -588,9 +602,21 @@ static ssize_t gamepad_property_show(struct device *dev,
 				     struct device_attribute *attr, char *buf,
 				     enum feature_status_index index)
 {
+	bool dev_registered;
 	ssize_t count = 0;
 	u8 i;
 
+	/* rgb_enabled is attached to led_classdev, not hid_device */
+	if (index == FEATURE_RGB_ENABLE)
+		/* Pairs with smp_store_release from gos_cfg_setup */
+		dev_registered = smp_load_acquire(&drvdata.rgb_registered);
+	else
+		/* Pairs with smp_store_release from gos_cfg_setup */
+		dev_registered = smp_load_acquire(&drvdata.gp_registered);
+
+	if (!dev_registered)
+		return -ENODEV;
+
 	count = mcu_property_out(drvdata.hdev, GET_GAMEPAD_CFG, index, NULL, 0);
 	if (count < 0)
 		return count;
@@ -726,10 +752,16 @@ static ssize_t touchpad_property_store(struct device *dev,
 				       const char *buf, size_t count,
 				       enum touchpad_config_index index)
 {
+	bool gp_registered;
 	size_t size = 1;
 	u8 val = 0;
 	int ret;
 
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	gp_registered = smp_load_acquire(&drvdata.gp_registered);
+	if (!gp_registered)
+		return -ENODEV;
+
 	switch (index) {
 	case CFG_WINDOWS_MODE:
 		ret = sysfs_match_string(touchpad_mode_text, buf);
@@ -760,9 +792,15 @@ static ssize_t touchpad_property_show(struct device *dev,
 				      struct device_attribute *attr, char *buf,
 				      enum touchpad_config_index index)
 {
+	bool gp_registered;
 	int ret = 0;
 	u8 i;
 
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	gp_registered = smp_load_acquire(&drvdata.gp_registered);
+	if (!gp_registered)
+		return -ENODEV;
+
 	ret = mcu_property_out(drvdata.hdev, GET_TP_PARAM, index, NULL, 0);
 	if (ret < 0)
 		return ret;
@@ -789,9 +827,15 @@ static ssize_t touchpad_property_options(struct device *dev,
 					 char *buf,
 					 enum touchpad_config_index index)
 {
+	bool gp_registered;
 	size_t count = 0;
 	unsigned int i;
 
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	gp_registered = smp_load_acquire(&drvdata.gp_registered);
+	if (!gp_registered)
+		return -ENODEV;
+
 	switch (index) {
 	case CFG_WINDOWS_MODE:
 	case CFG_LINUX_MODE:
@@ -814,9 +858,15 @@ static ssize_t test_property_show(struct device *dev,
 				  struct device_attribute *attr, char *buf,
 				  enum test_command_index index)
 {
+	bool gp_registered;
 	size_t count = 0;
 	u8 i;
 
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	gp_registered = smp_load_acquire(&drvdata.gp_registered);
+	if (!gp_registered)
+		return -ENODEV;
+
 	switch (index) {
 	case TEST_TP_MFR:
 		i = drvdata.tp_manufacturer;
@@ -874,9 +924,15 @@ static ssize_t rgb_effect_store(struct device *dev,
 {
 	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(drvdata.led_cdev);
 	enum rgb_config_index index;
+	bool rgb_registered;
 	u8 effect;
 	int ret;
 
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	rgb_registered = smp_load_acquire(&drvdata.rgb_registered);
+	if (!rgb_registered)
+		return -ENODEV;
+
 	ret = sysfs_match_string(rgb_effect_text, buf);
 	if (ret < 0)
 		return ret;
@@ -901,8 +957,14 @@ static ssize_t rgb_effect_store(struct device *dev,
 static ssize_t rgb_effect_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
+	bool rgb_registered;
 	int ret;
 
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	rgb_registered = smp_load_acquire(&drvdata.rgb_registered);
+	if (!rgb_registered)
+		return -ENODEV;
+
 	ret = rgb_attr_show();
 	if (ret)
 		return ret;
@@ -934,9 +996,15 @@ static ssize_t rgb_speed_store(struct device *dev,
 {
 	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(drvdata.led_cdev);
 	enum rgb_config_index index;
+	bool rgb_registered;
 	int val = 0;
 	int ret;
 
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	rgb_registered = smp_load_acquire(&drvdata.rgb_registered);
+	if (!rgb_registered)
+		return -ENODEV;
+
 	ret = kstrtoint(buf, 10, &val);
 	if (ret)
 		return ret;
@@ -964,8 +1032,14 @@ static ssize_t rgb_speed_store(struct device *dev,
 static ssize_t rgb_speed_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
+	bool rgb_registered;
 	int ret;
 
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	rgb_registered = smp_load_acquire(&drvdata.rgb_registered);
+	if (!rgb_registered)
+		return -ENODEV;
+
 	ret = rgb_attr_show();
 	if (ret)
 		return ret;
@@ -985,9 +1059,15 @@ static ssize_t rgb_speed_range_show(struct device *dev,
 static ssize_t rgb_mode_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
+	bool rgb_registered;
 	int ret;
 	u8 val;
 
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	rgb_registered = smp_load_acquire(&drvdata.rgb_registered);
+	if (!rgb_registered)
+		return -ENODEV;
+
 	ret = sysfs_match_string(rgb_mode_text, buf);
 	if (ret <= 0)
 		return ret;
@@ -1007,8 +1087,14 @@ static ssize_t rgb_mode_store(struct device *dev, struct device_attribute *attr,
 static ssize_t rgb_mode_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
+	bool rgb_registered;
 	int ret;
 
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	rgb_registered = smp_load_acquire(&drvdata.rgb_registered);
+	if (!rgb_registered)
+		return -ENODEV;
+
 	ret = rgb_cfg_call(drvdata.hdev, GET_RGB_CFG, LIGHT_MODE_SEL, NULL, 0);
 	if (ret)
 		return ret;
@@ -1038,10 +1124,16 @@ static ssize_t rgb_profile_store(struct device *dev,
 				 struct device_attribute *attr, const char *buf,
 				 size_t count)
 {
+	bool rgb_registered;
 	size_t size = 1;
 	int ret;
 	u8 val;
 
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	rgb_registered = smp_load_acquire(&drvdata.rgb_registered);
+	if (!rgb_registered)
+		return -ENODEV;
+
 	ret = kstrtou8(buf, 10, &val);
 	if (ret < 0)
 		return ret;
@@ -1061,8 +1153,14 @@ static ssize_t rgb_profile_store(struct device *dev,
 static ssize_t rgb_profile_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
+	bool rgb_registered;
 	int ret;
 
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	rgb_registered = smp_load_acquire(&drvdata.rgb_registered);
+	if (!rgb_registered)
+		return -ENODEV;
+
 	ret = rgb_cfg_call(drvdata.hdev, GET_RGB_CFG, LIGHT_PROFILE_SEL, NULL, 0);
 	if (ret)
 		return ret;
@@ -1084,8 +1182,14 @@ static void hid_gos_brightness_set(struct led_classdev *led_cdev,
 {
 	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(drvdata.led_cdev);
 	enum rgb_config_index index;
+	bool rgb_registered;
 	int ret;
 
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	rgb_registered = smp_load_acquire(&drvdata.rgb_registered);
+	if (!rgb_registered)
+		return;
+
 	if (brightness > led_cdev->max_brightness) {
 		dev_err(led_cdev->dev, "Invalid argument\n");
 		return;
@@ -1392,6 +1496,11 @@ static void cfg_setup(struct work_struct *work)
 			"Failed to retrieve OS Mode: %i\n", ret);
 		return;
 	}
+
+	/* Pairs with smp_load_acquire in attribute show/store functions */
+	smp_store_release(&drvdata.gp_registered, true);
+	/* Pairs with smp_load_acquire in attribute show/store functions */
+	smp_store_release(&drvdata.rgb_registered, true);
 }
 
 static int hid_gos_cfg_probe(struct hid_device *hdev,
@@ -1451,9 +1560,24 @@ static void hid_gos_cfg_remove(struct hid_device *hdev)
 
 static int hid_gos_cfg_reset_resume(struct hid_device *hdev)
 {
+	bool gp_registered, rgb_registered;
 	u8 os_mode = drvdata.os_mode;
 	int ret;
 
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	gp_registered = smp_load_acquire(&drvdata.gp_registered);
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	rgb_registered = smp_load_acquire(&drvdata.rgb_registered);
+	if (!gp_registered || !rgb_registered) {
+		ret = schedule_delayed_work(&drvdata.gos_cfg_setup, msecs_to_jiffies(2));
+		if (!ret) {
+			dev_err(&hdev->dev, "Failed to schedule startup delayed work\n");
+			return -ENODEV;
+		}
+
+		return 0;
+	}
+
 	ret = mcu_property_out(drvdata.hdev, SET_GAMEPAD_CFG,
 			       FEATURE_OS_MODE, &os_mode, 1);
 	if (ret < 0)
@@ -1542,6 +1666,30 @@ static int hid_gos_reset_resume(struct hid_device *hdev)
 	return 0;
 }
 
+static int hid_gos_cfg_suspend(void)
+{
+	disable_delayed_work_sync(&drvdata.gos_cfg_setup);
+
+	return 0;
+}
+
+static int hid_gos_suspend(struct hid_device *hdev, pm_message_t msg)
+{
+	int ret;
+	u8 ep;
+
+	/* Safe assumption. SET_INTERFACE ioctl can't be used while driver is bound */
+	ret = get_endpoint_address(hdev);
+	if (ret <= 0)
+		return 0;
+
+	ep = ret;
+	if (ep == GO_S_CFG_INTF_IN)
+		return hid_gos_cfg_suspend();
+
+	return 0;
+}
+
 static const struct hid_device_id hid_gos_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_QHE,
 			 USB_DEVICE_ID_LENOVO_LEGION_GO_S_XINPUT) },
@@ -1558,6 +1706,7 @@ static struct hid_driver hid_lenovo_go_s = {
 	.remove = hid_gos_remove,
 	.raw_event = hid_gos_raw_event,
 	.reset_resume = pm_ptr(hid_gos_reset_resume),
+	.suspend = pm_ptr(hid_gos_suspend),
 };
 module_hid_driver(hid_lenovo_go_s);
 
-- 
2.55.0

