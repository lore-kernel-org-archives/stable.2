Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF0E53446B;
	Wed,  9 Sep 2026 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952399; cv=none; b=NjP58x4kF6O6QYVNgA6P2mr1rB9XPWcbF23r9L71tvNpu5yJqGE3aa5TzotiF35D+nl9AMSrphfLMPpaBBIcdH/jjpTOaI8aUtMNU7Q3yBs4UoIS5ev43nEo8kv5XhjB5s728W3BcHX0SR/pbs6jswP42Q2kS2KgOKbLiDHtoLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952399; c=relaxed/simple;
	bh=jZ6Ru/NnHrDCYE9MEapU8I24ihoS6eEY6ZfB+Kc896M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hP6uEDZP+nz3E0hvmPlF/Gactm3dHqDQkF3jHf62C1CsDEulaiT9fYVA+nKTjZ2lDvOCXXw1tnVjzaSw3WMJRaztexGIKI7Uw2UcCuBLVE36bPcVmRJvdHmGQPvrz2RcytUBogsQ5QWhjbsQ324vH9KbJ/QeB6VcTJp+uWUBmPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZM1LXbJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZM1LXbJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1BA1F00AC4;
	Wed,  9 Sep 2026 11:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788952391;
	bh=gb+dllo9OizpGVodgwo9oxalZzw+97MBjv1geA/rRek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WZM1LXbJMugQbqAiEM9mrxgnH/ruqqHqOyIZkZ6RMh9FQIidCr6bHlByEw0GJNGuo
	 XWgTdqPSBtuOwexp0ujAL3rv4SLpxJpFPJyh5DRLT8J+3JrQYj9NOYBHtLOXQ+YTEQ
	 UWrHps2wu/Mtj+bIlMfw3T4hnILVk6JfHtPIJ1Ti7V9K/IMk7UppcBcraZloisBWoG
	 JqTSRGP61gERfYsVupGCc6b5Ror0CD+Gm/Acl0BC80/YB24Ud/pBTpeQRQpf/UlnBk
	 OcbnwwWS1L98pDmjXxew6lCh2wVQOfI1gkgtknKDTUay8JETsLyj+YJm1o2I2sA04+
	 ZRysRzKmPmg8Q==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Aaron Skomra <aaron.skomra@wacom.com>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v10 2/5] HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration
Date: Wed,  9 Sep 2026 11:12:24 +0000
Message-ID: <4b4d640e7d5a4ae2a51ae395407df0f6d01a5268.1788868602.git.lee@kernel.org>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
In-Reply-To: <fa3cb42f7b58c1b3022d8208969a81882783a5ec.1788868602.git.lee@kernel.org>
References: <fa3cb42f7b58c1b3022d8208969a81882783a5ec.1788868602.git.lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Input subsystem guidelines require that device capabilities are advertised
before the input device is registered.  The Wacom driver was violating
this by advertising the SW_MUTE_DEVICE capability post-registration in
wacom_set_shared_values() (and duplicating it in device-specific setup
cases).

Resolve this by moving the SW_MUTE_DEVICE capability setup to
wacom_setup_touch_input_capabilities() for all touch devices that support
it.

For generic touch devices whose capabilities depend on mute switch
usages parsed from a sibling Pen/Pad interface, defer registration
with -EPROBE_DEFER until the sibling has parsed its descriptors and
initialized shared capabilities.

Cc: stable@vger.kernel.org
Fixes: d2ec58aee8b1 ("HID: wacom: generic: support generic touch switch")
Signed-off-by: Lee Jones <lee@kernel.org>
---
v4 -> v5:  New patch used to split out SW_MUTE_DEVICE as per Jason's request
v5 -> v6:  Unconditionally advertise SW_MUTE_DEVICE on generic touch devices
v6 -> v7:  Only advertise SW_MUTE_DEVICE on composite USB generic touch devices
v7 -> v8:  Replace heuristic with probe deferral until sibling Pen/Pad is parsed
           Split out 'hdev->product' cleanups into a separate standalone patch
v8 -> v9:  Fix TOCTOU race by assigning shared sibling pointers in wacom_set_shared_values()
           Support Pad interfaces in sibling deferral logic
v9 -> v10: Defer probe if unprobed sibling HID interface exists on composite
           USB device
           Ensure standalone generic touch devices advertise SW_MUTE_DEVICE
           Use acquire memory barrier (smp_load_acquire) when reading shared
           sibling state
           Cancel pending init_work in fail_hw_stop error path after stopping
           hardware
           Move has_mute_touch_switch write inside wacom_udev_list_lock
           Only assign shared->pen for Pen devices to prevent overwrite by Pad

 drivers/hid/wacom_sys.c | 95 ++++++++++++++++++++++++++++++++---------
 drivers/hid/wacom_wac.c |  5 +++
 2 files changed, 80 insertions(+), 20 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 0eafa483b7f7..4eed2c189017 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -907,19 +907,14 @@ static int wacom_add_shared_data(struct hid_device *hdev)
 		list_add_tail(&data->list, &wacom_udev_list);
 	}
 
-	mutex_unlock(&wacom_udev_list_lock);
-
 	wacom_wac->shared = &data->shared;
 
+	if (wacom_wac->has_mute_touch_switch)
+		WRITE_ONCE(wacom_wac->shared->has_mute_touch_switch, true);
+
+	mutex_unlock(&wacom_udev_list_lock);
+
 	retval = devm_add_action_or_reset(&hdev->dev, wacom_remove_shared_data, wacom);
