Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586A62F90E0
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 07:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786260794; cv=none; b=UAonlgfcmu8aVSF4+IN5Yl3JarI1tZX0vxlDjN4vwP8CY1GstHrVjxlgwoiProXVP6T3QDrCkOzYpjLTTqT/4pAO14sVZwzx1T7neOsESuMwaYRADvcBVrpk38Uc6FFjVkn/XULR8uSS1JDowyx6mg/xHBlW1ybRUgXN5yCg17I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786260794; c=relaxed/simple;
	bh=KjB2Lr+gNrW4tPidywgCIXL5Whe6bg7M2THcOPT44YY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AiPvfT+U3D5+leBKFQQI0vN1RW1Ks94ObEoFt6jiAAAjWcMzPwXFvkjRQ2eXbQMa6wEUzeh2rWZmR7lswGgHgufX6sIGVpyL2CDJrlCa18ssreQ2dQ9MTlaXdTlqWUFBfKfjrKpxWAk1A5w4D3AehtS+W1sIaLrI0M5EVCkYRDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKwGycuY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKwGycuY"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc61541f8cso36880325ad.0
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 00:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786260793; x=1786865593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ENfS7OBp/4A8ZLshWeb8VKrRLZVv7nV81r8Jw7UB3zw=;
        b=SKwGycuYH2x5dibFopnT7XL5r9+OqAmBy/jwRWdl5pHaFYoOYEoEku6NVXQF15dUvp
         kmYafpC+zlgOgy1lTlpwoz1EArXmdZSgXSFTs/TYXfExeq5p/9UGN+PH1iYiOJopsZ95
         +BbP/cH+XdYiwO2XIOVajPSvMAjnJUjqd+Uls57kLW5WA/N/nD2FfC/UxaGsVZ5DA8Xg
         cyJEJw+ekr0vuiC9HtdUdGK8YcTyaEq1n5Qwq+GEg1sSoCHccUJr4zPJy9P2Ve9SwRJ1
         uOJt74YI92EfViyGCZ7eOFg4uX/x8FNaePCYvI3DLiLE9ZKDj48RRnRFiccgj8l8pvTJ
         jNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786260793; x=1786865593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ENfS7OBp/4A8ZLshWeb8VKrRLZVv7nV81r8Jw7UB3zw=;
        b=CIecpbcvuo9intvqmHtuvauDEXMHqAhPMjYcOs8lrF/oDP4jJuSM1+/c+6ErSQsdK9
         Zo95garrMvcGXRZTHmnjYphDCFp0A0xXA2aKALNMiVHod6tOsE+R/6PCgef8HnjSNSTr
         bhqvcSBTNg5/AUBxWN3QNP48INMCyKADg9mPZ+HPqJn2fTi/mI7UrkEvJ+rUiQ0LOdb0
         QK5AI1mtP/gRmG+Rlr/oU4dcSMTKqWMXCvZJq4QTcX/wf3Qx0J7Wu7IYfE4Vvol5htbn
         N8JwCd+w7o5M1AyylhI2Gx19ufP6GmGzBuVx5hvfON3Q+jy/EAykwkY33SArd+l0Ult4
         tsrg==
X-Forwarded-Encrypted: i=1; AHgh+RqV0CBnfupLcWM7eHh9OeoFknjGVJB+qSp0+1KPYk8o27EyOaSBx11lCZXnbPS6hGh2U6IBEr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7qW97YL+Xkm5Vn4nyfvZZwIIndffxazAXGKGIsvZEIzwTiTFP
	6TXoEdgc21MlHEaDFVHb/ORmj3fZYWS+WjoEg1i18VmoFzp+DkT2S7WoYw2gpb39uxs=
X-Gm-Gg: AR+sD12bBU5aE31mmHe1oOJDCxtoNR0g3OBbuUqqqBFuAps6QISrb7LHYK1J02Y6sAG
	4f5vAp2aZSMicHh5mN1/h/HPkVtC3aco5YcMRhFuNAkeqw3HSaEcwDXcOmjiRq6reWa3c8GY18E
	8k6+kIeVQDNi3XytRlXC82lYB2Qu/dSITVgzRf6kiiA0SBZwKAGY4ahs0rB2knzc8zuE0a7vWhB
	sKVZo3S/95VJguKq0kcYKE9SsPseq94LAKixFQnVcEqxPmSawArGwESv2KWhlJ9Ao06FZsWqORV
	42Mu3lqyB/bb2h4xBjFAB3IwXaZY+X+woIpdPhP/wUhZBliV5E8UyIhJziAbzsPx2FkXJcYcxkK
	Pg4uiKZEyzFhDd0HOdSum6JHmeFopydXDds6cQ70HLlS+Cf1Ygw7Cz8U7qsxmPmW/9t/F8z4HC4
	zx3YGMEHg6stL531AqxvG6iQw7xRX6O/SkIvLd0r9pxWysg14NKPixCA==
X-Received: by 2002:a17:903:2383:b0:2c0:d94f:50c7 with SMTP id d9443c01a7336-2d2b2de58dcmr124370505ad.7.1786260792633;
        Sun, 09 Aug 2026 00:33:12 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085f5e33fsm10540532a91.14.2026.08.09.00.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 00:33:12 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Ben Dooks <ben-linux@fluff.org>,
	Dirk Brandewie <dirk.brandewie@gmail.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: designware-pci: fix autosuspend cleanup during teardown
Date: Sun,  9 Aug 2026 15:30:55 +0800
Message-ID: <20260809073055.2980971-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i2c_dw_pci_probe() calls pm_runtime_use_autosuspend(), but
i2c_dw_pci_remove() does not call the matching
pm_runtime_dont_use_autosuspend() during teardown.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() call to the driver
remove path.

This issue was found by manual code inspection.

Fixes: 18dbdda89f5c ("i2c-designware: Add runtime power management support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 468287922363..f1f4955f9a3f 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -300,6 +300,7 @@ static void i2c_dw_pci_remove(struct pci_dev *pdev)
 
 	i2c_dw_disable(dev);
 
+	pm_runtime_dont_use_autosuspend(device);
 	pm_runtime_forbid(device);
 	pm_runtime_get_noresume(device);
 
-- 
2.43.0

