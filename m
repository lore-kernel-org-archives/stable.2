Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795339558;
	b=KE4F9FlOJj/VhbQgFrhhkgEL5Asdr6BL0COkwPMm9+/7+/lSiW7ahlJLpIwNiM23J3Ih
	 PX6XqWwuqSiee3mWsYZIBTrJ9uO90lf5ZcC3UM9zl5loPe9o0rgG3VT9VvrA3uKarwJdp
	 hk7CXfr6J2zmpRlWm2yHlHmuFiY8dQitIZQQjRIiHUHrvIwCWYjYKgpyDONjla4pza0pu
	 vLgTAegQOZdOuqnJKp7Ivdnn/T6NiUFx+DtSJrmioxHkfP5zfR/mFHOP+iF5pnThd52ax
	 hR1Nkr7brvj5mZLnW+FDjdYgwLA9ojcOyubpbIYYYGRsLPgeC3BlNm1XO/63weME3vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795339558;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=RLux4IaKjACihTjDhvHAsFdwr8NDbNNSjSatrsNIAE0=;
	b=ZfEWN85Fp18IYPSh4LL0Dnr9IuWyvQI6LOLKtuGOzXY8eMOcPC9T7i4Pz50RcPiKbW1k
	 tL7GeXmuzAK90qnJMIZ9bQut+ZmPhpn97c6dHBVmtCvyBIihfyoYA1MB7h1LO+2gDuOTq
	 dFeOcwN+Tj41Sksn4pqX1epl6Du1jckVR+Dbuvqrdr4FAlej2r61qKZSrXiDc0uw2lCC+
	 D+dQ/tDeJtmX0cOVjVDtCBaHtWkMSoT23+ZnZJXGh4FaAgCQk4ZyEjok8LiYWKEB+KdFN
	 0CpmHEko8OpM5FwTALIcGdyDtHIT/B3i+DQzajPyne5iUm51zK5rzT143l0BzXLo53Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Xs9Opo7/";
	arc=none smtp.remote-ip=209.85.167.171
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742BE606A333
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 09:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 742BE606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xs9Opo7/
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4c5d8c7f326so960672b6e.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 01:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795339557; x=1795944357; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RLux4IaKjACihTjDhvHAsFdwr8NDbNNSjSatrsNIAE0=;
        b=Xs9Opo7/eNxoZMPt/YYTB88CMLCtnNDN858vBx0SYeXA7hTIEeYVIvnGAZGGHO8nif
         tNoaEs8aIkCLH4y1SWvbwmCGgro5qF4vhKEdG8UMIGhJEmB+d9y2YDMri6i1RDcV+936
         f8HaWEUhRMU0GwcnPFAXKo2ccWO+LA8f42fe32I1sBx+NFzEKjlaUZOc96LYBfIJIlzv
         d2b04TCy+N1zIEaEQdF6bYBpyg55smiPcxDX5Uo0J2nxD/6r6zNl8eJ2vj+E1gLBMMon
         fjStYHHZlPkV0w6sIX7zy5IMnDiLdXdYk/je3K5cUxKDqY/cp9a3uiUZSoFghuol2LwC
         uFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795339557; x=1795944357;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RLux4IaKjACihTjDhvHAsFdwr8NDbNNSjSatrsNIAE0=;
        b=vTuyPppwrawyEsyz4FDV0iwmPjpdnKbrYz8Y9PAAQujjH/XWP+XUS000xlp9KvYeUb
         SG1VZs6rVp6YvxaIzQy+m6elWe6FRBluquUwdBbOIcT60G7hBKEllxXq87FrkdwdlqMZ
         +aKDw4sagMMP1LJQGHbdKIVEo4qdx7p5mqQ9k/vKL2wqkrFHV864jcYTDmmEjDj7sFdi
         HuGTrnrJYFo6TrTDPJvDWzAWIOZN7cCDnk3+wpX3qniZX7FvH84bHhvCJ/9Zao7WZmv2
         pgYDfS8/R9CAqLxy2SwRM82HiyRc9njGzOhkJqeTbxHsidGjXABWStMqwdNmDy3anNDf
         3Mlw==
X-Forwarded-Encrypted: i=1; AL+hErE7cgHbbfnkPM32YD/8EwjsI7JwoYcZM/j2ThEHp06hbmc0yiMq9qPdwmRU4c29DsqvX5YPVK8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+G8MrsLMCYI0HhlmZA8ZnW8sY82mg6LAauXZLWm2awIYapEbB6
	uRUQlx9b7USi/m8Sk5YzAuKdNILF1fbiqHYpY/Jj2EGctruXgi9/q/kV
