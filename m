Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBD33C062C;
	Thu, 10 Sep 2026 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789031853; cv=none; b=EuOz4GdgyqO6Mw+1U3hX9k3qFH22tlXgSDYmB1NWVnkTxlvstajvKlizM95NyJBXmrwnrRXh3lJX+RGHJsjUBjTHbgcAKc7oHmEhdLWQBWV+7oVJ1fOvVWa0SCTpEqE9YX0dCcqYzgKwZC4n6MmKM++UcP0cvT9dD7TfZDnW9BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789031853; c=relaxed/simple;
	bh=spcY7BAJlwHGX3P6IbcL5dGWXcunffCu+E+SqKxqqA0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JXFrJLuxZH+hceovYzcqAhPnPsoxvpM5fT2B3z+vOu+VfzK8rh/LNsXLdiluLEVXBJGVTm8q7S8Ik7zK3LaJa1Fq1eEBs2oCuTP4XpzGhJIKj9ohKv+tP/TUo07t3/IQ0Z3/uXjuww/wosv3jPrjhnHvWYvtr3ztrzcFde4IEjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Dgz7ArZD; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Dgz7ArZD"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d445a2a0;
	Thu, 10 Sep 2026 17:17:24 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Christian Gromm <christian.gromm@microchip.com>
Cc: linux-kernel@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] most: cdev: Initialize channel state before registering cdev
Date: Thu, 10 Sep 2026 17:17:19 +0800
Message-Id: <20260910091719.1283885-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa08a9b8be703a1kunmb66a157718f583
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaH05DVkkZTUodTkhCQx5DSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Dgz7ArZDGOkSROW8CuLdmEAKICxPUC9j71beV9aOdzPYTVcKkgg5/ozTpYG8Im2iAKV5vkK2Yg0JmZulbSAIUX8kOvkKCxFoVsWua9xDxdvus74E4fzpE1+K+ZDYkq2X4LSOb48bBQy1CWbmEpGlha34DuZuAXB/ObPDn1pArdk=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=e1jaTxcx/XNok3j6cDu7+JqblaXR+dPgZged9a4iIFA=;
	h=date:mime-version:subject:message-id:from;

comp_probe() registers the channel cdev before initializing c->cfg,
c->io_mutex, and the other state used by channel_fops. cdev_add() makes
the cdev live immediately, so an open through the registered device can
reach comp_open() while the channel is only partially initialized.

Initialize the channel state and allocate its FIFO before calling
cdev_add(). Release the FIFO if registering the cdev fails.

Fixes: ceea93444808 ("drivers: most: add character device interface driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM Codex
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/most/most_cdev.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/most/most_cdev.c b/drivers/most/most_cdev.c
index 5df508d8d..75b413359 100644
--- a/drivers/most/most_cdev.c
+++ b/drivers/most/most_cdev.c
@@ -441,20 +441,22 @@ static int comp_probe(struct most_interface *iface, int channel_id,
 	c->devno = MKDEV(comp.major, current_minor);
 	cdev_init(&c->cdev, &channel_fops);
 	c->cdev.owner = THIS_MODULE;
-	retval = cdev_add(&c->cdev, c->devno, 1);
-	if (retval < 0)
-		goto err_free_c;
 	c->iface = iface;
 	c->cfg = cfg;
 	c->channel_id = channel_id;
 	c->access_ref = 0;
 	spin_lock_init(&c->unlink);
 	INIT_KFIFO(c->fifo);
-	retval = kfifo_alloc(&c->fifo, cfg->num_buffers, GFP_KERNEL);
-	if (retval)
-		goto err_del_cdev_and_free_channel;
 	init_waitqueue_head(&c->wq);
 	mutex_init(&c->io_mutex);
+	retval = kfifo_alloc(&c->fifo, cfg->num_buffers, GFP_KERNEL);
+	if (retval)
+		goto err_free_c;
+	retval = cdev_add(&c->cdev, c->devno, 1);
+	if (retval < 0) {
+		kfifo_free(&c->fifo);
+		goto err_free_c;
+	}
 	spin_lock_irqsave(&ch_list_lock, cl_flags);
 	list_add_tail(&c->list, &channel_list);
 	spin_unlock_irqrestore(&ch_list_lock, cl_flags);
@@ -470,7 +472,6 @@ static int comp_probe(struct most_interface *iface, int channel_id,
 err_free_kfifo_and_del_list:
 	kfifo_free(&c->fifo);
 	list_del(&c->list);
-err_del_cdev_and_free_channel:
 	cdev_del(&c->cdev);
 err_free_c:
 	kfree(c);
-- 
2.34.1

