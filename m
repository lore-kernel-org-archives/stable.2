Received: from mail-oo2-f16.google.com (mail-oo2-f16.google.com [74.125.231.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5664963C3
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420203; cv=none; b=rMWI2z7nZOfkKIkbh+jERJlmIift5N27E/G1urWgjXWm7eGCIktaEUEfilHVl9Ipsg2Ae1wRFavvbMebBbOWy6VVMkamljZuv4oG413dxAKmX69Z4Dqk08395KLWkVAnZYUfs51zzHENnvmiQ9XiHKr8tglL8JmEzL4zIPzYvBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420203; c=relaxed/simple;
	bh=QNBt+pFeHHzCr6qyz6aRzEV+o3fccMFb5SqOxfos0lA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jERwC2Ne6bZ/quhMsd6QQeIixdvKFex2qs+LnPY+l1Esu75w+ghULcQKz5TQoZ0nRIUa53VFqWcwHLZT9S3urSHDP5PRWyL/LUXUwzJPeOjpNIYy6akUyVjTgwysHRT96HYoz9eyqj7zlW1bbLDw/fKjBumHZJjzR21DfkWwjQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ozvgo8/9; arc=none smtp.client-ip=74.125.231.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozvgo8/9"
Received: by mail-oo2-f16.google.com with SMTP id 46e09a7af769-805bf8c2661so1711371a34.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 14:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789420198; x=1790024998; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z2QJ/YfTCDyKu7jznVj9GPPyAB75HsBI8sl5USMlUvk=;
        b=ozvgo8/97agg2f1pieCOMOFS3cyzv5+2CQ9bwTeqh7vDYNxYf5xo7fTZCoEH4eyZkc
         26ZF3+Z4efP5Q8DLAvi1S5teGYgdtJkbXfF3zqmaNYXW+bE9iucmcZxpvBLCEIymtb5E
         gL2bfwtUF1Z7mUpvylcCe8/WEOGzN2JZLJChQmO78rTVwpZlQuskKEA7++yPeX4JwKcA
         0ah/JaSZc6OGfkHhcnKpH6RspBJiY1rFKaGvHdqyR4Ru9Fe5QYhRds1uQYnbx9wIKRK3
         RlPsMQ9ECiHfpLXwwNUXL92jOVLYGe6GDSKD9kQ714t9LkhVHC5BbyN+o3b9SmU0Bt1H
         9ENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789420198; x=1790024998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z2QJ/YfTCDyKu7jznVj9GPPyAB75HsBI8sl5USMlUvk=;
        b=XP6TSVQqj5dM8VS8QQ3a+a9EbBBnmwSY/k3bNT5WwvvZmswk6/SQTPCvb853+QIMGS
         ZcunkCC1fA8DlLZN+j/XifplXFHtACCNAUXtcdzd4UlY7j+/VbfnBLLCHRJKlQc/A+BQ
         07aTZ07AuEkb2OuFDLmD+FjbErZQki6rZlMJyJ9Rhylu8iO1MhpkYdw+xOYUk2xCoYe0
         S+lxJdeWocXU65yLBLE8NB7M4EOPUmnAu1aXWLnLQXDt7Diaz2xxOMffRRlEghety7Nb
         9az1kKhMGGfYuqvAf2kocIdI4M7kQIUej4XRWhjuSQqI3b0wPXa6eXc08ru33K7+q/wk
         0X6w==
X-Forwarded-Encrypted: i=1; AKwUvBxoO33qwl1B+cR+vvEZnsOvHIkDMBjT70Cp/JT+Pe43JWMBYQBIr6VpcOwf/Y9PmstsD4mJ3ms=@vger.kernel.org
X-Gm-Message-State: AFuF++mzciKR62aciVBrWLgtMdg8xL3kvEiDEAOmMkX3/NHRTkRTwNMl
	617NvGUZHEJF0HCsc+TOxsRpx7E0bI5V7U1k4W9Bu51BSrt4uSZE5stt
X-Gm-Gg: AYBFou2O4YKynszrVnO9JK253mVa5HoLN5l0QFYwpQ1h6D0v1t5A2VszKm5BxTUVb92
	m/UxPIEZb0yZzXKmU9AEXCySe4dMNsHDOQnPvDv99jarseopYcTAcHPslobxsC/sYAnA+TL50wh
	n+lBuiUDpzr20B6Y7O1+COG0T2hu4w8bDyjWei/ZadC5LH64VByjoq/dwKZskr/kwganJ6AVFgN
	gUdTocUzQREPcdZyYJrYAoUWNxfMnk5ZKtjKoKfMqezVhhvFOX2cGa0ytVCrIDOvbvDLHuWBKZT
	5P6Afk1B225G4p+eh7QO37Uo7x94pFhE8gZ8qJ0rtkgv3UrrL1tg1d+J4SGX9sqXeQzHrczg1y+
	EixBT7f2Yg+DoUJl399o7DJuuP4ax/DGwQh45HjZJmwsVXwTzQ18YbHHX4+jaTO9qW4Nq3dkV23
	iUuJpHWP3D2khuPv4A7oa2W27mrEdPrrAb2kdqfwy5NGWWTeVskHZfQeOPYNRo+MeQgK04V7p9O
	725z/+LaPXKZ9Qz5H9084zuaOnz0C9TQgs6hDtgC7J5dmdaeb+J0EWvsghqerULh4PY/9mHoi2l
	5iiRR8N87iZNh1c/9aPE8dRpsx2EqsUA0kekWLYzzhyHkdCWytg5Qiif0wP+tp57LgEsKOvdYk1
	SZ78qp1FoXuQm3MaZVT7pSjXoegfO
X-Received: by 2002:a05:6820:98e:b0:6c1:c628:b0bf with SMTP id 006d021491bc7-6c53f44bc19mr2434309eaf.13.1789420197732;
        Mon, 14 Sep 2026 14:09:57 -0700 (PDT)
Received: from [127.0.1.1] (184-96-157-145.hlrn.qwest.net. [184.96.157.145])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c45bfc3fe9sm4698544eaf.15.2026.09.14.14.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 14:09:57 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 14 Sep 2026 15:09:48 -0600
Subject: [PATCH v6 02/18] mtd: rawnand: sunxi: use the logical step's OOB
 length in PIO
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-submit-sunxi-nand-vendor-oob-layout-v1-v6-2-2fb084fe0751@gmail.com>
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

