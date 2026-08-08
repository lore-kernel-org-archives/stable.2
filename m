Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B58823E330
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 05:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786166154; cv=none; b=dCyUXht4o2O8cVNRz7ZwtcV/FJMO43JwjYsKgoyx48TL/4W4HCu95RGaofCCIWFa3wwkWSKzQuqUW4emjvqd1nQFvwUJCmUD63q50hy8oYtAsbGbLkZR7au9mbjeThseI8VQuc+ezPlOmtS/u31a2wCNWHI4lyJ+/gHl+uKdcXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786166154; c=relaxed/simple;
	bh=VkOrCT4YVQ8Wh4LRhDH5x3EtzvDG1US9Kzo2Smej2J0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QtgiSJgfILTcNEkZhi28H7+wlIlijI6pVn6jxoNB0dxXr4ff2sxw1uGJVhf0JQPOQhl+rNbgUOmW+lwO69B8gwmi+cFaCZOeICfn+GD/1v4KA8mlLyjAy5JRta703l7NJU1vmfaHKHslFa9ZuV+2qhHiVOgWkojURLuQeVqvhmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiOiTO5B; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiOiTO5B"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38f620399a0so197354a91.2
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 22:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786166153; x=1786770953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qzluCRQ9VF2+ag54x4AO1QH0LAV6RpJxZbkPJPdf67Q=;
        b=IiOiTO5BmroBM/glFtxSoOUQuABTMc7GAx/etZXqGgZlwN8WSBHBSYKQPR2AFEDsAe
         TU/DR4vVkBOtaDas64t0NIcnJidEAPYhaCgRtHYpJxD/w5GrlG+UWOS+36Yc+pUUGoGi
         QNJEG59QTmsI3RkVAP/WiM80Ow6NHffe4ZFHFRtN4HvHKfrqqtESbSF0FmMiFURLFyFI
         Gr4pfgXWIozIPLSojZz9wrrigBhm3NHq+MM6cDS36ymkI3EGaenKouEU9kesIXRy+zs8
         R2XGlirS40Iqw8Gv5t21c2q1WS+FG96rKL5yIKAVQkoOxu/1K/4LYb+TTC3gCmAqQN1s
         ZdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786166153; x=1786770953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qzluCRQ9VF2+ag54x4AO1QH0LAV6RpJxZbkPJPdf67Q=;
        b=D7fmw/lv0P8hqlg3hH/XVeDX0+7SqW5IRdrM+Dh3Wkldccneyjw5Xpdi/XovPfMYYa
         ZMHbm8Tm1KqaqXVqDt0ijwMmyOjvklwYjOsNXcZPYz0BXbD5BXkKLZOIcxWhXfUcLNB9
         zdFsTntyZdScxCWY9JT8M1SsLjN7ZLSQ4eKrP9N2+BH592cIeLF5HNebHicv/bwHARUZ
         3Q7pfhw6pCZVpaTaxTB79X6vyAfkuusUJqlUrJYwsRQaeu7NAmdJwnAesRUZVPJX//Mv
         xgntbTTK4P9erLapqMLI/KrdEFQnHSF8r9iGv47nnumHd5NCdevSqJVIfagIy8+T9G7b
         4R1Q==
X-Forwarded-Encrypted: i=1; AHgh+RpdJSprZ51oYfM8782y5Eqi7C+KUO4C9s/G4Hnnlg94LMjTvwWEcoBEGZptzS+AfnJ4ZjXfE98=@vger.kernel.org
X-Gm-Message-State: AOJu0YytSJrLhaYK53yWoLnJBUDScvNA4pIluJJSHMyfMuP7z6Ebb/07
	OB0I+f++KNBqduWE/+J5jvsZ1HlKUm5t9tIsuiLBX1PCnoWMsitdBlNK
X-Gm-Gg: AR+sD11/mgHG9+EBPCysIt8AY47o093yMDC7KtK/0ayfLREFc/u3/UG4NQIIDw4sKrj
	ShQM70U94/YUyrx/DffJlNNG1p4XekPYzv6GMBa557FlpMD80s3LiZWcTtFWIumXVrkNTFz9EKq
	SKkylyXyK9+efP/+78YZXMPSVVxYtAHx5EdP+FtdM4d1MBE7dxMIIxKyWC8eE9oL7lEgSLQqPEy
	ECKFCND0sbt0H4oWAoHg+HfH+5px/4ZyCSAjZtRAnS/hPgOM28n+FEmk2Gss+hCMhR1hSmVimOY
	AGXJ3apfMlGehE6GurpqH+SeIqxG97vrjMqt2DBcIp9ToVQk2bDj3nv/YrtAPkR+CtfZbom8utt
	a6WzmEySPtgFOsVMdiM5RYWSggh1zbfXz59631j9enCflu/gMIqmpQuFx21jGSHAceJhGqzPdgB
	/MXIgCegAHZRAypu+KUS3RaJpF8EG3t3cDbf0z2KUniJp02o0HWg==
X-Received: by 2002:a17:90b:4d8c:b0:381:6c5:3f63 with SMTP id 98e67ed59e1d1-3903c544f17mr23476693a91.6.1786166152704;
        Fri, 07 Aug 2026 22:15:52 -0700 (PDT)
Received: from lgs.. ([36.255.223.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390b37eac8csm2200388a91.4.2026.08.07.22.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 22:15:52 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Frederic Danis <frederic.danis@linux.intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_bcm: fix usage_count leak when autosuspend_delay is negative
Date: Sat,  8 Aug 2026 13:15:32 +0800
Message-ID: <20260808051532.2553947-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bcm_request_irq() calls pm_runtime_use_autosuspend(), but bcm_close()
does not call the matching pm_runtime_dont_use_autosuspend() when
tearing down runtime PM.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during driver teardown, this reference is not dropped and usage_count
remains unbalanced.

Add the missing pm_runtime_dont_use_autosuspend() call before disabling
runtime PM.

This issue was found by manual code inspection.

Fixes: e88ab30d3669 ("Bluetooth: hci_bcm: Add suspend/resume runtime PM functions")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/bluetooth/hci_bcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 1a4fc3882fd2..cc419e1960de 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -547,6 +547,7 @@ static int bcm_close(struct hci_uart *hu)
 		if (IS_ENABLED(CONFIG_PM) && bdev->irq_acquired) {
 			devm_free_irq(bdev->dev, bdev->irq, bdev);
 			device_init_wakeup(bdev->dev, false);
+			pm_runtime_dont_use_autosuspend(bdev->dev);
 			pm_runtime_disable(bdev->dev);
 		}
 
-- 
2.43.0

