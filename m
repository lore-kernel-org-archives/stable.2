Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794677333;
	b=U0VBUGCDnuLjeY2l6ev23KROvJ6jOoMcHRIJQrhjk+fEBjySRpS7MBEJKygKtNOeefxt
	 LTspJplkSn1TgNmngiJ9+iHWzlEe2RQPMVhVtAa6kZaCLpLOAC7D5VdjTThH3H5GW4EGA
	 iOo4lbIr3n35nCZdI67Jq4KRKJV1KoAYClpLPGFw8Iadc4XDc5i5y6o1lIdI/GtsM4a5t
	 vtwBrXtcMiPtagAR03DeW4SvbQDFY8Jwj9NFLsg3OMKO0Jt2LltXCJJNsIZsXDsV0iSin
	 hRX7uKo+0Cv0PW/fCUq31xH0decqhBdmE6ZhxF8W5ONyIdOd5kgZqJAC5oz875fXM2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794677333;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=bwuiQTGA7IyiYt4mUxO48SU0Ewzb475ptfetTK8z/XA=;
	b=FfSanGnynPbRa5lAn5oDrnL4LGC6cH13j5+I1yTXXmTdpGopIimwHxlsrd9AjH84Euji
	 XyEj0XHXxHVv5Rhv3S7Ng2UBwK23uOfRv0qT+Xwnaj+0CNcnzZnX54ip8h+OBok+P9kx6
	 K4lQ7XoYCjYCES8qRM+2YAJG+vA8ip+lpkW+CKkTOc5HexTPixqQgczRzRuqkmXwBVh5o
	 F6XQGAUayLTKuuvRMdwh20P+HGt6sKgSMmIom7ce/H4pGV7EtvtgQj4A/J5uTrEXv9iOV
	 RQzEL0/BIJrSDYaXY6fIRp5odaoy7ZnfCOGTZtJBCCW7UG+V3IF2OwFLKK4iuzOmkAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=becholey.ch;
	spf=pass smtp.mailfrom=becholey.ch;
	dkim=pass header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b="Z/wigYSs";
	arc=none smtp.remote-ip=109.224.244.21
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A85A606A331;
	Sat, 14 Nov 2026 17:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A85A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=becholey.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=becholey.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=Z/wigYSs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=becholey.ch;
	s=protonmail; t=1794677331; x=1794936531;
	bh=bwuiQTGA7IyiYt4mUxO48SU0Ewzb475ptfetTK8z/XA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Z/wigYSsk4l87qE8bRW7ZqOWzYhrR+Ro/eNdrEi2qoncanLADeM1pUEk9jy3plPdf
	 KrVbosJci6dKvqg4TS5eOv4fNsEjvfUbIxIBvngETN4kI/FoHCD2T6kEhWFDkBOBNU
	 jjT6x1Q5dJgyaQde5wqjBqDYXRqOss8v/ALwNt22bLghUWdF8sk4CMnL+hzFJWPCGq
	 Epu9sRA9KbWdSDEPT8T/4ZH7ippFlcjK23IMu6+1oTNisYlWX7xGdQs1egjjLW4f18
	 ehRni2jNRTbZ0trdUucDHh909D/X8wW765SU4Tch+Tj2+9tuLX1kXegtMuqO6rgyhr
	 2FYdyo5oSNT1Q==
Date: Sat, 14 Nov 2026 17:28:46 +0000
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, =?utf-8?Q?=C5=A0erif_Rami?= <ramiserifpersia@gmail.com>
From: Alexandre Becholey <alex@becholey.ch>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, Hanxiang Xu <xuhx@hust.edu.cn>, Alexandre Becholey <alex@becholey.ch>, stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/5] ALSA: usx2y: us144mkii: wait for the capture work on capture close
Message-ID: <20261114172806.88710-3-alex@becholey.ch>
In-Reply-To: <20261114172806.88710-1-alex@becholey.ch>
References: <20261114172806.88710-1-alex@becholey.ch>
Feedback-ID: 60743817:user:proton
X-Pm-Message-ID: d12c42654642bc83481c1b20d82e104f1a8f72f7
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The capture URBs are started and stopped together with the playback
stream by the shared trigger callback, and every completed capture URB
schedules capture_work. tascam_capture_work_handler() reads
tascam->capture_substream and its runtime once and then keeps writing
into runtime->dma_area, using runtime->frame_bits and
runtime->buffer_size, for as long as capture_active is set and the
capture ring has data.

