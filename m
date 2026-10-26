Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792984816;
	b=GBBydW/a37V9NFntOQ/Edd3Rt7CJzWVNljrpQPekAdhZTn9RskbmRgoo/ptzrOHyA510
	 kt3hBIfEyFPOlHA1YYhXw1nvqFokgVu0uOzUPyX9utKEbv/ivY4y8gNQbRzuief65WBJN
	 SZudrrLhCjMDJ5xTvJ49V0KyRpx/gRxw2CJfb4MdNR5oUp10LOY5uRsxqshs1lBdcsr7M
	 igpGoF6qzVEW7Gv7RWtfW8G/IhAwG345QReEUZKffSqBh4KJtRxvgjhLpWCnGkXhxIfgC
	 FG49Wu+LkHz/JJ1eAv8ha5h32QNiMqRLlV+xY020uM4cXV/yGXDMgJIxidzVIRlTlog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984816;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WTKZttgdr/SAexmQekzblCSc0QECF1tZsnrq/gh32Uw=;
	b=JJAmyoP8/O3bKECqNCunuE7gHxWl5K2fMnDMN4bV3g701Zy1FEXknjj6oX0vx2IP1+8S
	 4htfHkljEBV/kGXRlQh1PV5WU53nbrOhwjCn3xfvSPk+y6FR+RdxOZFqVJ0xdj3X7ylm0
	 7AtLqTI/KaWwFPTHDuIuniCVbahlSg+NTixiwnFV0Vz8fRBYfpNQBWmScBVslcLOPFblx
	 cgKSFoRzFBo+Qj7et08Wjygdz8Ry8v+NYbkvbubVIQ4ZLcTtmWk9ldQTHruuE5bDgzts3
	 wGSLXlC8D8JpGwq3ipacbyUNVj5Gna+d2f7EQVgfhVAz8mCzmA+RuCb/lsCe7c8vcdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=asu.edu;
	spf=pass smtp.mailfrom=asu.edu;
	dkim=pass header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=pRfCZdra;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4AD606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 03:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D4AD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=pRfCZdra
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-369f3e9e431so298973eec.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 20:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1792984814; x=1793589614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WTKZttgdr/SAexmQekzblCSc0QECF1tZsnrq/gh32Uw=;
        b=pRfCZdrauaWdHhmQ5/y43IX8CwxQleEIComGg3pM1J0MlvuUGTSfAR7Ye25+GfiwMU
         QyCliSoH2vcSwaNsxwqJH34fT/7EXfA0geb4KYwpVO0QpFvW4GcEXvE+al4FpMLWcDRf
         K98ZGWiG8Erw6GAk6qeIZZU6epmUrg7dP3s7GH9bUJQCbuBZGYtvFJDWDgm2LICUdHFf
         yDK7rTLR3VWDjCPEPy3JpMRM/nOjF0gyxo2uTqBGkQOTa1kkOzU/ftSoid7SIdB218QQ
         0WDU57+zYJK/NU4cbsK67lXplE/a15oBNFWOg2oqs13In8DwfxR3iBDMn/0swt5Igh3Q
         O8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792984814; x=1793589614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WTKZttgdr/SAexmQekzblCSc0QECF1tZsnrq/gh32Uw=;
        b=rIAr3VTIjGwOabnhKf+K8S3iSqyTetSGaIPYSohniyK0pTRFPBr3TbjoT0F6JAFBDr
         /NmX/gC1P6U5KqmTxIdzSzjAFkLgOwEX4oo8m8/kN7qFPX3UoRzqSUAAPEsJpOF352oy
         pPWCpALOuljqBrbFZ8yEesJ1akVfvHqXtNn2gWOnYwOUJHa656Pdz4VqVYCIIjErylms
         7xTdERGBXWt1Y2UpJmxHAqlb8lroEX7nZOEOTvyT5sLsfmB/8SGb/EDwxCpc2H42LEVj
         4OkCPG2wGcIf4k1gsOl1OwFpRsaqKgYwwuuXTMXsvWBOkduGb4t1oPGhH7DhGQemxuBq
         SJmw==
X-Forwarded-Encrypted: i=1; AKwUvByYwWjQQqZ1lX9SIEKfWW6mWKxUGCdqyOJNmLMrQlBd9JxS/nZo0+koHxgWVeDs4pDMK1k3cIA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjltHR0hq2XJ6b7CGxSUoFwm7/8QwXujRSRZrrwfapcZjmm7DE
	Nm6z0cPghbeqII47c9Llu/5jVITEbsM3otbYD30LCWcpVd8wu/RGC1DelaY6lOOKvQ==
