Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609309;
	b=Df0SReEwaUUzc7/hfcXNh16ztLZT1q/cBqiP/UYqqK8iih+kIF8EJBZFFVac3kjPP8I1
	 TX+c4fMgX59sWsmAyuamjzJeYQ6dnxQq+KE4szAHWo0bS/ziK0EtTH0LI2TIxTlNMErda
	 Rq3NN+unXty4pFng+AVhRpl2J0jEDqWApMJC9lpXowST+d5eBVTl2NTZ2LX9kKg4LNk5e
	 R32VPWA7P4B+9n2Qr1OUzZrhhCD1Fs24HLaL5c6zjUo42Q0bLmrYbbZXun9HsbDePHaTt
	 kfQNAezrggwtCoZbwMUglhS7fs7u1T1qz6KzfBBKDubS4Lyn6KR/iiVTDbsw/hysuDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FeByhJ3BHvo/2jRdQJQGFglqWfC3P53F7bznOhuKwO4=;
	b=V7PCk3OKbTi5UHDPNUq5x5BK1TW0CWVuYxeNOw8ApxCgTyWCER4Ci/MpZMh2wFeYJzOG
	 euIsOMT1ChKVR9xxdU7QbeYEkbIVqVLl8AJgu4XaVQejoUuuFRfAoOTjZxpHvvH+Jmj0A
	 TrVHVvQwBl0K+9TmoquBs1kF8O9UiJ2/MitySIJaAFhiUyN9Wvisz0MOTudScPpnccQ07
	 mA5/L/P1R0CBPGhPao8AeY3whc1t6XmIvRb9E1Hx9gte5+g6Tgb4kh4qaN1H1dol2LGWk
	 6riVc9JzXhReCl5+DEAAYoNoU30u2Zyib0OLAhdF3p7EiY4HUneMBDiJEoyO38oRwCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PM6xYQfQ;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44350606A686
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44350606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PM6xYQfQ
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8b904d10882so2330863b3a.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 04:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795609308; x=1796214108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FeByhJ3BHvo/2jRdQJQGFglqWfC3P53F7bznOhuKwO4=;
        b=PM6xYQfQ2bv5S6/aUWy15pAS0YgjizNeZ2yOut8L7JnpDlx5l0uhRn8soQHRl+Kirh
         vaSen6Yf0u5+pJY0bhwfyZ1lhP+w7Wo2FgjhElJR+Z5qhomy1HSrQCxNVlig+f19KAGE
         9f0zbmVxYogXcXSOtNlAlxWlQ2xhXgh2GQTIl3PI75adOR0bKyB1SaotAb3xiOUKv4Y9
         5i+OvcRerR3GS8zTexc8LVF6pC9BtgvcjMEjPBa+rXXySYju5k+gde8jN0KeSIZPmHc1
         XgTc8wfyAZtDbOSB+hbdPVqERdmvVRPRd04jTMtDBr1hmGMp/n7ox87VzYhXC0OF49qj
         5oPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795609308; x=1796214108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FeByhJ3BHvo/2jRdQJQGFglqWfC3P53F7bznOhuKwO4=;
        b=C7Q3gunT/mOTzeS2C7adNITUTRqo49OF8SU+0VINmzuybIXMP9Dwg+eMf3VakSYbwi
         9TUpjR90HcYgCNWDZIrzR3vnguG+7zf0Z/7Tz4Q2/wYu5D1lpqWnuSXFYDLiYufc6Mmq
         MXo8j8sF5xqtCpsb8dCnMKB/fkro+7NoTz5FWyyStqSD6tuo7Kwd7q3w541gQUb3+4b5
         Mc/qnblRR0B5CnCUmIwaHIo6LVTvJ37LP+N6/AlbNdD0ERA7SYxzvq5mpGphcVz7K4Uw
         +tvOa1juA1nCrdhGo76BlztdFXvin2uUljOawZsq94Ou/J+iYfM2hTT8/64Xj7xWLPP/
         ko+g==
X-Forwarded-Encrypted: i=1; AL+hErGKADU2/hK835iuAq8YzDgxMNX5PNhEaAHAcCWJvH6sKMrTtC9YbckzG4moocVJHUy0ZC06lp0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+m0iqdJf8+8wj9P3sbuPTlZr6RpL4BD4nYrb+T2wpbaiqB7mZN
	VodLm2x7Sj9I8w4i0HT3Vpka7w2UL5YzmmAGU1xPAvtg+GlRrJbRqMKb
X-Gm-Gg: AZFdTZcO6Xo0qQo4qrv3UnKfYjD3eVeStuvS9ftzSdPN7ei9JGduqu5pa4U3T+ru4+n
	yiV3mnI1XqykIDPX1h037abdyRBTk62uyAM/bMmzsB91zTTBtn1q0qBCmaX65crw4LjYnj489Oe
	6QeqQPCrW+lOx76MYVQET2yGoeHtrSdzban6C+2wsKyV26Peco+Ih/ed+A7BRiA1JuFgwBpFbIU
	iNpkhWTqBvcy1dlIwS+Q/NSwscnWbK8ZayS5kNZyCucvL4MU0VNQnrMyfJKrFS9S79sFle248ys
	m4D132EwW1d7ml3FI6JRZ+hhulXv5DYacdC02BfPb1DEr4qUWBsXkZ4bF6GdCDhg7HhKIm1e41H
	X2mADOmxGU8UIS3Gc/PuPtNQVIuHOkaaMSAbyp8xCxHlD3huY2JHoCc5lpoqJoUQZytGVBxHlCW
	yhPB9UtZOYRiTAwx4GRjxfANpfJlNGm63pMDhSWmzLID+oHzh+O+xyNzfPUkmsUtNoB3E50aAfZ
	j5dR7OeUx1kbAaiZ4c03crVzE72DL3SY8OfRDE3k0mx166TwyW7D3JrNO2L3c5E1p8IgrRkWEqZ
	8pixbmXLzJQWNVHoUVJauMS3Wr8lRHVyRIUDxiN1vtb5KYBkxM9aoB8=
X-Received: by 2002:a05:6a00:94d8:b0:8a3:7425:9095 with SMTP id d2e1a72fcca58-8c8794b8c2bmr16410566b3a.7.1795609308579;
        Wed, 25 Nov 2026 04:21:48 -0800 (PST)
Received: from server225.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c89dsm8688656b3a.13.2026.11.25.04.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:21:47 -0800 (PST)
From: Ping Li <leeonion.muyu@gmail.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ping Li <leeonion.muyu@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 2/3] mtd: rawnand: intel: unmap the DMA buffer in ebu_dma_start()
Date: Wed, 25 Nov 2026 20:21:34 +0800
Message-Id: <20261125122135.44696-3-leeonion.muyu@gmail.com>
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

