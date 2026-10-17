Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D87C49158D;
	Sat, 17 Oct 2026 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792248656; cv=none; b=Cn1QIClbveBJ1Djspb0v5M+dOJNSkG1eCo/jeXIVFVInydYI6RJMrs03ucJdTWUwGpclOcgksJKme45BTgCwGMnDy4FEys+WUKIVMY/IrLPi5gMCrjgG1Bi4xkJ2068QyBkdwbobR/a0C8bicaWQxGQnEuT1J79rc+P9H8j9Bu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792248656; c=relaxed/simple;
	bh=qoPoaukoJuUEirjNqjSlygzFTRC7K9O/GkMtSH/EZnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VDqBqCbHbjlF8Sqby4NaTQg6db4KsDtcDoJ/dMULGjDMuIrR62Lh35Xn4ZIv51Kvdm0z2ieFvMihHTx4jvP8cZzAqKOfxAYxtpK+4d9vOD3XjfXVSH0M5sL5J8tXYEAfZ7lkgt4sDs0i+KR6NjDMuo48HFN84dBpZ8sqFTPUmak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2UnLdCQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2UnLdCQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FDECC4AF0D;
	Sat, 17 Oct 2026 14:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792248656;
	bh=qoPoaukoJuUEirjNqjSlygzFTRC7K9O/GkMtSH/EZnM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=X2UnLdCQbqo2JPXQsQTMAdL1E3mfIOYisPNBKbriVkjdg2dQfbGKYvp9j7RzGzRkj
	 WKRYqMvPWO92ABdR9oS1DbBY5lrMUqEWc6TMGniQxaoltU/1Pz4pYxcPP0FVaGUq+2
	 5775JFyEup2+cgJ97fpaOVm2q6TmvThdysazkYPh/7AFgf5aWiL3odeYepmRC+QUF1
	 91kpWcbr/IHaTv0GvW4apDhiNZ03FMy6LyynU96oCeihU+jeTJ04RPp0wwokicJntk
	 1CNhWV21CClOfBlrpRkBgMkHZ/lsnmnIRM7syUuvfFTlTO/3VjjMY0S0SOiTMK7FT7
	 YtVjBVtZFbBTg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE51CCF2CF;
	Sat, 17 Oct 2026 14:50:56 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Sat, 17 Oct 2026 22:50:55 +0800
Subject: [PATCH net v6 5/6] can: rockchip_canfd: serialize TX with bus-off
 and restart
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-rockchip-canfd-restart-close-v6-5-ed605feb4b6e@qq.com>
References: <20261017-rockchip-canfd-restart-close-v6-0-ed605feb4b6e@qq.com>
In-Reply-To: <20261017-rockchip-canfd-restart-close-v6-0-ed605feb4b6e@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, kernel@pengutronix.de, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, stable@vger.kernel.org, 
 Cunhao Lu <1579567540@qq.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792248654; l=11892;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=cItqtt/nO+EQ+rRHd1Iqovlc2WtXn4+MqXYOKjNeIgo=;
 b=sC/mPBVNzh58y24z5v2PT9wAiVW3ZKVp3SQrV3x+26eHSa5XZFUU/tMvhK3RUUfBY+VYuwDAY
 f8UlprTYaLyBydU9SdClozCOiSn8UH5IqVQjr4amwskgjeOVLUIM5S4
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com

From: Cunhao Lu <1579567540@qq.com>

The bus-off path can reset the controller while ndo_start_xmit() is
active. CAN restart also flushes the echo ring before calling set_mode(),
so disabling TX in that callback is too late to protect echo slots.

Serialize TX submission, RX-side completion and retry with a private
lock and enabled flag. Disable TX and drain these users before publishing
CAN_STATE_BUS_OFF, protecting the core's echo flush during automatic and
manual recovery. Reject further submissions with NETDEV_TX_BUSY.

If close disables TX after an RX IRQ has consumed a self-transmitted
frame, skipping echo filtering alone would deliver it as ordinary RX.
Check tx_enabled under the same lock after consuming the FIFO entry. If
TX is disabled, drop the entry without accessing the echo ring, retrying
TX, waking the queue or allocating an ordinary RX skb. Return success so
the caller continues draining the FIFO.

