Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CDC4746A4
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 17:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764494; cv=none; b=eSq/PBsvDige9hO9PVOoLQqd1WePYD7KcDwAI9HJkzi9b+9SEGrTGIOTSUNcaUGxknbIVkjKN0Ni/sY7t0jt1m9VjR09CyAfHcqTvKhiWZVfsKuICCEKio91f9oYMvEvgrq1/zgj++DCT6EmfQuXcVSQI7Ecp5lMlDUHh1jv7Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764494; c=relaxed/simple;
	bh=dApDURUpSyfTuAYv9/4Qyzv7a8sktA8sbYKZKHjbY1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0r5YJ/EWjDXda0QdzkobFrO3mvDoAty2SrIUPGKtxeg+M6LSo5LU7mSShkH/ghDCXeJynSVmQOUa7Ci/GgPZhZ4alamLrjahVHmzER+rA/Mum90x5A2SLQv1Q/TVAe5z+xAFUw/ORxz7R+CMPWPwEGdTrNwQtfxSAkLLA6xc+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3V4oTal; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3V4oTal"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14391F00AC4;
	Wed, 26 Aug 2026 17:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787764457;
	bh=MmM34MST3k9rHBsaRevlTSBA6El7kQUyWvKKAfgJbOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I3V4oTalt9Y5t0ERLq3SZ8TN7p/F5r1sftBjTp8OSIUkZH5Ddbr9XGz07Oa5RVzKi
	 G47EYnHSdeRet+8Vaca5aDKXdBMFGYBjfp40SPHa4/+8IiiIArS59rrRT+cJX+NBEP
	 98PbKtpoVfVAc9qfp0ZoC8bSg2fpEppLgrG9XIS4HD0WK/HpCecZhcV+7j7VBKxBgs
	 EM14WAw4cpSuX9qRT8n6RFXFrIXzJleDYSC8ptCFGJ53l07GFjO4wKToAEr8um1vaZ
	 Ou59xGHzTK+trjREedngrLiNpRYIcB3ngzU8yNYu32gpxCOI4BwuDey922VUjnY7CO
	 gLZstKeL8QnFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lucas Zampieri <lcasmz54@gmail.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] HID: input: Introduce struct hid_battery and refactor battery code
Date: Wed, 26 Aug 2026 13:14:13 -0400
Message-ID: <20260826171414.2246040-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826171414.2246040-1-sashal@kernel.org>
References: <2026082541-tightwad-rinsing-012b@gregkh>
 <20260826171414.2246040-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lucas Zampieri <lcasmz54@gmail.com>

[ Upstream commit 7a3ac62473f2bd213557e41aaab7a8f144037dfd ]

Introduce struct hid_battery to encapsulate individual battery state,
preparing for future multi-battery support.

The new structure contains all battery-related fields previously stored
directly in hid_device (capacity, min, max, report_type, report_id,
charge_status, etc.). The hid_device->battery pointer type changes from
struct power_supply* to struct hid_battery*, and all battery functions
are refactored accordingly.

A hid_get_battery() helper is added for external drivers, with
hid-apple.c and hid-magicmouse.c updated to use the new API. The
hid-input-test.c KUnit tests are also updated for the new structure.

No functional changes for single-battery devices.

Signed-off-by: Lucas Zampieri <lcasmz54@gmail.com>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Stable-dep-of: d07644524b65 ("HID: input: read battery capacity from its actual report offset")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-apple.c      |  10 +--
 drivers/hid/hid-input-test.c |  39 ++++++-----
 drivers/hid/hid-input.c      | 128 ++++++++++++++++++++---------------
 drivers/hid/hid-magicmouse.c |  10 +--
 include/linux/hid.h          |  49 ++++++++++----
 5 files changed, 143 insertions(+), 93 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index cb1bd6dca8356..b655503cbff09 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -623,17 +623,19 @@ static int apple_fetch_battery(struct hid_device *hdev)
 	struct apple_sc *asc = hid_get_drvdata(hdev);
 	struct hid_report_enum *report_enum;
 	struct hid_report *report;
