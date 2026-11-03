Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.28
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707697;
	b=B1pR+Pp7dbsjkQOf4VFS4nayxJYYmQcGzHBCY0orlHMtgFasqtB1gpsg3rS+vMW7CDQ/
	 VnLvcWZpY7kTh9M+OgW17rRB658LCEBcNDWyV0Dj0lFkcPVE4Mydgf0O3m8L8f1AqcqI1
	 O9eis6CdAh2tiepxTShfaldwyiwmLyuJwIy26gSN58GD5sHxMJJG7kCbLZvL9qhrmK9aB
	 M98UGob4H2f/gp0E6yNlSQcpkPvDJqp/BlUFkLS5oM2mvnoim+aeNTahPgIRStjocvwk6
	 i29Bn+xQ3Yh8GDWElcnte1T8DOIxUNxzZqavNfWmc8bKg9Wek3wQRIVdl/zNn1t/i7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707697;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wK+F9iSHxL12xB7GmsXN/Ir/YPM0zAj50vPxKwtp7tk=;
	b=slMt5lurUfndxynt9CfzmHSXn4gAAKvhySCzN9Q7pdhxyhnSGgkXiieUPMOGbrnxuXJc
	 9+IrJ3CSYmnqY+5xkv+b9gn7LuN1sxZk90PofrGrhZv3P1A8rPEzzLeiaY3lCo7v2qegN
	 WwAmwYPRtN9dXf6L3bYGVOT0ST1dzbjK10CMxMq/tcUXguqyFCVLKaKPxbNYpDJnvWxH2
	 OOBdGIUCadLIu1Euo3XFgHP/nTn0AXs164pSsF3RJ6a0n+2clPq1fIG71BiX/vmeUuLL0
	 D40on9mVbgfopSUU7CKlFc/9rxQgXMEA5xrFY/x3zP3iGAKhkPEi0+7CG/3HDQy0Nmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=qGhvasLw;
	arc=none smtp.remote-ip=79.135.106.28
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02CF606A32D;
	Tue,  3 Nov 2026 12:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D02CF606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=qGhvasLw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1793707694; x=1793966894;
	bh=wK+F9iSHxL12xB7GmsXN/Ir/YPM0zAj50vPxKwtp7tk=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=qGhvasLwC4X9P1ioZMYv9+YOpw2IGUZwubTO3J/AuSt1Mp+qkyBGTQnJwFOjAhHKl
	 c3HmO9LMdLhyYfBumGvrpKnbC5gW21GecQv2sK9AN/1BRNUOyt4JnIRoKlM4OZb/Nw
	 TKJeiyaFKkE1f8CPRsWwQRkHR+G8lIO+/EsNnw/knZ6NIWfqvx79EQ2Q7TWlzxi/NT
	 s2zQZ92Eql9PD6+4NeDT/k8ME8BdTDzXy+e1B4bsPG8aiwLJLjldIXvpxBSIm8qdtB
	 kywvmqblNYPPQPbdFqcBfK/oXAUaZ6sMuLQC+FsKzzg+vYgdDnSTzgElxp6pmm8fKO
	 nZ2Dj3GsihqcQ==
Date: Tue, 03 Nov 2026 12:08:09 +0000
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
From: Sinan Turunc <enscrpt@pm.me>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] ALSA: usx2y: Bound capture copies by the PCM buffer size
Message-ID: <20261103120753.345-1-enscrpt@pm.me>
Feedback-ID: 48393780:user:proton
X-Pm-Message-ID: b88b7f34eef7d0237507a0ef2f71b4f8760194ec
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
allow 64-byte periods with periods_min 2, so a packet can be larger
than the whole buffer.

Clamp len to buffer_size before the copy so the single wrap stays
inside the buffer.

Reproduced on 7.3-rc7 with a USB/IP device presenting the US-122
interface layout and 1024-byte packets into a 512-byte buffer:

  BUG: KASAN: out-of-bounds in i_usx2y_urb_complete+0x1285/0x1ac0
  Read of size 18446744073709551104 at addr ffff88800e448800 by task vhci_r=
x/83

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Sinan Turunc <enscrpt@pm.me>
---
 sound/usb/usx2y/usbusx2yaudio.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudi=
o.c
index a3a0bc13632..ea4ae5caba6 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -51,6 +51,14 @@ static int usx2y_urb_capt_retire(struct snd_usx2y_substr=
eam *subs)
 =09=09=09dev_dbg(&usx2y->dev->dev, "%s: 0 =3D=3D len ERROR!\n", __func__);
 =09=09=09continue;
 =09=09}
+=09=09/*
+=09=09 * A packet can carry up to maxpacksize, which the device
+=09=09 * chooses, while the ring buffer can be as small as two
+=09=09 * 64-byte periods. The single wrap below is only valid for
+=09=09 * len <=3D buffer_size, so keep what fits.
+=09=09 */
+=09=09if (unlikely(len > runtime->buffer_size))
+=09=09=09len =3D runtime->buffer_size;
=20
 =09=09/* copy a data chunk */
 =09=09if ((hwptr_done + len) > runtime->buffer_size) {
--=20
2.56.0

