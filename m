Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799868;
	b=LsOqWaQr7AFf0DyuE/QDGj8BkhBlPb2oGxyXf2zqiygjcZn/ktjQpHANBh7fYeFXKiBz
	 f6iwW6A0DEtb71d1ehhMrDqTQBzbuwlcNa85wIrR33B0bJBPO40/h0Qhhg5una4OFLvRJ
	 KDepgaFNMBah/8Qg+U5Y2IcgJYBdYPGC4Xo/xfZuIis0tEfBFtsUfVRY6ku4/EeeMUjmy
	 8Hv25NC4UWLE1oWaB+mNGexTbNwVJRMfta7+k9cMZgls9XqHIpJl0VJFonorpFdf+/p88
	 P8cHq3IFuWkbXOvWC03lNbTBz+/sge/g8B3dr9b1VDvcAebyEaTophUe5U3UecqvHSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799868;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8ytfRyGTmhnnzH9ExO6ygvycgbCQYFU3kULDcrG2nQw=;
	b=f7aFqLIw5Fl32cd3yU8NB6OBbKSeXSjy9rdc3KSjd6KR+LAizP1gVzRFe3hnqABegWC9
	 wPqCNOpNYapSUU4AGOE+D8ia0eX4X/K1dkBMbEiEpTDlu6vn7uigCeYgqiVweGBuKCesm
	 rBn1Qw4EB+oqED7iTgiGzKqBS/2+uxrLqCHldpJ2rFaujZQCAFblc///Z30uxNm6X8HVO
	 v2KFM9GirLJPaSpwWARCdNCysF4Le17rG3BnL3sbOKCt8fWo+TVGlE0H/teglT6sKsD6g
	 ZpyU7SFXTjWNjXhFC79j86naOhJEj/zgTyg/AlQZfJkZwk2wJfYEQqemdJXe7az5DXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zQeIa3h1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F43A606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zQeIa3h1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20851F000C1;
	Wed,  4 Nov 2026 13:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793799867;
	bh=8ytfRyGTmhnnzH9ExO6ygvycgbCQYFU3kULDcrG2nQw=;
	h=Subject:To:Cc:From:Date;
	b=zQeIa3h12J4FDfP+mtalLQPh1TVfSHRpG6Q1v1svC0hOB+tOwC4b9U19QgFoyY7W3
	 PZfhBVgnhc+fRfG5cFxW5vAOdUzHsIsLOQibe9xRemEve65VNvyEP7L3tQPLDDR9Jb
	 7JtORrRsIK+mC4Ei0WD9lebQOsjiWYWPf7m/U9oI=
Subject: FAILED: patch "[PATCH] HID: wacom: Setup SW_MUTE_DEVICE according to the order of" failed to apply to 5.15-stable tree
To: ping.cheng@wacom.com,jkosina@suse.com,lee@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:44:26 +0100
Message-ID: <2026110426-recite-mullets-f0cd@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 97ce491bcef2d231b8d51cee8e579183319a5ba4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110426-recite-mullets-f0cd@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 97ce491bcef2d231b8d51cee8e579183319a5ba4 Mon Sep 17 00:00:00 2001
From: Ping Cheng <ping.cheng@wacom.com>
Date: Wed, 7 Oct 2026 15:03:35 -0700
Subject: [PATCH] HID: wacom: Setup SW_MUTE_DEVICE according to the order of
 input registration

The refactored SW_MUTE_DEVICE code assumed that stylus will be
the first regiestered input. In reality, touch can be registered
before stylus, such as the Wacom Cintiq Pro 13 and 16.

This patch covers both touch-first and stylus-first cases.

Cc: stable@vger.kernel.org
Fixes: ba16e5ffbaa1 ("HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration")
Reviewed-by: Lee Jones <lee@kernel.org>
Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index c4cd87b781c4..cf459c16b39a 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3977,10 +3977,18 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 
 	if (features->type == HID_GENERIC) {
 		hid_dbg(hdev, "generic touch setup\n");
-		if (wacom_wac->has_mute_touch_switch ||
-		    (wacom_wac->shared && READ_ONCE(wacom_wac->shared->has_mute_touch_switch))) {
+
+		/*
+		 * This is to setup the touch switch for those devices that report
+		 * pen interface first. The setup can only be done here since this
+		 * routine is only called once. When we are here, the shared
+		 * has_mute_touch_switch has been set by the pad.
+
+		 * There are two ways of reporting inputs from firmware: stylus first
+		 * or touch first. This path covers the stylus input first case.
+		 */
+		if (wacom_wac->shared && READ_ONCE(wacom_wac->shared->has_mute_touch_switch)) {
 			input_set_capability(input_dev, EV_SW, SW_MUTE_DEVICE);
-			wacom_wac->has_mute_touch_switch = true;
 		}
 		/* setup has already been done */
 		return 0;
@@ -4403,7 +4411,26 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 		break;
 
 	case INTUOSHT3_BT:
+		break;
+
 	case HID_GENERIC:
+		if (wacom_wac->shared) {
+			/*
+			 * The setup of touch switch capability can only be done
+			 * here for those devices, such as Cintiq Pro 13 and 16,
+			 * that have touch input registered before stylus and pad
+			 * inputs.
+			 *
+			 * There are two ways of reporting inputs from firmware:
+			 * stylus first or touch first. This path covers the touch
+			 * input first case.
+			 */
+			if (wacom_wac->has_mute_touch_switch &&
+			    wacom_wac->shared->touch_input) {
+				input_set_capability(wacom_wac->shared->touch_input,
+				    EV_SW, SW_MUTE_DEVICE);
+			}
+		}
 		break;
 
 	default:

