Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.121
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707717;
	b=KjXxD+CvClh/yYEb8CIcjdeup5CEAYpzlZs//4Ej5n67qhvAubtZuExyyfivL4ob3Z+m
	 fPWSW8KXjMj9YXlh+e5oBE1gTbyjMgZHvyIT5zL1G1z/arh387uw/ASIPK+MZCTdQHt/l
	 JvENhXhhUCpVBdMG2LMA0gQpEdoVifTNyHX2U9Ny2iVrbzGxYjALHopJmdCDdSWWiY/Nv
	 k4G7zNEIfdQcR/L6cPO0TmNTBdbrKxvkS4OZegZfMpdrLeZTsBJT4uYEXX0aGxSh7Z6Wx
	 IcS/HYatawZ5FyAjYwfQsmIsGRkMaBOXEUkabaD9wfIxn1teAJQtnVLEzzOCC4D9u+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707717;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/x6us06Il7cOBuX1Y5NFLXJj/ZFRDHp6C1Wighv86dA=;
	b=mIVAvmyptrPMPDD1noI9rHi0YFdW3+bKl44yOzxt0cKFKcHBmD+QxfK2mRWWn++PxafW
	 nBEbSVCuaAFBucxZLZIm4hTrzuDQsXPDaazHkRgfivkxIkcWcTrL1HYvgwNlmn6nDbWlb
	 0IT4AL8ftiTy1CAR+ncaWB2i7BiNFUu7/bzwyhXwOpTwpG8NSbiyruQUxtZCwmd7K1rHf
	 VyEW0wxnkshZGqMNv9M/Nyb75eyKg9EgeemINYBy/NTIalETFYsqpWEAZUA2PNXrUzK7K
	 cVJiL1i17f07dh4ElfWlNXS0Qm278K/55o32eE2FXE0D+EiHZHkO/rcokZAF+rcgn7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=BZ5ZHSZM;
	arc=none smtp.remote-ip=79.135.106.121
Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9752A606A327
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 12:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9752A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=BZ5ZHSZM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1793707713; x=1793966913;
	bh=/x6us06Il7cOBuX1Y5NFLXJj/ZFRDHp6C1Wighv86dA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=BZ5ZHSZM/I0LtXxu9OGkUKtKV/QAeIsJntO4GzSoEwDTmamrAU8Soo0wgPH3QlV07
	 +RFyNWdZzVkPN8BfGuLaTWmUsS5oUEBepzJ64HO6wKaW6HR3gkbhNikwq4dF2DsZyG
	 oEt4AzybXkj0f9FdEttBwpQUGD9EBN7ys0wt5LJSkZoIJMasvlAI7OttSX5BI4dJyT
	 JdOWqBPHoo+Pq5tEj1ZeVrvkntJbwlVtNQzUn+ySVe6aJC6+Tqo7NRMV+Ge+VpODO9
	 NG4V7/6neFq+EhZAx2A+vuwScsjcBJTUbiTFjNq1lUKgC2v38X27ZR8gZk1+RIKg4P
	 BH24CtGBfp4rA==
Date: Tue, 03 Nov 2026 12:08:29 +0000
To: Mauro Carvalho Chehab <mchehab@kernel.org>
From: Sinan Turunc <enscrpt@pm.me>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] media: cx231xx: Bound audio copies by the PCM buffer size
Message-ID: <20261103120813.362-1-enscrpt@pm.me>
Feedback-ID: 48393780:user:proton
X-Pm-Message-ID: b6799638f4bb857c45e6b0a2e0d6c3c3b2c384ad
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
setting, while the hw constraints allow 64-byte periods with
periods_min 2, so a packet can be larger than the whole buffer.

Clamp length to buffer_size before the copy in both callbacks so the
single wrap stays inside the buffer.

Reproduced on 7.3-rc7 with a USB/IP device presenting a Pixelview
Xcapture interface layout and 1024-byte packets into a 128-byte buffer:

  BUG: KASAN: use-after-free in cx231xx_audio_isocirq+0x2c7/0x780
  Read of size 4294966528 at addr ffff88800e8e0400 by task vhci_rx/82

Fixes: e0d3bafd0258 ("V4L/DVB (10954): Add cx231xx USB driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sinan Turunc <enscrpt@pm.me>
---
 drivers/media/usb/cx231xx/cx231xx-audio.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/media/usb/cx231xx/cx231xx-audio.c b/drivers/media/usb/=
cx231xx/cx231xx-audio.c
index b24ceef497e..4e5110dd160 100644
--- a/drivers/media/usb/cx231xx/cx231xx-audio.c
+++ b/drivers/media/usb/cx231xx/cx231xx-audio.c
@@ -123,6 +123,15 @@ static void cx231xx_audio_isocirq(struct urb *urb)
 =09=09=09if (!length)
 =09=09=09=09continue;
=20
+=09=09=09/*
+=09=09=09 * A packet can carry up to max_pkt_size, which the
+=09=09=09 * device chooses, while the ring buffer can be as small
+=09=09=09 * as two 64-byte periods. The single wrap below is only
+=09=09=09 * valid for length <=3D buffer_size, so keep what fits.
+=09=09=09 */
+=09=09=09if (unlikely(length > runtime->buffer_size))
+=09=09=09=09length =3D runtime->buffer_size;
+
 =09=09=09oldptr =3D dev->adev.hwptr_done_capture;
 =09=09=09if (oldptr + length >=3D runtime->buffer_size) {
 =09=09=09=09unsigned int cnt;
@@ -210,6 +219,10 @@ static void cx231xx_audio_bulkirq(struct urb *urb)
 =09=09=09=09     stride;
 =09=09=09cp =3D (unsigned char *)urb->transfer_buffer;
=20
+=09=09=09/* same bound as in cx231xx_audio_isocirq() */
+=09=09=09if (unlikely(length > runtime->buffer_size))
+=09=09=09=09length =3D runtime->buffer_size;
+
 =09=09=09oldptr =3D dev->adev.hwptr_done_capture;
 =09=09=09if (oldptr + length >=3D runtime->buffer_size) {
 =09=09=09=09unsigned int cnt;
--=20
2.56.0

