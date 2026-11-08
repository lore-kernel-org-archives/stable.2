Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794171921;
	b=ba13NuBdmClPzbwvXqUKsi+05jK1wPgyUNXg8SdVlOtVTw56GRwvxJXVbue18wWW18Wl
	 eKehyGPPdiAWtZCzOFlCmkoa6Lk8rv79c8VIC0B95DcOcBZjIyIW9ttpY4g2XGsRcR+rm
	 xX12K4t2gOeWmQZaS5b91SuJJ3aMNhBnfWgiZ+Dr3iJNE8529Cu0GuG8Xmz93heWRBvtY
	 a32S2eNzQG5oBGeYGPc2Z37WFCrkrc2awmd57gmCzPxh26ylkcFlsJUEFO46hkQNE77qB
	 bNuVeKK9bv6s9MuPH1C4hq6vrnDzgp2JXXj9JOA/OfRYwBRoTwcWmrt+kLi8Z0NXRLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794171921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=VOXdJqtU61quagom20vbQEtOrGbaqfLbHDdzOijlTys=;
	b=fW2WTwrp5yWpz3ocjQtKZWMuFpKaxlWl5XDJe5zKruUtBKYgxzm9H+Q+Y/pZKIfG2av5
	 Dpm04G2MGpmmJfYpYArhxoYQynSuV+KbE4rxpA3UY4I+Kl5SOE/aYUh2n1Ea5yHsYL5jn
	 zZiQ8MjUiMvQjqbbd5VhZSWo2UGxlaa31qWm43jHS+oGKQr+C8kDbYyVB3FhfMpOge4Ui
	 qTGgcooILooK/p7mhILQdbe6kX9gBxbkBdcAyTYFlcOiqnf/n7c1P0IniMmPFWq1hDZhx
	 rsHUZKX/ddfvgzFq2RAZdg+yhbq0iELTmcpWsn+/lqXoab4DAUF5kOLxPa4dOg8nm/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yOFI0uKb;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B4A606A321
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 21:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99B4A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yOFI0uKb
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-854b6e2e41fso137297a34.3
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 13:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794171919; x=1794776719; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VOXdJqtU61quagom20vbQEtOrGbaqfLbHDdzOijlTys=;
        b=yOFI0uKbuBmma6KiWoraFZ1FPpVDQQwjeHcK1XBmdzpnMHa2Wctu7hc4DtqvVC12v9
         VHeXeFmd1SC1JMpQ5EFZSjHY3Zz26OZq44MsJVXjKudCzuwAN5zqYEOLmHSpGw++caWf
         cxgLdq4Bjs26RdZDH6rZjidh48Ru/hE0ylT7pvaSRLQK00qXPTAe0aL+xNKIe+4srpob
         V2tk7QJMqnunh59Ozjr8P659aOc9V62u87s3Of6QPvDGOpPUYXREcTldxpITofPQfpLy
         BhKjrgOlSoGNj25iLokE36HUnwpjMUH0F23/S8j0ddiuUUvXqX91qW7EsUK791hvQRrc
         Adpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794171919; x=1794776719;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VOXdJqtU61quagom20vbQEtOrGbaqfLbHDdzOijlTys=;
        b=lGWcTbTCIReNOa918AJKHBVsjGTDiLn4y/PIcLs6UQyrgYAtBIwj9DD6OMVudZkSRu
         de/9CgNZUxP22pewOil1ZIarOYYcf4i9IEYHYoWVBFiQFbnBpyeBDkGCD2+NqWfrMOvk
         JbHflJjqUDnfVDmQVDwbHmpuHak8SBYiSxk0TWw+LMJlIixFFGz458UQ/M9J0WFdei5h
         pRk96UXMXCX1sA8bhAplXnqEmzd+RcBEUEl2ApGGReMDTuaEdlG9YK5XePMLw69OJdDy
         PFJ0c6irwe79BBe20pJMoHDXRdsEFov/D8s5V+od8CP0Uuvkd8B1FVDEz1mXcQsy14LW
         kQBw==
X-Forwarded-Encrypted: i=1; AL+hErFmeyuQUjrsqIoFZEyBkhgyqG6HwQTIFvjta7EYoQ/IRE7Fe+D8435sDdBk31F3+6bPPXDSGMA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+lJplFTtRlpYnSKWyT3Y1UOk85OZfP2tQwm4LuFnR9S59S5ut7
	Hnr122rad7trARpd28NNRcGx2o4lSh4b0TqxQH65UdShyuOFpiR+GqWo
