Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818C83B8D75;
	Sun, 30 Aug 2026 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100218; cv=none; b=ag6Ef2rbtw2e6RzDH/jEnik2WXJPsIuAX6C7Iri/q3pBjMk7GZ51auFHNH+2NhKQW3F45iLRygVtBoiQoBde3g5M9/BjIWaeld0OBI1Do9XADkvOpSdDxhTrwwuPkPWnMdUJA+bQcTZW5kUsOeRDpxxisxgjZK0h7N3RhXZIXTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100218; c=relaxed/simple;
	bh=Ct2NO6oH56nH2n0sDUC8gwPDJxIDC5PQ/X6CYFsBDLg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VyGQXuiz4BII2zzFTXJFO8Sp3xdQQ2QJswGtfhiZszPYwEddivOBdrCaF2RCX4yzEHq1SDptvREY3z+kaWMiUCYgzZS0bG9h+lHbYFtiqq1b4+/fHvXmL93EQCQ4s9b7f20LWdaozApEkDxc1zPYGMIP6gds20H4Q2fHIphRfqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Siq1YIim; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Siq1YIim"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4bd71cc71;
	Sun, 30 Aug 2026 22:30:10 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: hverkuil@kernel.org
Cc: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH] media: saa7146: Initialize interrupt lock before requesting IRQ
Date: Sun, 30 Aug 2026 22:30:02 +0800
Message-Id: <20260830143002.2690859-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa05313edb203a1kunmead4b91a1036b9
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaQ0wdVhkdHU4fSRpMSkxKHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Siq1YIimVIs9LPHJOGODF/IA9y9cLzwnQL2Xu+VqRCmwY+VgJ+jL2VL3d/W6TUP/aEIoJodNV5CfC6QhJZbLiCAhFsqbMYLuD3UByGAukRvkSXjFHksLnHHKPqV35A/1fGMBbqsSM7dqLp7V/Phd6X5AS1FxzCOC/olLDCxdzfo=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=Xi/wrjSw+AJTVv12s/i3arvf8gyonJf1sgsdvGreaEU=;
	h=date:mime-version:subject:message-id:from;

The saa7146 interrupt handler can call SAA7146_IER_DISABLE(), which
serializes register access with dev->int_slock. request_irq() allows the
shared handler to run before saa7146_init_one() reaches the current lock
initialization block.

Initialize dev->int_slock before requesting the interrupt so every handler
path sees an initialized lock.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/media/common/saa7146/saa7146_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/common/saa7146/saa7146_core.c b/drivers/media/common/saa7146/saa7146_core.c
index c297d019f..70d6ca005 100644
--- a/drivers/media/common/saa7146/saa7146_core.c
+++ b/drivers/media/common/saa7146/saa7146_core.c
@@ -340,6 +340,8 @@ static int saa7146_init_one(struct pci_dev *pci, const struct pci_device_id *ent
 		goto out;
 	}
 
+	spin_lock_init(&dev->int_slock);
+
 	/* create a nice device name */
 	sprintf(dev->name, "saa7146 (%d)", saa7146_num);
 
@@ -425,7 +427,6 @@ static int saa7146_init_one(struct pci_dev *pci, const struct pci_device_id *ent
 	dev->ext = ext;
 
 	mutex_init(&dev->v4l2_lock);
-	spin_lock_init(&dev->int_slock);
 	spin_lock_init(&dev->slock);
 
 	mutex_init(&dev->i2c_lock);
-- 
2.34.1

