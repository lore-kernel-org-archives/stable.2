Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892D7474255
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195972; cv=none; b=YG/2i8Q803QO3bhjuYFdcqA4marIxPNBGkL0818d7XieEv9IklL9sZ6RQG6Pk434dsxcnpF8aQ5GzO3h98FvEzWECOC81TOIWpfipK89NtrFQHSj9SIvfnMsNikHN5sGMSr5yT5WRs2+uh0nXfwhz6Ikwi53qi1JI2PqJ6tdexM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195972; c=relaxed/simple;
	bh=t80SbPzTa3ljs5kYaRUDz/laVuRVSwWY7JplOwW00Qs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SYYNFbU4YYaeUmDxnnQ4RRVlcgzW80fKpLxPb3fes5epRzVFRpV6MSrdFMR0PqYqFuWXwvzOcrZS5Vg5m2isW9MQf6unThC8HiqKnOOp6tB8xlLeyZUh+hVz1F2C3gm8IBA91lV02hHj12qA72R9nE1m/iYWKNkWFf49lTcLgP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g9qnoQ0b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g9qnoQ0b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAB61F00898;
	Mon,  5 Oct 2026 10:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791195971;
	bh=kG7nFMLyYtrd4cIT8+HpbiXKBF+Vb93I1YbkSFlGFMg=;
	h=Subject:To:Cc:From:Date;
	b=g9qnoQ0b+x5JMx+W+xI4he7KF5gDhQoUW/tTDfU1xmSkXqR7yH0l9LLWAGyyeS704
	 8GGPohsOdYuknrD9IqFYeYocBX0y2GYzYal1SrISI/toXS6glEEEpbgTtIIf5mrsL4
	 GTD9QSPApCcKzbRx0ehEt1XYodFcBCFTtVm5bJgU=
Subject: FAILED: patch "[PATCH] ALSA: usb-audio: Apply IGNORE_CTL_ERROR quirk to all Audient" failed to apply to 6.6-stable tree
To: tiwai@suse.de,faarisansari@googlemail.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 12:25:49 +0200
Message-ID: <2026100548-brunt-unwilling-2355@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x a154f7b9f197b3d5e41fa3ad62083f5aa93b1fe8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100548-brunt-unwilling-2355@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

