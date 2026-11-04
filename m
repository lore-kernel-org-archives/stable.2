Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793794925;
	b=aSCQl6xbcuAthbtxb2L8f8uKxVVZftgVBgqXbUhY4/HKdosE1GYlpVNMrTWip8UVh9+r
	 9Gt1qwJ9K+SliOxpJUAC/lzDBas29ROcwBYKiXv4BrBCcbdgG4bGvWFt/uji33mbX33wA
	 JmIbmN9Zc78APJNCAHeHcuyNhOg/qceysarM/f+BtkUlOXIOwfrCj0762OiZNyMfprYaS
	 u/yVC0OidiTjlJUzURsnwQeRx4MyVGVx/SmdKN/Wsibf0mbVy6bv2MI+Nlj+DyEG7fJmZ
	 4zFZaVvh/oX0+aXgrNOdEHHzBV05QiSHsMGcN4ylk/LkOzO6azZG2753ozRBCpON8pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793794925;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ved1DWcD7rA5TlRy/FZm6Y2WqpyF91+l7PRtshag9Nk=;
	b=g05KxkJHMtyNDyhO6bYMSTaRDdaH7RCGzsdXoA8QtFNM74qb+3HYsGY2qmY+iA+/ROyX
	 xxm97cYW+HL90YC8+LvOITktQshM8vKJlrpHjPrkCNqjW42Du4odvEO4cg/g5Nm03fcQi
	 AoZiIY13wrga7YmAYedpx1YOZnghkW1e2m6/3qH6o60sfE2qVYJCn+hwdWCTUjQAYn7hn
	 FfDp5xYCf26q4NDoevjtVo3woSpwGie6ob2juDP1wwdwO4tc7jBAlE4jUSMTXRu1+Rdpu
	 +JGc46oQJOZ77r8VzZRcCVnSmzvTxP7/nVQe1+TygxLrHBEdxbSbfRFQk2CraACho+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=QsksqQ7A;
	arc=none smtp.remote-ip=185.70.43.16
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6E3606A32D
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 12:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C6E3606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=QsksqQ7A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1793794922; x=1794054122;
	bh=ved1DWcD7rA5TlRy/FZm6Y2WqpyF91+l7PRtshag9Nk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QsksqQ7AWHkPW8NZHOnbCXnFomM+pSzCGQveYJHGMXGIjQkBJ0dc5qlsg0FxHubau
	 BpFRaXEWX1qGvebQmWL+hMH2cRGAe4HXnYx+QA0dnnxgLjUe3CfTiXcgFaaRxIY0QK
	 TuDfl6qbKLm2gT8wca/tJcIPcRw8hCaNUcvJI12j/9qUB3VIsfrM6c3Rq8md8WwHM4
	 1mvyzAhdmYWTNsjCusQNdnvA5ky5sf8oL9WTZCsDOD/YA8Ik+eCZESSr3Phi/U3IZD
	 GymbX+tFczWETl/aqU3Zx1qwxaojW/2/L0HJVdEBatAMMOuT8S//ut4kLAqMA2JncW
	 VwyoaAah1t/lQ==
Date: Wed, 04 Nov 2026 12:21:57 +0000
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
From: Sinan Turunc <enscrpt@pm.me>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v4 1/2] ALSA: usx2y: Require a buffer of two URBs
Message-ID: <20261104122136.1518-2-enscrpt@pm.me>
In-Reply-To: <20261104122136.1518-1-enscrpt@pm.me>
References: <20261104122136.1518-1-enscrpt@pm.me>
Feedback-ID: 48393780:user:proton
X-Pm-Message-ID: 7d0c6ab1ad28032b964268eef48df3ded2cdd609
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

usx2y_urb_capt_retire() wraps the ring buffer once per packet and
usx2y_urb_play_prepare() once per URB of nr_of_packs() packets of up to
50 frames. Both assume that the data fits in the buffer, and the hw
constraints only require about two 1 ms periods, so a packet larger
than the buffer on capture, or a URB larger than the buffer on playback,
violates that assumption.

