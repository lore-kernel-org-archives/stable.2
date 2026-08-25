Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7363DD846
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787655503; cv=none; b=XhqJuhyhA34zaj/yhZDTpEk3Tn9ISakmcMOFzsLTQ3rKbcDOMPaeujbCDqyabUVg/32U4my8v8Wx9P1ZPKoCnLXl6bOXcNMASq4mjQw5FYHIav6CC7gQOPe0HQfHP/nLb258Wtt4ugcrk7Ci69uKA3VHJi3KU9Utn989gg0S3lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787655503; c=relaxed/simple;
	bh=SSI/uYoBIaD7DipW9NmgcR2bXv834gqC+/WJG7gdZlw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=icvsAIkne+epTb+wgkYotvzhdV2cggfS2dXNS/4/xsvM7FNENsr3qTJN7Ijxlmpm9tx9YgDhJYqqXQoQP9VGNDzPjdFUehGROyYvOHAovZFkhyj+4i+azwGDQ1gkCoRjutwZNRnbefGtf9WWt1BCu4g4W8DVEyRVe0T+yZ9TZWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ktlyo/IB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ktlyo/IB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9795D1F000E9;
	Tue, 25 Aug 2026 10:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787655501;
	bh=hMSrEvlN3f9ZnHVt8fLf5HbxsBtKitHowIWYOKt7Ud0=;
	h=Subject:To:Cc:From:Date;
	b=Ktlyo/IBkaFc3EAFpy7gAwUCHEOO/T705/v7oWr+qRk0JzRfVzswrt9dL2RXeg5Yw
	 ZYDc21cnQE2aq/xWYz1EqGcmHJAQKYUQVOZX/QCCCvC6RLhJRNFcy+R2l2YpTCzpuH
	 QkKUtixlPt3c5LR03cbPzKvTV13I5FjWw7LejTm8=
Subject: FAILED: patch "[PATCH] HID: magicmouse: re-enable multitouch after reset-resume" failed to apply to 6.1-stable tree
To: ckhordiasma@gmail.com,jkosina@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 25 Aug 2026 12:57:47 +0200
Message-ID: <2026082547-glove-frying-a57a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4253fe22b137c4ee68f36b707fdb1b44b191edc4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082547-glove-frying-a57a@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4253fe22b137c4ee68f36b707fdb1b44b191edc4 Mon Sep 17 00:00:00 2001
From: Christopher Kodama <ckhordiasma@gmail.com>
Date: Sat, 25 Jul 2026 16:34:46 -0400
Subject: [PATCH] HID: magicmouse: re-enable multitouch after reset-resume

When the Apple Magic Trackpad 2 (USB) is reset across a power transition
(e.g. resume from hibernation) it drops out of multitouch mode: it keeps
sending report ID 0x02 on its HID_TYPE_USBMOUSE interface, but the packet
shrinks from 21 to 8 bytes and the trackpad2 handler drops it (size < 12).
Clicks still work but pointer motion is lost until the device is re-plugged
or the driver reloaded.

Re-enable multitouch from .reset_resume via the workqueue.  Only
.reset_resume is needed; suspend-to-idle keeps the device powered and
retains multitouch.

Fixes: 87a2f10395c8 ("HID: magicmouse: Apple Magic Trackpad 2 USB-C driver support")
Cc: stable@vger.kernel.org
Assisted-by: Claude-Code:claude-opus-4-8
Signed-off-by: Christopher Kodama <ckhordiasma@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 7be01cb103d2..d637c0477379 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -1037,6 +1037,22 @@ static void magicmouse_remove(struct hid_device *hdev)
 	hid_hw_stop(hdev);
 }
 
+#ifdef CONFIG_PM
+static int magicmouse_reset_resume(struct hid_device *hdev)
+{
+	struct magicmouse_sc *msc = hid_get_drvdata(hdev);
+
+	/* The device drops out of multitouch mode on resume; re-send the
+	 * enable report.  Only the HID_TYPE_USBMOUSE interface accepts it, and
+	 * it must be deferred. Sending it inline here is too early.
+	 */
+	if (msc && hdev->type == HID_TYPE_USBMOUSE)
+		schedule_delayed_work(&msc->work, msecs_to_jiffies(500));
+
+	return 0;
+}
+#endif
+
 static const __u8 *magicmouse_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 					   unsigned int *rsize)
 {
@@ -1100,6 +1116,9 @@ static struct hid_driver magicmouse_driver = {
 	.event = magicmouse_event,
 	.input_mapping = magicmouse_input_mapping,
 	.input_configured = magicmouse_input_configured,
+#ifdef CONFIG_PM
+	.reset_resume = magicmouse_reset_resume,
+#endif
 };
 module_hid_driver(magicmouse_driver);
 

