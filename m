Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C114B1B20
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443385; cv=none; b=fFHyHs0LJAm0hB7i7lpL6+dMGMGeA5onsTpYwISqHJHv4cPdjXMg1PL/jyHImiY5R93RXLuwtcDKGMshp92bJq1pjJ1qPxJyP9TaldWfPCiUH8RgmcMPT2vUrBTLfTxuECtUnr0reBdURJHm/1ls+Bw1ynOk+7ZjEd4L6UkSGKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443385; c=relaxed/simple;
	bh=MZbklynLLoiCqKsvi1wdZeGp9EMLYsZlvXEA3p3H0bA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RnLehN7En8c4IORkURGDGQjTVvXgqNhjNXHHDQoi5rTYM+86AH9n1Ihq6EIaScjXWjq8R4ghHoQnelVYqWF6BnILmYUsaKZyd032Jp5sq8H03IiMAcnFgacWWGVOU8Mbej9wArxGY84uln7+MG8+OMAD0/xTdSNo5icLSFgYLb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v6uSsk/n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v6uSsk/n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812DB1F00A3F;
	Thu,  3 Sep 2026 13:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443373;
	bh=tfjyASo6D4tGioyLaSgkzK7MKg9fi3SIqCFNJFTsXZ4=;
	h=Subject:To:Cc:From:Date;
	b=v6uSsk/nWh642+4OZPHsJqKplnWLPhJBauwid88bqqXW2p9tvMKumQd70FlMXOo1o
	 k6eWSGzRUnhc2rnQ4gyUU6SkrbgpQTKyJXnJ8qn6aAJyH2Dlud1sWXy2WJrrqK+IIu
	 0j+xnsiop66IhcoSsAZK8t/vAFRk0gHeeZRFBM00=
Subject: FAILED: patch "[PATCH] HID: apple: preserve keyboard backlight across T2 resume" failed to apply to 6.12-stable tree
To: dev@deq.rocks,jkosina@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:27:53 +0200
Message-ID: <2026090353-legal-vanish-db81@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 2b5d1495bd101f3d9c13caf3923754f48ee7371a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090353-legal-vanish-db81@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2b5d1495bd101f3d9c13caf3923754f48ee7371a Mon Sep 17 00:00:00 2001
From: Andre Eikmeyer <dev@deq.rocks>
Date: Sat, 18 Jul 2026 14:15:26 +0200
Subject: [PATCH] HID: apple: preserve keyboard backlight across T2 resume

The T2 virtual USB host controller re-enumerates the internal keyboard
after system resume. The butterfly keyboard backlight currently uses
LED_CORE_SUSPENDRESUME, so the LED core sends a blocking request to the
old HID device while it is disappearing. That request fails with -ENODEV
and the newly probed device starts with its backlight off.

To fix this, we cache the requested brightness when the old HID device is
removed and restore it when the replacement is probed. We let
re-enumeration handle restoration instead of issuing a request through the
stale device.

Fixes: 1f95a6cd5ad7 ("HID: apple: ensure the keyboard backlight is off if suspending")
Cc: stable@vger.kernel.org
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Jiri Kosina <jkosina@suse.com>

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index bf7dd0fbf249..a5f232cc2b66 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -91,6 +91,9 @@ struct apple_sc_backlight {
 	struct hid_device *hdev;
 };
 
+/* T2 VHCI re-enumerates the internal keyboard across system resume. */
+static int apple_backlight_resume_brightness = -1;
+
 struct apple_backlight_config_report {
 	u8 report_id;
 	u8 version;
@@ -825,6 +828,7 @@ static int apple_backlight_led_set(struct led_classdev *led_cdev,
 static int apple_backlight_init(struct hid_device *hdev)
 {
 	int ret;
+	int brightness;
 	struct apple_sc *asc = hid_get_drvdata(hdev);
 	struct apple_backlight_config_report *rep;
 
@@ -860,13 +864,20 @@ static int apple_backlight_init(struct hid_device *hdev)
 	asc->backlight->cdev.name = "apple::kbd_backlight";
 	asc->backlight->cdev.max_brightness = rep->backlight_on_max;
 	asc->backlight->cdev.brightness_set_blocking = apple_backlight_led_set;
-	asc->backlight->cdev.flags = LED_CORE_SUSPENDRESUME;
+	/* VHCI re-enumeration restores the cached brightness in the next probe. */
 
-	ret = apple_backlight_set(hdev, 0, 0);
+	brightness = READ_ONCE(apple_backlight_resume_brightness);
+	if (brightness < 0)
+		brightness = LED_OFF;
+	else
+		brightness = min_t(int, brightness, rep->backlight_on_max);
+
+	ret = apple_backlight_set(hdev, brightness, 0);
 	if (ret < 0) {
 		hid_err(hdev, "backlight set request failed: %d\n", ret);
 		goto cleanup_and_exit;
 	}
+	asc->backlight->cdev.brightness = brightness;
 
 	ret = devm_led_classdev_register(&hdev->dev, &asc->backlight->cdev);
 
@@ -999,6 +1010,9 @@ static void apple_remove(struct hid_device *hdev)
 
 	if (asc->quirks & APPLE_RDESC_BATTERY)
 		timer_delete_sync(&asc->battery_timer);
+	if (asc->backlight)
+		WRITE_ONCE(apple_backlight_resume_brightness,
+			   asc->backlight->cdev.brightness);
 
 	hid_hw_stop(hdev);
 }

