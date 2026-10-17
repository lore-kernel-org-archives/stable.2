Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55FD387361
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 01:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201221; cv=none; b=QRI2dHJRB6he6w+49Pw/VWS/2rE2e3uAlU9pWqIp8xgWvkNefMLcXgYC3adPAiLBZyDx07M4w3jMYkjrHwW6/xppFTWvgLg+AYXaOWFCJpL/BXOrJ9k3kKmua1KyQKoI7OhKaoo8MF2lZJtrPGeVzvv+8+IPQucVFUbjlfI67ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201221; c=relaxed/simple;
	bh=/mcewCeUjWmAseZYcNAB7LIG8r7YUnb8LC0dffTCf5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UeIKtdjILpIktkYG5Z5CbCV0/ZpVWQUpJ9JTWSy6DSivp/jk9YMXFrNgU+LyeLuVaNiUealv5wZUWT/JF7ZU73SxC9BQW3U0UcOh9SP9lQ2oYQwJJeqOsZVf7JwI+FJ1d19PKvZ8LYrqFWKh73spkKGZucUSSlSPC9s4fg6ZBaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRhZy978; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRhZy978"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-16079d54c17so1016505c88.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 18:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792201213; x=1792806013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qzvFYWoc6btM97vjxfEHHvXbZfRdbjVX+vN3On9hAMg=;
        b=BRhZy978xF/qPpVMCJ9RKvB0tafuq/ApJ/06CWcbaMflQdyYp4bj/kCu4BjScHAwW6
         WlPAjKIsNcewgZUFkXEtW95dOVypmmb1gFUs/tfBkGDdJDLBeOisytop+SDHPsIUzGcP
         18jYNu+jHQzmt+CZWKE3p/s+1dHe15JdIPxQJ1+/xkDS7XipSBlutOnGyeX/oTdp8GbA
         VrD3Or5wyNKKTjzy2xjAULwqJpuSe0L7z/S5EtAXjtKGrbEHo2Lnji35/EriJmx46THB
         JfLKSf8QdXCuOfPWnuR3/eRVcZbIxMKeQNEcd48MFQMY3Gr6OGR5v7rpNZZJJmu6VKkx
         edaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792201213; x=1792806013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qzvFYWoc6btM97vjxfEHHvXbZfRdbjVX+vN3On9hAMg=;
        b=NcmahzJn9XDwBm7wffZm8748LMYysT04VH0oZ7mK+jNt4w+0l+sFgswFuRFzgFSC0F
         IQHnJ3KuYp2lXO5SNvaIhSbAoSzihPlxJ4e0VIrd+0/+3i6dIOOz6FlGId5RGGoZgaE1
         o03pXb6uN1VrVbhGAtNFABdfikHud5NjHgM9ynvLEGZjsQD6cIF5j9Fyvu1uUM7slRFS
         cGh8Z1WInnoCSw9Tk2BqWU+9ZIWrXCgyqgTj/bqp2e9jMmClW5/3hDnro8NT/oklHH77
         b4Ejd/GLBQ2a+7o6c3vd5iqPCjU6zgSkCw3Atd1/U8mXuB7gHFXzif6WrZfSb9h3T9YP
         Opuw==
X-Forwarded-Encrypted: i=1; AKwUvBxoi8agB0/FOSBCtRQxhg+gbK78WXa0uqGF651n6uHvFNKPgI67EmYdClyxouu6R5ZJA2fyBBY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsRXTln9V+RtK6ueHgU2csg3NL2wDd2cwX4+Uurj881zoQAJ7a
	98Muvxxi3vwCh18vG8G1TDz2NWM6dTkg/181jmmlThOxje0TzMXIj//D
