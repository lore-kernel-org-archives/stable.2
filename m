Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799807;
	b=t/0hVMB3SnwSK4BAk0Q41SiV72JklU+DRbnhX4okWU8eA8B4OJE+jyvAxVxHwtX542eJ
	 IqcO9t0fipF7vVBKVidYDiRxv0/5ySDA4XpERUcy7HWZiYfiXbtPH++5Lcf7t/10SHJxF
	 v7IhPqxbSr0PucqBzMygMHDWHhKoyLd49+DYqlvFI29l5syLfbdKhcsZnLyPMAAIHQVPk
	 hXPbRJHyQN/13/CWP8LAkpB6suGM+JBkDbv97/J+d2MxRvYiZ9VjWB06GJknuVzW3PLBo
	 7/9BCyBtZ0kjUONzfroAg1/mbZ7653L4TvGsUTgPs1uDZIzk0bVGjQDAf0ClJMkVySg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799807;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=th7+/8JMjBLqdfX/d7qF4LVOUDJ2kRUW4Q1JesRR9lI=;
	b=r+DrTeX+H9Nn+cN3VVWTT7Ta42TEfOygq4S/FLtH+H+LfWo9Hd6y3frkO2t9Ldv44VZ6
	 AJmrDhPPwM38PztixQqbCohCHSJqnoBvi/qrhWV5KBKqnIhGbHo8YmTIGeowZhLiema+8
	 WI9KWUASBvSsO7AF3QB76hfFGmwMa0Yy/tuvL+Cw9GqhnhNI7Ou3u/pGnFr1AcocUvW1X
	 vLz2mjGG8u3LaZVJLMBG+2OdWoA+8JXXvCQcKMrU6efpRxX6QWRP19eSpucC5O/XMWm8V
	 QUewpz+c8VZF9NYYKz1MeozO+VJ6Kjn8p0mdkgJi+r5ZY11gIc5rq9xlrcBkQNLkGkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Io5OgXM4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F272606A32C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Io5OgXM4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E9E1F00A15;
	Wed,  4 Nov 2026 13:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793799807;
	bh=th7+/8JMjBLqdfX/d7qF4LVOUDJ2kRUW4Q1JesRR9lI=;
	h=Subject:To:Cc:From:Date;
	b=Io5OgXM4Qgn6Ss1e+h+vuDxG2SrEoksE4TG346Qxi3AvIhr1PP6BsD08AOd427fZG
	 +R0aF1irkLtXW7KhhTBgF6uRtI4mzkx9eYB5czHXgmxkekUvSEmovZVqW3jKg2R7oy
	 SbxBY8MJiBMNrwv58b0V3KWq/S8KQ3ptdwQBpdVo=
Subject: FAILED: patch "[PATCH] HID: wacom: Advertise SW_MUTE_DEVICE capability prior to" failed to apply to 5.10-stable tree
To: lee@kernel.org,jkosina@suse.com,ping.cheng@wacom.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:43:17 +0100
Message-ID: <2026110416-starch-strongman-324e@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ba16e5ffbaa10fde960918d69af5e49f2b3fdd5e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110416-starch-strongman-324e@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ba16e5ffbaa10fde960918d69af5e49f2b3fdd5e Mon Sep 17 00:00:00 2001
From: Lee Jones <lee@kernel.org>
Date: Wed, 9 Sep 2026 11:12:24 +0000
Subject: [PATCH] HID: wacom: Advertise SW_MUTE_DEVICE capability prior to
 registration

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

