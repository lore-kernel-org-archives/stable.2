Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794813460;
	b=KHRtEnrxA7iPatvkfYtPtWYWG/BhfSsG13eaDT5SfCnNtLUl2Fbr70S66rfH+ah4Yk3e
	 nkjK82eykoOwyz/HfM7t9d+TeP/TQXsV7af/gMDw6sENuYZMX6HtNdrO/xRvy5cSZ3AAA
	 azpdffvBSPiQi7QM/rGHVeuKO4xePIEK9UT97hi4LtTulbMET0Y3FxFXa5netBf6uqtOP
	 PFtdLWZfyL6twWJvqXsq4gZlUnA7SzOpQgkkooXoB3/RiFQ1hyiB3iku4p0k1+3eoxFM6
	 usuWIAY6G6nz1E9wyz4ST+60o2yNH/eI15IygPxlireBZOnV4g0/ddfNKsUccp2PB4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813460;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=KZWLSazTcz/mu2ScepEs7bxsTPuGDUzfcRzi4Nrn8ag=;
	b=l/ZE1AUv6SYVbfv5z1LPQ+L6lWBj23SU2D/zXLjXU6MEEfUAq/u04BoioUSHCd4D6OFK
	 KxmKwi9rIHhpKyDizfh1g+ryhvMHg/EWFI0Dj27nieQ4LNx2aaV+iBi+muDo6yBrokIBi
	 M1nMww/c18OTELwZ3WxLwvx0f96514cYIRVM0uzjc2c4HiNDb4vB4uie0eg5i8dkBe67Q
	 G+Pl55/pOauZQ76tZ9R/IpIGqsAT3gAM2/IAn4pKXObwNT9A+aGvp6qQbjrcB2Mj2cPBC
	 hFsGZRKd5wtjAs1IKAW6FPg14ZEsEzAVta/xI7tHI3WW2oEogc9JRDWX5lGyO0LG+kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=becholey.ch;
	spf=pass smtp.mailfrom=becholey.ch;
	dkim=pass header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=FIgfEf7+;
	arc=none smtp.remote-ip=185.70.43.18
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DAD606A32C;
	Mon, 16 Nov 2026 07:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93DAD606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=becholey.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=becholey.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=FIgfEf7+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=becholey.ch;
	s=protonmail; t=1794813457; x=1795072657;
	bh=KZWLSazTcz/mu2ScepEs7bxsTPuGDUzfcRzi4Nrn8ag=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FIgfEf7+GKoeKbDFQkHuBEHMfAdG9FNClJa3IBtPR95NtjS6mwJTzXf5nPUqKXmFN
	 y0T7QdE37WHopmVPw2xlHK4qnmqgscJcrtAk1Xwz8uFGDCPRi9VJiYg6yhNeEMizu1
	 b6/Fapl/Qniv5xAh8yuY/DVJHA727adtLcsqUbAwmB2uM0+TBetnG/Dl7Cl1DWIlmI
	 zUGprzncxmln+i1u3RASFnGeyf2L3JZaXKj+UHbdTV7KhZDL2Oo//N6uaBB0r/7S6H
	 ogTWQOCB1cSfNGOp9RgOiSShlQHxqaQjsmBcoO6FE7e0N52cUYPjqjtXUumz196yWb
	 I9ZrCXxlaQjhw==
Date: Mon, 16 Nov 2026 07:17:33 +0000
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, =?utf-8?Q?=C5=A0erif_Rami?= <ramiserifpersia@gmail.com>
From: Alexandre Becholey <alex@becholey.ch>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, Hanxiang Xu <xuhx@hust.edu.cn>, Alexandre Becholey <alex@becholey.ch>, stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 1/5] ALSA: usx2y: us144mkii: fix stop_pcm_work race with PCM close
Message-ID: <20261116071707.217448-2-alex@becholey.ch>
In-Reply-To: <20261116071707.217448-1-alex@becholey.ch>
References: <20261116071707.217448-1-alex@becholey.ch>
Feedback-ID: 60743817:user:proton
X-Pm-Message-ID: d59f15a6d6bc4233242fd987d628ee34c4903ce0
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

The feedback URB completion handler schedules stop_pcm_work when the
device stops sending valid feedback. The work handler then calls
snd_pcm_stop() on tascam->playback_substream and
tascam->capture_substream without the stream lock, and nothing keeps
these substreams open while it runs: the PCM .close callbacks only clear
the pointers and do not wait for the work.