X-Gm-Gg: AZFdTZecHXIHbIJSqI/cY8U7unVsno3IXIiarupNGWUaPNf+O2BuNzhdFrLfQRhRpX4
	BsLSZi/vUiS3Hl7JOqa4pBfvZd15SSKNypoJogr0sDZjqAEdchh4HRCyCNSakzGSYKYPM6Y3fdn
	CbPrQ0yBryp9tdJaTKUAfPnKZwZ5G4ImwVY1tBIKtAbDwT1nBgjbptubbZW46KtlM/kkSeFjx9I
	Bd2jGVi8cWVo7MaTRkfr6DBmiYUgm4rBgqXMWuYszMsN1k9NNw9zQHWJfS2uC+VG1G4iqn/KkDM
	MbbgGR6+86fifrhPOZRN7X1Of5lpYNZw+r0EnYEDJYLDSK1dywmFBVPsiVdilz3aZt3cfbLiVPR
	rcpPJl4VWzoAvsKFblT2oQUlW6aZSa4qhwh3xVgfFNkdNqd+wI4AyeugW+9SIUb2EuVKymPB3Aj
	3S2R4K1+Lhn28Y3I7lWa1QLwRTaGbsPIvuX7U4UPWeuaVRSHAn6xbNzlNmHpUN1Nbp2MJU1HatH
	M4XC4stf7VCv6GGDW9Usr7l8BDzre5wmSlPmsP06Vsc8AzR+JwTcMcM5AbZO2vD6s4xqWWktaVw
	2J3BwJu6q+qEXhKQkyFaOwhMDbsQfQBl0nzsEe2z8v8eRDswyT2wOrdO700gR97+P9JktWfOCE7
	Pa0Q03SkLuxRENDb2Ak+MnJNkQSxdV2n8iRjY7re610m9F+m2e7pJ+GuUrlodHjwLvR1utr0MFx
	LiY3J97eJGiRPcoTkLSxLF9QoFBvXX8hpvn3DTXAEVb33NIuJra27K
X-Received: by 2002:a05:6808:1384:b0:4ce:a4fc:a848 with SMTP id 5614622812f47-57a06a0da3amr10323868b6e.6.1795339557259;
        Sun, 22 Nov 2026 01:25:57 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5ebdc0acsm8698476fac.3.2026.11.22.01.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 01:25:56 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 22 Nov 2026 02:25:20 -0700
Subject: [PATCH v2 1/2] mtd: rawnand: macronix: serialize OTP access with
 NAND operations
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-submit-rawnand-operation-locking-v1-v2-1-030bc867f0c7@gmail.com>
References: <20261122-submit-rawnand-operation-locking-v1-v2-0-030bc867f0c7@gmail.com>
In-Reply-To: <20261122-submit-rawnand-operation-locking-v1-v2-0-030bc867f0c7@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Arseniy Krasnov <AVKrasnov@sberdevices.ru>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Kyle Roeschley <kyle.roeschley@ni.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev

The Macronix OTP callbacks select a target and issue feature and page
commands without taking the chip or controller locks. Normal NAND I/O
can interleave with these commands, use a different target or access
pages while OTP mode is enabled. OTP I/O can also run while the chip
is suspended.

Make the existing NAND serialization helpers available within the raw
NAND core and hold them across the entire OTP transaction, including
restoring normal mode and deselecting the target. This uses the same
lock ordering and suspend handling as normal NAND I/O.

Fixes: e87161321a40 ("mtd: rawnand: macronix: OTP access for MX30LFxG18AC")
Cc: stable@vger.kernel.org
Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/internals.h     | 2 ++
 drivers/mtd/nand/raw/nand_base.c     | 4 ++--
 drivers/mtd/nand/raw/nand_macronix.c | 2 ++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/internals.h b/drivers/mtd/nand/raw/internals.h
index b8b29341b88c..2668f527e637 100644
--- a/drivers/mtd/nand/raw/internals.h
+++ b/drivers/mtd/nand/raw/internals.h
@@ -81,6 +81,8 @@ extern const struct nand_manufacturer_ops toshiba_nand_manuf_ops;
 extern const struct mtd_pairing_scheme dist3_pairing_scheme;
 
 /* Core functions */
+void nand_get_device(struct nand_chip *chip);
+void nand_release_device(struct nand_chip *chip);
 const struct nand_manufacturer_desc *nand_get_manufacturer_desc(u8 id);
 int nand_bbm_get_next_page(struct nand_chip *chip, int page);
 int nand_markbad_bbm(struct nand_chip *chip, loff_t ofs);
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 58dbcb004a62..2f1c973b8d3b 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -207,7 +207,7 @@ EXPORT_SYMBOL_GPL(nand_deselect_target);
  *
  * Release chip lock and wake up anyone waiting on the device.
  */
-static void nand_release_device(struct nand_chip *chip)
+void nand_release_device(struct nand_chip *chip)
 {
 	/* Release the controller and the chip */
 	mutex_unlock(&chip->controller->lock);
@@ -336,7 +336,7 @@ static int nand_isbad_bbm(struct nand_chip *chip, loff_t ofs)
  *
  * Lock the device and its controller for exclusive access
  */
-static void nand_get_device(struct nand_chip *chip)
+void nand_get_device(struct nand_chip *chip)
 {
 	/* Wait until the device is resumed. */
 	while (1) {
diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
index 16847f28b19d..d7f5a9e7c240 100644
--- a/drivers/mtd/nand/raw/nand_macronix.c
+++ b/drivers/mtd/nand/raw/nand_macronix.c
@@ -380,6 +380,7 @@ static int __macronix_30lfxg18ac_rw_otp(struct mtd_info *mtd,
 	int ret, cleanup_ret;
 
 	nand = mtd_to_nand(mtd);
+	nand_get_device(nand);
 	nand_select_target(nand, 0);
 
 	ret = macronix_30lfxg18ac_otp_enable(nand);
@@ -426,6 +427,7 @@ static int __macronix_30lfxg18ac_rw_otp(struct mtd_info *mtd,
 			write ? "write" : "read");
 
 	nand_deselect_target(nand);
+	nand_release_device(nand);
 
 	return ret ? ret : cleanup_ret;
 }

-- 
2.53.0

