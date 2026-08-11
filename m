Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A53380FD3
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 06:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786428434; cv=none; b=QHywX+NAaKO/2WJm581UPGwOKePo6EFTv5hNL2c3GtkRjdEegiPjubWNbTgnzsSQQTqMZumyRzDsq0DPQBAaKXrBssWHs3tg9apL7mfOg70rN5jsF4ySn68/5OjiWzUEW7kQvcRCjEWLsnmyxcyW+tpVo2TPwk2xwfBAI7Tzvm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786428434; c=relaxed/simple;
	bh=cO0EPT1bPIG49AtzxircCgFULQ+dKdZXtNn1BWqEQV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PnU3kvfrLrfSxahofCOqJDT2oBoV27bnL43DybhFd2M0gbHEGfIOrWQpHka4+JVDdKBDPuIjFeVyePl5HQDtI0Jl8SC++4VM4vepQBvj54NVnWfIaW63b7BLsgh3UajQ3Llsgd9Mw6nwasmrbSHjRDKRQqPF1kOrPo8ObcF5G7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxXjjnby; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxXjjnby"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4a43c2a126fso747694b6e.3
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 23:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786428430; x=1787033230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PQogJxVcWHF2/s1gpFEzMjsDacnUmvO1LDzMrn00kZM=;
        b=QxXjjnbyzSdnSXtArAg7R8hZ4Sl14ExWbYqeXhkPW9j4LJs+cDK0sZ5VJsAMEIo64f
         QdAVbC3tuDuK4bcc1WjpnvO7sN957ibsBqDWmC7kBMDnf6nnkuRJKNXScMCgA1S30aPp
         ghUVHMmjiOD4LI7Dxr8/9RVjEoSeQnBUiOwjc5BLSUeHbErQbHv/7fqedvrLJja8msmO
         8lzzMULVLo65ac8fyfl7KUqfJXWmMGfOWBXIbvkSCdw1J/0JiIU/u16+AgsxLE3IgD2e
         se+HGaNE8SEFzja0l8QWQazrkFDjjT2853T9HcCqewrVvjo7J4K0Rz6+hk3w9QTYcnt7
         4fNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786428430; x=1787033230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PQogJxVcWHF2/s1gpFEzMjsDacnUmvO1LDzMrn00kZM=;
        b=syCz/Z/TrZOujps5TcmOxJ+xBcEfc+CkTFKzB0D7N4yLut0bQDmb32vK2XY2VcSNjn
         ChB0oh/OYLpdPdlwErtW26RseY0XdKTUhbuJYtNqhyRbbIQHgETBNU1ju/umBpXFgiHE
         Pkmm4O9lovVF4/e4ew7ujC9Et13BYtSBf4WECO3gcjW/nbYdifSXos/m+zs4pPSBs/+K
         v1iqWj15asrxWToWmoJZ2NoZ1vkazhS3icq9j1fNxSW52vJvrc5TN36crDOWH7HHBeCT
         Ti4o7R4FFtAFJAV9ekr3WlKCepU2kGD0pf08wXCY8PkIVJ240/SYU0SzCDmnJldGxszL
         0D6g==
X-Forwarded-Encrypted: i=1; AHgh+RpGazYN4DBmUwBV+nScA+tkfq0ahxQW8MBWTWc36D0SF6ukBjy3qa8lpzFAR4LMrbntkU5ZE4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMKQ9ny9AVuL+9VfByIaL+diFyUAdJtQx3/Fvyqb6KPef19uQG
	2NVGeja7NM+l/kn3hrqoO22+C9s5f3Th1T15ec1wux+FN+qhwMFKjTnV
