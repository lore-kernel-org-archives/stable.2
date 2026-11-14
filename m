Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794677340;
	b=Xxq70ZNtOUpEwZxseSpvkegjEQhpQQIG5Pv4GgmUzwqqV/znDRWQMFuKyR0jLoHk8MQY
	 EMtTJLA76RlMSfUihZyosIxqbNAs5ipuJAzbTYooK/1TziSzsnG+JDsIroasQmup1ayOQ
	 WefjWB1tYvCfA4e6sNG/Zwa4vsFTSjkqVCerU2X+D3/S1G2uGDdHyUdwVrFgpMHvHRp5t
	 Udw/z9G5LQ7z5VpmjikxnDhKP28tsu80rSthwt6DekvhpBsJ1RRahIOJVCfaxa7AJZWn0
	 noMxU0WO4JGR9AnvemMcCxxfE5zZXFghBERc7gr/tPzWvtpufiu0sA1pMOEK6tb1kfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794677340;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=7qwBif7qVK4IAlFZhcxh0706XbjAgwfM1uX8I90j4LQ=;
	b=mV51/d9XhglXo+eNWZrKxy9lWyPDIme+AaFb6qhvKOqJqwbBbKQ74m6yJZwbukoOu1oE
	 cPwF0BsLE3kf9r7doP9Oc1GK3G9lw7hOwoz94yPbuZ5+Omk0BwEX0ClO34+Z3szaCFTgt
	 +wF0H12ErZKiyR4OaJ1bc8ujP8fQ4YDQ0N5NhtEGnjiIkNMIt4ffHt64liJWgm0WQzfPU
	 0xmfShb0G/sNpjU4qDmYvMVKtOW6xsMlsr/pJ/5uwDTqBClh+JB+B2EiAgC2Mem+0rPCi
	 U4NiRXkg9GEpOQI45cho1UCV2e7zUQVSHA7vwYgsD0bZ7OD4RIjVL0gSj7T4oaY/s7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=becholey.ch;
	spf=pass smtp.mailfrom=becholey.ch;
	dkim=pass header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=MDkOJ9D6;
	arc=none smtp.remote-ip=79.135.106.25
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch [79.135.106.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B259B606A88F;
	Sat, 14 Nov 2026 17:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B259B606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=becholey.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=becholey.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=MDkOJ9D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=becholey.ch;
	s=protonmail; t=1794677337; x=1794936537;
	bh=7qwBif7qVK4IAlFZhcxh0706XbjAgwfM1uX8I90j4LQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MDkOJ9D6sUaDnARYT7UL/7Cw6p+L3tg6SFsVVT7yPnKg7aYb9fT5z8JHDTgnsvoA5
	 clQabFuYGCavKIjyFhxsPGp8gfq7uu5XWLiw3IpMxnHvWTVwQ0wkb01sP2I9chzmA5
	 qAEDtnpeFbsePmrP1YTPYjHGmMrnrsJoYGaDyA2UQYYJl7vNpiOL/2UDm4hqwXY7AT
	 yT0Tgcx2dHbhC1oV+JHkIJ3QiwPY+CN3wNUoUO63AaX4EDAAO6EDyxkNLWNLGIcxu9
	 QQOMUmxFeCvAkkLl2ik+HunLzpUrefJMzLZhW+xmIDA5pRNF2899X8l9aegyNjwm9g
	 Ek38eLL4AmxlQ==
Date: Sat, 14 Nov 2026 17:28:54 +0000
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, =?utf-8?Q?=C5=A0erif_Rami?= <ramiserifpersia@gmail.com>
From: Alexandre Becholey <alex@becholey.ch>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, Hanxiang Xu <xuhx@hust.edu.cn>, Alexandre Becholey <alex@becholey.ch>, stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/5] ALSA: usx2y: us144mkii: only touch the buffer of a running PCM stream
Message-ID: <20261114172806.88710-4-alex@becholey.ch>
In-Reply-To: <20261114172806.88710-1-alex@becholey.ch>
References: <20261114172806.88710-1-alex@becholey.ch>
Feedback-ID: 60743817:user:proton
X-Pm-Message-ID: c235a142e3ca384b982e5abd034b0a36baf64120
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

Testing, KASAN: without the series both cases crashed on the first
attempt (v7.3.1 and 9d66f26fefac, 1/1 each). With patches 1/5..3/5
applied: no report in v7.3.1 15 runs (capture 10, playback 5 with two
programs) and 9d66f26fefac 5 runs (capture 3, playback 2). Normal
streaming in both directions was checked on v7.3.1 with patches
1/5..3/5 applied (2 runs): the playback and capture positions keep
advancing. The playback test of patch 5/5 (normal streaming, 187 of
187 STARTs) also ran with all five patches.

Thanks,
Alexandre Becholey

 sound/usb/usx2y/us144mkii_capture.c  |  8 +++++++-
 sound/usb/usx2y/us144mkii_playback.c | 23 ++++++++++++++++++-----
 2 files changed, 25 insertions(+), 6 deletions(-)

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
index 0df95dbf585d..e6266488cf32 100644
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

