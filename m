Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B012345740
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 03:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789354911; cv=none; b=N7E+I/ahlA2G8M2YQZs3C97jnwbo0/Lval3uBpsX267nnZdikCgSFSmYDlxjga6EnkhVL6Vcdjiy1yjDxY76CGXDetBnXwv19phTc5QSzLbKFUeTFkSQ4WT/H3dFOpVGa1pcRss+DjVlGnEa+zHY6H+H20q1gHIzgh3oK5Qk0RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789354911; c=relaxed/simple;
	bh=ovOsliEdUhvhRoeaXGSGPM3LycBRMZNPRXeHkTBG1HM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tigYZ4WgkB1OettC9Wlnd+v0jNdinWMw4GKg2tMeB//MGG1jwjxOn5DITvEcTFag/l5tjyNxHCHOacxURGUa45I1Vn7G7eESNS/O85gdIRVSjC8qKDwDVzfATnMTLxUWg5s2Utua+5sv0k+s+ISEUGkKaYJgOEUSIVjeLpyuWFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rwR7hW9m; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwR7hW9m"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-8050801d337so1103208a34.2
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 20:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789354908; x=1789959708; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b70jsSBwLMejAy7LligcsivCdZpJr/KiRJCHlaFZ8JI=;
        b=rwR7hW9mIvGADlnH8wTrvjByc14LhkUwac6f06ukK1bpURHR+B8+1+HG40klkTftan
         uYfzALM4aX3HcWJOiw3nlcc23/GzlQhyisWcstzBsBOIAXuOP0PEfN6/REEw5sD8vMOZ
         Bzz2qEmng58Xcgi49e0yVxjM3G788g6UMyj+MeZNDzIILZn9Ld7RMRiCtCqvwhLY/JSB
         AcWKdOM/3hU+wquQWrofI1GaK9aszcOgQad8vVS4r3tgr4fXc9JD5GsdaaAEgnImXDqY
         6RQOPbsm/8d/rYVmObuq8C9jnW9q+DhW5Xp/XLY707k7uK/AnN+DV8VNHxG37WQr2jrH
         KgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789354908; x=1789959708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b70jsSBwLMejAy7LligcsivCdZpJr/KiRJCHlaFZ8JI=;
        b=pPG76OnsLM46Etoc7sk7xlNSoGgGHGvYr25X2QUPeD+Cy+3SXQYehBBprGCFzjoAWS
         lzsXeWrqNcX3TN1zsVEdVpsc9o0FO7b+dlbtZeq1JLZ9Cx1NYLav3JRFmr4E/8yaYMZ6
         /gB7Q4Sq9GrLk40lZ0zl+hREh9ZYIgd0D09LJWKR95ulAz4ILpRizYq2iESh5/jEyjEn
         yjrcp/GnWGBuqCLnxRWVJ/jWuUwkT0MNgkGHlqJN134qoI2tFO5WaltEl3bJVYO1pf1r
         PXkAXyfRF7l/Lbf76usRPrnkoEd9zWcvaua42aMdZwZmGJC9cgZOhn+Xe7BXU2j0l5M3
         x0BA==
X-Forwarded-Encrypted: i=1; AKwUvBy2q1nkjizW1M2gY9VxPgaxVh/cd7OwUyzIpiJHL6vUz4mMEZRGRSoaoBFgpZoNuazF+pyJxcc=@vger.kernel.org
X-Gm-Message-State: AFuF++nXTyHDolliV5h2fkGVOvYvozRQ0HOri+xQUrKSY1eHTcX4tkiU
	3KHCn+q5xuHxya3g7Zfw0bSbX8YNYIVNZPo7wIT4MTR79YP6xiGBDBy0
X-Gm-Gg: AYBFou3uCOFYuH0monDIegCeeJY2FJcqI+E3OZvQjZU2tSPoA0wkv/P2aIv51oFW7B0
	86I/b3ON2vPSeYqY66XfcEtrY4TjxkaydN55dBzzaJN2K9B8nOAEElBsNuUTPm/uMrdQnZfnbgS
	8GwgLdBaNrOVE7zFPLUgmKmXAVOFsM04PBPhS/YQGzImzzDkzsHdi2y9dfj9yrao7JdI5kA9M+t
	zt+93SK9eYyLEpQDW4NzyAEiuYmoEcR4EHJJ8OJ6vqlR6XrtYZgm7ek8hZ0KhODY8jmyHPnghGq
	gZgRbO4ENW2tifJu8N87p9OkSvN1o+RTJlx2DYTIa+nHS0OMb3I69DrW2gJnnpL87A2/D5QJH05
	OgILjDBTcRkesCiPsL5cF/tL6Hmx8kEIaanHDsfp2AQpW5zmPMJFcZjCfJfqlXZvt98OZK+WmIN
	pgcA4PtzivRRkT8Kvj+uPaG33aA9IyQewtvf7oAkad48InM01vuN83HQSbqvRfSCTaWzXGLog7s
	fBZjPPR8Pf2Ac1rDa1DCSp5GDstARdP7oWycIogVWwKyYBQsL0DGjV/jQM8p/zKp0vmHr/BF0ip
	ECZ8EUwzR1UJ1iU643X7/oiRyDlBd5kkxtY9h3R4uAR1g7Jl89lJUggBtDMStjnhQWkxUaMp4QB
	n9u+D/1aUsWEQqx1Nx2JkHorGxGPwrg==
X-Received: by 2002:a05:6830:4c18:b0:7f7:f55a:4bcc with SMTP id 46e09a7af769-80897c868f2mr541126a34.8.1789354908010;
        Sun, 13 Sep 2026 20:01:48 -0700 (PDT)
Received: from [127.0.1.1] (184-96-157-145.hlrn.qwest.net. [184.96.157.145])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f60feba1sm10619014a34.13.2026.09.13.20.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 20:01:47 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 13 Sep 2026 21:01:13 -0600
Subject: [PATCH v5 07/18] mtd: rawnand: sunxi: avoid a second program
 confirm for OOB writes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-submit-sunxi-nand-vendor-oob-layout-v1-v5-7-7d711076a6f7@gmail.com>
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

