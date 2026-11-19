Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795131008;
	b=CRAMMKPxYBaLkGrVDVUng/8M7OjOJoMUXA/hdhhWvpzPv2t8WAV1AF5VjMtp+03eaiSZ
	 0oYKthSbjEzXvx7hfoBiTNa9dSBls2yM2QKNwb/MKmcjWVMfxDdgBgqvCyIP8UAAEHkj1
	 Wo82AIBIG51UhIM6wP3cNyjBpmT+xKGDaPCJh2T1v0g0ibr8m6M2zkgO/aqICKOJAZSrC
	 2XTWRm9VOIF8kwedChwUScmJXYaCJD1YwyaDJoQcPCIdQXg5ID054eWXPphkJjzJX/p/a
	 AhKAR2Eo8Q6DLe3mpEZrx7By7cUrM0USMrFzAqTghQ34r00bkH+pJYQbL6jOAuuvNLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795131008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ea1gJLVhc2AO1s67WLIHygzyGKJ2RI2yud9cLOuT1ts=;
	b=GX+5lJSFpQHBGWpQEDG4MCqqjFgeeyRs/SK7Q3b1ugeR1rhbq+LbSck6n4vCzgFlanMd
	 M/FwcyhvkuZgzYaocYq6gRTOmKlbFlkuo0fQPnDJl/ymCKdv6+XzDUgjIcQC3zPjsZmfg
	 JeQOcny7t8TlGFNPdYaqbri+VT0JwTgN09v/vnJS3RRaFXocOSd8nZm0k6Zg2KZlxhlsI
	 1nR0rV4v+kxDSJfsyoz8BTaHySekhmHJyUYcG+FSTpafFrS0g1sNslu4Uz8qZPwxHbFKc
	 ovBxf3fDuDXG4h6Owmc/bVRGrPBysN6wPgUwc0gizBVYGGjm1Y9U9N5J31aRtmViwDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=asN7KogE;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE8B60A261F
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 23:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CE8B60A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=asN7KogE
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-38431138772so316827eec.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 15:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795131007; x=1795735807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ea1gJLVhc2AO1s67WLIHygzyGKJ2RI2yud9cLOuT1ts=;
        b=asN7KogEdB96Lzvh3BR5oH7SonpAuK8Q2/X/M8t/crF2IPtJoovK27hdTnMt/868+D
         TlvSSoQnPXoxVLQUX6pbtp+CEK/iNCQ2sCdAtBuCn12ID9Sa6CMD+gAkoOTNtsZYIpWD
         kBB23MWbIvaw/oBLvyUxwiSeAVOBonehR1MMIwFJmBJ3rJcuDTAzrdUuUrgibVQe5Gu+
         YM7VLIXm+p+jSM8Mv68Z0hbhMPQ4MnjDt+jHjKhJt/bK2xMOWPh9/wTsLuVfh+zKdvRp
         wXt3wfZdhL46pF5G/40RYxoUecauz7ILlISDElM0d6d9amgqwsDiPefYW7+cdMo7X9eD
         kq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795131007; x=1795735807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ea1gJLVhc2AO1s67WLIHygzyGKJ2RI2yud9cLOuT1ts=;
        b=hRpMkvK46cwvc4n1T8/D+QNSczHdFIszqiPa6+oyBSQE3otFlkbJ50LSnJzNf4NgZN
         MfQr71Lm2SLyiiJZLIgY4iXGzo9oIyCEhXFT6NPQLb+brQoWPDkzeU0IK6UHBThcCz0d
         3ujUStVSyI18JnPHYM9nkak8Go0jIHih5DmTixYDQb8gdBUvwXEOPY2gorVUh+BRHvY0
         PXy8nCu4xtGdwNkoPfQhy0Yvp61RofdRvOZ9QmXbEWM6iBx6zKMjArPLDSv371qZJo8B
         djN63bn6CkBWzwtV0yClgfgKhSrDHEm5JKVDSi8Dbab3Ov0XOTec1B9cNzz/0TAXKk1b
         ux8g==
X-Forwarded-Encrypted: i=1; AL+hErEXNlQ2uWOu8hB9LuwSW0ATD98AOu/FFoZvfk+hHf0+p1mRee8Y/MDuId++UbgaaIP84Atmp00=@vger.kernel.org
X-Gm-Message-State: APuU4Z+yqS3+ZTFOjUu/Hy3dbKWiLfw06epPhOg/VekgdJ606ysmLHeA
	TYsURDOM433Md0aFZrZHP3PaW7SPWIrNtdr5/VscDNpw0c827/xogiZ+jiAqo1a0
