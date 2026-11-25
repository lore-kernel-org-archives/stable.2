Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598749;
	b=g0SSkEo/arS1Ghsd8oEtJcWXzkcplj9AXz6+rRibNEM1/N5KPp+egs2JYv+J9kJtp0Sg
	 G8EorzQmB7Spmcn5fWQSsoyeZkeSuNoaW+DzNaDXbCkcQscT/n/Ml4rwMUggICj7o1elY
	 67nBoGt95q19P/iZNjawwVftOZAR4KEx7Kbb8n9OFmOgoXks/Hn2kS+u0BZey2HqB7Jfx
	 E0H41O3+ZIo47ohlH/vTDTXykiWaWq6Rw4+UkN567JQogZHx7uYQoT0i5kjJ+GZbpIcMN
	 erqRRhoXtfSl8oZRWEO+FOWWakYoV0d/xzWLhk0fN/6RVYzk9akZzYTNdrWdMHgUnXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FeByhJ3BHvo/2jRdQJQGFglqWfC3P53F7bznOhuKwO4=;
	b=Xcb038wyM6VZyVjjgMpM43UxsxMzlUsBjK9CISCDMr71oNNGtk7vWQBmCQWN8Cd0BYTt
	 Gvi4NC4lmNBhgI4sIUh9i4zbM4HB3qUpnHPmF78sLMiJEObUpJfngW4Q2s0Z1s4n/1A0L
	 87pvmbiHD3EKSJ2tY1jAANN+qVvmL8+gzV1Z9Y1c6HwCI225OK0i3/gHF/qp0rEf7TkUA
	 bunak3dcKtPIb7lKTWXLmdSNFFKNzCvR3iix3+x/Frj4SA4q8MLp+GEgHbWliYmLoH7Y5
	 IJM4Yz2ZTtYPPjL1L8oa6aaMKKNuTzLChbVodU3pwRI61QW5+FeS4+jEt1ShhoWbzJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K8BaRQHa;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EF7606A698
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4EF7606A698
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K8BaRQHa
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2f04fab527eso42045125ad.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 01:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795598748; x=1796203548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FeByhJ3BHvo/2jRdQJQGFglqWfC3P53F7bznOhuKwO4=;
        b=K8BaRQHaP+mwBjhBJwv8/7xEMnuYfDjMVxNnD7RSO+2NbJDxJY44NCK23E4cm1kzH5
         65NUrVkWBiyiib6ecfUEyhHGjwqfrbP5iLrzaAOEHKWhWWbgizA//XB0HT5BoBwE0m8O
         BZuLOGGzwoUr76Hq0G/CcUwVFPVlkDJeExjxuFHUckm1TVPaVyqMedP5JZi4dEPacBV3
         THMKAh0K9dVFuLdhfuIgmVvwye+1iyt2HvHr4cgV5OpDazlPvS6NSHC8wR0at2SuMIYA
         BofzKPfNX7Qs6LVDn46gQcO2Q8YajnUxI9jfnqg0us/JWzBNhLVCAjGwIbz6GDfnpiHR
         NAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795598748; x=1796203548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FeByhJ3BHvo/2jRdQJQGFglqWfC3P53F7bznOhuKwO4=;
        b=oxHr/SDXWQA/bfJHA69V3jZj9QDpHiQmasZeP+m4jPVIgu2UDVPEgGqZvS+FW2RNrL
         kA7LDd8zT2WSof+F4eXE9pTt5DHa7teGTiQy3pI9NPpNie/kt+OwKmAt/HxmFadF6P3V
         hYklXYPBqBHE1Vhs7lajurMy2MctPXZdiAEq6guGBuYzE31eMSvAxzBUd0hRVHH97sI5
         0zQzW6A4Zo9BGrpnKlBJDnQX0nhzevvHSl1BkUUh1ltrWbWbDWTd3h2XFwT+BpHnnrmH
         u2pPb2h+Ifi7Unei4mzOO4ObMapDLwG5rFhvBodX59c0PoPgfdMuLt3uYhLz/r5Epjra
         H90Q==
X-Forwarded-Encrypted: i=1; AL+hErHb4Y4PRAI6RhW1r0J2MOON5i29/IHf5NGH8dX/XSgsL6Rx5rkXzVfwZd10pxXR0mgYc+ecGCA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DvLdQBFEwZk3WF3Eq4eRG53gqmAdIimzfrQ55zF2hsoyQMcIs
	oSMJdPlL+MJu/9d1gLb22elIMTfq9v5glH/zNdTxoTv4uh49HxqmESDn
