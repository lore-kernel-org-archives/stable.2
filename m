Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C07332EBB
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 03:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789354903; cv=none; b=hbl3D1oTkr0vbqMY3b6rNBLxQ7bRq72hg/xo7I6e+oQXQPj7dOC10vsNo5aqbZravbaRKC/TLkPESQf1oxNorxQ3qxuqrBZ/MnUZkHBwCfJiQK/Zobok6iwr/TXAzd0QGRmprlo58LUTbtvoon3MfC6M4hKdUdmlpshQcErTd5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789354903; c=relaxed/simple;
	bh=QNBt+pFeHHzCr6qyz6aRzEV+o3fccMFb5SqOxfos0lA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aUQgNbIF8Rnaq3S/pj84zTPqGeCElQcxtl2GzTOYNHGf5N4wVULf422xGRRL18rcud1aJ7lfIZ/7zXJIIGh53YMPl/EdyFTrJK5Vkq+FnoLLqcv/cvePXvEufE97GMlGYenV3Sh6wYzhZM1DKxJnwvptRmRpSY68V9KKBeJkgLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAICENZa; arc=none smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAICENZa"
Received: by mail-oo2-f40.google.com with SMTP id 46e09a7af769-7f4f0d05c12so1160573a34.0
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 20:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789354900; x=1789959700; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z2QJ/YfTCDyKu7jznVj9GPPyAB75HsBI8sl5USMlUvk=;
        b=OAICENZaoz4K0XlI/9aBA/4R/RD9KIJnyHqDRASJd552gvF6fPZczws7IuPc1IrqFN
         VV0r1dUjZFUgKOnyrmjg1bnjeVv1zbONy/0iBWfgh4EliM+VP1h9V9czGMgSAcqLJXgj
         /l6xLzYgA7NUKiWYys11WKreaTYL8zK2bSzIm4Cv69scg5bemO0DJ8KJbN1Ar/G0xOst
         rgnC0ZG7HInJEJWaFyBr9tJxz0NaJePRfi+MjKRmBSgJcy4jUyxRVWS5q5rOouDYI4Qs
         +7c5DA0LqYs+94GZ5VMcaY6PQHgEK9WrUQJIBkg9sLY4PAxSWY+Eb/RvgylXWsK6agkQ
         45pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789354900; x=1789959700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z2QJ/YfTCDyKu7jznVj9GPPyAB75HsBI8sl5USMlUvk=;
        b=d4dJQmMkz5CuY/GXtR2orKH92NvtoQ2BZjSfb8OaYSOYLUPEz4F4Tr2esLvQ7RtaqD
         5uHUdAIiKJ5daBb9vvv834nrEDR5igSIQCCfvA3RckrDgu70HNzmIT2I1h0Iv4p3zHTm
         H9m0h1NZws7rMJMEInRbXqAv3COhoVFx9L+SV2QItO6W998yUw4WWE7FgOW8fiHC8V9j
         Lp78CxRPqgKn0mq0BoBZTBzXSMiV/mwIONQkofFX+aUZ54dLMIbLi9MWIcr7efyWPpUB
         o8YHcNPcg3nrIGYCn3F73aEsu8WTIAfaG8/OTllgf6spkuDC1mWlG1qWAPRf4pFN09pP
         xTgA==
X-Forwarded-Encrypted: i=1; AKwUvBxEY1c2V7USaxCtcNbz+YCYXzYfhToZQKWCtr9HqURNxTjlTyXfl3+InwJujHPQuBxfv273Ulg=@vger.kernel.org
X-Gm-Message-State: AFuF++nJCw2MfWHt+34xuPffkx9U4qs2EZkd7WeHAR8HoLQ8NEIatdi3
	DAl8PihBXeX2pNWIuETzsHJt2J5AW/JtJwI39tf4uk/3WH7McDIdiqfF
X-Gm-Gg: AYBFou2X8t674CDF228jdDpMmBjYnm0sDGH6rZn55998Co9iUOKqCjLGaTmvYcTOuyu
	jxEQX7Mdo1k2pCiroFdFYFaaHBcPgBl+y5sGX26aUOVuTbfbmEoUvimpNXQkkM9LDjw6UYx7L0K
	dJf0fU34GfbLAR2wNjSkCnLL1JzO6NueWdQPpDxFuTl+2tXMYuvJI9AP52i4BPianMXAp5Oqmss
	e6CUmwtwNrKWgBuITVGdcRcAgpFEHhBIIt+W5TaXvka4Fqs4+jFDDXir7YiaBCcBhtPpsOz1wmW
	uoLwCWbV8IBamS2wqcOQCCwM9okBkT7aqLyUjdgct7sjOSGbOx6+erPv5qFYnegsVQHT3kQnsBT
	tGcWWlh642RlKd7TVCZkUgNXtCjkn8uFqcTeMCopUMluuSbG3M8FQgOoq1NU5VMJry1N2LYIBYj
	E6Ox/mF1dbjuO+ZLAOTCzTHM3CHVidg+RhkhALy34KQhUteFcvdYr9xvclOHsHpZOHQosAwF7To
	aFDn/9POaCUsboL3d2Dvo/XSdZxpz2dzIRwHfwThJ/8ZzsO7+YjZnMbz3UT1e8QaOgvnVbEbJ3e
	7EG5BGYqspcfIPU3MxZhb23LflPCC5jyoXR2z2gchcftHaupIO/Vp2n4d7/gWyTafb2UwElKNbX
	dK+rD2ke/Sw0Hck6paI1YYYM9KQ/h77E=
