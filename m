Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9920843B3F8;
	Thu, 30 Jul 2026 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419342; cv=none; b=PZKVLKqEuScFlfZVcYplYW2LYI9QvWVP+Nhq/2ap66xt3N8IqEK2VYtWYEZDe4hyZ8aPzh+vIj1PSvgpQWOQ/Yn2RgcwXrEyI6SVyfbXREfTVOoPPmYbiVSPkYoTMgd+2JjjuIJPmDAuRhp5/g6pntppq0WvqDBsjzhSJOX9/FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419342; c=relaxed/simple;
	bh=Ixk4piSQ1y2IZtbE2rjWHMFHmywGxI7q2dnMxqX8tE8=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:References:
	 In-Reply-To:To:Cc; b=EOEkCN3weqAYADzIrvG9OHzOd90IZ75HBrUl1wQn7KvzIfa/zA/JioY4KXScMqQtsyqWzR8EEkhqYJ2fsV71CncfKdpx3RCsqxZ9I7wzwT/VWZrPIg1bZquEJw3bM4Ns5sEREQaPyNYu2bnTqhzUFjhwaiVALfoqkzNOHLUyhiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=u3c0U4gE; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="u3c0U4gE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785419328; bh=xBr+L3ZwuiP4mVg149qPGP5ZOMsWtZxNKgOqCdiAMQQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=u3c0U4gEWCgB1ka6MoRdvZPyJmi31n2XYHHPGaRrxZQS6eHrH7SRym1fVQFt3MiHc
	 LzMYlHfMwl7Bv229A2a6hw647C6tQfyTozGhL6G01LQ23zdtpalFiThn3X9kLPa8dA
	 gnhJMrnnaBBI1BjbSd074AJykCDzF2myygHOko7w=
