Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215031;
	b=1WNdcbFdzlOlvF01GuHbMXtCX8aGkxPXFWDmX6nbE1QLkb14CxNkYiBcXFbHoRoa0vC/
	 n0pKiCsUGGUuS1Fr31Z0GB22ntTciZqq1zCyb+IZutsbQ/jUyICYPhEdPk3BPT+la88Dx
	 0Un0PDZViKbuxXbMGqH/BZDZoZHVVnNRqvnpqdHf8BPHM/+julhcdSWYD8/ya8o9u5FSU
	 LKdgnu+AO/1oTcw9ZMvDa4WVYFx7sbgS2LkHIk3wWBfXgL+J5W3xO13UmJb36f2oM+2ox
	 RgoNNj2y1aA4koomeutzEsLWeR1vQi91ylvkAMiCTge1AF8zXaQgW9N8FwQvcjkcCiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215031;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xL7NICnviPylGawuY6UFdSAue0kDWn0dNEjgPy6oRAo=;
	b=5NSaRqU2aYa9IPmew1GsE3m6jg0oTg55k1W4L2F9EPItHidUilsRSRmgFKcF1h8+zhOl
	 RBgJUhkE8RDoQCEUq4Ro4e0eYGLeM689pBD9uRPC11Eroyo/xekbCBrSrut9F431/q6ym
	 Jw7zY4vU5SpJ/NhhqXg7qQHazkpdC1Epf93XXjI20lYpBVluuzZRtW7H1bdMaaKL9+T0b
	 NRhRuX5g1KTOMgYJCfsefu0G8R7fsxRB181JWypmPojOgtU9asOg6p/h1dejCQ10lDOOl
	 D+Fr1ctmBa7EpMTlgC31Iy6CsJtkfpFtNkN3FudWPO5pd5/KHNXl28wlLuxD+a2YIYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C2KZ3WuW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF889606A31C;
	Mon,  9 Nov 2026 09:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C2KZ3WuW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107FA1F0089F;
	Mon,  9 Nov 2026 09:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794215030;
	bh=xL7NICnviPylGawuY6UFdSAue0kDWn0dNEjgPy6oRAo=;
	h=From:To:Cc:Subject:Date;
	b=C2KZ3WuWjUIzoa8FcZUcaFzzQZhqMrHjM++x3qrdMIuFFCSVoc+/Ozkksr8Btqymr
	 woteoGAq+NPOYL4t2nZT/EnFjR889tG3rGDRry5BhOVYpez37nrqrpJTVXD7P9nNda
	 Fqo5uLViJhTiVN9ct41r6psIXua2EUoB6R2NL7yxFhvX4Lk2SlDKyMEQVA59ijHtTp
	 rBI7dhrjR2bt4HFsQO2te6Vh8hoCrAzXOUoKFrk3iGHls+xbVmfzt8Z+ggM6bMEajt
	 cUnKm96emTdtZlA+lTjLAV0dI9EXub9WqLAeGDbI9eHDlTSEon3dSuQrh9m8KJOvqp
	 WDWFVgIYEhusw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [STABLE v6.1-v5.15] ALSA: usb-audio: Don't try to submit URBs after disconnection
Date: Mon,  9 Nov 2026 09:03:44 +0000
Message-ID: <20261109090346.2098226-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

commit ab574d1629552b6831cd91b926b38092c15d6142 upstream.

USB-audio driver can still submit URBs while the device is being
disconnected, and it may result in spurious error messages like:
  usb 1-2: cannot submit urb (err = -19)
  usb 1-2: Unable to submit urb #0: -19 at snd_usb_queue_pending_output_urbs
  usb 1-2: cannot submit urb 0, error -19: no device
Although those are harmless, they are just ugly.

This patch tries to avoid spewing such error messages when the device
is already at the disconnected state.  It also skips the superfluous
xfer notification, too.

Link: https://lore.kernel.org/r/20230828101924.27107-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 sound/usb/endpoint.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index dd81c94cbb52..167eefc14d82 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -520,13 +520,18 @@ int snd_usb_queue_pending_output_urbs(struct snd_usb_endpoint *ep,
 			return -EPIPE;
 		}
 
-		err = usb_submit_urb(ctx->urb, GFP_ATOMIC);
+		if (!atomic_read(&ep->chip->shutdown))
+			err = usb_submit_urb(ctx->urb, GFP_ATOMIC);
+		else
+			err = -ENODEV;
 		if (err < 0) {
-			usb_audio_err(ep->chip,
-				      "Unable to submit urb #%d: %d at %s\n",
-				      ctx->index, err, __func__);
-			if (!in_stream_lock)
-				notify_xrun(ep);
+			if (!atomic_read(&ep->chip->shutdown)) {
+				usb_audio_err(ep->chip,
+					      "Unable to submit urb #%d: %d at %s\n",
+					      ctx->index, err, __func__);
+				if (!in_stream_lock)
+					notify_xrun(ep);
+			}
 			return -EPIPE;
 		}
 
@@ -593,12 +598,17 @@ static void snd_complete_urb(struct urb *urb)
 		prepare_inbound_urb(ep, ctx);
 	}
 
-	err = usb_submit_urb(urb, GFP_ATOMIC);
+	if (!atomic_read(&ep->chip->shutdown))
+		err = usb_submit_urb(urb, GFP_ATOMIC);
+	else
+		err = -ENODEV;
 	if (err == 0)
 		return;
 
-	usb_audio_err(ep->chip, "cannot submit urb (err = %d)\n", err);
-	notify_xrun(ep);
+	if (!atomic_read(&ep->chip->shutdown)) {
+		usb_audio_err(ep->chip, "cannot submit urb (err = %d)\n", err);
+		notify_xrun(ep);
+	}
 
 exit_clear:
 	clear_bit(ctx->index, &ep->active_mask);
@@ -1646,11 +1656,15 @@ int snd_usb_endpoint_start(struct snd_usb_endpoint *ep)
 			goto __error;
 		}
 
-		err = usb_submit_urb(urb, GFP_ATOMIC);
+		if (!atomic_read(&ep->chip->shutdown))
+			err = usb_submit_urb(urb, GFP_ATOMIC);
+		else
+			err = -ENODEV;
 		if (err < 0) {
-			usb_audio_err(ep->chip,
-				"cannot submit urb %d, error %d: %s\n",
-				i, err, usb_error_string(err));
+			if (!atomic_read(&ep->chip->shutdown))
+				usb_audio_err(ep->chip,
+					      "cannot submit urb %d, error %d: %s\n",
+					      i, err, usb_error_string(err));
 			goto __error;
 		}
 		set_bit(i, &ep->active_mask);
-- 
2.56.0.506.g506a7eabc5-goog

