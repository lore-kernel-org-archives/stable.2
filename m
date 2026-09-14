Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46444A014B
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 21:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420208; cv=none; b=MIDDz9mi0gspK1Pscl4fLtdJMY4tjFo9BktskB7Ft7/jmNPIBBJhLLZ7b9uMaOESg/Pd+mPwzVST4lLWX6f1Mgz0ndR2aTjiMO1qdz4hLRDqHPpf0miyw1DfJd2CVV5hhwjConAK7XcSlSf3ANPwUtVyCL7PPNKtERWCE24ybYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420208; c=relaxed/simple;
	bh=sEgsacOGRde9P8OKLBN0PM1Bqnp+ZYDx65EvzcaNGcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BARk09l8y/msCEKUv+JlZ2t4Hf8ShzctD1ZrtjZXfhZRhMnuO/+B6YtgWg7FFPkVqqgtyizhrsolvxMaKKXJPEmtD+4eMEb8QSF+IJg7h06H6GuU2/yUoNXg9YFi48L36T+/Amc8en6TD8Anu2AliQMucuELQlEiWo/uZTLmO3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2tbFN00; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2tbFN00"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6b1afdf98dfso2599695eaf.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 14:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789420200; x=1790025000; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a95pnyMUuTP3EJOQCSW0InToPnlbmRSOMBXnRGDUxFk=;
        b=B2tbFN00djp9L7fLBmsFagRNQmlKBvS1O/J5gy1zvNJ7cYNfQ0hDkfC0cKC0ZunRhQ
         GyfteCjwn9BrTvd5Fdg8ZHadlY7gUa3+5ixV7WiJPC1gwMwnZaAt+LaBh5rUv7zN4tZh
         AMrg+WbTpiO2tqOL83AD7dP2PQT3z37KvfWqvKQWfbCS6MLFgqfP4nrwtW22bvDpxu/8
         X3fgk86NfBq6JcXuRp7/Cv/oBEoPY9lMFWlSrwpG6l9POPzOwkm6czPudqGi8TG9kZwB
         K3kBrnPyBsnroqBd9WNh/3wv/dVIBphsPdyOBFqu5wQYEqfz1gydsb2PoTUPSsqoHu0/
         syFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789420200; x=1790025000;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a95pnyMUuTP3EJOQCSW0InToPnlbmRSOMBXnRGDUxFk=;
        b=1TkWMAcDP/ERMLKCsvmCCtZFFM7JV37HPOD/fwpYrCWxmLNBagAr8iRNGydW6E8Bav
         aBWE4IKiCrrO4IlMVruIwY+FDpQlerkk1UFwYrf6SI05luii4lDyfu/NITruNLDKv+LJ
         QpAA9HCm2I80QuUmLvky5zF5JiXxXeEmWXxjqfWP2Po4ObI8UCiZk7w/+/nvaHQOM3mo
         fLzy0KpqoMm0ChLVOx46V6dQL6ASwLjSAXN3aVs4qWx1oEFJ38uQprgWyqSxjDJfIxvO
         Yy7gsLeVLtDSTRgo+pvlSP1K3Sis2PZ+RiTqMRCaWgwfNWbhU1oW5BInlqB1OkuxJHBC
         +VvA==
X-Forwarded-Encrypted: i=1; AKwUvBwUTE3maC7J2C984ztaq/T4H2M3+vbhTRqXiDXaIoGJqw7DSqcwe85XhuORln/NBRIzjiIymbA=@vger.kernel.org
X-Gm-Message-State: AFuF++knnK1hJNhh0o3/z0RPYaHImS710P1p4BZy/XDWO8TDOL4UlHND
	fhgLVOVAjB9qPdFKevj29BAWmIPbJks8ABA1E75PH3CASilfb/jDOM5M
