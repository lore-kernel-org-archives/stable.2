Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A3235DA42;
	Sat,  8 Aug 2026 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786178109; cv=none; b=X2PY3uPMcvk/fUXeJjChQc1idAqo2IfCvZNGbJp4ct9ATTh1U3TeQd1X832621A2nOltAY7n43nxn67dwNNotYYJxQ5tJqR0JR8mdMEs+Iz6ibL9HXU8IAbvOa22YFEx4hUyaD2Mxr/iF1E+ORpu4IkCEgLDcWaI9FmRGPsFOw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786178109; c=relaxed/simple;
	bh=bNHASFMSou2FDTTKG9fJ7Zd7Z4wk2WgchNUAncvFo7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uGM0BSEm34fj8X+G/x5EIWztkmsVBwwlTsBQhrYfEg8aNAiRey7Ioaz9b2PvJkPSdkFrfSG6vesRJehzK5P42JEf89ILNJcC/ejwuMpkS1NsX+0h4R5gK97dsaqoGVruh3TMsCXOm5+7zZvPfisA3r4Rb92Iff8+ZZu0RDNUE/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=BGgysiV5; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="BGgysiV5"
Received: from LAPTOP-99KJFSET (unknown [36.153.54.46])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4940f033d;
	Sat, 8 Aug 2026 16:34:58 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Stephan Gerhold <stephan@gerhold.net>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Hongyan Xu <getshell@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: wwan: qcom_bam_dmux: fix TX DMA channel use-after-free
Date: Sat,  8 Aug 2026 16:34:57 +0800
Message-ID: <20260808083457.2023-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fe082d3a903a1kunm7d2dca154edf2
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSEJCVkgeTR9PQx1PTB4ZT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VT01ZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
DKIM-Signature: a=rsa-sha256;
	b=BGgysiV59sM89y8rF0ZB92EgTk1+jwjKoiHeQQtp1fvruqZbQOZvwicGwOmbUSmCJH8VZ+OVBwvsZS5zOikjk9C3I0PfBC6YXHqFEkO7j26tpo/HhfEdapMCPDA6Drgqt+uS2xym2q2QogZvrLfxsbRZOSF0oqZkjCE7vH77hJU=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=Hli+a2lRQuw4lNJO219qSpvui88vtUc2yHukHGclxLk=;
	h=date:mime-version:subject:message-id:from;

The modem power-control interrupt can currently call bam_dmux_power_off()
and release dmux->tx while the host side still has an active runtime PM
vote and is preparing or issuing TX DMA descriptors. Runtime PM prevents
the runtime suspend callback from running in that window, but it does not
serialize the modem-driven pc interrupt with the command, netdev transmit,
or deferred wakeup paths that use dmux->tx.

Serialize power-control state with a mutex and track the host pc vote under
that lock. If the modem reports pc=false while the host vote is still
active, acknowledge the pc transition but keep the DMA channels allocated.
This avoids releasing the TX channel underneath active users and avoids
terminating already queued commands such as BAM_DMUX_CMD_OPEN.

Synchronize the pc interrupt around the runtime-resume pc-ack sequence.
This makes a delayed pc=false interrupt run before runtime resume decides
that the remote side is up and requests the TX channel.

This issue was found by the author's in-house static analysis tool.
The patch was reviewed by the author.

Fixes: 21a0ffd9b38c ("net: wwan: Add Qualcomm BAM-DMUX WWAN network driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
v2:
- Drop the SRCU-based TX channel publishing from v1.
- Keep DMA channels allocated while the host pc vote is active, so a
  delayed pc=false IRQ cannot terminate queued TX commands or descriptors.
- Serialize pc IRQ handling with runtime PM power transitions.
- Post as a new netdev thread, as requested by
  Documentation/process/maintainer-netdev.rst.

v1: https://lore.kernel.org/netdev/20260806060642.1281-1-getshell@seu.edu.cn/

 drivers/net/wwan/qcom_bam_dmux.c | 81 +++++++++++++++++++++++++++-----
 1 file changed, 68 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
index cc6ace8..91b13b9 100644
--- a/drivers/net/wwan/qcom_bam_dmux.c
+++ b/drivers/net/wwan/qcom_bam_dmux.c
@@ -12,6 +12,7 @@
 #include <linux/if_arp.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/netdevice.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -73,6 +74,8 @@ struct bam_dmux {
 	u32 pc_mask, pc_ack_mask;
 	wait_queue_head_t pc_wait;
 	struct completion pc_ack_completion;
+	struct mutex power_lock; /* Protect power-control state */
+	bool pc_vote;
 
 	struct dma_chan *rx, *tx;
 	struct bam_dmux_skb_dma rx_skbs[BAM_DMUX_NUM_SKB];
@@ -99,6 +102,21 @@ static void bam_dmux_pc_vote(struct bam_dmux *dmux, bool enable)
 				    enable ? dmux->pc_mask : 0);
 }
 