Constrain SNDRV_PCM_HW_PARAM_BUFFER_SIZE in snd_usx2y_pcm_open() to at
least two URBs, 2 * nr_of_packs() * 50 frames, for both directions. The
bound is in frames and derived from the driver's own packet limit, so it
does not read the endpoint, whose altsetting is only selected in
prepare. Two URBs rather than one, because the position advances by a
URB on playback and only moves when a URB is less than the whole buffer.
Keep a guard in usx2y_urb_capt_retire() that drops a packet larger than
the buffer, for the case the constraint makes unreachable.

With nrpacks above about 163 (S16_LE) or 109 (S24_3LE) the bound exceeds
the 64 KiB buffer the substream preallocates (twice that with the
preallocation raised to its 128 KiB maximum), so hw_params fails for
those module settings. That is intended: the driver cannot be safe with
a URB larger than half the largest buffer.

Reproduced on 7.3-rc7 with a USB/IP device presenting the US-122
interface layout and 1024-byte packets into a 512-byte capture buffer:

  BUG: KASAN: out-of-bounds in i_usx2y_urb_complete+0x1285/0x1ac0
  Read of size 18446744073709551104 at addr ffff88800e448800 by task vhci_r=
x/83

Tested on 7.3-rc7 with the same device, S16_LE at 44100 Hz, nrpacks 4,
so the bound is 400 frames. A 128-frame capture buffer and a 200-frame
playback buffer are refused at hw_params with EINVAL. A 400-frame buffer
streams for 30 s in each direction with the position advancing inside
the buffer and no KASAN report; the capture guard did not fire. The
same 400-frame capture buffer with S24_3LE, which selects altsetting 2
in prepare, streams for 30 s with the same result.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Sinan Turunc <enscrpt@pm.me>
---
v4: the comment in snd_usx2y_pcm_open() says which direction needs which
bound; the nrpacks limit in the changelog is computed against the
preallocated buffer, not the hw struct maximum (review of v3).
v3: bound the buffer in frames by two URBs instead of two packets, so
the playback copy is covered and the bound no longer reads the endpoint
before the altsetting is selected (both from the review of v2). The
open() comment that described playback as wrapping per packet is
corrected. Both directions tested on 7.3-rc7, see above.
v2: constrain the buffer at open instead of clamping in the copy.

 sound/usb/usx2y/usbusx2yaudio.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudi=
o.c
index a3a0bc13632..1e1d0cfbd16 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -51,6 +51,18 @@ static int usx2y_urb_capt_retire(struct snd_usx2y_substr=
eam *subs)
 =09=09=09dev_dbg(&usx2y->dev->dev, "%s: 0 =3D=3D len ERROR!\n", __func__);
 =09=09=09continue;
 =09=09}
+=09=09/*
+=09=09 * snd_usx2y_pcm_open() constrains the buffer to hold at least
+=09=09 * two URBs, so this cannot happen for a device that keeps its
+=09=09 * packets at 50 frames. Drop the packet rather than exceed the
+=09=09 * single wrap below.
+=09=09 */
+=09=09if (unlikely(len > runtime->buffer_size)) {
+=09=09=09dev_err_ratelimited(&usx2y->dev->dev,
+=09=09=09=09=09    "%s: packet of %i frames exceeds %lu-frame buffer, drop=
ping\n",
+=09=09=09=09=09    __func__, len, runtime->buffer_size);
+=09=09=09continue;
+=09=09}
=20
 =09=09/* copy a data chunk */
 =09=09if ((hwptr_done + len) > runtime->buffer_size) {
@@ -888,6 +900,18 @@ static int snd_usx2y_pcm_open(struct snd_pcm_substream=
 *substream)
 =09runtime->private_data =3D subs;
 =09subs->pcm_substream =3D substream;
 =09snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIOD_TIME, 1=
000, 200000);
+=09/*
+=09 * Capture wraps the ring buffer once per packet and playback once
+=09 * per URB of nr_of_packs() packets of at most 50 frames (see
+=09 * usx2y_urb_play_prepare()). Playback needs the buffer to hold more
+=09 * than one URB and capture more than one packet; use the URB bound
+=09 * for both, and two URBs rather than one, because the position only
+=09 * advances when a URB is less than the whole buffer. The bound is in
+=09 * frames and does not depend on the altsetting, which is selected
+=09 * in prepare.
+=09 */
+=09snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
+=09=09=09=09     2 * nr_of_packs() * 50, UINT_MAX);
 =09return 0;
 }
=20
--=20
2.56.0

