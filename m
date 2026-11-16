Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.96
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794813471;
	b=OsOq7xmfOp9dtfWNVaLLW9zNCTCUYiMFUNV+k4wicQyp7x8mODqTrilO1lzYZ+3nuhuA
	 jvhUmT6gBAxdzhVPNSs0MuCChjLtJlhgEEnhvKve5ZSzfaRpUWD9joHz/O8Cd6Kg6Ue5C
	 KfmhQhAw3loCqOPDrIKzR+8uTtFDuxABzHpI9Sx3G4s2e7Dmq6NKa+qmz32ynjMP2TBvq
	 Y4GWRa3qdROFaEiT4bJjGQGqqvsUKK3sB3e6cs0ExHwh2ewRGhsBhgrZDanZd5dLsca8R
	 /4XjPJ7WsYrHtgquetXaZb4Yfjj564INV5w9srTy7us8pTUO/cbPU04L8ImqkJ7mTBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813471;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=IT6V+vcPn1omnsVU0AA6xPxJt0TSU1lv7TM9Nd8Agxk=;
	b=F3hEmDKg6yYIAa0QsjeK+ORx6Wyy/FNtGSBJHiqX3X8h8+GL3DsCYfj7gpUjanPvGc8X
	 NG3ahAdr9A7PkrJTL3h1By1C0JprbKqZ53FPW3IXxeMW7d/Z1pZ4C1AEBCUpALXndjn2h
	 +Xr6zE0OpZlUZ/fIYWYZlyHYSW+dqKEka+4nFB+3shNClSpDxCWLZ/CYJgaOA4x+4yeX6
	 eqo4XydSgVcgDGSbYiRJ+5qiT0ux4yx9rymAxJ1T0xQ3p2RokxBylxyJXOUsCh2jhy98g
	 CAC0h9ydBblpLgbaQDJnhyan6Fmr4LPN0AbetQaHGy0bfbQgvIJAH8nuP4Y5yZwOkmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=becholey.ch;
	spf=pass smtp.mailfrom=becholey.ch;
	dkim=pass header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=UVgIFDxn;
	arc=none smtp.remote-ip=185.70.43.96