+static void bam_dmux_pc_vote_locked(struct bam_dmux *dmux, bool enable)
+{
+	lockdep_assert_held(&dmux->power_lock);
+
+	dmux->pc_vote = enable;
+	bam_dmux_pc_vote(dmux, enable);
+}
+
+static void bam_dmux_pc_vote_protected(struct bam_dmux *dmux, bool enable)
+{
+	mutex_lock(&dmux->power_lock);
+	bam_dmux_pc_vote_locked(dmux, enable);
+	mutex_unlock(&dmux->power_lock);
+}
+
 static void bam_dmux_pc_ack(struct bam_dmux *dmux)
 {
 	qcom_smem_state_update_bits(dmux->pc_ack, dmux->pc_ack_mask,
@@ -655,6 +673,8 @@ static void bam_dmux_free_skbs(struct bam_dmux_skb_dma skbs[],
 
 static void bam_dmux_power_off(struct bam_dmux *dmux)
 {
+	lockdep_assert_held(&dmux->power_lock);
+
 	if (dmux->tx) {
 		dmaengine_terminate_sync(dmux->tx);
 		dma_release_channel(dmux->tx);
@@ -673,21 +693,28 @@ static void bam_dmux_power_off(struct bam_dmux *dmux)
 static irqreturn_t bam_dmux_pc_irq(int irq, void *data)
 {
 	struct bam_dmux *dmux = data;
-	bool new_state = !dmux->pc_state;
+	bool new_state;
+
+	mutex_lock(&dmux->power_lock);
+	new_state = !dmux->pc_state;
 
 	dev_dbg(dmux->dev, "pc: %u\n", new_state);
 
 	if (new_state) {
-		if (bam_dmux_power_on(dmux))
+		if (dmux->rx || bam_dmux_power_on(dmux))
 			bam_dmux_pc_ack(dmux);
 		else
 			bam_dmux_power_off(dmux);
+	} else if (dmux->pc_vote) {
+		dev_dbg(dmux->dev, "pc down while host vote is active\n");
+		bam_dmux_pc_ack(dmux);
 	} else {
 		bam_dmux_power_off(dmux);
 		bam_dmux_pc_ack(dmux);
 	}
 
-	dmux->pc_state = new_state;
+	WRITE_ONCE(dmux->pc_state, new_state);
+	mutex_unlock(&dmux->power_lock);
 	wake_up_all(&dmux->pc_wait);
 
 	return IRQ_HANDLED;
@@ -708,7 +735,12 @@ static int bam_dmux_runtime_suspend(struct device *dev)
 	struct bam_dmux *dmux = dev_get_drvdata(dev);
 
 	dev_dbg(dev, "runtime suspend\n");
-	bam_dmux_pc_vote(dmux, false);
+
+	mutex_lock(&dmux->power_lock);
+	bam_dmux_pc_vote_locked(dmux, false);
+	if (!dmux->pc_state)
+		bam_dmux_power_off(dmux);
+	mutex_unlock(&dmux->power_lock);
 
 	return 0;
 }
@@ -724,40 +756,55 @@ static int __maybe_unused bam_dmux_runtime_resume(struct device *dev)
 					 BAM_DMUX_REMOTE_TIMEOUT))
 		return -ETIMEDOUT;
 
+	synchronize_irq(dmux->pc_irq);
+
 	/* Vote for power state */
-	bam_dmux_pc_vote(dmux, true);
+	bam_dmux_pc_vote_protected(dmux, true);
 
 	/* Wait for ack */
 	if (!wait_for_completion_timeout(&dmux->pc_ack_completion,
 					 BAM_DMUX_REMOTE_TIMEOUT)) {
-		bam_dmux_pc_vote(dmux, false);
+		bam_dmux_runtime_suspend(dev);
 		return -ETIMEDOUT;
 	}
 
+	synchronize_irq(dmux->pc_irq);
+
 	/* Wait until we're up */
-	if (!wait_event_timeout(dmux->pc_wait, dmux->pc_state,
+	if (!wait_event_timeout(dmux->pc_wait, READ_ONCE(dmux->pc_state),
 				BAM_DMUX_REMOTE_TIMEOUT)) {
-		bam_dmux_pc_vote(dmux, false);
+		bam_dmux_runtime_suspend(dev);
 		return -ETIMEDOUT;
 	}
 
+	mutex_lock(&dmux->power_lock);
+
 	/* Ensure that we actually initialized successfully */
 	if (!dmux->rx) {
-		bam_dmux_pc_vote(dmux, false);
+		bam_dmux_pc_vote_locked(dmux, false);
+		if (!dmux->pc_state)
+			bam_dmux_power_off(dmux);
+		mutex_unlock(&dmux->power_lock);
 		return -ENXIO;
 	}
 
 	/* Request TX channel if necessary */
-	if (dmux->tx)
+	if (dmux->tx) {
+		mutex_unlock(&dmux->power_lock);
 		return 0;
+	}
 
 	dmux->tx = dma_request_chan(dev, "tx");
 	if (IS_ERR(dmux->tx)) {
 		dev_err(dev, "Failed to request TX DMA channel: %pe\n", dmux->tx);
 		dmux->tx = NULL;
-		bam_dmux_runtime_suspend(dev);
+		bam_dmux_pc_vote_locked(dmux, false);
+		if (!dmux->pc_state)
+			bam_dmux_power_off(dmux);
+		mutex_unlock(&dmux->power_lock);
 		return -ENXIO;
 	}
+	mutex_unlock(&dmux->power_lock);
 
 	return 0;
 }
@@ -799,6 +846,7 @@ static int bam_dmux_probe(struct platform_device *pdev)
 	init_waitqueue_head(&dmux->pc_wait);
 	init_completion(&dmux->pc_ack_completion);
 	complete_all(&dmux->pc_ack_completion);
+	mutex_init(&dmux->power_lock);
 
 	spin_lock_init(&dmux->tx_lock);
 	INIT_WORK(&dmux->tx_wakeup_work, bam_dmux_tx_wakeup_work);
@@ -827,10 +875,11 @@ static int bam_dmux_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_disable_pm;
 
+	mutex_lock(&dmux->power_lock);
 	ret = irq_get_irqchip_state(dmux->pc_irq, IRQCHIP_STATE_LINE_LEVEL,
 				    &dmux->pc_state);
 	if (ret)
-		goto err_disable_pm;
+		goto err_unlock_power;
 
 	/* Check if remote finished initialization before us */
 	if (dmux->pc_state) {
@@ -839,9 +888,12 @@ static int bam_dmux_probe(struct platform_device *pdev)
 		else
 			bam_dmux_power_off(dmux);
 	}
+	mutex_unlock(&dmux->power_lock);
 
 	return 0;
 
+err_unlock_power:
+	mutex_unlock(&dmux->power_lock);
 err_disable_pm:
 	pm_runtime_disable(dev);
 	pm_runtime_dont_use_autosuspend(dev);
@@ -872,12 +924,15 @@ static void bam_dmux_remove(struct platform_device *pdev)
 	pm_runtime_set_suspended(dev);
 
 	/* Try to wait for remote side to drop power vote */
-	if (!wait_event_timeout(dmux->pc_wait, !dmux->rx, BAM_DMUX_REMOTE_TIMEOUT))
+	if (!wait_event_timeout(dmux->pc_wait, !READ_ONCE(dmux->rx),
+				BAM_DMUX_REMOTE_TIMEOUT))
 		dev_err(dev, "Timed out waiting for remote side to suspend\n");
 
 	/* Make sure everything is cleaned up before we return */
 	disable_irq(dmux->pc_irq);
+	mutex_lock(&dmux->power_lock);
 	bam_dmux_power_off(dmux);
+	mutex_unlock(&dmux->power_lock);
 	bam_dmux_free_skbs(dmux->tx_skbs, DMA_TO_DEVICE);
 }
 
-- 
2.50.1.windows.1
