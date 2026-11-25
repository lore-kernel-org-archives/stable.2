Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609312;
	b=ZyeZvH/gbnATtLyrsdS/eBTgTyp7pNpmRJvtrpcBQg7qV4Er/NnbzSqAIts5CcQBhyi5
	 Rq/BzxLwHYLd0zHVD25enw9MdNPBCDvf+mJDnctlET/DdS8yhr5k9JQohzYTQY1fFPc5T
	 vR7CS7DYMFEREYSatiVRoP3wlazh8GwMVZHK8MOMjDyr9ijhQyaFbYjR7fO3j+BVM7HpR
	 gnEDlEe57Qu8yvXT7i3T4aZwGmgXjyvdhtv3CzeRgw4HWLYla0KQp73lK8D5ANFnvFrNb
	 WaxPNY+xBoQ3QHRCIt39cZlU0eQLzKbuOxeroRQgNKdY0R7YfHf0U7P//lhIDwdHc5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609312;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/QULW9udHfGSSQHhbWJ4MuomN45Oa80WoGrv85qAreQ=;
	b=OWY1lnwVvLvhLlxNe5sC0D2wWkAeKB/gbmhQ5FcowB2J+56VMb843a//99i4FXtsypnX
	 5meSH47NJwFNOjpmyuD9obOLKrMoFUSv0yqLP8B5MXjTUHMnavXDt64iK/30R/ITIEx1P
	 h14bm4lYq+u3Jf2+7iXQ1j4g9y55iQICj1zPe5ZKMwJF0O0JtjmEpjcWE/astS8J8VNfG
	 +FjZP/CXvHhtTY9rvNDWImZ0ir3KJPnsPhrP1cdUXEvwLuzhxkx2FG3wjkqNIWU/8o68V
	 rqQCkEEGzTpcxDt+uEvFFepc0APYQwcDd8ei8i6rBJOV6Po0a/g18UEeQxLPTzwDONw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0UMlnYhc;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD30606A683
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CD30606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0UMlnYhc
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8ca6a12efd9so1783357b3a.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 04:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795609312; x=1796214112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/QULW9udHfGSSQHhbWJ4MuomN45Oa80WoGrv85qAreQ=;
        b=0UMlnYhc6Jab6VMa6ttiQF8d1lJpBIB6uF3ONYklVOFBAMMaYceW7eneW9wUIq+95z
         pdgV6bHeTvavxSQlqGt2KaCvy4gWKsFzJBpBBi7NgvHFSYJiubeFCunkeRsPu+SLlBOF
         WrVWAfk8iiX55gpoJOE7c53RkG2Rku+Il7LCOgDCqVXxmr3IUEw0Xb/onbfD7JJ3KNH0
         725Z2qJvGe76W3I2j3QJ/CZHhxwAYrNJ7R5x+yT4PzG4xYwwwh/JrPeBeXLTBCt8D3ly
         PK0FeFpik5oq3Wrn5bVz7p0YCIOm9N1w8+Q20s/PIks6KFWZbX5wzMWjZ/zWIADA5azA
         rECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795609312; x=1796214112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/QULW9udHfGSSQHhbWJ4MuomN45Oa80WoGrv85qAreQ=;
        b=isvV6fQEzvNDzgl0RMbmvHriXHk8Ju+7sXeJh+plhj3vYQAEDxQIKqVvBULdBZPE6H
         IxgdZiYvu9ApIXF0MB9L4X3JqTFV9two0cVEiEyX7p0+kZ3JRpUpkY12eBj3IP6aBq/M
         diM2sgulNw1Odrrno0dpA4XmM30zM+G0uC6UQItJJhHDONRLmGladbZCglCO90Wn2q8d
         PFtervX6XxbnxqLw4NvX5puMiZiJT21z1QWWPiRAZe3iEpP74d9X37xQM7dZ3R9GanHa
         ixBGlYZ2vTMZ3NcKe/6HFeTEQQi/9465H6UhYl7ROUje97AF0elcp5aRF2N6H+3Oyu3s
         QY5g==
X-Forwarded-Encrypted: i=1; AL+hErGeGIKITZNBxXZjgwLtcTLOL2kWz2bmxE9IK10RMZd2/VbH0qbxStwfcYO+bu2PglwmMtQkACc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9PY/AbhTrZao74Frj/O6y/0sgbvX1nbIposnmTinedGzmqYlJF
	gW7iR8T/RiUnlfYjBrgETb4ZUJhfzzPTV0LBLBT+3IIv4QPl4FPAeNeM
