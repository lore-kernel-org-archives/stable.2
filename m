Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794743290;
	b=G7sraPGjqfho8jhbsc9xd0rwLeITj06bfd23WZBCdkmJsxtQ8Dg8GbzAfwSsjVT2zY7W
	 +KfIzengQGnmc/W82Fyf5eXZaN2j+Y8MXBR6ij/qmqPt9Uvmk4isY545kM1/oJEY+5uNb
	 9h3aZFZxKWLk7yqTxKatXTC255Lg+mtI0D+9/n0dxDo1dwy81duL5yb5z9QgG1H6Kw4Cw
	 /SNNbKzEsevGff5XqMcpZAfzw3e0e9Cup5cub8/Z853G8Ee8rCHAKRDU5gPgNps4Qv7Da
	 eUwYNlnbfy5sL7E0X+ZuEySVO6JisPTTGVC5aBwJE18X/MoXcX7Hz01mYYubivqocjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794743290;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=UsHOG0hKFPH8DG7mxbNZP/pVKPuhdC6MyX5+hsrEteA=;
	b=dQ6Tms3+zBMKtmf5QKG1awm6fxlEwebxIR8fVBroljIB/dUv7mV0uc8lqP/PhwR77lKg
	 Hfxyjgd1C2gEy3eJcCvVjjqlzXL5D84xYiJTzfzk4+mg21wIonN76VL238Vpq3UDs+1jh
	 Rd41uv9y3hKYPlu2GuivJJnZnCeydV2hjaj/Tr5G8KJCREYwCTBZKXwHcULXw6bME6IJH
	 L8/w1HnIVv+SevzyR9+TaiOLOJdPh59i7UTeGa23of5sP8P+Jh9iW9K3TaSqVqwoUObZA
	 O1BJk07m5fI/SVcXCxS7NVg2RntWDND9GpLGjfpxn8792ytju1N3xZouTgH9jutfjGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seu.edu.cn;
	spf=pass smtp.mailfrom=seu.edu.cn;
	dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=HSwHnnf1;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B89F606A333;
	Sun, 15 Nov 2026 11:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B89F606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=HSwHnnf1
Received: from [192.168.17.1] (unknown [124.79.98.159])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54b7e04eb;
	Sun, 15 Nov 2026 19:48:02 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Stephan Gerhold <stephan@gerhold.net>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David S. Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net v6 2/3] net: wwan: qcom_bam_dmux: serialize power and DMA
 lifetimes
Date: Sun, 15 Nov 2026 19:48:00 +0800
Message-ID: <179474328031.103840.14482517465335755960@seu.edu.cn>
In-Reply-To: <179474327647.103840.9539614513141118915@seu.edu.cn>
References: <179474327647.103840.9539614513141118915@seu.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa1df092cc703a1kunmbac61c98bf7a9
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHRgeVk8eTEkZQ0xJQxpLGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSU9VTEJVQkNVSk5CWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=HSwHnnf1948BS4MS479s9Psl+JV0hna3GB+oBfJZVddmiPHy6rJdYsMYt+blsg/6+2ZB3WXx/0A184sfsruXmFEWPLqvIIbr9e+gHFCdrIkckVV5wVw5XDLxzm5SUoVNt+rbQ0X1H4ZfeNyuLdMXrL7HXf1fGwlmLX7n7Ww8YqI=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=UsHOG0hKFPH8DG7mxbNZP/pVKPuhdC6MyX5+hsrEteA=;
	h=date:mime-version:subject:message-id:from;

The modem PC interrupt can release TX while a runtime-PM user prepares
or submits a descriptor. A host-vote acknowledgment alone does not order
a delayed PC-low event, and the DMA engine must be released before the
host acknowledges a valid remote power-down.

Serialize PC decisions and TX acquisition. Defer PC-low while a host
vote and TX channel are active, then re-read the live PC level at
runtime suspend before dropping that protection. A withdrawn PC-low
request is therefore not acknowledged from stale DOWN_PENDING state.