X-Gm-Gg: AYBFou22/htJ6hhLgxB71HVq5fXIdgjiS8j3hoWTnfRGnFkY6dzyTV2A9f+RWKKSKB7
	z8hvBzcybhTll9rCNy8R2nqtUSf9/qPBYSBD0UDXJ5v/zDHQevM5x8EOYGZJch/IwnJqpITGKV2
	F4AU0iRvt7C9i7NUzw3HPVOylpfW5tst66RJa0ykLkCOS4Gzdho4UhZ8SWQ1LfdzXwd4gz8LR5p
	WYrjBjUc8N4p20/ANMTWuBckKv5KUqgIIfKAUVVlXeHDMjJcCB7ocYSQE0EjIM5ChCmVspi8DdN
	6Ehgm9/yKt+eDDP5LSrmDodAmu+ilaooCMANtU1DN01zzLQ01su6fVqJ2mqP2SJFn0EeRqIxP2o
	ASZFBJwkHWgLiMV5mhHeWHVmj+Sw2j0wOS5bhAm7bEioYLKKD+C8UUujeABjmIumm4tuq14yM4J
	TEjjaqRY7whFP3zTM6VO6g3yX7VwaRIBWaBTEkcydxQRBzCczs5iXD9x6Yc/Chgbmkh5tex/4Cj
	9hpECfPa10Dp+mUzb7k9/ckBrQJW8XNqf/pXsxks/HXpG7mm56wnsIc7ac7uYDbSeNFGAOBVodR
	oxO/ziqULzj0
X-Received: by 2002:a05:693c:6093:b0:369:fe82:8d3f with SMTP id 5a478bee46e88-369fe828ebamr3830262eec.14.1792984814156;
        Sun, 25 Oct 2026 20:20:14 -0700 (PDT)
Received: from gio.localdomain (ip68-109-140-205.ph.ph.cox.net. [68.109.140.205])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8db7e73sm21439295eec.20.2026.10.25.20.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:20:13 -0700 (PDT)
From: Giorgi Kobakhia <gkobakhi@asu.edu>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Giorgi Kobakhia <gkobakhi@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH] swiotlb: fix out-of-bounds read in swiotlb_release_slots()
Date: Sun, 25 Oct 2026 20:20:07 -0700
Message-ID: <20261026032007.1957949-1-gkobakhi@asu.edu>
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

When buffer is freed, swiotlb_release_slots() tries to merge it with the
following free space by reading the list value of the next slot.

    if (index + nslots < ALIGN(index + 1, IO_TLB_SEGSIZE))
        count = mem->slots[index + nslots].list;
    else
        count = 0;

If index is in the last segment of the pool and the pool size is not
multiple of IO_TLB_SEGSIZE, index + nslots becomes equal to mem->nslabs
leading to out of bound read.

 BUG: KASAN: slab-out-of-bounds in swiotlb_release_slots
 Read of size 2

 Call trace:
  swiotlb_release_slots (kernel/dma/swiotlb.c:1653)
  __swiotlb_tbl_unmap_single (kernel/dma/swiotlb.c:1734)
  dma_unmap_phys (./include/linux/swiotlb.h:262 kernel/dma/direct.h:102
                    kernel/dma/mapping.c:218)
  dma_unmap_page_attrs (kernel/dma/mapping.c:236)

The commit 0b84e4f8b793 ("swiotlb: Add restricted DMA pool
initialization") makes it possible to initialize a pool with an
arbitrary size. Before it nslabs was multiple of IO_TLB_SEGSIZE and no
OOB occurred.

Add overflow check.

Fixes: 0b84e4f8b793 ("swiotlb: Add restricted DMA pool initialization")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Tested-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Giorgi Kobakhia <gkobakhi@asu.edu>
---
 kernel/dma/swiotlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index ded7016a46a7..1f18003be343 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1649,7 +1649,8 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr,
 	BUG_ON(aindex >= mem->nareas);
 
 	spin_lock_irqsave(&area->lock, flags);
-	if (index + nslots < ALIGN(index + 1, IO_TLB_SEGSIZE))
+	if (index + nslots < ALIGN(index + 1, IO_TLB_SEGSIZE) &&
+	    index + nslots < mem->nslabs)
 		count = mem->slots[index + nslots].list;
 	else
 		count = 0;
-- 
2.43.0

