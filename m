Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795077591;
	b=iYbkNjmcxH/0fOG06Htru5nALjkeSBxCbtxoHKyWvgDSskQEuVJZW9l7xJJgAlPa0TCY
	 HOAV+N6Vtyxw+e8AkyzNUWYLC4YkGE7iPg5SGD+xhQ0jU41kTUmh+lxpzm5UUBWECpdo0
	 7QSJQIlldmoOPv5NtgBdCRqWEyjII0cEGN5Dnt/rrNMDJTxN9XfctOL/XxlsQ1sVgtVRh
	 g8XOO+4GoyJB2OreRd3wu83lMTuklXVPchAspcMNJ2AWZPZ825nb/dojKAV+TzHC2k1QT
	 UCiyKaGmy+o1bee+4l+RXn/T87XoXL43cx8L3ezPJCMqtOtgbCTDyE6XyoxeKTJnEqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795077591;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=KzEnCWc+xGXfXES6kzJrx024f7eRRyHkVTj0wtJroNE=;
	b=LfCAUnxS1imMyxbrt26Qzzvz9RRc1iyEYLwtFNN6WafanjF0WlkUAOM4oyz8GjrHaGYx
	 qVqvBgpq3So0PPlc6iA+pZUyfjXU7tEmf/U+4mXvJA5BsDr93ppWdEq4osswJAt1dTPum
	 LItuSlAX2bg82GZLVpLYYuEfJundEdrJ1+ph2B6+fGb2GdzdrUo0hqvMd08GGoy4AlM1o
	 qWI9DNeYREuepusG2WpRlr28JLC4Cek+7ZSS2RWyV6P0pkZsS97z4xEcwDub8b0cqLgql
	 dnaHue/ZBVj3CcluOruZAx535FAIL8/PhVH2gIbv5rG4u3MfW3jxk26yfsIAocKqGNA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="d6CIL/8V";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0499D60A2628;
	Thu, 19 Nov 2026 08:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6CIL/8V
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795077590;
	b=ZFaJgHSpDI7h18aA3rMYsRHl4GYeiEtaczqWlwwiWNvcqMySrJBawOKPHFNqW1YwFzTI
	 IPaWrsbRVu2eXZM06Hrjfae7wUGVEFd6Tr/5ifmShfieIRdzoHAyttWtYbr0/3SQRj/iK
	 qbiz83H6bRj7NFki987bUrY0PsKunnD2hEpHHhh+L1m/Aq6vkLzegeUihu3J9OumP7Ao6
	 6ocZPOvyOpBG/B6pXUeFFKtZDX2iQx6ej6b9+qCh0hV8eeK2YwTWBGWcauNf0cXn0JI+V
	 uPy0V5QzhpKqhvTi9vAQF0lWNxzPYNyoNsr0L6T8ltPL2l7t0/rc+RLT8cNV+Urq+sA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795077590;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=KzEnCWc+xGXfXES6kzJrx024f7eRRyHkVTj0wtJroNE=;
	b=NH0uJYxfS0rtE6ZZvvvqsWbaL9D27ngmhdJGbcP600GaIvM1vJsAdRWa70HzbvgFRFqS
	 DjkdT5cd2qBV/bnEgn5chnbqU9wudIHpQH2lechLfSuZCCQoVrE7ICbxwC6WSOofg8a0r
	 hMU9gKSANkNvBF8TjwMqiDaHnb3q8ioeBBJ0zUvguQNuBuSCOoUCwDOlmbVnhw4FzzR3T
	 MouJcwwQOqzTkxndjHIR21UNrcI5ByttXSEw8qmqRPrSMa/IrnxzSYyFA/WOWj4TvJiEt
	 grgg38qw8Z9qO8B3cRDSegZdHhtHHMA6EKyB+Q4r7B36GHTJU0ZHIP5B6wJnFFlkY2w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E69211F000C7;
	Thu, 19 Nov 2026 08:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795077590;
	bh=KzEnCWc+xGXfXES6kzJrx024f7eRRyHkVTj0wtJroNE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=d6CIL/8VDMre2bk4vgZA+xY7h2JmS1GmH05GL4vUmP/h8j1/KSEIJY93YPQkliBGo
	 4N/c7KZTDe4bgVirSWdmBU6oX/xsKmubgurB8+PiOXPi92t4HWsXFxz674AYjqzESY
	 0W+rRnJDXCP7sxPu21P/0qktxVyp5202GGCap+3hv05uX1eCWIFB+F+gUCmKlg3xy3
	 9gqup1CnXemAPL1UANEgTfJkSY7KsA1QTGINvkLxkNj4JghQx4JeAKcugswHSyL401
	 np7Ny9oofBIXCvNqP7XNgZQNCrSgs7edF3YBK8G8+K2Fe8huFLilozqQNvgAEVA0jv
	 ysMFSFa+WbIKg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 726574B1AA;
	Thu, 19 Nov 2026 08:39:49 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 19 Nov 2026 16:39:43 +0800