Keep both PC interrupts masked until initialization is ready, then
enable them under the power mutex and sample the level afterwards. SMSM
unmask re-synchronizes its cached level instead of replaying a masked
edge. Gate both handlers until the successful post-unmask read so its
failure cannot publish DMA or netdev state on the probe error path.

Stop RX refill under a spinlock before synchronous termination. The
callback holds that lock only to check the refill gate, unmap its buffer
and requeue, so packet delivery does not run with interrupts disabled.
Synchronous termination waits for a callback that is already running.
Callback context must not take the sleeping power mutex; the provider's
synchronize hook is supplied by the preceding patch.

If resume fails while PC cannot be read, drop the host vote without
releasing DMA. Ordinary runtime-suspend failures must retain that vote
because PM returns to active on failure. A failed resume instead ends
suspended; leaving the vote asserted could suppress a later same-bit
SMEM notification after the acknowledgment completion is reset.

Record a delivered PC-ack even when its PC query fails. TX acquisition
still requires a fresh level query before it can use or allocate the
channel, so that completion does not authorize TX from stale PC state.

Found by the author's in-house static analysis tool.

Fixes: 21a0ffd9b38c ("net: wwan: Add Qualcomm BAM-DMUX WWAN network driver")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260903180057.1437-1-getshell@seu.edu.cn/
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
Signed-off-by: Zehao Gao <gaozehao@iie.ac.cn>
---

Discovery: found by the author's in-house static analysis tool.

 drivers/net/wwan/qcom_bam_dmux.c | 357 +++++++++++++++++++++++++------
 1 file changed, 291 insertions(+), 66 deletions(-)

diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
index 90801c0..48ad1bc 100644
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
@@ -64,17 +66,28 @@ struct bam_dmux_skb_dma {
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
+	bool pc_ready; /* Protected by power_lock */
 
 	struct dma_chan *rx, *tx;
+	spinlock_t rx_lock; /* Protect RX callbacks against shutdown */
+	bool rx_active;
 	struct bam_dmux_skb_dma rx_skbs[BAM_DMUX_NUM_SKB];
 	struct bam_dmux_skb_dma tx_skbs[BAM_DMUX_NUM_SKB];
 	spinlock_t tx_lock; /* Protect tx_skbs, tx_next_skb */
@@ -99,6 +112,22 @@ static void bam_dmux_pc_vote(struct bam_dmux *dmux, bool enable)
 				    enable ? dmux->pc_mask : 0);
 }
 
+static void bam_dmux_pc_vote_locked(struct bam_dmux *dmux, bool enable)
+{
+	lockdep_assert_held(&dmux->power_lock);
+
+	dmux->pc_vote = enable ? BAM_DMUX_PC_VOTE_ACTIVE :
+				 BAM_DMUX_PC_VOTE_INACTIVE;
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
@@ -462,25 +491,65 @@ static void bam_dmux_register_netdev_work(struct work_struct *work)
 	}
 }
 
