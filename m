Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CFA41D4E5
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 11:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338516; cv=none; b=F7bYLB0Q6e4kjof/IfvXGlXiV2OROT66/gjbCnkycUn441+K+vDhjPi/Oju5JvEcezdNOnP2PrMBMlEHCCDhZhBlJEiR4ZZ4wXebK66xAoBOVGh3wnLuEKarMnDRlcGEdhg82FwK4CZh7cIJnZwITOjJtu1CXR4SlH5oH4azF+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338516; c=relaxed/simple;
	bh=Vbjk1r1UF7aP9dlEuCuiRg7mgnpt1lUL6ZtGktNqaVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HH8E8m0Cui8RY5oOFbWPD1KO+VQypt65ksvmRxf14kFOd6R8VA6myvWrmFNdvm2OQGvV9i0FGogNPqWPv6TwNNZfayPgquyrSccMIaIVqeE1pJHdO6DSHUmOCO+s0lyMAIeEvI+8Be9E7mUunfPmlSxIFjxL5jTaWzmY4hDqH2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=QySWGiAR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="QySWGiAR"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b27c7451so35490945e9.0
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 04:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783338512; x=1783943312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YiNWA4XhuvaUhqi6Oa/oDG6LqIOrOq6gKP3C+ylBpDs=;
        b=QySWGiARAVUEuXhbuoM2qW/nuf+sLVQcemmkOpCzme/1BFM9pIA7rNyLyiywYCMZ0d
         99ZQdRhR7uGIK5dSs0jcxvQSg9MtZikR7ESEt3lTeHTI2+ZRhK65gfGMQx/7aqikDnqt
         sIgi45Ams2vv+LdtOLXxhQP4Z9L5dbGV8jeQsRgsX4iIqBqldv/Jr+JufOO+GZnURmxd
         euKYGrVI0tTb9z4ho3LPQs64JH5h2UBnOJ9pKSbcF7WEIxC0+AlZQdQ00SN+Cy3S2La9
         XLkiW1u7fHRYlZn08gdjRLZgV+zZAt8Xm0FL+N++hFTh2AglQmDsEhStGg8XIp+PVz+e
         dXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783338512; x=1783943312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiNWA4XhuvaUhqi6Oa/oDG6LqIOrOq6gKP3C+ylBpDs=;
        b=QVYEYNJIqXGNy8u9wTF14xyJeETGCVgZ3tgp9zo2Jby3GUeswg1eDivpKBw9MrTpl1
         W5AW66iNSSQGPzCw3pmNfFJNvr9+TWRxNiSPB04PCK6pGncuA0YTzHwcpTLz08o3+9Mz
         T7TWUM4LKvkoZ/RL5iHcQ3+y/BxS7H6ApPPPQPD4GUf3WCdAmV3o7oRI/siuUolJI4rZ
         fmhP2OEDjRkDA2bFl+0Blk4HOsSRXJ9bc8+qLQs00YWVT6H/n7/G3YzgI1Jj1cg4+8GF
         Ii5B60xEQ5Q6nQxgxQbEkMvxxXiQF1u1fJIEOApiJlRlPTDf8Ml0Wx1fKRuMOt4JcWmF
         VFFw==
X-Forwarded-Encrypted: i=1; AHgh+Rpn1+g+uTWkTtpFs+HwukjBWdY7p7Z8SE83YpiuaIJ0lRmq262ePc/xX9yd5qZNlf2k9zEvA74=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNc8+GSi8S/8nvQbEDoTr6MN5sh7MKHqaLatM7Ij9SIo+QIgYG
	jK9XzPJY8vxPwzIDOB9vkUL1/JlhTDDkdOxKmgrdGelXde31RC8xHd347/UW/+xs2Gc=
X-Gm-Gg: AfdE7cl5mPMgDySJdrvocdYfnGScI6uwGghB/fCasoGiuSCUfZObJYhP7de3r8UPtcf
	MeHImdk0pKTmvwBb4bmGCY9i7uM3iy5o7oYKjtXHgLyj80rSwNy+a2TKZa+shf6nCR7RnPUGoJ4
	nUD0fxe57BcXSlUH/SN806D4nUvcrc/OoAqIT5Oxw74QReb/pWG/xMiT/jiWCflu43yD6ovCHpo
	x+piauzFBiWU6eOAK+raP4UhQVB5ScjM9ez5A5eQ1CYgYdNL2SfYUE0bK6dAmE7EaW246dvOu0O
	fJfHpfDAb5ScCvSv2DhyUm+JyFgdBakCZHzP/15gpkhI9MI0zLZvYaYC6TsVWot/R1fwgrGqho5
	DR0Fayd7+flHfBGvaqMTFBseTb4Wnfy1TUCimj0BLTfsDSj5DzoPWqehEqbwCjpzrTD6arKEzDt
	V+0tfIsRfJ9tt26DDj5upjPh3ZbThoeie0mIORejVA1i20HTE+VtCx7HJa
X-Received: by 2002:a05:600c:4584:b0:492:3fb5:3a17 with SMTP id 5b1f17b1804b1-493decb3dc8mr4634135e9.2.1783338511859;
        Mon, 06 Jul 2026 04:48:31 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it ([95.236.170.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63172fesm623599205e9.0.2026.07.06.04.48.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Jul 2026 04:48:31 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
To: robh@kernel.org,
	saravanak@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Carlo Caione <ccaione@baylibre.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] of/address: Fix NULL bus dereference in of_pci_range_parser_one()
Date: Mon,  6 Jul 2026 13:47:17 +0200
Message-ID: <20260706114731.57353-1-ccaione@baylibre.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bus matching rework made of_match_bus() return NULL for nodes
with ranges/dma-ranges but no local #address-cells. parser_init()
stored that NULL bus, and the range iterator later dereferenced it.

Reject such nodes in parser_init(), leaving an explicit empty iterator
for callers that ignore the init return. Keep the DMA limit walk guarded
by a non-empty dma-ranges property, and only clamp the limit when at
least one complete range was parsed.

Fixes: 64ee3cf096ac ("of/address: Rework bus matching to avoid warnings")
Cc: stable@vger.kernel.org
Signed-off-by: Carlo Caione <ccaione@baylibre.com>

---
Changes in v2:
- Validate na/pna/ns in parser_init() with OF_CHECK_COUNTS() /
  OF_CHECK_ADDR_COUNT()
- Link to v1: https://lore.kernel.org/r/20260706095651.48839-1-ccaione@baylibre.com
---
 drivers/of/address.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index cf4aab11e9b1..fd2468b89579 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -753,6 +753,7 @@ EXPORT_SYMBOL(of_property_read_reg);
 static int parser_init(struct of_pci_range_parser *parser,
 			struct device_node *node, const char *name)
 {
+	const __be32 *range;
 	int rlen;
 
 	parser->node = node;
@@ -761,12 +762,20 @@ static int parser_init(struct of_pci_range_parser *parser,
 	parser->ns = of_bus_n_size_cells(node);
 	parser->dma = !strcmp(name, "dma-ranges");
 	parser->bus = of_match_bus(node);
+	parser->range = NULL;
+	parser->end = NULL;
 
-	parser->range = of_get_property(node, name, &rlen);
-	if (parser->range == NULL)
+	range = of_get_property(node, name, &rlen);
+	if (!range)
 		return -ENOENT;
 
-	parser->end = parser->range + rlen / sizeof(__be32);
+	if (!parser->bus ||
+	    !OF_CHECK_COUNTS(parser->na, parser->ns) ||
+	    !OF_CHECK_ADDR_COUNT(parser->pna))
+		return -EINVAL;
+
+	parser->range = range;
+	parser->end = range + rlen / sizeof(__be32);
 
 	return 0;
 }
@@ -792,7 +801,7 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 	int na = parser->na;
 	int ns = parser->ns;
 	int np = parser->pna + na + ns;
-	int busflag_na = parser->bus->flag_cells;
+	int busflag_na;
 
 	if (!range)
 		return NULL;
@@ -800,6 +809,8 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 	if (!parser->range || parser->range + np > parser->end)
 		return NULL;
 
+	busflag_na = parser->bus->flag_cells;
+
 	range->flags = parser->bus->get_flags(parser->range);
 
 	range->bus_addr = of_read_number(parser->range + busflag_na, na - busflag_na);
@@ -976,8 +987,8 @@ phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
 		np = of_root;
 
 	ranges = of_get_property(np, "dma-ranges", &len);
-	if (ranges && len) {
-		of_dma_range_parser_init(&parser, np);
+	if (ranges && len && !of_dma_range_parser_init(&parser, np) &&
+	    of_range_count(&parser)) {
 		for_each_of_range(&parser, &range)
 			if (range.cpu_addr + range.size > cpu_end)
 				cpu_end = range.cpu_addr + range.size - 1;
-- 
2.55.0

