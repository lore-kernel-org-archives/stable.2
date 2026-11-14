Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794677348;
	b=DCqXQNyzD7mocWDXjlnWrAMbMd+82wg+vLD3uNswtNd1frFrGC6WgnpIA3SeJE8bileZ
	 Trx63pPQOtzbVc1I60dma8KqOJUFcrgD08g62P5TlduhOgx0m2nj3HD6UHvSllpz3RR5b
	 Lu7DE/0ZGy84AoUAhko+tFmIOtqinAwB/9Rj8lThyY9SkcAixDOOJE1ykWAbV1v0AutEV
	 dU57lh4amBLhX8eNPRlVZZ+7pG6jyBFfQGPi61S+RVIOaaA6hDss8A8ONFWxjyGJtI4U2
	 5R0XY3RSbPA9qs0ZaJcSR3YPTtSTslucIgd7TmDDhX3NX0815l7AMfQb05ZqQYzf3RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794677348;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=4hb4aK2ydg2K7x1kGlmOBv9DvO7lHzeMpLQSvB/PByc=;
	b=rFVUdCw0Ch1bgH/uSFbQoYGiGa6Q7VINlmAycwaQji/d9nWAhtKB56IpUALDFBX+DqIA
	 +avBieBTrKcescEbk2twA9btDyubrrwDvCtrpwWjl3kUfM/dBtr+f+aELvyEUf8LG59EW
	 8pzjGAG8k7t+oE5KBD1I6Ljn5PBsPruJP1Fp3gNpdb8yydjey/rMIVqahBM4OPc5yueov
	 lRrh1CFZ4m//uEr78RHk5KqMX5bXqKPCKN25yrdsMD6cJDTv0MQ5EVJVynSErWB0ETIDU
	 XiFn6ZnjHuwYoRe8gpTqiEMemriTOAsbRoKrTe/k5IBxb+dEgoXo83R5iIGg6BF1wKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=becholey.ch;
	spf=pass smtp.mailfrom=becholey.ch;
	dkim=pass header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=CG2Tf7od;
	arc=none smtp.remote-ip=185.70.43.98