X-Gm-Gg: AYBFou3FNxuZmPtx+auY37sH6PtdIPNoUn11webFuGUXxb/+0G837eOJqZIlIQ3nO8N
	KF13u3ytIHYuKoGNyvsvylIfPOuUYSMhmbwpCarjaXvAHi/xmMwV5Z4HsAEEm8Tk/CWHrS4DtTv
	5E0eP+tIub6AJ8OtVKTVGjDKUzN2+slGjQgoZvHc7sXlwY9ElVk3Tqwo+SL7Y+ypRQVo/f8itsF
	E6iFCd+1MjRkKRv/Grd2TedGwJDBW5jncmzwPutJhUiP+oep6u+kCG6f9ckBMkHwvj2ElQOgvYV
	H85v09TsNzqBs50pU9JwreOndNIodYlJ/XHv6byx4jOM+BrafuvEXdMwZw89EPK34RhSbCTzY3I
	5LTvIiCrpYEWSLrIdWnEnvvgfPiKy0Gg7ncHdsXBo/WReMQrfUO7zMIRrum06tUu+gR8KSX2YjX
	dsX3PuetU2lmXuvy+2DyXfO2y4q/5MdFAwDZDyCXdkY+tUpCqB2PSotZxbAA8eHifEB1xN0r9vA
	2CLoR5z1B+aB901JHPdQEHTDrWOeaf8SvW9quw+KLBHO9QjHyomZv3AP/9ona1eM0N1PlHiVo3Z
	vmY0dugdZOpqJ9imCvde+a/byaYYWtlluo2QQ6PdUDMM2+S8wSuHWGsg/Lk1nQ3jP5aToIlKuZ6
	8t2RSf19FGJ6uBvh/S1vmhcsi3doh
X-Received: by 2002:a05:6820:810:b0:6be:6f42:3a86 with SMTP id 006d021491bc7-6c544ca9f68mr2776984eaf.47.1789420199333;
        Mon, 14 Sep 2026 14:09:59 -0700 (PDT)
Received: from [127.0.1.1] (184-96-157-145.hlrn.qwest.net. [184.96.157.145])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c45bfc3fe9sm4698544eaf.15.2026.09.14.14.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 14:09:58 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 14 Sep 2026 15:09:49 -0600
Subject: [PATCH v6 03/18] mtd: rawnand: sunxi: propagate page-setup and
 erased-check errors
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-submit-sunxi-nand-vendor-oob-layout-v1-v6-3-2fb084fe0751@gmail.com>
References: <20260914-submit-sunxi-nand-vendor-oob-layout-v1-v6-0-2fb084fe0751@gmail.com>
In-Reply-To: <20260914-submit-sunxi-nand-vendor-oob-layout-v1-v6-0-2fb084fe0751@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Masahiro Yamada <yamada.masahiro@socionext.com>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Brian Norris <computersforpeace@gmail.com>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2

The hardware-ECC read callbacks ignore errors from nand_read_page_op().
A failed page-setup command can leave the previous page available, so a
later successful transfer can return stale data instead of the requested
page. Stop before starting the PIO or DMA transfer when page setup fails.

The physical rereads used to check an uncorrectable chunk for erased
contents also ignore errors from nand_change_read_column_op(). A failed
transfer can therefore leave stale data in the buffers used for the
erased check and turn an I/O failure into an ECC result.

Share the erased-chunk fallback between PIO and DMA and stop before
checking the buffers when either reread fails. Preserve the existing
erased-chunk test and corrected-bit accounting when both reads succeed.

Before retrying a failed DMA read in PIO, restore only its corrected and
failed counters so partial results are not counted twice. Leave bad-block
and BBT counters alone. Route PIO page and subpage error exits through
ECC disable before returning the transfer error.

Fixes: 97d90da8a886 ("mtd: nand: provide several helpers to do common NAND operations")
Fixes: 25f815f66a14 ("mtd: nand: force drivers to explicitly send READ/PROG commands")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 120 +++++++++++++++++++++++---------------
 1 file changed, 72 insertions(+), 48 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 172c7c4b0ba6..d5d8d383b6d1 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1067,6 +1067,40 @@ static void sunxi_nfc_hw_ecc_update_stats(struct nand_chip *nand,
 	}
 }
 
