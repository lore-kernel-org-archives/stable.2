Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7610938553F
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490749; cv=none; b=KoxxuGMf/GUVl3PT+hbEUA98T1X4lz4PAKYls9VvN6wc9iuQFM2HX7UyB5SHxPmpL3EoEunV2cPmejQfd+YmEf04aRAnSK7B+EChOmFCbLnVqiC66q8wa8R0HOr7TvaY+tfyuHQnq8ZPCOe1qs14xOi04fIvf13mzb12+EeG8Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490749; c=relaxed/simple;
	bh=yPg4ksan4KvZAnUxvVEesaEuZZd4bO5TG5Os+ey0WO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iGlh8JPoXou2OAYRElCKzQQLMZ+NgwmPNSlaqC0eEpjQwqi3e6gSe7WvPzg1O6skL4Hy8WzNW92Z0nGv+vvm39oYpHy8evTdEZd6TTbv1Mb0WSwCMnnyC/QnHlqzxzZupoF+rtzlIl/+spKySLTJBpOyIfdZnHh9QpExzh1n774=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbfG9ggP; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbfG9ggP"
Received: by mail-pz2-f42.google.com with SMTP id d2e1a72fcca58-86efece610cso525109b3a.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 09:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789490748; x=1790095548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lvCnDXZrWO8TEYbuW/IRJAcni3hfewokDsrz8A4uCCc=;
        b=cbfG9ggP4RkELB0gjpRUhaUtJ0QpqfCVb58K1puIqsnr465b6JNXN4KGvDTQ1D8Y1m
         l8rz8wXoEsNEbOLWGC8MxsECQwpzbwWbUQxfROynpp4/7vNq0NrkwaQVIF1B+uamqCgJ
         RDRYZTNKglDX5pTgo4LgdfeE7dPM4wXrf4aTorqw4cjhdnDTsUCs/RZCL0tHSYR1uw2m
         /bLCaCaOZYWKj++m7esJBx0eHqMI+RrcP9YoAsgRqDfU0AHCAQrCAj5XyIAiEVzVhokz
         1rI+cRbWZ7p20/jyzTnP1necRgSjyKW3McXH5v8JaRmKccIE7VIsOkpMBPKoKf9ZnpyY
         WhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789490748; x=1790095548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lvCnDXZrWO8TEYbuW/IRJAcni3hfewokDsrz8A4uCCc=;
        b=nDesDr2ea2hlBgAT9SyvuOoGtCuKD9yw7bsw3xbqcT9oyGjnkUp9avRAysDVth1RqW
         T8QlrZkPM80YdL0MNxPd9hnBQsBdVCsvn47zRP6qHUtNeXlanK/BZxwSFd2aJ7H5dovx
         Imm93LYNbGcdfc7m2mOHIIAyBFetoLEuC+/1ldfNvnDqIqc//aBaZxN4N1e5wJFyfLdq
         B052PQYokCZNsKVkDx/x3OVZfBRnuPcgpJzCoxdovKU7Ygn86q8PRBwFa4ZWwr86Ao3K
         Vn9fdRyGcNMXikT2oF+Kz4MC3B3wK4SZ7NZi+Szh+n71oBbUc+Z4f9wPbT2bi1FZaBvd
         qz8g==
X-Gm-Message-State: AFuF++ksKxvgYWDwgAx65XsbpoU3yP6jxp1Wp+CGLGGUb+xLd7ZnOY8g
	BdOStAlP6fLV2AfWHsg+25EjV0nmJrduQIgb50Oh4cSEoizBkrAdQAwz
X-Gm-Gg: AYBFou2W8cRJlcCwzDc9sND0x5cIgA1lbOlQiaOx80C14REQf1xIHQgYUPyR/x2Owvq
	cWYeDW689zwxLojNxR+Uf+VI9YDJRXhu6MbI1hHBiouAUGcubVROOIxnE5L9CkZByfPnjvIrkDv
	iopHeNDvLzFF6Qcru86QJXXfJ+yRSN875L7fOz15OuyzZ5nAYDof4N+86tkQrpTJuEYSCnkBRrq
	ma+VKx1k/yUfldfLITbPgHmsk7mSaOveS6jlciyXVVnMs59gvTyMxFkeTtUKqhXQVfjhDwakCjY
	5jEfIRXIrOEyAE6ga7t8ht6MBKlbVsUV0mk5Jfjwv1al7S2Xa6lyOiFO5CKOroz9n2yRrh6i6w3
	EgJgyit0uI5TaLqgK4Ct4jusGypnWM5ilhSYEr1ry0lKvgFcIbC9GCPAyaCV4O3Wsc5eyvTUt5O
	uCcVvOyAcsEiKzRlkyEeZYg0SMfRtVkA8OlMz0cQXbRKLJLq1xzAyERQ==
X-Received: by 2002:a05:6a00:e18:b0:86c:f33d:e3d6 with SMTP id d2e1a72fcca58-8717eadc194mr2942536b3a.9.1789490747845;
        Tue, 15 Sep 2026 09:45:47 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b29dc09d4sm6481081b3a.47.2026.09.15.09.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:45:47 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Hui-Ping Chen <hpchen0nvt@gmail.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH] mtd: rawnand: nuvoton: fix clock cleanup on probe failure
Date: Wed, 16 Sep 2026 00:45:37 +0800
Message-ID: <20260915164537.2496540-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ma35_nand_probe() gets and enables the NAND clock with
devm_clk_get_enabled(), but the ma35_nand_chips_init() failure path
also calls clk_disable() before returning.

devm_clk_get_enabled() registers a managed cleanup that calls
clk_disable_unprepare() on probe failure and driver removal. Calling
clk_disable() explicitly first drops the clock enable count, so the
managed cleanup attempts to disable the clock again and triggers the
clock framework warning for an already disabled clock.

Remove the redundant clk_disable() and let the managed clock cleanup
handle the clock state.

This issue was found by manual code inspection.

Fixes: 5abb5d414d55 ("mtd: rawnand: nuvoton: add new driver for the Nuvoton MA35 SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/mtd/nand/raw/nuvoton-ma35d1-nand-controller.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/nuvoton-ma35d1-nand-controller.c b/drivers/mtd/nand/raw/nuvoton-ma35d1-nand-controller.c
index 1a285cd8fad6..f659d3a6b9ef 100644
--- a/drivers/mtd/nand/raw/nuvoton-ma35d1-nand-controller.c
+++ b/drivers/mtd/nand/raw/nuvoton-ma35d1-nand-controller.c
@@ -993,7 +993,6 @@ static int ma35_nand_probe(struct platform_device *pdev)
 	ret = ma35_nand_chips_init(&pdev->dev, nand);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to init NAND chips\n");
-		clk_disable(nand->clk);
 		return ret;
 	}
 
-- 
2.43.0