Subject: [PATCH net v10 02/10] can: rockchip_canfd: serialize TX state and
 command writes
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261119-rockchip-canfd-restart-close-v10-2-df23913aa33a@qq.com>
References: <20261119-rockchip-canfd-restart-close-v10-0-df23913aa33a@qq.com>
In-Reply-To: <20261119-rockchip-canfd-restart-close-v10-0-df23913aa33a@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Vincent Mailhol <mailhol@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Cunhao Lu <1579567540@qq.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795077587; l=8885;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=jRFiGuScFj8gP5uApkkYTNuUilstwA45FXHUGO8YZJQ=;
 b=LStmgWa5ybn4Kcpa1OdDFWwDqt/Rp4bo43ZeoTsxc8HOwxBC8mFtBs600ncTCRpfP48O0Y7xf
 8M4NJp/RoNeD2jGjhEGTrtZtJegp7g93G7YX2YVEU27szFxPBsT4gES
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

rkcanfd_get_effective_tx_free() inspects the tail echo entry while the RX
completion path removes it and advances tx_tail. Concurrent TX submission
can dereference an skb already queued for NAPI, where another CPU can
free it, or miscount free slots and stop the TX queue with no completion
left to wake it.

TX submission and RX-side retry also share the MODE/CMD/MODE sequence
used for erratum 12. Interleaving these sequences can restore the default
mode before the other caller writes CMD, bypassing the workaround.

Serialize TX submission with RX completion and retry using tx_lock. Hold
it across the TX space and RX pending checks, echo handling, head/tail
updates, BQL accounting, queue stop/wake and command writes. Require
caller-held locking in the shared helpers and keep TX diagnostics in
the same critical section.

Release the retained original skb after unlocking and restoring IRQs, so
its socket destructor cannot run under tx_lock.

Fixes: ae002cc32ec4 ("can: rockchip_canfd: prepare to use full TX-FIFO depth")
Fixes: 83f9bd6bf39d ("can: rockchip_canfd: implement workaround for erratum 12")
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>

---
Changes in v8:
- Extend the TX/RX critical sections to cover space and pending checks,
  queue updates and diagnostics; require caller-held helper locking and
  assert it for command writes.
- Release the retained original skb after unlocking.
---
 drivers/net/can/rockchip/rockchip_canfd-core.c |  1 +
 drivers/net/can/rockchip/rockchip_canfd-rx.c   | 23 ++++++++++++++---------
 drivers/net/can/rockchip/rockchip_canfd-tx.c   | 26 +++++++++++++++++++++++---
 drivers/net/can/rockchip/rockchip_canfd.h      |  3 +++
 4 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 37c1c22c40c9..1cae86973da5 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -921,6 +921,7 @@ static int rkcanfd_probe(struct platform_device *pdev)
 	priv->can.do_set_mode = rkcanfd_set_mode;
 	priv->can.do_get_berr_counter = rkcanfd_get_berr_counter;
 	priv->ndev = ndev;
