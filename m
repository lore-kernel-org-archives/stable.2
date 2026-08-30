Received: from ms.puri.sm (ms.puri.sm [135.181.196.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756441E22E9;
	Sun, 30 Aug 2026 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.181.196.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788128595; cv=none; b=fzQSZ2Iexzk4eoA3iPUpc6X95bXgzY4AK52yAC3eGKrTy5RRF5361B8wQnfsOiBuG6f4/Hcdd2XpGxr03kYTtmc3IbrCCtC937GVYu0eenpHLRv88tVJNQJYID9x8d88W6gQsFpsd5LBIxqlUilYBPLMv/pLWhPdyjsv5thoeaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788128595; c=relaxed/simple;
	bh=4JEe6MAnrQ77ke4wWUwz68qY4hoagUd12Z+MB80HeBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ctg/0YhowfW4rMQRzZktF1ZiByOM77sg/UrchQWegvicFt0J46spZoDpMt4Hq9LC9Sc49bcbgsP3tAkNYx9Pp++b9TWtnn6BkNicNrCyltydUUvDqV7IzIwld5V3ObYe4VeqdmcD+2T/H4L+wmjYb+DUYNNU45yUanCdd9ampnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=puri.sm; spf=pass smtp.mailfrom=puri.sm; dkim=pass (2048-bit key) header.d=puri.sm header.i=@puri.sm header.b=ibu5BgeD; arc=none smtp.client-ip=135.181.196.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=puri.sm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=puri.sm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=puri.sm header.i=@puri.sm header.b="ibu5BgeD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=smtp2;
	t=1788128053; bh=4JEe6MAnrQ77ke4wWUwz68qY4hoagUd12Z+MB80HeBs=;
	h=From:Date:Subject:To:Cc;
	b=ibu5BgeDGi1D7/eKvq110LXxiCOdftKf1Bh/FiqIO7ooyetRkWeaOs/WilMm9qM4U
	 JxZ+1+R3tM735sY+0pJxi3NOKTPr78Z02/MlYQ+0K2taM/QTN0QLcS3jj5QtJpdiLg
	 cn5rFrU5A5VN7cr5zKR/kStak1sfY/y6FIDZv6xbbQSY/5/csNVSZSALgBzE/PmTqo
	 VqGl0YpwpDt+KJx2/yOmp1he2aam8EVcxpJNchenc5pa1LGlICt6c5o0kMrwVaLGeZ
	 S8pto5YnUqzMizdQTP7ut0syJREut64g0YKZIeuAnIiY+gNg+Avzxgv7KCOasCCBz1
	 AeYzOs+mj+52A==
Received: from pliszka.localdomain (79.184.59.122.ipv4.supernova.orange.pl [79.184.59.122])
	by ms.puri.sm (Postfix) with ESMTPSA id BF2BC1F787;
	Sun, 30 Aug 2026 15:14:12 -0700 (PDT)
From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Date: Mon, 31 Aug 2026 00:13:32 +0200
Subject: [PATCH] media: hi846: Improve the power on sequence
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260831-hi846-poweronseq-v1-1-1091cf78cac3@puri.sm>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWMQQ7CIBBFr9LM2kmgrS3xKsYF4CjjAipTtUnTu
 ws2Lt/L/28FocwkcGpWyPRm4RQL6EMDPth4J+RrYWhVOyjTaQxs+gGn9KGcotATR02j9d2xV9p
 BuU2Zbrz8kufLzvJyD/Jz7dSFs0Loso0+VBVpmXHvt+bvt+0L6u8HaZsAAAA=
X-Change-ID: 20260831-hi846-poweronseq-71e7ac35401b
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Martin Kepplinger-Novakovic <martink@posteo.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Pavel Machek <pavel@ucw.cz>
Cc: kernel@puri.sm, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1684;
 i=sebastian.krzyszkowiak@puri.sm; h=from:subject:message-id;
 bh=4JEe6MAnrQ77ke4wWUwz68qY4hoagUd12Z+MB80HeBs=;
 b=owEBbQKS/ZANAwAKAejyNc8728P/AcsmYgBqlKs0qLug7PlsKGiey9ZkMQBCt468uy3e30tC8
 Yxh3cHUiEqJAjMEAAEKAB0WIQQi3Z+uAGoRQ1g2YXzo8jXPO9vD/wUCapSrNAAKCRDo8jXPO9vD
 /6/gEADCKfmWpcuXuFI+T5NRwY0+dGrsumBAOZCuAeoQsNikQx+dO55i/inGg4dNbAiQz8oTf2f
 /kqSoNj10rCsshvLYQwjW4whRXvGDXukvfU2IAUL1JEOzfpOaWshuJ/SkYZibsj5wziJRPMnVf8
 8fqEco0YCFqOndme72Y08abiACyjXoVAJfjR/kYTQSAvb0pdzCxcwEMepxCeh/ryBGWmDMRwB2u
 1moF1wSGBxb6GvormBJpufpW2AI2FCrDc9Lxts46QmSJ5dGAhPPKZapKWcilG7Ei4DcWNR5XqCu
 lXLoUwjm98qo3Om8ux4Dvg91BT14SdcN4D60zzmhf2ru8MuDU9Px0izuH0/mCidIkiMmT5IsXEP
 wYiBGbTxfS5XXjSdCw2qNrOuwfdTw5qg7pI6HBn/r8l+IMKlkRTt8HAo/qS1udEzwlJ3XgCF1Pf
 T25Fil8rQ9uSYqXaFPFENr/xfsA1Q+kdjUmn37nciZknmjhAijagb8fPru3NAjbJxX+Sq7wPnbL
 MPzfD30hifd1//yPQxlB0rSbTRZicCSQxirQZunvyTlcYPTNFnE8pYVG7GVjzU6MEJRhL1/3uin
 MGtzvxtyaf4uI+Rr1KXz4rIuUoBImVUGIKlMFacIvax9KtqrEOGfxXv6cEsNgsqUqWYUhWyOk1G
 Bb+ls1fZfv1ggdQ==
X-Developer-Key: i=sebastian.krzyszkowiak@puri.sm; a=openpgp;
 fpr=22DD9FAE006A11435836617CE8F235CF3BDBC3FF

Section 4.2 of YACG4D0C9SHC(Hi-846) datasheet specifies the time
between XSHUTDOWN rising and RESETB rising (t3-1) and RESETB rising
to the first I2C transaction (t3-2) to be both at least 2400 MCLK
cycles. This driver currently requires the MCLK rate to be set to
25 MHz, so t3-1 and t3-2 need to be at least 96 µs.

On top of that, Figure 14 shows that RESETB needs to be held for
at least 120 MCLK cycles. Ensure that this is the case.

Fixes: e8c0882685f9 ("media: i2c: add driver for the SK Hynix Hi-846 8M pixel camera")
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
---
 drivers/media/i2c/hi846.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/hi846.c b/drivers/media/i2c/hi846.c
index a3f77b8434ca..d58940c8da20 100644
--- a/drivers/media/i2c/hi846.c
+++ b/drivers/media/i2c/hi846.c
@@ -1643,11 +1643,16 @@ static int hi846_power_on(struct hi846 *hi846)
 	if (hi846->shutdown_gpio)
 		gpiod_set_value_cansleep(hi846->shutdown_gpio, 0);
 
-	/* 30us = 2400 cycles at 80Mhz */
-	usleep_range(30, 60);
-	if (hi846->rst_gpio)
+	/* 96us = 2400 cycles at 25MHz */
+	usleep_range(96, 120);
+
+	if (hi846->rst_gpio) {
+		gpiod_set_value_cansleep(hi846->rst_gpio, 1);
+		/* 5us = 120 cycles at 25MHz */
+		usleep_range(5, 10);
 		gpiod_set_value_cansleep(hi846->rst_gpio, 0);
-	usleep_range(30, 60);
+		usleep_range(96, 120);
+	}
 
 	return 0;
 

---
base-commit: e30626823a406725ce29bc75cb8ec467d3e1e326
change-id: 20260831-hi846-poweronseq-71e7ac35401b

Best regards,
--  
Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