If the PCM is closed while the work is running, snd_pcm_detach_substream()
frees the runtime under it, and the work then accesses the freed runtime
in snd_pcm_post_stop(), or dereferences a NULL substream->runtime in
snd_pcm_do_stop(), depending on how far the close has got. A USB device
can fire the work whenever it wants by sending bad feedback packets, so
a malicious device plus a process closing the PCM can trigger this.
With KASAN, on torvalds/master 067c5c24cef2:

  BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave+0xb0/0x104
  Workqueue: events tascam_stop_pcm_work_handler

Clear the substream pointers under tascam->lock in the .close callbacks
and flush stop_pcm_work afterwards, so the work can no longer run on a
closing substream. In the work, read the pointers under the same lock
and stop the streams with snd_pcm_stop_xrun(), which takes the stream
lock and checks that the stream is still running. The lock is dropped
before snd_pcm_stop_xrun() because the trigger callback takes
tascam->lock with the stream lock held.

Found with an emulated US-144MKII device (USB/IP, vhci_hcd).

The bug was found, and the reproducer and this fix were written, by AI
agents (Claude Mythos and Claude Opus models). The analysis and the
patch were reviewed by a human.

Reported-by: Hanxiang Xu <xuhx@hust.edu.cn>
Closes: https://lore.kernel.org/all/6891aa7d.26365.1a1d4e2c4e4.Coremail.xuh=
x@hust.edu.cn/
Fixes: a2a2210f2c2e ("ALSA: usb-audio: us144mkii: Implement audio playback =
and feedback")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Becholey <alex@becholey.ch>
---
Changes in v2:
- no change.

Notes for reviewers (not part of the commit message):

Trigger: an emulated TASCAM US-144MKII served over USB/IP to vhci_hcd
(an AF_UNIX socketpair inside the VM; dummy_hcd cannot do isochronous
transfers) under QEMU, arm64, KASAN. The program opens a PCM and
starts streaming; the device sends invalid feedback packets until the
driver logs "Fatal: Feedback sync lost. Stopping stream." and schedules
stop_pcm_work, while the program closes the PCM. The reproducer is availabl=
e to maintainers on request.

Decoded trace, torvalds/master 067c5c24cef2 (arm64, QEMU virt); the
object is the kmalloc-2k snd_pcm_runtime, allocated by
snd_pcm_attach_substream() on open and freed by
snd_pcm_detach_substream() from snd_pcm_release() on close:

  BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave (include/linux/=
spinlock_api_smp.h:155 (discriminator 1) kernel/locking/spinlock.c:181 (dis=
criminator 1))
  Read of size 1 at addr ffff00001318a180 by task kworker/1:0/24
  CPU: 1 UID: 0 PID: 24 Comm: kworker/1:0 Not tainted 7.4.0-rc2+ #1 PREEMPT=
(full)
  Hardware name: linux,dummy-virt (DT)
  Workqueue: events tascam_stop_pcm_work_handler
  Call trace:
   show_stack (arch/arm64/kernel/stacktrace.c:498 arch/arm64/kernel/stacktr=
ace.c:499) (C)
   dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
   print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
   kasan_report (mm/kasan/report.c:595)
   __kasan_check_byte (mm/kasan/common.c:585)
   lock_acquire (include/linux/kasan.h:402 (discriminator 1) kernel/locking=
/lockdep.c:5916 (discriminator 1) kernel/locking/lockdep.c:5899 (discrimina=
tor 1))
   _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:155 (discrimina=
tor 1) kernel/locking/spinlock.c:181 (discriminator 1))
   __wake_up (kernel/sched/wait.c:124 (discriminator 3) kernel/sched/wait.c=
:146 (discriminator 3))
   snd_pcm_post_stop (sound/core/pcm_native.c:1622)
   snd_pcm_action_single (sound/core/pcm_native.c:1386)
   snd_pcm_action (sound/core/pcm_native.c:1467)
   snd_pcm_stop (sound/core/pcm_native.c:1642)
   tascam_stop_pcm_work_handler (sound/usb/usx2y/us144mkii_playback.c:453)
   process_one_work (kernel/workqueue.c:3495)
   worker_thread (kernel/workqueue.c:3578 kernel/workqueue.c:3659)
   kthread (kernel/kthread.c:436)
   ret_from_fork (arch/arm64/kernel/entry.S:870)

On v7.3.1 the same reproducer also ends in
"KASAN: null-ptr-deref in range [0x1c0-0x1c7]" in snd_pcm_do_stop()
called from tascam_stop_pcm_work_handler() (us144mkii_playback.c:453),
the snd_pcm_stop() call this patch replaces.

sound/usb/usx2y/us144mkii*.c are identical in v7.3.1, 067c5c24cef2
and 9d66f26fefac.

