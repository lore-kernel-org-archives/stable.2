Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96484D17AE
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790171436; cv=none; b=j1dZ67tOGaGjaevKvtJKUAU+Y9bTCL1RCkiaE+yvJjH6eR9iTBvUxg8q2HUBUR8abw0M0dvgVI+pNlvuH9OEc4hkFJUJoajUAIYqOu8dF5nlMWagUC6bxyp+hsIkcmMA/cLlTzjW5hqmth6P8SnbAbFncACO0SUArhEOPzYXjBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790171436; c=relaxed/simple;
	bh=pc0FDD6IR7pFOD7noF91D54mnHrzpCH4w/W7A8vQcRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e8hqzdYlAbh5qmb2B7v3AS88MlIDqJ4GKhJN4BYNvRS5X3Tr5/DtsH3bnxTvbWhSn4Y37MBz9lkm6nk+qxt52gInQ5oMBB1vpHRkaBJBl1jm8WZubH30yHjx3jihOK+MT0IBh9mX3bhvXaXyXDZ14k0vpK//qaXxZFsyXvwxBu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ie7k14XL; arc=none smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ie7k14XL"
Received: by mail-vs2-f41.google.com with SMTP id 71dfb90a1353d-5c67e5292faso450762e0c.1
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 06:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790171432; x=1790776232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2SglU6SsyzFxHFyMmhSwCTOipsWKClut0lOm4koa3sM=;
        b=Ie7k14XLYXwZhS9e3z65cqdUOciSzADvJZlfnypfy5tdumIN20Y97QQIsdEdLbxlL2
         evK5A0R4gs/GYFzKwsExv8ofZNQtY910r/mQETygvg4UOGa4sQ6rgAzYbTAMajahAqnB
         dTqv77xqccDbnnv7lo0LjruUEeBQPgyZqO3O2ODMMKkawDombR44drMd7DjaQmBwtADF
         VE0x0K6n42smys2IygUpReg6FIb9ValhQ7AltsDDwh22eyhw2+i/oEyLmFmkSTPdNDfR
         SsLsba8lwwu1KIXiZj3vZZ4gxUTOgTzsprQIHhZ+Ugl2n8aX8F2zk4220+inOzgEWuwe
         4wkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790171432; x=1790776232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2SglU6SsyzFxHFyMmhSwCTOipsWKClut0lOm4koa3sM=;
        b=hv5OhotG7H0ArQWH3M8H3U/EEZ51dEAHdM2oWjE385j37UmyPdmXiF0UtOLmNe4WN3
         XpEjm/q5spCskKGWD17hpB22qcklCW6TT43wkCVOi0SyEjYgaGnL9urwDPaIzm+yAUtz
         SlEttV6RFDI25t830EocSK890b3kOzJNIDnHOag5aUXwhHzR6w8/oCkMqa/NeLa37JPj
         PCDEJpKYiLxHeYHqiK37k4nxeURPRlnc2OqJl9rPzDZmJCxSbmVZLaaBzTnmNHrzm5tG
         lRarH/Qfipw6/k0xiWCPpAIXtXRm815AACatJkKP2LYp2YbPnKILAmEepY+qy9wKFfoE
         8zlw==
X-Forwarded-Encrypted: i=1; AKwUvBxXeuPZ45pxkBGQrH0kHG7zdgE/5RH1eAHJqPEe1QbLUOOvDc984LvFgb+gxQPUxyYgyZUuG+o=@vger.kernel.org
X-Gm-Message-State: AFuF++nYx30EhB2q1ITO+wtOlHcRnpJL9VpR6NTHVGvQKrF0lLb89hIs
	Te1xFtDK+VOUeVSd+2o4QJ90AXDZ0LJWHuXfmIgpBPF5UfnB1Xra9u3D
X-Gm-Gg: AYBFou3Ts9UKMbr0F5y/sWCPC3WhEWWuNmn6lFGs/TR0hhtbfqv/jkvvjRpSlRqOFx3
	G5bAqwNsqAsvN/cAmEddkTiRaMDXaT77oR/2TiRdx8dWsFKTaCixk4EuwnSTxCkXx9ilyWvomz/
	Yc22+Kgi8CqR6irrYbooVyrK4MqT+O2vT8ProAHsCcnLLMB32YENXPM1wtoNXiFo/RMDnOV/11L
	8KRuiGMyeHVkeve+dsqkjtGuxQznSwpCuDZ/Q56y0xl93vKofx2BZVM1lfxPonG55MkOQiH+pJK
	YaVHv7VJ1MA9Xz8oXB5xss2CmtBtk9Pbw0UVix7GyAljH7ClIFO9gu0UJME3hWvowBRkJO872J7
	gyO9eKubObQLQlIm1PM3bXJ2zosbb+ZhJi+8Iu7u+KwIyuMvnA0Zp8UWtUN/siOLGe0JJFN/ZrG
	yZB5Bw8aIcT1GxdlVP4jWn9WbJZMr2AXbAP8nRnEGIiwLqAJGrX6q37RJSrTYTXSo=
X-Received: by 2002:a05:6122:2093:b0:5c9:a60b:e5d4 with SMTP id 71dfb90a1353d-5c9f165664amr3033636e0c.14.1790171432428;
        Wed, 23 Sep 2026 06:50:32 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c9f04c2a36sm3263916e0c.5.2026.09.23.06.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:50:32 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: zw@zh-kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] dmaengine: fsldma: kill the channel tasklet on remove
Date: Wed, 23 Sep 2026 10:50:21 -0300
Message-ID: <20260923135021.1858325-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fsl_dma_chan_remove() frees the fsldma_chan structure without first
quiescing the channel's tasklet. If an IRQ fires just before the
remove and schedules the tasklet, dma_do_tasklet() runs against the
freed channel struct, causing a use-after-free.

Add tasklet_kill() before tearing the channel down.

Fixes: d3f620b2c4fe ("fsldma: simplify IRQ probing and handling")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/dma/fsldma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 22d62d9..0e2f848 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1205,6 +1205,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 
 static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 {
+	tasklet_kill(&chan->tasklet);
 	irq_dispose_mapping(chan->irq);
 	list_del(&chan->common.device_node);
 	iounmap(chan->regs);
-- 
2.43.0