+/*
+ * Return 1 for an erased chunk or 0 for an uncorrectable chunk, with ECC
+ * statistics updated in either case. Negative values report transport errors.
+ */
+static int sunxi_nfc_hw_ecc_read_error(struct nand_chip *nand,
+				       u8 *data, int data_off,
+				       u8 *oob, int oob_off,
+				       unsigned int user_data_sz,
+				       unsigned int *max_bitflips)
+{
+	struct nand_ecc_ctrl *ecc = &nand->ecc;
+	unsigned int oob_len = ecc->bytes + user_data_sz;
+	int ret;
+
+	/* Check the physical representation for bitflips in erased pages. */
+	if (nand->options & NAND_NEED_SCRAMBLING) {
+		ret = nand_change_read_column_op(nand, data_off, data,
+						 ecc->size, false);
+		if (ret)
+			return ret;
+	}
+
+	ret = nand_change_read_column_op(nand, oob_off, oob, oob_len, false);
+	if (ret)
+		return ret;
+
+	ret = nand_check_erased_ecc_chunk(data, ecc->size, oob, oob_len, NULL, 0,
+					  ecc->strength);
+
+	sunxi_nfc_hw_ecc_update_stats(nand, max_bitflips, ret);
+
+	return ret >= 0;
+}
+
 static int sunxi_nfc_hw_ecc_correct(struct nand_chip *nand, u8 *data, u8 *oob,
 				    int step, u32 status, u32 pattern_found,
 				    unsigned int user_data_sz, bool *erased)
@@ -1115,7 +1149,6 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	unsigned int user_data_sz = sunxi_nfc_user_data_sz(sunxi_nand, step);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
-	int raw_mode = 0;
 	u32 pattern_found;
 	bool bbm = !step;
 	bool erased;
@@ -1158,25 +1191,13 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 		return 1;
 
 	if (ret < 0) {
-		/*
-		 * Re-read the data with the randomizer disabled to identify
-		 * bitflips in erased pages.
-		 */
-		if (nand->options & NAND_NEED_SCRAMBLING)
-			nand_change_read_column_op(nand, data_off, data,
-						   ecc->size, false);
-		else
+		if (!(nand->options & NAND_NEED_SCRAMBLING))
 			memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE,
 				      ecc->size);
 
-		nand_change_read_column_op(nand, oob_off, oob,
-					   ecc->bytes + user_data_sz, false);
-
-		ret = nand_check_erased_ecc_chunk(data,	ecc->size, oob,
-						  ecc->bytes + user_data_sz,
-						  NULL, 0, ecc->strength);
-		if (ret >= 0)
-			raw_mode = 1;
+		return sunxi_nfc_hw_ecc_read_error(nand, data, data_off,
+						 oob, oob_off, user_data_sz,
+						 max_bitflips);
 	} else {
 		memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE, ecc->size);
 
@@ -1193,7 +1214,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 
 	sunxi_nfc_hw_ecc_update_stats(nand, max_bitflips, ret);
 
-	return raw_mode;
+	return 0;
 }
 
 /*
@@ -1260,6 +1281,8 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, uint8_t *buf
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
 	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
+	unsigned int corrected = mtd->ecc_stats.corrected;
+	unsigned int failed = mtd->ecc_stats.failed;
 	unsigned int max_bitflips = 0;
 	int ret, i, raw_mode = 0;
 	struct scatterlist sg;
@@ -1354,29 +1377,18 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, uint8_t *buf
 			if (!(status & NFC_ECC_ERR(i)))
 				continue;
 
-			/*
-			 * Re-read the data with the randomizer disabled to
-			 * identify bitflips in erased pages.
-			 * TODO: use DMA to read page in raw mode
-			 */
-			if (randomized)
-				nand_change_read_column_op(nand, data_off,
-							   data, ecc->size,
-							   false);
-
-			/* TODO: use DMA to retrieve OOB */
-			nand_change_read_column_op(nand,
-						   mtd->writesize + oob_off,
-						   oob, ecc->bytes + user_data_sz, false);
-
-			ret = nand_check_erased_ecc_chunk(data,	ecc->size, oob,
-							  ecc->bytes + user_data_sz,
-							  NULL, 0,
-							  ecc->strength);
-			if (ret >= 0)
+			ret = sunxi_nfc_hw_ecc_read_error(nand, data, data_off, oob,
+							  mtd->writesize + oob_off,
+							  user_data_sz,
+							  &max_bitflips);
+			if (ret < 0) {
+				/* The caller retries the whole read in PIO mode. */
+				mtd->ecc_stats.corrected = corrected;
+				mtd->ecc_stats.failed = failed;
+				return ret;
+			}
+			if (ret)
 				raw_mode = 1;