After draining the old IRQ and reinitializing the controller, restore
carrier, enable TX, resume IRQ handling and wake the queue under the
lock. This prevents the old bus-off IRQ from leaving manual recovery
with carrier off, while allowing a new bus-off to take precedence.

Keep shared IRQ handling suspended during open until initialization is
complete, and leave TX disabled on close or failed open. Keep resets and
synchronous IRQ/work draining outside the lock.

Keep a reference to the original skb across can_put_echo_skb() and
release it after unlocking, so its socket destructor cannot run with
hard IRQs disabled. If echo preparation fails, drop the frame without
advancing tx_head, accounting BQL or requesting TX. This also fixes the
existing failure path that could stall TX on an empty echo slot.

Fixes: b6661d73290c ("can: rockchip_canfd: add TX PATH")
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>

---
Changes in v6:
- Defer the original skb's release until after unlocking.
- Abort TX submission if echo preparation fails.

Changes in v5:
- Drop consumed RX FIFO entries when tx_enabled is false under tx_lock,
  rather than skipping only echo filtering and delivering them as RX.
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 51 ++++++++++++++++++++++----
 drivers/net/can/rockchip/rockchip_canfd-rx.c   | 26 +++++++++----
 drivers/net/can/rockchip/rockchip_canfd-tx.c   | 40 +++++++++++++++++---
 drivers/net/can/rockchip/rockchip_canfd.h      |  3 ++
 4 files changed, 100 insertions(+), 20 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 4b3db07242395..150748c0b6845 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -326,6 +326,35 @@ static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
 		   rkcanfd_read(priv, RKCANFD_REG_MODE));
 }
 
