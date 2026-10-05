Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187683B8BD9
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195975; cv=none; b=ThhXwow0DtbaX/xCJjwcNzLC3NHEyxM5mHjEfLFRSN97eXtU/h7Z8kOhce/E7yamryRXEjnAe5kjkNErLU/r5bx4tDqP/bLo84uPogWg1+5TqUiWHizb4A/jpEneofRfLrFKh9GJUx7WSdH2NWU7sZwyicalXbfABm0CBEqYXM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195975; c=relaxed/simple;
	bh=4LjEHs7texSN0YShvwREYEX9yyutN7whG0pyK/EeWGs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LwcHmi38s6eweN3IQ8aGkWhqG45jFb3NFjAAmc2LlmKxNaYhFNJrkBU1mNaWJnEksgkWqTEKEZn86hY/0Ur1hZIQNEKWBk/kFEUlu//z/gRT0axIHKejFTfyVIYlKLgOC2TnSmU2sTcJ8lEWPMowtdlOZ/NPeFNZSTcPLTUFIqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kBaUkXmT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kBaUkXmT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731651F000FF;
	Mon,  5 Oct 2026 10:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791195974;
	bh=QF620horMR3mljLlJsE7jAH+W/l0C1JnCdd5HQQsyzo=;
	h=Subject:To:Cc:From:Date;
	b=kBaUkXmTI483SIguvTOH7q/ldw3KerdlNBFCyAIhdLplJW5ecgPfdTU6lDpNUJ8Ez
	 KH3YLak+0hWZaLU6O0a3xTmLFafdpglkZ/p4vVNtPlIXWIIsu/lT2Cnv0hbtUrQ33/
	 O1YkxW1rWSGawdQZD0bijt1z0irPcnvuWLvI7o/0=
Subject: FAILED: patch "[PATCH] ALSA: usb-audio: Apply IGNORE_CTL_ERROR quirk to all Audient" failed to apply to 5.10-stable tree
To: tiwai@suse.de,faarisansari@googlemail.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 12:25:50 +0200
Message-ID: <2026100550-outhouse-leggings-6ba9@gregkh>
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
git cherry-pick -x a154f7b9f197b3d5e41fa3ad62083f5aa93b1fe8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100550-outhouse-leggings-6ba9@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

