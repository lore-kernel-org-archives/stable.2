Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794813467;
	b=29YC0fbs1sX8jX0AXJqFCdZ4cLsn+YyFnHg/WlCgRCFDvlhNvea4wIXUfBjPsRz2hldT
	 rNDp12iwuJfsz8g2qJItxkkoPjILYVR4NsAma5bA1/ptUdsmoF16iMslHmmBLTqPQFyPk
	 Y+v4zlJU6/oxsGpF1EZR1fFfvq68IWb45ifRRFsdumsV7q8PB8/Kblpi3sE9yZo9TqWq4
	 8a4cf9s5WbCLTWiJbL6wnDlgcwVaISMZxFtvF8J9RaXMZaYN8QJsnvSBWOGQz25S2ovI9
	 v/T4EA8nOjEhMIg3GesjEE6Dq8VvJCzHx0+GR/9PjWacu+7K1b9waV7xZHIxE2mhT8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813467;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=B7nV9urTdshC/zpTRjwCw9MmwOU42RvML/s+5T9QAug=;
	b=g4vJbI32oR4LBdDr5tPjFneOw23vir4s3XD4o1VDTU7iPFe8bKc+Y0pF6cFJ6VwSrjJF
	 zd1ZiQxQVrUnn4x1SYKmCrnJsGeFRXfpXyluaxFSOTO4i+2har6CbtcejG9NvHma2Y+/W
	 2Iow5MaMeZQ9wfS98F2J3gmUSTj0FQLaCxiTN0bixyjMJ0v5Z4FHjhIkA+Wk9yY6oEmHt
	 H3dJN7V8I7pY7jbEjqQSSsVgMJSlr/DdzirAxM5erRQ7NMIlJil1PCcJ/hG5VzI2LS1Hk
	 b6R/tCGzLFD9jS96YjPXdOyDyFXbODlW5RiCBu3o9MC0cTO7yI4oBIgBR6BU27T0Xgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=becholey.ch;
	spf=pass smtp.mailfrom=becholey.ch;
	dkim=pass header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=xe+LlQN+;
	arc=none smtp.remote-ip=185.70.43.17
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72C3606A32A;
	Mon, 16 Nov 2026 07:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B72C3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=becholey.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=becholey.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=xe+LlQN+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=becholey.ch;
	s=protonmail; t=1794813463; x=1795072663;
	bh=B7nV9urTdshC/zpTRjwCw9MmwOU42RvML/s+5T9QAug=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=xe+LlQN+guxmXMH8cH2ONjEon3scolyiEsWlvi3Vx7mx84MtHb37UjOnuqSdV7EjH
	 hXjRWKQmODimt8ajBCWpyTpb0U0sgZcupOt4HPXjgCcF/ugyZhJ2CS0tsM2d5IkgWf
	 EcaSJ8r4+k04WREU/+m9ym2VQQJuBE/K7zaED/pNNYu3rNS/jU7mDlhQRxOjhAK31K
	 xWJoeq63QzkHnkcZqGS4LyhUdwoKmVNh/k7PHU2bTVgod3fHj272Av8e1RzangYa+d
	 C/R0U9tsykxQWaut80a3kAAPeN23kkOrxU74hAmwA11NARG9vfwdhBqM/H8hoJEgll
	 yTTnjKHPg1mNA==
Date: Mon, 16 Nov 2026 07:17:39 +0000
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, =?utf-8?Q?=C5=A0erif_Rami?= <ramiserifpersia@gmail.com>
From: Alexandre Becholey <alex@becholey.ch>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, Hanxiang Xu <xuhx@hust.edu.cn>, Alexandre Becholey <alex@becholey.ch>, stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 2/5] ALSA: usx2y: us144mkii: wait for the capture work on capture close
Message-ID: <20261116071707.217448-3-alex@becholey.ch>
In-Reply-To: <20261116071707.217448-1-alex@becholey.ch>
References: <20261116071707.217448-1-alex@becholey.ch>
Feedback-ID: 60743817:user:proton
X-Pm-Message-ID: 03fa600b52e4001fe12a14c1520f453ad9fe8c68
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
Changes in v2:
- no change.

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

Testing of v2 (whole series, KASAN, PROVE_LOCKING, PROVE_RCU): no
report in 6 runs of the close/reopen program (v7.3.1 3, 97d73c825122
3), each completing all 400 iterations.

Testing of v1, KASAN: without the series the close/reopen program crashed a=
s
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

