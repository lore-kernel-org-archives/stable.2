Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793734693;
	b=borfqsK23OT02+TakKfnXv699J5Bt/FqG3cCLr/9alIHrY3fnoXEcWsHWXdCJbI8mnQ1
	 5dOHDGLnE5zTlG/IzeI07hh4K+mokl/PkJWkEgJzcjgTWhi8PIlGHOLlkIx/CVLAIrivy
	 9rLNIY32VvWYxmcwhHkSOzjxqIGC0c2WonZi+DO352mc/2DaUX4H3omcP9JVd+jLQOqDW
	 vYArqqL9BzBroU2KiVD1jBf4S5GYdgMoyDqhHyDG2ErBFz4FVu1RLE7/EtTGfiGeMe8X2
	 fFeKJd6ujxJgYG3JyzSUL2Kg9xHXgGUA8k9+ZW2TPSoLI1fmq5aDPmvzoQ/m6O9ehLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734693;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=tuTSxu3KTMYXj5m2sq/CjElD/51ek2rmveUedi9cdvQ=;
	b=uqKqlfpiylaRR12UEeECT4kItq1mV7MjL1L4jUneA/qGndk5ze/siWytsxKw21CXqf23
	 hYarpr9DzN00phJVeqeqmFIg/Nn8B9dbMby0LKuptMgpRNzLL3fDFglbadQyKo1MbtSMF
	 bCHW9Il1Ujg8A/8rPlUArGNQMUoiltuIMoMKY42AiBw2xw6rMEkRR9u4gJOVHabv9rL6I
	 HxFtsdpg0VLsImp/cJJicIdbbrLHclyvsDACgUCczjQ7UyZxFcZ1EdA5fYTioauO3c43G
	 fbrJYMFXiYs+oF45K2hzJHDqsiYjeGc2Npso9yLcj+Sv7wZFORN55ROQesyakqp5X8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="GKRtY/xR";
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76FC606D804
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 19:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C76FC606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=GKRtY/xR
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so37372555e9.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 11:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793734691; x=1794339491; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tuTSxu3KTMYXj5m2sq/CjElD/51ek2rmveUedi9cdvQ=;
        b=GKRtY/xRqxKE0icRGOY1BmyhxrRDxuz7CSnjvN1kQlWXikkvz0R3sFAz8EPh+B8BED
         VHYDvslWBn1s8MtghLOL4W6uzFOja+20OtOFQbOF7QwyCVzyykDJ5gnCXuYj60qiIWDO
         HU5FW5OdZXn1Y6X1hmQc4YAx+rjaMNbVGA+01AQ7JSakygrakPRCy6P7ezF7/f/7JidB
         P31QRfc4IITd5Dikbcf7f6t519fkGW02GVIJEDEJK8I/8i489SdL/z+fBSwSlo4aNUkB
         a9svGfTw4Gh55GeKCCczCqgKD4PVjZGCzK4jYgVuvw8Upd85z+B8RrWCVWBxkyEbXeEy
         185w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793734691; x=1794339491;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tuTSxu3KTMYXj5m2sq/CjElD/51ek2rmveUedi9cdvQ=;
        b=D19U+ez4D9DyOFsaakdolBweQ1XRUgaRnwvJZu7KMOf2lOrQKsAqMv+5TK+VFf4Pam
         AE1ENXgSMrNIka6QvzNC4eWICrn9PuwKddXOTTkljKg1rCk0yEgdecI9bjPxSQBhiBBZ
         BDF9lNfAoxDQPE3q0siRisX3rDJm//ne+quicV+6tYFOaumg7pAtyo/ljk3Uxo/rPhc2
         u8Ii9SYduvs2xz3QDUvo9czj5GlHqwWUJcsPE+vXUs9Yo66QLQKL6Bnw+dF1ALvdjYDo
         7SaN7CYaT7yFzvhf8dfPRunigkaV+8oG7TiXzAD37U+dP2CchFlSsIm6/FHokQjYbkfQ
         V7QQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/F3c80cUSKl5PHNJY3QRZtg4n5l0aycBolvPPNgmgj9UOaSmvXvpCaMKuzY/oQYbdEHSQBMU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TJHUsCuAd7Ftsw7iv9Jp9hLrkCq0pmIT9VGm/WYPFH8WSfDRs
	Zy6Y5n2pGX2Hl5ew/uOo1voZMUUeYfuZyv0kN74XsY9M8kz2J1OS09x8Ark9/tQIyrU=
X-Gm-Gg: AYBFou2QXjV1zTB9ySCBAbuzhShVxiRRDq1lE0ZBhDC1VODd5xaPgK+BjjNsrvGTvJs
	wqNkJPyC7r84lGVcCKAqZO+s147bzQOXU84Ku/297aYRP57H0szxxLHibYOuXnewMx56C8q4LHF
	gIB+sxMFCO9NyeL+CdS9Dd7UgzxnFxaJcznZuXv/aItRE68fJJ7YW3FlzW+1YbbD0pBjbkv7/xb
	b1nRNE1jOxhdzdsKNMccQowp9qTt82m0OMkHAkRaQsknqx0SQAQ7tTEiQgqazp6+GmBa2JUa80T
	5Jd7w5Mz7cNpyIowCib4ZksUnBwhJ9wVJm0hTxn7AxwlgMXVG05/d52wPiCa+Ubkg9OE6lb80eJ
	klXOUuD7RBa4Jicf75JqE2tsPeJhCnSw/AztzYLGl+0sgmgjcoz4RMtz0ZuALRjoks80PPpjkW2
	DGSWr6uKC4BbJBqxltUTb2lx5+4ZLQ9t3hwzzxDL2kKLco0wrdQCdVKBX4dBju9p0NNg+4IVrMJ
	AGTSAI4OiRLbonPNYA2cBVMCUzNvkJg9kFofi9dMpF3kCx1Zy+G0jkwEQLoBizYS/C3Y4ovCEZn
	OsR/xGi04jrKBbfvMUO/jZsMRA==
