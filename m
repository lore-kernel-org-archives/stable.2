Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD9D33290F
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 03:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789354911; cv=none; b=DbcE8V9GmWTCCkAt3tPDR3t+UBiyo6s1/62wmtXDxu8x7/6Y0iV84E7XfT15jNlCNR40HB5FXSUZYvJ1KXe1W/CN/wSmqEVZ4kHOk+CVBV/yXCxyB+sO1OXj7yzFlyC88uDWfnDOsXWVn74P9BVdkucmEpPcfck+dDfP8bAd/OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789354911; c=relaxed/simple;
	bh=QuwwqJoNNeFbRXCees1KSU/os0gxTVKzY6QPcLIi7JU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qv+Zzyx50FY7NSQXzYsfRtk+MBebFdIpmisqjBMi5wdjmRPMqg/9CbGcrVeTS90OacNai/S0Qkp4LW4XXhCNaHT6O04G+Rc1CwZp5+tQXh/aXmLpWdqocYzd3lBvbHxUSjuEP7qMNaq2zGFmxsPxUyDAIsAKpbg/KyfiIAMDylI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipd0HEMp; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipd0HEMp"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-80576d65d8eso1947964a34.1
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 20:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789354906; x=1789959706; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j2vD4BC1COzN8qzLeVpRCLcx09AvVc6YiLKflTDkdf0=;
        b=ipd0HEMp+LaYBiL6cJ2/ZzxLz5Ee9DXf0RvAhQgZ+OBWRLcNOhx881bk8TnmnCpaab
         sfBc3zZevIup/XezsFBtEtAvEZH/W3myPA9t0QzymyAUfGSpASWfFsOIuc1uR2GBu2MK
         iyOZhxlor2NzDYUd9HPLyvXGXBSFlk8O8I96Pf67n5l+WhtOYOQ+zVfsoNthpYGWFd6z
         fB+eXN2bTjrMJZ7RugaikTsdU//yo56jvmuEmopa8jE2GOkFgVzxMQ1l3HSQEW250NO/
         5uO8TfKeaoJnESbFuC6iAGaVL7Vt1PaXMKZuMroy9A3V0/q5GUM3Un6ouhm1/RsPvSnx
         296g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789354906; x=1789959706;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j2vD4BC1COzN8qzLeVpRCLcx09AvVc6YiLKflTDkdf0=;
        b=PugtAqnYPn2s/Rki0vnFbZftZku79fYM3mWHRy9ajBg0322Gbd8xaTK4EmUCGyPMJv
         +/DIwygGo3eg8WumZou2ix/a0YEciprHgIVWNtLndOIpJCRRuBLCHxyIVFIyhB55/8gJ
         dherKJhxZPH6mHq+lgqRQiqfK0IAS//RCMXIohtj6fMLzKy+z6PV9XaxejfxLV33phy8
         5aefnrn2jMJZV6e4GoEmjeU/mnkhBhISF+Ul0jgVapHfDFVgxrwlv++h2zXn5DuuYe2o
         cw52cX9xcEcngl9w7s6+jTfcg21HqkOI5YaSf9wMoosSng+XvvdQzfdmeHat4e8RnMZQ
         15GA==
X-Forwarded-Encrypted: i=1; AKwUvBwi6PnMYY1fuFx0Y+fog5ReLHbei7TDss/rfXUKg7cAaeIB1ecdiZGQD9yYmwjJAybpVW9hU7o=@vger.kernel.org
X-Gm-Message-State: AFuF++n7fYOSzwhcuJoKUmYqxu7x0YBKAFFuAAIEbOw6fXFzhunJKOS4
	9CHCWW0KQ5ST+5J81XvY2HtEX/LxnZEdi1X38q9HLs8xS5+G6QwAea91
