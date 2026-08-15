Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D811374169;
	Sat, 15 Aug 2026 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786788307; cv=none; b=JgFnXNKtWJeMwpVK2OXGIhMYAs/jt/o8zaSmfoMYAg1ZogiLDEtdgnOjHuMLvId+JLklf2yNdqg6pF7yeeICeNJUzX6G4H0RCUSR4f7BG+1yGMdQiWFgMpsDNyFR0UOswGWsup6RSB9dGBUUn/Mkwkfrm06/p3bauIkar+G5VJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786788307; c=relaxed/simple;
	bh=HcjJhNG21dT5o6nFyPgyNTi71JcFe+OBFD0q1XZg0bo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T7SOkbplCGQQwvPU4x7LpSpfo32vDxhb0yz1Phw9DSWUJYY42fO9YYZ3AiiX1dZ6+UaojQn4ETiGbISeMX+nGaEHcTkzq3iwP4OkFl6FhsbaP0eb5Jgo4iFdh7oJSllsGRPVy9dn7JPTNN/6z013rFK4SBvhmQx3c7WIAVHrd1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Tn2rq2F+; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Tn2rq2F+"
Received: from LAPTOP-99KJFSET (unknown [36.153.54.101])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4a18cfe0c;
	Sat, 15 Aug 2026 18:04:55 +0800 (GMT+08:00)
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
Subject: [PATCH net v3] net: wwan: qcom_bam_dmux: fix TX DMA channel use-after-free
Date: Sat, 15 Aug 2026 18:04:53 +0800
Message-ID: <20260815100454.695-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa004e1b21703a1kunmd0d1492f86724
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSB8ZVkkfHkMaHk0fGk5NTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VSktKWVdZFhoPEhUdFFlBWU9LSFVKS0lITk
	NDVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=Tn2rq2F+FN0kIekbKBd9wExLrnplFuZ244a5+dk/70Ggn5aoj9vH3kOLHcR07hYTZrbHqRq3FoYDULaj1VmZjIYgbYuwTe/ZOqOMqCSANEFlHDXBSD4COUniLe8Zv6HBiF1tycr8ewazQTatT5MGeAoMt/LaAbBMm8EMDQ/1bBg=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=/Ep872+Mf8zZI27x/+GPRoLH3oyVR2uuhm00bDTjDek=;
	h=date:mime-version:subject:message-id:from;

The modem power-control interrupt can release dmux->tx while the command,
netdev transmit, or deferred wakeup paths are preparing and submitting
DMA descriptors. A runtime PM reference alone does not order those paths
against the modem-driven interrupt.

The pc and pc-ack IRQ actions do not encode the modem protocol order. A
pc=false edge raised before a new host power vote is acknowledged can
therefore be handled after runtime resume observes the acknowledgment and
starts using TX. On the other hand, acknowledging a new pc=false transition
while the acknowledged host vote remains active lets the modem power down
the DMA engine underneath the driver.

Serialize power-control state with a mutex and distinguish a requested host
vote from an acknowledged one. Publish each vote acknowledgment and its
completion under that lock. Before publishing the host-vote
acknowledgment, sample the actual pc line and process any delayed
transition. A valid pc=false transition is then handled before runtime
resume returns, when no path can submit through TX. The channels are
released before pc is acknowledged, and a queued BAM_DMUX_CMD_OPEN remains
queued for the new TX channel.

If pc goes low after the host vote was acknowledged, refuse the pc
acknowledgment and keep the DMA channels allocated. Remember the pending
transition so runtime suspend can first release the channels and only then
acknowledge pc=false. This preserves the protocol ordering without exposing
a released TX channel or cancelling an OPEN command that already succeeded.

Both IRQ handlers can now change the DMA channel state. Keep them
inactive until the initial probe state is committed, and disable both
before the final remove cleanup and before cleaning up a failed probe.

This issue was found by the author's in-house static analysis tool.
The patch was reviewed by the author.

