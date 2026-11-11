Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794377931;
	b=1EM5MKoNAGjOIWIBS5u92LcXYmTMO9CGr7j8B+GfM7hrN7T22aCAsgkZGhs/TB+xQJeI
	 RkecijKRNkKYmKCJa30bczZ1/Ym01s/0d/KrhRAqgwLJpXzJwy5wU0fbV0bJDWidXao8I
	 hc49sNuAHDcktfPEv7+nVLEgifvi9fLHEm13rL7sssWEfnhrc3Rl+URiczKrKqnSy6VZC
	 b3U4iouAgVR4iqUZU9B9DeDWV3v+clzEoZFG/H75GEak39aA3GCa11rrhKVOP4P3BDQSm
	 axygMa/Iz4Li5S+FF5xdL/3fHODsh+WRxwew3fgu7sgFchMvL6twlBiMmp1chzfc4UA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377931;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uIR/VbAS1G7PDEsn/cN0Z0Ds1Axz5h3Z6HjOuuhVWNg=;
	b=W84fyMs1H7t8cUuWOzFmdXUucQ+pkjRKtkBmzN3E72BwW3QN6ILXyBYplvvhFll8K5Oh
	 6eryVtsZBu12MZMNSButR9KKZdttGxlqUoHvpketSRmPG7iVJMTjL8ZzMjCX0ffTJw/YJ
	 ZtgvTc1ySK7yFMl8A3X1X81MVRHPzzzNZR8071uYbGk+/dc42sfYoqSPxaV/z2P0jwCTG
	 s8UhT3YcyLJ+ON4zhS1IBQZI+D96kL2Mi5VjYuHQhs8CYkAQjQaeXiLxONAhmP2CBAOq1
	 1yD320L57hLYCh5N+tonr6iA+wTiHPJiB+f9JOpiyTVX/FV3N4+gG4QLytZcRuYXPHQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E52hNhuv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB90D60A380E;
	Wed, 11 Nov 2026 06:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E52hNhuv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794377930;
	b=cEPHlrxYLI1Rz/8Hkzhb/Ht3sSmenGuzqe6p2xXtioE7euBCmFzDsJdULUwFRXT5g6Qj
	 GTVDb8c7eNKns3Ruu3bsiJzJ4Pvx4QH5Nk15NBYncSjWpd/p7R7ofN9nnmh6Qz4F5kSJ1
	 KeZftKm4Qa+mrSHjs5G0Df7pcTa+Bt1GVK5avoWMofqUDLy/xaSdWeF5zl+v7BTRB1Ely
	 hb7U4eLDbnDu+ytj10+VuzViy6UmmTsh3/nw04adksZmDugWpwy5mGiUaVwzKSE02+9C5
	 su3444RhK8Phgcy3dHzhwoN55dS+Ht+tY9hKyJql+5wqXEKEOHD4vtuDj7gC6yonDoQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794377930;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uIR/VbAS1G7PDEsn/cN0Z0Ds1Axz5h3Z6HjOuuhVWNg=;
	b=KA3YZ9kJAEY086h/hCii/QIHRgHfRx95JV3ak55tSCVx0JUHhG9yaQnPedIS13Hq0pKM
	 njeSRzgS3uRSzAsmyV6reVcPlMwi1BEIFy7TaladaO6XBLJi7DUaG+MKEHzqW0VkTlZ6l
	 Phqag9W5uK3xzKiyo8xolyCMbyy2YPN9wEDqUhg653FCpHMcCl6LkCnN6oic2IvYFGVFW
	 2ltT4vEtJCxIZbW+LOZyzLrZWhceoYKeUyEa6HkrTbHKWZWp7i9VibFY9tmacRNUj8ZAt
	 Py157HB9kiZqq02fDbKwZNj9+q/Lvj3SCTV+5WBAMnfRC3sUZdRqRDGOtBv+2ICZ+wA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id F2C061F00A13;
	Wed, 11 Nov 2026 06:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377930;
	bh=uIR/VbAS1G7PDEsn/cN0Z0Ds1Axz5h3Z6HjOuuhVWNg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=E52hNhuvnBgJD2r5zqhJJl43DfpuND5fHHdCy1ykIjUHmLkVmoBKlgPN5U/gNeHMD
	 XWJFSSntLl7ZQ1Ww2RQsyaZEeYDh+jWLhC7J5YbXP4bN9Nyu2JdPQWuM6uhiUpRhgA
	 2uDMP6SYJ/XUmPWd2mA6ioUQ1g0g6xYZZ1dzzrl6XnpUIveKu+Yufcz6QnesXWo47r
	 UsnHuAfWz9LolFGQo+XXZ66VdlD694e8FB9VrnHktey+RU0Ac6Zjx/NZm5ohvLPqXO
	 zjIiJygOtbozkxFccyBOE1Wvvgz+VM1HAD48Mna+70B83yC3zcBnTcqrEwvhDTSrzi
	 i9tnYfcjp1/kQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5747248E1A;
	Wed, 11 Nov 2026 06:18:47 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Wed, 11 Nov 2026 14:18:02 +0800