X-Gm-Gg: AZFdTZdUC77ZZGgJnWUaA+dNCuQL2pGtMli6vNg0xmibPgX06T9DgMnyWDdKg5H/KvS
	98DKMq6eu8BXGRrRqCzFz9ZC6Qv5sxmV2VOXP5yqREQM116RhYEXEGI/RZneTLFevW1ugFYAim6
	8NvYPoxP25TnLpDJpS19gyCOQ28hBle8gg0sfc6DEOswjOh3F8zSr4RvXU1+mCxVDFjh8uRIsSN
	netYOtAWmvzt+NRYS7kxeju1QfulLqXfeUoXkwDPWlQ6dFx4ZDtfacPxdkrEiEYj5UPs6MkULLG
	CAQC3DBbKwskfvRIFibUaOBSG+KK6qEeWbPt24Oo3bukOHqZdC7Ec42RXPqPTZscg0eThd3cuSO
	4qYZWzdHbsJ41VvkX2NjZXDdlsCjJwB0cBGBUQLRaP104xDy/6NkRuLh3ykiWaQ36i2wFATrbou
	JrJVRDCZUuLEVCHQ44e1UHpY2sqf5E5fBFdSZdr528/QsCkIxiZItHKS76vSo2JwbdcGAbK4zpp
	A4F88gQbBJ9UluFhgEQ+hxW/7RyithX3XDJLECRSkHa29B9o2faOa8aqBc/2R/uf5s0VY8zndy4
	Ap1czvumhRxOuNdCsI3d4piOj38d+JTPYw==
X-Received: by 2002:a05:6a20:7489:b0:3f9:a6b6:e16b with SMTP id adf61e73a8af0-4014c94a618mr15927591637.21.1795609311859;
        Wed, 25 Nov 2026 04:21:51 -0800 (PST)
Received: from server225.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c89dsm8688656b3a.13.2026.11.25.04.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:21:51 -0800 (PST)
From: Ping Li <leeonion.muyu@gmail.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ping Li <leeonion.muyu@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 3/3] mtd: rawnand: r852: declare NAND_USES_DMA
Date: Wed, 25 Nov 2026 20:21:35 +0800
Message-Id: <20261125122135.44696-4-leeonion.muyu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125122135.44696-1-leeonion.muyu@gmail.com>
References: <20261125115108.4147741-1-leeonion.muyu@gmail.com>
 <20261125122135.44696-1-leeonion.muyu@gmail.com>
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

r852_do_dma() feeds the buffers provided by the NAND core straight
to dma_map_single(), which is only valid for linear-map addresses,
but the driver never declares NAND_USES_DMA.  Because of this,
nand_base cannot know the controller DMAs these buffers and never
bounces non-linear-map ones.  Such buffers are not hypothetical:
mtdblock's write cache is vmalloc'ed and UBIFS passes vmalloc'ed
LPT buffers.

Declare NAND_USES_DMA so that nand_base bounces non-linear-map
buffers through chip->data_buf, and advertise the hardware's
512-byte alignment requirement through chip->buf_align so that
misaligned linear buffers are bounced as well, like the other
DMA-capable controllers do.  Both only apply when the controller
actually uses DMA: the PIO fallback path does not care about
buffer addresses being linear-map or 512-byte aligned.

Fixes: 67e054e919248 ("mtd: nand: Add driver for Ricoh xD/SmartMedia reader")
Cc: stable@vger.kernel.org
Signed-off-by: Ping Li <leeonion.muyu@gmail.com>
---
 drivers/mtd/nand/raw/r852.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index 92c47d351c27..c5a3622cddf6 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -640,6 +640,11 @@ static int r852_register_nand_device(struct r852_device *dev)
 	if (dev->readonly)
 		dev->chip->options |= NAND_ROM;
 
+	if (dev->dma_usable) {
+		dev->chip->options |= NAND_USES_DMA;
+		dev->chip->buf_align = R852_DMA_LEN;
+	}
+
 	r852_engine_enable(dev);
 
 	if (sm_register_device(mtd, dev->sm))
-- 
2.34.1

