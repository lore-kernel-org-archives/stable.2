Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712188;
	b=L+90n5ffK30WKb93ej28otElCQHp+o09e1EeI4A14aAuGEkEtrh24Eqpbrw/UbpYil/a
	 cUon9TsCNt6sisVvc92DYE6YTftMa4ZHSFUOX9/6eP2nmOpO/v2qcC8h+4fAzl/FVfs58
	 01ZLj4f6WbVWrT2lGAN8rH4/uJs9vAMQ3kNuzVdr3FKWGzPfbl6ty06j273yhZH3TN2Fh
	 IKogngJTceGyNMsvLiH8a1Ribh4Db4iUpnnfTP7EW4cn6EAILfhNYrL9J1+hSNASE/NKK
	 Z3RPWLKrHq6jEwLkUhk+NSvcK4xa3XcXTZF/t+g6C6hrnHY3Fdueay8ESt8pPeDZprQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712188;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Jnvtc4gqdtiixcNCaFZLBeaCmrtHkcb1NAUR/aXN7GI=;
	b=JRsHNEmfieguhBRjUqcVG5FMsvmnTsv/9mjuTOq6W5fqsaVM/cGc1AIU3jkzxaDK7N8G
	 DhA9oghoWjJzH6mWBKmibCMwMv6kapSiexQWuaufeDI+0CdivUvJ8Bwbvu8Q+MXdqKmCb
	 ITbbhyTBcX29KpkJ4EKAZoW8eIdt7RGnXXFtofoDsn7+Mpynm3LQoOJ4S7OTVQeKnM0Ht
	 n9NAe8MqO1/StZ0xt7neKGEEdIjxhR49ZTvRz3ADB3PaiXd1YjPepnyNU0U6i5kv7Gfpx
	 kWL+Pod+CzVsn1phsZzt9DXB9moiPNFk2nNj0DiMqwRyK5hA/abVbNzmRIjlfpkEn5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=OCzXpUDo;
	arc=none smtp.remote-ip=185.70.43.22
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFED606A334;
	Tue,  3 Nov 2026 13:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FFED606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=OCzXpUDo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1793712185; x=1793971385;
	bh=Jnvtc4gqdtiixcNCaFZLBeaCmrtHkcb1NAUR/aXN7GI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=OCzXpUDodzgnJ/KkNHRu8AajhAziYdVk9f23cQWaRXHEnQSGFA+QLHR0UPGKytBA0
	 jSGUa0uQZuMLONvYIucBYUWHKswDM1GE/QL5Wq6RuUIHwh7oe41pVzGwP9Js8X8w4G
	 aaKJOOsMKUFWZ/RcVOddi8XlfWdC7pN8Z2c9dluW0FUEJ3+gPhBy2VgOSjcR/x2DT/
	 G7Z+ACnn0JX4khILjAyIGh6usoCXSQ/dyIPNZtViT5Rx76MquLNyHKK73vVSrezlwk
	 +hAvuRhWwAl1XlGJk4WLmyDpKPnl1vZN7NpFV7c6MRkpKEtuu/fFo+jHWeD1hUkGCC
	 iUBQf2Q4oX2Pg==
Date: Tue, 03 Nov 2026 13:23:03 +0000
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
From: Sinan Turunc <enscrpt@pm.me>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2] ALSA: usx2y: Reject buffers smaller than two packets
Message-ID: <20261103132247.713-1-enscrpt@pm.me>
Feedback-ID: 48393780:user:proton
X-Pm-Message-ID: 7f98d601991cc0f07238302346ff0ac8e1b05903
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

usx2y_urb_capt_retire() splits the copy into the ALSA ring buffer once
at the buffer end and wraps hwptr_done once, which is only correct when
one packet holds at most buffer_size frames. The packet size is the
endpoint's maxpacksize from usb_maxpacket(), while the hw constraints
allow 64-byte periods with periods_min 2, so a packet can be larger than
the whole buffer.

The endpoint is known at probe time, so constrain
SNDRV_PCM_HW_PARAM_BUFFER_BYTES in snd_usx2y_pcm_open() to at least
twice the endpoint's packet size. Two packets, matching the line6 fix.
The bound makes the copy safe, but it does not make every larger buffer
progress: the position is reported once per URB of 4 packets, so a
buffer that divides one URB's data returns to the same position at every
callback. That was already the case before this patch and is not changed
here. Keep a guard in usx2y_urb_capt_retire() that drops an oversized
packet with a ratelimited error, for the case that should no longer be
reachable.

Reproduced on 7.3-rc7 with a USB/IP device presenting the US-122
interface layout and 1024-byte packets into a 512-byte buffer:

  BUG: KASAN: out-of-bounds in i_usx2y_urb_complete+0x1285/0x1ac0
  Read of size 18446744073709551104 at addr ffff88800e448800 by task vhci_r=
x/83

With this patch a 1024-byte buffer is refused at hw_params; a 2048-byte
buffer is accepted and safe but barely advances (hw_ptr 9216 after 30 s,
for the reason above); a 3072-byte buffer streams for 30 s with no
report and with the position moving inside the buffer.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
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

 sound/usb/usx2y/usbusx2yaudio.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudi=
o.c
index a3a0bc13632..d1ddc2b425d 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -51,6 +51,17 @@ static int usx2y_urb_capt_retire(struct snd_usx2y_substr=
eam *subs)
 =09=09=09dev_dbg(&usx2y->dev->dev, "%s: 0 =3D=3D len ERROR!\n", __func__);
 =09=09=09continue;
 =09=09}
+=09=09/*
+=09=09 * snd_usx2y_pcm_open() constrains the buffer to hold at least
+=09=09 * two packets, so this cannot happen for a conforming device.
+=09=09 * Drop the packet rather than overrun the single wrap below.
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
@@ -880,6 +891,7 @@ static int snd_usx2y_pcm_open(struct snd_pcm_substream =
*substream)
 =09=09((struct snd_usx2y_substream **)
 =09=09 snd_pcm_substream_chip(substream))[substream->stream];
 =09struct snd_pcm_runtime=09*runtime =3D substream->runtime;
+=09unsigned int=09=09pipe;
=20
 =09if (subs->usx2y->chip_status & USX2Y_STAT_CHIP_MMAP_PCM_URBS)
 =09=09return -EBUSY;
@@ -888,6 +900,18 @@ static int snd_usx2y_pcm_open(struct snd_pcm_substream=
 *substream)
 =09runtime->private_data =3D subs;
 =09subs->pcm_substream =3D substream;
 =09snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIOD_TIME, 1=
000, 200000);
+=09/*
+=09 * The capture and playback copies wrap the ring buffer once per
+=09 * packet and advance the position by the packet, which only works
+=09 * when the buffer holds more than one packet. The packet size is the
+=09 * endpoint's, so bound the buffer by two packets here.
+=09 */
+=09pipe =3D substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK ?
+=09=09usb_sndisocpipe(subs->usx2y->dev, subs->endpoint) :
+=09=09usb_rcvisocpipe(subs->usx2y->dev, subs->endpoint);
+=09snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
+=09=09=09=09     2 * usb_maxpacket(subs->usx2y->dev, pipe),
+=09=09=09=09     UINT_MAX);
 =09return 0;
 }
=20
--=20
2.56.0