+static void rkcanfd_tx_disable(struct rkcanfd_priv *priv)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->tx_lock, flags);
+	priv->tx_enabled = false;
+	netif_stop_queue(priv->ndev);
+	spin_unlock_irqrestore(&priv->tx_lock, flags);
+}
+
+static void rkcanfd_chip_start_finish(struct rkcanfd_priv *priv)
+{
+	unsigned long flags;
+
+	/* Serialize carrier, IRQ enable and queue wake with a new bus-off. */
+	spin_lock_irqsave(&priv->tx_lock, flags);
+	/* A manual restart may have raced with the old bus-off IRQ's
+	 * netif_carrier_off(). That IRQ is now drained; restore carrier
+	 * before resuming IRQ handling so a new bus-off takes precedence.
+	 */
+	netif_carrier_on(priv->ndev);
+	priv->tx_enabled = true;
+	/* Publish the initialized state before resuming IRQ handling. */
+	smp_store_release(&priv->irq_suspended, false);
+	rkcanfd_chip_interrupts_enable(priv);
+	netif_wake_queue(priv->ndev);
+	spin_unlock_irqrestore(&priv->tx_lock, flags);
+}
+
 static void __rkcanfd_chip_stop(struct rkcanfd_priv *priv, const enum can_state state)
 {
 	priv->can.state = state;
@@ -357,6 +386,7 @@ static int rkcanfd_set_mode(struct net_device *ndev,
 
 	switch (mode) {
 	case CAN_MODE_START:
+		rkcanfd_tx_disable(priv);
 		rkcanfd_chip_interrupts_disable(priv);
 		/* Flush the interrupt mask write before suspending the handler. */
 		rkcanfd_read(priv, RKCANFD_REG_INT_MASK);
@@ -367,10 +397,7 @@ static int rkcanfd_set_mode(struct net_device *ndev,
 		rkcanfd_timestamp_stop_sync(priv);
 
 		rkcanfd_chip_start(priv);
-		/* Publish the initialized state before resuming IRQ handling. */
-		smp_store_release(&priv->irq_suspended, false);
-		rkcanfd_chip_interrupts_enable(priv);
-		netif_wake_queue(ndev);
+		rkcanfd_chip_start_finish(priv);
 		break;
 
 	default:
@@ -604,6 +631,12 @@ static int rkcanfd_handle_state_error_int(struct rkcanfd_priv *priv)
 	 * handles cf == NULL.
 	 */
 	skb = rkcanfd_alloc_can_err_skb(priv, &cf, &timestamp);
+	if (new_state == CAN_STATE_BUS_OFF) {
+		/* Drain TX before publishing BUS_OFF, which permits a manual
+		 * restart to flush echo SKBs before calling our set_mode().
+		 */
+		rkcanfd_tx_disable(priv);
+	}
 	can_change_state(ndev, cf, tx_state, rx_state);
 
 	if (new_state == CAN_STATE_BUS_OFF) {
@@ -749,6 +782,8 @@ static int rkcanfd_open(struct net_device *ndev)
 	if (err)
 		goto out_close_candev;
 
+	/* A shared IRQ may run as soon as request_irq() succeeds. */
+	WRITE_ONCE(priv->irq_suspended, true);
 	rkcanfd_chip_start(priv);
 	can_rx_offload_enable(&priv->offload);
 
@@ -756,13 +791,12 @@ static int rkcanfd_open(struct net_device *ndev)
 	if (err)
 		goto out_rkcanfd_chip_stop;
 
-	rkcanfd_chip_interrupts_enable(priv);
-
-	netif_start_queue(ndev);
+	rkcanfd_chip_start_finish(priv);
 
 	return 0;
 
 out_rkcanfd_chip_stop:
+	rkcanfd_tx_disable(priv);
 	can_rx_offload_disable(&priv->offload);
 	rkcanfd_chip_stop_sync(priv, CAN_STATE_STOPPED);
 	pm_runtime_put(ndev->dev.parent);
@@ -776,7 +810,7 @@ static int rkcanfd_stop(struct net_device *ndev)
 	struct rkcanfd_priv *priv = netdev_priv(ndev);
 
 	close_candev_cancel_restart_sync(ndev);
-	netif_stop_queue(ndev);
+	rkcanfd_tx_disable(priv);
 
 	rkcanfd_chip_interrupts_disable(priv);
 	free_irq(ndev->irq, priv);
@@ -939,6 +973,7 @@ static int rkcanfd_probe(struct platform_device *pdev)
 	priv->can.do_set_mode = rkcanfd_set_mode;
 	priv->can.do_get_berr_counter = rkcanfd_get_berr_counter;
 	priv->ndev = ndev;
+	spin_lock_init(&priv->tx_lock);
 
 	match = device_get_match_data(&pdev->dev);
 	if (match) {
diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
index 24e87daa1df00..5e64317d4eee6 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
@@ -91,6 +91,7 @@ rkcanfd_fifo_header_to_cfd_header(const struct rkcanfd_priv *priv,
 	return len + cfd->len;
 }
 
+/* Called with tx_lock held and TX enabled. */
 static int rkcanfd_rxstx_filter(struct rkcanfd_priv *priv,
 				const struct canfd_frame *cfd_rx, const u32 ts,
 				bool *tx_done)
@@ -204,7 +205,9 @@ static int rkcanfd_handle_rx_int_one(struct rkcanfd_priv *priv)
 	struct canfd_frame cfd[1] = { }, *skb_cfd;
 	struct rkcanfd_fifo_header header[1] = { };
 	struct sk_buff *skb;
+	unsigned long flags;
 	unsigned int len;
+	bool tx_done = false;
 	int err;
 
 	/* read header into separate struct and convert it later */
@@ -237,15 +240,24 @@ static int rkcanfd_handle_rx_int_one(struct rkcanfd_priv *priv)
 		return 0;
 	}
 
-	if (rkcanfd_get_tx_pending(priv)) {
-		bool tx_done = false;
+	/* Drop FIFO entries while TX is disabled, as they may be self-
+	 * received frames. Do not access the echo ring, retry TX or wake the
+	 * queue while restart owns the ring. The entry is already consumed.
+	 */
+	spin_lock_irqsave(&priv->tx_lock, flags);
+	if (unlikely(!priv->tx_enabled)) {
+		spin_unlock_irqrestore(&priv->tx_lock, flags);
+		return 0;
+	}
 
+	err = 0;
+	if (rkcanfd_get_tx_pending(priv))
 		err = rkcanfd_rxstx_filter(priv, cfd, header->ts, &tx_done);
-		if (err)
-			return err;
-		if (tx_done && !(priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK))
-			return 0;
-	}
+	spin_unlock_irqrestore(&priv->tx_lock, flags);
+	if (err)
+		return err;
+	if (tx_done && !(priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK))
+		return 0;
 
 	/* Manual handling of CAN Bus Error counters. See
 	 * rkcanfd_get_corrected_berr_counter() for detailed
diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
index 12200dcfd3389..f86e31599b0a8 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
@@ -69,12 +69,19 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	u32 reg_frameinfo, reg_id, reg_cmd;
 	unsigned int tx_head, frame_len;
 	const struct canfd_frame *cfd;
+	unsigned long flags;
 	int err;
 	u8 i;
 
 	if (can_dev_dropped_skb(ndev, skb))
 		return NETDEV_TX_OK;
 
+	spin_lock_irqsave(&priv->tx_lock, flags);
+	if (unlikely(!priv->tx_enabled)) {
+		netif_stop_queue(ndev);
+		goto out_busy;
+	}
+
 	if (!netif_subqueue_maybe_stop(priv->ndev, 0,
 				       rkcanfd_get_effective_tx_free(priv),
 				       RKCANFD_TX_STOP_THRESHOLD,
@@ -85,7 +92,7 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 				    priv->tx_head, priv->tx_tail,
 				    rkcanfd_get_tx_pending(priv));
 
-		return NETDEV_TX_BUSY;
+		goto out_busy;
 	}
 
 	cfd = (struct canfd_frame *)skb->data;
@@ -117,16 +124,21 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	tx_head = rkcanfd_get_tx_head(priv);
 	reg_cmd = RKCANFD_REG_CMD_TX_REQ(tx_head);
 
+	/* Keep the original skb alive until IRQs are restored so echo
+	 * preparation cannot invoke its socket destructor under tx_lock.
+	 */
+	frame_len = can_skb_get_frame_len(skb);
+	err = can_put_echo_skb(skb_get(skb), ndev, tx_head, frame_len);
+	if (unlikely(err || !priv->can.echo_skb[tx_head]))
+		goto out_drop;
+
 	rkcanfd_write(priv, RKCANFD_REG_FD_TXFRAMEINFO, reg_frameinfo);
 	rkcanfd_write(priv, RKCANFD_REG_FD_TXID, reg_id);
 	for (i = 0; i < cfd->len; i += 4)
 		rkcanfd_write(priv, RKCANFD_REG_FD_TXDATA0 + i,
 			      *(u32 *)(cfd->data + i));
 
-	frame_len = can_skb_get_frame_len(skb);
-	err = can_put_echo_skb(skb, ndev, tx_head, frame_len);
-	if (!err)
-		netdev_sent_queue(priv->ndev, frame_len);
+	netdev_sent_queue(priv->ndev, frame_len);
 
 	WRITE_ONCE(priv->tx_head, priv->tx_head + 1);
 
@@ -137,7 +149,25 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 				  RKCANFD_TX_STOP_THRESHOLD,
 				  RKCANFD_TX_START_THRESHOLD);
 
+	spin_unlock_irqrestore(&priv->tx_lock, flags);
+	dev_consume_skb_any(skb);
+
+	return NETDEV_TX_OK;
+
+out_drop:
+	ndev->stats.tx_dropped++;
+	spin_unlock_irqrestore(&priv->tx_lock, flags);
+	/* An invalid index leaves the extra reference unconsumed. */
+	if (err == -EINVAL)
+		dev_kfree_skb_any(skb);
+	dev_kfree_skb_any(skb);
+
 	return NETDEV_TX_OK;
+
+out_busy:
+	spin_unlock_irqrestore(&priv->tx_lock, flags);
+
+	return NETDEV_TX_BUSY;
 }
 
 void rkcanfd_handle_tx_done_one(struct rkcanfd_priv *priv, const u32 ts,
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 2743c96ed42f0..4a2bdc205296e 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -476,6 +476,9 @@ struct rkcanfd_priv {
 	struct net_device *ndev;
 
 	void __iomem *regs;
+	/* Serialize TX submission/completion with bus-off and restart. */
+	spinlock_t tx_lock;
+	bool tx_enabled;
 	unsigned int tx_head;
 	unsigned int tx_tail;
 

-- 
2.34.1