Received: from mail-4396.protonmail.ch (mail-4396.protonmail.ch [185.70.43.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20C0606A330;
	Mon, 16 Nov 2026 07:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D20C0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=becholey.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=becholey.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=UVgIFDxn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=becholey.ch;
	s=protonmail; t=1794813468; x=1795072668;
	bh=IT6V+vcPn1omnsVU0AA6xPxJt0TSU1lv7TM9Nd8Agxk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UVgIFDxnq1MCL/5EoaZv1hEYpCYGK2EeaCAjEED7lyeSBjIvNF/JprCl4XMZ3d/7Y
	 dPiWd6eafvgzqlUZJGtJBs757vDQYjLeLqD4qS7LkgEm+CagY2Hda1PnV8q1APpHkg
	 S+PVse0qJi6YClnMGFpI0Q6sCMCb8X46vEFZhGo3vXS7I1p1aSZIqBPgoepBLqDVoQ
	 iVDXyclqhbH2BgWM/Ya0DhTDA/FvKlj+TYMddlSIrcYKfLtVfYByk4xEbT8MSUWI3l
	 +WOrWKxRcdOcScYzKFwiTK2CKcXZe3nyv2LKu1pPduuLFD+7YZHbpXjSqoEbt93GHs
	 lOPzQmw4YJ8OA==
Date: Mon, 16 Nov 2026 07:17:45 +0000
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, =?utf-8?Q?=C5=A0erif_Rami?= <ramiserifpersia@gmail.com>
From: Alexandre Becholey <alex@becholey.ch>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, Hanxiang Xu <xuhx@hust.edu.cn>, Alexandre Becholey <alex@becholey.ch>, stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 3/5] ALSA: usx2y: us144mkii: only touch the buffer of a running PCM stream
Message-ID: <20261116071707.217448-4-alex@becholey.ch>
In-Reply-To: <20261116071707.217448-1-alex@becholey.ch>
References: <20261116071707.217448-1-alex@becholey.ch>
Feedback-ID: 60743817:user:proton
X-Pm-Message-ID: ec53f425f0e1f18e75ac7be559bd8a67a42a2fab
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

The playback and capture URBs of the US-144MKII always run together:
tascam_pcm_trigger() sets both playback_active and capture_active and
submits all URBs when either substream is started. The capture work
handler and the playback URB completion handler, however, use the
buffer of their own substream as soon as the corresponding *_active
flag is set and the substream is open, without checking that this
substream is actually running.

So if only one direction is started, the handler of the other direction
works on a substream that may have no buffer at all:

 - capture PCM opened without HW_PARAMS, playback started:
   tascam_capture_work_handler() writes the captured frames through the
   NULL runtime->dma_area, and divides by the zero buffer_size.

 - playback PCM prepared but not started (or opened without HW_PARAMS),
   capture started, then HW_FREE on the playback PCM, which ALSA allows
   in the PREPARED state: playback_urb_complete() copies from the NULL
   runtime->dma_area.

With KASAN, on torvalds/master 9d66f26fefac:

  BUG: KASAN: null-ptr-deref in tascam_capture_work_handler
  Write of size 3 at addr 0000000000000000 by task kworker/0:2/62

  BUG: KASAN: null-ptr-deref in playback_urb_complete
  Read of size 480 at addr 0000000000000660 by task ksoftirqd/0/15

Both only need an attached device and this order of PCM ioctls from a
user with access to the PCM devices.

Only copy to or from the substream buffer while that substream is
running. The capture data is then dropped, and the playback URBs carry
silence, as the device keeps streaming in both directions.

The hardware position that the pointer callbacks report is counted
separately, in feedback_urb_complete(), for both substreams while the
URBs run. Count it, and the elapsed periods, only while the substream is
running as well, so that it stays in step with the buffer position when
one substream is started after the other.

The bugs were found, and the reproducers and this fix were written, by
AI agents (Claude Mythos and Claude Opus models). The analysis and the
patch were reviewed by a human.

Fixes: a2a2210f2c2e ("ALSA: usb-audio: us144mkii: Implement audio playback =
and feedback")
Fixes: c1bb0c13e430 ("ALSA: usb-audio: us144mkii: Implement audio capture a=
nd decoding")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Becholey <alex@becholey.ch>
---
Changes in v2:
- Also count the hardware position (playback_frames_consumed,
  capture_frames_processed) and the elapsed periods in
  feedback_urb_complete() only while the substream is running, so that a
  substream started after the other one starts at the beginning of its
  buffer (Sashiko review of v1:
  https://lore.kernel.org/all/sashiko-outbox-214859@kernel.org/).

Notes for reviewers (not part of the commit message):

Trigger: an emulated US-144MKII under QEMU arm64 with KASAN; the
capture case on dummy_hcd (raw-gadget), the playback case on an
emulated xHCI controller, because the playback URBs are isochronous.
The reproducers are available to maintainers on request.

Decoded, torvalds/master 9d66f26fefac:
  tascam_capture_work_handler (sound/usb/usx2y/us144mkii_capture.c:246)
  playback_urb_complete (sound/usb/usx2y/us144mkii_playback.c:230)

This patch depends on patch 2/5: the new snd_pcm_running() check reads
substream->runtime, so a capture work instance must not outlive the
close of its substream. With this patch alone, the close/reopen
reproducer of 2/5 crashed in the check (KASAN null-ptr-deref at
include/sound/pcm.h:711 from us144mkii_capture.c:231, v7.3.1).

Testing of v2 (whole series, KASAN, PROVE_LOCKING, PROVE_RCU): the
programs of both cases (and a second playback-case program) stayed
clean in 9 runs on v7.3.1 and 9 on 97d73c825122. For the v2 change,
a program prepares both PCMs, starts one and the other 0.7 to 1.8 s
later, and reads the hw_ptr of the late stream right after its START.
With v1 it was 200 frames or more in 56 of 64 cycles (up to 3970), the
position counted since PREPARE as described in the review; with v2 it
was below 200 in 59 of 60 cycles run alone on the test host (the other
one: 200). Runs made next to other VMs and builds had a few larger
values on v2 (at most 1198 frames, about 27 ms); we think the status
read was delayed by host scheduling, but did not prove it.

Testing of v1, KASAN: without the series both cases crashed on the first
attempt (v7.3.1 and 9d66f26fefac, 1/1 each). With patches 1/5..3/5
applied: no report in v7.3.1 15 runs (capture 10, playback 5 with two
programs) and 9d66f26fefac 5 runs (capture 3, playback 2). Normal
streaming in both directions was checked on v7.3.1 with patches
1/5..3/5 applied (2 runs): the playback and capture positions keep
advancing. The playback test of patch 5/5 (normal streaming, 187 of
187 STARTs) also ran with all five patches.

Thanks,
Alexandre Becholey

 sound/usb/usx2y/us144mkii_capture.c  |  8 ++++-
 sound/usb/usx2y/us144mkii_playback.c | 45 +++++++++++++++++++++-------
 2 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/sound/usb/usx2y/us144mkii_capture.c b/sound/usb/usx2y/us144mki=
i_capture.c
index 973bed60bfcd..9c142a85e8b2 100644
--- a/sound/usb/usx2y/us144mkii_capture.c
+++ b/sound/usb/usx2y/us144mkii_capture.c
@@ -231,7 +231,13 @@ void tascam_capture_work_handler(struct work_struct *w=
ork)
 =09=09=09=09=09=09  routed_block);
=20
 =09=09scoped_guard(spinlock_irqsave, &tascam->lock) {
-=09=09=09if (atomic_read(&tascam->capture_active)) {
+=09=09=09/*
+=09=09=09 * capture_active is also set when only the playback
+=09=09=09 * stream was started; the capture buffer is only valid
+=09=09=09 * while the capture stream itself is running.
+=09=09=09 */
+=09=09=09if (atomic_read(&tascam->capture_active) &&
+=09=09=09    snd_pcm_running(substream)) {
 =09=09=09=09int f;
=20
 =09=09=09=09for (f =3D 0; f < FRAMES_PER_DECODE_BLOCK; ++f) {
diff --git a/sound/usb/usx2y/us144mkii_playback.c b/sound/usb/usx2y/us144mk=
ii_playback.c
index 0df95dbf585d..7621d752c899 100644
--- a/sound/usb/usx2y/us144mkii_playback.c
+++ b/sound/usb/usx2y/us144mkii_playback.c
@@ -166,6 +166,7 @@ void playback_urb_complete(struct urb *urb)
 =09size_t total_bytes_for_urb =3D 0;
 =09snd_pcm_uframes_t offset_frames;
 =09snd_pcm_uframes_t frames_to_copy;
+=09bool running;
 =09int ret, i;
=20
 =09if (urb->status) {
@@ -207,13 +208,25 @@ void playback_urb_complete(struct urb *urb)
 =09=09}
 =09=09urb->transfer_buffer_length =3D total_bytes_for_urb;
=20
-=09=09offset_frames =3D tascam->driver_playback_pos;
-=09=09frames_to_copy =3D bytes_to_frames(runtime, total_bytes_for_urb);
-=09=09tascam->driver_playback_pos =3D
-=09=09=09(offset_frames + frames_to_copy) % runtime->buffer_size;
+=09=09/*
+=09=09 * The URBs also run when only the capture stream was started;
+=09=09 * the playback buffer is only valid while the playback stream
+=09=09 * itself is running.  Send silence otherwise.
+=09=09 */
+=09=09running =3D snd_pcm_running(substream);
+=09=09if (running) {
+=09=09=09offset_frames =3D tascam->driver_playback_pos;
+=09=09=09frames_to_copy =3D bytes_to_frames(runtime,
+=09=09=09=09=09=09=09 total_bytes_for_urb);
+=09=09=09tascam->driver_playback_pos =3D
+=09=09=09=09(offset_frames + frames_to_copy) %
+=09=09=09=09runtime->buffer_size;
+=09=09}
 =09}
=20
-=09if (total_bytes_for_urb > 0) {
+=09if (!running) {
+=09=09memset(urb->transfer_buffer, 0, total_bytes_for_urb);
+=09} else if (total_bytes_for_urb > 0) {
 =09=09u8 *dst_buf =3D urb->transfer_buffer;
=20
 =09=09/* Handle ring buffer wrap-around */
@@ -267,6 +280,7 @@ void feedback_urb_complete(struct urb *urb)
 =09unsigned int old_in_idx, new_in_idx;
 =09bool playback_period_elapsed =3D false;
 =09bool capture_period_elapsed =3D false;
+=09bool playback_running, capture_running;
=20
 =09if (urb->status) {
 =09=09if (urb->status !=3D -ENOENT && urb->status !=3D -ECONNRESET &&
@@ -395,14 +409,26 @@ void feedback_urb_complete(struct urb *urb)
 =09=09=09}
 =09=09}
=20
+=09=09/*
+=09=09 * As in playback_urb_complete() and the capture work, which
+=09=09 * only move driver_playback_pos and driver_capture_pos while
+=09=09 * their substream is running, only advance the position of a
+=09=09 * running substream, so that a substream started after the
+=09=09 * other one starts at the beginning of its buffer.
+=09=09 */
+=09=09playback_running =3D snd_pcm_running(playback_ss);
+=09=09capture_running =3D capture_rt && snd_pcm_running(capture_ss);
+
 =09=09if (total_frames_in_urb > 0) {
-=09=09=09tascam->playback_frames_consumed +=3D total_frames_in_urb;
-=09=09=09if (atomic_read(&tascam->capture_active))
+=09=09=09if (playback_running)
+=09=09=09=09tascam->playback_frames_consumed +=3D
+=09=09=09=09=09total_frames_in_urb;
+=09=09=09if (capture_running)
 =09=09=09=09tascam->capture_frames_processed +=3D
 =09=09=09=09=09total_frames_in_urb;
 =09=09}
=20
-=09=09if (playback_rt->period_size > 0) {
+=09=09if (playback_running && playback_rt->period_size > 0) {
 =09=09=09u64 current_period =3D
 =09=09=09=09div_u64(tascam->playback_frames_consumed,
 =09=09=09=09=09=09playback_rt->period_size);
@@ -413,8 +439,7 @@ void feedback_urb_complete(struct urb *urb)
 =09=09=09}
 =09=09}
=20
-=09=09if (atomic_read(&tascam->capture_active) && capture_rt &&
-=09=09    capture_rt->period_size > 0) {
+=09=09if (capture_running && capture_rt->period_size > 0) {
 =09=09=09u64 current_capture_period =3D
 =09=09=09=09div_u64(tascam->capture_frames_processed,
 =09=09=09=09=09=09capture_rt->period_size);

