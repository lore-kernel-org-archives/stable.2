Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80712306741
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 08:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786178190; cv=none; b=gtLAjS2NdYJ5Smb5NTC0USZZ735yN6SnhPgySH34421zghDiDKcLFeOXwMuK9gbOzyvtkzZXrRL+oKcdMruUsCoYhpiv6LpoEo0D1b76YMy7Iw2sk+d0sqcUhZmrmg4N6OuHPf4wUeZr1vZ568z6PAOZ0mperCVHqyT4ocIDmU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786178190; c=relaxed/simple;
	bh=XJ/DKreYFvcZTMMtcuxtj6GX3d172qVUGH8mKiop0OY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W4iBiN6SyYZP5+GNvPy7zx0x3wepgLRlooCYXmuvkD1IN6xS5u7l5zivHLWT6H5fShhpc1ivjAkry2NtwyrdLH4Z+aqrUYU/so4cUJTOuU0VwnBnOe3kU2MknfmkbmQRUSXAhl1rWHQ1LxfvD+vUkK9kg+rFS7ZY9CaodM/P2R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLOCE1vi; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLOCE1vi"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso187566a91.3
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 01:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786178189; x=1786782989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fdduiRQwuJsbrhFMnqTIsNuHvHg3FoBhY9JFBlVgCRM=;
        b=nLOCE1viDMM9gzwnbKjMFFQOKB5juXEd9s7/qX4kIlDlFHtLN2xFngNLpbdeK6gCKR
         frNRDXApB9so69IfVdu/y7TwhuOEUc1UYrMcsDg613fW7DtZTNap/btZdigNiphkwtH/
         NXcu5RqeEx6xNc5Q635BpM/6Ye7QYwvFQGRKXEJ4h3nSX4wVaS+D34XKNxb9N744zQKA
         5G/P+97/7GQt3TlIFY8OuKp1Azg713ypDPgQzWaITFFcQg1wSPK3BniPVXRTDh0tpJUH
         UlRUUJza67t54S4ZgZzIxFxhazZBUkxQCac09/46o+RHKg3DUdsgpSD8A7PFtcBMh0Dd
         Nn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786178189; x=1786782989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fdduiRQwuJsbrhFMnqTIsNuHvHg3FoBhY9JFBlVgCRM=;
        b=fQZCjK5Dgjjuc5TTRomW69WLW+Q+NUHKJwmqnJ4G2eQ8Z/06rLhguc6ra+RVO/CVtf
         3vvCd98vibqThwYGHZOyliiP191Rg5cO3hZqbgvuMKVHwRlvYETIBZpKW7YM0luxEFdc
         cy54ThpSvKcf+DbC+PyTDx6oI2wCfY956rSTu77obmCy5maD5JN3XRGj12KAMVUE05vr
         3NI81dQy7e1Ctx9LgVkbmiJmBMEK0J4P/h2E0haK2qkSNfs3L8NGu43xNOOWjB6bjOJq
         8zM5o5eZluDui4rqemcWDOFSfDv5Q8Ib/nxXQU6aOVxM5aHnx6H264widZ5PWywd8nXn
         4qLg==
X-Forwarded-Encrypted: i=1; AHgh+Rotail2ZJAHqmrTuWOp0nYQk8FvAdCARCsW+c25+XMfdUy4W/k5rr5hhyK4s8Pj5PK9K0Q4X9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD0vvl6cY+IFh2HCiTXCiAA6Pf3Kwj0BxE3FdlnI3Y2fTFFb1d
	/Z7vROyExlrZNadScrKUJSu7M0+HY6qFt7UVo25zKRcT24N4yqNLMMf/
X-Gm-Gg: AR+sD10GeLSOPbLROBXjJroFIlzwPNZt8l+lVmhh264T1uQdtEdr9syW9U+H/agKGVe
	Yac4/0gBRcJ5f4Xj/s3pAqV4x4/bI7dAt/UH9XsvPpVpb/zHyurM3xQIdhIJqPFRLTSLNG3D7ad
	oLyNJVVDMpXYDvQNAyeqQhd8QcauUAYB4wjdc6Di+vMaW87lOymEq67FzIN5PLiklGyUsHmD0CO
	Yl4ikX4Is5xCj+85FYGihwDAdUspXd85u/vyy8M3ZvoNTBU11k3SnOzZjWf2JzoKGO//K5EiNU4
	sSoSCj8tKVMXVxuiN6UdqoEpgzdJ4ohQo5CmDyTnz/vurFFzTpDWySe8uwFBv44nxQaTD+RupXJ
	mnCM22Ck+MyVVmprGoZ/BLMoVTk+0CkbKdflWx5xhgDwaEinBkYQjNmyYVOQFNRCFdKPlFaSxto
	BvPNBx/6d8ldBdmogIGKHU9kY/U+ewahvL5yopKw56pWPs4stoCkR8XmRIeg==
X-Received: by 2002:a17:90a:dfd0:b0:38e:5ab7:ce9b with SMTP id 98e67ed59e1d1-3909d928d54mr15940827a91.21.1786178188696;
        Sat, 08 Aug 2026 01:36:28 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39086164982sm7682051a91.16.2026.08.08.01.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 01:36:28 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	"Mark A. Greer" <mgreer@animalcreek.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] crypto: omap-aes: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 16:36:12 +0800
Message-ID: <20260808083612.2698779-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

omap_aes_probe() calls pm_runtime_use_autosuspend(), but neither the
probe failure path nor omap_aes_remove() calls the matching
pm_runtime_dont_use_autosuspend() before disabling runtime PM.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped and usage_count remains
unbalanced.

Add the missing pm_runtime_dont_use_autosuspend() calls to both the
probe failure and remove paths before disabling runtime PM.

This issue was found by manual code inspection.

Fixes: 5946c4a5e770 ("crypto: omap-aes - Convert to use pm_runtime API")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/crypto/omap-aes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
index f31555c0d715..a6f5a689fbcd 100644
--- a/drivers/crypto/omap-aes.c
+++ b/drivers/crypto/omap-aes.c
@@ -1243,6 +1243,7 @@ static int omap_aes_probe(struct platform_device *pdev)
 err_irq:
 	cancel_work_sync(&dd->done_task);
 err_pm_disable:
+	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
 err_res:
 	dd = NULL;
@@ -1269,6 +1270,7 @@ static void omap_aes_remove(struct platform_device *pdev)
 
 	cancel_work_sync(&dd->done_task);
 	omap_aes_dma_cleanup(dd);
+	pm_runtime_dont_use_autosuspend(dd->dev);
 	pm_runtime_disable(dd->dev);
 }
 
-- 
2.43.0