X-Gm-Gg: AR+sD107RXFP6bsIssT8Rl+RIcopJlOdmQ+Ql0by7zdg7eBlPsnVRA9erlGhiUpIJcf
	+LBn5XCNejuzKBW4UPEQEmIQzOPeUqjlRawHK38q2jk/KZqubN57PC0zWpZPUXXWBsnX6dtoEN7
	rowvtdgPb36xmN7ZlClaIZlPEoBJcOJYYsVYX1BSyY1FHDWB92NFwODR0JhJGsvHFXOYKa7AI7J
	OIMNOZPVy/MDNPVBsfoPt4nw62/+zV2FlhEUWkN0HXrBGowuFMh9WRTdrNZgLK+dgLhoU7sc90Z
	6nUI4iR83ykaun91E/ZMPSDFL4ccoUkvxPGSsXToeTiNlR5eAzhurH6S3vQmF3a+s5G4JI+ar2/
	T72UNeKEQBRnxnT78EqYr+7ddDaBUtF/vgabGrpeqjXS3Zpt8bfpEI3dLX2GoaijYGBROtYOeb1
	Hhi5nk8isaQfM55sSK8xwg25MA+VD0f+aAeHWG4/h3DfwytCOSAeL7sn6gtfxAkSM+GKvSGaq2u
	FfTYQm7+gVkc4NEZ2oHvJiPwsry3BKopXZaQATTq9ExWaGDXBsFrAW42jpRlhLS0D+dF5jm6uYR
	oCTsn+m6oiK2E5vq3VgmXTk0weYN+/bPnCetCpw/bTiSUD8JCF3HEshK0/D49wj7qVUW19QaWo9
	vQraTrPbZn4Hkp7ox8lYfK7M+lp2E4BcjFTO5Qw==
X-Received: by 2002:a05:6808:f01:b0:496:2b3:ae71 with SMTP id 5614622812f47-4b1fd9d2e1amr577795b6e.18.1786428430385;
        Mon, 10 Aug 2026 23:07:10 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2001331d2sm98211b6e.11.2026.08.10.23.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 23:07:08 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: linux-mtd@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Cc: James Hilliard <james.hilliard1@gmail.com>,
	stable@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Boris Brezillon <bbrezillon@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: sunxi: reject invalid ECC step sizes
Date: Tue, 11 Aug 2026 00:06:48 -0600
Message-ID: <20260811060651.227431-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ECC maximization forces a 1024-byte ECC step and divides the
available OOB bytes by the number of steps. A NAND with a smaller
page therefore produces zero steps and a division by zero.

An explicitly configured ECC step which is larger than, or does not
divide, the page also produces an unusable step count before the NAND
core can diagnose the configuration.

Validate the step size at both points where the driver derives the
number of sectors and reject invalid geometries.

Fixes: 4796d8655915 ("mtd: nand: sunxi: Support ECC maximization")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 45ccbce91551..ad314c0e30b2 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -2032,6 +2032,15 @@ static void sunxi_nand_detach_chip(struct nand_chip *nand)
 	sunxi_nand->user_data_bytes = NULL;
 }
 
+static int sunxi_nfc_ecc_steps(struct mtd_info *mtd, unsigned int step_size)
+{
+	if (!step_size || mtd->writesize < step_size ||
+	    mtd->writesize % step_size)
+		return -EINVAL;
+
+	return mtd->writesize / step_size;
+}
+
 static int sunxi_nfc_maximize_user_data(struct nand_chip *nand, uint32_t oobsize,
 					int ecc_bytes, int nsectors)
 {
@@ -2078,7 +2087,9 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
 		int bytes = mtd->oobsize;
 
 		ecc->size = 1024;
-		nsectors = mtd->writesize / ecc->size;
+		nsectors = sunxi_nfc_ecc_steps(mtd, ecc->size);
+		if (nsectors < 0)
+			return nsectors;
 
 		if (!nfc->caps->reg_user_data_len) {
 			/*
@@ -2163,7 +2174,9 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
 	/* HW ECC always work with even numbers of ECC bytes */
 	ecc->bytes = ALIGN(ecc->bytes, 2);
 
-	nsectors = mtd->writesize / ecc->size;
+	nsectors = sunxi_nfc_ecc_steps(mtd, ecc->size);
+	if (nsectors < 0)
+		return nsectors;
 
 	/*
 	 * The rationale for variable data length is to prioritize maximum ECC
-- 
2.53.0