Received: from ubuntu2204.localdomain ([2409:8d20:22b:54c:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id C291AE95; Thu, 30 Jul 2026 21:48:41 +0800
X-QQ-mid: xmsmtpt1785419326t95dps3r8
Message-ID: <tencent_DF0D7ED74DEC340D32DF095A239B01238808@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5N5+tXQQPRFZn89mMmsIJSm+0MekUoGSIAv8hsGoAhd0RUijoB4
	 fTiWcpNLsIE/zKMhmI8Wdn5aUQZ49xOzBpL9s+FcTkCzrXJu0WZc/AD/kQMLKpbQGLI+DrOxax7H
	 4SVc4fJmAFUsMEpoEu2kGU4NUkRDe428SlrTFYjImpaTNb+7R5CWE2artjv+TsVwLwSlbIwUcBzt
	 IJZnq0I8XTwidgDLwvGMsPsAFTCFo4C8OosCuot/+WEZcYnQD/c13cNAxy7H2+gIzDhzUokaYmBn
	 Ef16XMQEB2u4WRPXwhu8Xds8olnTS6z5pUxR2fUwWYnJV8GNPoHVfKegkgmEGqI7OywOIckAzUIL
	 4e90W8kM10Nfaq1GbjbTyX2JWSyfVEaoxO8l2WKkAdEasYwZsVPNSKoWQEJIhk0DY4Tjp260o6ms
	 UbYAFmmPh5lqtHR69cKc+D+hksUO78azI3cHHIhuC0hilrn4sbGxb95RN4unw94n9A2Fx3njnZcm
	 UC0BnkFs2zgTkeL6ooQBvoQxR3jaXz75UxBXmk9OunHOGg7LOTWBDbpwgUOnl0McTXdRgzuRFdiN
	 xkHtKPKnyIoMmmN6uqaP5qf5Ka2fAw/zF2jQvvhTEM7tuy4gMa4AS10kf+FcNGLR1nmNwrFQHp4L
	 g7Ym7mhsjw8bWdaspGxwGFjnAHZCBtVcEe7iHQzTIoIEuJikLNqDDPOGLBDw+qn0lBHTjiFUWwYD
	 HmAzX3bskkrdghpEwJnFEQg/Lxf5ckB3tpjsUxnGlpO53ED3wyoQVPVtlLFvRliCPT56AvDFj6Fk
	 sWzRzm3TKd2VL9onQsZCYuZxah6h5KVJAkUvVev0CJBZtQPjyIXIJILLBq0fKi9Eo/Y39nyH1O7f
	 7VuT5+eY/VcjLj5+BFYl4ZbrCzQ+G1akCBdgIYJ2H9IhEUMVjYNE8LEqZe5lrtpeWoxOhqRqLyA5
	 ubojLqVPCQ13O/U+rYU9FrrMrhEzK8ybg2xXeAVWs+u5Gi2yjLsBjrw2WmMFIQPWh4enLo437ccE
	 iB1BvIDy9EbATugebairzX2ZWYGIdE78FMsMyvd421ChCupyIruPbyLfAiM09HOYiXcHFo2I1IJI
	 WOyKu3ofPWFh9s78pDzrSGAb7/6kJpmG4/X8BCBxJZiRh6+MutpTHBFOGI7+xgW4k2GM10wGV+O4
	 q69tp49mW95OfqGI3bQo0swvE5N0/NbHDgK6Q=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Cunhao Lu <1579567540@qq.com>
Date: Thu, 30 Jul 2026 21:48:40 +0800
Subject: [PATCH v3 3/3] can: rockchip_canfd: serialize TX state and command
 writes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260730-master-v3-3-91cf030c337d@qq.com>
References: <20260730-master-v3-0-91cf030c337d@qq.com>
In-Reply-To: <20260730-master-v3-0-91cf030c337d@qq.com>
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

On SMP, the transmit path can consequently observe a pending frame with
an empty echo slot:

  rockchip_canfd fea60000.can can0: rkcanfd_tx_tail_is_eff:
  echo_skb[0]=NULL tx_head=0x00060f7d tx_tail=0x00060f7c

It can also keep a pointer to an echo skb while the completion path removes
and queues it for NAPI, where it can be freed on another CPU. The
inconsistent snapshot can stop the netdev TX queue when there is no later
completion to wake it.

There is a second race in the command submission sequence.
rkcanfd_start_xmit() runs in softirq context while rkcanfd_xmit_retry() is
called from the RX interrupt handler. On controllers affected by erratum
12, both execute a MODE/CMD/MODE register sequence. The interrupt handler
can restore the default MODE between the softirq writes, causing the
resumed softirq to issue CMD without SPACE_RX_MODE and bypass the erratum
12 workaround.

Add a TX state lock and use it to protect tx_head, tx_tail and the echo skb
ring as one state. The same lock serializes the MODE/CMD/MODE sequence
between the transmit and interrupt paths. Keep the queue completion and
wake operation outside the lock to avoid nesting the TX state lock with
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
index 475c0409e215..9f57a35672ed 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
@@ -99,15 +99,26 @@ static int rkcanfd_rxstx_filter(struct rkcanfd_priv *priv,
 	struct rkcanfd_stats *rkcanfd_stats = &priv->stats;
 	const struct canfd_frame *cfd_nominal;
 	const struct sk_buff *skb;
+	unsigned long flags;
 	unsigned int tx_tail;
 
+	spin_lock_irqsave(&priv->tx_lock, flags);
+
+	if (!rkcanfd_get_tx_pending(priv))
+		goto out_unlock;
+
 	tx_tail = rkcanfd_get_tx_tail(priv);
 	skb = priv->can.echo_skb[tx_tail];
 	if (!skb) {
+		const unsigned int tx_head = priv->tx_head;
+		const unsigned int tx_tail_full = priv->tx_tail;
+
+		spin_unlock_irqrestore(&priv->tx_lock, flags);
+
 		netdev_err(priv->ndev,
 			   "%s: echo_skb[%u]=NULL tx_head=0x%08x tx_tail=0x%08x\n",
 			   __func__, tx_tail,
-			   priv->tx_head, priv->tx_tail);
+			   tx_head, tx_tail_full);
 
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
index 2b5cd6aab31b..ff9d8b77499c 100644
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
+	unsigned long flags;
+	unsigned int tx_free;
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

