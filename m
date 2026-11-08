Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794137684;
	b=DCftyRb9QMNrZCv2ezX3/ag5AVBN+3rwzunPqrgGg3IXVMZzyR3q4pbpu3AiEzYP8uke
	 BFs25ed3Ww8Cj88x7CuiyucZfdLLgFfxFSVeIxX3TqZ39cmKz8A1hMjAeDTx2MPQDApXb
	 XxtGMuzlrh2NPTCId3sy75Jx/2U6htGKHJd1X2Mbpbmo/uI8i3pQxJTd+U/epETaA1Cbw
	 VP27vnwWrxN0FNTXhmOOnIptuqR/+hKtIDVqapG8NTodGqd30meOxSrB48Y3rKdD/McP3
	 mBttmQGVRTOs/2KlyQOohfrZGI6QWjUPVSQzfDA4fbVyumiIAvxpT5PNWSQPM3r8eSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794137684;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=TjbBemQPJnJ9RYKttAP+fZf5q7tkMwispOTZo7QXREM=;
	b=ofRvsCHnTifB0LgiAL4jZZkB3OJ/vTbMkpbUvsCsKsHjidJ8Q5KZMWQiXyc6RXeYSdKm
	 ZhviCFvFJo68Q5FnQkjCIgiDM/7vq4bBY4L5ZttoAw2GqIVauNeKykuQGTukFUCIT+jZP
	 UxVristPX9JPKm5eQqiljB3SYzJojVHiWTYF0XwgmGNEZMoXSJ/bnw1xR8nCcNwH80Pl0
	 VsDWi8mXQB1/XMMC2ksXjNlCc/Uu+2LNXJmiVkvmNosnTCyJCb8BQf0XtzCxjgEGP9+9l
	 n5i8qXhfWYHHbsrQWoe+AHiWN866oqWXV52X9aooiFSqJV+GPXRGtAFtvVpu+rn9JhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLxUROZ+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCC9606EE87;
	Sun,  8 Nov 2026 11:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLxUROZ+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794137684;
	b=NksfBgkryho/T+WlAj3ivLIzLL6FD6sn3kTg6eAf2CmnSze7XyswAKY7ZjJVQVW+r0eU
	 sGB3MmajT0U8TNwnPyzLhETlU17aoWDJ/fS2B6rWITuQwUYw7bmXNmK2HpycFav+fvewB
	 p9W5VWkiPOITgdvQFJroOmmzzwtNvFYKN5Uw8gwjPdyQ/iUY6Ev3NwPDqBJl38P9zIadW
	 F4C8IcsKKtpvlcOPkH7e8p1Yssm+X5j/VQ/D2a5I/1i8PN8mxK9a2Awhw8uBdHZO6Eafy
	 Jfxi439Zs7rnoD/68cP2z68KCDzfVz3dvoFy4jaPJk6rGMYKADCD1qcByr0FpBULF2Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794137684;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=TjbBemQPJnJ9RYKttAP+fZf5q7tkMwispOTZo7QXREM=;
	b=m7+dctP5aL6tDNS1eyGLkwEZGj/EYiPUTCyP4xsa3WKrbWBpkfS0GoZ5GYfOocgcRQEr
	 DkTinY4PShzEIdniudTZZppV8lharYEzGcslPCPe6Rzkqaa4XY0a4Qw9A3mZuXMBl+RWE
	 ykdchw5bOVz51a7o6xRpowYANeXCbsSt2Rd8AiQ8E0afu3RFh7LJBupHMaRiZIu7/3swI
	 q/6rR/Gs7Nt18uQXjImBiygVeRQdXNXOYCUPvpFxt7HSSIUU7hnA35xRQRyQnNTQxyu0n
	 ShYgrEQNyfkAY6iqie3LNG6Z5b+i/lE9QaSGueO7Pco/Mlpgu4+OMv5PfOVazP7pIeQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id ABAB91F008A3;
	Sun,  8 Nov 2026 11:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794137683;
	bh=TjbBemQPJnJ9RYKttAP+fZf5q7tkMwispOTZo7QXREM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=MLxUROZ+G9Sz1r4Fy2ctYOKyE3sLHOP9/5vJnrt583HgJypLjs3RPYctnHIaSLwjU
	 86ZIyomM6C8PXjPFE9RY3hwO42DZMrCBDMYy8fYGbRUqBgLYM7s+3KNtC8j/GlP3nO
	 TJ521qGe9AdgBGjwCAQTRa2/Ut0WYHEnkhe0wimRRntvSIP5i22MGFC6UHv/0zE4OC
	 YT+EmcU2ZCBuWFIAQIZGjL9umFZYNupph/O5/rDzfINoOCQKJaFmiz6dItN8HvqXJo
	 9DHE8jvdlYJ2EUiIPNTXcYXTnwmxaBmNSWBlBopycqhSrwa+1/PaDlC1rgoyZ45WwV
	 NBcOkhWPaJtIw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A338C47F29;
	Sun,  8 Nov 2026 11:34:40 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Sun, 08 Nov 2026 19:33:35 +0800
