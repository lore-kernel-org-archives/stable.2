Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61812BFC60;
	Tue, 29 Sep 2026 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790692286; cv=none; b=Izy3Ddr12iDHVDGxHrasYghgAVezlqF7xd1itelFDLZxt71noE1DM+otE+14ah8hnzjqDue1cjBZSsL97R9HYXoenBk0rF3tbMtNlvoiPUDux1OOyTfsf3vhW1UT5rtv6US8UpKSFPHsrWvlnJkmj1Le1NRfrbqw/wPeT+nM1DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790692286; c=relaxed/simple;
	bh=mc0ilMueXZXPuhVX6jYrX0LunRcOPD+Ig24apa308/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lVaNBsjuVKvpm6oyt0tE1DtvLMWrsgJGFJClAW4KvYqIRi842Pgusb7LFlCBHDq7OvIIJPISXwPCsTo7TCqtntTD7SCBFU/B+j1nqbt7T/Ja+Fc9yWY61MUYW2UeMO7/4vid8FTZL3yg4mVQV7jVqbyVetSZMVYLsmqDUl9cHxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=nl5075lJ; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="nl5075lJ"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f83a856d;
	Tue, 29 Sep 2026 22:31:12 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] media: rc: Fix simulated TX timer lifecycle
Date: Tue, 29 Sep 2026 22:31:05 +0800
Message-Id: <20260929143105.2170272-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0ed93a9dd03a1kunmdecca74e242d48
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSkJKVh1JHUxOQkIfGB5JHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=nl5075lJxJ/fPCr70pKfVhRELflboqA/7/pCiO+cMj1BAuNdhJrv/b6jqhdlXhNxVdsYjiMdQQsWpxXtdSf6fhQD10dSvbMOFMmNEjJEtyjCzX5Sk7IHNPJZuqzHAxdlmustOKlmACiHDDhMIeFWvVY7uApx75lZFu9pzNKOpLY=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=E2PrdciCZ3Uc2ciSOa1CzF5S70Ohk9bCqDAdSupoot0=;
	h=date:mime-version:subject:message-id:from;

The ENE driver only initializes tx_sim_timer when TX simulation is
enabled for hardware without native TX support.  However, ene_remove()
passes the timer to timer_delete_sync() unconditionally, and
ene_tx_sample() uses the global txsim parameter when deciding whether to
arm it.  Thus a normal device, or a device with native TX support and
txsim enabled, can operate on an uninitialized timer.

Track whether simulation was actually enabled for each device and use
that state for timer arming and teardown.  Since the simulation callback
rearms the timer, shut it down permanently before freeing the device.

Fixes: 9ea53b74df9c ("V4L/DVB: STAGING: remove lirc_ene0100 driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/media/rc/ene_ir.c | 6 ++++--
 drivers/media/rc/ene_ir.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/rc/ene_ir.c b/drivers/media/rc/ene_ir.c
index 6f7dccc96..9d0279667 100644
--- a/drivers/media/rc/ene_ir.c
+++ b/drivers/media/rc/ene_ir.c
@@ -652,7 +652,7 @@ static void ene_tx_sample(struct ene_device *dev)
 	dev->tx_reg = !dev->tx_reg;
 exit:
 	/* simulate TX done interrupt */
-	if (txsim)
+	if (dev->tx_sim_enabled)
 		mod_timer(&dev->tx_sim_timer, jiffies + HZ / 500);
 }
 
@@ -1032,6 +1032,7 @@ static int ene_probe(struct pnp_dev *pnp_dev, const struct pnp_device_id *id)
 
 	if (!dev->hw_learning_and_tx_capable && txsim) {
 		dev->hw_learning_and_tx_capable = true;
+		dev->tx_sim_enabled = true;
 		timer_setup(&dev->tx_sim_timer, ene_tx_irqsim, 0);
 		pr_warn("Simulation of TX activated\n");
 	}
@@ -1103,7 +1104,8 @@ static void ene_remove(struct pnp_dev *pnp_dev)
 	unsigned long flags;
 
 	rc_unregister_device(dev->rdev);
-	timer_delete_sync(&dev->tx_sim_timer);
+	if (dev->tx_sim_enabled)
+		timer_shutdown_sync(&dev->tx_sim_timer);
 	spin_lock_irqsave(&dev->hw_lock, flags);
 	ene_rx_disable(dev);
 	ene_rx_restore_hw_buffer(dev);
diff --git a/drivers/media/rc/ene_ir.h b/drivers/media/rc/ene_ir.h
index c1c44e86e..f44cbc034 100644
--- a/drivers/media/rc/ene_ir.h
+++ b/drivers/media/rc/ene_ir.h
@@ -218,6 +218,7 @@ struct ene_device {
 	int tx_done;				/* done transmitting */
 						/* one more sample pending*/
 	struct completion tx_complete;		/* TX completion */
+	bool tx_sim_enabled;			/* simulated TX is enabled */
 	struct timer_list tx_sim_timer;
 
 	/* TX settings */
-- 
2.34.1
