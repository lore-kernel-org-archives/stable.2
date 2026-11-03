Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793734691;
	b=UmdNYVwZSOVTQffvW1NZ4cW6vYJ5JRIRJ7bOIpJlunpz+xen3ssuAyFQSLVfCPwnC08Y
	 J0w99YoAKHVVetvqTVp9XXZ4BBdJYasVlao5XS/ywAyc3Qd/EFDoi59HJGuTeI3Nfnx7p
	 NWiiFOat/uvYxAHP/Wimw5mi9W7TV8sTtzoX4Ov+zVNjFyADNpfK9kHsbPUkb1IL0gN9q
	 +o73YpIbgWlLE8MfoSS3Eebu3m+jK5KeGIKSGoCR8ZovlCVIaQNyvsR4XuYdn0Tm/1fu6
	 +Iu7fwZoADLJ4tSGI3fBnJCWSt9VMljN2sAMfOjKln39mAWO4sCIsyPC4HZ9HkbBcqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734691;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=8PPx/HR4xDG+iQY+cv1KoaG7KZBkWYuC6hmVzUweW8E=;
	b=IIbqzJB5fCWXTGeEhCXMi/uKAAx/6F7308EZLiJdwgsLfcazYB7sJXqyVezU2k4iGXrA
	 CyqR16Gnki5cdv7DpgrJ4aaTWTQN8Dcx6gL5nhHiaGGHqx1qi/vk6OpGqQc4J734vV1B4
	 v5uYiETqNTetrJJC8LUWCvILccOwsdbdWp54uhL+JiCAGqMMxc6rRBQ9dUOk4QmmSe3J+
	 4/Q+o8auW9gDXbUtSYnvSZI5libAW3Lp3zF7m6EqvIzoU+QWZQ+URhQ294nKIa9RL6zgb
	 SDUhPhrSRZXdpFrodwubYfDa6COuUgf6kffqODsTu8BAy1caJUYxt40jf73E45WZrrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Fpvs0M3M;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438AE606A328
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 19:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 438AE606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Fpvs0M3M
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so41520605e9.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 11:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793734689; x=1794339489; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8PPx/HR4xDG+iQY+cv1KoaG7KZBkWYuC6hmVzUweW8E=;
        b=Fpvs0M3MJhfioY9sbGDh6sQpSD9Paq/GLsra9eG2IsBCECMHqW/VdV9qY4TiuxhRrr
         cTyFX27EkNM+Kzl1cJR6W+R5Cg/eP7GdbSQPB2wa4aI5XQr4JWBXaYh7RtYF5UJjx4NY
         3VkuqRbCTUOJ7l6YaSZVQOiiAnB9YSyjVYUczbVorXCkvTMEDGUiSZXj70NDg3xhDHvn
         c+lBuNeaJ05Um34iCSb8ldNZU5474mF4yP+njoF3/NcIx/WC2oKmpdbEO9Pg4BlxSrIK
         d56ApTQNhRN6nt5+gLZz5T8FNuHz25vvI2rTl9zzKLpwN7MUJShsl+VbpL/3K67EoxKa
         C3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793734689; x=1794339489;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8PPx/HR4xDG+iQY+cv1KoaG7KZBkWYuC6hmVzUweW8E=;
        b=kZZ3YdgdXzzQu40oSlu2gNChQHKUMWBwylQ/gxQOelsCPUIk87EQWimZ6IFdTZQbDT
         9IDcnmJTfQu0KoIMRF/KjDpPBgJ2ybQpYy+EE12jBgdKoQyIOEIB9SzX2EBHmKo9nIVU
         dLwkoGvTmvhlUTqSpe7CNKf+MUd7qG8iGBNiJJsw6gMe++NTZXXiGhj3PDEGFdqnPto0
         2XjSRxBbcnkt71QkoX1uJP3cZxV3mokJcw47LFc+53AV2lNspLRiq2R9906bMfSPr1MD
         5EKKQE9V69GwhMFLczWdc57tnsOMnRrsPujUJFy6SAGhoW+KgSXpfTdfjCNoCwL8RWc7
         /eUA==
X-Forwarded-Encrypted: i=1; AKwUvBzY2orTJul657sh0Abeh7CVjnZwjkuKJKBa+NXJrceS9oJ77ssW1dRTF5LkGjnnQUb1+7B9Au0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Kbxt09Lu1eRA/rR+R/fcA2DOcLG4tGLPVTqky6sHsr5aE2lC6
	hp07vR1N6pjLHNH7Zg4AvshXo0CSGRXODtaxb8pOFaq7T/B1Cdo/FBDKv1PascROjZw=