-static void bam_dmux_rx_callback(void *data);
-
-static bool bam_dmux_skb_dma_submit_rx(struct bam_dmux_skb_dma *skb_dma)
+static void bam_dmux_rx_callback(void *data)
 {
+	struct bam_dmux_skb_dma *skb_dma = data;
 	struct bam_dmux *dmux = skb_dma->dmux;
-	struct dma_async_tx_descriptor *desc;
+	struct bam_dmux_hdr *hdr;
+	struct sk_buff *skb;
+	unsigned long flags;
 
-	desc = dmaengine_prep_slave_single(dmux->rx, skb_dma->addr,
-					   skb_dma->skb->len, DMA_DEV_TO_MEM,
-					   DMA_PREP_INTERRUPT);
-	if (!desc) {
-		dev_err(dmux->dev, "Failed to prepare RX DMA buffer\n");
-		return false;
+	spin_lock_irqsave(&dmux->rx_lock, flags);
+	if (!dmux->rx_active) {
+		spin_unlock_irqrestore(&dmux->rx_lock, flags);
+		return;
 	}
 
-	desc->callback = bam_dmux_rx_callback;
-	desc->callback_param = skb_dma;
-	desc->cookie = dmaengine_submit(desc);
-	return true;
+	skb = skb_dma->skb;
+	hdr = (struct bam_dmux_hdr *)skb->data;
+	bam_dmux_skb_dma_unmap(skb_dma, DMA_FROM_DEVICE);
+	if (dmux->removing) {
+		spin_unlock_irqrestore(&dmux->rx_lock, flags);
+		goto requeue;
+	}
+	spin_unlock_irqrestore(&dmux->rx_lock, flags);
+
+	if (hdr->magic != BAM_DMUX_HDR_MAGIC) {
+		dev_err(dmux->dev, "Invalid magic in header: %#x\n", hdr->magic);
+		goto requeue;
+	}
+
+	if (hdr->ch >= BAM_DMUX_NUM_CH) {
+		dev_dbg(dmux->dev, "Unsupported channel: %u\n", hdr->ch);
+		goto requeue;
+	}
+
+	switch (hdr->cmd) {
+	case BAM_DMUX_CMD_DATA:
+		bam_dmux_cmd_data(skb_dma);
+		break;
+	case BAM_DMUX_CMD_OPEN:
+		bam_dmux_cmd_open(dmux, hdr);
+		break;
+	case BAM_DMUX_CMD_CLOSE:
+		bam_dmux_cmd_close(dmux, hdr);
+		break;
+	default:
+		dev_err(dmux->dev, "Unsupported command %u on channel %u\n",
+			hdr->cmd, hdr->ch);
+		break;
+	}
+
+requeue:
+	/*
+	 * Recheck the gate: power-off may have stopped refill while the
+	 * command was dispatched without the lock.
+	 */
+	spin_lock_irqsave(&dmux->rx_lock, flags);
+	if (dmux->rx_active &&
+	    bam_dmux_skb_dma_queue_rx(skb_dma, GFP_ATOMIC))
+		dma_async_issue_pending(dmux->rx);
+	spin_unlock_irqrestore(&dmux->rx_lock, flags);
 }
 
 static bool bam_dmux_skb_dma_queue_rx(struct bam_dmux_skb_dma *skb_dma, gfp_t gfp)
@@ -574,9 +643,16 @@ static void bam_dmux_rx_callback(void *data)
 {
 	struct bam_dmux_skb_dma *skb_dma = data;
 	struct bam_dmux *dmux = skb_dma->dmux;
-	struct sk_buff *skb = skb_dma->skb;
-	struct bam_dmux_hdr *hdr = (struct bam_dmux_hdr *)skb->data;
+	struct bam_dmux_hdr *hdr;
+	struct sk_buff *skb;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dmux->rx_lock, flags);
+	if (!dmux->rx_active)
+		goto out_unlock;
 
+	skb = skb_dma->skb;
+	hdr = (struct bam_dmux_hdr *)skb->data;
 	bam_dmux_skb_dma_unmap(skb_dma, DMA_FROM_DEVICE);
 
 	if (hdr->magic != BAM_DMUX_HDR_MAGIC) {
@@ -608,6 +684,8 @@ static void bam_dmux_rx_callback(void *data)
 out:
 	if (bam_dmux_skb_dma_queue_rx(skb_dma, GFP_ATOMIC))
 		dma_async_issue_pending(dmux->rx);
+out_unlock:
+	spin_unlock_irqrestore(&dmux->rx_lock, flags);
 }
 
 static bool bam_dmux_power_on(struct bam_dmux *dmux)
@@ -619,6 +697,8 @@ static bool bam_dmux_power_on(struct bam_dmux *dmux)
 	};
 	int i;
 
+	lockdep_assert_held(&dmux->power_lock);
+
 	dmux->rx = dma_request_chan(dev, "rx");
 	if (IS_ERR(dmux->rx)) {
 		dev_err(dev, "Failed to request RX DMA channel: %pe\n", dmux->rx);
@@ -631,6 +711,8 @@ static bool bam_dmux_power_on(struct bam_dmux *dmux)
 		if (!bam_dmux_skb_dma_queue_rx(&dmux->rx_skbs[i], GFP_KERNEL))
 			return false;
 	}
+	scoped_guard(spinlock_irqsave, &dmux->rx_lock)
+		dmux->rx_active = true;
 	dma_async_issue_pending(dmux->rx);
 
 	return true;
