Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794677358;
	b=ytAGIRSYwUukXmZOjM1dX3MuDVoeAabZVFpVnFkD0RKAbm11DePbrpdKbSSoaKrAu+vi
	 DKbpDn2OicE9viOYeXF8/ANX6uiidlnFN6UUPbugzREgBLYneczPKVpA3QkzoAvq/OCH0
	 8KKndgL7hDuJ9W3EUlbyapSMuN/udDu5i5Va7Lzy4xRJ6JF5otyQcCqyFTEbNrT/Be7EH
	 B2fJy0cWOqaL9AQOgxhFPuDlz/dhxPtbD5eXvEVHXa+yH4oFAO7XVSY1rG+lD+d/RaWpG
	 bDm2ROCcuvOHXT9P4HljtHj/WwAdIjBxxRvF9XWq30GZHhPFgiUbAATgRm9BuPyprgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794677358;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Ybh1orfb8A+hMu6JRpXnjbCXh3N9F/ZtSbUT1lv0xWw=;
	b=DlTCQo/vm1xfKTBIHweixhi+g12FshpvHqvIA5bUVRBaEvaVkgrppX3wWOWybgGEyaZs
	 KTP/gbEMSnrN3/KFCjCyBcF1nDktkqs7TdpDJfKo61BGSlJs51BFz2CwjiEWQ9Ie3rvc4
	 +yYBmcKyv6JkxCou0DAKh77AXo0PZVjimzMBlKIrdib04bxrXAPohN8HIHR20lgW1CQS1
	 V50HJDgidDduyK5s8C7gSzHHfbETl3IZcVo4es8GVFt05egjqKFOu4HMggOSIOjj0sEs2
	 0gPzOJ6lYeWwig90fd0T6pR9iXGQxFH6vdSi5uk2CBDChg1bkI71oHli2xikI67TF/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=becholey.ch;
	spf=pass smtp.mailfrom=becholey.ch;
	dkim=pass header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=fYImpxWX;
	arc=none smtp.remote-ip=79.135.106.105
