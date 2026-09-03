Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0874A5EAA
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440095; cv=none; b=KUDt7j4z4sc3j60uoAydBJuaBl78IjNqNY40+r7kRIbQNIazt9DnDr7tO38Q4xTEUGdb4OU5bglg/bRXiDrzTGij5stMBMKelYmc01Mme9gFoimoBGIXYVbqmRPMBM798zPz2KO+p99ydfsUeUeUtKlPLqcVBlfE6j45PYOuMok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440095; c=relaxed/simple;
	bh=8TJGYUs5/EsTTxJWFatcb/UE+0S6M3E5d8jV/7tQ6eQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ivxaeywXBNOHp7RyspsAVmFb1J9ewy/VloDrdR4BeoOHZZIK6IY2DvydjiPl6LPJ9EEYphhsCJYXIhs/ATn8PjfUfaAsnt4bg2CN243CeV/85QVYDiuyll3XkSbBl6Aw6MBvkjZn5BHo6Nl1T8bLKx2HHhiQS2cYk52DcTjfyZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ck+QkYOm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ck+QkYOm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D131F00A3A;
	Thu,  3 Sep 2026 12:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788440094;
	bh=qJshW6/1fTkjJpx4UmSeRIdMLJFUo5W5dxxHjcgBrQk=;
	h=Subject:To:Cc:From:Date;
	b=ck+QkYOmR52paR5i/Y3fRBGVSFWK7J8jsYze9v//NuYs6F0UIz/lvGMiXKDt2t15G
	 v/pSu786FVetsca63oCVJglCu0oWccoBQtKFZ8Fv0aFi83qQnl0rPxtI8YVtIvie+8
	 krKS/DCyRNo6VdKGyLH2zdb2OJ/KsJUNXIV+03bU=
Subject: FAILED: patch "[PATCH] usb: dwc2: gadget: Exit partial power down state when" failed to apply to 5.10-stable tree
To: flavra@baylibre.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 14:38:59 +0200
Message-ID: <2026090359-explicit-driveway-3cc2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x bf1e90189a98ca4a824fd64b4f3c6043d13c98ea
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090359-explicit-driveway-3cc2@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bf1e90189a98ca4a824fd64b4f3c6043d13c98ea Mon Sep 17 00:00:00 2001
From: Francesco Lavra <flavra@baylibre.com>
Date: Tue, 28 Jul 2026 17:44:20 +0200
Subject: [PATCH] usb: dwc2: gadget: Exit partial power down state when
 changing USB pull-up

When a USB host suspends a connected device, the DWC2 USB device controller
enters a partial power down state where controller registers are not
accessible. If the USB gadget is then disconnected or deactivated
(e.g. when a gadget function is unbound from the controller), the `pullup`
callback in struct usb_gadget_ops is invoked; if the controller is kept in
partial power down, the register write in dwc2_hsotg_core_disconnect() does
not take effect; as a result, the USB host keeps seeing the device as
connected, even though the device is disabled.

Properly exit partial power down state in the pullup callback, so that the
USB host detects a device disconnection as intended.

Fixes: 97861781daff ("usb: dwc2: Allow entering hibernation from USB_SUSPEND interrupt")
Cc: stable@vger.kernel.org
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Link: https://patch.msgid.link/20260728154420.2021519-1-flavra@baylibre.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index c8b02c27d27d..102169b40419 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -4680,6 +4680,7 @@ static int dwc2_hsotg_pullup(struct usb_gadget *gadget, int is_on)
 {
 	struct dwc2_hsotg *hsotg = to_hsotg(gadget);
 	unsigned long flags;
+	int ret = 0;
 
 	dev_dbg(hsotg->dev, "%s: is_on: %d op_state: %d\n", __func__, is_on,
 		hsotg->op_state);
@@ -4691,6 +4692,13 @@ static int dwc2_hsotg_pullup(struct usb_gadget *gadget, int is_on)
 	}
 
 	spin_lock_irqsave(&hsotg->lock, flags);
+	if (hsotg->in_ppd) {
+		ret = dwc2_exit_partial_power_down(hsotg, 0, true);
+		if (ret) {
+			dev_err(hsotg->dev, "exit partial_power_down failed\n");
+			goto exit;
+		}
+	}
 	if (is_on) {
 		hsotg->enabled = 1;
 		dwc2_hsotg_core_init_disconnected(hsotg, false);
@@ -4704,9 +4712,10 @@ static int dwc2_hsotg_pullup(struct usb_gadget *gadget, int is_on)
 	}
 
 	hsotg->gadget.speed = USB_SPEED_UNKNOWN;
+exit:
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 
-	return 0;
+	return ret;
 }
 
 static int dwc2_hsotg_vbus_session(struct usb_gadget *gadget, int is_active)

