Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DA163CB;
	Sun, 30 Aug 2026 15:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788102061; cv=none; b=mgPW1xtA5Hx7XSLELAn1awdN5SE6ERlVHE+WWW/t65c9+SFahuVpRzlkVb9stLuwCcdqOkpQtbTS2D5EdVz3cRnCKPS20PQ5HO93TFKletiAFmU7x/+HCbtrq1SfYwPuKzrQJBDa7aOa8qg27cgt0bSt/+kKcGRztE7iCbUXpnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788102061; c=relaxed/simple;
	bh=fpmQpiLSEDu3jSABFrsjYgl+3bFlGO6oy84CsKKIgas=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jK6mq7HaWGXj23UytpOB2NFTi06tReMT9m6ed3lbxjHt6rTCjy6YcdvKg6uGmxnlhPljFf382czg0RTuuvxK7ahQKHOg7XfRWDJkfRlKl151w5TZi4AGgLVZ7eDGwel9vp/pBUQ75uQy3UzLiLw++f17kjjDHckr95g3ExueOKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=I42t/z3y; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="I42t/z3y"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4bd75fa35;
	Sun, 30 Aug 2026 23:00:52 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: jacopo.mondi@ideasonboard.com
Cc: kernel-list@raspberrypi.com,
	mchehab@kernel.org,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-media@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH] media: pisp_be: Initialize lock before requesting IRQ
Date: Sun, 30 Aug 2026 23:00:45 +0800
Message-Id: <20260830150045.2704062-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa053300a6e03a1kunm4d1b7491104863
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGBhIVh4ZQx8eGh5KHUsfGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=I42t/z3ywPRiOvfmCV2BJ84ZiUZQyXk3UmJAhvfAwrvsvGOT/4Bv6KD1kWi9NFDAM5dPGw2xYi+1J+fKtqucpwg/9ImYriMGACPLTLY8VPZlN4uWQUHVwwz1KF2vJWxYQRbPZK8I0ovJ+kuRUo23xNcyxz3WV0E+exRIpx95YLc=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=rFpzjXZ5IYHG22KLLH2bPfUNBwlnja8+59AgiXh79UA=;
	h=date:mime-version:subject:message-id:from;

The PiSP BE interrupt handler can schedule work that takes hw_lock. The
lock must be initialized before devm_request_irq() makes the handler
runnable.

Fixes: 12187bd5d4f8 ("media: raspberrypi: Add support for PiSP BE")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/media/platform/raspberrypi/pisp_be/pisp_be.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/raspberrypi/pisp_be/pisp_be.c b/drivers/media/platform/raspberrypi/pisp_be/pisp_be.c
index d60d92d2f..43fca54be 100644
--- a/drivers/media/platform/raspberrypi/pisp_be/pisp_be.c
+++ b/drivers/media/platform/raspberrypi/pisp_be/pisp_be.c
@@ -1695,6 +1695,7 @@ static int pispbe_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, pispbe);
 	pispbe->dev = &pdev->dev;
 	platform_set_drvdata(pdev, pispbe);
+	spin_lock_init(&pispbe->hw_lock);
 
 	pispbe->be_reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pispbe->be_reg_base)) {
@@ -1732,7 +1733,6 @@ static int pispbe_probe(struct platform_device *pdev)
 		goto pm_runtime_disable_err;
 
 	pispbe->hw_busy = false;
-	spin_lock_init(&pispbe->hw_lock);
 	ret = pispbe_hw_init(pispbe);
 	if (ret)
 		goto pm_runtime_suspend_err;
-- 
2.34.1

