Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF5733DED9
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 03:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789354908; cv=none; b=ZA2RbCa7bRd7zcxGSEoZfInIKaHOneVkGCkgs5WJx1F5MwbhbvZw457j26aJZm8Nn5mKfkH/V5Nae6eGcCUgGh86Nvv62niyjpJmAXwLJ4UzW5O628stxIIoQUcntJ4rBB8QbYEGsH0K6/IXThMzhCYtTyqOU6eI953UYcwQEDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789354908; c=relaxed/simple;
	bh=NlWMHvWo8eC8a5062ul0UGSwTs8Firq1Hsg3xcZzp2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XlpUIcK9ZDmZBtD0hlGswEts/lAipNeKIYvwg0FvnY/X9QETYYVhb2mnh+eWnlvv/c6TAaVUH5wNM78Nlqm7A1o7PvDsVAbOuj2WfcOfzosoy/q3lcwa7pY2aMcD+9J+Bl60BqQ/kc+KC5HF6ujCEvdoyq/waOo6AN9EMTFywJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSOS9ipV; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSOS9ipV"
Received: by mail-oo2-f41.google.com with SMTP id 46e09a7af769-7fccd4c3f36so1513228a34.3
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 20:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789354903; x=1789959703; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o8noBZbj7C7U90sjdVnrOExXAG4fUCSDlE1zY+ZGE34=;
        b=GSOS9ipVsEkoWjZwrv4Y7Z/wqjFeIMJ14k4zhVlTUwlhCjW+GUWwXbbLQLkqK+jCJt
         xu+HfbM12yhTxmsSzrMDop//Vgs5QIobkOJiA9OUcu577xBbxJ0KQAGBZ153dijUrDZ0
         B2JDz2a3Jk/fhX0eLhCIbPUaZjTGhGcB/9wOnpECEPv5AE6f4HlcIH9kixmZopCAEFyt
         6RojfNE0tmdl3Q/40Ebv/07dhVXf3hJ+04U3jl15iYY7FvwgzZNoXGLzZBgEoV9vYJtl
         YVn++5JAiryUwIVQOQ7dKa7HMXTo4a1KtSHEF6BTpbKRaaM1my2oMOae6ogpAMrm4GRC
         cCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789354903; x=1789959703;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o8noBZbj7C7U90sjdVnrOExXAG4fUCSDlE1zY+ZGE34=;
        b=jTK4BYuwwb6sb+JPbjB9LXqEwaVImSdTX0xK0XrazJM4a0IJ40i4cH65NgWdG4Bm1l
         mSfXEtMKNjD1F59jeRn09umWoYuxkxyZeHLbm3wB4epfmIOlgkE4hx4ERHReC4pncGbK
         dpu2jRwWaIWvMmgJUIGurJjDGSCnlRXpb5lognR0D4DOvSSF4YZt6tBEIYMOTBSZauyW
         U28Waz9iVd5sQWD4o3scKyvmpeRBK1v1QhVTZLN6PZj5+Wc9fgL5e1v/NZZzbl0M9Xl3
         U0ty3L1QpIxmBpPzwWs6fUGN/HlT5VsAOvjpWb4Fm/dKvhZkSyQcKg4GS0GM3hbHd0GS
         zOww==
X-Forwarded-Encrypted: i=1; AKwUvBwWxLT9vX5b5UsnDNPy+SQYwc9GdpbcbCig1t21i4/vHFVv3AFIQ6evHf06ee4Kc1+4JdrkIrw=@vger.kernel.org
X-Gm-Message-State: AFuF++kx7+m0hZ5l+XjtRigryacHs41tSFgV1rCak7/gomSDvxPGjC1D
	47LspYV3bfyQGqo0b3stvuJuos1NHHt3SaJbAbCKVobHj2AxkwpeUhPf
X-Gm-Gg: AYBFou0AKDKR0SfbrdfczVbPkooTYWVD3V/iHGoL1b83MdtszbWHKQwuBA/t5HOX8SY
	cLWg5qoMSwx/tpuRed0SuCqzuFjh0pHLe8GkTsxnOk2yJ6Y2DwvQeETfHSYsGKUN3wf/dMravki
	0TCPyDav7M5rF5uKoDfumu/yBFv7GnO9/0Ftxm5b+3bCGeKKYQlZrs0DpxAefCTnuf+qj5sZIk1
	UH/eroa8e217okw4Sh4R8e7zYxq1siMTCRbvlXhNbmeVQFYhY5M/cfjD7/+8Vd5tzLh0VCFdHEL
	K+dYxmmsVFBQh3xUVacLGDqyOCl0aflpilTLkfJ75mNCxglP7jtP/wE2Vmshbhzen2uGcpvwS3E
	+dfklyLQoCWXVUoucO0g0W4UnhPpBHYLHblaz5rY1PBxQLMGraxbjYDC8vmNKHbP1yumWOPvaQn
	nbbo8UogYUTrcgq17EeHDwWcjLABlxzui+H+BXkY7C7EALS12JIIoaxSVx80D5yTE6f/00n5XlV
	6PzA3hm+nswSqDHG9ekLk9FXof4b5KLTZXDk4I1Bcl1hvFh51egb4EajbFQvR+J1bMtXMFYG7Wi
	PemVXFyKCy7ZXp9oG/K+EXwqtXJO5G8Jxxwp8wBAlt3sQaoa8RVmN1FgaorxKKxh1R/IXRnjGfF
	0wcbveBRLa6RjLHjAdukf6XwpusPjuA==
