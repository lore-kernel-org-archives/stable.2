Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889C43314AC;
	Fri, 31 Jul 2026 10:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494382; cv=none; b=nC/eL7fU2yaP+vSv8cuQiZjz/XrGyJ1ScdFIUruckOpKeI5dx7zV012ZAXVV28SMeruopvEkj9ab3xL876e+oIIDYh++qk0UsITLajOeM2AQ+Y2Uwo/+NqEQJGRz+1WT6JxPr78pKi1PtNNW/NXGcQWLFCoZCj/EBoc/Q4JEzvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494382; c=relaxed/simple;
	bh=4r2mhpoxM0PLqNT+vqnq+idXb1PB9Cr2Fc2oqTgK+qY=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:References:
	 In-Reply-To:To:Cc; b=H0wTVoVQUl8VE03Oc+6b1LHf2zpdiE+XWPGHwoxrbl3KAeNM1U+WPUOS9n6k4eWvFTG/yIOuanEHHPlRsRyma2BBZSEZ9uvg2IR4ctU+Fj+CTv/ShIR030V2iND3kH4nmjWVHi0+qt1zzZKxugRopJeWDQW4MJh80tJQUMUBxBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=cCYrCkIR; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="cCYrCkIR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785494358; bh=KvZnB8ilLIwu5R8FZVzXX0PY43qv8Q2CmIPD7haY9Qg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cCYrCkIRl4IqvGdU+sC7CRKLVMrQhQ+QAT6LroELm38l7wagrh9tbEZRxs573nlR/
	 cF0hmrLsG+mBNnhibzTm/XCha8hnP0nCE4jBYvrtWMHb/VnBMQ6bfi/6c2XZI/j7B4
	 Ac+RjW9mHzCk3bdDuxmQrGCKp5Uu3jYinl88cOuo=