X-Gm-Gg: AYBFou3+P+4kHJ0Uge/UVzO9f/JpeOonITjRsQ8dKgO+AQhfN7gnEqxjY/2XnxPnDV7
	X0S9Xh4NfTGecM2R8EsIMqJA/0QHYpPSblH+SZ6DBkJiBSLA7xmVQ/t/6h6Sy94tYIUuBvtUW4N
	RhyKX0eFNQChCeDotolKbNGbKdV9T9TPlD3fmxp9RZ6iIU/rhPmApRUbGlWwGOr7j7+Tx1zi/c7
	Kb2W2EebaI+kopSa9z5oM+Fz4TnJlaROmS1be3R+inb9wb4HFx7LvJ37UM3BT1jC+QhxTfKEMAD
	vwhbrTRfPjumP3kVvSaqAT8y1hBwTr/JVtBwoXEScsfv4SSD8dd1cDECsrmtgQUbkHKb2WiD6Ed
	liD39JIlzXjSolhkBygj9FkHQRLxYd28rK280bTHS+BmIM9c/QMctMkqNOtnrFjKaJW4mK76Cn3
	5DSAjC0lk0r03OZq84taZvgZ8OI6LyNvELvCbe32Xr9H9+h8Yrw4fitF/n5vyiy9FEjNlSG459q
	324NUcGq7PfiQKf/pY5phnJ5hVTekyKdoztm1TBTNISGQSSXSRhXeWWHWMOObwK5ssAiTP0y5PK
	L0iAc30twpmXxO2O2GNIPKxYyUH3AYUnrkI9qZaRGKd+7L1ZDLChr6n7XsLxQzn0hUAWXV9yK70
	EkrOj9K/+OdApJNkkWRyGnggJobDgvA==
X-Received: by 2002:a05:6830:3886:b0:7fa:ac4f:790 with SMTP id 46e09a7af769-8089a150dcamr251581a34.28.1789354906207;
        Sun, 13 Sep 2026 20:01:46 -0700 (PDT)
Received: from [127.0.1.1] (184-96-157-145.hlrn.qwest.net. [184.96.157.145])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f60feba1sm10619014a34.13.2026.09.13.20.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 20:01:45 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 13 Sep 2026 21:01:12 -0600
Subject: [PATCH v5 06/18] mtd: rawnand: sunxi: propagate buffer and column
 transfer errors
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-submit-sunxi-nand-vendor-oob-layout-v1-v5-6-7d711076a6f7@gmail.com>
References: <20260913-submit-sunxi-nand-vendor-oob-layout-v1-v5-0-7d711076a6f7@gmail.com>
In-Reply-To: <20260913-submit-sunxi-nand-vendor-oob-layout-v1-v5-0-7d711076a6f7@gmail.com>
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

The PIO buffer helpers stop on a FIFO or completion timeout but return no
status. Their hardware-ECC callers also ignore column-change failures,
including the extra-OOB paths used after DMA. A read can therefore report
success with incomplete data, and a write can issue PAGEPROG after a
failed transfer.

Return transfer errors through the randomizer and OOB helpers to the
page callbacks. Always disable the randomizer after a buffer transfer,
and let the existing page error exits disable ECC and skip program-end.
Only advance the extra-OOB cursor after a successful transfer.

Keep the corrected-bit count separate from transport status so successful
OOB reads do not overwrite it. If any legacy DMA OOB read fails, discard
the ECC statistics from that attempt before the caller retries in PIO.
Leave the successful transfer sequence and OOB representation unchanged.

Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller support")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 220 ++++++++++++++++++++++++--------------
 1 file changed, 141 insertions(+), 79 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 3f506d0666a1..72b79f893e29 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -644,7 +644,7 @@ static void sunxi_nfc_select_chip(struct nand_chip *nand, unsigned int cs)
 	writel(ctl, nfc->regs + NFC_REG_CTL);
 }
 
