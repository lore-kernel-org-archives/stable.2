Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821048;
	b=uNyWsz/srLZD3yJ6GrawvM5Pkr+FZVAIkSlDYH+1SrUV4CV7Pu63i9+Y7NQ+e6Wi+Bv2
	 YByLQWER9JopI/ZYf545Cl+nxYbjm/XScX+eV2ZUy8IhZ63PUQo2SS8kRU5QC4N8t1qry
	 DsjcYLb0L4JsxU/dyZ0a0PLBAKL9RijMkoAuTf2n48sg8S7SzoJSlHUIV8jnF1rDyZvmD
	 nzlmhB2Z7Zp8Utjdijpl9rzz57e9WXHoUFlAmtrFKbuLiJ6GeGWo6yl2SgNa0OedHaaxA
	 5Fhesc6belw+EREKcst3YEOzKMPgZ5RTRoIslykzMqDcBmCP1IyocbnDoSOtftQjIxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821048;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=V7fzBpJw/3e4vWRbjufwgzefTwGo41Nzj8xonsSzp2Q=;
	b=ioO1WruvuaAQ7uFDEKbzfnP6gtk4Uf1Y/sZYU9+gS9csTuP6t55CfNzRirJ1AMQkopPp
	 rPdcdrF3QOHjNNCmzgYHS+h03mpZY547KnPVsIuIyihenoxlq7INsRniBchx3k4eDkVou
	 /0XEGh9EPM+4WNDZKkB7rb+DhGesVxvb3JT+BFjC2waRQk3jOQH6cafpFmhKIgwvPzR3p
	 Spl1odj7SBGldTFg7Y342qteHp/+scyFadveZFcSXCKaJG58VbeFnmoYMGw2KjYwAtWa3
	 FUZ+PAjxzo3TuZxsuU0eYrdEy8lDcXOKDp5URMuM74KgMy+/HVrRHd1sie+rdXMeJHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oc5+2+XL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BE2607E728
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oc5+2+XL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13351F0093A;
	Wed,  4 Nov 2026 19:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821047;
	bh=V7fzBpJw/3e4vWRbjufwgzefTwGo41Nzj8xonsSzp2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oc5+2+XL8AWF7JMi+8U4+3rjPDd8ssU6e0PYGljcFUY+I/zbcr3G5LEWNA53gJbin
	 EibXF3zID6YMgiOpED6d7BZrDOn5uIuQJROzL2oMQosN/WiQjATom/4mnIkr7EMscW
	 zYKYfYCBlLaVcN3mU1sE2bZz1oRVnFz/JgV3kplZVNZiXCvdFRv80cV55bxwtruYi0
	 4ANB/HRFtlzMKg3ElMtDZm/jDSu4s3BS9WC8HADQUPujBJvyc52nW+jwI5ONL8knTh
	 RdvTPJuyGDOIzmDqeDas//e5X2IOIE3CEQRtfT0ylbWypzbQ3J9j1uFnjI9iRUMj2R
	 di5lsyOubWDaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Ping Cheng <ping.cheng@wacom.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration
Date: Wed,  4 Nov 2026 14:37:25 -0500
Message-ID: <20261104193645.3973605-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110416-starch-strongman-324e@gregkh>
References: <2026110416-starch-strongman-324e@gregkh>
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
[ sashal: used has_mute_touch_switch instead of the missing is_soft_touch_switch to initialize is_touch_on ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/wacom_sys.c | 86 ++++++++++++++++++++++++++++++++++-------
 drivers/hid/wacom_wac.c |  5 +++
 2 files changed, 77 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 374719d28f9e5..b6f379650ae22 100644
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
@@ -2314,22 +2312,76 @@ static void wacom_release_resources(struct wacom *wacom)
 
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
 
-	if (wacom_wac->shared->has_mute_touch_switch &&
-	    wacom_wac->shared->touch_input) {
-		set_bit(EV_SW, wacom_wac->shared->touch_input->evbit);
-		input_set_capability(wacom_wac->shared->touch_input, EV_SW,
-				     SW_MUTE_DEVICE);
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
@@ -2405,6 +2457,11 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
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
@@ -2469,6 +2526,7 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 
 fail_hw_stop:
 	hid_hw_stop(hdev);
+	cancel_delayed_work_sync(&wacom->init_work);
 fail:
 	wacom_release_resources(wacom);
 	return error;
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index f74da953d78f2..8804bc2cba32d 100644
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
2.53.0

