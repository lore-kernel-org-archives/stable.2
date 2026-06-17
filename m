Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03818288D0;
	Wed, 17 Jun 2026 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708825; cv=none; b=NYVgAe72ko4H5UgXTK2y5wWyukIrzMVdhsfcU6/lLXuqdeNjn9hxi2CXRFhvxAEP/Pt0wmq836hkdoPiGuU6NqgNYRmGA/wgiJM4LnG8eStjtfbqmDqFqYSOgCDE/KmLRB0xCV31VXeLvHAKQZFNtIx6t0eEMxs2dq/nWNG1e8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708825; c=relaxed/simple;
	bh=aQbg1YvfiQDdp+2LZACTnYqzfGQ9WFK8VhEU7/1Oa7A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oBAuovuen7IHcmBDi3hIyJoneKm5t2edZ+IY4qElmP440EoAf3tcYOkEz8rkyRdqugWWzCSA10ZewXO3JvZPPmbUlE6JE3ZnuEIFtTBnlJJ81fcSQ8QMDQhqqa9t4wsIQ2UTxYfgTpvzMoaA3k/MbmKGdlyb/SbM0c/JFF8v160=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=mg4p7HEH; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="mg4p7HEH"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 42c696515;
	Wed, 17 Jun 2026 23:01:44 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Jorge Marques <jorge.marques@analog.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Frank Li <Frank.Li@nxp.com>,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH] i3c: master: adi: initialize the lock before enabling interrupts
Date: Wed, 17 Jun 2026 23:01:38 +0800
Message-Id: <20260617150138.628578-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ed61a3cb903a1kunm30aede3e71fad
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGUpNVkNJHk9PT0NJH0wYH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=mg4p7HEHY8vmP8MknhhjbKoZBcw3shn2hzBZBbfIK7chKfApm6cwCjHgmcGiuCUmK+zVBVtBTdAhYZTz3+gW1Z5r1Wx2q5llxdusNFsh66S9cmKxggnXcvCB8RsRBXwWRQCcCKTzZ797VQsN7i+BBIXJiCD80Svx3/O0tG6qpvI=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=oP+7Fqj5obiHqmRzGIe8ikds8jQUQ2UQELMJxvRP8PA=;
	h=date:mime-version:subject:message-id:from;

adi_i3c_master_probe() requests the IRQ and unmasks REG_IRQ_PENDING_CMDR
before the controller's IBI state, transfer queue list and transfer
queue lock are initialized.  A pending CMDR interrupt can therefore run
adi_i3c_master_irq() and take master->xferqueue.lock before the dynamic
lock has been initialized.

This issue was found by our static analysis tool and then manually
reviewed against the current tree.

The grounded PoC kept the probe ordering and the IRQ path
adi_i3c_master_probe() -> adi_i3c_master_irq() -> xferqueue.lock, with a
pending CMDR interrupt arriving after REG_IRQ_PENDING_CMDR is unmasked.
Lockdep reported:

  INFO: trying to register non-static key.
  you didn't initialize this object before use?
  lock_acquire+0xbb/0x290
  _raw_spin_lock_irqsave+0x36/0x60
  adi_i3c_master_irq+0x32/0x56 [vuln_msv]
  adi_i3c_master_probe+0x5a/0xf47 [vuln_msv]

Initialize the transfer queue and IBI state before requesting and
unmasking the IRQ.

Fixes: a79ac2cdc91d ("i3c: master: Add driver for Analog Devices I3C Controller IP")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/i3c/master/adi-i3c-master.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/i3c/master/adi-i3c-master.c b/drivers/i3c/master/adi-i3c-master.c
index 82ac0b3d057a..cf873d46e10f 100644
--- a/drivers/i3c/master/adi-i3c-master.c
+++ b/drivers/i3c/master/adi-i3c-master.c
@@ -967,17 +967,9 @@ static int adi_i3c_master_probe(struct platform_device *pdev)
 	writel(0x00, master->regs + REG_ENABLE);
 	writel(0x00, master->regs + REG_IRQ_MASK);
 
-	ret = devm_request_irq(&pdev->dev, irq, adi_i3c_master_irq, 0,
-			       dev_name(&pdev->dev), master);
-	if (ret)
-		return ret;
-
 	platform_set_drvdata(pdev, master);
 
 	master->free_rr_slots = GENMASK(ADI_MAX_DEVS, 1);
-
-	writel(REG_IRQ_PENDING_CMDR, master->regs + REG_IRQ_MASK);
-
 	spin_lock_init(&master->ibi.lock);
 	master->ibi.num_slots = 15;
 	master->ibi.slots = devm_kcalloc(&pdev->dev, master->ibi.num_slots,
@@ -989,6 +981,13 @@ static int adi_i3c_master_probe(struct platform_device *pdev)
 	spin_lock_init(&master->xferqueue.lock);
 	INIT_LIST_HEAD(&master->xferqueue.list);
 
+	ret = devm_request_irq(&pdev->dev, irq, adi_i3c_master_irq, 0,
+			       dev_name(&pdev->dev), master);
+	if (ret)
+		return ret;
+
+	writel(REG_IRQ_PENDING_CMDR, master->regs + REG_IRQ_MASK);
+
 	return i3c_master_register(&master->base, &pdev->dev,
 				   &adi_i3c_master_ops, false);
 }
-- 
2.34.1