tascam_capture_close() only clears tascam->capture_substream and does
not wait for the work. When the capture PCM was opened and prepared but
not started while the playback stream is running, closing it does not
stop anything: capture_active stays set and the URBs keep completing.
The runtime is freed by snd_pcm_detach_substream() right after the close
callback returns, while a running work instance still uses it. With
KASAN, on torvalds/master 9d66f26fefac:

  BUG: KASAN: slab-use-after-free in tascam_capture_work_handler (sound/usb=
/usx2y/us144mkii_capture.c:230)
  Read of size 8 at addr ffff000013270458 by task kworker/0:1/11
  Workqueue: events tascam_capture_work_handler
  ...
  Freed by task 79:
   kfree
   snd_pcm_detach_substream
   snd_pcm_release_substream.part.0
   snd_pcm_release
   __fput

A USB device that keeps the capture endpoint busy keeps the work loop
running, which makes the window wide.

Cancel the capture work in the close callback, after the substream
pointer has been cleared under tascam->lock (patch 1/5), so that no
work instance can still use the runtime when it is freed. Instances
queued later see the cleared pointer and return early.

The bug was found, and the reproducer and this fix were written, by AI
agents (Claude Mythos and Claude Opus models). The analysis and the
patch were reviewed by a human.

Reported-by: Hanxiang Xu <xuhx@hust.edu.cn>
Closes: https://lore.kernel.org/all/12a3a26a.26361.1a1d4e1ad57.Coremail.xuh=
x@hust.edu.cn/
Fixes: c1bb0c13e430 ("ALSA: usb-audio: us144mkii: Implement audio capture a=
nd decoding")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Becholey <alex@becholey.ch>
---
Notes for reviewers (not part of the commit message):

Trigger: an emulated US-144MKII (raw-gadget + dummy_hcd, QEMU arm64,
KASAN, 2 CPUs) that streams capture data. In each of 400 iterations
the program opens the capture PCM and prepares it without starting
it, starts the playback PCM, and closes the capture PCM. A variant
also stops playback before the next capture open, so that only this
race is left. The reproducers are available to maintainers on request.

The context of this patch is the close hunk of patch 1/5. Patch 3/5
also depends on it: with 3/5 alone, a capture work instance still
running after close dereferences the detached runtime in the new
snd_pcm_running() check (seen in testing, KASAN null-ptr-deref at
include/sound/pcm.h:711 from us144mkii_capture.c:231 on v7.3.1).

Testing, KASAN: without the series the close/reopen program crashed as
above on the first attempt (v7.3.1 1/1, 9d66f26fefac 1/1). With
patches 1/5..3/5 applied: v7.3.1 0/15 runs (both programs), 9d66f26fefac
0/5 runs, each run completing all 400 iterations.

Not changed here: feedback_urb_complete() also reads
tascam->capture_substream->runtime before taking tascam->lock and uses
capture_rt->period_size under it; patch 4/5 fixes that.

Thanks,
Alexandre Becholey

 sound/usb/usx2y/us144mkii_capture.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/usb/usx2y/us144mkii_capture.c b/sound/usb/usx2y/us144mki=
i_capture.c
index 30cdd73ca99c..973bed60bfcd 100644
--- a/sound/usb/usx2y/us144mkii_capture.c
+++ b/sound/usb/usx2y/us144mkii_capture.c
@@ -40,6 +40,12 @@ static int tascam_capture_close(struct snd_pcm_substream=
 *substream)
 =09=09tascam->capture_substream =3D NULL;
 =09/* The stop work may still be using this substream; wait for it. */
 =09flush_work(&tascam->stop_pcm_work);
+=09/*
+=09 * The capture work keeps a pointer to the runtime, which is freed
+=09 * when this callback returns. The capture URBs (and so the work) keep
+=09 * running as long as the playback stream does, so wait for it here.
+=09 */
+=09cancel_work_sync(&tascam->capture_work);
=20
 =09return 0;
 }

