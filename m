Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC7B4FECC5;
	Thu,  3 Sep 2026 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788458475; cv=none; b=YLPcPld1V5aXdZdypiqUIilrmgCeWKAIfwIoXCs220WlXRIs8qATjw4vonPiwIjehs/xxUFihKN6uPZBKZyaz45jOdY1HJqfVoxGMZ1ABq8nxaBOtPES1eBR+PCO0PGZZYoJ5LjqN3zgCKvO3KGtA5QDnmlkoFsuOFhC5XAaUaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788458475; c=relaxed/simple;
	bh=biH6N5+0ZerdaNl8k468WTEKGet4obZKZcZGuQh5ZFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dqmBuWdFeNjWj43i/e3QbVGynYCWIWzqzL7XUPnCfWLv3G0t1v8DhdMb4c593ZqY/VYzg9IoNR9R1p0FYvoZ+2MLNpUUzL7pENMoUadvoWfpZ448H0D9K7GbzP2W3PAm7ZfKZ5V9Gy9BduoqHKA2rybCB57KBL7aUxlAkBwkyHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=WWwIZ6mQ; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="WWwIZ6mQ"
Received: from LAPTOP-99KJFSET (unknown [36.153.54.56])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c71e19dc;
	Fri, 4 Sep 2026 02:00:59 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Stephan Gerhold <stephan@gerhold.net>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	stable@vger.kernel.org,
	Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH net v5] net: wwan: qcom_bam_dmux: fix TX DMA channel use-after-free
Date: Fri,  4 Sep 2026 02:00:57 +0800
Message-ID: <20260903180057.1437-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0686e5bab03a1kunm26e323eafcf5
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGUkeVhhKSk4dHUJNSkJMHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VTk1ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
	NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=WWwIZ6mQH9ywRmTRS0RPrmftDGHDAYrOpcEvITOlUJDR2HNoJdHPAQ51aR1X77Kfpw7Ak53znjbd4/rYG8oVJcPat/68YSDz3A+yrhnIFyDDYjc0OcBaYB0rTWXQcIH0XfqArXlNqbdWBxLacX48jgxDErJLs6sKUyIqeMdw2jg=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=7VV1LtMraJT6IO8wc0LZXKVs9ECQ9NZVroHNT5EZIis=;
	h=date:mime-version:subject:message-id:from;

The modem power-control interrupt can release dmux->tx while the command,
netdev transmit, or deferred wakeup paths are preparing and submitting
DMA descriptors. A runtime PM reference alone does not order those paths
against the modem-driven interrupt.

The pc and pc-ack IRQ actions do not encode the modem protocol order. A
pc=false edge raised before a new host power vote is acknowledged can
therefore be handled after runtime resume observes the acknowledgment and
starts using TX. On the other hand, acknowledging a new pc=false transition
while the host vote remains active lets the modem power down the DMA engine
underneath the driver.

Serialize power-control state with a mutex. Before publishing a host-vote
acknowledgment, sample the actual pc line and process any delayed
transition.
When pc goes low while the host vote is active and the TX channel is
allocated, defer the transition without acknowledging it. Repeated pc=false
interrupts remain deferred and cannot release the channel. If pc returns
high, cancel the deferred transition.

Runtime suspend drops the host vote under the same lock. If a pc=false
transition was deferred, it then terminates and releases the DMA channels
before acknowledging the transition. If runtime suspend wins the race with
the pc interrupt, the interrupt observes the inactive host vote and can
safely perform the same shutdown. This orders channel release after the
last runtime PM user without relying on whether the modem acknowledges
the host vote before or after asserting pc.

Keep both state IRQs disabled until the initial probe state is committed,
and disable both before final remove cleanup. Use a device-managed mutex
and scoped guards for the serialized paths.

This issue was found by the author's in-house static analysis tool.
The patch was reviewed by the author.