X-Gm-Gg: AYBFou0xD8moi7pbj9ocVSpBM7KmfKnjOnL8mq1DL7ERUOa2yUWaK3hlTD+pe6dRSGn
	Hb2mQ2QgLlSkQs+FwYAkGy54HgVXSOAOVtYbC0EmbZD93Dj80sAyJnSllLul6OKiHBiElth5D99
	2PJC4oN/IHuJP+gVo9RutW9OG0iV1XFKc8V+x3DXSjHBRzkhuhDRoIMn7L8Aicpch1J5G5LXZ2L
	hlUm9ZlAnVJmP24bVw1qiXjaf5eLVYUtUIpFlGcD0kMK3IQObnQMhokedQnt4+B/XaAOWUBTWbn
	7DsU+4MV7O4KYNYgDPaBP59GWmd/kYyK8kCcVbJVguiCFOEESuaHY3BKjdjg2Fw+T3JsNhC9D/d
	+j1s3zx9e10EfAa22BPpqkesYDrz0R+iHfRQ/M1EeSOnTsympG0uz1ZnQPOftMejhFqFs/abWJO
	yZKrVYgMneqDfjmeZ1e6HmmD/+jISOoYshEtqwPhVAvQyAL7Ii4J5cGAm1UwyWeTqsZDkNngyLm
	GfCrfoOu2FM44HeNI+LPoukraYh7OZSd+HlP6Pl0QIoRc6SjyxVTzrNEwkktDcgvP/k3nE4uD1T
	2uLOfYHJy3TrdFdeJj5/54Oj2TV2AVCKShscpyVTM2rGmxgse6fjcc5gPa9cFT3G/sk5p9JhcVB
	LwS7KWolRHiZ8Bq4+5CUerQXxSh80eTOpLhB8C/chJhCh4WID4MwTZ3wI2EyE78B7sfFI3G6Sv8
	zXlKC5WOQLj/6UK16dLk34/RPVv3MuoeQRhgNPMt0qPtef95vPcLad
X-Received: by 2002:a05:6830:91a:b0:85c:4897:f2ff with SMTP id 46e09a7af769-85f5084cce8mr2349585a34.25.1794171919700;
        Sun, 08 Nov 2026 13:05:19 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f4fbd820csm2226208a34.23.2026.11.08.13.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:05:19 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 14:05:17 -0700
Subject: [PATCH] mtd: rawnand: intel: disable NAND when probe fails after
 scanning
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
Message-Id: <20261108-submit-intel-nand-probe-disable-v1-v1-1-eb0471429e09@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXN3QrCMAyG4VsZOTasHTrBWxEP+hNdZMtGU8dg7
 N5t9fD9CE92UEpMCrdmh0QrK89Swp4aCIOTFyHH0tCZrrfWXFE/fuKMLJlGFCcRlzR7wsjq/Ei
 4WjS9ucRozi70AQq0JHry9ntyf/y7KG8Kucr1wjsl9MlJGOo05dhWuhXaMhzHFziLSe2mAAAA
X-Change-ID: 20261107-submit-intel-nand-probe-disable-v1-0605dd04ac6c
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Operations issued by nand_scan() enable NAND mode in EBU_NAND_CON through
ebu_select_chip(). A failed scan or MTD registration releases the DMA
channels and other probe resources without clearing that enable bit.

Disable NAND mode on both error paths, as the removal path already does.
Keep failures before scanning on their existing cleanup path.

Fixes: 0b1039f016e8 ("mtd: rawnand: Add NAND controller support on Intel LGM SoC")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/intel-nand-controller.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/intel-nand-controller.c b/drivers/mtd/nand/raw/intel-nand-controller.c
index 477a427dac1f..97c82e9c1af2 100644
--- a/drivers/mtd/nand/raw/intel-nand-controller.c
+++ b/drivers/mtd/nand/raw/intel-nand-controller.c
@@ -690,7 +690,7 @@ static int ebu_nand_probe(struct platform_device *pdev)
 	/* Scan to find existence of the device */
 	ret = nand_scan(&ebu_host->chip, 1);
 	if (ret)
-		goto err_cleanup_dma;
+		goto err_disable_nand;
 
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret)
@@ -700,6 +700,8 @@ static int ebu_nand_probe(struct platform_device *pdev)
 
 err_clean_nand:
 	nand_cleanup(&ebu_host->chip);
+err_disable_nand:
+	ebu_nand_disable(&ebu_host->chip);
 err_cleanup_dma:
 	ebu_dma_cleanup(ebu_host);
 err_of_node_put:

---
base-commit: 30daaf3e7897b4a8d9b72e5b0c86dd6e2a4d7d85
change-id: 20261107-submit-intel-nand-probe-disable-v1-0605dd04ac6c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

