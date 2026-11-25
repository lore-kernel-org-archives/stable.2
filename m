Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598751;
	b=VBxkON4VsA+brFThFazy6dPMUZaCvvX1wgSxid4+6FBgFPR5X4gUvBn9VXKn1utJSi5g
	 WUKyDHTMyalg1PPTh7cZR5aVM4mwVe/b+TYZg3XYgf2P4ke0dLwBqgV937XMcz0rqRaq6
	 /7/B9AI29zYxqI3OdaavloA2NL69qUGeSpQutvbtPSXA6bZ4Pk3aKQzzPr8UOiHK8fam+
	 MfSG/ExoDif8nIBGLEz0QwnbywUzKEGYdsadip8fqZgW/IonF3BqUF2VNVQgOfy8ErVHV
	 V/AMF4pPK5zPE/8t6E9A1XU8oaAZyzN5GALdFpN5yNHWnqSM/FmTQaGpyJa+jqDYy5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=X58yRtM32801RbbTP1Ym4v2U/VBocOatJPea1zyP738=;
	b=rppULIN+UiET87P57QmRbCwdwzNe7wVDe25vG0cOIejFuHJBVVHDzH83U0YTH89Hc8Z4
	 DZKqOopTgMBSRFI+45cXdv+IgzakTUEO3Ujfj6jOhFjWC0irqjybVed8/GADg8VatLyY7
	 JZlIzcQZWUjODHWjkKW8kihupSSl+iu/Fj1jjqwNRXPcU/GIo/fPHRWQCZbtw13Yj74Q0
	 8nJ2MyGq8GajicznUaQa6p+UkcvvToGj6FydCTU40yJSWPd2zoGFcyJ0q0NZj2zc/j6l7
	 761PgxoIlTj4JrYVUz+uHkbTcoBjrtrCrhz9qw1g9QKsqqOtDcCWqByVcS24F5/F2sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hsZvZPJb;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CA7606A332
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84CA7606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hsZvZPJb
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2f02f04a426so44696695ad.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 01:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795598751; x=1796203551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X58yRtM32801RbbTP1Ym4v2U/VBocOatJPea1zyP738=;
        b=hsZvZPJb3NT4UDJ0b4V8Kr/96kKPVBcBqTFr27/wnRwqcHCMOHxQDXlvpc25xjNMLC
         egvTft9ijtp3Ya9chXTMNBstVwIjcYAaGI6IAFOOBW9QwHZ9U41zX94t0jqLvUcDbqFS
         2EwZE4KmYTVyD5CSsNeO+MeAL8lpSebZJahoNvWVfvmOMrz7Kmkv3bdLQ8gBPq3OFFg1
         Oc7J5Ts8p7MCaSnRWkWBXZnkBwvqI/Qv62z3ibl6qPBqKYwso+FsSuJRefrcHSIenEwp
         A/3lo130dlAT24vgP6hyJyVeyjChqDMY6x89It2W+gU5pkU7dqBOlVCVmWOrpirr7tft
         3ZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795598751; x=1796203551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X58yRtM32801RbbTP1Ym4v2U/VBocOatJPea1zyP738=;
        b=YS6owtRD5gRCL/mHr+uEL7ogGQjIpWhZ/osYtbFPLBQzsO4BSnxxM6w2W5DBodRPn7
         oE/6VY3jcITwoXtAAcsrx0coXMayYO4tqmK5BXYZX7HiG2TY0nBxp8NML3nSLj6Cy469
         VoyHSUZwsu6dWc+AvV/2gLbNfLIfgO/ORMUOhQgglPFKp4b8NYkFQVLB0L/3JzLEOcir
         ut5LdqW0eakwPSMXOMunE1ZkY39J3vWUGgNV4IJaM9BdGCE7XtDnVcAvlBMMXLZM6b6Z
         oo+2uCZeX0qMwypsse0u7yMFdaBEDlPR26Wsj4YiAqO64Rg1zNEE5qJqgT8qHUVyBY7p
         vj5g==