Received: from ubuntu2204.localdomain ([2409:8d20:22b:54c:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 9C92DE69; Fri, 31 Jul 2026 18:39:09 +0800
X-QQ-mid: xmsmtpt1785494355tg0nre34l
Message-ID: <tencent_AF224EFBC9343DD238C80824AC8CA805480A@qq.com>
X-QQ-XMAILINFO: OLHLRPgEm/lFBDX1jZ930v/2ePlaUvWy8OXjkSfa5ei3d28cISUTX3o97Y+yy3
	 dbEoghbRXI/8h69RkxVxnCNwUUvTon5XfZVWEkjaNvZAD/xqw2lDwM0PeBLthJaapvAtvVpY6v6g
	 6pykDbZatWeQ17C6JuJniuqgobWyvYRkid7/iwfQK8E54hRucUrWbF6esDDIkdwxxUDk4288HOEr
	 /a5vHDwxwkeYZ+gPvuY3H7MpO7FiZQ8HbZzqdEy3ERRVw+dX6e1w88XHBt1wOQ1X0lN/sjT4jHu8
	 1dItL4haq6CLftk72M5TgXaZ7yl3/oYH/Xk4uHUAT2mnVFkcU4fK8F7bY6FOMjX2jTYCsu8pkLrX
	 z4tkyVHbOrYu3dUVKuTN+FKS9C4tpSx1CR8kH+bMLY+pLxNAnXcgu63pQdQrmT3UdMN9Mouw2URR
	 gE9KzjEnHsK3hxWLiEqRheuFZkJPRQgOSJHlxV3Gzo5xWDQJ8TpbbGcp4AFpkFoucQJrB8ItBBrM
	 nc/jrrJPTlKmwZUAIUNjvuibXExclxm2KO5b3x3TH4V6Fs01DBVe8tV52IvbaakmmbZVG8L1aHgy
	 Ptp/stj55Rek4RgHQHeJS44DLUiCtyHDc6JZnSBOhwfosnQTVRz0VP3I30WgxOrK+z6c+Pazq/8F
	 Ycv140Ufz3XyydRRM9O6jgcefhRMHhb43F9cuQ6TY+uDIEUkimtO9nYtbJ2bxkT20O5fb0e2TDj3
	 apyQw2QcdFgXSAKUETdbxrPcomK2BBSrZsypJmMwv1uO5ZeTmyub+MSAlh25y6OvSDp+EYkK9buv
	 gYCO+3OiWKjhzy8Q5h3Bv+hooFDXoss+BNiNcsrq5jWL9BEqQPMZ5jQ/YKA3pDmwYd3pfbDG0uqY
	 OjFPMuPiAr4lBtHbixwZbRGQhkjjNYH1Plq5oQsn/LsxqRQ2wuhUZhvsevjOJ+3UOXDxToLTh4nY
	 ukduDmrH645Dw/lte6Lc9MGq3n6lAmzWqwAEGKLTmgopFLRo8rF4QobOPZ72cTdsMv/IGFSPnro2
	 rTETFjLedBfEaG9lryPI3by4fQ9pSVhBM9CRw/nHH/9diQLCBkEkNtBb7OKO+QhGFcgR0fCI4/of
	 PolwG5sjSdO4fS2dE=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Cunhao Lu <1579567540@qq.com>
Date: Fri, 31 Jul 2026 18:39:05 +0800
Subject: [PATCH v5 3/3] can: rockchip_canfd: serialize TX state and command
 writes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260731-master-v5-3-5b27029dee20@qq.com>
References: <20260731-master-v5-0-5b27029dee20@qq.com>
In-Reply-To: <20260731-master-v5-0-5b27029dee20@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, kernel@pengutronix.de, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Cunhao Lu <1579567540@qq.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2

The TX completion path removes an echo skb before advancing tx_tail. In
parallel, the transmit path reads tx_head, tx_tail and the tail echo slot
when applying the erratum 6 queue restriction. There is no synchronization
between these operations.

On SMP, the transmit path can consequently observe a pending frame with
an empty echo slot. It can also keep a pointer to an echo skb while the
completion path removes and queues it for NAPI, where it can be freed on
another CPU. The inconsistent snapshot can stop the netdev TX queue when
there is no later completion to wake it.

There is a second race in the command submission sequence.
rkcanfd_start_xmit() runs in softirq context.
rkcanfd_xmit_retry() runs from the RX interrupt handler. On controllers
affected by erratum 12, both execute a MODE/CMD/MODE register sequence. The
interrupt handler can restore the default MODE between the softirq writes.
The resumed softirq then issues CMD without SPACE_RX_MODE and bypasses the
erratum 12 workaround.

Add a TX state lock and use it to protect tx_head, tx_tail and the echo skb
ring as one state. The same lock serializes the MODE/CMD/MODE sequence
between the transmit and interrupt paths. Keep completion and wakeup
outside the lock to avoid nesting the TX state lock with the netdev TX
queue lock. Install the echo skb before loading the hardware TX buffer so
an echo setup failure cannot desynchronize the hardware and software TX
state.

Tested on an RK3588 rev2.2 at 1 Mbit/s with 100,000 extended CAN frames.
The run triggered 138 erratum 6 retries and completed without drops, queue
stalls or driver warnings. RK3588 does not enable erratum 12, so this test
does not exercise that hardware workaround.

Fixes: ae002cc32ec4 ("can: rockchip_canfd: prepare to use full TX-FIFO depth")
Fixes: 83f9bd6bf39d ("can: rockchip_canfd: implement workaround for erratum 12")
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c |  1 +
 drivers/net/can/rockchip/rockchip_canfd-rx.c   | 31 +++++++++++++++++++-------
 drivers/net/can/rockchip/rockchip_canfd-tx.c   | 26 ++++++++++++++++++---
 drivers/net/can/rockchip/rockchip_canfd.h      |  4 +++-
 4 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 29de0c01e4ed..c8257858b452 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -904,6 +904,7 @@ static int rkcanfd_probe(struct platform_device *pdev)
 	priv->can.do_set_mode = rkcanfd_set_mode;
 	priv->can.do_get_berr_counter = rkcanfd_get_berr_counter;
 	priv->ndev = ndev;
+	spin_lock_init(&priv->tx_lock);
 
 	match = device_get_match_data(&pdev->dev);
 	if (match) {
diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
index 475c0409e215..02efc8c0cddc 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
@@ -100,14 +100,25 @@ static int rkcanfd_rxstx_filter(struct rkcanfd_priv *priv,
 	const struct canfd_frame *cfd_nominal;
 	const struct sk_buff *skb;
 	unsigned int tx_tail;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->tx_lock, flags);
+
+	if (!rkcanfd_get_tx_pending(priv))
+		goto out_unlock;
 
 	tx_tail = rkcanfd_get_tx_tail(priv);
 	skb = priv->can.echo_skb[tx_tail];
 	if (!skb) {
+		const unsigned int tx_head_unmasked = priv->tx_head;
+		const unsigned int tx_tail_unmasked = priv->tx_tail;
+
+		spin_unlock_irqrestore(&priv->tx_lock, flags);
+
 		netdev_err(priv->ndev,
 			   "%s: echo_skb[%u]=NULL tx_head=0x%08x tx_tail=0x%08x\n",
 			   __func__, tx_tail,
-			   priv->tx_head, priv->tx_tail);
+			   tx_head_unmasked, tx_tail_unmasked);
 
 		return -ENOMSG;
 	}
@@ -123,17 +134,18 @@ static int rkcanfd_rxstx_filter(struct rkcanfd_priv *priv,
 		rkcanfd_handle_tx_done_one(priv, ts, &frame_len);
 
 		WRITE_ONCE(priv->tx_tail, priv->tx_tail + 1);
+		*tx_done = true;
+
+		spin_unlock_irqrestore(&priv->tx_lock, flags);
 		netif_subqueue_completed_wake(priv->ndev, 0, 1, frame_len,
 					      rkcanfd_get_effective_tx_free(priv),
 					      RKCANFD_TX_START_THRESHOLD);
 
-		*tx_done = true;
-
 		return 0;
 	}
 
 	if (!(priv->devtype_data.quirks & RKCANFD_QUIRK_RK3568_ERRATUM_6))
-		return 0;
+		goto out_unlock;
 
 	/* Erratum 6: Extended frames may be send as standard frames.
 	 *
@@ -143,7 +155,7 @@ static int rkcanfd_rxstx_filter(struct rkcanfd_priv *priv,
 	 */
 	if (!(cfd_nominal->can_id & CAN_EFF_FLAG) ||
 	    (cfd_rx->can_id & CAN_EFF_FLAG))
-		return 0;
+		goto out_unlock;
 
 	/* Not affected if:
 	 * - standard part and RTR flag of the TX'ed frame
@@ -151,20 +163,20 @@ static int rkcanfd_rxstx_filter(struct rkcanfd_priv *priv,
 	 */
 	if ((cfd_nominal->can_id & (CAN_RTR_FLAG | CAN_SFF_MASK)) !=
 	    (cfd_rx->can_id & (CAN_RTR_FLAG | CAN_SFF_MASK)))
-		return 0;
+		goto out_unlock;
 
 	/* Not affected if:
 	 * - length is not the same
 	 */
 	if (cfd_nominal->len != cfd_rx->len)
-		return 0;
+		goto out_unlock;
 
 	/* Not affected if:
 	 * - the data of non RTR frames is different
 	 */
 	if (!(cfd_nominal->can_id & CAN_RTR_FLAG) &&
 	    memcmp(cfd_nominal->data, cfd_rx->data, cfd_nominal->len))
-		return 0;
+		goto out_unlock;
 
 	/* Affected by Erratum 6 */
 	u64_stats_update_begin(&rkcanfd_stats->syncp);
@@ -185,6 +197,9 @@ static int rkcanfd_rxstx_filter(struct rkcanfd_priv *priv,
 
 	rkcanfd_xmit_retry(priv);
 
+out_unlock:
+	spin_unlock_irqrestore(&priv->tx_lock, flags);
+
 	return 0;
 }
 
diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
index fc338ea865fe..b367341dd0ae 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
@@ -14,6 +14,8 @@ static bool rkcanfd_tx_tail_is_eff(const struct rkcanfd_priv *priv)
 	const struct sk_buff *skb;
 	unsigned int tx_tail;
 
+	lockdep_assert_held(&priv->tx_lock);
+
 	if (!rkcanfd_get_tx_pending(priv))
 		return false;
 
@@ -33,13 +35,22 @@ static bool rkcanfd_tx_tail_is_eff(const struct rkcanfd_priv *priv)
 	return cfd->can_id & CAN_EFF_FLAG;
 }
 
-unsigned int rkcanfd_get_effective_tx_free(const struct rkcanfd_priv *priv)
+unsigned int rkcanfd_get_effective_tx_free(struct rkcanfd_priv *priv)
 {
+	unsigned int tx_free;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->tx_lock, flags);
+
 	if (priv->devtype_data.quirks & RKCANFD_QUIRK_RK3568_ERRATUM_6 &&
 	    rkcanfd_tx_tail_is_eff(priv))
-		return 0;
+		tx_free = 0;
+	else
+		tx_free = rkcanfd_get_tx_free(priv);
+
+	spin_unlock_irqrestore(&priv->tx_lock, flags);
 
-	return rkcanfd_get_tx_free(priv);
+	return tx_free;
 }
 
 static void rkcanfd_start_xmit_write_cmd(const struct rkcanfd_priv *priv,
@@ -60,6 +71,8 @@ void rkcanfd_xmit_retry(struct rkcanfd_priv *priv)
 	const unsigned int tx_tail = rkcanfd_get_tx_tail(priv);
 	const u32 reg_cmd = RKCANFD_REG_CMD_TX_REQ(tx_tail);
 
+	lockdep_assert_held(&priv->tx_lock);
+
 	rkcanfd_start_xmit_write_cmd(priv, reg_cmd);
 }
 