+	struct hid_battery *bat;
 
-	if (!(asc->quirks & APPLE_RDESC_BATTERY) || !hdev->battery)
+	bat = hid_get_battery(hdev);
+	if (!(asc->quirks & APPLE_RDESC_BATTERY) || !bat)
 		return -1;
 
-	report_enum = &hdev->report_enum[hdev->battery_report_type];
-	report = report_enum->report_id_hash[hdev->battery_report_id];
+	report_enum = &hdev->report_enum[bat->report_type];
+	report = report_enum->report_id_hash[bat->report_id];
 
 	if (!report || report->maxfield < 1)
 		return -1;
 
-	if (hdev->battery_capacity == hdev->battery_max)
+	if (bat->capacity == bat->max)
 		return -1;
 
 	hid_hw_request(hdev, report, HID_REQ_GET_REPORT);
diff --git a/drivers/hid/hid-input-test.c b/drivers/hid/hid-input-test.c
index 6f5c71660d823..c92008dafddfd 100644
--- a/drivers/hid/hid-input-test.c
+++ b/drivers/hid/hid-input-test.c
@@ -9,54 +9,59 @@
 
 static void hid_test_input_update_battery_charge_status(struct kunit *test)
 {
-	struct hid_device *dev;
+	struct hid_battery *bat;
 	bool handled;
 
-	dev = kunit_kzalloc(test, sizeof(*dev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	bat = kunit_kzalloc(test, sizeof(*bat), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, bat);
 
-	handled = hidinput_update_battery_charge_status(dev, HID_DG_HEIGHT, 0);
+	handled = hidinput_update_battery_charge_status(bat, HID_DG_HEIGHT, 0);
 	KUNIT_EXPECT_FALSE(test, handled);
-	KUNIT_EXPECT_EQ(test, dev->battery_charge_status, POWER_SUPPLY_STATUS_UNKNOWN);
+	KUNIT_EXPECT_EQ(test, bat->charge_status, POWER_SUPPLY_STATUS_UNKNOWN);
 
-	handled = hidinput_update_battery_charge_status(dev, HID_BAT_CHARGING, 0);
+	handled = hidinput_update_battery_charge_status(bat, HID_BAT_CHARGING, 0);
 	KUNIT_EXPECT_TRUE(test, handled);
-	KUNIT_EXPECT_EQ(test, dev->battery_charge_status, POWER_SUPPLY_STATUS_DISCHARGING);
+	KUNIT_EXPECT_EQ(test, bat->charge_status, POWER_SUPPLY_STATUS_DISCHARGING);
 
-	handled = hidinput_update_battery_charge_status(dev, HID_BAT_CHARGING, 1);
+	handled = hidinput_update_battery_charge_status(bat, HID_BAT_CHARGING, 1);
 	KUNIT_EXPECT_TRUE(test, handled);
-	KUNIT_EXPECT_EQ(test, dev->battery_charge_status, POWER_SUPPLY_STATUS_CHARGING);
+	KUNIT_EXPECT_EQ(test, bat->charge_status, POWER_SUPPLY_STATUS_CHARGING);
 }
 
 static void hid_test_input_get_battery_property(struct kunit *test)
 {
 	struct power_supply *psy;
+	struct hid_battery *bat;
 	struct hid_device *dev;
 	union power_supply_propval val;
 	int ret;
 
 	dev = kunit_kzalloc(test, sizeof(*dev), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
-	dev->battery_avoid_query = true;
+
+	bat = kunit_kzalloc(test, sizeof(*bat), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, bat);
+	bat->dev = dev;
+	bat->avoid_query = true;
 
 	psy = kunit_kzalloc(test, sizeof(*psy), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, psy);
-	psy->drv_data = dev;
+	psy->drv_data = bat;
 
-	dev->battery_status = HID_BATTERY_UNKNOWN;
-	dev->battery_charge_status = POWER_SUPPLY_STATUS_CHARGING;
+	bat->status = HID_BATTERY_UNKNOWN;
+	bat->charge_status = POWER_SUPPLY_STATUS_CHARGING;
 	ret = hidinput_get_battery_property(psy, POWER_SUPPLY_PROP_STATUS, &val);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 	KUNIT_EXPECT_EQ(test, val.intval, POWER_SUPPLY_STATUS_UNKNOWN);
 
-	dev->battery_status = HID_BATTERY_REPORTED;
-	dev->battery_charge_status = POWER_SUPPLY_STATUS_CHARGING;
+	bat->status = HID_BATTERY_REPORTED;
+	bat->charge_status = POWER_SUPPLY_STATUS_CHARGING;
 	ret = hidinput_get_battery_property(psy, POWER_SUPPLY_PROP_STATUS, &val);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 	KUNIT_EXPECT_EQ(test, val.intval, POWER_SUPPLY_STATUS_CHARGING);
 
-	dev->battery_status = HID_BATTERY_REPORTED;
-	dev->battery_charge_status = POWER_SUPPLY_STATUS_DISCHARGING;
+	bat->status = HID_BATTERY_REPORTED;
+	bat->charge_status = POWER_SUPPLY_STATUS_DISCHARGING;
 	ret = hidinput_get_battery_property(psy, POWER_SUPPLY_PROP_STATUS, &val);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 	KUNIT_EXPECT_EQ(test, val.intval, POWER_SUPPLY_STATUS_DISCHARGING);
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index bc913110fda6a..7a9259d8a37d6 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -419,18 +419,18 @@ static unsigned find_battery_quirk(struct hid_device *hdev)
 	return quirks;
 }
 
-static int hidinput_scale_battery_capacity(struct hid_device *dev,
+static int hidinput_scale_battery_capacity(struct hid_battery *bat,
 					   int value)
 {
-	if (dev->battery_min < dev->battery_max &&
-	    value >= dev->battery_min && value <= dev->battery_max)
-		value = ((value - dev->battery_min) * 100) /
-			(dev->battery_max - dev->battery_min);
+	if (bat->min < bat->max &&
+	    value >= bat->min && value <= bat->max)
+		value = ((value - bat->min) * 100) /
+			(bat->max - bat->min);
 
 	return value;
 }
 
-static int hidinput_query_battery_capacity(struct hid_device *dev)
+static int hidinput_query_battery_capacity(struct hid_battery *bat)
 {
 	int ret;
 
@@ -438,19 +438,20 @@ static int hidinput_query_battery_capacity(struct hid_device *dev)
 	if (!buf)
 		return -ENOMEM;
 
-	ret = hid_hw_raw_request(dev, dev->battery_report_id, buf, 4,
-				 dev->battery_report_type, HID_REQ_GET_REPORT);
+	ret = hid_hw_raw_request(bat->dev, bat->report_id, buf, 4,
+				 bat->report_type, HID_REQ_GET_REPORT);
 	if (ret < 2)
 		return -ENODATA;
 
-	return hidinput_scale_battery_capacity(dev, buf[1]);
+	return hidinput_scale_battery_capacity(bat, buf[1]);
 }
 
 static int hidinput_get_battery_property(struct power_supply *psy,
 					 enum power_supply_property prop,
 					 union power_supply_propval *val)
 {
-	struct hid_device *dev = power_supply_get_drvdata(psy);
+	struct hid_battery *bat = power_supply_get_drvdata(psy);
+	struct hid_device *dev = bat->dev;
 	int value;
 	int ret = 0;
 
@@ -461,13 +462,13 @@ static int hidinput_get_battery_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_CAPACITY:
-		if (dev->battery_status != HID_BATTERY_REPORTED &&
-		    !dev->battery_avoid_query) {
-			value = hidinput_query_battery_capacity(dev);
+		if (bat->status != HID_BATTERY_REPORTED &&
+		    !bat->avoid_query) {
+			value = hidinput_query_battery_capacity(bat);
 			if (value < 0)
 				return value;
 		} else  {
-			value = dev->battery_capacity;
+			value = bat->capacity;
 		}
 
 		val->intval = value;
@@ -478,20 +479,20 @@ static int hidinput_get_battery_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_STATUS:
-		if (dev->battery_status != HID_BATTERY_REPORTED &&
-		    !dev->battery_avoid_query) {
-			value = hidinput_query_battery_capacity(dev);
+		if (bat->status != HID_BATTERY_REPORTED &&
+		    !bat->avoid_query) {
+			value = hidinput_query_battery_capacity(bat);
 			if (value < 0)
 				return value;
 
-			dev->battery_capacity = value;
-			dev->battery_status = HID_BATTERY_QUERIED;
+			bat->capacity = value;
+			bat->status = HID_BATTERY_QUERIED;
 		}
 
-		if (dev->battery_status == HID_BATTERY_UNKNOWN)
+		if (bat->status == HID_BATTERY_UNKNOWN)
 			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
 		else
-			val->intval = dev->battery_charge_status;
+			val->intval = bat->charge_status;
 		break;
 
 	case POWER_SUPPLY_PROP_SCOPE:
@@ -509,8 +510,9 @@ static int hidinput_get_battery_property(struct power_supply *psy,
 static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 				  struct hid_field *field, bool is_percentage)
 {
+	struct hid_battery *bat;
 	struct power_supply_desc *psy_desc;
-	struct power_supply_config psy_cfg = { .drv_data = dev, };
+	struct power_supply_config psy_cfg = { 0 };
 	unsigned quirks;
 	s32 min, max;
 	int error;
@@ -526,16 +528,22 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	if (quirks & HID_BATTERY_QUIRK_IGNORE)
 		return 0;
 
-	psy_desc = kzalloc(sizeof(*psy_desc), GFP_KERNEL);
-	if (!psy_desc)
+	bat = kzalloc(sizeof(*bat), GFP_KERNEL);
+	if (!bat)
 		return -ENOMEM;
 
+	psy_desc = kzalloc(sizeof(*psy_desc), GFP_KERNEL);
+	if (!psy_desc) {
+		error = -ENOMEM;
+		goto err_free_bat;
+	}
+
 	psy_desc->name = kasprintf(GFP_KERNEL, "hid-%s-battery",
 				   strlen(dev->uniq) ?
 					dev->uniq : dev_name(&dev->dev));
 	if (!psy_desc->name) {
 		error = -ENOMEM;
-		goto err_free_mem;
+		goto err_free_desc;
 	}
 
 	psy_desc->type = POWER_SUPPLY_TYPE_BATTERY;
@@ -555,37 +563,43 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	if (quirks & HID_BATTERY_QUIRK_FEATURE)
 		report_type = HID_FEATURE_REPORT;
 
-	dev->battery_min = min;
-	dev->battery_max = max;
-	dev->battery_report_type = report_type;
-	dev->battery_report_id = field->report->id;
-	dev->battery_charge_status = POWER_SUPPLY_STATUS_DISCHARGING;
+	bat->dev = dev;
+	bat->min = min;
+	bat->max = max;
+	bat->report_type = report_type;
+	bat->report_id = field->report->id;
+	bat->charge_status = POWER_SUPPLY_STATUS_DISCHARGING;
+	bat->status = HID_BATTERY_UNKNOWN;
 
 	/*
 	 * Stylus is normally not connected to the device and thus we
 	 * can't query the device and get meaningful battery strength.
 	 * We have to wait for the device to report it on its own.
 	 */
-	dev->battery_avoid_query = report_type == HID_INPUT_REPORT &&
-				   field->physical == HID_DG_STYLUS;
+	bat->avoid_query = report_type == HID_INPUT_REPORT &&
+			   field->physical == HID_DG_STYLUS;
 
 	if (quirks & HID_BATTERY_QUIRK_AVOID_QUERY)
-		dev->battery_avoid_query = true;
+		bat->avoid_query = true;
 
-	dev->battery = power_supply_register(&dev->dev, psy_desc, &psy_cfg);
-	if (IS_ERR(dev->battery)) {
-		error = PTR_ERR(dev->battery);
+	psy_cfg.drv_data = bat;
+	bat->ps = power_supply_register(&dev->dev, psy_desc, &psy_cfg);
+	if (IS_ERR(bat->ps)) {
+		error = PTR_ERR(bat->ps);
 		hid_warn(dev, "can't register power supply: %d\n", error);
 		goto err_free_name;
 	}
 
-	power_supply_powers(dev->battery, &dev->dev);
+	power_supply_powers(bat->ps, &dev->dev);
+	dev->battery = bat;
 	return 0;
 
 err_free_name:
 	kfree(psy_desc->name);
-err_free_mem:
+err_free_desc:
 	kfree(psy_desc);
+err_free_bat:
+	kfree(bat);
 	dev->battery = NULL;
 	return error;
 }
@@ -597,21 +611,22 @@ static void hidinput_cleanup_battery(struct hid_device *dev)
 	if (!dev->battery)
 		return;
 
-	psy_desc = dev->battery->desc;
-	power_supply_unregister(dev->battery);
+	psy_desc = dev->battery->ps->desc;
+	power_supply_unregister(dev->battery->ps);
 	kfree(psy_desc->name);
 	kfree(psy_desc);
+	kfree(dev->battery);
 	dev->battery = NULL;
 }
 
-static bool hidinput_update_battery_charge_status(struct hid_device *dev,
+static bool hidinput_update_battery_charge_status(struct hid_battery *bat,
 						  unsigned int usage, int value)
 {
 	switch (usage) {
 	case HID_BAT_CHARGING:
-		dev->battery_charge_status = value ?
-					     POWER_SUPPLY_STATUS_CHARGING :
-					     POWER_SUPPLY_STATUS_DISCHARGING;
+		bat->charge_status = value ?
+				     POWER_SUPPLY_STATUS_CHARGING :
+				     POWER_SUPPLY_STATUS_DISCHARGING;
 		return true;
 	}
 
@@ -621,32 +636,33 @@ static bool hidinput_update_battery_charge_status(struct hid_device *dev,
 static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
 				    int value)
 {
+	struct hid_battery *bat = dev->battery;
 	int capacity;
 
-	if (!dev->battery)
+	if (!bat)
 		return;
 
-	if (hidinput_update_battery_charge_status(dev, usage, value)) {
-		power_supply_changed(dev->battery);
+	if (hidinput_update_battery_charge_status(bat, usage, value)) {
+		power_supply_changed(bat->ps);
 		return;
 	}
 
 	if ((usage & HID_USAGE_PAGE) == HID_UP_DIGITIZER && value == 0)
 		return;
 
-	if (value < dev->battery_min || value > dev->battery_max)
+	if (value < bat->min || value > bat->max)
 		return;
 
-	capacity = hidinput_scale_battery_capacity(dev, value);
+	capacity = hidinput_scale_battery_capacity(bat, value);
 
-	if (dev->battery_status != HID_BATTERY_REPORTED ||
-	    capacity != dev->battery_capacity ||
-	    ktime_after(ktime_get_coarse(), dev->battery_ratelimit_time)) {
-		dev->battery_capacity = capacity;
-		dev->battery_status = HID_BATTERY_REPORTED;
-		dev->battery_ratelimit_time =
+	if (bat->status != HID_BATTERY_REPORTED ||
+	    capacity != bat->capacity ||
+	    ktime_after(ktime_get_coarse(), bat->ratelimit_time)) {
+		bat->capacity = capacity;
+		bat->status = HID_BATTERY_REPORTED;
+		bat->ratelimit_time =
 			ktime_add_ms(ktime_get_coarse(), 30 * 1000);
-		power_supply_changed(dev->battery);
+		power_supply_changed(bat->ps);
 	}
 }
 #else  /* !CONFIG_HID_BATTERY_STRENGTH */
diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 9eadf3252d0dc..e70bd3dc07ab7 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -817,19 +817,21 @@ static int magicmouse_fetch_battery(struct hid_device *hdev)
 #ifdef CONFIG_HID_BATTERY_STRENGTH
 	struct hid_report_enum *report_enum;
 	struct hid_report *report;
+	struct hid_battery *bat;
 
-	if (!hdev->battery ||
+	bat = hid_get_battery(hdev);
+	if (!bat ||
 	    (!is_usb_magicmouse2(hdev->vendor, hdev->product) &&
 	     !is_usb_magictrackpad2(hdev->vendor, hdev->product)))
 		return -1;
 
-	report_enum = &hdev->report_enum[hdev->battery_report_type];
-	report = report_enum->report_id_hash[hdev->battery_report_id];
+	report_enum = &hdev->report_enum[bat->report_type];
+	report = report_enum->report_id_hash[bat->report_id];
 
 	if (!report || report->maxfield < 1)
 		return -1;
 
-	if (hdev->battery_capacity == hdev->battery_max)
+	if (bat->capacity == bat->max)
 		return -1;
 
 	hid_hw_request(hdev, report, HID_REQ_GET_REPORT);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 29561887bea8c..d1f105def0fbc 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -634,6 +634,34 @@ enum hid_battery_status {
 	HID_BATTERY_REPORTED,		/* Device sent unsolicited battery strength report */
 };
 
+/**
+ * struct hid_battery - represents a single battery power supply
+ * @dev: pointer to the parent hid_device
+ * @ps: the power supply instance
+ * @min: minimum battery value from HID descriptor
+ * @max: maximum battery value from HID descriptor
+ * @report_type: HID report type (input/feature)
+ * @report_id: HID report ID for this battery
+ * @charge_status: current charging status
+ * @status: battery reporting status
+ * @capacity: current battery capacity (0-100)
+ * @avoid_query: if true, avoid querying battery (e.g., for stylus)
+ * @ratelimit_time: rate limiting for battery reports
+ */
+struct hid_battery {
+	struct hid_device *dev;
+	struct power_supply *ps;
+	__s32 min;
+	__s32 max;
+	__s32 report_type;
+	__s32 report_id;
+	__s32 charge_status;
+	enum hid_battery_status status;
+	__s32 capacity;
+	bool avoid_query;
+	ktime_t ratelimit_time;
+};
+
 struct hid_driver;
 struct hid_ll_driver;
 
@@ -670,19 +698,9 @@ struct hid_device {
 #ifdef CONFIG_HID_BATTERY_STRENGTH
 	/*
 	 * Power supply information for HID devices which report
-	 * battery strength. power_supply was successfully registered if
-	 * battery is non-NULL.
+	 * battery strength. battery is non-NULL if successfully registered.
 	 */
-	struct power_supply *battery;
-	__s32 battery_capacity;
-	__s32 battery_min;
-	__s32 battery_max;
-	__s32 battery_report_type;
-	__s32 battery_report_id;
-	__s32 battery_charge_status;
-	enum hid_battery_status battery_status;
-	bool battery_avoid_query;
-	ktime_t battery_ratelimit_time;
+	struct hid_battery *battery;
 #endif
 
 	unsigned long status;						/* see STAT flags above */
@@ -743,6 +761,13 @@ static inline void hid_set_drvdata(struct hid_device *hdev, void *data)
 	dev_set_drvdata(&hdev->dev, data);
 }
 
+#ifdef CONFIG_HID_BATTERY_STRENGTH
+static inline struct hid_battery *hid_get_battery(struct hid_device *hdev)
+{
+	return hdev->battery;
+}
+#endif
+
 #define HID_GLOBAL_STACK_SIZE 4
 #define HID_COLLECTION_STACK_SIZE 4
 
-- 
2.53.0