-static void sunxi_nfc_read_buf(struct nand_chip *nand, uint8_t *buf, int len)
+static int sunxi_nfc_read_buf(struct nand_chip *nand, u8 *buf, int len)
 {
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
@@ -660,7 +660,7 @@ static void sunxi_nfc_read_buf(struct nand_chip *nand, uint8_t *buf, int len)
 
 		ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
 		if (ret)
-			break;
+			return ret;
 
 		writel(cnt, nfc->regs + NFC_REG_CNT);
 		tmp = NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD;
@@ -672,17 +672,19 @@ static void sunxi_nfc_read_buf(struct nand_chip *nand, uint8_t *buf, int len)
 
 		ret = sunxi_nfc_wait_events(nfc, NFC_CMD_INT_FLAG, poll, 0);
 		if (ret)
-			break;
+			return ret;
 
 		if (buf)
 			memcpy_fromio(buf + offs, nfc->regs + NFC_RAM0_BASE,
 				      cnt);
 		offs += cnt;
 	}
+
+	return 0;
 }
 
-static void sunxi_nfc_write_buf(struct nand_chip *nand, const uint8_t *buf,
-				int len)
+static int sunxi_nfc_write_buf(struct nand_chip *nand, const u8 *buf,
+			       int len)
 {
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
@@ -698,7 +700,7 @@ static void sunxi_nfc_write_buf(struct nand_chip *nand, const uint8_t *buf,
 
 		ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
 		if (ret)
-			break;
+			return ret;
 
 		writel(cnt, nfc->regs + NFC_REG_CNT);
 		memcpy_toio(nfc->regs + NFC_RAM0_BASE, buf + offs, cnt);
@@ -712,10 +714,12 @@ static void sunxi_nfc_write_buf(struct nand_chip *nand, const uint8_t *buf,
 
 		ret = sunxi_nfc_wait_events(nfc, NFC_CMD_INT_FLAG, poll, 0);
 		if (ret)
-			break;
+			return ret;
 
 		offs += cnt;
 	}
+
+	return 0;
 }
 
 /* These seed values have been extracted from Allwinner's BSP */
@@ -865,23 +869,31 @@ static void sunxi_nfc_randomize_bbm(struct nand_chip *nand, int page, u8 *bbm)
 	bbm[1] ^= sunxi_nfc_randomizer_step(state, 8);
 }
 
-static void sunxi_nfc_randomizer_write_buf(struct nand_chip *nand,
-					   const uint8_t *buf, int len,
-					   bool ecc, int page)
+static int sunxi_nfc_randomizer_write_buf(struct nand_chip *nand,
+					  const u8 *buf, int len,
+					  bool ecc, int page)
 {
+	int ret;
+
 	sunxi_nfc_randomizer_config(nand, page, ecc);
 	sunxi_nfc_randomizer_enable(nand);
-	sunxi_nfc_write_buf(nand, buf, len);
+	ret = sunxi_nfc_write_buf(nand, buf, len);
 	sunxi_nfc_randomizer_disable(nand);
+
+	return ret;
 }
 
-static void sunxi_nfc_randomizer_read_buf(struct nand_chip *nand, uint8_t *buf,
-					  int len, bool ecc, int page)
+static int sunxi_nfc_randomizer_read_buf(struct nand_chip *nand, u8 *buf,
+					 int len, bool ecc, int page)
 {
+	int ret;
+
 	sunxi_nfc_randomizer_config(nand, page, ecc);
 	sunxi_nfc_randomizer_enable(nand);
-	sunxi_nfc_read_buf(nand, buf, len);
+	ret = sunxi_nfc_read_buf(nand, buf, len);
 	sunxi_nfc_randomizer_disable(nand);
+
+	return ret;
 }
 
 static void sunxi_nfc_hw_ecc_enable(struct nand_chip *nand)
@@ -1152,17 +1164,25 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 	u32 pattern_found;
 	bool bbm = !step;
 	bool erased;
-	int ret;
+	int ret, bitflips;
 	/* From the controller point of view, we are at step 0 */
 	const int nfc_step = 0;
 
-	if (*cur_off != data_off)
-		nand_change_read_column_op(nand, data_off, NULL, 0, false);
+	if (*cur_off != data_off) {
+		ret = nand_change_read_column_op(nand, data_off, NULL, 0, false);
+		if (ret)
+			return ret;
+	}
 