X-Forwarded-Encrypted: i=1; AL+hErF5s4cQNBSI0jaBV3kmwDz+G3v9KxCgfVcvckac0HH5zIAAwiOOg3Yr8l5cfi49nK/145L2L2k=@vger.kernel.org
X-Gm-Message-State: APuU4Z8PbtydjOXvwjgdP8/tHMQTEzIaFzWjFliXe6JdJJ1y8Dalk+7v
	40m/85L+3dc9Bm1anvE3xqjhNEPfN82819dAbf11qf2qtKedDVKzdIYI
X-Gm-Gg: AZFdTZcod4LOXXpnIKTLUHp7u6+OuwYvz4X5bD2H2Q+aYd8xqADr0bNTgEhD2oePd2q
	YfG/hou69qn64bKxcGlAI+hR+7JKKJ55rVTUQF9tS5H1KdXiX8ffe3WdWyUY0xzjP4zi7aKAGRy
	AX0R577fhgBICmLBic+4zsCy79JI4Yt2oQ+UOUxMJLKdUbIpu0Wt9VRWWQ4Jt/AvMIlHH22vZoR
	FhUEghMFN2FU/b5OmdNcfA5l62fnwz2chMoqCccWmBFASaITN7EJoS5vCJAlQ5ZQeETEMrpWdet
	8dAUY7CNlSYa8wfEvx5rcMcgnEaOeeiHurC+Ea+3j9L54CAPSZO76wDX1MyFnxkoawjhpvFPOZT
	VrVRMJcQJFWMF/34kZmER//1n+izScLu7kL5kSZC5e3Cnyet1d/qBB2hsK3OEa/aemR73VoTx3e
	3rf86BB4yuW4oPfxtBIAT+FId7dtaDSz8aTG9ZUTiDuNItwpOsz/Pk206EcF8gMzG3SjLdHBLQh
	d4PI63N53mKTsNxL7X4lIwOA/wAkEMpBpwTA+a72nfsSllzstIIZ7S3CfXb5uO/LQhq7T77fQ6p
	WwTzZULSdVua0/A50e54KVsyVzFvJTzq5w==
X-Received: by 2002:a17:902:ce82:b0:2ef:e9df:2422 with SMTP id d9443c01a7336-2f03f1cf4e6mr174997205ad.16.1795598750820;
        Wed, 25 Nov 2026 01:25:50 -0800 (PST)
Received: from server225.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f142b8bsm80883155ad.70.2026.11.25.01.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:25:50 -0800 (PST)
From: Ping Li <leeonion.muyu@gmail.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ping Li <leeonion.muyu@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 3/3] mtd: rawnand: r852: declare NAND_USES_DMA
Date: Wed, 25 Nov 2026 17:25:38 +0800
Message-Id: <20261125092538.1938516-4-leeonion.muyu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125092538.1938516-1-leeonion.muyu@gmail.com>
References: <20261123070440.3060882-1-leeonion.muyu@gmail.com>
 <20261125092538.1938516-1-leeonion.muyu@gmail.com>
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
buffers through chip->data_buf, as the other DMA-capable
controllers do.  The existing local bounce in r852_do_dma() is
still needed for the hardware's 512-byte alignment requirement,
which the core condition (chip->buf_align, default 1) does not
cover.

Fixes: 67e054e919248 ("mtd: nand: Add driver for Ricoh xD/SmartMedia reader")
Cc: stable@vger.kernel.org
Signed-off-by: Ping Li <leeonion.muyu@gmail.com>
---
 drivers/mtd/nand/raw/r852.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index 92c47d351c27..f930e8cc80e6 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -640,6 +640,16 @@ static int r852_register_nand_device(struct r852_device *dev)
 	if (dev->readonly)
 		dev->chip->options |= NAND_ROM;
 
+	/*
+	 * r852_do_dma() feeds the buffers provided by the NAND core
+	 * straight to dma_map_single(), so ask nand_base to bounce
+	 * non-linear-map buffers.  The local bounce in r852_do_dma()
+	 * is still needed for the hardware's 512-byte alignment
+	 * requirement, which the core condition (chip->buf_align,
+	 * default 1) does not cover.
+	 */
+	dev->chip->options |= NAND_USES_DMA;
+
 	r852_engine_enable(dev);
 
 	if (sm_register_device(mtd, dev->sm))
-- 
2.34.1

