Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231557;
	b=dETTKMw50n0Z//fgBMRWGmaP6IGyaHNsPznI0/TGPda7O8QW81zt8WLTWCg1QzSEwejt
	 n7g4YkFAggpFZCfdiPd116lEMdl83iFF6xj8Z8R22+ZGItGPjrYh/IP6HbjhqjdcktauO
	 5dCisxsqU93ggqeWhKY4n5dZ45DQLEB2bxQF/agSHC5xVEv2wvl15JKyDRjcAzt/Een7f
	 8oBGCc+b03SfUvvMj75kM5vVeePqCRU3ELP4ZIShTGuhbzKiEKTD6xBLN1mPMQI3BflVT
	 LXKiSbgLacW1aFA7ItMSxp6IKiteLfC87JpyudRGSL26/tn08EuGiW6BCfeaa5YmUsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231557;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HEBV1anMn1x6YBVCqg8AbZeiCX3KVIogYwj3J+og3T8=;
	b=vw0YMB4uTloaUt+mc4VD6mXWhR10AG7Gvd7+tebsk2HDgnLlQMqD58dm8KG01edZ1zwp
	 S2XGnEhfEaXsNfFaPgqv2e9jE3qnW5mkRKF5a4dDwrhiBkMJ3cxW2Ftld6WCpKg7b8ann
	 uq+XjxW5dNyLi4m0Gdmb96DzLpudfmkBVdHQ6bvCOIeO6pkO8iWLUPWv17Z3yLdOca89X
	 bAFaMyAVabT9boAt9jhtmoauAQFISISDvg9WEfiNg3kCuGXVHHGPNCcihOCbBmwZ/SXwn
	 leTe+CRGAP3gWoGHdVHQBb97Bw7/CCPYom4HpCDutCQVB5wDzQnI9FNQe5WfxPRGr3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=flw0ucz4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAB4606A321;
	Mon,  9 Nov 2026 13:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=flw0ucz4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47F91F008A1;
	Mon,  9 Nov 2026 13:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794231557;
	bh=HEBV1anMn1x6YBVCqg8AbZeiCX3KVIogYwj3J+og3T8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=flw0ucz4p0RW3uKykRjf+sL8Z4V/nB3JZi6e/JMlwKL4R8QXH7N9K7Hivi6X7upMX
	 XCPdY4Ub5e0MISOFWOcGMpHOFrINDq97IHF49VBcjFwlUUqk7LUUGFYDiT/NoyJOkc
	 Ok/KDvbLhCU0CFWVszVpgR9Hy5X42cyNncBRRCye0msJLM/pJL2i9Eg8tmbpm5ddU0
	 JlC2VG4y9Cis0UoQmSacv67DYsBvLMpO1t3vVfb3ReAd6YuKrOMHa1LqDFYAkZBMlU
	 LsfZXXS7XtyOVUPocdwGuxVv6b0wVcVy+rU9P+BfLbRTzzlOgn0QqUpU5C1TN6gi+s
	 0No7XscfgKm2A==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Aaron Skomra <aaron.skomra@wacom.com>,
	Ping Cheng <ping.cheng@wacom.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Jiri Kosina <jkosina@suse.com>
Subject: [STABLE v5.10 1/5] HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration
Date: Mon,  9 Nov 2026 13:39:02 +0000
Message-ID: <20261109133911.3026622-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109133911.3026622-1-lee@kernel.org>
References: <20261109133911.3026622-1-lee@kernel.org>
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
[Lee: Retain devm_add_action() error handling and adapt context around
      is_soft_touch_switch and wacom_initialize_battery()]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/wacom_sys.c | 86 ++++++++++++++++++++++++++++++++++-------
 drivers/hid/wacom_wac.c |  5 +++
 2 files changed, 77 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index f418efa868ee..e5d12683f578 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -924,6 +924,9 @@ static int wacom_add_shared_data(struct hid_device *hdev)
 
 	wacom_wac->shared = &data->shared;
 
+	if (wacom_wac->has_mute_touch_switch)
+		WRITE_ONCE(wacom_wac->shared->has_mute_touch_switch, true);
+
 	retval = devm_add_action(&hdev->dev, wacom_remove_shared_data, wacom);
 	if (retval) {
 		mutex_unlock(&wacom_udev_list_lock);
@@ -931,11 +934,6 @@ static int wacom_add_shared_data(struct hid_device *hdev)
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
@@ -2336,22 +2334,76 @@ static void wacom_release_resources(struct wacom *wacom)
 
 static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
 {
+	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
+
+	guard(mutex)(&wacom_udev_list_lock);
+
+	if (wacom_wac->has_mute_touch_switch) {
+		WRITE_ONCE(wacom_wac->shared->has_mute_touch_switch, true);
+		wacom_wac->shared->is_touch_on = true;
+	}
+
 	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {
 		wacom_wac->shared->type = wacom_wac->features.type;
 		wacom_wac->shared->touch_input = wacom_wac->touch_input;
+		wacom_wac->shared->touch = wacom->hdev;
+	} else if (wacom_wac->features.device_type & WACOM_DEVICETYPE_PEN) {
+		/* Pairs with smp_load_acquire() in wacom_sibling_pending() */
+		smp_store_release(&wacom_wac->shared->pen, wacom->hdev);
 	}
+}
 
-	if (wacom_wac->has_mute_touch_switch) {
-		wacom_wac->shared->has_mute_touch_switch = true;
-		wacom_wac->shared->is_touch_on = true;
-	}
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
 
-	if (wacom_wac->shared->has_mute_touch_switch &&
-	    wacom_wac->shared->touch_input) {
-		set_bit(EV_SW, wacom_wac->shared->touch_input->evbit);
-		input_set_capability(wacom_wac->shared->touch_input, EV_SW,
-				     SW_MUTE_DEVICE);
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
@@ -2427,6 +2479,11 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
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
@@ -2491,6 +2548,7 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 
 fail_hw_stop:
 	hid_hw_stop(hdev);
+	cancel_delayed_work_sync(&wacom->init_work);
 fail:
 	wacom_release_resources(wacom);
 	return error;
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index f74da953d78f..8804bc2cba32 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3882,6 +3882,11 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 
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
2.56.0.506.g506a7eabc5-goog

