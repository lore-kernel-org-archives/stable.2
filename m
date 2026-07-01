Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374DA363C50
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 02:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782873907; cv=none; b=LOrpRAVz6/NEwyNMFjU4IrMIMEUDRejMVa9VmeHxOOGsosRCzkAwOEZbh+AS9/eOIjPU78DyAJ9XH1lhO6tIAXPgdW8IgT6EN2zonoKMV75h4MDIx7VrOzfu/XU4ylGsCINlbBUwCKI2tGtC0uUXwLj1yz81oxhOaDCMpiUhfm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782873907; c=relaxed/simple;
	bh=7AUf/dQ60ZUC10Vl9hsxxT4uc9WrQwe3UEf1UqLr0wY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o18njS3knJtXukfh7scIkOpHh1mvjWPq/YSU7xUK23AP9DZBGpM76JuZobTUhYoSd7Vd5B4qfOgdH1nQTmIedc5VTShDvgWyAyuwbDNv096QBAi4EvZsebxzLgvTksPHyNDEB9CyigQyGLEE/DhR0t77wfpo5d9Ri9z9U41N1u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djkGsmFP; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djkGsmFP"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso140442b3a.2
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 19:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782873905; x=1783478705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+OPd1GHODOckXDuq1kdFib8UHAUD5MfQDAIu/WdnbLI=;
        b=djkGsmFP89aSY4BoXyf3nxtWGdVk3WtKIeQpNFWauRemCrvBbWhdGofi3fo0VBn+Vv
         A5LXFACW6RQ9G5nzUmdA5Fcx5IKcRsF0f7y8rfAoFjIJXo5pyfE/n193pvxp9Wmc5Y2P
         5Cp5uoLu5q2R0ilW77V5wQyEBH0s0iV+YT9Qwn57Qq3zbXl8DxtIHmHcw8FLSVeDHIKD
         zKiBGeWkpu9IylrAjQv4AgHIxN+5AkuV6x9P14t5zjlGKext9dw7bTo0ZDm8361lMxSt
         std/WHIAeK1pCYbXXBj+j1oAbXGuZgpcOIT9PxfznHnPkp/DsCZ2y9QPSBhphmnQiWHY
         8ueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782873905; x=1783478705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OPd1GHODOckXDuq1kdFib8UHAUD5MfQDAIu/WdnbLI=;
        b=Jp90QRqcyZV+xOGmm+WegnIU5IcQo6YFsi8JEdB3by6Szi6ItzL1k53GyGbblToNLv
         zxRzHb5ZMa4qZQ3Z61DfVtyksMIWVWByCEWtdONx8dz/ShAvJslQAAFqW5+DmKctNhh4
         +ZSqHCD9Df6WxZpxPuC2q6CEDOO3lRUUiAVoYz8ItrcoFDGbcqzScNMH/eYT3upy4SjR
         oaLOpDcLwMI5hHM1hnmVoNc9eixa2j558nFlBtFck8EltEghQ3u/zhXTpkAPr2oPl2c6
         tHop8d0tZuHcvLyLbP4GGFRUMYK0AVzdzcPoyr4aeE3cSzXVLQcthLLZURS70sPPT/P2
         f0fA==
X-Gm-Message-State: AOJu0YyFDpOmxFwJDScKxFzszjbuiNaNsxxLHcrkfc7PR40D5CodoIqn
	UCGFzEt3y/Dwvj8dxSvEtXZ3vABt0oCNlwurWJ1vJHeBKOW0AJ+B2fVB
X-Gm-Gg: AfdE7cmWHDCAroxIeeqqQ9ZUlUgIoh8mc3sjNt8HpGJSZoECHjiVyO41ysLEfozuLEx
	S3DtutoHRU0dL9QcCHMKIvmyEQEE6Y7zyxO6NZLM8nhsJqEhRzPffmP7fEEt+RcYbl64a1dh9Nj
	aOM8oX+8S+a3PL6l++KZkefKfw5NHKuggK/RvszJZhXfd5ZdUN/1w+mdzyhZ/lv6ugVtDZf8T2d
	cJUhkGQUx0EszN9RFwAPMzCqxTTTt4NBPz1qF8uhMYj1VLuSXvNur+7bcDzqWMilJt8MJEnWEVj
	7K+kb3am/G3KNajJuhTSbi9bBTUqbv8RiDlqzLNu+Nu6/XmRXe/TJrMqr3i/zCSC2ZZrBpeVr0Q
	IX29Jpxnszu1k/movaHUWzt18XxjuPA2LviYZ92I1iFJG7edLg4zz8kNX0GbL5HTXRNxW0zUvu/
	SZLZ7kSMhptZ1GkPBJGg12pjRNCgr9BUoDMN4=