X-Gm-Gg: AZFdTZcNybNjFUYViLOco1unCGtZAW4hIKC6jm0Oi4biGFLVnqJUBGcAdlTC+pmf9C1
	dw2SizRSNG0DDsF7d+uwojgC3I0ZlT2UWRLtQvyF3wG7BP+B/ct6z/0aWC3Nccz83nGg4SVm7Sd
	MKr5dV+Z1nkpToY8d3vbC0ow/FuwZn5vn7WegYcg1D/hx1Zs+ZXJtYMc3Cks/ciNAKilaiBzV5q
	lIgKPlcxWW2B4iRG7TP+TnuXn05sjJlCaF5zL1PK28hsWScGPtlEilqLOSqo7BvW6x1Ry+SLtJv
	SDG4n3jcrEg3a0r59hQA3PeO7SreDT0egr0B7/4Z08cn+90Ve9wJ7wl76oTvqWD4xfqSZBXISdy
	Nb3mBkhiHZXKski8W8MQglw2W/1PIjneNggonnVlWibDCJTI3pKS58Ccnp3UJLH0QHVYDGlf9bM
	QhhxrQZ/GXaVw/Q1MylWhCiSjxNdLEYNm5k5DXrxGrDnwk3a3jUhPt/LeSUJw82Z7w+qPtCr2n3
	IDBSGEIjuo7fhpzxo5Q/4pzUDCvTdiAJH9DJ4IlefF4k8QauOEx42v30rQtCv3cCW7FVFFFY9wP
	unaPG+bn0zGvq0VLsAVvEfybdIZrquJ3hIW3pOrKjPCJLlwkoUF0xayGkU4ilp/6VKkIn/oqNA/
	nkd2erxk5
X-Received: by 2002:a05:7300:8816:b0:381:5fe2:8008 with SMTP id 5a478bee46e88-38571b071d3mr821602eec.39.1795131007412;
        Thu, 19 Nov 2026 15:30:07 -0800 (PST)
Received: from lounas.tail428e48.ts.net ([157.131.129.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385c6830815sm176015eec.20.2026.11.19.15.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 15:30:06 -0800 (PST)
From: Louis Thiery <thiery.louis@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	Louis Thiery <thiery.louis@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] io_uring/net: don't charge the folio offset to truesize for managed frags
Date: Thu, 19 Nov 2026 23:29:35 +0000
Message-ID: <20261119232935.1708458-1-thiery.louis@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Registered buffers backed by huge pages are coalesced into one bvec per
folio, so bv_offset is relative to the folio, not to a 4K page.
io_sg_from_iter() adds PAGE_ALIGN(bv_len + bv_offset) to the skb
truesize, which charges the socket for the whole run-up inside the
folio. A 64K send from 1.5MB into a 2MB THP folio adds about 1.6MB of
truesize, and sk_wmem_queued fills long before any real memory is used.

The visible effect is a socket that looks full: with a 2MB send buffer
only 4 of 128 queued 64K sends complete before the sender blocks,
versus 30 of 128 with the same buffer registered as 4K pages, and most
pipelined send_zc requests come back short.

Only the in-page part of the offset matters for how much memory a
fragment ties up, so use offset_in_page(). This matches what
zerocopy_fill_skb_from_iter() charges for the same data.

Fixes: 57bebf807e2a ("io_uring/rsrc: optimise registered huge pages")
Cc: stable@vger.kernel.org
Signed-off-by: Louis Thiery <thiery.louis@gmail.com>
---
 io_uring/net.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index 533afd335..8afad1b2d 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1501,7 +1501,12 @@ static int io_sg_from_iter(struct sk_buff *skb,
 		struct bio_vec v = mp_bvec_iter_bvec(from->bvec, bi);
 
 		copied += v.bv_len;
-		truesize += PAGE_ALIGN(v.bv_len + v.bv_offset);
+		/*
+		 * bv_offset is relative to the folio for coalesced huge page
+		 * registrations, so only the in-page part of it matters for
+		 * how much memory this fragment ties up.
+		 */
+		truesize += PAGE_ALIGN(v.bv_len + offset_in_page(v.bv_offset));
 		__skb_fill_page_desc_noacc(shinfo, frag++, v.bv_page,
 					   v.bv_offset, v.bv_len);
 		bvec_iter_advance_single(from->bvec, &bi, v.bv_len);

base-commit: 0659e44ce739ecd856164c75a5325b7959a2921d
-- 
2.43.0

