Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.121
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793054215;
	b=OzXrRmeoYjRfinkwFPlcPhvGTOpWnWVHuiPf5OPvB9WCLm6LXgtqXcjdYhJ3bQiRaefW
	 a0bf6plNolKPDZTUDJaSMWFDwX4Dwj1XA26Y53tfZ0PlRvSKacVUm62u/OldmAVuj/r3q
	 G3SKJybV4wfuPHciXc8FWYY6fc9sg81kTRtKmQiTxIK0ghKlblV9L6VsYMzI1AVo4KJ7A
	 ZKoF7BrIJOqXq8oIaZi9QXbC+6FbsvFCipOGBFxcyD6OYsetiy0NIadkY+90EvbWcFMJP
	 STRiiAfdyqU6JptAeqczkDef5PMoaoEsxE/oul1gM0k5/Ct4oOYoz34T7+I4CQ7kOaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793054215;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=LSzChQayDvgm3wQsdTfsK8Vmg8juNB+gYjKT5q5bH28=;
	b=AFV6FgWilN0tcEiEdGY7ttGXDC3+wVkRBo3sdjJ1g8GxwPzKwx2NWW8PBTe5VfUpK+Cg
	 1sxlx2ruIa9WN3/YFvwSjO8vWrZuFw9s+8/BQjSuHPst6j9szkar4j65uTgHTrwE0iF7s
	 01CrXnuomn/Sj948qeLgDZcP84jtijsJY32uiRqE3yg1ezr78rAmPbv5otVKYWZ+Cw7bY
	 rh0vt4KFleQfAJdSCOOxf+fuVckkcgTYJvOCW+Q1rj62w6KBu30hTZ0xjWyCdZKHkDLmU
	 7DO2JCAeyGOfTRHrraSBpj8jug4ckYqQomEGaEcxQv2KLIYjU89cruP0930ibLYyskA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=RygYxQPf;
	arc=none smtp.remote-ip=79.135.106.121
Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52A2606A31A;
	Mon, 26 Oct 2026 22:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A52A2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=RygYxQPf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1793054212; x=1793313412;
	bh=LSzChQayDvgm3wQsdTfsK8Vmg8juNB+gYjKT5q5bH28=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RygYxQPfbsy0i1dIarK2SdJRoabea6Qq/C+RLJz5AJYawETCENx8lZvrTHg+XYYE2
	 u9LmArKSeSq/VkfsLPWE8R5kOBIXhxrj4wooappJizaPPXDvwA7kEi0dLyr+7abCzm
	 w3P+eUiE2j1DZuX8EQAH4mmyqjVtSjgjQGZtro9q4jksdPMQBOUZHUKyo73mCA15nQ
	 /UHDsfGNqRoUilDvJ2G9xA9OJ8hq+7+BEKciCbd1LczuWEXOc+ImlgcuIQPf/Er7r9
	 6JxX5bk+DQGFxcjrZrw5Uadj9O4AuYwaI2Ej0MKgGuon2otILxMQZesaLea0i2IDTk
	 MlG/mwUPKdHTA==
Date: Mon, 26 Oct 2026 22:36:47 +0000
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Clemens Ladisch <clemens@ladisch.de>
From: Sinan Turunc <enscrpt@pm.me>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 2/2] ALSA: ua101: Bound packet copies by the PCM buffer size
Message-ID: <20261026223543.620-3-enscrpt@pm.me>
In-Reply-To: <20261026223543.620-1-enscrpt@pm.me>
References: <20261026223543.620-1-enscrpt@pm.me>
Feedback-ID: 48393780:user:proton
X-Pm-Message-ID: 869b78e3fdd32c8f22a6606cdc6e5da3e975d8bd
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

copy_capture_data() and copy_playback_data() wrap the ring buffer
position once and split the memcpy() in two at the buffer end, which is
only correct when one packet holds at most buffer_size frames. The
capture packet size is the device's (actual_length up to wMaxPacketSize,
divided by 3 * bNrChannels from its own descriptor), the playback packet
size is taken from the capture packets, and set_stream_hw() lets the
PCM client pick period_bytes_min 1, periods_min 2 and a period time of
1.5 packet intervals: 9 frames at 44.1 kHz high speed, an 18-frame
buffer. A device sending 672-byte mono 24-bit packets delivers 224
frames per packet.

