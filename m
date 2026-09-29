Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8081B51DB0B;
	Tue, 29 Sep 2026 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790678547; cv=none; b=YSXFFS75FVdJQLuarbEDz7AAC6nm8FYxRBeHKGCCoiR4lzfpfDUgTwiHfjOdTV1mrRQjKdk55j7vG1hr9EokJ1Agz9Mz9nbYpDR3FbvCvkNj4gQ5ZjxLijNVe+x8DrHHqIzKiDXq1wdJ4nXrtZppYQYdYxlpv3v4vS2rSgiNgQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790678547; c=relaxed/simple;
	bh=S4c09kf9aEcSEzNcL72zyynKihmSMp2v6pSwv/GmhR8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M5BgGvRVErgJwC+yf+m5sZKaqnqVVZvCNMgtRAclHXaVQPJKGH3QTDeNYaB4URbtaZufpGBTAzwZ4XF+0whxi7WHwbPmVyTlZbJItGIfj7lgVJ7Y0P3gPCbCTNOpsOb7SQbp5TfaMBMmUENKNgN5CQRL8E9l2Bet2/zQju1goRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=hYsiSEty; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="hYsiSEty"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f7ead5a1;
	Tue, 29 Sep 2026 18:42:04 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Nagarjuna Kristam <nkristam@nvidia.com>,
	stable@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] usb: gadget: tegra-xudc: Request IRQ after initialization
Date: Tue, 29 Sep 2026 18:41:58 +0800
Message-Id: <20260929104158.2110698-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0ecc1e1ad03a1kunmc2bed5a02383e5
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHRhPVk8dGU4dT0tPQx9KHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=hYsiSEtynBHDLTcBAOX1zAbmqFXPqcoFl7HGUyacfG4ITPgPrrh3Mc+hjN1h+TQTprWP0vebYRRvmdan+M5ewfaXm/OtBMGsWJNWCdXn07en42lFOobGlNoGvo0Q7OYs3mjaPklS6nhH/9XfMXDr8ts0+pFIBjZu5cpy8Ggwv8c=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=7endw89yCm8iJaPJAZ/yCVPBktC/rUJen6QsQpRssFc=;
	h=date:mime-version:subject:message-id:from;

tegra_xudc_probe() requests the IRQ before initializing the state used by
tegra_xudc_irq(). The handler may run immediately and access the event ring
or lock before they are ready.

Request the IRQ after initializing all handler-visible state and before
usb_add_gadget_udc() publishes the UDC. That call may bind a gadget driver.
If UDC registration fails, release the managed IRQ before freeing state.

Fixes: 49db427232fe ("usb: gadget: Add UDC driver for tegra XUSB device mode controller")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/usb/gadget/udc/tegra-xudc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index e9d33be028664..5b133b9d65631 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -3801,14 +3801,6 @@ static int tegra_xudc_probe(struct platform_device *pdev)
 	if (xudc->irq < 0)
 		return xudc->irq;
 
-	err = devm_request_irq(&pdev->dev, xudc->irq, tegra_xudc_irq, 0,
-			       dev_name(&pdev->dev), xudc);
-	if (err < 0) {
-		dev_err(xudc->dev, "failed to claim IRQ#%u: %d\n", xudc->irq,
-			err);
-		return err;
-	}
-
 	xudc->clks = devm_kcalloc(&pdev->dev, xudc->soc->num_clks, sizeof(*xudc->clks),
 				  GFP_KERNEL);
 	if (!xudc->clks)
@@ -3886,9 +3878,18 @@ static int tegra_xudc_probe(struct platform_device *pdev)
 	xudc->gadget.name = "tegra-xudc";
 	xudc->gadget.max_speed = USB_SPEED_SUPER;
 
+	err = devm_request_irq(&pdev->dev, xudc->irq, tegra_xudc_irq, 0,
+			       dev_name(&pdev->dev), xudc);
+	if (err < 0) {
+		dev_err(xudc->dev, "failed to claim IRQ#%u: %d\n", xudc->irq,
+			err);
+		goto free_eps;
+	}
+
 	err = usb_add_gadget_udc(&pdev->dev, &xudc->gadget);
 	if (err) {
 		dev_err(&pdev->dev, "failed to add USB gadget: %d\n", err);
+		devm_free_irq(&pdev->dev, xudc->irq, xudc);
 		goto free_eps;
 	}
 
-- 
2.34.1