-	sunxi_nfc_randomizer_read_buf(nand, NULL, ecc->size, false, page);
+	ret = sunxi_nfc_randomizer_read_buf(nand, NULL, ecc->size, false, page);
+	if (ret)
+		return ret;
 
-	if (data_off + ecc->size != oob_off)
-		nand_change_read_column_op(nand, oob_off, NULL, 0, false);
+	if (data_off + ecc->size != oob_off) {
+		ret = nand_change_read_column_op(nand, oob_off, NULL, 0, false);
+		if (ret)
+			return ret;
+	}
 
 	ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
 	if (ret)
@@ -1184,13 +1204,13 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 	pattern_found = readl(nfc->regs + nfc->caps->reg_pat_found);
 	pattern_found = field_get(NFC_ECC_PAT_FOUND_MSK(nfc), pattern_found);
 
-	ret = sunxi_nfc_hw_ecc_correct(nand, data, oob_required ? oob : NULL,
-				       nfc_step, readl(nfc->regs + NFC_REG_ECC_ST),
-				       pattern_found, user_data_sz, &erased);
+	bitflips = sunxi_nfc_hw_ecc_correct(nand, data, oob_required ? oob : NULL,
+					    nfc_step, readl(nfc->regs + NFC_REG_ECC_ST),
+					    pattern_found, user_data_sz, &erased);
 	if (erased)
 		return 1;
 
-	if (ret < 0) {
+	if (bitflips < 0) {
 		if (!(nand->options & NAND_NEED_SCRAMBLING))
 			memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE,
 				      ecc->size);
@@ -1202,17 +1222,22 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 		memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE, ecc->size);
 
 		if (oob_required) {
-			nand_change_read_column_op(nand, oob_off, NULL, 0,
-						   false);
-			sunxi_nfc_randomizer_read_buf(nand, oob, ecc->bytes + user_data_sz,
-						      true, page);
+			ret = nand_change_read_column_op(nand, oob_off, NULL, 0,
+							 false);
+			if (ret)
+				return ret;
+			ret = sunxi_nfc_randomizer_read_buf(nand, oob,
+							    ecc->bytes + user_data_sz,
+							    true, page);
+			if (ret)
+				return ret;
 
 			sunxi_nfc_hw_ecc_get_prot_oob_bytes(nand, oob, nfc_step,
 							    bbm, page, user_data_sz);
 		}
 	}
 
-	sunxi_nfc_hw_ecc_update_stats(nand, max_bitflips, ret);
+	sunxi_nfc_hw_ecc_update_stats(nand, max_bitflips, bitflips);
 
 	return 0;
 }
@@ -1245,31 +1270,39 @@ static int sunxi_get_ecc_offset(struct sunxi_nand_chip *sunxi_nand,
 		sunxi_nfc_user_data_sz(sunxi_nand, step);
 }
 
-static void sunxi_nfc_hw_ecc_read_extra_oob(struct nand_chip *nand,
-					    u8 *oob, int *cur_off,
-					    bool randomize, int page)
+static int sunxi_nfc_hw_ecc_read_extra_oob(struct nand_chip *nand,
+					   u8 *oob, int *cur_off,
+					   bool randomize, int page)
 {
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
 	int offset = sunxi_get_oob_offset(sunxi_nand, ecc, ecc->steps);
 	int len = mtd->oobsize - offset;
+	int ret;
 
 	if (len <= 0)
-		return;
+		return 0;
 
-	if (!cur_off || *cur_off != (offset + mtd->writesize))
-		nand_change_read_column_op(nand, mtd->writesize + offset,
-					   NULL, 0, false);
+	if (!cur_off || *cur_off != (offset + mtd->writesize)) {
+		ret = nand_change_read_column_op(nand, mtd->writesize + offset,
+						 NULL, 0, false);
+		if (ret)
+			return ret;
+	}
 
 	if (!randomize)
-		sunxi_nfc_read_buf(nand, oob + offset, len);
+		ret = sunxi_nfc_read_buf(nand, oob + offset, len);
 	else
-		sunxi_nfc_randomizer_read_buf(nand, oob + offset, len,
-					      false, page);
+		ret = sunxi_nfc_randomizer_read_buf(nand, oob + offset, len,
+						    false, page);
+	if (ret)
+		return ret;
 
 	if (cur_off)
 		*cur_off = mtd->oobsize + mtd->writesize;
+
+	return 0;
 }
 
 static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, uint8_t *buf,
