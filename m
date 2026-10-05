Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24966446C0C
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195964; cv=none; b=YX+DwFhRlDNokd8TVXTEwEeKbbs7S/GajKnNLxUT6PaOBOZTvruManHxNiAsedYSlohRAcLTYtYXWwhr2CuOo+CxEOpeXsM76J9v+s4i8aF78Et/FhAKl/++VNA40mXhA0H6qOtnY8yVHynbc4giStnhcp4D9abfi7prnFkV49g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195964; c=relaxed/simple;
	bh=tnU48Fl6AlHeL4DcDha3EgTpvmoes8UDwkmBvIb1ydc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fFftUH0tNMZvPl2bTUum8lc03UThBk0B2EufIF534pjrcIVXhYm8W/QW+vNdw/WsRerfSFnp7Xq36EkoziceT/PlqMPx3TAsi/cbBvxPbiHlXI8KCloY7SpFHr8CT/en9zkMoVBFSEjhqFXjmv5V62c+JnXPEfcaEQK6R7egqRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t6IiiaoO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t6IiiaoO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542681F000FF;
	Mon,  5 Oct 2026 10:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791195962;
	bh=Sq1BRBu4FP9w7OJaIuLEpbkFubIKirVK4Uc2tqcuZFo=;
	h=Subject:To:Cc:From:Date;
	b=t6IiiaoO6NVVAEmuh85vlz0wDZ6hMPsrHy1ZinXKS57twLAggIeuDLxEuqF8m4te4
	 urw4luj6R/r71VDaDwgti7S20sSs6hTnOMTNLheklXbSwqflDEsJTfA5JhN8Wikdfs
	 xCz0N/2BXYyhE/g6pxfndHxeAFWpVuYC1Lvi4GM8=
Subject: FAILED: patch "[PATCH] ALSA: usb-audio: Apply IGNORE_CTL_ERROR quirk to all Audient" failed to apply to 6.18-stable tree
To: tiwai@suse.de,faarisansari@googlemail.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 12:25:48 +0200
Message-ID: <2026100548-bunkhouse-composer-05e9@gregkh>
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
git cherry-pick -x a154f7b9f197b3d5e41fa3ad62083f5aa93b1fe8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100548-bunkhouse-composer-05e9@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a154f7b9f197b3d5e41fa3ad62083f5aa93b1fe8 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 29 Sep 2026 16:41:26 +0200
Subject: [PATCH] ALSA: usb-audio: Apply IGNORE_CTL_ERROR quirk to all Audient
 devices

Faaris reported a problem with Audient EVO4 device and it turned out
to be a regression by the recent fix commit 87a6f2fa6e6c ("ALSA:
usb-audio: Propagate write errors in generic mixer put callbacks").
It exhibited that the hardware gives errors at accessing the mixer
unit 10 on certain channels, and the change above made it a fatal
error.

We had already a quirk for Audient iD14 to work around such errors
from the mixer controls, and we can simply apply the same for EVO4.
OTOH, it's highly possible that other Audient devices suffer from the
same issue; they must be using similar firmware, after all.

So, in this patch, we apply the quirk generically to all devices with
the vendor ID Audient (2708), instead.  Ignoring the control error
isn't usually less critical than overreaction to the firmware
misbehavior.

Fixes: 87a6f2fa6e6c ("ALSA: usb-audio: Propagate write errors in generic mixer put callbacks")
Reported-and-tested-by: Faaris Ansari <faarisansari@googlemail.com>
Closes: https://lore.kernel.org/CANBVYRCL=8QdLxGg4S6qrahrFtwJxhv-aSGpW7-1S=+iOe4ZGA@mail.gmail.com
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20260929144132.1521617-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index f55b02d6dd39..3afc49565963 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2516,8 +2516,6 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_FORCE_IFACE_RESET | QUIRK_FLAG_IFACE_DELAY),
 	DEVICE_FLG(0x262a, 0x9302, /* ddHiFi TC44C */
 		   QUIRK_FLAG_DSD_RAW),
-	DEVICE_FLG(0x2708, 0x0002, /* Audient iD14 */
-		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x2772, 0x0502, /* Musical Fidelity M6s DAC */
 		   0), /* for avoiding QUIRK_FLAG_DSD_RAW with vendor match */
 	DEVICE_FLG(0x2912, 0x30c8, /* Audioengine D1 */
@@ -2616,6 +2614,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x2622, /* IAG Limited devices */
 		   QUIRK_FLAG_DSD_RAW),
+	VENDOR_FLG(0x2708, /* Audient devices */
+		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	VENDOR_FLG(0x2772, /* Musical Fidelity devices */
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x278b, /* Rotel? */

