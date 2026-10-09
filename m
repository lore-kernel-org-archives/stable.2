Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2AB34D3A9;
	Fri,  9 Oct 2026 06:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791525736; cv=none; b=Mqhe0hQTCRXp3zYbFMKjTMwmuiKi0FWGB9oBdugabGoMdk6WitemUX3xrp2041+4i2v0LNi42HuY0OrCWD6if1HSaFO8ATKkJK5MQVnnTWKC9xJ1DuXNdBSHN+W2nI4DGIyD9lowxC/2WI4hke5pkV5lmSEIaxN6Y5Hcj+J3rYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791525736; c=relaxed/simple;
	bh=ciZC9Ssy3NRSl89akavzoCl38muqMjVbA1w5ik6Iqs0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OijzmPi6FEijpCiO20BSwVV8Zvn0KPRWvljdXySaQkSUTo/2T0Ns+wnayCKPB7sljZYosPvAhYKsQT8MdqN0ey/I/onzQ+wLhM7Ea3ZMDB7IAPiFqGmzC425QzSBodNzaDp/0uZV9SKJ6naB49AFSFSi3dASPskKZ2TBkvs7XXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=fpIgAxC3; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="fpIgAxC3"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 506751e12;
	Fri, 9 Oct 2026 14:02:07 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] memory: fsl_ifc: guard optional NAND IRQ cleanup
Date: Fri,  9 Oct 2026 14:01:55 +0800
Message-Id: <20261009060155.1162262-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa11f412c2703a1kunm0de001d3439d46
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHR4ZVkhPTExMTR8fS0MaSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=fpIgAxC3oaaXePrSKO33OSXjjGzjDRo5AdaHTunRNO4vU0GlF8zKK1fFZzo3e6wOxokJURjGUlXc6Ftu6wz7lTGvGHeJYhowYH3g4/+5fdTkyLz4jXt6L5p6osAdzbmISehe7hYVzisjILM/9cYxm6+N1pBDe3Pp8j+XZDdBDh4=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=rIx21gW6rbftWZ/7ACCjR7eG2Pqkz9C3Ir/UcsoKq9I=;
	h=date:mime-version:subject:message-id:from;

The IFC device tree binding permits a controller to provide only the
common interrupt. In that configuration, irq_of_parse_and_map() returns
0 for the optional NAND IRQ and probe skips request_irq(), but both the
probe unwind and remove paths still call free_irq() unconditionally.

Guard the NAND IRQ cleanup with a check for a non-zero IRQ.

Fixes: 721c0705906e ("powerpc/mpc85xx: Update interrupt handling for IFC controller")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/memory/fsl_ifc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
index e89e0c6cc4..6dcc317d95 100644
--- a/drivers/memory/fsl_ifc.c
+++ b/drivers/memory/fsl_ifc.c
@@ -89,7 +89,8 @@ static void fsl_ifc_ctrl_remove(struct platform_device *dev)
 	struct fsl_ifc_ctrl *ctrl = dev_get_drvdata(&dev->dev);
 
 	of_platform_depopulate(&dev->dev);
-	free_irq(ctrl->nand_irq, ctrl);
+	if (ctrl->nand_irq)
+		free_irq(ctrl->nand_irq, ctrl);
 	free_irq(ctrl->irq, ctrl);
 
 	irq_dispose_mapping(ctrl->nand_irq);
@@ -292,7 +293,8 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
 	return 0;
 
 err_free_nandirq:
-	free_irq(fsl_ifc_ctrl_dev->nand_irq, fsl_ifc_ctrl_dev);
+	if (fsl_ifc_ctrl_dev->nand_irq)
+		free_irq(fsl_ifc_ctrl_dev->nand_irq, fsl_ifc_ctrl_dev);
 err_free_irq:
 	free_irq(fsl_ifc_ctrl_dev->irq, fsl_ifc_ctrl_dev);
 err_unmap_nandirq:
