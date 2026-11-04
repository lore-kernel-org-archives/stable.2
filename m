Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807919;
	b=oVpUyq8JzwNnetRlNJo5wYc0zIz3bQ8jsp1vIIs3tTBwzKvw3fRDBXioMKAOf7YL4b0r
	 oCjOosKlBbwOqeBwKHF7U9Sax58mdd9+tdh4gx5FEF72kdqdFQQHJXH1HrYhWOaEJTqxw
	 osbAm+Wa3Izpg/FtTvIfPMmBv7OhMt85Qwb6rrg2sk6/hWXFjVysKRw/8UrjM6Ie2iatV
	 /pj8W51i9dd5trYBmFJniPvdxTxWWp8RdLm248tA7kSsnXfP9+HRPPHOVQT9dAxalcwAV
	 GRxVdpSY3KEhf4kdyDMCRNpOABMFLdHjJXpG2L3thRnYw8jgwd5rWeEuAsWo+t669Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807919;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ikw83QtSDYuHWtpHM0kqvbJSEtS0HlrumxKRSq3iUeU=;
	b=rnHdZQ/vaOLtYhKbCmnY+t2khu2VLXHHHzOYDimPDIXcz8tbmuG/LiPSHsM4Fv6KvWLX
	 8pDZFdX69uzubAerLrkom8pjW0ebjh0IuG9TgPfkc1iVx4WHYHT6L6W4LRrnPrgHPX1Zb
	 w7qCvQVnYCXU4RrdqLPt2DPBPbzsB0n9oSl64p/jfHoO/mtxpnuIMbS9rkftFDvn0Z/UD
	 CGCgKzj325/IZnVKSVffkuWu6Kq7UDQoKA2ZbTTml4R3rc8esLXSsSzqwcAJmn/cIUx0J
	 b/nyZPt9LZ6U/7H9JTzQOYqfggg78yhX+ilRo8VNlcSrWV2Y9QBzySC5b/UvZA9ZOVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oiGFGArg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B24606D812
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oiGFGArg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605CE1F00A15;
	Wed,  4 Nov 2026 15:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793807918;
	bh=Ikw83QtSDYuHWtpHM0kqvbJSEtS0HlrumxKRSq3iUeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oiGFGArgnVu8VnRjG1KndG4uSvZ1A+cNs7NE34hknxQ5Jg6ut/jzVdOUN23t+6N+t
	 tp73X1L4yZmyeXEfw0TM63ZbFa2VAgcAYjWSKY+pJCWWezllsU4ifOk9a8kjn5Sakh
	 r34luf4YT9IINj/4yrF1MWLvyiIzLoBBijfV0dxUOSEt0+VPkOUpvikw+fRmrCwSd2
	 qIWBZFkD7+oAPus80M7MB77L7b0SSVfPl+wlIfHIEwpIaH/o9nM7BOyNKfxcyg6AwL
	 uqRHj8GfLLOD4xDEs+zxKGpu1Lo3gcvBnsg2C+Ui7t9s7TNDs9dBws/wCFf9XZjSRS
	 duf5w2Jsp1ngw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Ping Cheng <ping.cheng@wacom.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration
Date: Wed,  4 Nov 2026 10:58:37 -0500
Message-ID: <20261104155732.3922024-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110416-undertone-chatter-7d31@gregkh>
References: <2026110416-undertone-chatter-7d31@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lee Jones <lee@kernel.org>

[ Upstream commit ba16e5ffbaa10fde960918d69af5e49f2b3fdd5e ]

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
Acked-by: Ping Cheng <ping.cheng@wacom.com>
Tested-by: Ping Cheng <ping.cheng@wacom.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
[ sashal: retained devm_add_action() with explicit failure cleanup instead of devm_add_action_or_reset() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/wacom_sys.c | 88 ++++++++++++++++++++++++++++++++++-------
 drivers/hid/wacom_wac.c |  5 +++
 2 files changed, 78 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index b5e6605a83753..4588bb153a93a 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -902,6 +902,9 @@ static int wacom_add_shared_data(struct hid_device *hdev)
 
 	wacom_wac->shared = &data->shared;
 
+	if (wacom_wac->has_mute_touch_switch)
+		WRITE_ONCE(wacom_wac->shared->has_mute_touch_switch, true);
+
 	retval = devm_add_action(&hdev->dev, wacom_remove_shared_data, wacom);
 	if (retval) {
 		mutex_unlock(&wacom_udev_list_lock);
@@ -909,11 +912,6 @@ static int wacom_add_shared_data(struct hid_device *hdev)
 		return retval;
 	}
 
-	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)
-		wacom_wac->shared->touch = hdev;
-	else if (wacom_wac->features.device_type & WACOM_DEVICETYPE_PEN)
-		wacom_wac->shared->pen = hdev;
-
 out:
 	mutex_unlock(&wacom_udev_list_lock);
 	return retval;
@@ -2314,13 +2312,12 @@ static void wacom_release_resources(struct wacom *wacom)
 
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
@@ -2330,12 +2327,67 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
 			WRITE_ONCE(wacom_wac->shared->is_touch_on, true);
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
+	}
+}
+
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
 	}
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
 }
 
 static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
@@ -2411,6 +2463,11 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 	if (error)
 		goto fail;
 
+	if (wacom_sibling_pending(wacom)) {
+		error = -EPROBE_DEFER;
+		goto fail;
+	}
+
 	if (!(features->device_type & WACOM_DEVICETYPE_WL_MONITOR) &&
 	     (features->quirks & WACOM_QUIRK_BATTERY)) {
 		error = wacom_initialize_battery(wacom);
@@ -2475,6 +2532,7 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 
 fail_hw_stop:
 	hid_hw_stop(hdev);
+	cancel_delayed_work_sync(&wacom->init_work);
 fail:
 	wacom_release_resources(wacom);
 	return error;
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 96164a97ff9cd..b1fd91aa5e370 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3912,6 +3912,11 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 
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
2.53.0

