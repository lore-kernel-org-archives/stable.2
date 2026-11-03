Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712213;
	b=2MH6aBtg5n7p9Tpb776eJSPzBZLNhzyiUGyk8EUxzY5IiWZHF/dSUO/SNWWDvslKcvgV
	 cdYgZRhpBBGEV5ilPGiCftWNlZ0AHCZSs6vA8+pcq2nxL9nD2+KOdVTundPWZhboAdXwX
	 M+OXsaaG2bAlrxGccJUuhyWV36Y2W6N1fM6tN94151Y+47okcnFzW+pe48PHp6A7sGxVi
	 WLm/CI2eBcYTvHYsWgMnScXJ04P5f4fOSfgaz+HeQOy56Te6MaG8yJFwOpNXrY+L6RMs+
	 ptIAskMveKKc7hyZTWL9X59Y7dW4M6s2SrYNZHaNY+UTSuq2Ngt9cuX6Ewx9JQl8Myg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712213;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kuOu0lYlBmoBcCTMmte4a+Y7DfM7+mJz3jxY/0rfu3w=;
	b=Yi6SvOVv1RkiDtRwJokVIBQomnnnf8/Bfab9ErtXKiKICFpuDwr1wDdyD0+gXB2cfz5M
	 Lv/O2ByoZWtBI5ZOpagLS4rTbva9ziHfPQuNTLWtIctOlgKAmKreVfeD2jFCBFKlYyjOD
	 QEDWWfizMx3Yhzfzmn0DJQ1TjTd490BZmio65gYOkY3JbtUeEbRP7nvlc1Rox6mrWpfJ4
	 AYj03sG6E5OueIP4Vkj36W1Fxa68opHQS5tZA8SOuZXPUpaYUKTszrxFaknF2HXnLVhot
	 A2DblUrnLpkFGLX0vdPddDzBEP9vjrn4WWIB0m//Wzm0b1vyChMdnLE2fFchsP47pxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=jP4JzRXf;
	arc=none smtp.remote-ip=185.70.43.16
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68103606D807;
	Tue,  3 Nov 2026 13:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68103606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=jP4JzRXf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1793712209; x=1793971409;
	bh=kuOu0lYlBmoBcCTMmte4a+Y7DfM7+mJz3jxY/0rfu3w=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=jP4JzRXfJoykOtSxNtzWbpBDvVwOw+HxqNxVOFp0KkXQjCcUcR0DilpVRzS1IDECZ
	 KNMFhuvU4AYAKNUPX9RuzSb7xiq3/jLX76OfYUMYLu0qbLEXVBT/9rjtTNhjnwnqXx
	 GlD0erZHd4lee0JPGd+eTwQ93ecHt6dIvUXMIW/Roa0euYplKkBMybqni2lM4mzjDf
	 1t97UV4tDZolBUk/iZdf5jLxnWsbwGQc3uiI75vjWW3ujwtpdaWXOvT0afl3jvUKDi
	 IXrCa7IpWcWe6aZQ7nfvVevJRhDw+NoOnc2gPgd3lirwhes+iafmRZnRdIjK2iEqKm
	 xFe9Fd97n89CQ==
Date: Tue, 03 Nov 2026 13:23:24 +0000
To: Mauro Carvalho Chehab <mchehab@kernel.org>
From: Sinan Turunc <enscrpt@pm.me>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2] media: cx231xx: Reject audio buffers smaller than two packets
Message-ID: <20261103132307.730-1-enscrpt@pm.me>
Feedback-ID: 48393780:user:proton
X-Pm-Message-ID: 128f8fbecdd7df5fe60a818bdfd7337bf6400d4a
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

cx231xx_audio_isocirq() and cx231xx_audio_bulkirq() split the copy into
the ALSA ring buffer once at the buffer end and wrap hwptr_done_capture
once, which is only correct when one packet holds at most buffer_size
frames. The packet size is max_pkt_size from the device's alternate
setting, while the hw constraints allow 64-byte periods with periods_min
2, so a packet can be larger than the whole buffer.

snd_cx231xx_capture_open() selects the alternate setting before
hw_params, which sets max_pkt_size, so constrain
SNDRV_PCM_HW_PARAM_BUFFER_BYTES there to at least twice max_pkt_size.
Two packets, matching the line6 fix. The bound makes the copy safe, but
it does not make every larger buffer progress: the position is reported
once per URB of 64 packets, so a buffer that divides one URB's data
returns to the same position at every callback. That was already the
case before this patch and is not changed here. Keep a guard in both
callbacks that drops an oversized packet with a ratelimited error, for
the case that should no longer be reachable.