Received: from mail-4398.protonmail.ch (mail-4398.protonmail.ch [185.70.43.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35616606A333
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 17:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35616606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=becholey.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=becholey.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=CG2Tf7od
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=becholey.ch;
	s=protonmail; t=1794677346; x=1794936546;
	bh=4hb4aK2ydg2K7x1kGlmOBv9DvO7lHzeMpLQSvB/PByc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CG2Tf7odAA+arh1+eIA2zxmUUEFPtBkVLoMF6XKUGFGcmoayEwNT9whHeRKIU5bJj
	 OdN1eWffPWKfd3sBTxKWr6d2OyfQdm289Wi1oLOAMGqvXkXmcxfg7zcMH8tox6iLiT
	 o3DUpOJPEW9j6Ri5nA9f61GeQNpbneQsqp0Bh1nRN+/lCR6HWGLFeSIOvY/zDV7HxQ
	 YSd/pKNstY94ZQBDxtcbRydAf+St3DkOjifLTjFyyXKnrWQorjf1d/eB8S7Tbp/X86
	 6rya+1fHb0jAUnLOX9zejelIfaOiMC+sn/J87FjecOAo8f69WNrqkLvBi5goQT1fRI
	 8cftBN1nreuaw==
Date: Sat, 14 Nov 2026 17:29:00 +0000
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, =?utf-8?Q?=C5=A0erif_Rami?= <ramiserifpersia@gmail.com>
From: Alexandre Becholey <alex@becholey.ch>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, Hanxiang Xu <xuhx@hust.edu.cn>, Alexandre Becholey <alex@becholey.ch>, stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/5] ALSA: usx2y: us144mkii: wait for the URB completion handlers on stop and close
Message-ID: <20261114172806.88710-5-alex@becholey.ch>
In-Reply-To: <20261114172806.88710-1-alex@becholey.ch>
References: <20261114172806.88710-1-alex@becholey.ch>
Feedback-ID: 60743817:user:proton
X-Pm-Message-ID: 56bc3b3b02477e3227e2da4e6ad194b5ff87ecc4
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

The playback, feedback and capture URBs are started and stopped together,
so they keep running while either PCM stream is running, also when the
other substream is closed. playback_urb_complete() and
feedback_urb_complete() read tascam->playback_substream (and
capture_substream) and its runtime without holding tascam->lock, then
use runtime->rate, runtime->period_size and runtime->buffer_size under
the lock, copy from runtime->dma_area and call snd_pcm_period_elapsed()
after dropping it. Nothing waits for a completion handler that has
already loaded these pointers: the PCM .close callbacks only clear them
and the stop path only schedules stop_work.

So when a PCM is closed while the URBs are running, the managed buffer
is freed by do_hw_free() and the runtime by snd_pcm_detach_substream()
while a completion handler may still be using them. A device can make
the window wide: a feedback completion that prints "Fatal: Feedback
sync lost" does so between two uses of the playback runtime. With
KASAN, on torvalds/master 7e1392a42ea2:

  BUG: KASAN: slab-use-after-free in feedback_urb_complete+0xe64/0x1174
  Read of size 8 at addr ffff0000132ba078 by task repro/82

The object is the snd_pcm_runtime, freed by snd_pcm_detach_substream()
from snd_pcm_release().

Read the substream pointers inside an RCU read-side section in both
completion handlers and keep it until they no longer use the substream.
Call synchronize_rcu() in the .close callbacks, after the pointer was
cleared, and in a new .sync_stop callback, which the PCM core calls
after a stop before the buffer is freed or reallocated. The capture
work, which writes to the capture buffer with tascam->lock held, is
covered by the same grace period; on close it is already cancelled.

The bug was found, and the reproducer and this fix were written, by AI
agents (Claude Mythos and Claude Opus models). The analysis and the
patch were reviewed by a human.

Reported-by: Hanxiang Xu <xuhx@hust.edu.cn>
Closes: https://lore.kernel.org/all/12a3a26a.26361.1a1d4e1ad57.Coremail.xuh=
x@hust.edu.cn/
Fixes: a2a2210f2c2e ("ALSA: usb-audio: us144mkii: Implement audio playback =
and feedback")
Fixes: c1bb0c13e430 ("ALSA: usb-audio: us144mkii: Implement audio capture a=
nd decoding")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Becholey <alex@becholey.ch>
---
Notes for reviewers (not part of the commit message):

Trigger: an emulated US-144MKII on an emulated xHCI controller (the
URBs are isochronous), QEMU arm64, KASAN. The device completes the
probe and then sends empty feedback packets. The program starts the
capture PCM, which starts all URBs, while the playback PCM is only
prepared, and closes the playback PCM when the driver logs "Feedback
sync lost" (a close of a PCM that is not running does not stop the
URBs). A variant does the same with the capture runtime (line 414).
Two more programs serve the device over USB/IP (vhci_hcd) and close
the PCMs at a high rate. The reproducers are available to maintainers
on request.

Decoded, torvalds/master 7e1392a42ea2 (the object is the kmalloc-2k
snd_pcm_runtime, allocated by snd_pcm_attach_substream() on open):

  BUG: KASAN: slab-use-after-free in feedback_urb_complete (sound/usb/usx2y=
/us144mkii_playback.c:402)
  Read of size 8 at addr ffff0000132ba078 by task repro/82
  Call trace:
   feedback_urb_complete (sound/usb/usx2y/us144mkii_playback.c:402)
   __usb_hcd_giveback_urb (drivers/usb/core/hcd.c:1657)
   usb_giveback_urb_bh (drivers/usb/core/hcd.c:1691)
   process_one_work (kernel/workqueue.c:3495)
   bh_worker (kernel/workqueue.c:3578 kernel/workqueue.c:3885)
  Freed by task 83:
   kfree (include/linux/kasan.h:235 mm/slub.c:2780 mm/slub.c:6630 mm/slub.c=
:6923)
   snd_pcm_detach_substream (sound/core/pcm.c:1014)
   snd_pcm_release_substream.part.0 (sound/core/pcm_native.c:2858)
   snd_pcm_release (sound/core/pcm_native.c:2840 sound/core/pcm_native.c:30=
37)
   __fput (fs/file_table.c:512)

Line 402 is the playback_rt->period_size read after the locked
section's dev_err(); line 414 (capture_rt->period_size) was hit by the
capture variant.

Testing, KASAN: without the patch the programs crashed in
feedback_urb_complete() on v7.3.1 (3/3 in this test, :402 and :414)
and on 7e1392a42ea2 (4/4 in the verification). With the whole series
applied, no us144mkii report in 27 runs: v7.3.1 15, 97d73c825122 7,
and 5 runs on v7.3.1 with a debug patch that holds the race window
open for 20 ms (181 windows held with a close pending; the same debug
kernel without this patch crashed 3/3 at the first window).

Four of the 27 runs (USB/IP programs) ended in a KASAN use-after-free
in vhci_urb_dequeue(), a race in the vhci_hcd test harness between
vhci_rx and usb_kill_anchored_urbs(), not in this driver; the same
programs with KASAN multi-shot and no panic ran the full time with no
report (3 runs).

Cost: one RCU grace period in each .close and in .sync_stop (prepare,
hw_params or hw_free after a stop). The capture work is covered by
.sync_stop because synchronize_rcu() also waits for regions with
interrupts disabled; an explicit rcu_read_lock() in
tascam_capture_work_handler() is a two-line alternative.

sound/usb/usx2y/us144mkii*.c are identical in v7.3.1, 7e1392a42ea2,
9d66f26fefac and 97d73c825122.

Thanks,
Alexandre Becholey

 sound/usb/usx2y/us144mkii_capture.c  |  3 +++
 sound/usb/usx2y/us144mkii_pcm.c      | 14 ++++++++++++++
 sound/usb/usx2y/us144mkii_pcm.h      |  8 ++++++++
 sound/usb/usx2y/us144mkii_playback.c | 23 ++++++++++++++++++-----
 4 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/sound/usb/usx2y/us144mkii_capture.c b/sound/usb/usx2y/us144mki=
i_capture.c
index 9c142a85e8b2..fa7b0cd94c71 100644
--- a/sound/usb/usx2y/us144mkii_capture.c
+++ b/sound/usb/usx2y/us144mkii_capture.c
@@ -40,6 +40,8 @@ static int tascam_capture_close(struct snd_pcm_substream =
*substream)
 =09=09tascam->capture_substream =3D NULL;
 =09/* The stop work may still be using this substream; wait for it. */
 =09flush_work(&tascam->stop_pcm_work);
+=09/* So may the URB completion handlers, see tascam_pcm_sync_stop(). */
+=09synchronize_rcu();
 =09/*
 =09 * The capture work keeps a pointer to the runtime, which is freed
 =09 * when this callback returns. The capture URBs (and so the work) keep
@@ -113,6 +115,7 @@ const struct snd_pcm_ops tascam_capture_ops =3D {
 =09.ioctl =3D snd_pcm_lib_ioctl,
 =09.hw_params =3D tascam_pcm_hw_params,
 =09.hw_free =3D tascam_pcm_hw_free,
+=09.sync_stop =3D tascam_pcm_sync_stop,
 =09.prepare =3D tascam_capture_prepare,
 =09.trigger =3D tascam_pcm_trigger,
 =09.pointer =3D tascam_capture_pointer,
diff --git a/sound/usb/usx2y/us144mkii_pcm.c b/sound/usb/usx2y/us144mkii_pc=
m.c
index 03dfb1f38801..5add9c1b253a 100644
--- a/sound/usb/usx2y/us144mkii_pcm.c
+++ b/sound/usb/usx2y/us144mkii_pcm.c
@@ -259,6 +259,20 @@ int tascam_pcm_hw_free(struct snd_pcm_substream *subst=
ream)
 =09return 0;
 }
=20
+int tascam_pcm_sync_stop(struct snd_pcm_substream *substream)
+{
+=09/*
+=09 * The URBs of both streams keep running as long as one of them does.
+=09 * The playback URB completion handler uses the substream inside an RCU
+=09 * read-side section, and the capture work writes to the buffer with
+=09 * tascam->lock held (interrupts disabled), which synchronize_rcu()
+=09 * also waits for.  Wait for both before the buffer is freed or
+=09 * reallocated.
+=09 */
+=09synchronize_rcu();
+=09return 0;
+}
+
 int tascam_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 =09struct tascam_card *tascam =3D snd_pcm_substream_chip(substream);
diff --git a/sound/usb/usx2y/us144mkii_pcm.h b/sound/usb/usx2y/us144mkii_pc=
m.h
index a130678405e3..22c05c61fdd8 100644
--- a/sound/usb/usx2y/us144mkii_pcm.h
+++ b/sound/usb/usx2y/us144mkii_pcm.h
@@ -139,6 +139,14 @@ int tascam_pcm_hw_params(struct snd_pcm_substream *sub=
stream,
  */
 int tascam_pcm_hw_free(struct snd_pcm_substream *substream);
=20
+/**
+ * tascam_pcm_sync_stop() - Waits for the URB completion handlers after a =
stop.
+ * @substream: The ALSA PCM substream.
+ *
+ * Return: 0.
+ */
+int tascam_pcm_sync_stop(struct snd_pcm_substream *substream);
+
 /**
  * tascam_pcm_trigger() - Triggers the start or stop of PCM streams.
  * @substream: The ALSA PCM substream.
diff --git a/sound/usb/usx2y/us144mkii_playback.c b/sound/usb/usx2y/us144mk=
ii_playback.c
index e6266488cf32..36d5417d9975 100644
--- a/sound/usb/usx2y/us144mkii_playback.c
+++ b/sound/usb/usx2y/us144mkii_playback.c
@@ -40,6 +40,8 @@ static int tascam_playback_close(struct snd_pcm_substream=
 *substream)
 =09=09tascam->playback_substream =3D NULL;
 =09/* The stop work may still be using this substream; wait for it. */
 =09flush_work(&tascam->stop_pcm_work);
+=09/* So may the URB completion handlers, see tascam_pcm_sync_stop(). */
+=09synchronize_rcu();
=20
 =09return 0;
 }
@@ -153,6 +155,7 @@ const struct snd_pcm_ops tascam_playback_ops =3D {
 =09.ioctl =3D snd_pcm_lib_ioctl,
 =09.hw_params =3D tascam_pcm_hw_params,
 =09.hw_free =3D tascam_pcm_hw_free,
+=09.sync_stop =3D tascam_pcm_sync_stop,
 =09.prepare =3D tascam_playback_prepare,
 =09.trigger =3D tascam_pcm_trigger,
 =09.pointer =3D tascam_playback_pointer,
@@ -180,9 +183,13 @@ void playback_urb_complete(struct urb *urb)
 =09if (!tascam || !atomic_read(&tascam->playback_active))
 =09=09goto out;
=20
-=09substream =3D tascam->playback_substream;
-=09if (!substream || !substream->runtime)
+=09/* Pairs with synchronize_rcu() in close and sync_stop. */
+=09rcu_read_lock();
+=09substream =3D READ_ONCE(tascam->playback_substream);
+=09if (!substream || !substream->runtime) {
+=09=09rcu_read_unlock();
 =09=09goto out;
+=09}
 =09runtime =3D substream->runtime;
=20
 =09scoped_guard(spinlock_irqsave, &tascam->lock) {
@@ -252,6 +259,7 @@ void playback_urb_complete(struct urb *urb)
 =09=09process_playback_routing_us144mkii(tascam, dst_buf, dst_buf,
 =09=09=09=09=09=09   frames_to_copy);
 =09}
+=09rcu_read_unlock();
=20
 =09urb->dev =3D tascam->dev;
 =09usb_get_urb(urb);
@@ -295,12 +303,16 @@ void feedback_urb_complete(struct urb *urb)
 =09if (!tascam || !atomic_read(&tascam->playback_active))
 =09=09goto out;
=20
-=09playback_ss =3D tascam->playback_substream;
-=09if (!playback_ss || !playback_ss->runtime)
+=09/* Pairs with synchronize_rcu() in close and sync_stop. */
+=09rcu_read_lock();
+=09playback_ss =3D READ_ONCE(tascam->playback_substream);
+=09if (!playback_ss || !playback_ss->runtime) {
+=09=09rcu_read_unlock();
 =09=09goto out;
+=09}
 =09playback_rt =3D playback_ss->runtime;
=20
-=09capture_ss =3D tascam->capture_substream;
+=09capture_ss =3D READ_ONCE(tascam->capture_substream);
 =09capture_rt =3D capture_ss ? capture_ss->runtime : NULL;
=20
 =09scoped_guard(spinlock_irqsave, &tascam->lock) {
@@ -444,6 +456,7 @@ void feedback_urb_complete(struct urb *urb)
 =09=09snd_pcm_period_elapsed(playback_ss);
 =09if (capture_period_elapsed)
 =09=09snd_pcm_period_elapsed(capture_ss);
+=09rcu_read_unlock();
=20
 =09urb->dev =3D tascam->dev;
 =09usb_get_urb(urb);

