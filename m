Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793789580;
	b=Z91GcvmW3pL3OZcKu+bxfvYJMph7BXK2UWGimha2r8iR58I0znjVIfQI1vaDNd1B+HrD
	 v4FF0vRARa6IIK1BCLE9Pg9n2790KMlpcFaPks2rD8dJWVqXisi7AUSPSDsBflbDZTE+z
	 cp7dYD9dd6sCy9ww5t+CL0SNllX6+mnQ8yEnOCUnt/Yn+kd7YOa2D6hF68oHbXCcuTH0r
	 2hpZ2SSbtrfisz+Y6tCTu8blF97sevNRiYHim0k5EB3qRRkJd6VcHEq6FoxXFuAj6eIup
	 ZmhEqnoA5d/kgu+zyt812caa/iFxpd4Bq4uUnC9kPcIsrcfnPojm52VtdiZw2ayGE9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789580;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=GimgcPXH2fNoHOLDkivcT6L2F+6r2bGEOK3CclBJHEE=;
	b=2PWo4Q3I0qEWcbUvgr+2dIycZDcw+Ma41tOlroeDML5YuFixr37TU3nwzTZo3prWk68o
	 ncPDrxqhCAn1xnfJXy65XD4VxfZP9mrRmuJuIPRTszKWLPu2hxbIItQXoX4ylpx49C2k/
	 /hWSrkEzbhBaxRqeg55XtT7Aa2YfL3+poDvkY87Ao+PxrhSWvujQF03QZ7otCpY18kb/D
	 Ps5TcmyQJIwYrh6wd3WE4+IK7lDrYaZW7pcJ4s3BUihOMp41ffdeeXcYFMHvdiS8Dm6Wp
	 hMlF/b6VJcwhE9A+wIf/gdtAXjXab7xQYOmJGJm95Mb8uzX2t+KJ7LlTpM8WkKcq50Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b="JzGU/S5R";
	arc=none smtp.remote-ip=185.70.43.102
Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch [185.70.43.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8FD606A31B;
	Wed,  4 Nov 2026 10:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F8FD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=JzGU/S5R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1793789578; x=1794048778;
	bh=GimgcPXH2fNoHOLDkivcT6L2F+6r2bGEOK3CclBJHEE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=JzGU/S5RVygaOe8FMojJxUCsVBL7E7/XsSh395fO6shr6D2yu1uFTNpoTxNFVuh5U
	 iZNN5cHZbaKFar+uMz2gkdHHHc1n97zLAjvC6V1u8Pw3yXwSFwvYnW4Tt4w1TUoHQJ
	 94P5NCVnVJ9EPfi1KbkjWWsNpvwgHlp9hkgq8tL0G54i9U+p0GqSyHX+r/rAvQHq61
	 5YZNy0uzcJCWsFoHQbLZUBGgpMdLqnYsKC8qwb0vqS5yJzupH2ZU8xhokB1p6vX4Su
	 5cfU/dUIiuelFxwFnBgOJ1FjnUEeHkRUIsypIAENBZ/G4QNy/VMY4n/B6lTs0q9jEq
	 kLseACskaee4w==
Date: Wed, 04 Nov 2026 10:52:55 +0000
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
From: Sinan Turunc <enscrpt@pm.me>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v3 2/2] ALSA: usx2y: Guard the playback copy
Message-ID: <20261104105228.1124-3-enscrpt@pm.me>
In-Reply-To: <20261104105228.1124-1-enscrpt@pm.me>
References: <20261104105228.1124-1-enscrpt@pm.me>
Feedback-ID: 48393780:user:proton
X-Pm-Message-ID: 6f257916e3e14e150a1c466d7fb4812cb07fc0e7
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

usx2y_urb_play_prepare() sums the packet lengths of a whole URB, copies
that many frames with a single wrap, and sizes each playback packet from
the capture packet's actual_length. Two assumptions are unchecked: that
the URB fits in the ring buffer, and that a packet fits in the playback
endpoint's maxpacksize, from which tmpbuf is allocated.

Return -EPIPE, as the existing packet-size check does, when the URB is
larger than the buffer or a packet is larger than maxpacksize. The first
case is prevented by the buffer bound in the previous patch and this is
the guard for it; the second depends only on the device.

The first case is reachable on the unpatched driver with ordinary
packets: on 7.3-rc7, a USB/IP device presenting the US-122 interface
layout and sending 48-frame packets, with a 100-frame playback buffer
(two 50-frame periods, inside the stock constraints), KASAN reports:

  BUG: KASAN: out-of-bounds in i_usx2y_urb_complete+0x79b/0x1ac0
  Read of size 18446744073709551280 at addr ffff88800e6b02e0 by task vhci_r=
x/80

With both patches, the same device and a 200-frame playback buffer is
refused at hw_params with EINVAL, and a 400-frame buffer plays for 30 s
with the position advancing inside the buffer, no KASAN report and
neither guard message. The maxpacksize check is not exercised: the
emulated device reports the same wMaxPacketSize on both endpoints.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Sinan Turunc <enscrpt@pm.me>
---
v3: new patch, split out of the v3 draft; the review of v2 found both
unchecked assumptions. The buffer case is confirmed on the unpatched
driver and the guards tested on 7.3-rc7, see above.

 sound/usb/usx2y/usbusx2yaudio.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudi=
o.c
index ee224b4dfb0..5f241d45401 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -112,7 +112,8 @@ static int usx2y_urb_play_prepare(struct snd_usx2y_subs=
tream *subs,
 =09=09/* calculate the size of a packet */
 =09=09counts =3D cap_urb->iso_frame_desc[pack].actual_length / usx2y->stri=
de;
 =09=09count +=3D counts;
-=09=09if (counts < 43 || counts > 50) {
+=09=09if (counts < 43 || counts > 50 ||
+=09=09    counts * usx2y->stride > subs->maxpacksize) {
 =09=09=09dev_err(&usx2y->dev->dev, "%s: should not be here with counts=3D%=
i\n",
 =09=09=09=09__func__, counts);
 =09=09=09return -EPIPE;
@@ -125,6 +126,16 @@ static int usx2y_urb_play_prepare(struct snd_usx2y_sub=
stream *subs,
 =09=09urb->iso_frame_desc[pack].length =3D cap_urb->iso_frame_desc[pack].a=
ctual_length;
 =09}
 =09if (atomic_read(&subs->state) >=3D STATE_PRERUNNING) {
+=09=09/*
+=09=09 * The copy below wraps once, which needs count <=3D buffer_size.
+=09=09 * snd_usx2y_pcm_open() guarantees it; guard anyway.
+=09=09 */
+=09=09if (unlikely(count > runtime->buffer_size)) {
+=09=09=09dev_err_ratelimited(&usx2y->dev->dev,
+=09=09=09=09=09    "%s: URB of %i frames exceeds %lu-frame buffer\n",
+=09=09=09=09=09    __func__, count, runtime->buffer_size);
+=09=09=09return -EPIPE;
+=09=09}
 =09=09if (subs->hwptr + count > runtime->buffer_size) {
 =09=09=09/* err, the transferred area goes over buffer boundary.
 =09=09=09 * copy the data to the temp buffer.
--=20
2.56.0

