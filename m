Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1507B2690EC;
	Sun, 30 Aug 2026 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788102785; cv=none; b=DBHGV3yL2ygrVUhB5CmAlMwkXXwcwFKTUtKbYXvSRqQ5bAXyTdjYfNAkfAXGGfEn2hNI1MjAEgdyLJuSxVRuHrY2D25lCoIm43/0rL6v9jpO+ilI7cFel7qu+t3rt8QwIdByx08Lr03dl9Apr3eZXITzyvz4cJc068sAECuXArw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788102785; c=relaxed/simple;
	bh=IzUNjPhBsfCfXoUGkJXPcgxGo9YeR4g2YWNbQ3T52YA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jj+sgCMDxpo35Jg+YEwu9rcB9D3tUwGJOzvsQJNH9rj8wzOFOEBFFuExjHl0NFXSAQxrFX7diQpcAlsy3JW2gxiNcbrkOfC39TUtpivjms0bEuWod53Eyy4cwtFb8LhjSdeWgbk9BN3N+Cy9D5BOovGpdm58Ehp+TecfgfPdjzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=iNyKp2es; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="iNyKp2es"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4bd7a1dd6;
	Sun, 30 Aug 2026 23:12:47 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: jacopo.mondi@ideasonboard.com,
	mchehab@kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH] media: platform: rzg2l-cru: Initialize lock before requesting IRQ
Date: Sun, 30 Aug 2026 23:12:41 +0800
Message-Id: <20260830151241.2706370-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0533af3ff03a1kunmdc285e41104ee1
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCH01PVk5OHxlKSU0aTxpPH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=iNyKp2esiYcw2btnJG4swCh1aziuOxvwa/Wj8rWiObzff0U9lN8NpvVYKrCsTYtEQFqRcr4kiI6uFpn9UwmArwD39vfac8vwc5x9o+LNoeWR9w3rPeDmxBA5UiQugHWNtMPwJU3xmXTaG5SKZhKHgwqIody3kiqlHH5HPbb8Kzw=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=GZqszPOpzCr2YKcKxfAhZUtmepn/2OYB9XsHvo0LUx0=;
	h=date:mime-version:subject:message-id:from;

rzg2l_cru_probe() requests the CRU interrupt before calling
rzg2l_cru_dma_register(). The latter initializes cru->hw_lock, which is
acquired by the IRQ handlers.

An interrupt can be delivered as soon as devm_request_irq() succeeds, so
the handler can observe hw_lock before it has been initialized. Initialize
hw_lock before requesting the IRQ and remove the later duplicate
initialization.

Fixes: 0c200daa5780 ("media: platform: rzg2l-cru: rzg2l-video: Move request_irq() to probe()")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Assisted-by: Codex:GPT-5
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c  | 1 +
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
index 798ef2916..3edb9d3c4 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
@@ -269,6 +269,7 @@ static int rzg2l_cru_probe(struct platform_device *pdev)
 
 	cru->dev = dev;
 	cru->info = of_device_get_match_data(dev);
+	spin_lock_init(&cru->hw_lock);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 91eda5034..a92d87d53 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -784,7 +784,6 @@ int rzg2l_cru_dma_register(struct rzg2l_cru_dev *cru)
 	mutex_init(&cru->lock);
 	INIT_LIST_HEAD(&cru->buf_list);
 
-	spin_lock_init(&cru->hw_lock);
 	spin_lock_init(&cru->qlock);
 
 	for (i = 0; i < RZG2L_CRU_HW_BUFFER_MAX; i++)
-- 
2.34.1

