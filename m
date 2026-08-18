Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72594392C4C;
	Tue, 18 Aug 2026 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787061220; cv=none; b=GIDZd9EzTg5JUNp+HR6TyYnG3Xx8NmhNCYMYAWmPvSZ6aMNxrZYn20/cFkMDjCcbfZ0CUccdpk9T1NhBgo3UHNKQE6UyipLuZQQrsPViat1AlIzQXTcn3dw+FbIyiQJ7NDwfBTiTJ7Yj+Clkvuh9Isd847EIN1CSAZaLHAl1d5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787061220; c=relaxed/simple;
	bh=e1tuGGIP/ZBZCvqevNu0/K1XTDfvFeK+Xm8w4RcQAic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iHXr3FCVVn1VgMT3d9j4D0M6AxD4n6fXFbmp0ODCC1rANtbc1Xn6QzIfDiIwVDj+wE3++49s3+HzqRK81Iw65LK4iMc3h6Wa9M4ohenv8XRCJY2fdEMoloHsjoCFElSqlg2wye67cG9VenpVayTuMYASAw1/9Ijzw4Nq/ESXLGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=G0qBUXxe; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="G0qBUXxe"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4a6d2cde8;
	Tue, 18 Aug 2026 21:53:24 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Helge Deller <deller@gmx.de>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
	Dave Airlie <airlied@gmail.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	linux-omap@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] fbdev: omapfb: panel-dsi-cm: initialize lock before registering display
Date: Tue, 18 Aug 2026 21:53:18 +0800
Message-Id: <20260818135318.1957283-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa01525f6e303a1kunm72eec736112e9a
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaQhlPVkIaSxgfSkpPQ0lMSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=G0qBUXxeocdkLCIoutjgBg2bW2KZzL0MMhhr5go1jone8lqArYrEx392j8fvU7hKyeADD48P3x9yYzvSsZZxZmw+XGGj5N0i2tv9yKx74lWGwpObIE5iRlIxJymIB4BgTxSH6XNiQrB4AheC42H9pWUbPvEGU4wuWrwklBQDJXI=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=s8wa7yiZYDJ20bpSxGQc5WMiume6jdmMCtn+WJuBMr4=;
	h=date:mime-version:subject:message-id:from;

dsicm_probe() registers the display before initializing ddata->lock.
Once omapdss_register_display() publishes the display, another consumer
can reach a dsicm callback that takes this mutex while it is still
uninitialized.

Initialize the mutex before registering the display so the published
callbacks always see a valid lock.

Fixes: f76ee892a99e ("omapfb: copy omapdss & displays for omapfb")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
index 1d75f27c6b80..ce1d4d5f4034 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
@@ -1151,14 +1151,14 @@ static int dsicm_probe(struct platform_device *pdev)
 	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE |
 		OMAP_DSS_DISPLAY_CAP_TEAR_ELIM;
 
+	mutex_init(&ddata->lock);
+
 	r = omapdss_register_display(dssdev);
 	if (r) {
 		dev_err(dev, "Failed to register panel\n");
 		goto err_reg;
 	}
 
-	mutex_init(&ddata->lock);
-
 	atomic_set(&ddata->do_update, 0);
 
 	ddata->reset_gpio = devm_gpiod_get(&pdev->dev, "reset", GPIOD_OUT_LOW);
-- 
2.34.1