-
-			sunxi_nfc_hw_ecc_update_stats(nand, &max_bitflips, ret);
 		}
 	}
 
@@ -1471,7 +1483,9 @@ static int sunxi_nfc_hw_ecc_read_page(struct nand_chip *nand, uint8_t *buf,
 
 	sunxi_nfc_select_chip(nand, nand->cur_cs);
 
-	nand_read_page_op(nand, page, 0, NULL, 0);
+	ret = nand_read_page_op(nand, page, 0, NULL, 0);
+	if (ret)
+		return ret;
 
 	sunxi_nfc_hw_ecc_enable(nand);
 
@@ -1487,7 +1501,7 @@ static int sunxi_nfc_hw_ecc_read_page(struct nand_chip *nand, uint8_t *buf,
 						  &cur_off, &max_bitflips,
 						  i, oob_required, page);
 		if (ret < 0)
-			return ret;
+			goto out;
 		else if (ret)
 			raw_mode = true;
 	}
@@ -1496,9 +1510,11 @@ static int sunxi_nfc_hw_ecc_read_page(struct nand_chip *nand, uint8_t *buf,
 		sunxi_nfc_hw_ecc_read_extra_oob(nand, nand->oob_poi, &cur_off,
 						!raw_mode, page);
 
+	ret = max_bitflips;
+out:
 	sunxi_nfc_hw_ecc_disable(nand);
 
-	return max_bitflips;
+	return ret;
 }
 
 static int sunxi_nfc_hw_ecc_read_page_dma(struct nand_chip *nand, u8 *buf,
@@ -1508,7 +1524,9 @@ static int sunxi_nfc_hw_ecc_read_page_dma(struct nand_chip *nand, u8 *buf,
 
 	sunxi_nfc_select_chip(nand, nand->cur_cs);
 
-	nand_read_page_op(nand, page, 0, NULL, 0);
+	ret = nand_read_page_op(nand, page, 0, NULL, 0);
+	if (ret)
+		return ret;
 
 	ret = sunxi_nfc_hw_ecc_read_chunks_dma(nand, buf, oob_required, page,
 					       nand->ecc.steps);
@@ -1532,7 +1550,9 @@ static int sunxi_nfc_hw_ecc_read_subpage(struct nand_chip *nand,
 
 	sunxi_nfc_select_chip(nand, nand->cur_cs);
 
-	nand_read_page_op(nand, page, 0, NULL, 0);
+	ret = nand_read_page_op(nand, page, 0, NULL, 0);
+	if (ret)
+		return ret;
 
 	sunxi_nfc_hw_ecc_enable(nand);
 
@@ -1550,12 +1570,14 @@ static int sunxi_nfc_hw_ecc_read_subpage(struct nand_chip *nand,
 						  &cur_off, &max_bitflips, i,
 						  false, page);
 		if (ret < 0)
-			return ret;
+			goto out;
 	}
 
+	ret = max_bitflips;
+out:
 	sunxi_nfc_hw_ecc_disable(nand);
 
-	return max_bitflips;
+	return ret;
 }
 
 static int sunxi_nfc_hw_ecc_read_subpage_dma(struct nand_chip *nand,
@@ -1567,7 +1589,9 @@ static int sunxi_nfc_hw_ecc_read_subpage_dma(struct nand_chip *nand,
 
 	sunxi_nfc_select_chip(nand, nand->cur_cs);
 
-	nand_read_page_op(nand, page, 0, NULL, 0);
+	ret = nand_read_page_op(nand, page, 0, NULL, 0);
+	if (ret)
+		return ret;
 
 	ret = sunxi_nfc_hw_ecc_read_chunks_dma(nand, buf, false, page, nchunks);
 	if (ret >= 0)

-- 
2.53.0

