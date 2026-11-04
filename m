Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793794930;
	b=07VQlBaz/9nUIOSeRTbF/NjlwUc92kT4Zb/sw9RIyYlcUe7LLRkGYhwzvAFck8tDODpY
	 /TNkX8UPo4eo/7/XMeAdk2STfVVfW/TMQcQEuJlCTPGEZANwNprthXOE4rs3hIz654TUt
	 PFxZHMKTyNI0SbwutYvShkQULWokbq3HNIdnXRBWRSgUabhQt12QbrN5OUr/rWYXQwkMG
	 tTl7xFh5fJgxNlkbNSZSkTFcHxYTzOHuSdd74nzq+ihn/iVRVLHYIrErjvWNQtKY5f/DF
	 ryxv7fWa6qHBvXfogFDGOQbynlmOsSx7VIUMQhJYaaqRU8eNCuvqk/Kj9tegBq6Ar8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793794930;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=1VRHBV0Vi6lcFS6X07earnXeCOVYmYuBX2CJ9LanzrM=;
	b=UFRwhr9hpbMzd+2STTaU2I6r/qKraSo8vHaITSQ0FgbrhoyOMMrK2/v5tgmR2H9etlTf
	 WpRi30LaRzwzA0gSTFWkvoUopUM1UJFQOTXDMm3GCe1L4tpRf83WwltF/X1UAaDA3elFu
	 PObBAqgilt2wulUmZDcRUAcYxeNkT+iOwNX4HmL3NhR4PNbHU3C+k2SpB6TkVSFtwL4Qj
	 EHYxGy4sxHDRt6RGM4X6RFHnoA0eSSPKJtH10dyQdLSnfFLvc4tPWiICX+N5tk8dZp1KM
	 YSD0eYCpey1QXUEfmhbyhaPfEK1rhzAEfS3QEflQ96NExNG3FA35ePSgz+nQoEwcXHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=Av+rzeCN;
	arc=none smtp.remote-ip=79.135.106.119
Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C30606A32C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 12:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1C30606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=Av+rzeCN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1793794927; x=1794054127;
	bh=1VRHBV0Vi6lcFS6X07earnXeCOVYmYuBX2CJ9LanzrM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Av+rzeCNyk0HPev1VhXkgLnD2VHnha7GXmXz/RPAgyASSdQUWdf1P7Wo+kfd4HaLL
	 TRWFGMpnWbmuW37Dv7j/9ZXRyDW0VkSrV3FyGDCBEpN5rl7j6/zOUyeSPHr+odYSv2
	 m8Pvpak2MI9+RBl7BAovdw7SrMp/HtNNYVVXWLn7PWE5gMlFMgAh+VVZ0NSd+fz9uX
	 ew4S2iwyuGKNgvsd/78MCmR9WVGNKh3mGb49yGBElbLFo1S7O72V7iTp7P8+zkJSaQ
	 ZgZV1f0QdlUh8ilMVSYVQBrloxf2auNreLm3dVoVzsu/hR0EchxObQrn6l/rUpcXBj
	 TwArMVu0Z67cQ==
Date: Wed, 04 Nov 2026 12:22:03 +0000
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
From: Sinan Turunc <enscrpt@pm.me>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v4 2/2] ALSA: usx2y: Guard the playback copy
Message-ID: <20261104122136.1518-3-enscrpt@pm.me>
In-Reply-To: <20261104122136.1518-1-enscrpt@pm.me>
References: <20261104122136.1518-1-enscrpt@pm.me>
Feedback-ID: 48393780:user:proton
X-Pm-Message-ID: c65bdafba056a5aa7f65a001c8ab584f50cb00e9
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
the capture packet's actual_length. Three things are unchecked: that the
URB fits in the ring buffer, that a packet fits in the playback
endpoint's maxpacksize, from which tmpbuf is allocated, and that
actual_length is a whole number of frames. The ISO descriptors take the
raw actual_length while transfer_buffer_length and the copies take
count * stride, so a packet that is not a multiple of the stride makes
the descriptors add up to more than the buffer, by up to stride - 1
bytes per packet.

Return -EPIPE, as the existing packet-size check does, when the URB is
larger than the buffer or a packet is larger than maxpacksize, and size
each descriptor from whole frames, so the descriptors add up to
transfer_buffer_length and each stays within maxpacksize. The buffer
case is prevented by the previous patch and this is the guard for it;
the other two depend only on the device.

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

The descriptor case is visible with capture packets of 195 bytes at
stride 4 (48 frames and 3 bytes): without this change the four
descriptors add up to 780 bytes for 768 bytes of data, and USB/IP's
completion check refuses the URB ("total length of iso packets 780 not
equal to actual length of buffer 768", -EPROTO), after which the driver
stops the streams. With this patch every descriptor is 192 bytes, the
descriptors add up to the data in every URB for 30 s, the position
advances inside the buffer and KASAN reports nothing. The 48-frame
playback run above is unchanged.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Sinan Turunc <enscrpt@pm.me>
---
v4: size the ISO descriptors from whole frames, so they add up to
transfer_buffer_length (review of v3); the maxpacksize check has its own
ratelimited message. Regenerated on top of 1/2.
v3: new patch, split out of the v3 draft; the review of v2 found both
unchecked assumptions. The buffer case is confirmed on the unpatched
driver and the guards tested on 7.3-rc7, see above.

 sound/usb/usx2y/usbusx2yaudio.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudi=
o.c
index 1e1d0cfbd16..798c9bb5386 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -118,14 +118,31 @@ static int usx2y_urb_play_prepare(struct snd_usx2y_su=
bstream *subs,
 =09=09=09=09__func__, counts);
 =09=09=09return -EPIPE;
 =09=09}
+=09=09if (counts * usx2y->stride > subs->maxpacksize) {
+=09=09=09dev_err_ratelimited(&usx2y->dev->dev,
+=09=09=09=09=09    "%s: packet of %i bytes exceeds maxpacksize %u\n",
+=09=09=09=09=09    __func__, counts * usx2y->stride,
+=09=09=09=09=09    subs->maxpacksize);
+=09=09=09return -EPIPE;
+=09=09}
 =09=09/* set up descriptor */
 =09=09urb->iso_frame_desc[pack].offset =3D pack ?
 =09=09=09urb->iso_frame_desc[pack - 1].offset +
 =09=09=09urb->iso_frame_desc[pack - 1].length :
 =09=09=090;
-=09=09urb->iso_frame_desc[pack].length =3D cap_urb->iso_frame_desc[pack].a=
ctual_length;
+=09=09urb->iso_frame_desc[pack].length =3D counts * usx2y->stride;
 =09}
 =09if (atomic_read(&subs->state) >=3D STATE_PRERUNNING) {
+=09=09/*
+=09=09 * The copy below wraps once, which needs count <=3D buffer_size.
+=09=09 * snd_usx2y_pcm_open() guarantees it; guard anyway.
+=09=09 */
+=09=09if (unlikely(count > runtime->buffer_size)) {
+=09=09=09dev_err_ratelimited(&usx2y->dev->dev,
+=09=09=09=09=09    "%s: URB of %i frames exceeds %lu-frame buffer, stoppin=
g\n",
+=09=09=09=09=09    __func__, count, runtime->buffer_size);
+=09=09=09return -EPIPE;
+=09=09}
 =09=09if (subs->hwptr + count > runtime->buffer_size) {
 =09=09=09/* err, the transferred area goes over buffer boundary.
 =09=09=09 * copy the data to the temp buffer.
--=20
2.56.0