@@ -1340,21 +1373,24 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, uint8_t *buf
 		u8 *data = buf + data_off;
 		u8 *oob = nand->oob_poi + oob_off;
 		bool erased;
+		int bitflips;
 
-		ret = sunxi_nfc_hw_ecc_correct(nand, randomized ? data : NULL,
-					       oob_required ? oob : NULL,
-					       i, status, pattern_found,
-					       user_data_sz, &erased);
+		bitflips = sunxi_nfc_hw_ecc_correct(nand, randomized ? data : NULL,
+						    oob_required ? oob : NULL,
+						    i, status, pattern_found,
+						    user_data_sz, &erased);
 
 		/* ECC errors are handled in the second loop. */
-		if (ret < 0)
+		if (bitflips < 0)
 			continue;
 
 		if (oob_required && !erased) {
 			/* TODO: use DMA to retrieve OOB */
-			nand_change_read_column_op(nand,
-						   mtd->writesize + oob_off,
-						   oob, ecc->bytes + user_data_sz, false);
+			ret = nand_change_read_column_op(nand, mtd->writesize + oob_off,
+							 oob, ecc->bytes + user_data_sz,
+							 false);
+			if (ret)
+				goto err_stats;
 
 			sunxi_nfc_hw_ecc_get_prot_oob_bytes(nand, oob, i, !i,
 							    page, user_data_sz);
@@ -1363,7 +1399,7 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, uint8_t *buf
 		if (erased)
 			raw_mode = 1;
 
-		sunxi_nfc_hw_ecc_update_stats(nand, &max_bitflips, ret);
+		sunxi_nfc_hw_ecc_update_stats(nand, &max_bitflips, bitflips);
 	}
 
 	if (status & NFC_ECC_ERR_MSK(nfc)) {
@@ -1381,23 +1417,27 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, uint8_t *buf
 							  mtd->writesize + oob_off,
 							  user_data_sz,
 							  &max_bitflips);
-			if (ret < 0) {
-				/* The caller retries the whole read in PIO mode. */
-				mtd->ecc_stats.corrected = corrected;
-				mtd->ecc_stats.failed = failed;
-				return ret;
-			}
+			if (ret < 0)
+				goto err_stats;
 			if (ret)
 				raw_mode = 1;
 		}
 	}
 
-	if (oob_required)
-		sunxi_nfc_hw_ecc_read_extra_oob(nand, nand->oob_poi,
-						NULL, !raw_mode,
-						page);
+	if (oob_required) {
+		ret = sunxi_nfc_hw_ecc_read_extra_oob(nand, nand->oob_poi,
+						      NULL, !raw_mode, page);
+		if (ret)
+			goto err_stats;
+	}
 
 	return max_bitflips;
+
+err_stats:
+	/* The caller retries the whole read in PIO mode. */
+	mtd->ecc_stats.corrected = corrected;
+	mtd->ecc_stats.failed = failed;
+	return ret;
 }
 
 static int sunxi_nfc_hw_ecc_write_chunk(struct nand_chip *nand,
@@ -1415,13 +1455,21 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct nand_chip *nand,
 	/* From the controller point of view, we are at step 0 */
 	const int nfc_step = 0;
 
-	if (data_off != *cur_off)
-		nand_change_write_column_op(nand, data_off, NULL, 0, false);
+	if (data_off != *cur_off) {
+		ret = nand_change_write_column_op(nand, data_off, NULL, 0, false);
+		if (ret)
+			return ret;
+	}
 
-	sunxi_nfc_randomizer_write_buf(nand, data, ecc->size, false, page);
+	ret = sunxi_nfc_randomizer_write_buf(nand, data, ecc->size, false, page);
+	if (ret)
+		return ret;
 
-	if (data_off + ecc->size != oob_off)
-		nand_change_write_column_op(nand, oob_off, NULL, 0, false);
+	if (data_off + ecc->size != oob_off) {
+		ret = nand_change_write_column_op(nand, oob_off, NULL, 0, false);
+		if (ret)
+			return ret;
+	}
 
 	ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
 	if (ret)
@@ -1447,27 +1495,35 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct nand_chip *nand,
 	return 0;
 }
 
