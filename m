Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795077597;
	b=C/7Vyfc+OORSGHKkFQwSmydB1V+FekZ7KtoIP+jy0ZR4uw/z7h1I1JJ/hcHLDlqfpK8a
	 UtxOAJ9rSXqlBS29MT1Yo6E6Zhb6bbqtEyPimggbcYsOcKhEe/d8MIpZFTBjjyteO5GOE
	 pKYnUAuPZ+JhhLCM9DZHZb0B4jbz0r6CAWOkp+J5nThnKCboLMdlZ27K6J5KgkfqGoJ03
	 PDItRMI0mIYZe3Atj7XzeMPudEJFpkjJRVCsKsht14bD1i5ooYvI3q1sbGIeehKHjHrmA
	 c+dE+FmzN8v/xNTKyUcSeWskEAHijL38bpMaFonfSJwaMiw1bPpwkJGvpQ3dSGhbOAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795077597;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ZGxkpF3X1Al37G9RLiETPKjikVaI53b/aNWX65rEE00=;
	b=eWovRMssWwxdmEJekGBy426sl2K3PtWE8+abxAbqXWHKgisY2qPKcUdJHIW8vxZ+rSem
	 Cnb57cEhhGVa02KLm1FfiYY16/ymHkGGWQogwJQW3tmu6b1qVHoDTcOhUQ8eA5C8FzOmS
	 ExcyLHq8sTsukJZId3qySir+wItqQ60SqDOISJD8AFeLgp59jeY+o+icxFAD96dA2x6PN
	 6ot2ZevTbnuIpXRhZi4XifRKVJn3IpmscgDrOln5uh40QGVOfaVYo8rm+jllPa4ixUBNW
	 xeGNGFilv+Phz+E3oQLj8UU4ZywwSZJc3LRgsxR6oBekHVRH8tpAim+tbsu/+/NhcBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=THsV4oQL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F6560A6F6A;
	Thu, 19 Nov 2026 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=THsV4oQL
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795077596;
	b=wKHCza16/r77lXZeB0LkK1QW2wxQwAcW0SFui2qlKJCLIpQ7DVAM095XWKPinvA4Unxu
	 UO4EXR6aFwui+sg12RZlz1srBMRX+/ab4hBkvwPrxeHSX7fm7R1GUEI5rLCy1ldEVXTmn
	 lGElDpZnYXAQ8RwAurG0E9KvGwGZ0QFRnRfKNeZ0vRhUjOCUOhERXZkB1F8TrgkF1kPEW
	 UFDyJ8sPtEke088JIIeZWi52ByWJA2OtxnW+urNrTzirnDJ6Zjm4Swyb6KpiYNR1o+UW0
	 Q5p8qnfJawhXFhMFD0yqaRVB8LQIlb043zBZ5b2KhRSbpnfQUuFeSOuy2SPkb+jm85A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795077596;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ZGxkpF3X1Al37G9RLiETPKjikVaI53b/aNWX65rEE00=;
	b=XR9ErjW+tr7jNLo6aObnlkB+UslbXXd0gZICVjcZ+FyyQA+Mlir6KcO0MScLvZNuwSu+
	 5u+dN4A79sD4M29JtlGF9CXJjD2TLKbTpYI5yii+vAN7MsXQUMu82w2+2dSSHrgRViMl8
	 hIa8SK333ofU+2yvb/1QHOBXm33yCH9oJqOsvCNZBgQ6tNTdAARGCnfqTvsw4NXpMC3u/
	 qUaSSjoAVWuherW6gtIGl0c/BSl36CQ4KylEwJMq+RDP2TdVruR/eDLz0+Hu+D/7+b1iv
	 ew3U2B3axCMli5YyBdD5y2Qv0zuidQamIhastOF548n241fgAevN6oeYNRNxJl/mkwQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5A1831F00927;
	Thu, 19 Nov 2026 08:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795077596;
	bh=ZGxkpF3X1Al37G9RLiETPKjikVaI53b/aNWX65rEE00=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=THsV4oQLtZ1Hiy3tKGYqckTqoWWDeH7OGBJ/acpkoLlUX1MubYhdiXuuYv7rSWXUa
	 z0hIZgK8VT0UIOWnW5py4Q35Er5oCkNhXV/8FTUrhmWPOZDQfbQ9Cjcix/F7WOp6g6
	 LYFFVuizAZit8XtLRWR5p7zIE3F2T+z8ocBv7tf31OpIa/ZYQM1BVc4f3tC9cPGoB2
	 nOW4WlIdaKNW8RtBl6jSPU1X7yN2ginZ9Iw89oopvkANpwmqAwo4vw20aOQxMpQmA8
	 S9zLsxwMJNWztEmHa91ZkWtXsX2GosOZimz0dLz9CG+fuQmaC2LaYrBlnN0S++vL+r
	 a/nNPMTm0bj4w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id EBFDD4B1BE;
	Thu, 19 Nov 2026 08:39:49 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 19 Nov 2026 16:39:48 +0800
Subject: [PATCH net v10 07/10] can: rockchip_canfd: serialize TX with
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
Message-Id: <20261119-rockchip-canfd-restart-close-v10-7-df23913aa33a@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795077587; l=13604;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=/I3lRXkHGm7b7Ag8p5LF9zhZJx83XvMldyRqSJNiwyE=;
 b=3/5IEXXLYYxOmoU3Fx950VyERNu43ygVslW6QzlvqLWoLMxsCcsYf37y4TjUwSmv6tDzJUn01
 Iqf+42hYx9xDUmAsmz5KAepxl5RPqz62if14Kuh3fjmqYxM6QYE5Bos
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

Q: Does irq_suspended replace a lock around controller reinitialization?

A: No. Restart masks and flushes device interrupts, sets irq_suspended
and drains active handlers with synchronize_irq() before reinitializing
the controller. The release/acquire pair publishes the initialized state
when IRQ handling resumes. Open sets the gate before registering the
handler, so there is no old handler to drain. This closes the window in
which the IRQ handler could access the controller during restart.

Q: Does this also protect the bus error counter getter?

A: No. The getter can race with IRQ cache updates, RX/TX decrements and
restart's cache reset. Its runtime PM reference protects power, not the
cache. This race predates the patch. The IRQ gate adds no cache accesses
and does not widen the race, so this patch does not fix it.

Q: Can the first INT_MASK write after reset deassertion be lost?

A: No lost write was observed on RK3588 rev2.2. Across open, close and
idle restart callbacks, all 600 first reads of INT_MASK returned 0x3fff
after a write of 0x7fff. A readback flushes the write but does not
establish when reset completes. Reset already cleared INT_MASK before
this patch; restoring the mask earlier shortens the unmasked window.
These results do not rule out a lost write on other hardware, but give
no basis for adding a delay here.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-rockchip-canfd-restart-close-v9-0-6643f3825ba3%40qq.com
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
index caa71cf8e39a9..7e3f478422e0e 100644
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