-	if (retval)
-		return retval;
-
-	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)
-		wacom_wac->shared->touch = hdev;
-	else if (wacom_wac->features.device_type & WACOM_DEVICETYPE_PEN)
-		wacom_wac->shared->pen = hdev;
-
 	return retval;
 }
 
@@ -2343,13 +2338,12 @@ static void wacom_release_resources(struct wacom *wacom)
 
 static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
 {
-	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {
-		wacom_wac->shared->type = wacom_wac->features.type;
-		wacom_wac->shared->touch_input = wacom_wac->touch_input;
-	}
+	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
+
+	guard(mutex)(&wacom_udev_list_lock);
 
 	if (wacom_wac->has_mute_touch_switch) {
-		wacom_wac->shared->has_mute_touch_switch = true;
+		WRITE_ONCE(wacom_wac->shared->has_mute_touch_switch, true);
 		/* Hardware touch switch may be off. Wait until
 		 * we know the switch state to decide is_touch_on.
 		 * Softkey state should be initialized to "on" to
@@ -2359,14 +2353,69 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
 			wacom_wac->shared->is_touch_on = true;
 	}
 
-	if (wacom_wac->shared->has_mute_touch_switch &&
-	    wacom_wac->shared->touch_input) {
-		set_bit(EV_SW, wacom_wac->shared->touch_input->evbit);
-		input_set_capability(wacom_wac->shared->touch_input, EV_SW,
-				     SW_MUTE_DEVICE);
+	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {
+		wacom_wac->shared->type = wacom_wac->features.type;
+		wacom_wac->shared->touch_input = wacom_wac->touch_input;
+		wacom_wac->shared->touch = wacom->hdev;
+	} else if (wacom_wac->features.device_type & WACOM_DEVICETYPE_PEN) {
+		/* Pairs with smp_load_acquire() in wacom_sibling_pending() */
+		smp_store_release(&wacom_wac->shared->pen, wacom->hdev);
 	}
 }
 
+static bool wacom_sibling_pending(struct wacom *wacom)
+{
+	const struct wacom_features *features = &wacom->wacom_wac.features;
+	struct hid_device *hdev = wacom->hdev;
+	struct usb_interface *sibling_intf;
+	int ifnum;
+
+	if (features->type != HID_GENERIC ||
+	    !(features->device_type & WACOM_DEVICETYPE_TOUCH))
+		return false;
+
+	if (wacom->wacom_wac.shared) {
+		/* Pairs with smp_store_release() in wacom_set_shared_values() */
+		if (smp_load_acquire(&wacom->wacom_wac.shared->pen))
+			return false;
+	}
+
+	if (!hid_is_usb(hdev) || !wacom->usbdev || !wacom->intf ||
+	    !wacom->intf->cur_altsetting)
+		return false;
+
+	ifnum = wacom->intf->cur_altsetting->desc.bInterfaceNumber;
+
+	/*
+	 * On composite Wacom devices, the Pen interface is always interface 0.
+	 * If the Touch interface is interface 0, there is no sibling Pen
+	 * interface on this device (standalone touch device).
+	 */
+	if (ifnum == 0)
+		return false;
+
+	/* Look for the sibling Pen interface at interface 0 */
+	sibling_intf = usb_ifnum_to_if(wacom->usbdev, 0);
+	if (!sibling_intf || !sibling_intf->cur_altsetting)
+		return false;
+
+	if (sibling_intf->cur_altsetting->desc.bInterfaceClass !=
+	    USB_INTERFACE_CLASS_HID)
+		return false;
+
+	if (sibling_intf->cur_altsetting->desc.bInterfaceSubClass == 1 &&
+	    (sibling_intf->cur_altsetting->desc.bInterfaceProtocol == 1 ||
+	     sibling_intf->cur_altsetting->desc.bInterfaceProtocol == 2))
+		return false;
+
+	/*
+	 * Interface 0 is a candidate HID interface on this composite device
+	 * whose probe has not completed yet (shared->pen is NULL). Defer until
+	 * interface 0 finishes probing and registers shared values.
+	 */
+	return true;
+}
+
 static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 {
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
@@ -2444,6 +2493,11 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 	if (error)
 		goto fail;
 
+	if (wacom_sibling_pending(wacom)) {
+		error = -EPROBE_DEFER;
+		goto fail;
+	}
+
 	error = wacom_setup_inputs(wacom);
 	if (error)
 		goto fail;
@@ -2501,6 +2555,7 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 
 fail_hw_stop:
 	hid_hw_stop(hdev);
+	cancel_delayed_work_sync(&wacom->init_work);
 fail:
 	wacom_release_resources(wacom);
 	return error;
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 7cf2b4de52be..30df866feac8 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3978,6 +3978,11 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 
 	if (features->type == HID_GENERIC) {
 		hid_dbg(hdev, "generic touch setup\n");
+		if (wacom_wac->has_mute_touch_switch ||
+		    (wacom_wac->shared && READ_ONCE(wacom_wac->shared->has_mute_touch_switch))) {
+			input_set_capability(input_dev, EV_SW, SW_MUTE_DEVICE);
+			wacom_wac->has_mute_touch_switch = true;
+		}
 		/* setup has already been done */
 		return 0;
 	}
-- 
2.55.0.979.g7e5102b832-goog

