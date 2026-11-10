Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794290437;
	b=wgZp9XmpP6YQ6MexmiO6Jhsbdqdwpe3W7BGTHfuNdGfCTaBKiIH68qy8rFb6gNoPBSNz
	 6hLe+XakJyChrNeSdHpfHvCsYNSsNvLQeXF6fWe3c+VcVQZ2PEg1dxkz+DNPOp5Zc4NAC
	 8tZtnE4i2QbcEvrNinyliKQfcrUXLUA31Y5WZsiAtuX/hU+uwsjyVhUfnA7bXWJBWiYKG
	 viKZrtJw9RNGlSDJsc623Ts/XYPBerKNflPVNLWxJ3BJHhTuBH6a+Lwa8Cjzj8GANFMuL
	 hR5+hQHpzdqzI+cVF8uzjT8ZVs0vZBQkDjzxYIVkrA9wwYsMwMw9e33E6/SNiqWsY5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794290437;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:
	 Content-Type:CMS-TYPE:cpgsPolicy:X-CFilter-Loop:X-CMS-RootMailID:
	 References;
	bh=HRSkNBNCGQP3+WWuKL4PepJWaawJY/A9pCIWUz3AJ1k=;
	b=hlSBfanQGYc3xCLPaCAZoICQY+sJ85vyN/9CSTOd8KGHCfY+qJtfFZX/qKhtsb1JOlms
	 J7+Aq8ZJ7PjURpayWpRmddPtLA/C7GZ/Bk6ZaOCbMKvcyWJWmHzh1PH29Y4/CYXhinvjq
	 DK+QefJq/cb5N+Dro4crknPs0dvnZujg+7qaeKnHxL/C8NcTgLmvn1erJsVnXLHfA4b96
	 0KtZc9i8QYMlWiz2d9pCetILIZr9wkKaI/ZwFRkyGs/BCHrmGvjUWtsrJgGbAyGAQNUwP
	 HhEEKnRdaXAMIat+ovNrtE3slTWk2H0tHARvE1Ylm1b5//nLSSCrjAnR7lO53Rg4auw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=kzBdfRfG;
	arc=none smtp.remote-ip=203.254.224.33
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BFF606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3BFF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=kzBdfRfG
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20261110060033epoutp0367dd48e21eee68ad2ad0768ca3b1fd62~mmaSH0ylI0711607116epoutp03N
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:00:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20261110060033epoutp0367dd48e21eee68ad2ad0768ca3b1fd62~mmaSH0ylI0711607116epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794290433;
	bh=HRSkNBNCGQP3+WWuKL4PepJWaawJY/A9pCIWUz3AJ1k=;
	h=From:To:Cc:Subject:Date:References:From;
	b=kzBdfRfGjn+JPeC1M9qDbAcZFOw+yh3EcWn6wRzN4HfuL9YQ19KW1EA14DA1qoiPl
	 AhyMIg1LXtwIVZ1R85Fbix3Uc7hhwsoYH+2B3IIa901iNf1lX1cSK+5BS9C418oVCD
	 Kqk6fW7HjtPjRhQ1q1G90XmSTvFWjNvEpFV9MXDo=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPS id
	20261110060033epcas1p3f16322cf7597964bea512dd529242333~mmaRrbJwt1479314793epcas1p3C;
	Tue, 10 Nov 2026 06:00:33 +0000 (GMT)
Received: from epcas1p4.samsung.com (unknown [182.195.38.116]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4jNwxD49W4z6B9mQ; Tue, 10 Nov
	2026 06:00:32 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261110060032epcas1p1a4de057d86d384387d0b8004d63ef331~mmaQzxQ980234802348epcas1p1F;
	Tue, 10 Nov 2026 06:00:32 +0000 (GMT)
Received: from VDBS1420.vd.sec.samsung.net (unknown [168.219.244.32]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261110060032epsmtip2a880c20583abe50f7ea0aa2017e23612~mmaQwqyF30109101091epsmtip2e;
	Tue, 10 Nov 2026 06:00:32 +0000 (GMT)
From: Gichoon Han <gichoon.han@samsung.com>
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: Sinan Turunc <enscrpt@pm.me>, Edward Adam Davis <eadavis@qq.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, Gichoon Han
	<gichoon.han@samsung.com>, stable@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Drop capture packets with bogus
 actual_length
Date: Tue, 10 Nov 2026 15:00:21 +0900
Message-Id: <20261110060021.2146383-1-gichoon.han@samsung.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261110060032epcas1p1a4de057d86d384387d0b8004d63ef331
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-702,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261110060032epcas1p1a4de057d86d384387d0b8004d63ef331
References: <CGME20261110060032epcas1p1a4de057d86d384387d0b8004d63ef331@epcas1p1.samsung.com>

retire_capture_urb() copies urb->iso_frame_desc[i].actual_length bytes
out of urb->transfer_buffer at the packet's offset, but never checks
that value against the requested packet length.  A host controller
reporting more data than requested makes memcpy() read past the end
of the URB transfer buffer.

Commit 06be918062ad ("ALSA: usb-audio: Bound packet copies by the PCM
buffer size") clamps the count to the PCM ring buffer size, which
protects the destination.  The source slot is only ep->curpacksize
bytes per packet, though, so the over-read remains.

This was hit on an ARM32 system (vendor 5.4 kernel; the code path is
unchanged in mainline) with a full-speed UAC1 microphone behind a
high-speed hub, i.e. the EHCI siTD path.  sitd_complete() computes
actual_length as desc->length - SITD_LENGTH(t); the controller
reported a remaining length larger than the programmed one, the value
wrapped to ~4G, and the capture copy faulted on the first unmapped
page after the URB buffer:

  Unable to handle kernel paging request at virtual address e8756000
  Internal error: Oops: 7 [#1] PREEMPT SMP ARM
  r3 : 00000000  r2 : 0001e700  r1 : e8756000  r0 : e878fc80
  Code: ba000002 f5d1f03c f5d1f05c f5d1f07c (e8b151f8)

A packet can never legitimately carry more than its requested length,
so warn and skip it instead of copying.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Gichoon Han <gichoon.han@samsung.com>
---
Compile-tested only on linux-next.  The crash was observed in the
field on a vendor 5.4-based ARM32 kernel with the same code path;
I don't have a setup to reproduce the bogus siTD length on mainline.

 sound/usb/pcm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index c2f7b08607ac..57a26492dd61 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1337,6 +1337,12 @@ static void retire_capture_urb(struct snd_usb_substream *subs,
 					    "frame %d active: %d\n", i,
 					    urb->iso_frame_desc[i].status);
 		bytes = urb->iso_frame_desc[i].actual_length;
+		if (unlikely(bytes > urb->iso_frame_desc[i].length)) {
+			dev_warn_ratelimited(&subs->dev->dev,
+					     "packet %d: actual_length %u exceeds length %u, dropping\n",
+					     i, bytes, urb->iso_frame_desc[i].length);
+			continue;
+		}
 		if (subs->stream_offset_adj > 0) {
 			unsigned int adj = min(subs->stream_offset_adj, bytes);
 			cp += adj;

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
-- 
2.25.1