@@ -69,6 +82,7 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	u32 reg_frameinfo, reg_id, reg_cmd;
 	unsigned int tx_head, frame_len;
 	const struct canfd_frame *cfd;
+	unsigned long flags;
 	int err;
 	u8 i;
 
@@ -88,10 +102,13 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		return NETDEV_TX_BUSY;
 	}
 
+	spin_lock_irqsave(&priv->tx_lock, flags);
 	tx_head = rkcanfd_get_tx_head(priv);
 	frame_len = can_skb_get_frame_len(skb);
 	err = can_put_echo_skb(skb, ndev, tx_head, frame_len);
 	if (err) {
+		spin_unlock_irqrestore(&priv->tx_lock, flags);
+
 		ndev->stats.tx_dropped++;
 		return NETDEV_TX_OK;
 	}
@@ -136,6 +153,7 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	WRITE_ONCE(priv->tx_head, priv->tx_head + 1);
 
 	rkcanfd_start_xmit_write_cmd(priv, reg_cmd);
+	spin_unlock_irqrestore(&priv->tx_lock, flags);
 
 	netif_subqueue_maybe_stop(priv->ndev, 0,
 				  rkcanfd_get_effective_tx_free(priv),
@@ -152,6 +170,8 @@ void rkcanfd_handle_tx_done_one(struct rkcanfd_priv *priv, const u32 ts,
 	unsigned int tx_tail;
 	struct sk_buff *skb;
 
+	lockdep_assert_held(&priv->tx_lock);
+
 	tx_tail = rkcanfd_get_tx_tail(priv);
 	skb = priv->can.echo_skb[tx_tail];
 
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 93131c7d7f54..3cf283a7b380 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -15,6 +15,7 @@
 #include <linux/netdevice.h>
 #include <linux/reset.h>
 #include <linux/skbuff.h>
+#include <linux/spinlock.h>
 #include <linux/timecounter.h>
 #include <linux/types.h>
 #include <linux/u64_stats_sync.h>
@@ -462,6 +463,7 @@ struct rkcanfd_priv {
 	struct can_rx_offload offload;
 	struct net_device *ndev;
 
+	spinlock_t tx_lock; /* protects tx_head, tx_tail and echo_skb */
 	void __iomem *regs;
 	unsigned int tx_head;
 	unsigned int tx_tail;
@@ -544,7 +546,7 @@ void rkcanfd_timestamp_start(struct rkcanfd_priv *priv);
 void rkcanfd_timestamp_stop(struct rkcanfd_priv *priv);
 void rkcanfd_timestamp_stop_sync(struct rkcanfd_priv *priv);
 
-unsigned int rkcanfd_get_effective_tx_free(const struct rkcanfd_priv *priv);
+unsigned int rkcanfd_get_effective_tx_free(struct rkcanfd_priv *priv);
 void rkcanfd_xmit_retry(struct rkcanfd_priv *priv);
 netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev);
 void rkcanfd_handle_tx_done_one(struct rkcanfd_priv *priv, const u32 ts,

-- 
2.34.1