-static void sunxi_nfc_hw_ecc_write_extra_oob(struct nand_chip *nand,
-					     u8 *oob, int *cur_off,
-					     int page)
+static int sunxi_nfc_hw_ecc_write_extra_oob(struct nand_chip *nand,
+					    u8 *oob, int *cur_off,
+					    int page)
 {
 	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
 	int offset = sunxi_get_oob_offset(sunxi_nand, ecc, ecc->steps);
 	int len = mtd->oobsize - offset;
+	int ret;
 
 	if (len <= 0)
-		return;
+		return 0;
 
-	if (!cur_off || *cur_off != offset)
-		nand_change_write_column_op(nand, offset + mtd->writesize,
-					    NULL, 0, false);
+	if (!cur_off || *cur_off != offset) {
+		ret = nand_change_write_column_op(nand, offset + mtd->writesize,
+						  NULL, 0, false);
+		if (ret)
+			return ret;
+	}
 
-	sunxi_nfc_randomizer_write_buf(nand, oob + offset, len, false, page);
+	ret = sunxi_nfc_randomizer_write_buf(nand, oob + offset, len, false, page);
+	if (ret)
+		return ret;
 
 	if (cur_off)
 		*cur_off = mtd->oobsize + mtd->writesize;
+
+	return 0;
 }
 
 static int sunxi_nfc_hw_ecc_read_page(struct nand_chip *nand, uint8_t *buf,
@@ -1506,9 +1562,12 @@ static int sunxi_nfc_hw_ecc_read_page(struct nand_chip *nand, uint8_t *buf,
 			raw_mode = true;
 	}
 
-	if (oob_required)
-		sunxi_nfc_hw_ecc_read_extra_oob(nand, nand->oob_poi, &cur_off,
-						!raw_mode, page);
+	if (oob_required) {
+		ret = sunxi_nfc_hw_ecc_read_extra_oob(nand, nand->oob_poi, &cur_off,
+						      !raw_mode, page);
+		if (ret)
+			goto out;
+	}
 
 	ret = max_bitflips;
 out:
@@ -1635,8 +1694,8 @@ static int sunxi_nfc_hw_ecc_write_page(struct nand_chip *nand,
 	}
 
 	if (oob_required || (nand->options & NAND_NEED_SCRAMBLING))
-		sunxi_nfc_hw_ecc_write_extra_oob(nand, nand->oob_poi,
-						 &cur_off, page);
+		ret = sunxi_nfc_hw_ecc_write_extra_oob(nand, nand->oob_poi,
+						       &cur_off, page);
 
 out:
 	sunxi_nfc_hw_ecc_disable(nand);
@@ -1759,10 +1818,13 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct nand_chip *nand,
 	if (ret)
 		return ret;
 
-	if (oob_required || (nand->options & NAND_NEED_SCRAMBLING))
+	if (oob_required || (nand->options & NAND_NEED_SCRAMBLING)) {
 		/* TODO: use DMA to transfer extra OOB bytes ? */
-		sunxi_nfc_hw_ecc_write_extra_oob(nand, nand->oob_poi,
-						 NULL, page);
+		ret = sunxi_nfc_hw_ecc_write_extra_oob(nand, nand->oob_poi,
+						       NULL, page);
+		if (ret)
+			return ret;
+	}
 
 	return nand_prog_page_end_op(nand);
 

-- 
2.53.0

