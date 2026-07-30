Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF70383983;
	Thu, 30 Jul 2026 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427039; cv=none; b=ihKDz4lV1YHc/oDwUIgkfsEILMB63E7IsY5OXUz8dYCv3vBAROdXP64473NdN61YrGZGylOPKlvYeTqCtc7BnADhuTMBPfB2TiPHk9L6oS+lXy8IpK1Xf/a9dh31x1MNKbvNPDShjXtKeEYMiGc63QCEBBSnoxj5RromcDKqW5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427039; c=relaxed/simple;
	bh=/cop3GcxpIaGYXJX9Y+qdBTmX8VXthjFvxYBwd33FL4=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:References:
	 In-Reply-To:To:Cc; b=Awz6LcDTOcgT03loNNFgeTTZBhP8QxA/aIEhwfTprGITZfvveI5XRPikaFAlx3N1+2+tVl+yf9GjYzbmrWeFIziEO6pEAest8QU7J+VD23TKf9Bz1oHdVVZD3eoMaxABsPrgU4ST5zemI2SdLi0B0YsiKNuMHC1wbkTT1c2ioMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=BGS7RAig; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BGS7RAig"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785427033; bh=go9nYGmnbF3DJEU7xWoaMnXMh5xsIoUGzQrAGZ7OZgM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BGS7RAigARmT82UIq9kIw2Ae3CEGxEOncQM6UVWOKQ1JNid3dR40qaGAcTH6EwS3F
	 2ItOs0cT6b2jpCZdSIx8XUKqchd9YhiGZ+5nUUZ75S2IJ6FBRPs4uTl/aiOV8u4Zbl
	 WpvLzuCZQDJJ+2GX2seeS413+GhRxOvNGTpXtTPA=
