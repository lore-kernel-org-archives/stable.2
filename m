Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795538797;
	b=nTSnYxefmsEAOSh0AQ3WfrsOIlXw9807H7ZzPY96BtkFoeRg7t58DlE5zmkftdkwjXYw
	 ubIBE7nYsY6ejno9oMnUL+gnrc4JT4p2hxgeDdgbZP0Yo3DuDhNdVV8lQ+1s17AJnPbsF
	 IDKwZpKn9m2XJnoy1jegKay6ojTpnwOrsPtPGTUY5ac3moQkDYVN/BzQlpyU/Y2Nom1z4
	 UYWaShsQAhOR1IX8SXYC9OWnNRTQ0YAUOKM9g/j83VSCfpZ2MD0lExoNFmcMd4EHPBpA/
	 1tKn5F0RBwSZ9nB/6PQZTfqZdY/PqbaJYzRaTT0vfyM6opiuTud8pOslG4s98lT027w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538797;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=whFeiy2C5pn/e+nXVtcQ8J3tkzHLYBnV0Ny268pSTEk=;
	b=vj/gGX3Y6b+NFjEZl512fyR3/275fmEM+kec/3Njk2MWNBi7nDhLekYM43RmLq9gUpCi
	 YjqM2cyDZ0Ov6oQqt1Y7SmAzWVx/LpmIs2LzBuXUdx71AbB1zpYI+jC3yTq/ytyXFnZjR
	 sdQ0o3pZANn5qVbdws010mxIGTRRCPRYQuTUjY4tQM34/aszUMlwJKG+/V3DYl6jFm7gv
	 HUHuMAi4KIJ+v5Gpgq45Zh7yqO+keUYDnx4bP05ON6I1w3YNwtt2FrQIJN5iQVVkhNP+T
	 wR9s+9lBWeoERIfKHfM/BrIIDdvnb+Mp4kz832ZhklgomCHp7LnfxhlQbZLz8JIzkVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=Zmnaj0Gp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.112
