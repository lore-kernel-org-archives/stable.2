Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D424A0F0F
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 21:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420212; cv=none; b=dRzfCJPv3DAuMM7cpOpX4mz3vDkLnvIWhF31CkDdgm6IigzVxByQ6YuS8rWpgNwYMu5z6sLpM1yKxDk4IxD8sjmVD8475oZfVxnQ01CG2N6rHCIdvAonN0JCdnJdElKWW5elDjfMf/GdeiBGOndvVAen/BiXEMM18YErIEOJT2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420212; c=relaxed/simple;
	bh=ovOsliEdUhvhRoeaXGSGPM3LycBRMZNPRXeHkTBG1HM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QGozeuqsTw0Q3Sz2AMXT2VodRRu5oX7yy/RV5XEpWXNxE6RRR9GFgAvWBdzT8FSScnYwD5aRpQ4whkQLROOhJtvW4na5ULmz7tKbQtioNtRMHVb6whyU8Mowu6df5qPT8idRTz3MmIJjQyywR+OgrQtT1o6RBGNlrfXjvwKzB1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OML/24vV; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OML/24vV"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a3ed714so1543460b6e.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 14:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789420205; x=1790025005; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b70jsSBwLMejAy7LligcsivCdZpJr/KiRJCHlaFZ8JI=;
        b=OML/24vVZv7p98bMsaWSMckNEo8krsuDwaP3JaMi7Rk/boUDNRGM1eBeZS5QG/85ne
         zMslfwYd4FmRsarS6mSaT9zhS5Wi1b3q2ixkTzxyNGuJmDFSisM1ja/jEj2e5x71P/P9
         SI3tK2vC1mW87wHJtGRiOXc3YuFluFz28ZbV2NvbP1kmNqONUs286hk+V4OUQVBIApFk
         BUyBjPY8KndVfPCvysDfGTsogC9gNflskOTQp/k3W+Ei+P+Wb4AD0wLQMgWnKEtOrLML
         bPtRa7eYPpXrMyQj1EM5HbhBkwCPq7qS7l0O39A3vkRyyfQm5stZkaoRjo5PMKl63fuV
         c1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789420205; x=1790025005;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b70jsSBwLMejAy7LligcsivCdZpJr/KiRJCHlaFZ8JI=;
        b=HN//lehDCJjZexBGg/EmlqMyjEA2IKL5rhVbt0GUKWIr04nejXHRjCJEMpNEtR/zj2
         IHr7q8MAScnzq3uR7NyoMffSE1YXmhoAKSP5ejcIF/n95jD8nOPAbcF5GzaWiFJYjDMB
         YseY4OE7GbpVBEH2k49faA9gqtEgHGL/ilMc5yn05NhzNpB7zU34V7yC6rMQvHYpjtUw
         TodiCgMMxlcy2mMKVBhY4OUzQrWlpD7FhVPoE0kzEXhw/kQpChx6V52/WMrGLnerRKFF
         RdBCIjI6IHhxenUKt5h6B632mHMVEX3SJSc5n+MAzfUF8uxd0DCXz9any6d+myKHViFg
         Plzw==
X-Forwarded-Encrypted: i=1; AKwUvByIazgUpypEFzfbehRM5Tsa10UmQBGB+TbqSqdJt2VOVQ+dOvaEB4RQ9Rl4kRoaxWHAwDU3W6k=@vger.kernel.org
X-Gm-Message-State: AFuF++mZJmOSQOvOKgnkoYg/U2zeLE1Pj82d/1bA/T0Nfm8w66sE3C96
	vs1KW7Uqt0sQ4HMc0Lf69tKjH2ccjES/T0CYOJoYlfY7FfRY0vX/ESN7
X-Gm-Gg: AYBFou2WzqAPntYAO05vrs46ZnC2/32lwgfOm2zSz94D4mq7+oLOHDGrNaEc0vAAlbP
	ZwRAQx5Dx9P5mQET/VqESFurEhVDs50JTkWd2KIK4xO2sfXt086ClRG2N8StJ2Q+F7AahHF1mCS
	PPaHeT3RJovUu6OLhRtP5vBN0DQgbLz0eNZvVkRlR/BeUJsYWADqpOrjY1h+MP2Ds+xUvDNgX+A
	vbur+pXTchy0n0BtGWpyz654bi0bMaz48I/Xu5nKg+BRu7xPomAXouw+U4TcPr09UjISVSEQvNm
	0unNbiQst0qUw5dB9jNAO0CdoWZH9h+Laov6x/b9UYW2YZP45nyFNdletFTHpfp4pmnjd5SNJQf
	d02OgEqVC16KYCAS4UijEy+BCQAgRNeLR0lHdLjA5bcgSlJnMOe4QMVAwIGFRQlgxMOquOqoSQl
	f0qFUadDAjInMj/Se60dDY2quVhMmNbDIloZGXGWOjspi5FH+ndRDomMOnBeqCDUbgg9bdOVebN
	/ujpqiNMYqKQXqMDMJiVsP8yURRawp4fxeOyb3BgiUkxKKztyILReMUROa0eiUzqv7oa6Niwtgb
	63BJSG/hpAHlt9apPwKTz7aqbXKX0BmEtWDm2KCNHOIv3hrxbSwZxkqLORDbS+TU3K/pMwPcq9e
	Igsct17+AULhw3I6MAts50LEJf8Nh
X-Received: by 2002:a05:6820:1626:b0:6b6:93d6:afcd with SMTP id 006d021491bc7-6c540b66d8bmr2665520eaf.26.1789420204843;
        Mon, 14 Sep 2026 14:10:04 -0700 (PDT)
Received: from [127.0.1.1] (184-96-157-145.hlrn.qwest.net. [184.96.157.145])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c45bfc3fe9sm4698544eaf.15.2026.09.14.14.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 14:10:04 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 14 Sep 2026 15:09:53 -0600
Subject: [PATCH v6 07/18] mtd: rawnand: sunxi: avoid a second program
 confirm for OOB writes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-submit-sunxi-nand-vendor-oob-layout-v1-v6-7-2fb084fe0751@gmail.com>
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

The hardware-ECC OOB writer delegates to the page writer, which already
issues PAGEPROG, waits for completion and checks the NAND status. The OOB
wrapper then calls nand_prog_page_end_op() again, sending an extra program
confirm without a corresponding program setup. An error on this redundant
operation is returned even though the page writer has already succeeded.

Return the page writer's result directly. This leaves both PIO and DMA
responsible for completing their own program operation and preserves their
error results, including for bad-block-marker writes.

Fixes: 25f815f66a14 ("mtd: nand: force drivers to explicitly send READ/PROG commands")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 72b79f893e29..41d6560d7df7 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1843,15 +1843,10 @@ static int sunxi_nfc_hw_ecc_write_oob(struct nand_chip *nand, int page)
 {
 	struct mtd_info *mtd = nand_to_mtd(nand);
 	u8 *buf = nand_get_data_buf(nand);
-	int ret;
 
 	memset(buf, 0xff, mtd->writesize);
-	ret = nand->ecc.write_page(nand, buf, 1, page);
-	if (ret)
-		return ret;
 
-	/* Send command to program the OOB data */
-	return nand_prog_page_end_op(nand);
+	return nand->ecc.write_page(nand, buf, 1, page);
 }
 
 static const struct sunxi_nfc_timings sun4i_a10_nfc_timings = {

-- 
2.53.0