X-Received: by 2002:a05:600c:8b61:b0:4a2:1398:dd05 with SMTP id 5b1f17b1804b1-4ac17752ee4mr302304865e9.16.1793734691196;
        Tue, 03 Nov 2026 11:38:11 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b413312b94sm2165015e9.3.2026.11.03.11.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 11:38:10 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 20:37:30 +0100
Subject: [PATCH 3/4] dmaengine: ti: cppi41: Restore QMGR_MEMCTRL in resume
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-v7-3-topic-am335lpm-cppi41-v1-3-d7213446c5f5@baylibre.com>
References: <20261103-v7-3-topic-am335lpm-cppi41-v1-0-d7213446c5f5@baylibre.com>
In-Reply-To: <20261103-v7-3-topic-am335lpm-cppi41-v1-0-d7213446c5f5@baylibre.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Daniel Mack <zonque@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Julien Panis <jpanis@baylibre.com>, "Mendez, Judith" <jm@ti.com>, 
 "Francis, Sebin" <sebin.francis@ti.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2614; i=msp@baylibre.com;
 h=from:subject:message-id; bh=T6rTeOj2mOVu4qd7MFS1jh/VVnFzsdhhla/rk3UZJo8=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqxXFsKpjQ9+x5c/rYm9/bl9wn7BJ3u/L6rfcPTZ9I6rX
 878iV27uKOUhUGMi0FWTJGlMzE07b/8zmPJi5ZthpnDygQyhIGLUwAmcu0RI8OC25+Ur8mGMu6Z
 89M0nvPsjc+vhZttq3+zVO1bryq3ze86w//QY618XK2+0keu63f1Pvog/bkr/Idl7j/PyFLnIN4
 d6hwA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Currently only QMGR_MEMBASE is restored in resume, QMGR_MEMCTRL is left
at its default values.

Add a restore for QMGR_MEMCTRL. This introduces a helper function
cppi41_memctrl() to not duplicate this calcuation in init and resume.

Fixes: f97b98d6d02e ("dma: cppi41: add support for suspend and resume")
Cc: stable@vger.kernel.org
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/dma/ti/cppi41.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/ti/cppi41.c b/drivers/dma/ti/cppi41.c
index f5a824418fe7..e2a089066c6d 100644
--- a/drivers/dma/ti/cppi41.c
+++ b/drivers/dma/ti/cppi41.c
@@ -842,13 +842,22 @@ static void deinit_cppi41(struct device *dev, struct cppi41_dd *cdd)
 			cdd->scratch_phys);
 }
 
+static u32 cppi41_memctrl(int area)
+{
+	u32 reg;
+
+	reg = (area * ALLOC_DECS_NUM) << QMGR_MEMCTRL_IDX_SH;
+	reg |= (ilog2(sizeof(struct cppi41_desc)) - 5) << QMGR_MEMCTRL_DESC_SH;
+	reg |= ilog2(ALLOC_DECS_NUM) - 5;
+
+	return reg;
+}
+
 static int init_descs(struct device *dev, struct cppi41_dd *cdd)
 {
 	unsigned int desc_size;
 	unsigned int mem_decs;
 	int i;
-	u32 reg;
-	u32 idx;
 
 	BUILD_BUG_ON(sizeof(struct cppi41_desc) &
 			(sizeof(struct cppi41_desc) - 1));
@@ -858,13 +867,7 @@ static int init_descs(struct device *dev, struct cppi41_dd *cdd)
 	desc_size = sizeof(struct cppi41_desc);
 	mem_decs = ALLOC_DECS_NUM * desc_size;
 
-	idx = 0;
 	for (i = 0; i < DESCS_AREAS; i++) {
-
-		reg = idx << QMGR_MEMCTRL_IDX_SH;
-		reg |= (ilog2(desc_size) - 5) << QMGR_MEMCTRL_DESC_SH;
-		reg |= ilog2(ALLOC_DECS_NUM) - 5;
-
 		BUILD_BUG_ON(DESCS_AREAS != 1);
 		cdd->cd = dma_alloc_coherent(dev, mem_decs,
 				&cdd->descs_phys, GFP_KERNEL);
@@ -872,9 +875,7 @@ static int init_descs(struct device *dev, struct cppi41_dd *cdd)
 			return -ENOMEM;
 
 		cppi_writel(cdd->descs_phys, cdd->qmgr_mem + QMGR_MEMBASE(i));
-		cppi_writel(reg, cdd->qmgr_mem + QMGR_MEMCTRL(i));
-
-		idx += ALLOC_DECS_NUM;
+		cppi_writel(cppi41_memctrl(i), cdd->qmgr_mem + QMGR_MEMCTRL(i));
 	}
 	return 0;
 }
@@ -1191,8 +1192,10 @@ static int __maybe_unused cppi41_resume(struct device *dev)
 	if (pm_runtime_status_suspended(dev))
 		return 0;
 
-	for (i = 0; i < DESCS_AREAS; i++)
+	for (i = 0; i < DESCS_AREAS; i++) {
 		cppi_writel(cdd->descs_phys, cdd->qmgr_mem + QMGR_MEMBASE(i));
+		cppi_writel(cppi41_memctrl(i), cdd->qmgr_mem + QMGR_MEMCTRL(i));
+	}
 
 	list_for_each_entry(c, &cdd->ddev.channels, chan.device_node)
 		if (!c->is_tx)

-- 
2.55.0