X-Received: by 2002:a05:6a00:4089:b0:845:dde9:ab62 with SMTP id d2e1a72fcca58-847addb1bd5mr2956528b3a.19.1782873905310;
        Tue, 30 Jun 2026 19:45:05 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8479fff9744sm3145620b3a.14.2026.06.30.19.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 19:45:04 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (unknown [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 96B64416A065;
	Wed,  1 Jul 2026 10:45:02 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: stable@vger.kernel.org
Cc: tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	alvinzhou@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH 6.12.y 1/2] mtd: spi-nor: macronix: Add post_sfdp fixups for Quad Input Page Program
Date: Wed,  1 Jul 2026 10:42:03 +0800
Message-Id: <20260701024204.2730472-1-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

commit 798aafeffb369c5eb36e406b18970ef27baa820d upstream.

Although certain Macronix NOR flash support the Quad Input Page Program
feature, the corresponding information in the 4-byte Address Instruction
Table of these flash is not properly filled. As a result, this feature
cannot be enabled as expected.

To address this issue, a post_sfdp fixups implementation is required to
correct the missing information.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
Link: https://lore.kernel.org/r/20250211063028.382169-2-linchengming884@gmail.com
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/macronix.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index ea6be95e75a5..678ebaa220ca 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -28,8 +28,26 @@ mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
 	return 0;
 }
 
+static int
+macronix_qpp4b_post_sfdp_fixups(struct spi_nor *nor)
+{
+	/* PP_1_1_4_4B is supported but missing in 4BAIT. */
+	struct spi_nor_flash_parameter *params = nor->params;
+
+	params->hwcaps.mask |= SNOR_HWCAPS_PP_1_1_4;
+	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_1_1_4],
+				SPINOR_OP_PP_1_1_4_4B, SNOR_PROTO_1_1_4);
+
+	return 0;
+}
+
 static const struct spi_nor_fixups mx25l25635_fixups = {
 	.post_bfpt = mx25l25635_post_bfpt_fixups,
+	.post_sfdp = macronix_qpp4b_post_sfdp_fixups,
+};
+
+static const struct spi_nor_fixups macronix_qpp4b_fixups = {
+	.post_sfdp = macronix_qpp4b_post_sfdp_fixups,
 };
 
 static const struct flash_info macronix_nor_parts[] = {
@@ -85,11 +103,13 @@ static const struct flash_info macronix_nor_parts[] = {
 		.size = SZ_64M,
 		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
+		.fixups = &macronix_qpp4b_fixups,
 	}, {
 		.id = SNOR_ID(0xc2, 0x20, 0x1b),
 		.name = "mx66l1g45g",
 		.size = SZ_128M,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.fixups = &macronix_qpp4b_fixups,
 	}, {
 		.id = SNOR_ID(0xc2, 0x23, 0x14),
 		.name = "mx25v8035f",
@@ -137,18 +157,21 @@ static const struct flash_info macronix_nor_parts[] = {
 		.size = SZ_64M,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
+		.fixups = &macronix_qpp4b_fixups,
 	}, {
 		.id = SNOR_ID(0xc2, 0x25, 0x3a),
 		.name = "mx66u51235f",
 		.size = SZ_64M,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
+		.fixups = &macronix_qpp4b_fixups,
 	}, {
 		.id = SNOR_ID(0xc2, 0x25, 0x3c),
 		.name = "mx66u2g45g",
 		.size = SZ_256M,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
+		.fixups = &macronix_qpp4b_fixups,
 	}, {
 		.id = SNOR_ID(0xc2, 0x26, 0x18),
 		.name = "mx25l12855e",
-- 
2.25.1