Fixes: 21a0ffd9b38c ("net: wwan: Add Qualcomm BAM-DMUX WWAN network driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>

---
Changes in v5:
- Drop the vote-ack state; PC-down safety does not depend on ACK ordering.
- Keep repeated PC-low interrupts deferred while TX can still be in use.
- Complete a deferred PC-down directly from runtime suspend after dropping
  the host vote.
- Move TX channel acquisition into a scoped helper and retain early returns.

Link: https://lore.kernel.org/netdev/20260822085308.1089-1-getshell@seu.edu.cn/

diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
index cc6ace8..429d34a 100644
--- a/drivers/net/wwan/qcom_bam_dmux.c
+++ b/drivers/net/wwan/qcom_bam_dmux.c
@@ -6,12 +6,14 @@
 
 #include <linux/atomic.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/completion.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/if_arp.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/netdevice.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -64,15 +66,23 @@ struct bam_dmux_skb_dma {
 	dma_addr_t addr;
 };
 
+enum bam_dmux_pc_vote {
+	BAM_DMUX_PC_VOTE_INACTIVE, /* pc_vote = false */
+	BAM_DMUX_PC_VOTE_ACTIVE, /* pc_vote = true */
+	BAM_DMUX_PC_VOTE_DOWN_PENDING, /* pc = false while host vote active */
+};
+
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
+	enum bam_dmux_pc_vote pc_vote;
 
 	struct dma_chan *rx, *tx;
 	struct bam_dmux_skb_dma rx_skbs[BAM_DMUX_NUM_SKB];
@@ -99,6 +109,24 @@ static void bam_dmux_pc_vote(struct bam_dmux *dmux, bool enable)
 				    enable ? dmux->pc_mask : 0);
 }
 