X-Gm-Gg: AYBFou2YfFy8erKWEeS/isMhFrFJh/0p1uqmAnuqId9KfX66bTJ2CTv9jysFK5tUcKn
	XcjTEZn1vl68dykLl4YGF8Ii1m96LxjiSG7oWmhvXonGk3kG8In8YApv+az7S8MJ7XaipI5gy7P
	7K65TFLvXM4rKbIFgOWv0GLzk0LI1rs8YCQbC5O4T//WBBj7WmZN1F1u7M9bM8NywcQRmA5Uk9e
	5y24xqx1K+kyO38GTRYt0OHqlEpEkBzgwE/RcCcRjayyTrTmM+22QXe8QyGs6CKcTIyOnbJYBsH
	zGbEA7fG4HVylJJ0Ur8ZrVPRBXLmV62HqkTgpKiegXFqHxhHXhb9SvL6CCBRvYhVDWybXboI97y
	+7QATejDX8tDJgKCaNiLK2vhjUbvWkp6Dg/fNhc5rSFjkr97HIROSd3ZjUitgsP/7zln4VsI51Z
	LADWF5FG0SQ4Hs1JymLzsX7rgoPeWlQh3Ds+nvSOlQf3EEMZ7/aVPiU7f3WvFG5w6ZjxCsTBlUE
	Y1Lx9bUu9ucz3HIMWqVnCpgCyn9sW+rI2O5OtXJeSDKLimuCEGglJuD86xuYhcgIqTh6/wxK8JE
	cmb5N9zHpFMflUBPUX1xQOSfbA==
X-Received: by 2002:a05:600c:1387:b0:4a2:729:f7ce with SMTP id 5b1f17b1804b1-4ac17d16afbmr327136595e9.8.1793734688513;
        Tue, 03 Nov 2026 11:38:08 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b41297c16asm5880115e9.3.2026.11.03.11.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 11:38:07 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 20:37:28 +0100
Subject: [PATCH 1/4] dmaengine: ti: cppi41: Use td_queue to restore
 DMA_TDFDQ
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
Message-Id: <20261103-v7-3-topic-am335lpm-cppi41-v1-1-d7213446c5f5@baylibre.com>
References: <20261103-v7-3-topic-am335lpm-cppi41-v1-0-d7213446c5f5@baylibre.com>
In-Reply-To: <20261103-v7-3-topic-am335lpm-cppi41-v1-0-d7213446c5f5@baylibre.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Daniel Mack <zonque@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Julien Panis <jpanis@baylibre.com>, "Mendez, Judith" <jm@ti.com>, 
 "Francis, Sebin" <sebin.francis@ti.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1510; i=msp@baylibre.com;
 h=from:subject:message-id; bh=B/woc6BJx2wq+Pk4aPkNjANUiNT1MPY10g3hs4IO0Lw=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqxXFlyRG8zuTBTpWpAlxTx3WtnpBxcO69g8tjr4bdF+e
 4NuL4FVHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjCR+kuMDN++hwdM3JT0Tyz0
 942/oX37VxlO3nTyqs631XPZrW4d3sjA8IeLazrbguufuTwsdxSqh5uFz7nr4+m+Unp74tcVSVn
 tS7kB
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

In init_cppi41() td_queue.submit is used to setup DMA_TDFDQ. In
suspend/resume the same value is read, stored and restored.

To get rid of the suspend register access, use td_queue.submit in resume
as well to restore the value.

Cc: stable@vger.kernel.org
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/dma/ti/cppi41.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/dma/ti/cppi41.c b/drivers/dma/ti/cppi41.c
index 88756dccd62c..458d20b12462 100644
--- a/drivers/dma/ti/cppi41.c
+++ b/drivers/dma/ti/cppi41.c
@@ -146,9 +146,6 @@ struct cppi41_dd {
 	struct list_head pending;	/* Pending queued transfers */
 	spinlock_t lock;		/* Lock for pending list */
 
-	/* context for suspend/resume */
-	unsigned int dma_tdfdq;
-
 	bool is_suspended;
 };
 
@@ -1174,7 +1171,6 @@ static int __maybe_unused cppi41_suspend(struct device *dev)
 {
 	struct cppi41_dd *cdd = dev_get_drvdata(dev);
 
-	cdd->dma_tdfdq = cppi_readl(cdd->ctrl_mem + DMA_TDFDQ);
 	disable_sched(cdd);
 
 	return 0;
@@ -1195,7 +1191,7 @@ static int __maybe_unused cppi41_resume(struct device *dev)
 
 	init_sched(cdd);
 
-	cppi_writel(cdd->dma_tdfdq, cdd->ctrl_mem + DMA_TDFDQ);
+	cppi_writel(cdd->td_queue.submit, cdd->ctrl_mem + DMA_TDFDQ);
 	cppi_writel(cdd->scratch_phys, cdd->qmgr_mem + QMGR_LRAM0_BASE);
 	cppi_writel(QMGR_SCRATCH_SIZE, cdd->qmgr_mem + QMGR_LRAM_SIZE);
 	cppi_writel(0, cdd->qmgr_mem + QMGR_LRAM1_BASE);

-- 
2.55.0

