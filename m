Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794813479;
	b=k3dCQr92qkCEwW5wNlDHNqeIVpqMmSmzgUVjjsP45cgAN/YE95xtFLWDWLdCoyVxqkHY
	 ud83WPCgHRL97mgWk2Ssngt5XF1YZPYp2JX59Hq3WpBbpxc+gWxvUusikSD+I9ABNIzAv
	 fjHdi4RuNDdeCeQY0pce+5gBeTh9gQxtB+M16x+5puvJ+uZ/F8a4CbViPk65Y6RE4fgjS
	 dTs+Ccm9Rw/HdyzkwKtkJBZtJ+PgQkKj6tbP5Q1zP6v6IFx5gRqDJg3VjYWDe3eLAOiKV
	 awYYmZcea4zlEJ69nNX98gUUVk9Om51F+T9mMCLnym3C6L1mj5ML/05/hGqMHKBD35A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813479;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=D3i8ClD+CaO0jDkdvaCe6R0rq9QijdYF3Az+wwQ2XAw=;
	b=UDSd70c+1uyaRpernvJ/G70TyXk+3avCB9Zqur4vopLDOw2KinhtfiFpNzleQGn5gzyy
	 rqw2Tshy5RClF/FgJQLasLcduVX7vuhP52YgKmgH072Xj1uAgHFf+5saeYm1vI4OX1JWm
	 Pmbt/4lLZvt5wyAt0TE05WUYHKCd9RyoCqLjdBrnOKWhod7J2UyWfG0SpJAGpuURu7w1J
	 gJE4xA6RbVTSZMk5DGyX5S8LjsLzRCDbjwq6Ay6Wmw7I2iCrDo2ZInfZkJw4NVBDrUa41
	 MdgY6Pu/KECs0d6eaCGQMHo6/QOf68X9DeeqcFEdUDM9RSYyhEP05jMTIy2LXoeRdtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=becholey.ch;
	spf=pass smtp.mailfrom=becholey.ch;
	dkim=pass header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=CYszrBXf;
	arc=none smtp.remote-ip=185.70.43.98
