Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FD949F11B;
	Wed,  2 Sep 2026 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356676; cv=none; b=hAv3nCexhPKY2dmZv2XCzMTDlQJd90pQQVdAa99xU4LuF9m63wRvU6zx7sm0VGFESbOfSkKF8hDZmI61zZkA7V/j3ETu8r0TbIOMLhK9wO9iwMSziNRKyqB5RFbHYHIGejyb9NQLd1FWdgjX4MvxwXIq8Pr9r7lWsKtAgl8rUwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356676; c=relaxed/simple;
	bh=LRQiK94eyA8sRLnAkw9zv/xqjE64B6mWovxXyYiJaYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqCLbnjL4WFId9dWescMgSj2oNSlhPI3URFjjcpiFPX9Je2z8v0db3lE/vd7lL1croT2mWTgA1pjOb7LWu3lkKoT+gAdv9NyjZ6DNK0at589h3WIztay8PyE6UnfNNtFvHIKWb4pbkPPTzFwaEahc0O1izYIIm09OHT/FU4JA6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzyEZq3x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzyEZq3x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4961F00A3A;
	Wed,  2 Sep 2026 13:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788356673;
	bh=eP4YMrTyr2L+9kIR7ZL7xFr3rydAQhi8hs9whJ+YNkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CzyEZq3xASCu51eF+3MI/jp0XH19wboWO8lwZS4vkDuEUDwi8ahShVAVB895gT3l3
	 NqmS3+e3RYk9Sm0pjFDc1LknPJE3gakFNyOcoFDe53hXvMMQCofOEsxmSIBzqpgR8X
	 N5vxsRoCDqohY6k6tivvixpxfjWpmA8vaUmgpYGpPyGGHbBxjX/S5SgG7XwFE0UDml
	 IaEhqZPq2LxKNNOtp2zBBo4EnBuC1Rwdf7D71vTk0O3sB8OJGaFefPjd0szTluz7Ne
	 7ogL6PiuRJIm9C7g2/K/9cv6gs5tlIp4GiMdmEd0I8eEOlJBG/5uQUH+YwiBxvTkRM
	 PWKVhdOvs5qTA==
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
Subject: [PATCH v9 2/5] HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration
Date: Wed,  2 Sep 2026 13:44:02 +0000
Message-ID: <20260902134417.1270552-2-lee@kernel.org>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
In-Reply-To: <20260902134417.1270552-1-lee@kernel.org>
References: <20260902134417.1270552-1-lee@kernel.org>
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

v4 -> v5: New patch used to split out SW_MUTE_DEVICE as per Jason's request
v5 -> v6: Unconditionally advertise SW_MUTE_DEVICE on generic touch devices
v6 -> v7: Only advertise SW_MUTE_DEVICE on composite USB generic touch devices
v7 -> v8: Replace heuristic with probe deferral until sibling Pen/Pad is parsed
          Split out 'hdev->product' cleanups into a separate standalone patch
v8 -> v9: Fix TOCTOU race by assigning shared sibling pointers in wacom_set_shared_values()
          Support Pad interfaces in sibling deferral logic

 drivers/hid/wacom_sys.c | 68 ++++++++++++++++++++++++++++++-----------
 drivers/hid/wacom_wac.c |  4 +++
 2 files changed, 55 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 0eafa483b7f7..026a6be467d3 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -912,14 +912,6 @@ static int wacom_add_shared_data(struct hid_device *hdev)
 	wacom_wac->shared = &data->shared;
 
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
 
@@ -2343,10 +2335,7 @@ static void wacom_release_resources(struct wacom *wacom)
 
 static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
 {
-	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {
-		wacom_wac->shared->type = wacom_wac->features.type;
-		wacom_wac->shared->touch_input = wacom_wac->touch_input;
-	}
+	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
 
 	if (wacom_wac->has_mute_touch_switch) {
 		wacom_wac->shared->has_mute_touch_switch = true;
@@ -2359,14 +2348,54 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
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
+	} else if (wacom_wac->features.device_type &
+		   (WACOM_DEVICETYPE_PEN | WACOM_DEVICETYPE_PAD)) {
+		wacom_wac->shared->pen = wacom->hdev;
 	}
 }
 
+static bool wacom_sibling_pending(struct wacom *wacom)
+{
+	struct hid_device *hdev = wacom->hdev;
+	const struct wacom_features *features = &wacom->wacom_wac.features;
+	struct usb_host_config *actconfig;
+	int i;
+
+	if (features->type != HID_GENERIC ||
+	    !(features->device_type & WACOM_DEVICETYPE_TOUCH))
+		return false;
+
+	if (wacom->wacom_wac.shared &&
+	    rcu_access_pointer(wacom->wacom_wac.shared->pen))
+		return false;
+
+	if (!hid_is_usb(hdev) || !wacom->usbdev)
+		return false;
+
+	if (features->oPid != HID_ANY_ID && features->oPid != 0)
+		return true;
+
+	actconfig = wacom->usbdev->actconfig;
+	if (actconfig && actconfig->desc.bNumInterfaces > 1) {
+		for (i = 0; i < actconfig->desc.bNumInterfaces; i++) {
+			struct usb_interface *sibling_intf = actconfig->interface[i];
+
+			if (!sibling_intf || sibling_intf == wacom->intf)
+				continue;
+
+			if (sibling_intf->cur_altsetting->desc.bInterfaceClass ==
+			    USB_INTERFACE_CLASS_HID)
+				return true;
+		}
+	}
+
+	return false;
+}
+
 static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 {
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
@@ -2444,6 +2473,11 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
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
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 4436faf2d2bb..a7e3817aa2c4 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3965,6 +3965,10 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 
 	if (features->type == HID_GENERIC) {
 		hid_dbg(hdev, "generic touch setup\n");
+		if (wacom_wac->shared && wacom_wac->shared->has_mute_touch_switch) {
+			input_set_capability(input_dev, EV_SW, SW_MUTE_DEVICE);
+			wacom_wac->has_mute_touch_switch = true;
+		}
 		/* setup has already been done */
 		return 0;
 	}
-- 
2.55.0.966.g6673acef38-goog

