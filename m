Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707674;
	b=upS8R60yCv1IcnOTIfh5I5l1cx32Bn4itAPn0zNM+ID2tUihT2/WClSfD/QMWthn9FJM
	 zSrrc9uIm+F5zm+2OF+LQd1EjZZlKNeH1gk15H34ZXY/SZJQU4elAXEFZ1i2n/LsGkaF4
	 13JmHoppFDWl+x0rRDwKWA/ZXx9a7/cR/xWhj/HoRGegm+ncPmnKCsRetS3jFUvnX/sDi
	 bi1RFbQ+rGmEOUeMZwEMbHYky2lRgZrvYuTKyKVO6UZ+L5nfT3R7yPh7ro3Njxq0Pnrvh
	 Hu/pUbeWnA8yqHL4YHq72fKBhgTNsxEYoxIPVxoJCi51bCmqNVhqR7XRqKlxZK8QpYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707674;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=W8ThHzrlivPu8gAbaKgXemSEWB7nzcOBJLB5Uh70tcQ=;
	b=z5blKWFEdPDaaT/vKyY0Bc8jByD4W92vNil92PrDn58x2Hr4c1eXX01iOa1Gm12l7VhX
	 cQtMjahGzp/Ej1mI5xNs0sePBdPxooGdnDtuaU7Zcio7gljkuHxFQA67aWca4VRQj5zKb
	 CjPW0jfeIs7dwAJ3yNBGak1YBRE3cQ5AM0qfaDM4OQcEtQyRsOL9oB+EyTrt4itdT3fdN
	 Z3kJ0uKFasrAUUuF3RO70r6eOIDMcYd6Zc1th4xtq4FHo4btLkRfQ2RPJvxJSWOF+2bqf
	 abQ0fD5EDS4VsXoO026ZlTM/eeVw8yBMdzO4Z+NcWJY1/7liTNGth36UKnWX5nTcdFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=oAVQtPnP;
	arc=none smtp.remote-ip=185.70.43.22
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB94606A32C;
	Tue,  3 Nov 2026 12:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAB94606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=oAVQtPnP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1793707671; x=1793966871;
	bh=W8ThHzrlivPu8gAbaKgXemSEWB7nzcOBJLB5Uh70tcQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=oAVQtPnPycudYfHaBNSNjVQgnbl3mGeLOrJBGmx7F6rRyoWhkL4U3Vr/E4hJkTeWC
	 rNW5CkP/ubEJlb5xbmVU6+5BASRin4WyvV89efXnsDtQaY5uwDZD0aPS6OQN2ukE2B
	 aKG32JVgEMOYbYfhjltUIiOZpfK/kBNlQFILJX9SHjGSVU8mNkAL2xTrWfb/DIPFLD
	 5us0k+lt1vWW0ztx+1eYlW8hhcejUxgqPMhj8ZQc2wJ2c9cl+gmmj1m18RaDqD4vLh
	 jAFkZ67CrNmU3lfDFMSfJiycSdfgq4nOEQvkUna+TT6NDZBbIe8Q6HxFU7ZOawSkJL
	 apZiuQPPsjZxw==
Date: Tue, 03 Nov 2026 12:07:47 +0000
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
From: Sinan Turunc <enscrpt@pm.me>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] ALSA: line6: Bound capture copies by the PCM buffer size
Message-ID: <20261103120723.328-1-enscrpt@pm.me>
Feedback-ID: 48393780:user:proton
X-Pm-Message-ID: 983d19f266c16ba23ba2f9fe93eab4dbe563245a
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

Clamp frames to buffer_size before the copy so the single wrap stays
inside the buffer.

Reproduced on 7.3-rc7 with a USB/IP device presenting the GuitarPort
interface layout and 1024-byte packets into a 128-byte buffer: ALSA
logged "invalid position: pos =3D 224, buffer size =3D 32" and the driver
logged "driver bug: len" on every following packet.

Fixes: 705ececd1c60 ("Staging: add line6 usb driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sinan Turunc <enscrpt@pm.me>
---
 sound/usb/line6/capture.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index 6dbaf30232f..7d8e7e83eeb 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -94,6 +94,17 @@ void line6_capture_copy(struct snd_line6_pcm *line6pcm, =
char *fbuf, int fsize)
 =09if (runtime =3D=3D NULL)
 =09=09return;
=20
+=09/*
+=09 * A packet can carry up to max_packet_size_in, which the device
+=09 * chooses, while the ring buffer can be as small as one 64-byte
+=09 * period. The single wrap below is only valid for
+=09 * frames <=3D buffer_size, so keep what fits.
+=09 */
+=09if (unlikely(frames > runtime->buffer_size)) {
+=09=09frames =3D runtime->buffer_size;
+=09=09fsize =3D frames * bytes_per_frame;
+=09}
+
 =09if (line6pcm->in.pos_done + frames > runtime->buffer_size) {
 =09=09/*
 =09=09   The transferred area goes over buffer boundary,
--=20
2.56.0

