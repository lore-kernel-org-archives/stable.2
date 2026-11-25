Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607476;
	b=KOif7dBAAJMpExBdGoWjA3ShK1CeHWOkny28LolWEpB3zCIU/QnaQ/5akJjt65+IdK3i
	 5Q4fPzMLygDcfYdvDoK7b5gZDhxRVvFdhRZ7la+3HSLvm0cyF9hF9043h+hIpWOV3xTnF
	 Ls47xkAGs++tsw0euO6RAp1vssN1BG7VEZketGWu9C02t87PTVpjtjdLFnRZWwMk19lbu
	 fJDT+LNZz4brCSxwzkl0Jjl1BL5g2RhrMjrRBmLDk92rFX/vsGDjbn402a82HCam/VvUH
	 h0q10RnWfSJnM7IXPtPKSIoda/2xfDDLolaVZN5EuOF4rA7Puouu8QmH+OTegx5WtBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607476;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MA+Kx+uKQP6OM3muhrQQ7gMLzt5UOS5UjDB/PUfvv7E=;
	b=h265PcYznFC+bPKU8ul4iDv2l/7YUb298kM4o9DgrQWqdqi0DDUTsjjYCq3MmmWoZZAT
	 ubl1m4KVsOtmkl/ir/X5ccl2PChDoK/TrKjc+yYW77LzLanpFx3CCBNVwsvZNWUDbB4bx
	 aeqWhmc1HiZqKHi/K3hUo+gLqGcz282nR0md/SEWNUFn0hdQATfF0fVzAYJIql38z6Gg5
	 s5zCcEM2BgkwF5LIPW+KXaburVfGUs2naIvJocZ/aHLgvyjPEJXO2n6dS38skayzwBqhE
	 ecpss1piIXgPybscqwzGq6FOf8Ges4PL1MSfQpg3JGkc1upzkAxZS3E0jJ21rrh09gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RwmBSJ8G;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F54606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41F54606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RwmBSJ8G
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b413997581so4447616a91.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 03:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795607475; x=1796212275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MA+Kx+uKQP6OM3muhrQQ7gMLzt5UOS5UjDB/PUfvv7E=;
        b=RwmBSJ8GqgITrxaU4LDYQ3Z0v0Jlt2WeqeydwXMxNzV3UfJTK31DXYyE7fBrWHh/Y5
         6ZBWKJQdYXQjR/FijFHbAF3rT2bhD1ded5jk/VuZVdhrcMs4BysPB3fwYssfOt9WjELP
         Hr8NdGvlsLpCJb2xSNQ6EQ53nb+uF8b159C2gZaN+7eAQMbJj7PilBpy/HiGRBCEipe/
         91HJL1f19Z/+gTgg1Ai684Y/hCXJSgCx39RknWyE+7GqtOdAOw41FTaVfpZl0mY6lsPF
         RtQ3pyh8LY0tL+th5lF3j86vfnwRR4DovA6BJHrq4uo3YSY8dUTU0iBfZRslBXZvOSdu
         LMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795607475; x=1796212275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MA+Kx+uKQP6OM3muhrQQ7gMLzt5UOS5UjDB/PUfvv7E=;
        b=zHaXFGrv/F/zBfM12OvI/wVjZNWbUid12FtNZtRaTwmWZdBV9ecJhzu2NwFdYpIxiu
         ekdap2XOoLw8y+mG9yS0lJkFHsgT+XM9We2kYDPqryJHWtz3JNTHV9LGX8wMJw1kb0bg
         uX/6EPzMDEv3Xcxa2Ch/bd+o8N4PD0lQOgteChaAX6qdDgDkPsRWx8I50r7cqzxiBXDu
         X9UXXge0rPwc29Wh/pwF5no0IQ07AfM4X1S5zqK2Xh3mVa5/0kqcYrIKjhcMX6NBOQRr
         5tIU/WCJFHz190nvqVnhpKrlqyr2Zk7kPhGCsGhoTr75ZnHzKvEp9t73/Ej06JaISFLt
         IH5g==
X-Forwarded-Encrypted: i=1; AL+hErHwevhqLZVmwzgflXMjc0GWskxGIwheDqLE352rLr3ShZwvtOksXPKqUpHHnMwIuX6RD1mmh8Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2Xm2JzmSrdCOdqAkIUe0IEqLfAB2elVPCXvwoNRn8SQsTss++
	HwEtQOJg1xE7vz77/SFtOuUtxdRrsYbVfZfH2d3x8sapGrMxZQD/0cvk
