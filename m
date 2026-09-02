Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF46377EC2;
	Wed,  2 Sep 2026 07:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332759; cv=none; b=SP8OkU+ncXgzWmh5LJqhMkoRkZSe/KulFPB/XT/Hw0gDP6qpnRTv1i4YfWa4uwhc+CdzF2Nrq/m+XbVpz412IybTX/tldvIXJzRYjljvGv/5yXAFmLpSivWhYHyOkhCJiLJcEjo0Ci5zQt8/Imp+hLXIAeU1Od/VtDQ1QNreYUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332759; c=relaxed/simple;
	bh=X5smk5m4c/0Qb7uJ+Q9zZGtk0FDn9O2GrWMCg1RN7b0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ezl3PhrTTm8dhmUwdVLSH7PWs1yts+f0MIZBA9pAzAEQtjPJGbKqdPV2mI7v955tU0pqihYCn+zSd5oNMFr83RJzuh/DFB7Fh2pcBbclOJzqeHe7SWmeVmEHGnGkNvcX4MKKFzb7niIbo6Iwn4d+CM+cxEu1o54bUG7wUnofT5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=d7OPUNb3; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="d7OPUNb3"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c3a2356d;
	Wed, 2 Sep 2026 15:05:50 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] mtd: rawnand: cadence: Initialize IRQ state before requesting IRQ
Date: Wed,  2 Sep 2026 15:05:42 +0800
Message-Id: <20260902070542.3485515-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa060f034f303a1kunmf845d501199cbc
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSEoYVktOT0oYTh5PSBkfSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=d7OPUNb3F7IFjgZDDDZlrJpC4LQHmUSt52A22+keUTpatCnMuSTXC8M32Rr8pyabBMgFYf4hXcwk4IkB8gpS9Dn884aUuW0uCFEnUJR78Sc+1xJ/SzclqzVgakdEEVNl2sv8ixhG8+TiChm+Tx/UNI1b1mWdffBM1B1z4R4emz0=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=UKVt8CRyy8NuzNyQNeB1dgvHDG2t7AG0+OHEbcD2evA=;
	h=date:mime-version:subject:message-id:from;

The Cadence NAND interrupt handler uses both the IRQ lock and completion
object. Registering the IRQ before initializing them leaves a window in
which a pending interrupt can access uninitialized synchronization state.

Initialize them before registering the handler.

Fixes: ec4ba01e894d ("mtd: rawnand: Add new Cadence NAND driver to MTD subsystem")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/mtd/nand/raw/cadence-nand-controller.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index d53b35a8b..cff36ea3a 100644
--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -3143,6 +3143,9 @@ static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
 		goto free_buf_desc;
 	}
 
+	spin_lock_init(&cdns_ctrl->irq_lock);
+	init_completion(&cdns_ctrl->complete);
+
 	if (devm_request_irq(cdns_ctrl->dev, cdns_ctrl->irq, cadence_nand_isr,
 			     IRQF_SHARED, "cadence-nand-controller",
 			     cdns_ctrl)) {
@@ -3151,9 +3154,6 @@ static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
 		goto free_buf;
 	}
 
-	spin_lock_init(&cdns_ctrl->irq_lock);
-	init_completion(&cdns_ctrl->complete);
-
 	ret = cadence_nand_hw_init(cdns_ctrl);
 	if (ret)
 		goto disable_irq;
-- 
2.34.1
