Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1D934DCE3
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303550; cv=none; b=ZN9RnM7Pr4DV81xfEttedAAnRngnsX98yoodp7YgzmJDQaJnqVm8lrOveJIu03DjbdLndaYM/Y2CqCShJdHxCpQhN1lZSYYhpkInkqENZQhEq1eT/UuuGgAPueO7BZlPPv929DZ//9JhFayF+R2kIsdqI6cech9gfXmr2V3G4Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303550; c=relaxed/simple;
	bh=k1IgA+NdLrvl7ltDUfmRmUgs0wr3k278THCaOwttGgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XhMV5A+N3l0Viq4YdJurVn8JJhjPMX+MU6OQmNsoB/SuZR1IS4fwX31RdedXZXCtJvfHN8xCATq7oS0WgF51ZM2w43nZ3i8WJaS7/0Wh521IhgheOGoHUy9dk5Pk+/Dsowj7ZAysdvYgB0eT0QoDRVMugigtseA6g3Kdv/Nbnb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSLQ3jVz; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSLQ3jVz"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39c74c469e8so62801371fa.0
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 08:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784303546; x=1784908346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mR8w9J8HX07mDDKSdmoHrKPNrY3xeykulocxr2DnutU=;
        b=NSLQ3jVzSJK88ISUn0cZPtMLuEKh4e871nM5wno/W9M9dDeC5H9lOrnr92rQKYd/s3
         tL7NmsveQhZ0cHMfK8oTiDkYdcIeJ5zjpp4A2PnPy8KeAmN1Vj8PG+IM7j+DkMQYfzTS
         qPvtUs4o5AN7+RyD3HOEXG1gUo1L7rKKb5w9p1UF+l25bxu0MbZEC6CB6ybvK7hIg4/J
         AVcjw9FDfPT+zLHZ+SjBUiQM7RpZCf0wyeWM9kf23Xpw3W3HVM6BgZb+aGCKbVebyu89
         bBJS3/Ir4phADt8WcTtnhWvT43bJNC//N5gdWDKlAEVk3C5v8dxOcPblehd6088DYCxD
         cVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784303546; x=1784908346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mR8w9J8HX07mDDKSdmoHrKPNrY3xeykulocxr2DnutU=;
        b=KKn2k8SgtQtazfUYCniVqVa4v7fo+yCfpCMJnfaaAihAkrdfZt9WDhogum4rdI0TZc
         TKXdu9qaa4wgO1VUpDFGbyaShQKeWc1EuuLkU2gHnQ1PI816QdncDx8JKAEuzmbtLdMR
         Kd+RRci98mfIeLRSCZoEO7YDT8sdhzz1PhvDsQp9MznSc/fvSULNCCV7AJdB3kY3yuDN
         U5wSAh1zUep4JLHTTzl6ST4Yx1FQzKw+PweT3gaPYAvMCoVha6LE2wXGOs8vsWcMR2Ih
         ukbs6j7N4V25Mj5Y7Cw4wFpN9qC0gnernkI6CiPKcpu0Pomj5Ya/3KHNfABgY1a02jUz
         infg==
X-Forwarded-Encrypted: i=1; AHgh+RrxvVAy0ao2E94/hss5oaFXrBw0CbXtwrIamEu9G74Ui+FfjsNBZA2eSB2N13DztNDHlaqwQ0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMuYHUpnVK95a7pDj9NoITFLGQhowyGTNjEa7TZGoeKXUy9J/1
	Jso+ahZhF/xuuagvMqS+032JOOKGesc0GTxK/wMN0KlidY84dgjRDXpE
X-Gm-Gg: AfdE7cl5VgD3XG4TZczB83kkTmKT47tmX89x01Ykj2FdIlNCi+oxO3+88swxlz6pPLK
	oNPYOFqb3S5hglJneWJ2QwQZtmtmWaxH82wBj0O1oye/WGQzzFw+wZRkJmYGJ+rIV7NP9Gj3LUM
	+63dLDExk9T7k6iP9lTvjw22HLz0CaAOk4Ng9eALPLI6eH+VJbsI0Ww49xnnyAV9JW8vSCXhint
	CB+vfwc1Cs05XJZBUdskD7H+6aJ+tLBG4M4Nw+YIV2P5Ow63AIBJlifm8rFBRBCOm5KZQyokmBf
	WqWmY0hhViMglwExNf5kBXyMIYUsgxz2O+78+l9asmU/BAQ7BWwFmKKbfl4BVoYVYgZChQgLWwA
	LzScuAo8wWc3kHtyzPqWMZZtBv74OjnQY0b0ODNLVnHHf1mv91SkyScRlKtCzeaNUMREtMZNKUJ
	LhvZWataRL7wH84poHxb+Gx72fIH6dzd/koLEwPdpP8vLKaMjXAFze
X-Received: by 2002:a05:651c:158d:b0:39c:6f89:c9b3 with SMTP id 38308e7fff4ca-39eb282acf6mr6605421fa.14.1784303545606;
        Fri, 17 Jul 2026 08:52:25 -0700 (PDT)
Received: from NoteBook (sandersphylex.duckdns.org. [193.23.209.59])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39eb501b90bsm3164781fa.40.2026.07.17.08.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 08:52:24 -0700 (PDT)
From: Aleksandr Mineev <sanderrrs@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Mineev <sanderrrs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mtd: spinand: fmsh: fix FM25G01B/FM25G02B Quad I/O read dummy cycles
Date: Fri, 17 Jul 2026 18:50:50 +0300
Message-ID: <20260717155051.50-1-sanderrrs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FM25G01B/FM25G02B datasheets specify a single dummy byte for the
0xEB Quad I/O read-from-cache operation, but the generic
read_cache_variants set uses two dummy bytes for the 1S-4S-4S variant.
The extra dummy byte shifts the data phase and returns corrupted data
with no ECC error, breaking boot on boards using these chips.

Use a dedicated read-from-cache variant set with ndummy=1 for the
1S-4S-4S (0xEB) operation.

FM25G01B datasheet: https://www.fmsh.com/nvm/FM25G01B_ds_eng.pdf
FM25G02B datasheet: https://www.fmsh.com/nvm/FM25G02B_ds_eng.pdf

Fixes: d5a5c9eb2ee9 ("mtd: spinand: fmsh: add support for FM25G{01,02}B")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Mineev <sanderrrs@gmail.com>
---
v2:
- Add Cc: stable tag (Miquel Raynal)

 drivers/mtd/nand/spi/fmsh.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/fmsh.c b/drivers/mtd/nand/spi/fmsh.c
index be5db9f9502b..6352e9c9e502 100644
--- a/drivers/mtd/nand/spi/fmsh.c
+++ b/drivers/mtd/nand/spi/fmsh.c
@@ -44,6 +44,14 @@ static SPINAND_OP_VARIANTS(update_cache_variants,
 		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
+static SPINAND_OP_VARIANTS(fm25g_read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
+
 static int fm25g01b_ooblayout_ecc(struct mtd_info *mtd, int section,
 				  struct mtd_oob_region *region)
 {
@@ -192,7 +200,7 @@ static const struct spinand_info fmsh_spinand_table[] = {
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xd1),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 21, 1, 1, 1),
 		     NAND_ECCREQ(8, 528),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+		     SPINAND_INFO_OP_VARIANTS(&fm25g_read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
@@ -202,7 +210,7 @@ static const struct spinand_info fmsh_spinand_table[] = {
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xd2),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 41, 1, 1, 1),
 		     NAND_ECCREQ(8, 528),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+		     SPINAND_INFO_OP_VARIANTS(&fm25g_read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
-- 
2.54.0