Subject: [PATCH net v9 08/10] can: rockchip_canfd: serialize TX with
 bus-off and restart
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
Message-Id: <20261111-rockchip-canfd-restart-close-v9-8-6643f3825ba3@qq.com>
References: <20261111-rockchip-canfd-restart-close-v9-0-6643f3825ba3@qq.com>
In-Reply-To: <20261111-rockchip-canfd-restart-close-v9-0-6643f3825ba3@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794377925; l=12091;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=D399Iw8j6hNv0Cn3aQm8+RtJqxFTtDhKP8vRs6yDOk8=;
 b=Gn0rKSjMnyfyf8ILLxlDCJ6oMD+CVKuxSueW5lBzKw4APACLdl0hc81qUora+Hg+sDDRRS2ob
 3TPEU00Ws3vBV+4iMUCVnea6BizFoNz5a20YcsbEUqPdzN6gcSqGHfZ
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

The bus-off path can reset the controller while TX submission or RX-side
echo handling is active. CAN restart flushes echo skbs before set_mode(),
so disabling TX in that callback is too late to protect the echo ring.

Use tx_lock and tx_enabled to drain TX and RX-side echo users before
publishing CAN_STATE_BUS_OFF. Return NETDEV_TX_BUSY while TX is disabled
and drop consumed RX entries so self-transmitted frames cannot escape
echo filtering as ordinary RX.

Before restart, mask device interrupts and flush the mask write, suspend
shared IRQ access, and drain active handlers and timestamp work. After
reinitialization, restore carrier, TX, IRQ handling and the queue under
tx_lock, so the old bus-off IRQ cannot leave carrier off and a new bus-off
takes precedence. Keep synchronous waits outside the lock and other
shared IRQ users enabled.

Reset clears INT_MASK. Restore and flush the full mask immediately after
deassertion so the remaining controller configuration stays masked.

Keep IRQ handling suspended until open completes and TX disabled on
close or failed open. Initialize timestamp work once at probe.

Fixes: ff60bfbaf67f ("can: rockchip_canfd: add driver for Rockchip CAN-FD controller")
Fixes: b6661d73290c ("can: rockchip_canfd: add TX PATH")
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>

---
Changes in v9:
- Restore and flush the full interrupt mask immediately after reset
  deassertion, before the remaining controller configuration.
- Count consumed RX FIFO entries discarded while TX is disabled.
- Include asm/barrier.h directly for release/acquire operations.

Changes in v8:
- Move skb ownership handling and running TX/RX critical sections to
  the preceding TX patches.

Changes in v7:
- Introduce restart/IRQ synchronization and TX protection together.
- Reuse prerequisite TX locking and adapt to the updated skb ownership.

Changes in v6:
- Defer the original skb's release until after unlocking.
- Abort TX submission if echo preparation fails.

Changes in v5:
- Drop consumed RX FIFO entries when tx_enabled is false under tx_lock,
  rather than skipping only echo filtering and delivering them as RX.

Changes in v3:
- Replace disable_irq()/enable_irq() with device interrupt masking,
  mask readback, an irq_suspended flag and synchronize_irq().
- Pair release/acquire accesses to publish reinitialized state before
  the IRQ handler resumes, without disabling other shared IRQ users.
- Initialize timestamp delayed work once at probe and synchronously
  cancel it before reinitializing the timestamp state during restart.
---
 drivers/net/can/rockchip/rockchip_canfd-core.c     | 66 ++++++++++++++++++++--
 drivers/net/can/rockchip/rockchip_canfd-rx.c       | 11 +++-
 .../net/can/rockchip/rockchip_canfd-timestamp.c    |  6 +-
 drivers/net/can/rockchip/rockchip_canfd-tx.c       |  4 ++
 drivers/net/can/rockchip/rockchip_canfd.h          |  6 +-
 5 files changed, 84 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index d05264605efc2..a5c6331191d17 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -22,6 +22,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/string.h>
 