Received: from mail-106105.protonmail.ch (mail-106105.protonmail.ch [79.135.106.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55220606A327
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 17:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55220606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=becholey.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=becholey.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=fYImpxWX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=becholey.ch;
	s=protonmail; t=1794677354; x=1794936554;
	bh=Ybh1orfb8A+hMu6JRpXnjbCXh3N9F/ZtSbUT1lv0xWw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=fYImpxWXUXbRjLaY3xkxyYB/RZg38SNqRq3aXR5RxCH4pXIYQLWww1KNJY/fEjkCP
	 mjI7qkAZjmQvM3tw9GeQDzx54oWS1eK9doEYKVboF6RgCSaIADX7T3gW9dzjn87msP
	 iWsyfr3yzYeR3kOjGe7tnpUxAGwg8vaNqlVFwy/zKIvj9OgbNRitri1daJS+WGVVAe
	 8ln3VxrAg9MOQmmeBp+4Ixha6LhWJlKJHmGKKcfXcc2KGfVtwZhAbvpF3hqjWVse7D
	 luJ3hBk0YJHYgNHmyypJEjLHAj8eIzuF5ML4FpXIo+VNWiJPlYSRq/9oI/qtXFTr4I
	 5VoPcCMxTbf6A==
Date: Sat, 14 Nov 2026 17:29:09 +0000
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, =?utf-8?Q?=C5=A0erif_Rami?= <ramiserifpersia@gmail.com>
From: Alexandre Becholey <alex@becholey.ch>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, Hanxiang Xu <xuhx@hust.edu.cn>, Alexandre Becholey <alex@becholey.ch>, stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/5] ALSA: usx2y: us144mkii: do not restart the stream while stop_work runs
Message-ID: <20261114172806.88710-6-alex@becholey.ch>
In-Reply-To: <20261114172806.88710-1-alex@becholey.ch>
References: <20261114172806.88710-1-alex@becholey.ch>
Feedback-ID: 60743817:user:proton
X-Pm-Message-ID: 38c2bad81bf20be97b7bd1c9ec524b2d54f4795c
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

tascam_pcm_trigger(STOP) clears the stream flags and schedules
stop_work, which kills the URBs and then sets active_urbs to 0.
START only checks active_urbs > 0 before it anchors and submits the
URBs again, and that check does not hold:

 - START sets playback_active before the check, so when it fails with
   -EAGAIN the PCM core undoes it with trigger(STOP), which schedules
   stop_work again. If the work is running, it runs once more as soon
   as it has finished, i.e. exactly when the next START passes the
   check. That stale run kills the feedback URBs START has just
   submitted, misses the playback URBs submitted behind it, and resets
   active_urbs to 0 while they are in flight.
 - The START error path decrements active_urbs for the URB that failed
   to submit, which was never counted.
 - A STOP of the other substream can schedule stop_work while START is
   still submitting, as the submission is done without tascam->lock.

The next STOP and START then anchor and submit playback URBs that are
still anchored and owned by the host controller, which corrupts the
anchor list. Retrying START after a STOP from user space, which the
-EAGAIN invites, triggers it within seconds. On torvalds/master
7e1392a42ea2:

  URB 00000000d35257ae submitted while active
  WARNING: drivers/usb/core/urb.c:387 at usb_submit_urb+0x1318/0x1630, CPU#=
0: repro/77

and in another run, without the WARNING first, a "list_add double add"
from usb_anchor_urb() in tascam_pcm_trigger():

  kernel BUG at lib/list_debug.c:35!
  Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP

Track a queued or running stop_work in a new stop_pending flag, set
with the STOP under tascam->lock and cleared by the work under the lock
after the URBs are dead, and refuse START with -EAGAIN while it is set,
without touching the stream flags. Submit the URBs with the lock held,
so that a STOP cannot come in between, and on a failed submission stop
through the same path instead of miscounting active_urbs. Flush
stop_work instead of cancelling it on suspend, so stop_pending cannot
be left set.

The bug was found, and the reproducer and this fix were written, by AI
agents (Claude Mythos and Claude Opus models). The analysis and the
patch were reviewed by a human.

Fixes: a2a2210f2c2e ("ALSA: usb-audio: us144mkii: Implement audio playback =
and feedback")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Becholey <alex@becholey.ch>
---
Notes for reviewers (not part of the commit message):

Trigger: an emulated US-144MKII on an emulated xHCI controller, QEMU
arm64, KASAN; the device only streams normally. A local program with
access to the PCM device stops (DROP) a running playback substream and
retries START in a loop while the driver answers -EAGAIN ("Cannot
start, URBs still active"), then does one more DROP/PREPARE/START. A
device can supply the STOP itself with bad feedback packets (the
stop_pcm_work path of patch 1/5); that variant was seen in our tests
of 1/5 over USB/IP but not reproduced on its own. The reproducer is
available to maintainers on request.

Decoded, torvalds/master 7e1392a42ea2:

  WARNING: drivers/usb/core/urb.c:387 at usb_submit_urb+0x1318/0x1630, CPU#=
0: repro/77
  Call trace:
   usb_submit_urb (drivers/usb/core/urb.c:387 (discriminator 12)) (P)
   tascam_pcm_trigger (sound/usb/usx2y/us144mkii_pcm.c:320 (discriminator 1=
))
   snd_pcm_do_start (sound/core/pcm_native.c:1530 sound/core/pcm_native.c:1=
523)
   snd_pcm_action_single (sound/core/pcm_native.c:1384)
   snd_pcm_action (sound/core/pcm_native.c:1467)
   snd_pcm_common_ioctl (sound/core/pcm_native.c:1480 sound/core/pcm_native=
.c:1584 sound/core/pcm_native.c:3526)
   snd_pcm_ioctl (sound/core/pcm_native.c:3591)

The list_add case is usb_anchor_urb() (drivers/usb/core/urb.c:132)
from tascam_pcm_trigger() (us144mkii_pcm.c:318). On v7.3.1 the same
program shows the WARNING at urb.c:379, and runs that continue past it
end in "list_del corruption" in __usb_unanchor_urb().

Testing, KASAN, panic_on_warn: without the patch the program hit the
WARNING or the list corruption in every run (v7.3.1 1/1 in this test;
16/16 in the verification on v7.3.1, 7e1392a42ea2 and v7.3.1 with
patches 1/5..3/5). With the whole series applied: no report in 18
runs (v7.3.1 14, 97d73c825122 4), 593 to 1114 STOP/START cycles per
run, with the new stop_pending check refusing a START in about a
third of the cycles of the main program. A control run that waits
200 ms after each DROP streams normally: 187 of 187 STARTs succeed.

Not changed here (pre-existing): the .open callbacks clear the
*_active flags without stopping anything, and PAUSE_RELEASE is not
handled although SNDRV_PCM_INFO_PAUSE is advertised; source reading
only, not tested.

Thanks,
Alexandre Becholey

 sound/usb/usx2y/us144mkii.c     |   5 +-
 sound/usb/usx2y/us144mkii.h     |   2 +
 sound/usb/usx2y/us144mkii_pcm.c | 148 ++++++++++++++++----------------
 3 files changed, 78 insertions(+), 77 deletions(-)

diff --git a/sound/usb/usx2y/us144mkii.c b/sound/usb/usx2y/us144mkii.c
index 58ef23146f20..8270e09281cb 100644
--- a/sound/usb/usx2y/us144mkii.c
+++ b/sound/usb/usx2y/us144mkii.c
@@ -266,7 +266,10 @@ void tascam_stop_work_handler(struct work_struct *work=
)
 =09usb_kill_anchored_urbs(&tascam->playback_anchor);
 =09usb_kill_anchored_urbs(&tascam->feedback_anchor);
 =09usb_kill_anchored_urbs(&tascam->capture_anchor);
+
+=09guard(spinlock_irqsave)(&tascam->lock);
 =09atomic_set(&tascam->active_urbs, 0);
+=09tascam->stop_pending =3D false;
 }
=20
 /*
@@ -311,7 +314,7 @@ static int tascam_suspend(struct usb_interface *intf, p=
m_message_t message)
=20
 =09snd_pcm_suspend_all(tascam->pcm);
=20
-=09cancel_work_sync(&tascam->stop_work);
+=09flush_work(&tascam->stop_work);
 =09cancel_work_sync(&tascam->capture_work);
 =09cancel_work_sync(&tascam->midi_in_work);
 =09cancel_work_sync(&tascam->midi_out_work);
diff --git a/sound/usb/usx2y/us144mkii.h b/sound/usb/usx2y/us144mkii.h
index 95c4341f038a..852551e0b5d0 100644
--- a/sound/usb/usx2y/us144mkii.h
+++ b/sound/usb/usx2y/us144mkii.h
@@ -174,6 +174,7 @@ struct us144mkii_frame_pattern_observer {
  *
  * @lock: Main spinlock for protecting shared driver state.
  * @active_urbs: Atomic counter for active URBs.
+ * @stop_pending: stop_work is queued or running; protected by @lock.
  * @current_rate: Currently configured sample rate of the device.
  * @line_out_source: Source for Line Outputs (0: Playback 1-2, 1: Playback=
 3-4).
  * @digital_out_source: Source for Digital Outputs (0: Playback 1-2, 1: Pl=
ayback
@@ -232,6 +233,7 @@ struct tascam_card {
 =09atomic_t playback_active;
 =09atomic_t capture_active;
 =09atomic_t active_urbs;
+=09bool stop_pending;
 =09int current_rate;
=20
 =09/* --- Playback State --- */
diff --git a/sound/usb/usx2y/us144mkii_pcm.c b/sound/usb/usx2y/us144mkii_pc=
m.c
index 5add9c1b253a..0890884a55eb 100644
--- a/sound/usb/usx2y/us144mkii_pcm.c
+++ b/sound/usb/usx2y/us144mkii_pcm.c
@@ -278,93 +278,89 @@ int tascam_pcm_trigger(struct snd_pcm_substream *subs=
tream, int cmd)
 =09struct tascam_card *tascam =3D snd_pcm_substream_chip(substream);
 =09int err =3D 0;
 =09int i;
-=09bool do_start =3D false;
-=09bool do_stop =3D false;
-
-=09scoped_guard(spinlock_irqsave, &tascam->lock) {
-=09=09switch (cmd) {
-=09=09case SNDRV_PCM_TRIGGER_START:
-=09=09case SNDRV_PCM_TRIGGER_RESUME:
-=09=09=09if (!atomic_read(&tascam->playback_active)) {
-=09=09=09=09atomic_set(&tascam->playback_active, 1);
-=09=09=09=09atomic_set(&tascam->capture_active, 1);
-=09=09=09=09do_start =3D true;
-=09=09=09}
-=09=09=09break;
-=09=09case SNDRV_PCM_TRIGGER_STOP:
-=09=09case SNDRV_PCM_TRIGGER_SUSPEND:
-=09=09case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-=09=09=09if (atomic_read(&tascam->playback_active)) {
-=09=09=09=09atomic_set(&tascam->playback_active, 0);
-=09=09=09=09atomic_set(&tascam->capture_active, 0);
-=09=09=09=09do_stop =3D true;
-=09=09=09}
-=09=09=09break;
-=09=09default:
-=09=09=09err =3D -EINVAL;
-=09=09=09break;
-=09=09}
-=09}
=20
-=09if (do_start) {
-=09=09if (atomic_read(&tascam->active_urbs) > 0) {
+=09/*
+=09 * Hold the lock while submitting, so that a STOP of the other
+=09 * substream cannot schedule stop_work in the middle of a START.
+=09 */
+=09guard(spinlock_irqsave)(&tascam->lock);
+
+=09switch (cmd) {
+=09case SNDRV_PCM_TRIGGER_START:
+=09case SNDRV_PCM_TRIGGER_RESUME:
+=09=09if (atomic_read(&tascam->playback_active))
+=09=09=09return 0;
+=09=09/*
+=09=09 * stop_work kills the URBs of the previous run asynchronously;
+=09=09 * they must not be anchored and submitted again before it is
+=09=09 * done.
+=09=09 */
+=09=09if (tascam->stop_pending ||
+=09=09    atomic_read(&tascam->active_urbs) > 0) {
 =09=09=09dev_warn(tascam->card->dev,
 =09=09=09=09 "Cannot start, URBs still active.\n");
 =09=09=09return -EAGAIN;
 =09=09}
+=09=09atomic_set(&tascam->playback_active, 1);
+=09=09atomic_set(&tascam->capture_active, 1);
+=09=09break;
+=09case SNDRV_PCM_TRIGGER_STOP:
+=09case SNDRV_PCM_TRIGGER_SUSPEND:
+=09case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+=09=09if (!atomic_read(&tascam->playback_active))
+=09=09=09return 0;
+=09=09goto stop;
+=09default:
+=09=09return -EINVAL;
+=09}
=20
-=09=09for (i =3D 0; i < NUM_FEEDBACK_URBS; i++) {
-=09=09=09usb_get_urb(tascam->feedback_urbs[i]);
-=09=09=09usb_anchor_urb(tascam->feedback_urbs[i],
-=09=09=09=09=09       &tascam->feedback_anchor);
-=09=09=09err =3D usb_submit_urb(tascam->feedback_urbs[i],
-=09=09=09=09=09=09     GFP_ATOMIC);
-=09=09=09if (err < 0) {
-=09=09=09=09usb_unanchor_urb(tascam->feedback_urbs[i]);
-=09=09=09=09usb_put_urb(tascam->feedback_urbs[i]);
-=09=09=09=09atomic_dec(&tascam->active_urbs);
-=09=09=09=09goto start_rollback;
-=09=09=09}
-=09=09=09atomic_inc(&tascam->active_urbs);
+=09for (i =3D 0; i < NUM_FEEDBACK_URBS; i++) {
+=09=09usb_get_urb(tascam->feedback_urbs[i]);
+=09=09usb_anchor_urb(tascam->feedback_urbs[i],
+=09=09=09       &tascam->feedback_anchor);
+=09=09err =3D usb_submit_urb(tascam->feedback_urbs[i], GFP_ATOMIC);
+=09=09if (err < 0) {
+=09=09=09usb_unanchor_urb(tascam->feedback_urbs[i]);
+=09=09=09usb_put_urb(tascam->feedback_urbs[i]);
+=09=09=09goto start_rollback;
 =09=09}
-=09=09for (i =3D 0; i < NUM_PLAYBACK_URBS; i++) {
-=09=09=09usb_get_urb(tascam->playback_urbs[i]);
-=09=09=09usb_anchor_urb(tascam->playback_urbs[i],
-=09=09=09=09=09       &tascam->playback_anchor);
-=09=09=09err =3D usb_submit_urb(tascam->playback_urbs[i],
-=09=09=09=09=09=09     GFP_ATOMIC);
-=09=09=09if (err < 0) {
-=09=09=09=09usb_unanchor_urb(tascam->playback_urbs[i]);
-=09=09=09=09usb_put_urb(tascam->playback_urbs[i]);
-=09=09=09=09atomic_dec(&tascam->active_urbs);
-=09=09=09=09goto start_rollback;
-=09=09=09}
-=09=09=09atomic_inc(&tascam->active_urbs);
+=09=09atomic_inc(&tascam->active_urbs);
+=09}
+=09for (i =3D 0; i < NUM_PLAYBACK_URBS; i++) {
+=09=09usb_get_urb(tascam->playback_urbs[i]);
+=09=09usb_anchor_urb(tascam->playback_urbs[i],
+=09=09=09       &tascam->playback_anchor);
+=09=09err =3D usb_submit_urb(tascam->playback_urbs[i], GFP_ATOMIC);
+=09=09if (err < 0) {
+=09=09=09usb_unanchor_urb(tascam->playback_urbs[i]);
+=09=09=09usb_put_urb(tascam->playback_urbs[i]);
+=09=09=09goto start_rollback;
 =09=09}
-=09=09for (i =3D 0; i < NUM_CAPTURE_URBS; i++) {
-=09=09=09usb_get_urb(tascam->capture_urbs[i]);
-=09=09=09usb_anchor_urb(tascam->capture_urbs[i],
-=09=09=09=09       &tascam->capture_anchor);
-=09=09=09err =3D usb_submit_urb(tascam->capture_urbs[i],
-=09=09=09=09=09     GFP_ATOMIC);
-=09=09=09if (err < 0) {
-=09=09=09=09usb_unanchor_urb(tascam->capture_urbs[i]);
-=09=09=09=09usb_put_urb(tascam->capture_urbs[i]);
-=09=09=09=09atomic_dec(&tascam->active_urbs);
-=09=09=09=09goto start_rollback;
-=09=09=09}
-=09=09=09atomic_inc(&tascam->active_urbs);
+=09=09atomic_inc(&tascam->active_urbs);
+=09}
+=09for (i =3D 0; i < NUM_CAPTURE_URBS; i++) {
+=09=09usb_get_urb(tascam->capture_urbs[i]);
+=09=09usb_anchor_urb(tascam->capture_urbs[i],
+=09=09=09       &tascam->capture_anchor);
+=09=09err =3D usb_submit_urb(tascam->capture_urbs[i], GFP_ATOMIC);
+=09=09if (err < 0) {
+=09=09=09usb_unanchor_urb(tascam->capture_urbs[i]);
+=09=09=09usb_put_urb(tascam->capture_urbs[i]);
+=09=09=09goto start_rollback;
 =09=09}
-
-=09=09return 0;
-start_rollback:
-=09=09dev_err(tascam->card->dev,
-=09=09=09"Failed to submit URBs to start stream: %d\n", err);
-=09=09do_stop =3D true;
+=09=09atomic_inc(&tascam->active_urbs);
 =09}
=20
-=09if (do_stop)
-=09=09schedule_work(&tascam->stop_work);
+=09return 0;
+
+start_rollback:
+=09dev_err(tascam->card->dev,
+=09=09"Failed to submit URBs to start stream: %d\n", err);
+stop:
+=09atomic_set(&tascam->playback_active, 0);
+=09atomic_set(&tascam->capture_active, 0);
+=09tascam->stop_pending =3D true;
+=09schedule_work(&tascam->stop_work);
=20
 =09return err;
 }