X-Gm-Gg: AZFdTZdmUwAqiotaMvHMaje2+vhJWdXrXCGhFZoYcDDNSnpZYe0IaxzditAj4Myj/LD
	EJMt8ooaZ7yi2h824VltdLdTigPRP5uJuEhj1cslgG4rjr5dukY6q2Dpk2O4xK/pGYLQAK4gD7j
	n3J/GmsKOgpMThaP2y8O8r/41Xw5eBr5203+IWf1qZ66NKGHdxSN5E6hU7W5fcUB5HZ+XSi4/ab
	4cp5yP3xMULeGqBzIn8FcL6PsSfEvFAI0dmPdF35/OGVlNZXM9OwrxrHaNRkbp0rf/JcwQ792wz
	n/nk5jnQS42DMuXNBEIlfpkFW9hcBdpGTyYZ34ItYfp5dNdvi560Llze37F34Nb0bWEE3L/s+0M
	Df+Vf2/2KDjk7pLOLX4NblYjqDBpkttvclxg0Yj7LR8e/P0KANbloQKygNDcnkv7QAfWb/jXgyE
	XFJCPs3/iUCBMVdzQffh/q65BNn8J9JvuMggRb0KUcAt8Pq6eJdPGo9Oqo8NQ84EQUrRmG21Pxj
	JiIm+liueSo005A85FxkWmhxKx2I0NVpGGuICglFutOgMmcTB/9xfOhZ4oCEMjI8VnVDC52Z1Bz
	qLWTPi4gH582kHtKooOOGGrj9BfjruCHcQ==
X-Received: by 2002:a17:90a:ec88:b0:3b1:3e7a:6d8e with SMTP id 98e67ed59e1d1-3b41c8e0c73mr14680529a91.10.1795607475481;
        Wed, 25 Nov 2026 03:51:15 -0800 (PST)
Received: from server225.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecbd0bsm30569662a91.15.2026.11.25.03.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:51:15 -0800 (PST)
From: Ping Li <leeonion.muyu@gmail.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ping Li <leeonion.muyu@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 1/3] mtd: rawnand: intel: declare NAND_USES_DMA
Date: Wed, 25 Nov 2026 19:51:06 +0800
Message-Id: <20261125115108.4147741-2-leeonion.muyu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125115108.4147741-1-leeonion.muyu@gmail.com>
References: <20261125092538.1938516-1-leeonion.muyu@gmail.com>
 <20261125115108.4147741-1-leeonion.muyu@gmail.com>
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

ebu_nand_read_page_hwecc()/ebu_nand_write_page_hwecc() feed the
page buffers provided by the NAND core straight to the DMA
engine, but the driver never declares NAND_USES_DMA.  Because of
this, nand_base cannot know the controller DMAs these buffers and
never bounces non-linear-map ones (see the use_bounce_buf logic
in nand_do_read_ops()/nand_do_write_ops()).

Non-linear-map buffers are not hypothetical here: mtdblock's
write cache is vmalloc'ed and UBIFS passes vmalloc'ed LPT buffers,
so such buffers can reach the controller's DMA engine, for which
they are not a valid dma_map_single() input.

Declare NAND_USES_DMA so that nand_base bounces non-linear-map
buffers through chip->data_buf, as the other DMA-capable
controllers (arasan, denali, meson, mtk, nuvoton...) already do.

Fixes: 0b1039f016e8a ("mtd: rawnand: Add NAND controller support on Intel LGM SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Ping Li <leeonion.muyu@gmail.com>
---
 drivers/mtd/nand/raw/intel-nand-controller.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/intel-nand-controller.c b/drivers/mtd/nand/raw/intel-nand-controller.c
index cfb4b231e067..1f493fb426d6 100644
--- a/drivers/mtd/nand/raw/intel-nand-controller.c
+++ b/drivers/mtd/nand/raw/intel-nand-controller.c
@@ -688,6 +688,7 @@ static int ebu_nand_probe(struct platform_device *pdev)
 	nand = &ebu_host->chip;
 	nand->controller = &ebu_host->controller;
 	nand->controller->ops = &ebu_nand_controller_ops;
+	nand->options |= NAND_USES_DMA;
 
 	/* Scan to find existence of the device */
 	ret = nand_scan(&ebu_host->chip, 1);
-- 
2.34.1