@@ -655,6 +737,12 @@ static void bam_dmux_free_skbs(struct bam_dmux_skb_dma skbs[],
 
 static void bam_dmux_power_off(struct bam_dmux *dmux)
 {
+	lockdep_assert_held(&dmux->power_lock);
+
+	/* Block refill before terminate_sync waits for callbacks. */
+	scoped_guard(spinlock_irqsave, &dmux->rx_lock)
+		dmux->rx_active = false;
+
 	if (dmux->tx) {
 		dmaengine_terminate_sync(dmux->tx);
 		dma_release_channel(dmux->tx);
@@ -670,10 +758,24 @@ static void bam_dmux_power_off(struct bam_dmux *dmux)
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
 
@@ -682,13 +784,44 @@ static irqreturn_t bam_dmux_pc_irq(int irq, void *data)
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
+	}
+
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
+	if (!dmux->pc_ready) {
+		mutex_unlock(&dmux->power_lock);
+		return IRQ_HANDLED;
+	}
+	ret = irq_get_irqchip_state(dmux->pc_irq, IRQCHIP_STATE_LINE_LEVEL,
+				    &new_state);
+	if (ret) {
+		mutex_unlock(&dmux->power_lock);
+		dev_err_ratelimited(dmux->dev, "failed to read pc state: %d\n", ret);
+		return IRQ_HANDLED;
 	}
 
-	dmux->pc_state = new_state;
-	wake_up_all(&dmux->pc_wait);
+	wake = bam_dmux_handle_pc(dmux, new_state);
+	mutex_unlock(&dmux->power_lock);
+	if (wake)
+		wake_up_all(&dmux->pc_wait);
 
 	return IRQ_HANDLED;
 }
@@ -696,9 +829,33 @@ static irqreturn_t bam_dmux_pc_irq(int irq, void *data)
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
+	if (!dmux->pc_ready) {
+		mutex_unlock(&dmux->power_lock);
+		return IRQ_HANDLED;
+	}
+	ret = irq_get_irqchip_state(dmux->pc_irq, IRQCHIP_STATE_LINE_LEVEL,
+				    &new_state);
+	if (ret) {
+		/* The IRQ still acknowledges the host vote. */
+		complete_all(&dmux->pc_ack_completion);
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
@@ -706,9 +863,68 @@ static irqreturn_t bam_dmux_pc_ack_irq(int irq, void *data)
 static int bam_dmux_runtime_suspend(struct device *dev)
 {
 	struct bam_dmux *dmux = dev_get_drvdata(dev);
+	bool new_state, wake;
+	int ret;
 
 	dev_dbg(dev, "runtime suspend\n");
-	bam_dmux_pc_vote(dmux, false);
+
+	scoped_guard(mutex, &dmux->power_lock) {
+		ret = irq_get_irqchip_state(dmux->pc_irq,
+					    IRQCHIP_STATE_LINE_LEVEL, &new_state);
+		if (ret)
+			return ret;
+		bam_dmux_pc_vote_locked(dmux, false);
+		wake = bam_dmux_handle_pc(dmux, new_state);
+	}
+	if (wake)
+		wake_up_all(&dmux->pc_wait);
+
+	return 0;
+}
+
+static void bam_dmux_resume_cleanup(struct bam_dmux *dmux)
+{
+	int ret;
+
+	ret = bam_dmux_runtime_suspend(dmux->dev);
+	if (!ret)
+		return;
+
+	dev_err_ratelimited(dmux->dev, "failed to read pc state during resume cleanup: %d\n",
+			    ret);
+	/* Failed resume leaves PM suspended; retain DMA, but drop the vote. */
+	scoped_guard(mutex, &dmux->power_lock)
+		bam_dmux_pc_vote_locked(dmux, false);
+}
+
+static int bam_dmux_request_tx(struct bam_dmux *dmux)
+{
+	struct device *dev = dmux->dev;
+	bool new_state;
+	int ret;
+
+	scoped_guard(mutex, &dmux->power_lock) {
+		ret = irq_get_irqchip_state(dmux->pc_irq,
+					    IRQCHIP_STATE_LINE_LEVEL, &new_state);
+		if (ret)
+			return ret;
+		bam_dmux_handle_pc(dmux, new_state);
+		/* Check state and acquire TX under the power-control lock. */
+		if (!dmux->pc_state || !dmux->rx)
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
@@ -716,6 +932,7 @@ static int bam_dmux_runtime_suspend(struct device *dev)
 static int __maybe_unused bam_dmux_runtime_resume(struct device *dev)
 {
 	struct bam_dmux *dmux = dev_get_drvdata(dev);
+	int ret;
 
 	dev_dbg(dev, "runtime resume\n");
 
@@ -724,50 +941,41 @@ static int __maybe_unused bam_dmux_runtime_resume(struct device *dev)
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
+		bam_dmux_resume_cleanup(dmux);
 		return -ETIMEDOUT;
 	}
 
+	synchronize_irq(dmux->pc_irq);
+
 	/* Wait until we're up */
-	if (!wait_event_timeout(dmux->pc_wait, dmux->pc_state,
+	if (!wait_event_timeout(dmux->pc_wait, READ_ONCE(dmux->pc_state),
 				BAM_DMUX_REMOTE_TIMEOUT)) {
-		bam_dmux_pc_vote(dmux, false);
+		bam_dmux_resume_cleanup(dmux);
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
-		bam_dmux_runtime_suspend(dev);
-		return -ENXIO;
-	}
+	ret = bam_dmux_request_tx(dmux);
+	if (ret)
+		bam_dmux_resume_cleanup(dmux);
 
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
 
 	dmux = devm_kzalloc_obj(dev, *dmux);
 	if (!dmux)
@@ -780,9 +988,9 @@ static int bam_dmux_probe(struct platform_device *pdev)
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
@@ -799,7 +1007,11 @@ static int bam_dmux_probe(struct platform_device *pdev)
 	init_waitqueue_head(&dmux->pc_wait);
 	init_completion(&dmux->pc_ack_completion);
 	complete_all(&dmux->pc_ack_completion);
+	ret = devm_mutex_init(dev, &dmux->power_lock);
+	if (ret)
+		return ret;
 
+	spin_lock_init(&dmux->rx_lock);
 	spin_lock_init(&dmux->tx_lock);
 	INIT_WORK(&dmux->tx_wakeup_work, bam_dmux_tx_wakeup_work);
 	INIT_WORK(&dmux->register_netdev_work, bam_dmux_register_netdev_work);
@@ -817,31 +1029,41 @@ static int bam_dmux_probe(struct platform_device *pdev)
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
+	/* SMSM/SMP2P unmask can consume an edge: sample after enabling. */
+	enable_irq(dmux->pc_ack_irq);
+	enable_irq(dmux->pc_irq);
 	ret = irq_get_irqchip_state(dmux->pc_irq, IRQCHIP_STATE_LINE_LEVEL,
-				    &dmux->pc_state);
-	if (ret)
-		goto err_disable_pm;
-
-	/* Check if remote finished initialization before us */
-	if (dmux->pc_state) {
-		if (bam_dmux_power_on(dmux))
-			bam_dmux_pc_ack(dmux);
-		else
-			bam_dmux_power_off(dmux);
+				    &pc_state);
+	if (!ret) {
+		dmux->pc_ready = true;
+		bam_dmux_handle_pc(dmux, pc_state);
 	}
+	mutex_unlock(&dmux->power_lock);
+	if (ret)
+		goto err_disable_irqs;
 
 	return 0;
 
+err_disable_irqs:
+	disable_irq(dmux->pc_ack_irq);
+	disable_irq(dmux->pc_irq);
+err_power_off:
+	mutex_lock(&dmux->power_lock);
+	bam_dmux_power_off(dmux);
+	mutex_unlock(&dmux->power_lock);
 err_disable_pm:
 	pm_runtime_disable(dev);
 	pm_runtime_dont_use_autosuspend(dev);
@@ -872,12 +1094,15 @@ static void bam_dmux_remove(struct platform_device *pdev)
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
