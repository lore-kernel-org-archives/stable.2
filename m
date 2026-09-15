Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1AA409638
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488805; cv=none; b=W2DPmcmMQX4X7loKXDGcB8fnHcgHa7UmS8mzMTEK9FY9wvSxb0mZuDmCQDKCp5ayAgZBfAOU/H1A5/ijEhy7MPlUQxwECROs7uQxRsObbAXPfWigsnt5quBD5S3vT21xdft9i2SNwso1nGPxPM3WdNj0RlqMhqXDxOieXjRkEc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488805; c=relaxed/simple;
	bh=L1vX6qasiMUjDTveY35hvrmewqSOHuZCD9Ih9SP+3Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YzEigfw68uJ16qYfTUhf7p7cxw6nsgxTI1JoNX/6UBJ2Pue1hYxtUdoAcCSYs1crtpxtiWfTJSI/NQ3+a+m6Qxl5v+CTp2r6ZBs4p8Xdt2ul2ktl0N2oVi/obpfbC9WqjHBDfpUtlHajqPeonAmWw3JeYNSgjyMLAS5j73lwiQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Esgwx/m+; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Esgwx/m+"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1ceb47d55so489607a12.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 09:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789488803; x=1790093603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fELIu1xKNH0ktGK2iyYSc9aLCgv+tvpxP2PwjS3qyLo=;
        b=Esgwx/m+VtobjleMRxNL/xBhmk/Z1cCaoB+nxNVr14UY8i2662Y1i4A+/fSn6UzDNl
         KtSgUL6QxV8b+NjCEbuqziSvMqVQHmdVvIRRgeT9oDBWMAmwlLjOaZbZgWrZ0nM0fOYk
         VBATE3ca3Ddk/e9TFrLgPcxUve7u/9g3HB4P5cLvOV97tZQHL1qfJrSxsLq5Wq3vMYtE
         5wNZdOVFWr0G61gIGJQLaXTQlRwKZyn9bCZG1BZFE1uMpZO0UnuNtuLpg9L1qsbBg0Lv
         pX4QNfj+0nCo5BlzfnHxgBLa0Uv48ZEdLd67YiWlThVDgV+19Br9JJN2v9LqhUm0kkyr
         NbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488803; x=1790093603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fELIu1xKNH0ktGK2iyYSc9aLCgv+tvpxP2PwjS3qyLo=;
        b=Qz/4oKsag4Ik+6C6iRkTug5l5KeB+Bq8sTkpc7sfJp4buzmK9fdUjymYFg/V0h5W/r
         47f9tVjGVg3Ja9kR1//k7qZpV33Fp31D+OMsYv6Lj+Fjsj7wRWidzTBaMGKMJz6nxxbg
         rB8xuxTg5vMowgyPQZZRBV1GsON8notRddLh1j5bLfSDY1raq/YEhq25rNexiBZNJg8V
         AMHXSByUDiOj0XKVgjta1PpMv1B7DEBnGKZI77I+MkdZNh3eapalY2pAAJ4/eXDpUw4B
         XLesZ0JpmDargcD1L3w7EEOA+5g6TfwAupPmNmAHnQdK4fFg3RyK+c/z+Ut0V3yAPRl/
         V1lQ==
X-Gm-Message-State: AFuF++lss/Q3dh6eharsaPsbn5/g68CRphG23AgGcByFaVsUEfQRYuVR
	w0vrM0VfatjFfZW6GBbWC1suhcFmnZ90QMUT87MWMpx2GnHFj7IkTef0
X-Gm-Gg: AYBFou0lje1kYw0RbcKyNmJg6prbTGXcXyV9acRabSFUnLG8aiXn2OAvIPKD/JujVat
	ZU2TTBtSU0D+53M0UgFWHvH8z9og2PLQswjJssfVikPfL2/kx6FAnkMETs6opp1afQsN4eh0LC/
	LWfz/pJp8rk41Z7u8cic/KYRWdzsyLuj1Q2hBSItAQjvvGqz+cLU1IlFDYlnIIVP9RghXDa2vRM
	vZwiN3FfLKMSY6htFni3zV5BDJg/Et3TTUrXjvAf28IKFcH8LeF/99+FfOpq03P9cUnWTSZAcA5
	NQv87Ql6ctmdGcKAyJD4WbfuXNjrLmUsdlDChDRvth2HTEHbOCDsJwTefyQewm2HB0qzB4Zk4Dt
	TeOfETgZH+SKbqd6jXj79KojhjGVS1pv7jZDE1KiNFXyE9J6cOmqF3bZchM98d3CnzOtgTGFCFA
	u6hZ7EB9hMjdm1vmnSyqBha3s2OWlMyg+/WMCDYiyKlZeoK4ZSzGJmFQ==
X-Received: by 2002:a17:90b:3842:b0:39e:b0d:d274 with SMTP id 98e67ed59e1d1-39e0b0dd4c1mr2366721a91.10.1789488802775;
        Tue, 15 Sep 2026 09:13:22 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfbac254bsm2139196a91.3.2026.09.15.09.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:13:22 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Robert Richter <rric@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Jan Glauber <jan.glauber@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] mmc: cavium: destroy slot platform devices on remove
Date: Wed, 16 Sep 2026 00:13:10 +0800
Message-ID: <20260915161310.2477406-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

thunder_mmc_probe() creates host->slot_pdev[i] with
of_platform_device_create(), while thunder_mmc_remove() does not destroy
the child platform devices.

The probe failure path removes each MMC slot and destroys its associated
platform device, but the normal remove path only removes the MMC slot.
As a result, the child platform devices remain registered after the
ThunderX MMC controller is removed.

Destroy each slot platform device during removal after cleaning up the
corresponding MMC slot, matching the probe failure cleanup path. Keep an
extra device reference around of_platform_device_destroy() as done in
the existing error path.

This issue was found by manual code inspection.

Fixes: 166bac38c3c56 ("mmc: cavium: Add MMC PCI driver for ThunderX SOCs")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/mmc/host/cavium-thunderx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cavium-thunderx.c b/drivers/mmc/host/cavium-thunderx.c
index 84ff6d82ae3c..c80907aaf51b 100644
--- a/drivers/mmc/host/cavium-thunderx.c
+++ b/drivers/mmc/host/cavium-thunderx.c
@@ -173,9 +173,15 @@ static void thunder_mmc_remove(struct pci_dev *pdev)
 	u64 dma_cfg;
 	int i;
 
-	for (i = 0; i < CAVIUM_MAX_MMC; i++)
+	for (i = 0; i < CAVIUM_MAX_MMC; i++) {
 		if (host->slot[i])
 			cvm_mmc_of_slot_remove(host->slot[i]);
+		if (host->slot_pdev[i]) {
+			get_device(&host->slot_pdev[i]->dev);
+			of_platform_device_destroy(&host->slot_pdev[i]->dev, NULL);
+			put_device(&host->slot_pdev[i]->dev);
+		}
+	}
 
 	dma_cfg = readq(host->dma_base + MIO_EMM_DMA_CFG(host));
 	dma_cfg &= ~MIO_EMM_DMA_CFG_EN;
-- 
2.43.0