Subject: [PATCH net v8 08/10] can: rockchip_canfd: serialize TX with
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
Message-Id: <20261108-rockchip-canfd-restart-close-v8-8-3e7a23fd9eae@qq.com>
References: <20261108-rockchip-canfd-restart-close-v8-0-3e7a23fd9eae@qq.com>
In-Reply-To: <20261108-rockchip-canfd-restart-close-v8-0-3e7a23fd9eae@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Vincent Mailhol <mailhol@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: Cunhao Lu <1579567540@qq.com>, linux-can@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794137678; l=11324;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=hAuSAw5/dFohWVygYp1eacUIJNThuZakLHSTnH34wzc=;
 b=oX3pUjEeQ094RDo9JACQTtCw+9EyWbEtXjpzHwVqJCQrvAx4RwmcwXFstxk+vzPH3Qc+PWAK7
 MTYW4D/O+PsBtSoktIk6UkZGH4CpR24RywRnt0NUdfDh8zBRh2GoLLv
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

Keep IRQ handling suspended until open completes and TX disabled on
close or failed open. Initialize timestamp work once at probe.

Fixes: ff60bfbaf67f ("can: rockchip_canfd: add driver for Rockchip CAN-FD controller")
Fixes: b6661d73290c ("can: rockchip_canfd: add TX PATH")
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>

---
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
 drivers/net/can/rockchip/rockchip_canfd-core.c     | 63 +++++++++++++++++++---
 drivers/net/can/rockchip/rockchip_canfd-rx.c       | 10 +++-
 .../net/can/rockchip/rockchip_canfd-timestamp.c    |  6 ++-
 drivers/net/can/rockchip/rockchip_canfd-tx.c       |  4 ++
 drivers/net/can/rockchip/rockchip_canfd.h          |  5 +-
 5 files changed, 79 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index d05264605efc2..536d9bc812afe 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -20,6 +20,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/smp.h>
 #include <linux/string.h>
 
 #include "rockchip_canfd.h"
@@ -325,6 +326,35 @@ static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
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
@@ -356,9 +386,17 @@ static int rkcanfd_set_mode(struct net_device *ndev,
 
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
@@ -592,6 +630,12 @@ static int rkcanfd_handle_state_error_int(struct rkcanfd_priv *priv)
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
@@ -666,6 +710,10 @@ static irqreturn_t rkcanfd_irq(int irq, void *dev_id)
 	struct rkcanfd_priv *priv = dev_id;
 	u32 reg_int_unmasked, reg_int;
 
+	/* Pairs with smp_store_release() in rkcanfd_chip_start_finish(). */
+	if (smp_load_acquire(&priv->irq_suspended))
+		return IRQ_NONE;
+
 	reg_int_unmasked = rkcanfd_read(priv, RKCANFD_REG_INT);
 	reg_int = reg_int_unmasked & ~priv->reg_int_mask_default;
 
@@ -733,6 +781,8 @@ static int rkcanfd_open(struct net_device *ndev)
 	if (err)
 		goto out_close_candev;
 
+	/* The shared IRQ handler may run before request_irq() returns. */
+	WRITE_ONCE(priv->irq_suspended, true);
 	rkcanfd_chip_start(priv);
 	can_rx_offload_enable(&priv->offload);
 
@@ -740,13 +790,12 @@ static int rkcanfd_open(struct net_device *ndev)
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
@@ -760,7 +809,7 @@ static int rkcanfd_stop(struct net_device *ndev)
 	struct rkcanfd_priv *priv = netdev_priv(ndev);
 
 	close_candev_cancel_restart_sync(ndev);
-	netif_stop_queue(ndev);
+	rkcanfd_tx_disable(priv);
 
 	rkcanfd_chip_interrupts_disable(priv);
 	free_irq(ndev->irq, priv);
@@ -937,6 +986,8 @@ static int rkcanfd_probe(struct platform_device *pdev)
 	if (err)
 		goto out_free_candev;
 
+	rkcanfd_timestamp_work_init(priv);
+
 	err = rkcanfd_register(priv);
 	if (err)
 		goto out_can_rx_offload_del;
diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
index 23476a334d6c3..fb98dd0da4913 100644
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
@@ -242,7 +242,15 @@ static int rkcanfd_handle_rx_int_one(struct rkcanfd_priv *priv)
 		return 0;
 	}
 
+	/* Drop consumed FIFO entries while TX is disabled to avoid delivering
+	 * self-received frames as ordinary RX without echo filtering.
+	 */
 	spin_lock_irqsave(&priv->tx_lock, flags);
+	if (unlikely(!priv->tx_enabled)) {
+		spin_unlock_irqrestore(&priv->tx_lock, flags);
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
index 077dd57d42de9..3664124a8da25 100644
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
@@ -483,6 +483,8 @@ struct rkcanfd_priv {
 
 	u32 reg_mode_default;
 	u32 reg_int_mask_default;
+	bool tx_enabled;
+	bool irq_suspended;
 	struct rkcanfd_devtype_data devtype_data;
 
 	struct cyclecounter cc;
@@ -554,6 +556,7 @@ int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv);
 
 void rkcanfd_skb_set_timestamp(const struct rkcanfd_priv *priv,
 			       struct sk_buff *skb, const u32 timestamp);
+void rkcanfd_timestamp_work_init(struct rkcanfd_priv *priv);
 void rkcanfd_timestamp_init(struct rkcanfd_priv *priv);
 void rkcanfd_timestamp_start(struct rkcanfd_priv *priv);
 void rkcanfd_timestamp_stop(struct rkcanfd_priv *priv);

-- 
2.34.1