Received: from mail-4398.protonmail.ch (mail-4398.protonmail.ch [185.70.43.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A05606A32A
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 07:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53A05606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=becholey.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=becholey.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=CYszrBXf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=becholey.ch;
	s=protonmail; t=1794813476; x=1795072676;
	bh=D3i8ClD+CaO0jDkdvaCe6R0rq9QijdYF3Az+wwQ2XAw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CYszrBXf94nCIKSDB3Mu9D/54U5IvxGspNMpBkKvN2NtH5rlJmeyV0Tygh3QnyVwm
	 CvaQ1NP7UXG87kMUweiQbvA0dck8wIbisL7cnrZBS7HsIYSrcMJ6ueGrH+3+w8Z+gh
	 q3HJaxyWIZu6s20pYWnbqbLyUytKc8iVdMnE1Z7Hk0q2r9n4ra4Cg4pvs0/4b0KiTu
	 oOlV5KNe7xKZ98N5WhK8dl0bU56vLhp1/DsEXn0BukosNjeei84lVJaT2Ym94TH57+
	 n5o3KWhhe4NnoaV7HeVJbETx8AUYYzfDNizcwK8oolXNkQnbgEXKQM5x9/sROAThlh
	 f/6S7fqfxgTPg==
Date: Mon, 16 Nov 2026 07:17:51 +0000
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, =?utf-8?Q?=C5=A0erif_Rami?= <ramiserifpersia@gmail.com>
From: Alexandre Becholey <alex@becholey.ch>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, Hanxiang Xu <xuhx@hust.edu.cn>, Alexandre Becholey <alex@becholey.ch>, stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 4/5] ALSA: usx2y: us144mkii: wait for the URB completion handlers on stop and close
Message-ID: <20261116071707.217448-5-alex@becholey.ch>
In-Reply-To: <20261116071707.217448-1-alex@becholey.ch>
References: <20261116071707.217448-1-alex@becholey.ch>
Feedback-ID: 60743817:user:proton
X-Pm-Message-ID: 62f8a2a953d89b05fc6e79d7fca26aba022cf562
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

Make playback_substream and capture_substream RCU-protected pointers:
publish them with rcu_assign_pointer() in the .open callbacks, so that
the initialized runtime is visible before the pointer, clear them with
RCU_INIT_POINTER(), and read them with rcu_dereference() inside an RCU
read-side section that the completion handlers and the capture work
keep until they no longer use the substream. Call synchronize_rcu() in
the .close callbacks, after the pointer was cleared, and in a new
.sync_stop callback, which the PCM core calls after a stop before the
buffer is freed or reallocated.

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
Changes in v2:
- Make playback_substream and capture_substream __rcu pointers: publish
  them with rcu_assign_pointer(), clear them with RCU_INIT_POINTER() and
  read them with rcu_dereference(); the capture work now also reads the
  pointer and uses the substream inside an RCU read-side section (Sashiko
  review of v1:
  https://lore.kernel.org/all/sashiko-outbox-214863@kernel.org/).

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

Testing of v2 (whole series, KASAN, PROVE_LOCKING, PROVE_RCU): the
programs above (playback and capture variants, both USB/IP programs)
ran 3 times each on v7.3.1 and on 97d73c825122 with no us144mkii
report and no RCU or lockdep warning, plus 5 runs on v7.3.1 with the
20 ms debug window moved inside the new RCU read-side section of
feedback_urb_complete() (180 windows held with a close pending, no
report). Three USB/IP runs hit the vhci_urb_dequeue() harness race
again.

Testing of v1, KASAN: without the patch the programs crashed in
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
hw_params or hw_free after a stop). Since v2 the capture work holds an
RCU read-side section (guard(rcu)) while it uses the substream; its
loop does not sleep.

sound/usb/usx2y/us144mkii*.c are identical in v7.3.1, 7e1392a42ea2,
9d66f26fefac and 97d73c825122.

Thanks,
Alexandre Becholey

 sound/usb/usx2y/us144mkii.h          |  4 ++--
 sound/usb/usx2y/us144mkii_capture.c  | 13 ++++++++---
 sound/usb/usx2y/us144mkii_pcm.c      | 12 ++++++++++
 sound/usb/usx2y/us144mkii_pcm.h      |  8 +++++++
 sound/usb/usx2y/us144mkii_playback.c | 34 ++++++++++++++++++++--------
 5 files changed, 57 insertions(+), 14 deletions(-)

diff --git a/sound/usb/usx2y/us144mkii.h b/sound/usb/usx2y/us144mkii.h
index 95c4341f038a..7a482c65194e 100644
--- a/sound/usb/usx2y/us144mkii.h
+++ b/sound/usb/usx2y/us144mkii.h
@@ -209,8 +209,8 @@ struct tascam_card {
 =09struct snd_rawmidi *rmidi;
=20
 =09/* --- PCM Substreams --- */
-=09struct snd_pcm_substream *playback_substream;
-=09struct snd_pcm_substream *capture_substream;
+=09struct snd_pcm_substream __rcu *playback_substream;
+=09struct snd_pcm_substream __rcu *capture_substream;
=20
 =09/* --- URBs and Anchors --- */
 =09struct urb *playback_urbs[NUM_PLAYBACK_URBS];
diff --git a/sound/usb/usx2y/us144mkii_capture.c b/sound/usb/usx2y/us144mki=
i_capture.c
index 9c142a85e8b2..44a93cfe1ecf 100644
--- a/sound/usb/usx2y/us144mkii_capture.c
+++ b/sound/usb/usx2y/us144mkii_capture.c
@@ -17,7 +17,8 @@ static int tascam_capture_open(struct snd_pcm_substream *=
substream)
 =09struct tascam_card *tascam =3D snd_pcm_substream_chip(substream);
=20
 =09substream->runtime->hw =3D tascam_pcm_hw;
-=09tascam->capture_substream =3D substream;
+=09/* Pairs with rcu_dereference() in feedback_urb_complete() and the work=
. */
+=09rcu_assign_pointer(tascam->capture_substream, substream);
 =09atomic_set(&tascam->capture_active, 0);
=20
 =09return 0;
@@ -37,9 +38,11 @@ static int tascam_capture_close(struct snd_pcm_substream=
 *substream)
 =09struct tascam_card *tascam =3D snd_pcm_substream_chip(substream);
=20
 =09scoped_guard(spinlock_irqsave, &tascam->lock)
-=09=09tascam->capture_substream =3D NULL;
+=09=09RCU_INIT_POINTER(tascam->capture_substream, NULL);
 =09/* The stop work may still be using this substream; wait for it. */
 =09flush_work(&tascam->stop_pcm_work);
+=09/* So may the URB completion handlers, see tascam_pcm_sync_stop(). */
+=09synchronize_rcu();
 =09/*
 =09 * The capture work keeps a pointer to the runtime, which is freed
 =09 * when this callback returns. The capture URBs (and so the work) keep
@@ -113,6 +116,7 @@ const struct snd_pcm_ops tascam_capture_ops =3D {
 =09.ioctl =3D snd_pcm_lib_ioctl,
 =09.hw_params =3D tascam_pcm_hw_params,
 =09.hw_free =3D tascam_pcm_hw_free,
+=09.sync_stop =3D tascam_pcm_sync_stop,
 =09.prepare =3D tascam_capture_prepare,
 =09.trigger =3D tascam_pcm_trigger,
 =09.pointer =3D tascam_capture_pointer,
@@ -167,12 +171,15 @@ void tascam_capture_work_handler(struct work_struct *=
work)
 {
 =09struct tascam_card *tascam =3D
 =09=09container_of(work, struct tascam_card, capture_work);
-=09struct snd_pcm_substream *substream =3D tascam->capture_substream;
+=09struct snd_pcm_substream *substream;
 =09struct snd_pcm_runtime *runtime;
 =09u8 *raw_block =3D tascam->capture_decode_raw_block;
 =09s32 *decoded_block =3D tascam->capture_decode_dst_block;
 =09s32 *routed_block =3D tascam->capture_routing_buffer;
=20
+=09/* Pairs with synchronize_rcu() in close and sync_stop. */
+=09guard(rcu)();
+=09substream =3D rcu_dereference(tascam->capture_substream);
 =09if (!substream || !substream->runtime)
 =09=09return;
 =09runtime =3D substream->runtime;
diff --git a/sound/usb/usx2y/us144mkii_pcm.c b/sound/usb/usx2y/us144mkii_pc=
m.c
index 03dfb1f38801..7be6710e7fe3 100644
--- a/sound/usb/usx2y/us144mkii_pcm.c
+++ b/sound/usb/usx2y/us144mkii_pcm.c
@@ -259,6 +259,18 @@ int tascam_pcm_hw_free(struct snd_pcm_substream *subst=
ream)
 =09return 0;
 }
=20
+int tascam_pcm_sync_stop(struct snd_pcm_substream *substream)
+{
+=09/*
+=09 * The URBs of both streams keep running as long as one of them does.
+=09 * The URB completion handlers and the capture work use the substream
+=09 * inside an RCU read-side section; wait for them before the buffer is
+=09 * freed or reallocated.
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
index 7621d752c899..6fb3be2bacd9 100644
--- a/sound/usb/usx2y/us144mkii_playback.c
+++ b/sound/usb/usx2y/us144mkii_playback.c
@@ -17,7 +17,8 @@ static int tascam_playback_open(struct snd_pcm_substream =
*substream)
 =09struct tascam_card *tascam =3D snd_pcm_substream_chip(substream);
=20
 =09substream->runtime->hw =3D tascam_pcm_hw;
-=09tascam->playback_substream =3D substream;
+=09/* Pairs with rcu_dereference() in the URB completion handlers. */
+=09rcu_assign_pointer(tascam->playback_substream, substream);
 =09atomic_set(&tascam->playback_active, 0);
=20
 =09return 0;
@@ -37,9 +38,11 @@ static int tascam_playback_close(struct snd_pcm_substrea=
m *substream)
 =09struct tascam_card *tascam =3D snd_pcm_substream_chip(substream);
=20
 =09scoped_guard(spinlock_irqsave, &tascam->lock)
-=09=09tascam->playback_substream =3D NULL;
+=09=09RCU_INIT_POINTER(tascam->playback_substream, NULL);
 =09/* The stop work may still be using this substream; wait for it. */
 =09flush_work(&tascam->stop_pcm_work);
+=09/* So may the URB completion handlers, see tascam_pcm_sync_stop(). */
+=09synchronize_rcu();
=20
 =09return 0;
 }
@@ -153,6 +156,7 @@ const struct snd_pcm_ops tascam_playback_ops =3D {
 =09.ioctl =3D snd_pcm_lib_ioctl,
 =09.hw_params =3D tascam_pcm_hw_params,
 =09.hw_free =3D tascam_pcm_hw_free,
+=09.sync_stop =3D tascam_pcm_sync_stop,
 =09.prepare =3D tascam_playback_prepare,
 =09.trigger =3D tascam_pcm_trigger,
 =09.pointer =3D tascam_playback_pointer,
@@ -180,9 +184,13 @@ void playback_urb_complete(struct urb *urb)
 =09if (!tascam || !atomic_read(&tascam->playback_active))
 =09=09goto out;
=20
-=09substream =3D tascam->playback_substream;
-=09if (!substream || !substream->runtime)
+=09/* Pairs with synchronize_rcu() in close and sync_stop. */
+=09rcu_read_lock();
+=09substream =3D rcu_dereference(tascam->playback_substream);
+=09if (!substream || !substream->runtime) {
+=09=09rcu_read_unlock();
 =09=09goto out;
+=09}
 =09runtime =3D substream->runtime;
=20
 =09scoped_guard(spinlock_irqsave, &tascam->lock) {
@@ -252,6 +260,7 @@ void playback_urb_complete(struct urb *urb)
 =09=09process_playback_routing_us144mkii(tascam, dst_buf, dst_buf,
 =09=09=09=09=09=09   frames_to_copy);
 =09}
+=09rcu_read_unlock();
=20
 =09urb->dev =3D tascam->dev;
 =09usb_get_urb(urb);
@@ -296,12 +305,16 @@ void feedback_urb_complete(struct urb *urb)
 =09if (!tascam || !atomic_read(&tascam->playback_active))
 =09=09goto out;
=20
-=09playback_ss =3D tascam->playback_substream;
-=09if (!playback_ss || !playback_ss->runtime)
+=09/* Pairs with synchronize_rcu() in close and sync_stop. */
+=09rcu_read_lock();
+=09playback_ss =3D rcu_dereference(tascam->playback_substream);
+=09if (!playback_ss || !playback_ss->runtime) {
+=09=09rcu_read_unlock();
 =09=09goto out;
+=09}
 =09playback_rt =3D playback_ss->runtime;
=20
-=09capture_ss =3D tascam->capture_substream;
+=09capture_ss =3D rcu_dereference(tascam->capture_substream);
 =09capture_rt =3D capture_ss ? capture_ss->runtime : NULL;
=20
 =09scoped_guard(spinlock_irqsave, &tascam->lock) {
@@ -456,6 +469,7 @@ void feedback_urb_complete(struct urb *urb)
 =09=09snd_pcm_period_elapsed(playback_ss);
 =09if (capture_period_elapsed)
 =09=09snd_pcm_period_elapsed(capture_ss);
+=09rcu_read_unlock();
=20
 =09urb->dev =3D tascam->dev;
 =09usb_get_urb(urb);
@@ -479,8 +493,10 @@ void tascam_stop_pcm_work_handler(struct work_struct *=
work)
 =09struct snd_pcm_substream *playback_ss, *capture_ss;
=20
 =09scoped_guard(spinlock_irqsave, &tascam->lock) {
-=09=09playback_ss =3D tascam->playback_substream;
-=09=09capture_ss =3D tascam->capture_substream;
+=09=09playback_ss =3D rcu_dereference_protected(tascam->playback_substream=
,
+=09=09=09=09=09=09=09lockdep_is_held(&tascam->lock));
+=09=09capture_ss =3D rcu_dereference_protected(tascam->capture_substream,
+=09=09=09=09=09=09       lockdep_is_held(&tascam->lock));
 =09}
=20
 =09if (playback_ss)