X-Received: by 2002:a05:6830:3894:b0:805:9f8b:bef8 with SMTP id 46e09a7af769-8089974baa0mr554382a34.14.1789354902809;
        Sun, 13 Sep 2026 20:01:42 -0700 (PDT)
Received: from [127.0.1.1] (184-96-157-145.hlrn.qwest.net. [184.96.157.145])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f60feba1sm10619014a34.13.2026.09.13.20.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 20:01:42 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 13 Sep 2026 21:01:10 -0600
Subject: [PATCH v5 04/18] mtd: rawnand: sunxi: stop failed program
 operations and disable ECC
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-submit-sunxi-nand-vendor-oob-layout-v1-v5-4-7d711076a6f7@gmail.com>
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

The PIO page and subpage write callbacks leave ECC enabled if a chunk
transfer fails. They also ignore program-setup errors, as does the DMA
page writer, and can continue transferring data and issuing PAGEPROG
after the setup command has failed.

Check program setup before enabling ECC or transferring data. If DMA
preparation has already succeeded, abort the queued operation and unmap
its buffer before returning the setup error.

Route PIO chunk failures through ECC disable and return the original
error. Issue the program-end command only after the transfers succeed,
preserving the existing successful-write sequence.

Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller support")
Fixes: 25f815f66a14 ("mtd: nand: force drivers to explicitly send READ/PROG commands")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index d5d8d383b6d1..5d88ad3b8f70 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1610,11 +1610,13 @@ static int sunxi_nfc_hw_ecc_write_page(struct nand_chip *nand,
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
-	int ret, i, cur_off = 0;
+	int ret = 0, i, cur_off = 0;
 
 	sunxi_nfc_select_chip(nand, nand->cur_cs);
 
-	nand_prog_page_begin_op(nand, page, 0, NULL, 0);
+	ret = nand_prog_page_begin_op(nand, page, 0, NULL, 0);
+	if (ret)
+		return ret;
 
 	sunxi_nfc_hw_ecc_enable(nand);
 
@@ -1629,14 +1631,17 @@ static int sunxi_nfc_hw_ecc_write_page(struct nand_chip *nand,
 						   oob_off + mtd->writesize,
 						   &cur_off, i, page);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	if (oob_required || (nand->options & NAND_NEED_SCRAMBLING))
 		sunxi_nfc_hw_ecc_write_extra_oob(nand, nand->oob_poi,
 						 &cur_off, page);
 
+out:
 	sunxi_nfc_hw_ecc_disable(nand);
+	if (ret)
+		return ret;
 
 	return nand_prog_page_end_op(nand);
 }
@@ -1650,11 +1655,13 @@ static int sunxi_nfc_hw_ecc_write_subpage(struct nand_chip *nand,
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
-	int ret, i, cur_off = 0;
+	int ret = 0, i, cur_off = 0;
 
 	sunxi_nfc_select_chip(nand, nand->cur_cs);
 
-	nand_prog_page_begin_op(nand, page, 0, NULL, 0);
+	ret = nand_prog_page_begin_op(nand, page, 0, NULL, 0);
+	if (ret)
+		return ret;
 
 	sunxi_nfc_hw_ecc_enable(nand);
 
@@ -1670,10 +1677,13 @@ static int sunxi_nfc_hw_ecc_write_subpage(struct nand_chip *nand,
 						   oob_off + mtd->writesize,
 						   &cur_off, i, page);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
+out:
 	sunxi_nfc_hw_ecc_disable(nand);
+	if (ret)
+		return ret;
 
 	return nand_prog_page_end_op(nand);
 }
@@ -1712,7 +1722,12 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct nand_chip *nand,
 		sunxi_nfc_set_user_data_len(nfc, user_data_sz, i);
 	}
 
-	nand_prog_page_begin_op(nand, page, 0, NULL, 0);
+	ret = nand_prog_page_begin_op(nand, page, 0, NULL, 0);
+	if (ret) {
+		sunxi_nfc_dma_op_abort(nfc);
+		sunxi_nfc_dma_op_cleanup(nfc, DMA_TO_DEVICE, &sg);
+		return ret;
+	}
 
 	sunxi_nfc_hw_ecc_enable(nand);
 	sunxi_nfc_randomizer_config(nand, page, false);

-- 
2.53.0