Received: from sender6-pp-f112.zoho.com (sender6-pp-f112.zoho.com [165.173.180.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A560E606A31E;
	Tue, 24 Nov 2026 16:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A560E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=Zmnaj0Gp
ARC-Seal: i=1; a=rsa-sha256; t=1795538718; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Xodovde6qmxVQihNRsEqNxFOWA/sy/ZPZE2Fp+oZxMLJSSEB6cYkfHrULJPtkt5v6E3pKwiMhRQK15fkR10v7OhLOCGZZEAfKHjjTlGfUpqElM6gDW5V4TVO5GAhq/qbSZBj2snAsBpdrrhZ8zEalu6C1EENpH9YLLpLncNmq/4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795538718; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=whFeiy2C5pn/e+nXVtcQ8J3tkzHLYBnV0Ny268pSTEk=; 
	b=E4WVwY0qlmVMGJkWK7KiKsLd6WkHVyr7O1bjvnyoUmv/ZM5PaI1gtF7Kz7akKGyZFtn+MPgThw7sAY6cPC+SBW//l6IZv3KmKEVdJnf6Wn1ZITcWFZ3beZ1iWloR0bJaydK4OOLrRIGCJVfuB/bL8oevt4b3TLnKNg+PRNRH8MA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=Zmnaj0GpS39HAkRYObifw9aCk8xW6xTuGZlyiYCYb5izsYdxZjPjyQn+PW5cK0v6U3k33IGnZcXyrvkC5PGQgBULZO6BwGM/vcodhrUNx16XRYEa/nZ65AGrtAuhy1Xzk68XQRc6Q3dEB9lFA5Ux40O6yrLYEPaykTThGXk3Qnsqcx6JHycldkxYe+nQLG3cmXZXVuH7X2D2jPRKC9ZrU/4ieGbGWQ0XpndiKARXHvWR5BYEF26dQREgH4Kc5f+MLqA5m6oT2r86lkzejqn5SQp81yRUj9G3xdD5MVb2cJbA0g0dXsSVayFj0iPJEetqkgptF873jQoThk6kMIZFhQ==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=whFeiy2C5pn/e+nXVtcQ8J3tkzHLYBnV0Ny268pSTEk=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795538716191700.3072928911643;
	Tue, 24 Nov 2026 08:45:16 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Wed, 25 Nov 2026 00:44:31 +0800
Subject: [PATCH v4 3/9] HID: haptic, multitouch: Check haptic prerequisite
 properly
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-hid-haptic-kmod-v4-3-03713a89f656@rong.moe>
References: <20261125-hid-haptic-kmod-v4-0-03713a89f656@rong.moe>
In-Reply-To: <20261125-hid-haptic-kmod-v4-0-03713a89f656@rong.moe>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Angela Czubak <aczubak@google.com>, Henrik Rydberg <rydberg@bitmath.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-ZohoMailClient: External

The td->is_haptic_touchpad boolean is multiplexed through during the
probe- and run-time procedures of hid-multitouch. However, the way it
flips is fragile on faulty devices.

MT touchpads have multiple HID_DG_TIPPRESSURE usages, but the value of
td->is_haptic_touchpad only depends on the last usage, and doesn't check
if all usages have the same critical annotations. Moreover, if the HID
device happens to have multiple HID_DG_TOUCHPAD applications, the haptic
device may be initialized more than once.

Fix them by storing the relevant HID_DG_TOUCHPAD input device (must have
a pressure sensor) during hid_haptic_check_pressure_unit(), with proper
sanity checks that reject annotation mismatches and duplicated
HID_DG_TOUCHPAD input devices. Later, hid_haptic_input_configured()
continues the initialization only if the input device matches the
previously stored one.

With that, the td->is_haptic_touchpad is converted into a one-way (false
=> true) flipping manner. All calls to hid_haptic_*() during the
probe-time procedures are now guarded by the nullability of td->haptic
instead of td->is_haptic_touchpad or no guard, preparing to skip
allocating td->haptic in !CONFIG_HID_HAPTIC builds in the following
changes.

At runtime, relevant haptic methods are called only if the event source
is the same input device as the stored one.

Fixes: 7939f787f450 ("HID: haptic: move FF initialization into .input_configured()")
Cc: stable@vger.kernel.org
Signed-off-by: Rong Zhang <i@rong.moe>
---
Changes in v2:
- Reject touchpad applications with non-force units (thanks Sashiko)
- Only call runtime methods if the event source is the same input device
  as the stored one (ditto)
---
 drivers/hid/hid-haptic.c     | 65 ++++++++++++++++++++++++++------------------
 drivers/hid/hid-haptic.h     | 35 ++++++++++++++----------
 drivers/hid/hid-multitouch.c | 36 ++++++++++++------------
 3 files changed, 77 insertions(+), 59 deletions(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index 8312b8edc847..3ef2bce67671 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -48,17 +48,40 @@ void hid_haptic_feature_mapping(struct hid_device *hdev,
 }
 EXPORT_SYMBOL_GPL(hid_haptic_feature_mapping);
 
-bool hid_haptic_check_pressure_unit(struct hid_haptic_device *haptic,
+void hid_haptic_check_pressure_unit(struct hid_haptic_device *haptic,
 				    struct hid_input *hi, struct hid_field *field)
 {
-	if (field->unit == HID_UNIT_GRAM || field->unit == HID_UNIT_NEWTON) {
-		haptic->force_logical_minimum = field->logical_minimum;
-		haptic->force_physical_minimum = field->physical_minimum;
-		haptic->force_resolution = input_abs_get_res(hi->input,
-							     ABS_MT_PRESSURE);
-		return true;
+	if (hi->application != HID_DG_TOUCHPAD)
+		return;
+
+	if (IS_ERR(haptic->input_dev))
+		return;
+
+	if (field->unit != HID_UNIT_GRAM && field->unit != HID_UNIT_NEWTON)
+		goto reject;
+
+	if (!haptic->input_dev) {
+		haptic->input_dev = hi->input;
+		haptic->pressure_field = field;
+		haptic->force_resolution = input_abs_get_res(hi->input, ABS_MT_PRESSURE);
+		return;
 	}
-	return false;
+
+	if (hid_haptic_connected_to_input(haptic, hi->input) &&
+	    haptic->pressure_field->unit == field->unit &&
+	    haptic->pressure_field->logical_minimum == field->logical_minimum &&
+	    haptic->pressure_field->physical_minimum == field->physical_minimum &&
+	    haptic->force_resolution == input_abs_get_res(hi->input, ABS_MT_PRESSURE))
+		return;
+
+reject:
+	/*
+	 * Reject if:
+	 * - there are multiple input devices with pressure sensors
+	 * - there is any touchpad application with a non-force unit
+	 * - pressure annotations mismatch among HID_DG_TIPPRESSURE usages
+	 */
+	haptic->input_dev = ERR_PTR(-EPROTO);
 }
 EXPORT_SYMBOL_GPL(hid_haptic_check_pressure_unit);
 
@@ -78,28 +101,17 @@ int hid_haptic_input_mapping(struct hid_device *hdev,
 }
 EXPORT_SYMBOL_GPL(hid_haptic_input_mapping);
 
-int hid_haptic_input_configured(struct hid_device *hdev,
-				struct hid_haptic_device *haptic,
-				struct hid_input *hi)
+bool hid_haptic_input_configured(struct hid_device *hdev,
+				 struct hid_haptic_device *haptic, struct hid_input *hi)
 {
-	int error;
-
-	if (hi->application != HID_DG_TOUCHPAD)
-		return -1;
-
-	if (!haptic->auto_trigger_report || !haptic->manual_trigger_report)
-		return 0;
+	if (IS_ERR_OR_NULL(haptic->input_dev) ||
+	    !hid_haptic_connected_to_input(haptic, hi->input) ||
+	    !haptic->auto_trigger_report || !haptic->manual_trigger_report)
+		return false;
 
 	__set_bit(INPUT_PROP_PRESSUREPAD, hi->input->propbit);
 
-	error = hid_haptic_init(hdev, haptic, hi->input);
-	if (error) {
-		dev_warn(&hdev->dev, "Cannot allocate haptic for %s\n",
-			 hdev->name);
-		return 0;
-	}
-
-	return 1;
+	return hid_haptic_init(hdev, haptic, hi->input) == 0;
 }
 EXPORT_SYMBOL_GPL(hid_haptic_input_configured);
 
@@ -519,6 +531,7 @@ int hid_haptic_init(struct hid_device *hdev,
 	kfree(haptic->hid_usage_map);
 	haptic->hid_usage_map = NULL;
 exit:
+	dev_warn(&hdev->dev, "Cannot allocate haptic for %s: %d\n", hdev->name, ret);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(hid_haptic_init);
diff --git a/drivers/hid/hid-haptic.h b/drivers/hid/hid-haptic.h
index 6332991a7844..cd4d9c74d2dc 100644
--- a/drivers/hid/hid-haptic.h
+++ b/drivers/hid/hid-haptic.h
@@ -33,12 +33,11 @@ struct hid_haptic_device {
 	struct mutex auto_trigger_mutex;
 	struct workqueue_struct *wq;
 	struct hid_report *manual_trigger_report;
+	struct hid_field *pressure_field;
 	struct mutex manual_trigger_mutex;
 	size_t manual_trigger_report_len;
 	int pressed_state;
 	s32 pressure_sum;
-	s32 force_logical_minimum;
-	s32 force_physical_minimum;
 	s32 force_resolution;
 	u32 mode;
 	u32 default_auto_trigger;
@@ -55,20 +54,25 @@ struct hid_haptic_device {
 };
 
 #if IS_ENABLED(CONFIG_HID_HAPTIC)
+static inline bool hid_haptic_connected_to_input(struct hid_haptic_device *haptic,
+						 struct input_dev *input)
+{
+	return haptic->input_dev == input;
+}
+
 void hid_haptic_feature_mapping(struct hid_device *hdev,
 				struct hid_haptic_device *haptic,
 				struct hid_field *field, struct hid_usage
 				*usage);
-bool hid_haptic_check_pressure_unit(struct hid_haptic_device *haptic,
+void hid_haptic_check_pressure_unit(struct hid_haptic_device *haptic,
 				    struct hid_input *hi, struct hid_field *field);
 int hid_haptic_input_mapping(struct hid_device *hdev,
 			     struct hid_haptic_device *haptic,
 			     struct hid_input *hi,
 			     struct hid_field *field, struct hid_usage *usage,
 			     unsigned long **bit, int *max);
-int hid_haptic_input_configured(struct hid_device *hdev,
-				struct hid_haptic_device *haptic,
-				struct hid_input *hi);
+bool hid_haptic_input_configured(struct hid_device *hdev,
+				 struct hid_haptic_device *haptic, struct hid_input *hi);
 int hid_haptic_init(struct hid_device *hdev, struct hid_haptic_device *haptic,
 		    struct input_dev *dev);
 void hid_haptic_handle_press_release(struct hid_haptic_device *haptic);
@@ -76,6 +80,12 @@ void hid_haptic_pressure_reset(struct hid_haptic_device *haptic);
 void hid_haptic_pressure_increase(struct hid_haptic_device *haptic,
 				  __s32 pressure);
 #else
+static inline bool hid_haptic_connected_to_input(struct hid_haptic_device *haptic,
+						 struct input_dev *input)
+{
+	return false;
+}
+
 static inline
 void hid_haptic_feature_mapping(struct hid_device *hdev,
 				struct hid_haptic_device *haptic,
@@ -83,11 +93,9 @@ void hid_haptic_feature_mapping(struct hid_device *hdev,
 				*usage)
 {}
 static inline
-bool hid_haptic_check_pressure_unit(struct hid_haptic_device *haptic,
+void hid_haptic_check_pressure_unit(struct hid_haptic_device *haptic,
 				    struct hid_input *hi, struct hid_field *field)
-{
-	return false;
-}
+{}
 static inline
 int hid_haptic_input_mapping(struct hid_device *hdev,
 			     struct hid_haptic_device *haptic,
@@ -98,11 +106,10 @@ int hid_haptic_input_mapping(struct hid_device *hdev,
 	return 0;
 }
 static inline
-int hid_haptic_input_configured(struct hid_device *hdev,
-				struct hid_haptic_device *haptic,
-				struct hid_input *hi)
+bool hid_haptic_input_configured(struct hid_device *hdev,
+				 struct hid_haptic_device *haptic, struct hid_input *hi)
 {
-	return 0;
+	return false;
 }
 static inline
 void hid_haptic_reset(struct hid_device *hdev, struct hid_haptic_device *haptic)
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 3afca07025ea..5eea774dee44 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -605,7 +605,8 @@ static void mt_feature_mapping(struct hid_device *hdev,
 		break;
 	}
 
-	hid_haptic_feature_mapping(hdev, td->haptic, field, usage);
+	if (td->haptic)
+		hid_haptic_feature_mapping(hdev, td->haptic, field, usage);
 }
 
 static void set_abs(struct input_dev *input, unsigned int code,
@@ -961,9 +962,8 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		case HID_DG_TIPPRESSURE:
 			set_abs(hi->input, ABS_MT_PRESSURE, field,
 				cls->sn_pressure);
-			td->is_haptic_touchpad =
-				hid_haptic_check_pressure_unit(td->haptic,
-							       hi, field);
+			if (td->haptic)
+				hid_haptic_check_pressure_unit(td->haptic, hi, field);
 			MT_STORE_FIELD(p);
 			return 1;
 		case HID_DG_SCANTIME:
@@ -1085,7 +1085,7 @@ static void mt_sync_frame(struct mt_device *td, struct mt_application *app,
 
 	app->num_received = 0;
 	app->left_button_state = 0;
-	if (td->is_haptic_touchpad)
+	if (td->is_haptic_touchpad && hid_haptic_connected_to_input(td->haptic, input))
 		hid_haptic_pressure_reset(td->haptic);
 }
 
@@ -1238,7 +1238,7 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 			minor = minor >> 1;
 		}
 
-		if (td->is_haptic_touchpad)
+		if (td->is_haptic_touchpad && hid_haptic_connected_to_input(td->haptic, input))
 			hid_haptic_pressure_increase(td->haptic, *slot->p);
 
 		x = hdev->quirks & HID_QUIRK_X_INVERT ?
@@ -1441,7 +1441,7 @@ static int mt_touch_input_configured(struct hid_device *hdev,
 	if (cls->is_indirect)
 		app->mt_flags |= INPUT_MT_POINTER;
 
-	if (td->is_haptic_touchpad)
+	if (td->is_haptic_touchpad && hid_haptic_connected_to_input(td->haptic, input))
 		app->mt_flags |= INPUT_MT_TOTAL_FORCE;
 
 	if (app->quirks & MT_QUIRK_NOT_SEEN_MEANS_UP)
@@ -1553,10 +1553,11 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	if (field->physical == HID_DG_STYLUS)
 		hi->application = HID_DG_STYLUS;
 
-	ret = hid_haptic_input_mapping(hdev, td->haptic, hi, field, usage, bit,
-				       max);
-	if (ret != 0)
-		return ret;
+	if (td->haptic) {
+		ret = hid_haptic_input_mapping(hdev, td->haptic, hi, field, usage, bit, max);
+		if (ret)
+			return ret;
+	}
 
 	/* let hid-core decide for the others */
 	return 0;
@@ -1954,14 +1955,11 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	struct hid_report *report;
 	int ret;
 
-	if (td->is_haptic_touchpad && (td->mtclass.name == MT_CLS_WIN_8 ||
-	    td->mtclass.name == MT_CLS_WIN_8_FORCE_MULTI_INPUT ||
-	    td->mtclass.name == MT_CLS_WIN_8_KEEP_LATENCY_ON_CLOSE)) {
-		if (hid_haptic_input_configured(hdev, td->haptic, hi) == 0)
-			td->is_haptic_touchpad = false;
-	} else {
-		td->is_haptic_touchpad = false;
-	}
+	if (td->haptic && !td->is_haptic_touchpad &&
+	    (td->mtclass.name == MT_CLS_WIN_8 ||
+	     td->mtclass.name == MT_CLS_WIN_8_FORCE_MULTI_INPUT ||
+	     td->mtclass.name == MT_CLS_WIN_8_KEEP_LATENCY_ON_CLOSE))
+		td->is_haptic_touchpad = hid_haptic_input_configured(hdev, td->haptic, hi);
 
 	list_for_each_entry(report, &hi->reports, hidinput_list) {
 		rdata = mt_find_report_data(td, report);

-- 
2.55.0