After the first packet buffer_pos is 206 and stays beyond buffer_size.
On the next packet frames1 =3D buffer_size - buffer_pos wraps and memcpy()
runs away:

  snd-ua101 2-1:1.0: invalid position: , pos =3D 206, buffer size =3D 18,
period size =3D 9
  BUG: KASAN: slab-out-of-bounds in capture_urb_complete+0x9eb/0xcb0
  Read of size 4294966732 at addr ffff88800d73e7e0 by task vhci_rx/81

and for playback:

  BUG: KASAN: vmalloc-out-of-bounds in playback_work+0x789/0xac0
  Read of size 4294966732 at addr ffffc9000002626a by task kworker/0:1H/80

Clamp the capture copy to buffer_size. On playback, copy at most one
buffer and fill the rest of the packet with silence, so the URB length,
the delay accounting and the data sent stay consistent. With that bound
the single wrap and both memcpy() halves stay inside the buffer. A
device whose packets do not fit the buffer never played correctly
anyway.

Reproduced on 7.3-rc7 with a USB/IP device presenting the UA-101
interface layout and a 672-byte isochronous endpoint.

Fixes: 63978ab3e3e9 ("sound: add Edirol UA-101 support")
Cc: stable@vger.kernel.org
Signed-off-by: Sinan Turunc <enscrpt@pm.me>
---
v2: From and Signed-off-by now carry my real name. No code change.

 sound/usb/misc/ua101.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/sound/usb/misc/ua101.c b/sound/usb/misc/ua101.c
index 58d8a3cdc8b9..bd8e0ed0ba5d 100644
--- a/sound/usb/misc/ua101.c
+++ b/sound/usb/misc/ua101.c
@@ -285,13 +285,29 @@ static void playback_work(struct work_struct *work)
 =09=09=09/* fill packet with data or silence */
 =09=09=09urb->iso_frame_desc[0].length =3D
 =09=09=09=09frames * ua->playback.frame_bytes;
-=09=09=09if (test_bit(ALSA_PLAYBACK_RUNNING, &ua->states))
+=09=09=09if (test_bit(ALSA_PLAYBACK_RUNNING, &ua->states)) {
+=09=09=09=09/*
+=09=09=09=09 * The packet size comes from the capture stream,
+=09=09=09=09 * i.e. from the device, while the ring buffer can
+=09=09=09=09 * be as small as two tiny periods. The single wrap
+=09=09=09=09 * in copy_playback_data() is only valid for
+=09=09=09=09 * frames <=3D buffer_size, so copy at most one
+=09=09=09=09 * buffer and send silence for the rest.
+=09=09=09=09 */
+=09=09=09=09unsigned int copy_frames =3D min(frames,
+=09=09=09=09=09ua->playback.substream->runtime->buffer_size);
+
 =09=09=09=09do_period_elapsed |=3D copy_playback_data(&ua->playback,
 =09=09=09=09=09=09=09=09=09urb,
-=09=09=09=09=09=09=09=09=09frames);
-=09=09=09else
+=09=09=09=09=09=09=09=09=09copy_frames);
+=09=09=09=09memset(urb->transfer_buffer +
+=09=09=09=09       copy_frames * ua->playback.frame_bytes, 0,
+=09=09=09=09       (frames - copy_frames) *
+=09=09=09=09       ua->playback.frame_bytes);
+=09=09=09} else {
 =09=09=09=09memset(urb->transfer_buffer, 0,
 =09=09=09=09       urb->iso_frame_desc[0].length);
+=09=09=09}
=20
 =09=09=09/* and off you go ... */
 =09=09=09err =3D usb_submit_urb(urb, GFP_ATOMIC);
@@ -320,6 +336,13 @@ static bool copy_capture_data(struct ua101_stream *str=
eam, struct urb *urb,
=20
 =09runtime =3D stream->substream->runtime;
 =09frame_bytes =3D stream->frame_bytes;
+=09/*
+=09 * A packet can carry up to max_packet_bytes, the device's
+=09 * wMaxPacketSize, which may exceed the whole ring buffer; keep what
+=09 * fits so the single wrap below stays valid.
+=09 */
+=09if (unlikely(frames > runtime->buffer_size))
+=09=09frames =3D runtime->buffer_size;
 =09dest =3D runtime->dma_area + stream->buffer_pos * frame_bytes;
 =09if (stream->buffer_pos + frames <=3D runtime->buffer_size) {
 =09=09memcpy(dest, urb->transfer_buffer, frames * frame_bytes);
--=20
2.56.0