+#include <asm/barrier.h>
+
 #include "rockchip_canfd.h"
 
 static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3568v2 = {
@@ -116,6 +118,10 @@ static void rkcanfd_chip_set_reset_mode(const struct rkcanfd_priv *priv)
 	udelay(2);
 	reset_control_deassert(priv->reset);
 
+	/* Reset clears INT_MASK; restore it before configuring the controller. */
+	rkcanfd_write(priv, RKCANFD_REG_INT_MASK, RKCANFD_REG_INT_ALL);
+	rkcanfd_read(priv, RKCANFD_REG_INT_MASK);
+
 	rkcanfd_write(priv, RKCANFD_REG_MODE, 0x0);
 }
 
@@ -325,6 +331,34 @@ static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
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
+	/* Restore carrier after draining the old bus-off IRQ. Hold tx_lock
+	 * through IRQ resumption and queue wake so a new bus-off takes
+	 * precedence.
+	 */
+	spin_lock_irqsave(&priv->tx_lock, flags);
+	netif_carrier_on(priv->ndev);
+	priv->tx_enabled = true;
+	/* Publish initialized state to the IRQ handler's acquire. */
+	smp_store_release(&priv->irq_suspended, false);
+	rkcanfd_chip_interrupts_enable(priv);
+	netif_wake_queue(priv->ndev);
+	spin_unlock_irqrestore(&priv->tx_lock, flags);
+}
+
 static void __rkcanfd_chip_stop(struct rkcanfd_priv *priv, const enum can_state state)
 {
 	priv->can.state = state;
@@ -356,9 +390,17 @@ static int rkcanfd_set_mode(struct net_device *ndev,
 
 	switch (mode) {
 	case CAN_MODE_START:
+		rkcanfd_tx_disable(priv);
+		rkcanfd_chip_interrupts_disable(priv);
+		/* Flush the interrupt mask write before suspending the handler. */
+		rkcanfd_read(priv, RKCANFD_REG_INT_MASK);
+		WRITE_ONCE(priv->irq_suspended, true);
+		/* Wait for handlers that already passed the suspended check. */
+		synchronize_irq(ndev->irq);
+		rkcanfd_timestamp_stop_sync(priv);
+
 		rkcanfd_chip_start(priv);
-		rkcanfd_chip_interrupts_enable(priv);
-		netif_wake_queue(ndev);
+		rkcanfd_chip_start_finish(priv);
 		break;
 
 	default:
@@ -592,6 +634,11 @@ static int rkcanfd_handle_state_error_int(struct rkcanfd_priv *priv)
 	 * handles cf == NULL.
 	 */
 	skb = rkcanfd_alloc_can_err_skb(priv, &cf, &timestamp);
+	/* Drain TX before publishing BUS_OFF, which permits a manual
+	 * restart to flush echo SKBs before calling our set_mode().
+	 */
+	if (new_state == CAN_STATE_BUS_OFF)
+		rkcanfd_tx_disable(priv);
 	can_change_state(ndev, cf, tx_state, rx_state);
 
 	if (new_state == CAN_STATE_BUS_OFF) {
@@ -666,6 +713,10 @@ static irqreturn_t rkcanfd_irq(int irq, void *dev_id)
 	struct rkcanfd_priv *priv = dev_id;
 	u32 reg_int_unmasked, reg_int;
 
+	/* Pairs with smp_store_release() in rkcanfd_chip_start_finish(). */
+	if (smp_load_acquire(&priv->irq_suspended))
+		return IRQ_NONE;
+
 	reg_int_unmasked = rkcanfd_read(priv, RKCANFD_REG_INT);
 	reg_int = reg_int_unmasked & ~priv->reg_int_mask_default;
 
@@ -733,6 +784,8 @@ static int rkcanfd_open(struct net_device *ndev)
 	if (err)
 		goto out_close_candev;
 
+	/* The shared IRQ handler may run before request_irq() returns. */
+	WRITE_ONCE(priv->irq_suspended, true);
 	rkcanfd_chip_start(priv);
 	can_rx_offload_enable(&priv->offload);
 
@@ -740,13 +793,12 @@ static int rkcanfd_open(struct net_device *ndev)
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
@@ -760,7 +812,7 @@ static int rkcanfd_stop(struct net_device *ndev)
 	struct rkcanfd_priv *priv = netdev_priv(ndev);
 
 	close_candev_cancel_restart_sync(ndev);
-	netif_stop_queue(ndev);
+	rkcanfd_tx_disable(priv);
 
 	rkcanfd_chip_interrupts_disable(priv);
 	free_irq(ndev->irq, priv);
@@ -937,6 +989,8 @@ static int rkcanfd_probe(struct platform_device *pdev)
 	if (err)
 		goto out_free_candev;
 
+	rkcanfd_timestamp_work_init(priv);
+
 	err = rkcanfd_register(priv);
 	if (err)
 		goto out_can_rx_offload_del;
diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
index 23476a334d6c3..0eab00623e037 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
@@ -91,7 +91,7 @@ rkcanfd_fifo_header_to_cfd_header(const struct rkcanfd_priv *priv,
 	return len + cfd->len;
 }
 
-/* Called with tx_lock held. */
+/* Called with tx_lock held and TX enabled. */
 static int rkcanfd_rxstx_filter(struct rkcanfd_priv *priv,
 				const struct canfd_frame *cfd_rx, const u32 ts,
 				bool *tx_done)
@@ -242,7 +242,16 @@ static int rkcanfd_handle_rx_int_one(struct rkcanfd_priv *priv)
 		return 0;
 	}
 
+	/* Drop consumed FIFO entries while TX is disabled to avoid delivering
+	 * self-received frames as ordinary RX without echo filtering.
+	 */
 	spin_lock_irqsave(&priv->tx_lock, flags);
+	if (unlikely(!priv->tx_enabled)) {
+		spin_unlock_irqrestore(&priv->tx_lock, flags);
+		stats->rx_dropped++;
+		return 0;
+	}
+
 	err = 0;
 	if (rkcanfd_get_tx_pending(priv))
 		err = rkcanfd_rxstx_filter(priv, cfd, header->ts, &tx_done);
diff --git a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
index 72774cd2f94b7..ad582afbbd682 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
@@ -37,6 +37,11 @@ static void rkcanfd_timestamp_work(struct work_struct *work)
 	schedule_delayed_work(&priv->timestamp, priv->work_delay_jiffies);
 }
 
+void rkcanfd_timestamp_work_init(struct rkcanfd_priv *priv)
+{
+	INIT_DELAYED_WORK(&priv->timestamp, rkcanfd_timestamp_work);
+}
+
 void rkcanfd_timestamp_init(struct rkcanfd_priv *priv)
 {
 	const struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
@@ -73,7 +78,6 @@ void rkcanfd_timestamp_init(struct rkcanfd_priv *priv)
 	max_cycles = min(max_cycles, cc->mask);
 	work_delay_ns = clocksource_cyc2ns(max_cycles, cc->mult, cc->shift);
 	priv->work_delay_jiffies = div_u64(work_delay_ns, 3u * NSEC_PER_SEC / HZ);
-	INIT_DELAYED_WORK(&priv->timestamp, rkcanfd_timestamp_work);
 
 	netdev_dbg(priv->ndev, "clock=%lu.%02luMHz bitrate=%lu.%02luMBit/s div=%u rate=%lu.%02luMHz mult=%u shift=%u delay=%lus\n",
 		   priv->can.clock.freq / MEGA,
diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
index 8998b7855d15d..6f60d4119812f 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
@@ -85,6 +85,10 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		return NETDEV_TX_OK;
 
 	spin_lock_irqsave(&priv->tx_lock, flags);
+	if (unlikely(!priv->tx_enabled)) {
+		netif_stop_queue(ndev);
+		goto out_busy;
+	}
 
 	if (!netif_subqueue_maybe_stop(priv->ndev, 0,
 				       rkcanfd_get_effective_tx_free(priv),
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 077dd57d42de9..8fdb59025bfaf 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -475,7 +475,7 @@ struct rkcanfd_priv {
 	struct can_rx_offload offload;
 	struct net_device *ndev;
 
-	/* Protect running TX/RX echo state, queue updates and TX commands. */
+	/* Serialize TX submission/completion with bus-off and restart. */
 	spinlock_t tx_lock;
 	void __iomem *regs;
 	unsigned int tx_head;
@@ -485,6 +485,9 @@ struct rkcanfd_priv {
 	u32 reg_int_mask_default;
 	struct rkcanfd_devtype_data devtype_data;
 
+	bool tx_enabled;
+	bool irq_suspended;
+
 	struct cyclecounter cc;
 	struct timecounter tc;
 	struct delayed_work timestamp;
@@ -554,6 +557,7 @@ int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv);
 
 void rkcanfd_skb_set_timestamp(const struct rkcanfd_priv *priv,
 			       struct sk_buff *skb, const u32 timestamp);
+void rkcanfd_timestamp_work_init(struct rkcanfd_priv *priv);
 void rkcanfd_timestamp_init(struct rkcanfd_priv *priv);
 void rkcanfd_timestamp_start(struct rkcanfd_priv *priv);
 void rkcanfd_timestamp_stop(struct rkcanfd_priv *priv);

-- 
2.34.1