X-Gm-Gg: AZFdTZdc+Q5E8EE9AUjnrXKeCal0uYq9wr6bivEYsLFa6ehYTzoWoSt60ZeRo0VX+Jm
	7GQa0D+XWAkqgshtWmB6QdqHtZlyNTAwhCvjFM40gwPXvIy3ddWPAHKZ6RMiNAAx5W2YQrrmVj4
	BzSnYfb78Af9Y1iL+LGJfe9hGDxkszV4sewap49FNZcWbugaXFurSLPPs2oX2DMt49PhYk6p9tY
	VOHCdu6whwrgU7WFmmRfllXRVrNMejpWQDxxVnajvqItjewPiqw7xFoJdXCAwemI3zCnobv/h35
	Jr4xiC9LGryGNIAo31H1fhPNEfU2/ztLiJ8HT5mcs+6TgMnnMHdSPDTWl8cYs+fOttZVKY8/RxU
	001i7g5Nn0ugx+nIw+tzb1c2OKm0AeGPteODqGsvo5Y2gHzIHq2MMNF2PuCQO0iC/swQSZ2+rb1
	b0CCrDPob5I9solq7wsFYUhCwDGXCxuiP/T35apQX1d3Al4Kg5NWXa0vl4bYKyL0rBvFul97z3e
	MihOlqgeP8gu4GWHP5oroDnm+znorjBmzmkpef2x4EiRubsoH2O1wnqjHwYJEN2Y7RkBV6ua2Og
	9z0QngXhBaFLyT+Cj7N6OyYyXH72LaL77Q==
X-Received: by 2002:a17:903:2308:b0:2e9:cb4:b345 with SMTP id d9443c01a7336-2f03f264db3mr164655465ad.55.1795598748107;
        Wed, 25 Nov 2026 01:25:48 -0800 (PST)
Received: from server225.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f142b8bsm80883155ad.70.2026.11.25.01.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:25:47 -0800 (PST)
From: Ping Li <leeonion.muyu@gmail.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ping Li <leeonion.muyu@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/3] mtd: rawnand: intel: unmap the DMA buffer in ebu_dma_start()
Date: Wed, 25 Nov 2026 17:25:37 +0800
Message-Id: <20261125092538.1938516-3-leeonion.muyu@gmail.com>
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

ebu_dma_start() maps the data buffer for every page transfer but
only unmaps it on the error path.  Successful transfers thus leak
the mapping, which accumulates IOVA space on IOMMU systems and
skips any cache maintenance the unmap would perform on
non-coherent platforms.  The error path has two more problems:
when the mapping itself fails it jumps to the unmap with an
invalid dma address, and the unmap is performed with
ebu_host->dev instead of the dma_dev device the buffer was
mapped with.

Return directly when the mapping fails, and unmap with dma_dev on
both the success and the error paths.

Fixes: 0b1039f016e8a ("mtd: rawnand: Add NAND controller support on Intel LGM SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Ping Li <leeonion.muyu@gmail.com>
---
 drivers/mtd/nand/raw/intel-nand-controller.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/intel-nand-controller.c b/drivers/mtd/nand/raw/intel-nand-controller.c
index 1f493fb426d6..5eff8d7522d4 100644
--- a/drivers/mtd/nand/raw/intel-nand-controller.c
+++ b/drivers/mtd/nand/raw/intel-nand-controller.c
@@ -312,8 +312,7 @@ static int ebu_dma_start(struct ebu_nand_controller *ebu_host, u32 dir,
 	buf_dma = dma_map_single(dma_dev, (void *)buf, len, dir);
 	if (dma_mapping_error(dma_dev, buf_dma)) {
 		dev_err(ebu_host->dev, "Failed to map DMA buffer\n");
-		ret = -EIO;
-		goto err_unmap;
+		return -EIO;
 	}
 
 	tx = dmaengine_prep_slave_single(chan, buf_dma, len, dir, flags);
@@ -346,10 +345,12 @@ static int ebu_dma_start(struct ebu_nand_controller *ebu_host, u32 dir,
 		goto err_unmap;
 	}
 
+	dma_unmap_single(dma_dev, buf_dma, len, dir);
+
 	return 0;
 
 err_unmap:
-	dma_unmap_single(ebu_host->dev, buf_dma, len, dir);
+	dma_unmap_single(dma_dev, buf_dma, len, dir);
 
 	return ret;
 }
-- 
2.34.1

