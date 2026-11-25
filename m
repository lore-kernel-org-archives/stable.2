Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607479;
	b=pwp2PwRpY9FPISGcZdH9fi2KXJeIH4Lmo1ul6J265T2OvBmLdir6I9Khy0W3MGd7triU
	 3EY+FHFCarhUDf8W8n8/aoaYzZSiP/VekBX6p6SePg/m0YI2tFv9wZCTqm2X7fFQjvIpR
	 Tyx8vq3VsShYf4hASQGKeNxt5kDQ3r69ft/Rw8shBcMIChm92KjvTKCouAsY5aRnaAAWR
	 OliNzYrNwkM7rPCpdFA7piDYijGJjmLmcRuYHDtJ1VLQHKtewxlBVuHIDG0JRBF8J2MUn
	 /QNe74njgTtM6BoYFVxC+uhjF81CWee8IIc+IByixBlyztpLW+7IQFtludlou6QAHFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607479;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FeByhJ3BHvo/2jRdQJQGFglqWfC3P53F7bznOhuKwO4=;
	b=HrCjqsHyydvAuCrnSVMJTLAq3DWP1bq/aMP71NYDyPxzCAvNMtuTiMoZVS3jodnkM6X7
	 SoJ68gf8PlBL93vU+14iI1SHxIk7+UZ1OSegk0mLmZqr1n2tFS1f9OId8MZH4pEziCw6z
	 2S0LgHDrkEr6Ijue4Gt2UFbMCBVk47nyy7SDKvYNh0+b4Zj5mKt/tpN8/BSa15OvbLJzq
	 9I93/nU7AYm+5S+QRgBO0rXVnSwsK/1h2g1mQ000j669K4u7GBEBhBThni0+ZaHcXgLM6
	 ooBb+ukrcAcEWBotvq6g+uZXG1zU0X0FRkv4wZvDlUoqwXgKQtwGaU8YUvK5RXbSeeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fKTIuiel;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E733C606A32E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E733C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fKTIuiel
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b402824d07so3813420a91.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 03:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795607478; x=1796212278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FeByhJ3BHvo/2jRdQJQGFglqWfC3P53F7bznOhuKwO4=;
        b=fKTIuiell0F9fayFUXNdbXkc9/s8SXSCjyBMAIWiunc3I5o7xEcxZxjqRvcboFrsKZ
         fUapIZ4v9zwbrA3QGyX3s0PSuKLaYdEcYI2EdU87//eaDwIPhdED5Ue3ByrhbA2Dfu6/
         iv3aplKvgk8J/A61mssKeVGNLieueco/xeOkLwhswB2iDrQR8yFSVaifIAIWrOZP977N
         /LHLaI9wrfSXNu0BR477fffQJRoX6jSfPUHJN9D3sOIXNhPBcDLMa/xGaE4hogdU7X+J
         kaoCh6S44Y9pPgUk03iCfioS6NEM3YdiUSwUZzu7Mf1Hsn041sCVaVIvh2qktRuKxuir
         RpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795607478; x=1796212278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FeByhJ3BHvo/2jRdQJQGFglqWfC3P53F7bznOhuKwO4=;
        b=bGm9W4Rfd9Mw9Yb94evPZza20gGTlambZD1HlpvBnG+3CxqKFvgoQYWgTnUwB5fkdJ
         SpB1ooxV3Z0JzZg4uthscbuGZd5UauNzPYlpPbLui7ekkNjfylqsOEa3ouoE79z1TcWx
         R94vgwnsTa0mj80teZdzDaPHA2bJpb0hN9qOLJY9ZDwg/jyxjFY3rvmYYPsLyiw4kdYz
         YmQX0X5sZfqBF6kVIRRyyhioLQkXaK2NvrzR3clwA3IkDZFE6HYdFLjteM84NhE5/JP/
         b549hTmdOLoNd0/8fGpqPd+NQQ6WhPxz8Nf8NQix88E6rgKJ/VAXI1bfmV6RMhqVVIUR
         lFaw==
X-Forwarded-Encrypted: i=1; AL+hErH+L4asU6OLqB6JyvLFReCcEEizJeaYTVbN1BVPUPdYn5SboTr+cOpSZBsyngO+kNz35OrmpB8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TJcD/WVlq3+Yt4u0u1WMhpnRKvUzU3rrN/uuqXQlEh8mSmyat
	VPNPRjHbwyyn7GfPuiTc1wqd+CPjD9FPn4AC6PW2IktRwG0qVi4rf/uW
X-Gm-Gg: AZFdTZf+6w+9IwZptPvk1AkfLMW+73olZ+yrD/+GzlOL92JPuMKzSJr6FNG/4BS8/lb
	FMi0eZ8HIC1plyADFWUr16UOVkaiwBtwWjRwWKRFHIyokavBdNQJc3IwvowpS+A4UhQq2kKVVRM
	jqO/6yVtSJUhbZugFlJjxC7iGh5klMJaeLRoZlZ+xWVOZynYCk+zWhkQiRCo9/hD6inBKQt2nP/
	MC30FC//f/zwIWSCDKLYGXI9z5uZcD524HoPwjmOUkFnmuGROl7XAFsabzXWmPlinuSjr2r1K03
	t+eqSTQmmETad6B+Ywe7JBpWPjQy41D4JZjjI4XOIjFmH3utd4KDHzxV+481/OuLC7pAt+inLXy
	MG3k8bI/qUsBotU6F1D4RRrpzD8PJXCzzoy6iDhRijRh3Yo5rajrDvSczb8r0+tcJpzblHXLxyR
	w7VYU2oEwvayrSp3wooZIGmrpsSo0k6pXzYLTSuCmv+VWcYcn/oPEq8sZJrR9ShIbNpctMuLEXe
	Q8zGTb9DzzKifBJRWbQB7nz8wWuZSLrq4/CZeGbNroXLOjOKZ74YOlpanCvKu9dC6B69y0PlQob
	gKpSAnoXVCw2HPFE0+yVkt7k3WwjcCNelA==
X-Received: by 2002:a17:90b:3891:b0:3b4:127a:2bc2 with SMTP id 98e67ed59e1d1-3b41c8d9bfamr15951758a91.14.1795607478256;
        Wed, 25 Nov 2026 03:51:18 -0800 (PST)
Received: from server225.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecbd0bsm30569662a91.15.2026.11.25.03.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:51:17 -0800 (PST)
From: Ping Li <leeonion.muyu@gmail.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ping Li <leeonion.muyu@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 2/3] mtd: rawnand: intel: unmap the DMA buffer in ebu_dma_start()
Date: Wed, 25 Nov 2026 19:51:07 +0800
Message-Id: <20261125115108.4147741-3-leeonion.muyu@gmail.com>
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