Fixes: 21a0ffd9b38c ("net: wwan: Add Qualcomm BAM-DMUX WWAN network driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
Changes in v3:
- Sample the pc line before publishing a host-vote acknowledgment so a
  delayed, valid pc=false transition is completed before runtime resume.
- Refuse to acknowledge pc=false after the active host vote was acknowledged.
- Complete a refused down transition during runtime suspend, releasing the
  DMA channels before acknowledging it.
- Serialize the vote acknowledgment and completion with vote changes.
- Gate both state IRQ handlers until probe initialization is committed and
  quiesce both before probe-error or remove cleanup.

Changes in v2:
- Track the host power vote and serialize the power-control paths.

Link: https://lore.kernel.org/netdev/20260808083457.2023-1-getshell@seu.edu.cn/
Link: https://lore.kernel.org/netdev/20260806060642.1281-1-getshell@seu.edu.cn/

 drivers/net/wwan/qcom_bam_dmux.c | 192 ++++++++++++++++++++++++++-----
 1 file changed, 161 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
index cc6ace8..41928ed 100644
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
@@ -67,12 +68,17 @@ struct bam_dmux_skb_dma {
 struct bam_dmux {
 	struct device *dev;
 
-	int pc_irq;
+	int pc_irq, pc_ack_irq;
 	bool pc_state, pc_ack_state;
 	struct qcom_smem_state *pc, *pc_ack;
 	u32 pc_mask, pc_ack_mask;
 	wait_queue_head_t pc_wait;
 	struct completion pc_ack_completion;
+	struct mutex power_lock; /* Protect power-control state */
+	bool pc_vote;
+	bool pc_vote_acked;
+	bool pc_down_pending;
+	bool ready;
 
 	struct dma_chan *rx, *tx;
 	struct bam_dmux_skb_dma rx_skbs[BAM_DMUX_NUM_SKB];
@@ -99,6 +105,22 @@ static void bam_dmux_pc_vote(struct bam_dmux *dmux, bool enable)
 				    enable ? dmux->pc_mask : 0);
 }
 
+static void bam_dmux_pc_vote_locked(struct bam_dmux *dmux, bool enable)
+{
+	lockdep_assert_held(&dmux->power_lock);
+
+	dmux->pc_vote = enable;
+	dmux->pc_vote_acked = false;
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
@@ -655,6 +677,8 @@ static void bam_dmux_free_skbs(struct bam_dmux_skb_dma skbs[],
 
 static void bam_dmux_power_off(struct bam_dmux *dmux)
 {
+	lockdep_assert_held(&dmux->power_lock);
+
 	if (dmux->tx) {
 		dmaengine_terminate_sync(dmux->tx);
 		dma_release_channel(dmux->tx);
@@ -670,25 +694,63 @@ static void bam_dmux_power_off(struct bam_dmux *dmux)
 	bam_dmux_free_skbs(dmux->rx_skbs, DMA_FROM_DEVICE);
 }
 
-static irqreturn_t bam_dmux_pc_irq(int irq, void *data)
+static bool bam_dmux_handle_pc(struct bam_dmux *dmux, bool new_state)
 {
-	struct bam_dmux *dmux = data;
-	bool new_state = !dmux->pc_state;
+	lockdep_assert_held(&dmux->power_lock);
+
+	if (new_state == dmux->pc_state) {
+		if (new_state)
+			dmux->pc_down_pending = false;
+		return false;
+	}
 
 	dev_dbg(dmux->dev, "pc: %u\n", new_state);
 
 	if (new_state) {
-		if (bam_dmux_power_on(dmux))
+		if (dmux->rx || bam_dmux_power_on(dmux))
 			bam_dmux_pc_ack(dmux);
 		else
 			bam_dmux_power_off(dmux);
+	} else if (dmux->pc_vote && dmux->pc_vote_acked) {
+		/* The modem must keep the DMA engine on until pc is acked. */
+		dmux->pc_down_pending = true;
+		dev_err_ratelimited(dmux->dev,
+				    "refusing pc down while host vote is active\n");
+		return false;
 	} else {
 		bam_dmux_power_off(dmux);
 		bam_dmux_pc_ack(dmux);
 	}
 
-	dmux->pc_state = new_state;
-	wake_up_all(&dmux->pc_wait);
+	dmux->pc_down_pending = false;
+	WRITE_ONCE(dmux->pc_state, new_state);
+	return true;
+}
+
+static irqreturn_t bam_dmux_pc_irq(int irq, void *data)
+{
+	struct bam_dmux *dmux = data;
+	bool new_state, wake;
+	int ret;
+
+	mutex_lock(&dmux->power_lock);
+	if (!dmux->ready) {
+		mutex_unlock(&dmux->power_lock);
+		return IRQ_HANDLED;
+	}
+
+	ret = irq_get_irqchip_state(dmux->pc_irq, IRQCHIP_STATE_LINE_LEVEL,
+				    &new_state);
+	if (ret) {
+		mutex_unlock(&dmux->power_lock);
+		dev_err_ratelimited(dmux->dev, "failed to read pc state: %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	wake = bam_dmux_handle_pc(dmux, new_state);
+	mutex_unlock(&dmux->power_lock);
+	if (wake)
+		wake_up_all(&dmux->pc_wait);
 
 	return IRQ_HANDLED;
 }
@@ -696,9 +758,33 @@ static irqreturn_t bam_dmux_pc_irq(int irq, void *data)
 static irqreturn_t bam_dmux_pc_ack_irq(int irq, void *data)
 {
 	struct bam_dmux *dmux = data;
+	bool new_state, wake = false;
+	int ret;
 
 	dev_dbg(dmux->dev, "pc ack\n");
+
+	/* Process an earlier pc edge before publishing the host-vote ack. */
+	synchronize_irq(dmux->pc_irq);
+	mutex_lock(&dmux->power_lock);
+	if (!dmux->ready) {
+		mutex_unlock(&dmux->power_lock);
+		return IRQ_HANDLED;
+	}
+
+	ret = irq_get_irqchip_state(dmux->pc_irq, IRQCHIP_STATE_LINE_LEVEL,
+				    &new_state);
+	if (ret) {
+		mutex_unlock(&dmux->power_lock);
+		dev_err_ratelimited(dmux->dev, "failed to read pc state: %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	wake = bam_dmux_handle_pc(dmux, new_state);
+	dmux->pc_vote_acked = true;
 	complete_all(&dmux->pc_ack_completion);
+	mutex_unlock(&dmux->power_lock);
+	if (wake)
+		wake_up_all(&dmux->pc_wait);
 
 	return IRQ_HANDLED;
 }
@@ -706,9 +792,19 @@ static irqreturn_t bam_dmux_pc_ack_irq(int irq, void *data)
 static int bam_dmux_runtime_suspend(struct device *dev)
 {
 	struct bam_dmux *dmux = dev_get_drvdata(dev);
+	bool wake = false;
 
 	dev_dbg(dev, "runtime suspend\n");
-	bam_dmux_pc_vote(dmux, false);
+
+	mutex_lock(&dmux->power_lock);
+	bam_dmux_pc_vote_locked(dmux, false);
+	if (dmux->pc_down_pending)
+		wake = bam_dmux_handle_pc(dmux, false);
+	else if (!dmux->pc_state)
+		bam_dmux_power_off(dmux);
+	mutex_unlock(&dmux->power_lock);
+	if (wake)
+		wake_up_all(&dmux->pc_wait);
 
 	return 0;
 }
@@ -724,40 +820,55 @@ static int __maybe_unused bam_dmux_runtime_resume(struct device *dev)
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
@@ -766,8 +877,9 @@ static int bam_dmux_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct bam_dmux *dmux;
-	int ret, pc_ack_irq, i;
+	int ret, i;
 	unsigned int bit;
+	bool pc_state;
 
 	dmux = devm_kzalloc(dev, sizeof(*dmux), GFP_KERNEL);
 	if (!dmux)
@@ -780,9 +892,9 @@ static int bam_dmux_probe(struct platform_device *pdev)
 	if (dmux->pc_irq < 0)
 		return dmux->pc_irq;
 
-	pc_ack_irq = platform_get_irq_byname(pdev, "pc-ack");
-	if (pc_ack_irq < 0)
-		return pc_ack_irq;
+	dmux->pc_ack_irq = platform_get_irq_byname(pdev, "pc-ack");
+	if (dmux->pc_ack_irq < 0)
+		return dmux->pc_ack_irq;
 
 	dmux->pc = devm_qcom_smem_state_get(dev, "pc", &bit);
 	if (IS_ERR(dmux->pc))
@@ -799,6 +911,7 @@ static int bam_dmux_probe(struct platform_device *pdev)
 	init_waitqueue_head(&dmux->pc_wait);
 	init_completion(&dmux->pc_ack_completion);
 	complete_all(&dmux->pc_ack_completion);
+	mutex_init(&dmux->power_lock);
 
 	spin_lock_init(&dmux->tx_lock);
 	INIT_WORK(&dmux->tx_wakeup_work, bam_dmux_tx_wakeup_work);
@@ -817,31 +930,41 @@ static int bam_dmux_probe(struct platform_device *pdev)
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_enable(dev);
 
-	ret = devm_request_threaded_irq(dev, pc_ack_irq, NULL, bam_dmux_pc_ack_irq,
-					IRQF_ONESHOT, NULL, dmux);
+	ret = devm_request_threaded_irq(dev, dmux->pc_ack_irq, NULL,
+					bam_dmux_pc_ack_irq, IRQF_ONESHOT,
+					NULL, dmux);
 	if (ret)
 		goto err_disable_pm;
 
 	ret = devm_request_threaded_irq(dev, dmux->pc_irq, NULL, bam_dmux_pc_irq,
 					IRQF_ONESHOT, NULL, dmux);
 	if (ret)
-		goto err_disable_pm;
+		goto err_disable_pc_ack_irq;
 
+	mutex_lock(&dmux->power_lock);
 	ret = irq_get_irqchip_state(dmux->pc_irq, IRQCHIP_STATE_LINE_LEVEL,
-				    &dmux->pc_state);
+				    &pc_state);
 	if (ret)
-		goto err_disable_pm;
+		goto err_unlock_disable_irqs;
 
 	/* Check if remote finished initialization before us */
-	if (dmux->pc_state) {
-		if (bam_dmux_power_on(dmux))
-			bam_dmux_pc_ack(dmux);
-		else
-			bam_dmux_power_off(dmux);
-	}
+	bam_dmux_handle_pc(dmux, pc_state);
+	dmux->ready = true;
+	mutex_unlock(&dmux->power_lock);
 
 	return 0;
 
+err_unlock_disable_irqs:
+	mutex_unlock(&dmux->power_lock);
+	disable_irq(dmux->pc_ack_irq);
+	disable_irq(dmux->pc_irq);
+	goto err_power_off;
+err_disable_pc_ack_irq:
+	disable_irq(dmux->pc_ack_irq);
+err_power_off:
+	mutex_lock(&dmux->power_lock);
+	bam_dmux_power_off(dmux);
+	mutex_unlock(&dmux->power_lock);
 err_disable_pm:
 	pm_runtime_disable(dev);
 	pm_runtime_dont_use_autosuspend(dev);
@@ -872,12 +995,19 @@ static void bam_dmux_remove(struct platform_device *pdev)
 	pm_runtime_set_suspended(dev);
 
 	/* Try to wait for remote side to drop power vote */
-	if (!wait_event_timeout(dmux->pc_wait, !dmux->rx, BAM_DMUX_REMOTE_TIMEOUT))
+	if (!wait_event_timeout(dmux->pc_wait, !READ_ONCE(dmux->rx),
+				BAM_DMUX_REMOTE_TIMEOUT))
 		dev_err(dev, "Timed out waiting for remote side to suspend\n");
 
 	/* Make sure everything is cleaned up before we return */
+	mutex_lock(&dmux->power_lock);
+	dmux->ready = false;
+	mutex_unlock(&dmux->power_lock);
+	disable_irq(dmux->pc_ack_irq);
 	disable_irq(dmux->pc_irq);
+	mutex_lock(&dmux->power_lock);
 	bam_dmux_power_off(dmux);
+	mutex_unlock(&dmux->power_lock);
 	bam_dmux_free_skbs(dmux->tx_skbs, DMA_TO_DEVICE);
 }
 