+	spin_lock_init(&priv->tx_lock);
 
 	match = device_get_match_data(&pdev->dev);
 	if (match) {
diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
index 24e87daa1df0..23476a334d6c 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
@@ -91,6 +91,7 @@ rkcanfd_fifo_header_to_cfd_header(const struct rkcanfd_priv *priv,
 	return len + cfd->len;
 }
 
+/* Called with tx_lock held. */
 static int rkcanfd_rxstx_filter(struct rkcanfd_priv *priv,
 				const struct canfd_frame *cfd_rx, const u32 ts,
 				bool *tx_done)
@@ -101,6 +102,8 @@ static int rkcanfd_rxstx_filter(struct rkcanfd_priv *priv,
 	const struct sk_buff *skb;
 	unsigned int tx_tail;
 
+	lockdep_assert_held(&priv->tx_lock);
+
 	tx_tail = rkcanfd_get_tx_tail(priv);
 	skb = priv->can.echo_skb[tx_tail];
 	if (!skb) {
@@ -201,9 +204,11 @@ rkcanfd_fifo_header_empty(const struct rkcanfd_fifo_header *header)
 static int rkcanfd_handle_rx_int_one(struct rkcanfd_priv *priv)
 {
 	struct net_device_stats *stats = &priv->ndev->stats;
-	struct canfd_frame cfd[1] = { }, *skb_cfd;
 	struct rkcanfd_fifo_header header[1] = { };
+	struct canfd_frame cfd[1] = { }, *skb_cfd;
+	bool tx_done = false;
 	struct sk_buff *skb;
+	unsigned long flags;
 	unsigned int len;
 	int err;
 
@@ -237,15 +242,15 @@ static int rkcanfd_handle_rx_int_one(struct rkcanfd_priv *priv)
 		return 0;
 	}
 
-	if (rkcanfd_get_tx_pending(priv)) {
-		bool tx_done = false;
-
+	spin_lock_irqsave(&priv->tx_lock, flags);
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
index 420e59b41059..caa71cf8e39a 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
@@ -14,6 +14,8 @@ static bool rkcanfd_tx_tail_is_eff(const struct rkcanfd_priv *priv)
 	const struct sk_buff *skb;
 	unsigned int tx_tail;
 
+	lockdep_assert_held(&priv->tx_lock);
+
 	if (!rkcanfd_get_tx_pending(priv))
 		return false;
 
@@ -35,6 +37,8 @@ static bool rkcanfd_tx_tail_is_eff(const struct rkcanfd_priv *priv)
 
 unsigned int rkcanfd_get_effective_tx_free(const struct rkcanfd_priv *priv)
 {
+	lockdep_assert_held(&priv->tx_lock);
+
 	if (priv->devtype_data.quirks & RKCANFD_QUIRK_RK3568_ERRATUM_6 &&
 	    rkcanfd_tx_tail_is_eff(priv))
 		return 0;
@@ -45,6 +49,8 @@ unsigned int rkcanfd_get_effective_tx_free(const struct rkcanfd_priv *priv)
 static void rkcanfd_start_xmit_write_cmd(const struct rkcanfd_priv *priv,
 					 const u32 reg_cmd)
 {
+	lockdep_assert_held(&priv->tx_lock);
+
 	if (priv->devtype_data.quirks & RKCANFD_QUIRK_RK3568_ERRATUM_12)
 		rkcanfd_write(priv, RKCANFD_REG_MODE, priv->reg_mode_default |
 			      RKCANFD_REG_MODE_SPACE_RX_MODE);
@@ -60,6 +66,8 @@ void rkcanfd_xmit_retry(struct rkcanfd_priv *priv)
 	const unsigned int tx_head = rkcanfd_get_tx_head(priv);
 	const u32 reg_cmd = RKCANFD_REG_CMD_TX_REQ(tx_head);
 
+	lockdep_assert_held(&priv->tx_lock);
+
 	rkcanfd_start_xmit_write_cmd(priv, reg_cmd);
 }
 
@@ -69,12 +77,15 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	u32 reg_frameinfo, reg_id, reg_cmd;
 	unsigned int tx_head, frame_len;
 	const struct canfd_frame *cfd;
+	unsigned long flags;
 	int err;
 	u8 i;
 
 	if (can_dev_dropped_skb(ndev, skb))
 		return NETDEV_TX_OK;
 
+	spin_lock_irqsave(&priv->tx_lock, flags);
+
 	if (!netif_subqueue_maybe_stop(priv->ndev, 0,
 				       rkcanfd_get_effective_tx_free(priv),
 				       RKCANFD_TX_STOP_THRESHOLD,
@@ -85,7 +96,7 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 				    priv->tx_head, priv->tx_tail,
 				    rkcanfd_get_tx_pending(priv));
 
-		return NETDEV_TX_BUSY;
+		goto out_busy;
 	}
 
 	cfd = (struct canfd_frame *)skb->data;
@@ -117,8 +128,8 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	tx_head = rkcanfd_get_tx_head(priv);
 	reg_cmd = RKCANFD_REG_CMD_TX_REQ(tx_head);
 
-	/* Retain the original skb as the frame-data source even if the
-	 * echo skb is removed before submission finishes.
+	/* Keep the original skb alive until IRQs are restored so echo
+	 * preparation cannot invoke its socket destructor under tx_lock.
 	 */
 	frame_len = can_skb_get_frame_len(skb);
 	err = can_put_echo_skb(skb_get(skb), ndev, tx_head, frame_len);
@@ -142,15 +153,22 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 				  RKCANFD_TX_STOP_THRESHOLD,
 				  RKCANFD_TX_START_THRESHOLD);
 
+	spin_unlock_irqrestore(&priv->tx_lock, flags);
 	dev_consume_skb_any(skb);
 
 	return NETDEV_TX_OK;
 
 out_drop:
 	ndev->stats.tx_dropped++;
+	spin_unlock_irqrestore(&priv->tx_lock, flags);
 	dev_kfree_skb_any(skb);
 
 	return NETDEV_TX_OK;
+
+out_busy:
+	spin_unlock_irqrestore(&priv->tx_lock, flags);
+
+	return NETDEV_TX_BUSY;
 }
 
 void rkcanfd_handle_tx_done_one(struct rkcanfd_priv *priv, const u32 ts,
@@ -160,6 +178,8 @@ void rkcanfd_handle_tx_done_one(struct rkcanfd_priv *priv, const u32 ts,
 	unsigned int tx_tail;
 	struct sk_buff *skb;
 
+	lockdep_assert_held(&priv->tx_lock);
+
 	tx_tail = rkcanfd_get_tx_tail(priv);
 	skb = priv->can.echo_skb[tx_tail];
 
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 95bea9bfd8a2..077dd57d42de 100644
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
@@ -474,6 +475,8 @@ struct rkcanfd_priv {
 	struct can_rx_offload offload;
 	struct net_device *ndev;
 
+	/* Protect running TX/RX echo state, queue updates and TX commands. */
+	spinlock_t tx_lock;
 	void __iomem *regs;
 	unsigned int tx_head;
 	unsigned int tx_tail;

-- 
2.34.1


