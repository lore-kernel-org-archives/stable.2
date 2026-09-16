Received: from mail-pj2-f14.google.com (mail-pj2-f14.google.com [74.125.227.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902483DAAD0
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 05:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789538366; cv=none; b=Ajxj1H7f7vd9AxNc9zRxm4+8HOORCg6wQb9isT2yKvabYz58X3ny1JwHVFlruoMnFB1Huzq0ynGfGiVl1lbbCgwwWFtpGBhJyP7AEo4GsyJl5wZEWSl7OwOLViNdStGYs/kJB1Ey4vgqo2L3t3oK4i5zJeLMlj8OEK4XF6JdO7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789538366; c=relaxed/simple;
	bh=djRbzIiovJx+oLFaryQwnSgtVMfADKF8NqdeIMo63GU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NAx7lhjmD0tOEhzg5ZbxdJKTIteVrWL7j4O99h9NNxpTG0BHS8T3maUxUDsNbOuqga2JZ3XY2d/jDJ1AnL9WY98nlY5uADHs9QQq+BcLDKKQrh1GoT42gBtM8IJyc9CPsMRqiTuQgFXKcv/a9mZnME1Sggz2CPBK4dXY6hsH9IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sTcyZZXf; arc=none smtp.client-ip=74.125.227.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTcyZZXf"
Received: by mail-pj2-f14.google.com with SMTP id d9443c01a7336-2d747f05ffcso3628475ad.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 22:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789538365; x=1790143165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wWnmHAMPdOzeGK3Sr5eg1RKJL6eIVjM91xJo25+AOg4=;
        b=sTcyZZXfUk2/One7Cm+uG2hb/OiH612/RGmaV4LXl0+kYoM5M6D33r0e9XCPi7t66j
         3nWP1MFlvv1mWEDGztNQmDOc8kCzDDAOFt2gNnyEb+Ux1uEUIq/iUXraQhhYL4wLODwO
         6zh+rd6ssiC9wIJ2gFNPlCRqMXpZLCc/bdfdpaew5meybg6+VqO19nO72t0wdiDEAF9b
         VHesrQDvXLyJayihOJHCJjcnq6KtV76jHksM/9RfHWqFbJnHwvyX5qkC+Y9s32gzp3Uq
         /osjkBBQxzXdcwUnCNMeOPcfWpjaJX63d14bYBOVGqP8xOiE4KaX/8/FRXmp4rvp+4k2
         k+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789538365; x=1790143165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wWnmHAMPdOzeGK3Sr5eg1RKJL6eIVjM91xJo25+AOg4=;
        b=BBeNdaBBLL3LyaOhFQv+p1eHefWJa7oE7WpIfNe3lm/r8ejA+qJfebu/Na92DfcYCq
         QBKuAaxr3DowwJOaWKRzhE2iBzH78d1hcM4S5lDXeXmNe2AtzT6Fcc5utLqZZd1miL/2
         dYmhn/xDtJ7+UFJVFmQWXDvpx+p/LXA9xSjAVLSkko2dYr6fvPplzCR1puFFhMqkpCPE
         xoqxW6DSx55ZFGadmnv2EKgJ7Th98Q13H9xGLAHzXWC7IWXJ6nBhh+T5mSDvytJOLd4i
         jf6Lf2PfWzM+3VLaVUONnlEc/vJLJ4lGhuDF5AlTX0zMW7nkHRgOHGfn0U8heRm7+Prm
         FKUA==
X-Gm-Message-State: AFuF++mfNVn94T1Yf2zKV4Gu07MDNHcj38WFeESLMaH5smzby7tfr01v
	gg0j0TXdHy05IA3TjLG+aREU8XJHfNLlEn70t4S3dSEBiQjQf2IKqjjl
X-Gm-Gg: AYBFou2UVs+r+BSBIGCdz1J03qD2/TinWraNR/5hcsmUsfRAfgQOUWfIsPG3GzEM7Ud
	7mJk+XITvixpUIlBxxKQtQ+iaTfoJpxYtaYGSqx10COomyJwtqPAZHj0sBUIvIzVjh5t46Ze7kN
	aRXR4Hd6f1nHCI1JqHPmXsj54y3/nbpawW4gYwkpEi1ejIBu6Px8Uj+pQu6XC1WpvZrFVWtaNI/
	oHRnYt4k8S081LDSbyShiKk2iff4tXeIBp4OWXV00v0HeyUkHdP8ichNpVXZW2mZNIloCM7edzT
	j5XbdOLFyV7lJycNkEa2sb2zTbCEfNXjrHLZ5VtJuqQ4RTIuTEoHz0FkKGhWiChZbx12dHJSqvZ
	lcscZSZzL32xlfcOjSkCzj3XKt1PyOoxruXH/T7oscamQAdURT1pNhY5jlygj1H6Ridxp1bEPmp
	Fk2tB2VEPyu2rAz6hPwHxOjq54efOCm0z9czw5erlXX+FT0BTY9y7W4g==
X-Received: by 2002:a17:90b:384c:b0:39d:f615:725e with SMTP id 98e67ed59e1d1-39e1e4921fcmr2985136a91.13.1789538364891;
        Tue, 15 Sep 2026 22:59:24 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1ae99ca6sm2753254a91.0.2026.09.15.22.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:59:24 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jijie Shao <shaojijie@huawei.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Ruoyu Wang <ruoyuw560@gmail.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Jakub Raczynski <j.raczynski@samsung.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] net: sungem: disable PCI device on remove
Date: Wed, 16 Sep 2026 13:59:13 +0800
Message-ID: <20260916055913.2910349-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gem_init_one() enables the PCI device with pci_enable_device().

The probe failure path balances this operation with
pci_disable_device(). However, after a successful probe,
gem_remove_one() releases the PCI resources and netdev without
disabling the PCI device.

Call pci_disable_device() during removal to balance the successful
pci_enable_device() call.

This issue was found by manual code inspection.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/sun/sungem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
index dc5638d105db..6abf4d292802 100644
--- a/drivers/net/ethernet/sun/sungem.c
+++ b/drivers/net/ethernet/sun/sungem.c
@@ -2806,6 +2806,7 @@ static void gem_remove_one(struct pci_dev *pdev)
 		iounmap(gp->regs);
 		pci_release_regions(pdev);
 		free_netdev(dev);
+		pci_disable_device(pdev);
 	}
 }
 
-- 
2.43.0