+static void bam_dmux_pc_vote_locked(struct bam_dmux *dmux, bool enable)
+{
+	lockdep_assert_held(&dmux->power_lock);
+
+	if (enable)
+		dmux->pc_vote = BAM_DMUX_PC_VOTE_ACTIVE;
+	else if (dmux->pc_vote != BAM_DMUX_PC_VOTE_DOWN_PENDING)
+		dmux->pc_vote = BAM_DMUX_PC_VOTE_INACTIVE;
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
@@ -655,6 +683,8 @@ static void bam_dmux_free_skbs(struct bam_dmux_skb_dma skbs[],
 
 static void bam_dmux_power_off(struct bam_dmux *dmux)
 {
+	lockdep_assert_held(&dmux->power_lock);
+
 	if (dmux->tx) {
 		dmaengine_terminate_sync(dmux->tx);
 		dma_release_channel(dmux->tx);
@@ -670,10 +700,24 @@ static void bam_dmux_power_off(struct bam_dmux *dmux)
 	bam_dmux_free_skbs(dmux->rx_skbs, DMA_FROM_DEVICE);
 }
 
-static irqreturn_t bam_dmux_pc_irq(int irq, void *data)
+static void bam_dmux_complete_pc_down(struct bam_dmux *dmux)
 {
-	struct bam_dmux *dmux = data;
-	bool new_state = !dmux->pc_state;
+	lockdep_assert_held(&dmux->power_lock);
+
+	bam_dmux_power_off(dmux);
+	bam_dmux_pc_ack(dmux);
+	WRITE_ONCE(dmux->pc_state, false);
+}
+
+static bool bam_dmux_handle_pc(struct bam_dmux *dmux, bool new_state)
+{
+	lockdep_assert_held(&dmux->power_lock);
+
+	if (new_state == dmux->pc_state) {
+		if (new_state && dmux->pc_vote == BAM_DMUX_PC_VOTE_DOWN_PENDING)
+			dmux->pc_vote = BAM_DMUX_PC_VOTE_ACTIVE;
+		return false;
+	}
 
 	dev_dbg(dmux->dev, "pc: %u\n", new_state);
 
@@ -682,13 +726,40 @@ static irqreturn_t bam_dmux_pc_irq(int irq, void *data)
 			bam_dmux_pc_ack(dmux);
 		else
 			bam_dmux_power_off(dmux);
+	} else if (dmux->tx && dmux->pc_vote != BAM_DMUX_PC_VOTE_INACTIVE) {
+		/* The modem must keep the DMA engine on until pc is acked. */
+		dmux->pc_vote = BAM_DMUX_PC_VOTE_DOWN_PENDING;
+		dev_err_ratelimited(dmux->dev,
+				    "refusing pc down while host vote is active\n");
+		return false;
 	} else {
-		bam_dmux_power_off(dmux);
-		bam_dmux_pc_ack(dmux);
+		bam_dmux_complete_pc_down(dmux);
 	}
 
-	dmux->pc_state = new_state;
-	wake_up_all(&dmux->pc_wait);
+	if (new_state)
+		WRITE_ONCE(dmux->pc_state, true);
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
@@ -696,9 +767,27 @@ static irqreturn_t bam_dmux_pc_irq(int irq, void *data)
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
+	ret = irq_get_irqchip_state(dmux->pc_irq, IRQCHIP_STATE_LINE_LEVEL,
+				    &new_state);
+	if (ret) {
+		mutex_unlock(&dmux->power_lock);
+		dev_err_ratelimited(dmux->dev, "failed to read pc state: %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	wake = bam_dmux_handle_pc(dmux, new_state);
 	complete_all(&dmux->pc_ack_completion);
+	mutex_unlock(&dmux->power_lock);
+	if (wake)
+		wake_up_all(&dmux->pc_wait);
 
 	return IRQ_HANDLED;
 }
@@ -706,9 +795,47 @@ static irqreturn_t bam_dmux_pc_ack_irq(int irq, void *data)
 static int bam_dmux_runtime_suspend(struct device *dev)
 {
 	struct bam_dmux *dmux = dev_get_drvdata(dev);
+	bool wake = false;
 
 	dev_dbg(dev, "runtime suspend\n");
-	bam_dmux_pc_vote(dmux, false);
+
+	scoped_guard(mutex, &dmux->power_lock) {
+		bam_dmux_pc_vote_locked(dmux, false);
+		if (dmux->pc_vote == BAM_DMUX_PC_VOTE_DOWN_PENDING) {
+			dmux->pc_vote = BAM_DMUX_PC_VOTE_INACTIVE;
+			bam_dmux_complete_pc_down(dmux);
+			wake = true;
+		} else if (!dmux->pc_state) {
+			bam_dmux_power_off(dmux);
+		}
+	}
+	if (wake)
+		wake_up_all(&dmux->pc_wait);
+
+	return 0;
+}
+
+static int bam_dmux_request_tx(struct bam_dmux *dmux)
+{
+	struct device *dev = dmux->dev;
+
+	scoped_guard(mutex, &dmux->power_lock) {
+		/* Ensure that we actually initialized successfully */
+		if (!dmux->rx)
+			return -ENXIO;
+
+		/* Request TX channel if necessary */
+		if (dmux->tx)
+			return 0;
+
+		dmux->tx = dma_request_chan(dev, "tx");
+		if (IS_ERR(dmux->tx)) {
+			dev_err(dev, "Failed to request TX DMA channel: %pe\n",
+				dmux->tx);
+			dmux->tx = NULL;
+			return -ENXIO;
+		}
+	}
 
 	return 0;
 }
@@ -716,6 +843,7 @@ static int bam_dmux_runtime_suspend(struct device *dev)
 static int __maybe_unused bam_dmux_runtime_resume(struct device *dev)
 {
 	struct bam_dmux *dmux = dev_get_drvdata(dev);
+	int ret;
 
 	dev_dbg(dev, "runtime resume\n");
 
@@ -724,50 +852,41 @@ static int __maybe_unused bam_dmux_runtime_resume(struct device *dev)
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
 
-	/* Ensure that we actually initialized successfully */
-	if (!dmux->rx) {
-		bam_dmux_pc_vote(dmux, false);
-		return -ENXIO;
-	}
-
-	/* Request TX channel if necessary */
-	if (dmux->tx)
-		return 0;
-
-	dmux->tx = dma_request_chan(dev, "tx");
-	if (IS_ERR(dmux->tx)) {
-		dev_err(dev, "Failed to request TX DMA channel: %pe\n", dmux->tx);
-		dmux->tx = NULL;
+	ret = bam_dmux_request_tx(dmux);
+	if (ret)
 		bam_dmux_runtime_suspend(dev);
-		return -ENXIO;
-	}
 
-	return 0;
+	return ret;
 }
 
 static int bam_dmux_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct bam_dmux *dmux;
-	int ret, pc_ack_irq, i;
 	unsigned int bit;
+	bool pc_state;
+	int ret, i;
 
 	dmux = devm_kzalloc(dev, sizeof(*dmux), GFP_KERNEL);
 	if (!dmux)
@@ -780,9 +899,9 @@ static int bam_dmux_probe(struct platform_device *pdev)
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
@@ -799,6 +918,9 @@ static int bam_dmux_probe(struct platform_device *pdev)
 	init_waitqueue_head(&dmux->pc_wait);
 	init_completion(&dmux->pc_ack_completion);
 	complete_all(&dmux->pc_ack_completion);
+	ret = devm_mutex_init(dev, &dmux->power_lock);
+	if (ret)
+		return ret;
 
 	spin_lock_init(&dmux->tx_lock);
 	INIT_WORK(&dmux->tx_wakeup_work, bam_dmux_tx_wakeup_work);
@@ -817,31 +939,40 @@ static int bam_dmux_probe(struct platform_device *pdev)
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_enable(dev);
 
-	ret = devm_request_threaded_irq(dev, pc_ack_irq, NULL, bam_dmux_pc_ack_irq,
-					IRQF_ONESHOT, NULL, dmux);
+	ret = devm_request_threaded_irq(dev, dmux->pc_ack_irq, NULL,
+					bam_dmux_pc_ack_irq,
+					IRQF_ONESHOT | IRQF_NO_AUTOEN,
+					NULL, dmux);
 	if (ret)
 		goto err_disable_pm;
 
 	ret = devm_request_threaded_irq(dev, dmux->pc_irq, NULL, bam_dmux_pc_irq,
-					IRQF_ONESHOT, NULL, dmux);
+					IRQF_ONESHOT | IRQF_NO_AUTOEN, NULL, dmux);
 	if (ret)
-		goto err_disable_pm;
+		goto err_power_off;
 
+	mutex_lock(&dmux->power_lock);
 	ret = irq_get_irqchip_state(dmux->pc_irq, IRQCHIP_STATE_LINE_LEVEL,
-				    &dmux->pc_state);
-	if (ret)
-		goto err_disable_pm;
+				    &pc_state);
+	if (ret) {
+		mutex_unlock(&dmux->power_lock);
+		goto err_power_off;
+	}
 
 	/* Check if remote finished initialization before us */
-	if (dmux->pc_state) {
-		if (bam_dmux_power_on(dmux))
-			bam_dmux_pc_ack(dmux);
-		else
-			bam_dmux_power_off(dmux);
-	}
+	bam_dmux_handle_pc(dmux, pc_state);
+	mutex_unlock(&dmux->power_lock);
+
+	/* Start handling state changes after the initial state is processed. */
+	enable_irq(dmux->pc_ack_irq);
+	enable_irq(dmux->pc_irq);
 
 	return 0;
 
+err_power_off:
+	mutex_lock(&dmux->power_lock);
+	bam_dmux_power_off(dmux);
+	mutex_unlock(&dmux->power_lock);
 err_disable_pm:
 	pm_runtime_disable(dev);
 	pm_runtime_dont_use_autosuspend(dev);
@@ -872,12 +1003,16 @@ static void bam_dmux_remove(struct platform_device *pdev)
 	pm_runtime_set_suspended(dev);
 
 	/* Try to wait for remote side to drop power vote */
-	if (!wait_event_timeout(dmux->pc_wait, !dmux->rx, BAM_DMUX_REMOTE_TIMEOUT))
+	if (!wait_event_timeout(dmux->pc_wait, !READ_ONCE(dmux->rx),
+				BAM_DMUX_REMOTE_TIMEOUT))
 		dev_err(dev, "Timed out waiting for remote side to suspend\n");
 
 	/* Make sure everything is cleaned up before we return */
+	disable_irq(dmux->pc_ack_irq);
 	disable_irq(dmux->pc_irq);
+	mutex_lock(&dmux->power_lock);
 	bam_dmux_power_off(dmux);
+	mutex_unlock(&dmux->power_lock);
 	bam_dmux_free_skbs(dmux->tx_skbs, DMA_TO_DEVICE);
 }
 
-- 
2.50.1.windows.1