Testing of v2 (whole series, KASAN, PROVE_LOCKING, PROVE_RCU): the
main USB/IP program ran 3 times each on v7.3.1 and 97d73c825122; the
stop work fired 3000 times per run and no run showed a report.

Testing of v1, KASAN: without the patch every run crashed in
tascam_stop_pcm_work_handler (v7.3.1 3/3, 067c5c24cef2 1/1). With the
patch no run showed this crash (v7.3.1 0/14 with three test programs,
067c5c24cef2 0/5 with one).
With patches 1/5..3/5 applied (v7.3.1, the same three test programs,
8 runs), the stop work fired 10 to 1740 times per run and no run
showed this crash; 4 of those 8 runs ended in the first two other
problems listed below. These programs were not re-run with 4/5 and
5/5 added; those patches were tested with their own reproducers.

17 of the 19 runs with this patch alone still crashed elsewhere:
- 12 runs: list_del corruption in __usb_unanchor_urb(), on v7.3.1
  after a WARNING at drivers/usb/core/urb.c:379 in the stream start
  path (that WARNING was also seen without the patch); fixed by
  patch 5/5;
- 4 runs: KASAN use-after-free in vhci_urb_dequeue() from
  usb_kill_anchored_urbs() in tascam_stop_work_handler(), a race in
  the vhci_hcd test harness, not in this driver;
- 1 run: KASAN slab-use-after-free in feedback_urb_complete()
  (us144mkii_playback.c:347, reading playback_rt->rate); fixed by
  patch 4/5.

Thanks,
Alexandre Becholey

 sound/usb/usx2y/us144mkii_capture.c  |  5 ++++-
 sound/usb/usx2y/us144mkii_playback.c | 19 ++++++++++++++-----
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/sound/usb/usx2y/us144mkii_capture.c b/sound/usb/usx2y/us144mki=
i_capture.c
index d7cdf9e0f685..30cdd73ca99c 100644
--- a/sound/usb/usx2y/us144mkii_capture.c
+++ b/sound/usb/usx2y/us144mkii_capture.c
@@ -36,7 +36,10 @@ static int tascam_capture_close(struct snd_pcm_substream=
 *substream)
 {
 =09struct tascam_card *tascam =3D snd_pcm_substream_chip(substream);
=20
-=09tascam->capture_substream =3D NULL;
+=09scoped_guard(spinlock_irqsave, &tascam->lock)
+=09=09tascam->capture_substream =3D NULL;
+=09/* The stop work may still be using this substream; wait for it. */
+=09flush_work(&tascam->stop_pcm_work);
=20
 =09return 0;
 }
diff --git a/sound/usb/usx2y/us144mkii_playback.c b/sound/usb/usx2y/us144mk=
ii_playback.c
index 7efaca0a6489..0df95dbf585d 100644
--- a/sound/usb/usx2y/us144mkii_playback.c
+++ b/sound/usb/usx2y/us144mkii_playback.c
@@ -36,7 +36,10 @@ static int tascam_playback_close(struct snd_pcm_substrea=
m *substream)
 {
 =09struct tascam_card *tascam =3D snd_pcm_substream_chip(substream);
=20
-=09tascam->playback_substream =3D NULL;
+=09scoped_guard(spinlock_irqsave, &tascam->lock)
+=09=09tascam->playback_substream =3D NULL;
+=09/* The stop work may still be using this substream; wait for it. */
+=09flush_work(&tascam->stop_pcm_work);
=20
 =09return 0;
 }
@@ -448,9 +451,15 @@ void tascam_stop_pcm_work_handler(struct work_struct *=
work)
 {
 =09struct tascam_card *tascam =3D
 =09=09container_of(work, struct tascam_card, stop_pcm_work);
+=09struct snd_pcm_substream *playback_ss, *capture_ss;
+
+=09scoped_guard(spinlock_irqsave, &tascam->lock) {
+=09=09playback_ss =3D tascam->playback_substream;
+=09=09capture_ss =3D tascam->capture_substream;
+=09}
=20
-=09if (tascam->playback_substream)
-=09=09snd_pcm_stop(tascam->playback_substream, SNDRV_PCM_STATE_XRUN);
-=09if (tascam->capture_substream)
-=09=09snd_pcm_stop(tascam->capture_substream, SNDRV_PCM_STATE_XRUN);
+=09if (playback_ss)
+=09=09snd_pcm_stop_xrun(playback_ss);
+=09if (capture_ss)
+=09=09snd_pcm_stop_xrun(capture_ss);
 }