Reproduced on 7.3-rc7 with a USB/IP device presenting a Pixelview
Xcapture interface layout and 1024-byte packets into a 128-byte buffer:

  BUG: KASAN: use-after-free in cx231xx_audio_isocirq+0x2c7/0x780
  Read of size 4294966528 at addr ffff88800e8e0400 by task vhci_rx/82

With this patch a 1024-byte buffer is refused at hw_params; a 2048-byte
buffer is accepted and safe but barely advances (hw_ptr 14336 after 30
s, for the reason above); a 3072-byte buffer streams for 30 s with no
report and with the position moving inside the buffer.

Fixes: e0d3bafd0258 ("V4L/DVB (10954): Add cx231xx USB driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sinan Turunc <enscrpt@pm.me>
---
v2: constrain the buffer at open instead of clamping in the copy. v1
clamped the frame count to buffer_size, which left the ring position
unchanged on every oversized packet and stalled the stream, as the
Sashiko review of the line6 patch pointed out. The bound is two
packets, matching the line6 fix; see the message for what it does and
does not change. The clamp is replaced by a drop guard for the case the
constraint makes unreachable.

 drivers/media/usb/cx231xx/cx231xx-audio.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletions(-)

diff --git a/drivers/media/usb/cx231xx/cx231xx-audio.c b/drivers/media/usb/=
cx231xx/cx231xx-audio.c
index b24ceef497e..14df45ab011 100644
--- a/drivers/media/usb/cx231xx/cx231xx-audio.c
+++ b/drivers/media/usb/cx231xx/cx231xx-audio.c
@@ -123,6 +123,19 @@ static void cx231xx_audio_isocirq(struct urb *urb)
 =09=09=09if (!length)
 =09=09=09=09continue;
=20
+=09=09=09/*
+=09=09=09 * snd_cx231xx_capture_open() constrains the buffer to
+=09=09=09 * hold at least two packets, so this cannot happen for
+=09=09=09 * a conforming device. Drop the packet rather than
+=09=09=09 * overrun the single wrap below.
+=09=09=09 */
+=09=09=09if (unlikely(length > runtime->buffer_size)) {
+=09=09=09=09dev_err_ratelimited(dev->dev,
+=09=09=09=09=09=09    "audio packet of %d frames exceeds %lu-frame buffer,=
 dropping\n",
+=09=09=09=09=09=09    length, runtime->buffer_size);
+=09=09=09=09continue;
+=09=09=09}
+
 =09=09=09oldptr =3D dev->adev.hwptr_done_capture;
 =09=09=09if (oldptr + length >=3D runtime->buffer_size) {
 =09=09=09=09unsigned int cnt;
@@ -204,7 +217,7 @@ static void cx231xx_audio_bulkirq(struct urb *urb)
 =09=09runtime =3D substream->runtime;
 =09=09stride =3D runtime->frame_bits >> 3;
=20
-=09=09if (1) {
+=09=09if (urb->actual_length / stride <=3D runtime->buffer_size) {
 =09=09=09unsigned long flags;
 =09=09=09int length =3D urb->actual_length /
 =09=09=09=09     stride;
@@ -424,6 +437,18 @@ static int snd_cx231xx_capture_open(struct snd_pcm_sub=
stream *substream)
=20
 =09runtime->hw =3D snd_cx231xx_hw_capture;
=20
+=09/*
+=09 * The URB callbacks wrap the ring buffer once per packet and advance
+=09 * the position by the packet, which only works when the buffer holds
+=09 * more than one packet. max_pkt_size was set by the alternate setting
+=09 * above, so bound the buffer by two packets here.
+=09 */
+=09ret =3D snd_pcm_hw_constraint_minmax(runtime,
+=09=09=09=09=09   SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
+=09=09=09=09=09   2 * dev->adev.max_pkt_size, UINT_MAX);
+=09if (ret < 0)
+=09=09return ret;
+
 =09mutex_lock(&dev->lock);
 =09/* inform hardware to start streaming */
 =09ret =3D cx231xx_capture_start(dev, 1, Audio);
--=20
2.56.0

