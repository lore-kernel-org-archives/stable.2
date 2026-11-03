Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.121
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712171;
	b=rqpoUZ93CRBboAokx9bBcaZaZiXJGDh1KfLU4ku42ShBbrNPCnBRU93KN2l04emX6yiR
	 e5R2pZrpc1ITUTe2MpuJzYW6fEdkh4EKf050SpWIaK3nxiEVAt0w06SXY+YfhLyaDhZwe
	 P5R25M/CMGG/ITdnGFdToml5DIFMTgYPOzGET2IrCdkvjv9vH9NqnYSeTsYb6/l2enTzH
	 Cp9CzuS20B4/81Cmk+qiWsCV9v54cTGI4hIc4eGynRUHH9AzHZ2g/TW9KbA9P6+NRyCWL
	 dwr5UPWzsfRztZmpS26fwdM/JIfhrFW51BVSNprNs7hN0nTqGrRbs67xYU5QlvQDF4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712171;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=iQivvky2ATDTmaxZzTIV2FyhaqawfZzHTFUstVZoE7s=;
	b=Yks5kxRYVONa3i8rvI+bX94g3Ib3b0z8DSKJQTy4QwwikRpHj4TBIpdSFUofTZRBOC06
	 5Yecar4HRwEYHxLS/x7M5iKwsZeOYSLYZYZheyAN9S7fbmo6+880iBFQv3thQ7AgFSO+x
	 TiYqJVyRoP+/UYtmz0MLl/ReelmKbeS9qe+D0gFn174rlxcDIUoUHGcMk6KhlyGVvwEUH
	 0xYzkLGPcC9NVk82GJYP93D3nZhn5ceeEPnau0t6eflmz53e5iqoBWpRumeJAA+23CLiY
	 a6RxamoUwSTw5mZqsggxpw7vfjW3RITyPmw2oJ389r+AvSNK2cNYa+ie6rXdZIjVDPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=RXPsMV1x;
	arc=none smtp.remote-ip=79.135.106.121
Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37126606A324;
	Tue,  3 Nov 2026 13:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37126606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=RXPsMV1x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1793712169; x=1793971369;
	bh=iQivvky2ATDTmaxZzTIV2FyhaqawfZzHTFUstVZoE7s=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=RXPsMV1xT0Do4WHpXEam5AhviJnf4d2MuC5A7yUmIF03LFsA440tOD9TnQQLanCSO
	 mRkmPMGLPCvh31AnOGr30HUh0mZaZxyWCvOHPRoOEzcVE008RT8Ly6R/GjHZPgvE42
	 6zZrS+m5lboG2otqtralXJSQrJnIJnahOPymjBtIn0k5d4dx19BvIUnIN5nBh0mIj3
	 BLNO7U0n+GpqRkhdsNN/UbuxaLEuv9r8QayNwuNUIaxP1a7kV+eotubv/m1NYz2adN
	 r3u+am2GydXBtgrdSwAObtBl0O1u9OLqZFoGEDhfysKNDz340C2aar6qqGq9sThz17
	 xLYF6bUi6I6+A==
Date: Tue, 03 Nov 2026 13:22:44 +0000
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
From: Sinan Turunc <enscrpt@pm.me>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2] ALSA: line6: Reject capture buffers smaller than two packets
Message-ID: <20261103132227.696-1-enscrpt@pm.me>
Feedback-ID: 48393780:user:proton
X-Pm-Message-ID: ccc3b01cd691daf4f6f25c596ac56161c798b3e0
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

line6_capture_copy() splits the copy into the ALSA ring buffer once at
the buffer end and wraps pos_done once, which is only correct when one
packet holds at most buffer_size frames. The packet size comes from the
device's endpoint, and the per-device hw structs allow 64-byte periods
with periods_min 1, so a packet can be larger than the whole buffer.
audio_in_callback() logs an oversized packet and then copies it anyway.

The packet size is known at probe time, so constrain
SNDRV_PCM_HW_PARAM_BUFFER_BYTES in snd_line6_capture_open() to at least
twice the larger of the two endpoints' packet sizes. Two rather than
one, because pos_done advances by the packet and wraps once, so a buffer
of exactly one packet leaves the position unchanged after every packet.
hw_params then rejects a buffer that cannot hold two packets, and the
single wrap is valid for every configuration that gets through. Keep a
guard in line6_capture_copy() that drops an oversized packet with a
ratelimited error, for the case that should no longer be reachable.

Reproduced on 7.3-rc7 with a USB/IP device presenting the GuitarPort
interface layout and 1024-byte packets into a 128-byte buffer: ALSA
logged "invalid position: pos =3D 224, buffer size =3D 32" and the driver
logged "driver bug: len" on every following packet. With this patch a
1024-byte buffer is refused at hw_params, and a 2048-byte buffer streams
for 30 s with no report and with the position moving inside the buffer.

Fixes: 705ececd1c60 ("Staging: add line6 usb driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sinan Turunc <enscrpt@pm.me>
---
v2: constrain the buffer at open instead of clamping in the copy. v1
clamped the frame count to buffer_size, which left the ring position
unchanged on every oversized packet and stalled the stream, as the
Sashiko review of the line6 patch pointed out. A buffer of exactly one
packet has the same effect, so the bound is two packets. The clamp is
replaced by a drop guard for the case the constraint makes unreachable.

 sound/usb/line6/capture.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index 6dbaf30232f..7aaf7826c48 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -94,6 +94,18 @@ void line6_capture_copy(struct snd_line6_pcm *line6pcm, =
char *fbuf, int fsize)
 =09if (runtime =3D=3D NULL)
 =09=09return;
=20
+=09/*
+=09 * snd_line6_capture_open() constrains the buffer to hold at least
+=09 * two packets, so this cannot happen for a conforming device. Drop
+=09 * the packet rather than overrun the single wrap below.
+=09 */
+=09if (unlikely(frames > runtime->buffer_size)) {
+=09=09dev_err_ratelimited(line6pcm->line6->ifcdev,
+=09=09=09=09    "packet of %d frames exceeds %lu-frame buffer, dropping\n"=
,
+=09=09=09=09    frames, runtime->buffer_size);
+=09=09return;
+=09}
+
 =09if (line6pcm->in.pos_done + frames > runtime->buffer_size) {
 =09=09/*
 =09=09   The transferred area goes over buffer boundary,
@@ -224,6 +236,23 @@ static int snd_line6_capture_open(struct snd_pcm_subst=
ream *substream)
 =09if (err < 0)
 =09=09return err;
=20
+=09/*
+=09 * line6_capture_copy() wraps the ring buffer once per packet and
+=09 * advances pos_done by the packet, which only works when the buffer
+=09 * holds more than one packet: with exactly one, pos_done gains a
+=09 * buffer and loses it again on every packet. The packet size comes
+=09 * from the device, so bound the buffer by two packets here. The
+=09 * impulse-response path copies a playback URB into this ring, so
+=09 * take the larger of the two endpoints.
+=09 */
+=09err =3D snd_pcm_hw_constraint_minmax(runtime,
+=09=09=09=09=09   SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
+=09=09=09=09=09   2 * max(line6pcm->max_packet_size_in,
+=09=09=09=09=09=09   line6pcm->max_packet_size_out),
+=09=09=09=09=09   UINT_MAX);
+=09if (err < 0)
+=09=09return err;
+
 =09line6_pcm_acquire(line6pcm, LINE6_STREAM_CAPTURE_HELPER, false);
=20
 =09runtime->hw =3D line6pcm->properties->capture_hw;
--=20
2.56.0