X-Received: by 2002:a05:6830:3892:b0:7f8:4ac8:bd2a with SMTP id 46e09a7af769-80899a529a4mr493322a34.12.1789354899758;
        Sun, 13 Sep 2026 20:01:39 -0700 (PDT)
Received: from [127.0.1.1] (184-96-157-145.hlrn.qwest.net. [184.96.157.145])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f60feba1sm10619014a34.13.2026.09.13.20.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 20:01:39 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 13 Sep 2026 21:01:08 -0600
Subject: [PATCH v5 02/18] mtd: rawnand: sunxi: use the logical step's OOB
 length in PIO
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-submit-sunxi-nand-vendor-oob-layout-v1-v5-2-7d711076a6f7@gmail.com>
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

PIO transfers always use hardware ECC slot zero, even when transferring a
later logical step. The user-data length programmed into that slot can
differ from the first step's length on H6/H616 controllers.

The ECC correction and protected-OOB write helpers instead derive the
length from the hardware slot. Pattern handling can consequently fill
beyond the current step's OOB region, including beyond the page's OOB
buffer for its last step. Writes can also fetch bytes outside the current
step's protected user data.

Pass the logical step's user-data length to both helpers, as the protected
OOB read helper already does. Keep the hardware slot for register access.
DMA callers pass their existing per-step length, without changing the
on-flash layout.

Fixes: 54dcd6aa69db ("mtd: rawnand: sunxi: introduce maximize variable user data length")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index e50cf5b6a730..172c7c4b0ba6 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1011,11 +1011,11 @@ static void sunxi_nfc_set_user_data_len(struct sunxi_nfc *nfc,
 
 static void sunxi_nfc_hw_ecc_set_prot_oob_bytes(struct nand_chip *nand,
 						const u8 *oob, int step,
-						bool bbm, int page)
+						bool bbm, int page,
+						unsigned int user_data_sz)
 {
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
-	unsigned int user_data_sz = sunxi_nfc_user_data_sz(sunxi_nand, step);
 	u8 user_data[SUNXI_NFC_MAX_USER_DATA_SZ] = {};
 
 	/* Randomize the Bad Block Marker. */
@@ -1069,11 +1069,9 @@ static void sunxi_nfc_hw_ecc_update_stats(struct nand_chip *nand,
 
 static int sunxi_nfc_hw_ecc_correct(struct nand_chip *nand, u8 *data, u8 *oob,
 				    int step, u32 status, u32 pattern_found,
-				    bool *erased)
+				    unsigned int user_data_sz, bool *erased)
 {
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
-	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
-	unsigned int user_data_sz = sunxi_nfc_user_data_sz(sunxi_nand, step);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
 	u32 tmp;
 
@@ -1155,7 +1153,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 
 	ret = sunxi_nfc_hw_ecc_correct(nand, data, oob_required ? oob : NULL,
 				       nfc_step, readl(nfc->regs + NFC_REG_ECC_ST),
-				       pattern_found, &erased);
+				       pattern_found, user_data_sz, &erased);
 	if (erased)
 		return 1;
 
@@ -1323,7 +1321,7 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, uint8_t *buf
 		ret = sunxi_nfc_hw_ecc_correct(nand, randomized ? data : NULL,
 					       oob_required ? oob : NULL,
 					       i, status, pattern_found,
-					       &erased);
+					       user_data_sz, &erased);
 
 		/* ECC errors are handled in the second loop. */
 		if (ret < 0)
@@ -1420,7 +1418,8 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct nand_chip *nand,
 	sunxi_nfc_randomizer_config(nand, page, false);
 	sunxi_nfc_randomizer_enable(nand);
 	sunxi_nfc_set_user_data_len(nfc, user_data_sz, nfc_step);
-	sunxi_nfc_hw_ecc_set_prot_oob_bytes(nand, oob, nfc_step, bbm, page);
+	sunxi_nfc_hw_ecc_set_prot_oob_bytes(nand, oob, nfc_step, bbm, page,
+					    user_data_sz);
 
 	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD |
 	       NFC_ACCESS_DIR | NFC_ECC_OP,
@@ -1684,7 +1683,8 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct nand_chip *nand,
 		int oob_off = sunxi_get_oob_offset(sunxi_nand, ecc, i);
 		const u8 *oob = nand->oob_poi + oob_off;
 
-		sunxi_nfc_hw_ecc_set_prot_oob_bytes(nand, oob, i, !i, page);
+		sunxi_nfc_hw_ecc_set_prot_oob_bytes(nand, oob, i, !i, page,
+						    user_data_sz);
 		sunxi_nfc_set_user_data_len(nfc, user_data_sz, i);
 	}
 

-- 
2.53.0

