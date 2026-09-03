Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E683921EC
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440120; cv=none; b=IpH33Py+8zr5ian4KViCO5v9/Bmc49Jeg9Msj1Xr4kBX69eFK1LOpdTSqkHA/4IaVDZqQbJfWaqOJZVPxYTSPBdYvZi2FcoAEj8wyaYYuWlecPyNGR7UEUU43iEKpz6AS1Wx82WXyRlSULsFLDTlkIJauP9CYOcli67o8YRZmII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440120; c=relaxed/simple;
	bh=4H8UbxrGnbq0j6iqr4vMRAM9o0bFO2qbNYgwgvrW1Cg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=T6ThKFkjncuC2ee1+rSIgwln1sSmgSDTc2m3qFCojeYsnVUx1N+l/uk+O1qf3GiXbRKc7CtodpEv5p4jI4YU2LknNBdOUtlAMM51rTaVMtFbkfPJ28ySYUaD+Rfwr02GBVWxfJYEZWMaschOtSVK2TZQI204HFNQqWEIE6DYxM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c01u0Gnq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c01u0Gnq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125771F000E9;
	Thu,  3 Sep 2026 12:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788440119;
	bh=jo4qvE4rHOhAYSrBUKmBVyEXo+ZemxzPvObjyO2euRw=;
	h=Subject:To:Cc:From:Date;
	b=c01u0GnqfL7fiFHKxHkfIjw92lBKFIoT78Tj2dCom3BWkn/lse84ZtNffQzUye6GY
	 kjooj+xHQA0+Ui7V7zvtes5vmZnAZ/ttKOegIW1OSI9WZljaUurJp1xmDCeiMKavOF
	 UecWGupw8jD0yG129OiLjsS3QjRcDQyHZMs3jWb0=
Subject: FAILED: patch "[PATCH] usb: gadget: u_audio: Fix use-after-free on sound card" failed to apply to 5.10-stable tree
To: sonalipradhan@google.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 14:40:24 +0200
Message-ID: <2026090324-poker-gradient-aafb@gregkh>
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
git cherry-pick -x 858965947081d10d41d9a1010a540d3d5eea958b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090324-poker-gradient-aafb@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 858965947081d10d41d9a1010a540d3d5eea958b Mon Sep 17 00:00:00 2001
From: Sonali Pradhan <sonalipradhan@google.com>
Date: Mon, 10 Aug 2026 07:12:37 +0000
Subject: [PATCH] usb: gadget: u_audio: Fix use-after-free on sound card
 disconnect

g_audio_cleanup() invokes snd_card_free_when_closed() to initiate sound
card teardown and immediately frees the underlying struct snd_uac_chip
context. However, snd_card_free_when_closed() returns asynchronously
while ALSA control elements (kctls) remain open in userspace.

When userspace control applications access or close these open file
descriptors, kctl callbacks attempt to dereference kctl->private_data
pointing to &uac->c_prm or &uac->p_prm within the freed uac structure,
resulting in a use-after-free (UAF) memory corruption.

Fix this issue by deferring the destruction of struct snd_uac_chip until
all references to the ALSA sound card are released. Register a custom
card->private_free callback (u_audio_card_free) during g_audio_setup()
that frees uac and its associated playback/capture request and ring
buffers only when the sound card reference count drops to zero.

Fixes: 6c67ed9ad9b8 ("usb: gadget: u_audio: don't let userspace block driver unbind")
Cc: stable@vger.kernel.org
Signed-off-by: Sonali Pradhan <sonalipradhan@google.com>
Link: https://patch.msgid.link/20260810071237.2207680-1-sonalipradhan@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index ca26bf9c8040..f0ee83abcebc 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -1183,6 +1183,20 @@ static struct snd_kcontrol_new u_audio_controls[]  = {
 	},
 };
 
+static void u_audio_card_free(struct snd_card *card)
+{
+	struct snd_uac_chip *uac = card->private_data;
+
+	if (!uac)
+		return;
+
+	kfree(uac->p_prm.reqs);
+	kfree(uac->c_prm.reqs);
+	kfree(uac->p_prm.rbuf);
+	kfree(uac->c_prm.rbuf);
+	kfree(uac);
+}
+
 int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 					const char *card_name)
 {
@@ -1262,6 +1276,8 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 		goto fail;
 
 	uac->card = card;
+	card->private_data = uac;
+	card->private_free = u_audio_card_free;
 
 	/*
 	 * Create first PCM device
@@ -1430,6 +1446,8 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 
 snd_fail:
 	snd_card_free(card);
+	return err;
+
 fail:
 	kfree(uac->p_prm.reqs);
 	kfree(uac->c_prm.reqs);
@@ -1455,12 +1473,6 @@ void g_audio_cleanup(struct g_audio *g_audio)
 	card = uac->card;
 	if (card)
 		snd_card_free_when_closed(card);
-
-	kfree(uac->p_prm.reqs);
-	kfree(uac->c_prm.reqs);
-	kfree(uac->p_prm.rbuf);
-	kfree(uac->c_prm.rbuf);
-	kfree(uac);
 }
 EXPORT_SYMBOL_GPL(g_audio_cleanup);
 

