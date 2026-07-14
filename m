Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42E14A3406
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044897; cv=none; b=Tx3EOY2oC7k+KjCbSJwXKxC6kG59gTpdD+5aMaOkXqrRbPfu552OWqFWN+xp4zVoLdMv8MGhH8yDRhEKfFu871o9JVkFvxpWyot8VpiSEs12nUYNizZMnUDeCjE6hhbNjIt7LRDoraaxWtnmRcuBQok/VrFRDwz/0ClXCv5TZCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044897; c=relaxed/simple;
	bh=/rmV0NyF2NmlETcLxpqtbkT5Y7jG9e26yux0BHuTYUI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FnusR+guFcuX8rQRbDJlX1Rk7wbwKpSfZW1ut7p4yf9LXK5MgD4MFcPFeCOkmhGdZNOHSAygJwwGHibnWLfDzzJn6tZLCzQ8wpCpVZr4nojY1CHr9LWEpcN6ZHJzX4lQM/fjZ4DMGiTeC++3fiIuuVS+dEqn7HTPNtwdjk4oDcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OSGt5O3/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OSGt5O3/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D9C1F000E9;
	Tue, 14 Jul 2026 16:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784044895;
	bh=LzwFt1pDJX2x+CSDo5AVrAGJ5BBxO+YhNlQp4MV3Xf4=;
	h=Subject:To:Cc:From:Date;
	b=OSGt5O3/GSElDEHS8pkI8i6h1nD4D4eAAB4o1MIixsC3mQc1RLOKYwB7O0GBdhWKZ
	 NC1TmsEsYgIJfB/fgSp5v+t9YGj0jJGzIBsXJWTYLCs9t0GjMUiLxdGnTFkLrX3uk1
	 KPbNjvvMxSl2HV/jUWVGJiXTSa0WMWOuq6c4AMec=
Subject: FAILED: patch "[PATCH] usb: atm: ueagle-atm: wait for pre-firmware load in" failed to apply to 6.18-stable tree
To: mfo@igalia.com,aitsygunka@yandex.ru,gregkh@linuxfoundation.org,stable@kernel.org,stf_xl@wp.pl
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 18:01:27 +0200
Message-ID: <2026071427-sulfate-await-a368@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x e2674dfbed8a30d57e2bc872c4bfa6c3eec918bf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071427-sulfate-await-a368@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e2674dfbed8a30d57e2bc872c4bfa6c3eec918bf Mon Sep 17 00:00:00 2001
From: Mauricio Faria de Oliveira <mfo@igalia.com>
Date: Tue, 26 May 2026 14:09:44 -0300
Subject: [PATCH] usb: atm: ueagle-atm: wait for pre-firmware load in
 .disconnect()

ueagle-atm uses the asynchronous request_firmware_nowait() in .probe(),
but does not wait for its completion, not even in .disconnect(); so, if the
device is unplugged meanwhile, its teardown runs concurrently with that.

Even though this inconsistency is worth addressing on its own, it has also
triggered several bug reports in syzbot over the years (some auto-closed)
where the firmware sysfs fallback mechanism (CONFIG_FW_LOADER_USER_HELPER)
creates a firmware subdirectory in the device directory during its removal,
which might hit unexpected conditions in kernfs, apparently, depending at
which point the add and remove operations raced. (See links.)

The pattern is:

usb ?-?: Direct firmware load for ueagle-atm/eagle?.fw failed with error -2
usb ?-?: Falling back to sysfs fallback for: ueagle-atm/eagle?.fw
<ERROR>
Call trace:
 ...
 kernfs_create_dir_ns
 sysfs_create_dir_ns
 create_dir
 kobject_add_internal
 kobject_add_varg
 kobject_add
 class_dir_create_and_add
 get_device_parent
 device_add
 fw_load_sysfs_fallback
 fw_load_from_user_helper
 firmware_fallback_sysfs
 _request_firmware
 request_firmware_work_func
 ...

(Some variations are observed, after fw_load_sysfs_fallback(), e.g., [1].)

While the kernfs side is being looked at, the ueagle-atm side can be fixed
by waiting for the pre-firmware load in the .disconnect() handler.

This change has a similar approach to previous work by Andrey Tsygunka [2]
(wait_for_completion() in .disconnect()), but it is relatively different in
design/implementation; using the Originally-by tag for credit assignment.

This has been tested with:
- synthetic reproducer to check the error path;
- USB gadget (virtual device) to check the firmware upload path;
- QEMU device emulator to check the device ID re-enumeration path;
(The latter two were written by Claude; no other code/text in this commit.)

