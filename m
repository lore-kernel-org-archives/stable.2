Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7903B4562A1
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791297225; cv=none; b=qFQsBJ9PUe3B20leI5W6lsWc5wqEuk4/HKTcGTGDMNQ5jtCnex9ZY1XwEQsiZJxni8cblPxYaSBdIYRuEGtuYmTH2uu/vSMGDNHbNUc5OyMrmkiUiI5FkRbC0/5R8ajDPBg9nCGYBgb6qDRQioKr/RGHh7tQHq22RF8mKJaakNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791297225; c=relaxed/simple;
	bh=AHtQESmUQDbfBJupwFyXgqeFpsKsAMO/Fmo8tcPAIdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uuAUFjDsIeeHMpPgH45BRtFc0iOCD0IdAgIGIIS9RQABOoO/JSYho6N/hg0FDkpvY6s8f+8b011uB1VeZ6V97J/Baacgw4BKm9Z1E8l7NEDZI6VsIABGidhOdoKNivUC5z85cjIGu34BxT9vauHM31gvpWlfxubi+yTrEnNEiW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=po8pjY2m; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="po8pjY2m"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48b08452cc5so392222f8f.1
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 07:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791297222; x=1791902022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=szrJLEgfWw06ca3u4MTw98CHDldHiWIyomp/y7G6TPI=;
        b=po8pjY2mGMvZXbwyWm0Zmyl/d3iFN6Wsd0vxmD/icroU0EyutOxuWfDfEXhQH+Z0Kq
         +QHkzjcYh/HAHd6ae5z4wnIP3V4mdiKsB4jADf67jo2kH97vUVwxf9eqChWjcWKOrBnb
         V4SEwjBAdqI9iYX42iTJKUhP9nzY9EISYsanPILJg+LBnpxDQem3rDuFMxrAGgl5PrD+
         HQ6T4qda2YnR4OX9UVFMjC40WuFm8By3PwtaIysiZK2gvDltFqmZ0EceBCgoy1dNsaAX
         FTGIy9bNkgcfW18Y6sBJyXzVkJSLFR5FEgChOIlxCZh+2dLbzXF70sWqsjydEfkdt/Ok
         NDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791297222; x=1791902022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=szrJLEgfWw06ca3u4MTw98CHDldHiWIyomp/y7G6TPI=;
        b=vyiZKnWpYJBFtZRPJW/2ZxBJkJQjkKesLBqNZea1cZroK57BqlxZLU69G+NCG8sEj2
         gpLs7dSvhsvGkB10wGiGZwoYKBNuqAzl8bcuHUsCuyZPQqHoogyIzZXzvtJjC1/FblEG
         46ywB849tAVNXJ86U6UzDUn8QPTF5DVs4ie/p3wm90x4DpLlSB3lJIRpoqPuky5N0BIB
         HeXF04Pm4Ayl+ExJjsFTNoBytbDRl4cr4kDlNdKLNwOk4cQGoQUh+0b9Gix3r1ca1RK1
         gmWaGAz9AMb3F/TJihUMBuU7+aXmYslR8MvO7l58zpgA8sxjSF3kHJjMu99IiRaY54dl
         fd2A==
X-Forwarded-Encrypted: i=1; AKwUvBw4RSwObTJqCDRmP2mlkcM+BZzy65mXQ1WQCIOEbtvEhlc8uOdX1Ccgyk8BSEDP/saV0yfnuCM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKbTTgp9Ba6XH1RHpjToq2hdv4U4bRecvIOagrqdo+IkMEhJOoF
	rKJN/cCbdwXO9f1dxkwO4jzGE0AIzs5tz3nut47SX8JehY6nFU+JU71J
X-Gm-Gg: AYBFou2mxMEWwYeEQAwzsFqgypTTpKG4pGfembsXVm0r17/CVbH9+4ciqDPWnHFl7w1
	s6vRCjTLbn9O8lf4F0b/u0ogoKx29qviSMy6Aoz+iLVz8vpNWYaBiQEVhs1Mnqq5JZq54M68+F5
	Nadlo2Jy6mrN3Vkpi2e3FePijNm+MysEfWFSTgEet58fo87wg/fiUAHhTdyg/mB3OKKVgECM6R0
	vC2NhvnlK/Z/YRg9aRAilYon7F/aWEUB3RvNf901ujEKlOTibcdo+dq6WT+OQ+tzZvrQk3M8Yp3
	cfM804OiRobEhBv4O1iYmaLHx6se2XcNNk8rGUjAsR+i21RQRLZEMIs6svGfrUZGvseBQ/MI+bd
	VLiPnOMSzUgF0gYZ7ogEJqDuiKNZGIuSyiiMaZsifuFTzThk1cC7vOpLu44w/YCn8oHRrk1prJV
	QRsACTwgPy2I4o3Lvwg7+RnJ158uvkqHkhM4hpHynSPH+75Y47jkeldBIREYeltSFCOx7Qz+DBN
	gEVFqpGrTXQbe0avydHG5eAjJLqWqZrBaJpaPQLyWEsRBr9v7ss+PcX3/4HUMjaBaw=
X-Received: by 2002:a05:6000:2586:b0:48a:f3d0:5dbc with SMTP id ffacd0b85a97d-48b12711a15mr25744347f8f.4.1791297221448;
        Tue, 06 Oct 2026 07:33:41 -0700 (PDT)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-149.paris.inria.fr. [128.93.83.149])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48c62289b62sm10911048f8f.20.2026.10.06.07.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 07:33:36 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeff Garzik <jeff@garzik.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: ethernet: i825xx: Fix dma_alloc_coherent() size
Date: Tue,  6 Oct 2026 16:32:40 +0200
Message-ID: <20261006143247.54724-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In sni_82596_probe(), the lp->dma buffer is allocated with
dma_alloc_coherent() and with size sizeof(struct i596_dma), and possibly
freed in the error path with the same size. However, in
sni_82596_driver_remove(), the same buffer is freed but with size
sizeof(struct i596_private). This error may leave the freed buffers
mapped, leaking a resource and allowing the device to access freed
memory.

Change the length in sni_82596_driver_remove() to
sizeof(struct i596_dma).

This patch was compile tested only, and found by hand.

Fixes: f2ec8030085a ("Ethernet driver for EISA only SNI RM200/RM400 machines")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/ethernet/i825xx/sni_82596.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/i825xx/sni_82596.c b/drivers/net/ethernet/i825xx/sni_82596.c
index baa598988f47..73e1e153cb78 100644
--- a/drivers/net/ethernet/i825xx/sni_82596.c
+++ b/drivers/net/ethernet/i825xx/sni_82596.c
@@ -159,7 +159,7 @@ static void sni_82596_driver_remove(struct platform_device *pdev)
 	struct i596_private *lp = netdev_priv(dev);
 
 	unregister_netdev(dev);
-	dma_free_coherent(&pdev->dev, sizeof(struct i596_private), lp->dma,
+	dma_free_coherent(&pdev->dev, sizeof(struct i596_dma), lp->dma,
 			  lp->dma_addr);
 	iounmap(lp->ca);
 	iounmap(lp->mpu_port);
-- 
2.43.0