Received: from ubuntu2204.localdomain ([2409:8d20:22b:54c:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id E4428204; Thu, 30 Jul 2026 23:57:04 +0800
X-QQ-mid: xmsmtpt1785427029ter5j5z37
Message-ID: <tencent_9BBC002BC4013FA9A6559A771980048B9107@qq.com>
X-QQ-XMAILINFO: NXu+3P8uW1MU0x+RmsEiLDHlsV+9CkkebKeCw3hJjjxuVoVGaIf+95YZU3Kd3+
	 HOBlWhhYyeDwOgbYfQXUfO61EQYTgvyY2epDlMuPEj4/av0utyhSYkzs68cYT4YzmCfGy0EEmkN/
	 cuaQAf8W79IWllNa827SCrwxjZ008xUHhTPxTuueVibFuShXIiMXwe+LTZ3LlCFRnNqlJg1lB9yR
	 Fjp3Rb2nihaXEcL1mPwG8J58lsd5ZskdP9KOhZiAxAeE+ki4gWyK3efKligOgIxA8aKQft85Ww3v
	 2JlxNI6dwQ8M6fGUARDflEIChoXGA+SN23tMXVfltWAf0DdEOx40TjthXRMW1aBQjL19v6GgXOS/
	 jvhTvX2lI9GfsVFrT7McsKJlEZbKamJC0SFt5aNM1qxqfD+0OgeeGpgtvoOuVoabltviBLFJjh2s
	 Ht2dWfZad6PlNl3SOJM5PLoD1oCu5GnXsdj8xYm6PI/oNk+6GbvuVxhUNYYWkrIpnyQMJCSFMJ/i
	 bJBcQWQ9ycIce6BHEBAKhiEHq5Jb9Wdzk+hE1B2we84d1errU6+uFziJtavmfgixBjTxC8JB1trA
	 bC4fL6+C4UUo5KKY8voL67MsgkUt4x5DfN4CtP5Adsl2yu0kAvkowxyHpjeHugW3P/PDTXisBjCs
	 qcEcaqvj051gKKITrbBQIpwjACXRFZUekbk7jHqSQNmzlWEReWuQdluWQjAyZNGJO2ar5KeAzWx/
	 vUp+eAP7WOjpepunECsNMPX4gBEjRX7G//D8vsY7+f3zdBDZTtwka9OqrI5t2nMU3g5zO5DIjbSV
	 vdVjjXq75eSkHBHMYoMxgpM6nM17bim91I0qrlROxwz5uJJ/t1sVVpYgw4JAjQzyGWgCbqphxCHG
	 EEX9qtEg3DeYzxJXXQKe4hRt+F4GHy8xMYyeRPySRcveDTtSxbXih2bLyhL0ISjvD884rf18szWE
	 nVx6XA+yzbmRWCbNS15D/h1xs5sO1D5W1eSOaDTvWpOEIb/urFVfD+67KtO/AXhGmDR/PkmhzJZo
	 eTx0acQBVxpVr+v3OB8cQQgUVvhZxthy2ralFPCHUgHHCscIV8eeq+pWBCTcnjTu8ETFa1Tsbw3k
	 vv02MjDm7YaeKHSAbSgvPg8H49Ug7iUgcUvua1aPJ7NjJKqcGLQOEQ2dW21hd2rWY8b/yS+no2CI
	 X4XCuK/vRVzHU8GXoXzPwWvCrY8dN76m58ld1zcrSp0nPLzngLnKXf5+gU
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Cunhao Lu <1579567540@qq.com>
Date: Thu, 30 Jul 2026 23:50:43 +0800
Subject: [PATCH v4 3/3] can: rockchip_canfd: serialize TX state and command
 writes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260730-master-v4-3-07f7952f761d@qq.com>
References: <20260730-master-v4-0-07f7952f761d@qq.com>
In-Reply-To: <20260730-master-v4-0-07f7952f761d@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, kernel@pengutronix.de, 
 Heiko Stuebner <heiko@sntech.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 stable@vger.kernel.org, Cunhao Lu <1579567540@qq.com>
X-Mailer: b4 0.15.2

The TX completion path removes an echo skb before advancing tx_tail. In
parallel, the transmit path reads tx_head, tx_tail and the tail echo slot
when applying the erratum 6 queue restriction. There is no synchronization
between these operations.

On SMP, the transmit path can consequently observe a pending frame with an
empty echo slot. It can also keep a pointer to an echo skb while the
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
ring as one state. The same lock serializes the MODE/CMD/MODE
sequence between the transmit and interrupt paths. Keep completion
and wakeup outside the lock to avoid nesting the TX state lock with
the netdev TX queue lock.

Tested on an RK3588 rev2.2 at 1 Mbit/s with 100,000 extended CAN frames.
The run triggered 138 erratum 6 retries and completed without drops, queue
stalls or driver warnings. RK3588 does not enable erratum 12, so this test
does not exercise that hardware workaround.

Fixes: ae002cc32ec4 ("can: rockchip_canfd: prepare to use full TX-FIFO depth")
Fixes: 83f9bd6bf39d ("can: rockchip_canfd: implement workaround for erratum 12")
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
Changes in v4:
- Use reverse Christmas tree order for the new local variables.
- Use the _unmasked suffix for both TX state snapshots.

Changes in v3:
- Adjust for the can_put_echo_skb() ownership change in patch 1; no
  functional changes.

Changes in v2:
- Serialize the erratum 12 MODE/CMD/MODE sequence with the TX lock.
- Add the erratum 12 commit to the Fixes tags.
- Add RK3588 extended-frame stress-test results.
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
index 2b5cd6aab31b..c311b6990bc9 100644
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
 
@@ -124,8 +138,11 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 			      *(u32 *)(cfd->data + i));
 
 	frame_len = can_skb_get_frame_len(skb);
+	spin_lock_irqsave(&priv->tx_lock, flags);
 	err = can_put_echo_skb(skb, ndev, tx_head, frame_len);
 	if (err) {
+		spin_unlock_irqrestore(&priv->tx_lock, flags);
+
 		ndev->stats.tx_dropped++;
 		return NETDEV_TX_OK;
 	}
@@ -134,6 +151,7 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	WRITE_ONCE(priv->tx_head, priv->tx_head + 1);
 
 	rkcanfd_start_xmit_write_cmd(priv, reg_cmd);
+	spin_unlock_irqrestore(&priv->tx_lock, flags);
 
 	netif_subqueue_maybe_stop(priv->ndev, 0,
 				  rkcanfd_get_effective_tx_free(priv),
@@ -150,6 +168,8 @@ void rkcanfd_handle_tx_done_one(struct rkcanfd_priv *priv, const u32 ts,
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