Links (year first reported):
 2025 https://syzbot.org/bug?extid=ce1e5a1b4e086b43e56d
 2025 https://syzbot.org/bug?extid=9af8471255ac36e34fd4
 2024 https://syzbot.org/bug?extid=306212936b13e520679d
 2023 https://syzkaller.appspot.com/bug?extid=457452d30bcdda75ead2
 2022 https://syzbot.org/bug?extid=782984d6f1701b526edb
 2021 https://syzbot.org/bug?id=f3f221579f4ef7e9691281f3c6f56c05f83e8490
 2021 https://syzbot.org/bug?id=84d86f0d71394829df6fc53daf6642c045983881
 2021 https://syzbot.org/bug?id=3302dc1c0e2b9c94f2e8edb404eabc9267bc6f90

[1] https://syzkaller.appspot.com/bug?extid=457452d30bcdda75ead2
[2] https://lore.kernel.org/lkml/20250410093146.3776801-2-aitsygunka@yandex.ru/

Cc: stable <stable@kernel.org>
Reported-by: syzbot+ce1e5a1b4e086b43e56d@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=ce1e5a1b4e086b43e56d
Reported-by: syzbot+306212936b13e520679d@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=306212936b13e520679d
Reported-by: syzbot+457452d30bcdda75ead2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=457452d30bcdda75ead2
Originally-by: Andrey Tsygunka <aitsygunka@yandex.ru>
Fixes: b72458a80c75 ("[PATCH] USB: Eagle and ADI 930 usb adsl modem driver")
Assisted-by: Claude:claude-opus-4.7 # usb gadget & qemu device for testing
Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
Link: https://patch.msgid.link/20260526-ueagle-atm_req-fw-sync-v3-1-93c01961daaf@igalia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/atm/ueagle-atm.c b/drivers/usb/atm/ueagle-atm.c
index d610cdcef7d0..4e71ed679a76 100644
--- a/drivers/usb/atm/ueagle-atm.c
+++ b/drivers/usb/atm/ueagle-atm.c
@@ -594,7 +594,9 @@ static int uea_send_modem_cmd(struct usb_device *usb,
 static void uea_upload_pre_firmware(const struct firmware *fw_entry,
 								void *context)
 {
-	struct usb_device *usb = context;
+	struct usb_interface *intf = context;
+	struct usb_device *usb = interface_to_usbdev(intf);
+	struct completion *fw_done = usb_get_intfdata(intf);
 	const u8 *pfw;
 	u8 value;
 	u32 crc = 0;
@@ -663,15 +665,17 @@ static void uea_upload_pre_firmware(const struct firmware *fw_entry,
 	uea_err(usb, "firmware is corrupted\n");
 err:
 	release_firmware(fw_entry);
+	complete(fw_done);
 }
 
 /*
  * uea_load_firmware - Load usb firmware for pre-firmware devices.
  */
-static int uea_load_firmware(struct usb_device *usb, unsigned int ver)
+static int uea_load_firmware(struct usb_interface *intf, unsigned int ver)
 {
 	int ret;
 	char *fw_name = EAGLE_FIRMWARE;
+	struct usb_device *usb = interface_to_usbdev(intf);
 
 	uea_info(usb, "pre-firmware device, uploading firmware\n");
 
@@ -694,7 +698,7 @@ static int uea_load_firmware(struct usb_device *usb, unsigned int ver)
 	}
 
 	ret = request_firmware_nowait(THIS_MODULE, 1, fw_name, &usb->dev,
-					GFP_KERNEL, usb,
+					GFP_KERNEL, intf,
 					uea_upload_pre_firmware);
 	if (ret)
 		uea_err(usb, "firmware %s is not available\n", fw_name);
@@ -2555,8 +2559,23 @@ static int uea_probe(struct usb_interface *intf, const struct usb_device_id *id)
 
 	usb_reset_device(usb);
 
-	if (UEA_IS_PREFIRM(id))
-		return uea_load_firmware(usb, UEA_CHIP_VERSION(id));
+	if (UEA_IS_PREFIRM(id)) {
+		struct completion *fw_done;
+
+		/* Wait for the firmware load to be done, in .disconnect() */
+		fw_done = kzalloc_obj(*fw_done);
+		if (!fw_done)
+			return -ENOMEM;
+
+		init_completion(fw_done);
+		usb_set_intfdata(intf, fw_done);
+
+		ret = uea_load_firmware(intf, UEA_CHIP_VERSION(id));
+		if (ret)
+			kfree(fw_done);
+
+		return ret;
+	}
 
 	ret = usbatm_usb_probe(intf, id, &uea_usbatm_driver);
 	if (ret == 0) {
@@ -2586,6 +2605,13 @@ static void uea_disconnect(struct usb_interface *intf)
 		usbatm_usb_disconnect(intf);
 		mutex_unlock(&uea_mutex);
 		uea_info(usb, "ADSL device removed\n");
+	} else if (usb->config->desc.bNumInterfaces == 1) {
+		struct completion *fw_done = usb_get_intfdata(intf);
+
+		uea_dbg(usb, "pre-firmware device, waiting firmware upload\n");
+		wait_for_completion(fw_done);
+		uea_dbg(usb, "pre-firmware device, finished waiting\n");
+		kfree(fw_done);
 	}
 }
 