X-Gm-Gg: AYBFou1zUhVgcUr48We6362XSfoztlx3LWMMwGOlQyvG7EyTKfUf1j4euQVb4jcU4So
	Zv0/+R2CY5RYTU6522F0mNFASmtmqtgJu2qvOuk9BEtcn70MFBHGBBOZOlCcSFenX3Av5r2kbmV
	3pNQmlxdOcDf/VQQvcqSrpcZ7xSfzzgEyrEoyaNTQvmJWbrWqAsqhhuwngJzKDQfo2jAb+qe3mT
	GIhD2Nqj1Ny6bsW+B5acb8npf28r3Ltwfoi5gm9is1b9xqXoMeQjNr+kv7ItvNmCfBSDu9zNhb/
	MhR5Wx5To6Rr1vYB+cHTIF3f1RCPMOsa0rGwEWfgzDNrfmK2HwNHd4DcCH/u1QprOQwgbuBcldK
	lIjiK+D8y1Gy0P2Q8zCQtN6DhJci2NFDgkPWshq8z3trh+agyTcJB86ERTAN/LPkmNR0qeXki3Y
	zIt6kajzZ+0bdBkWUzBi1+6p0pbPy+7XcykWqmzxqV39h2R/0HtEqv5jGIsIh1Q8StgGu9H+kUe
	rOdgkvjUQP6SEsN2F4mBCqPTzboqLyfhSZikIPj7EKBHzw/7YJtzPFoO8cidLXVhu9/irZuqiGU
	Fv8Gyf1Lig==
X-Received: by 2002:a05:701b:458d:b0:14f:505d:813 with SMTP id a92af1059eb24-18514633f94mr2017889c88.41.1792201212852;
        Fri, 16 Oct 2026 18:40:12 -0700 (PDT)
Received: from lappy.taila8a9bd.ts.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831acba710sm12128429c88.13.2026.10.16.18.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:40:12 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH v2 06/11] HID: hid-lenovo-go-s: Add suspend function and gate access under bool.
Date: Fri, 16 Oct 2026 18:39:51 -0700
Message-ID: <20261017013956.2440130-7-derekjohn.clark@gmail.com>
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
index ed08200e3571..14aeddd65704 100644
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
@@ -507,10 +509,22 @@ static ssize_t gamepad_property_store(struct device *dev,
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
@@ -591,9 +605,21 @@ static ssize_t gamepad_property_show(struct device *dev,
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
@@ -729,10 +755,16 @@ static ssize_t touchpad_property_store(struct device *dev,
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
@@ -763,9 +795,15 @@ static ssize_t touchpad_property_show(struct device *dev,
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
@@ -792,9 +830,15 @@ static ssize_t touchpad_property_options(struct device *dev,
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
@@ -817,9 +861,15 @@ static ssize_t test_property_show(struct device *dev,
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
@@ -877,9 +927,15 @@ static ssize_t rgb_effect_store(struct device *dev,
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
@@ -904,8 +960,14 @@ static ssize_t rgb_effect_store(struct device *dev,
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
@@ -937,9 +999,15 @@ static ssize_t rgb_speed_store(struct device *dev,
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
@@ -967,8 +1035,14 @@ static ssize_t rgb_speed_store(struct device *dev,
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
@@ -988,9 +1062,15 @@ static ssize_t rgb_speed_range_show(struct device *dev,
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
@@ -1010,8 +1090,14 @@ static ssize_t rgb_mode_store(struct device *dev, struct device_attribute *attr,
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
@@ -1041,10 +1127,16 @@ static ssize_t rgb_profile_store(struct device *dev,
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
@@ -1064,8 +1156,14 @@ static ssize_t rgb_profile_store(struct device *dev,
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
@@ -1087,8 +1185,14 @@ static void hid_gos_brightness_set(struct led_classdev *led_cdev,
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
@@ -1395,6 +1499,11 @@ static void cfg_setup(struct work_struct *work)
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
@@ -1455,9 +1564,24 @@ static void hid_gos_cfg_remove(struct hid_device *hdev)
 
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
@@ -1546,6 +1670,30 @@ static int hid_gos_reset_resume(struct hid_device *hdev)
 	return 0;
 }
 
+static int hid_gos_cfg_suspend(void)
+{
+	cancel_delayed_work_sync(&drvdata.gos_cfg_setup);
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
@@ -1562,6 +1710,7 @@ static struct hid_driver hid_lenovo_go_s = {
 	.remove = hid_gos_remove,
 	.raw_event = hid_gos_raw_event,
 	.reset_resume = pm_ptr(hid_gos_reset_resume),
+	.suspend = pm_ptr(hid_gos_suspend),
 };
 module_hid_driver(hid_lenovo_go_s);
 
-- 
2.55.0

