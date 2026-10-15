Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33417509F19;
	Thu, 15 Oct 2026 09:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792057564; cv=none; b=Odx9HSzt2t9z6tOdyYEDaJskdpFBeNe/MaRNGgbA/O5IbPoFLlKUXpSIShoIIruB0yQg3hTy5qUsDeP6w6C45XfW/nXzPBAy10reCHhaQWLjS+0+/EUOVad5mRCDHKz7YUrYr1PbQlfHS4samXQErEAB76eaOPFLFfZuxEVA8ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792057564; c=relaxed/simple;
	bh=/mn1FAMySoblw7BNJKxvIifUG3mFrbJRYX66CKqRe6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tpT6KnxuBGA96nBUgZ9C3NTXDtTm1Gn5Cm0noo7MzZf4Q8mBplYgGUtDF6yR01+HByi2ZmLqKRW0dODu87wmDF1g3g0NIJCZDju09zhtY8OsJeiLUgIRy8unEoKUWQ0y5+oedmNgwR9EzhjKPn++Ac8xG5yJ0eDYFPH1ugiXBnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sC/e+idA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sC/e+idA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3134C2BD01;
	Thu, 15 Oct 2026 09:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792057564;
	bh=/mn1FAMySoblw7BNJKxvIifUG3mFrbJRYX66CKqRe6s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sC/e+idARBf/1K0qJTFSNUKZt3g6i9yHdV4BVYkCcqYY6FqCMR93qsXFpYpDBmVPp
	 xesOI+CZyVR5sIeiVZ5v2iFnQEoZA8pTuRbJhOucswlKj/n0axZ+nsJypZ5QPEwbZs
	 QGGrWXoKKS+qFBx1hcYYNYa8/ynHkNzUYEUnnlMZCXOLKQCsjUo1RAJrdvYUVzDwu4
	 QuimVlBqkJoQIKh2PWhifkJvtpKIpru5eM8dTovQbqwpL32hxOZTdQeRG5YL5Vnicv
	 wQDVnm452rEr0IaUmcvrcra0n+04+zevNOowZ5uEajvviywX+AThVGxdqo5lmjXZRk
	 aLdtHkJGoeJCw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6297CC6B33;
	Thu, 15 Oct 2026 09:46:03 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 15 Oct 2026 17:45:04 +0800
Subject: [PATCH net v5 3/6] can: rockchip_canfd: cancel bus-off restart
 before closing the device
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-rockchip-canfd-restart-close-v5-3-ae77327037c9@qq.com>
References: <20261015-rockchip-canfd-restart-close-v5-0-ae77327037c9@qq.com>
In-Reply-To: <20261015-rockchip-canfd-restart-close-v5-0-ae77327037c9@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, kernel@pengutronix.de
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 stable@vger.kernel.org, Cunhao Lu <1579567540@qq.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792057562; l=6448;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=IbsG/cS8L/6o4aTMlb97O7JQVyc7lkKuTpqEDY4h4Dw=;
 b=BXBEzaJ1viyo+pQQzfnpBEwWEsAXTO9sbym79Y4F79za99X2XpDhkC3QQbu6YgWo2epmxFr/Z
 Av9DGauq6zGC0T/o7fA8dmsGvEJbv9TfzV2Barypt65EmHzQ+VvajEF
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com

From: Cunhao Lu <1579567540@qq.com>

The close path cancels restart_work in close_candev() only after freeing
the IRQ, disabling RX offload and stopping the controller. A concurrent
restart can re-enable the controller and interrupts after IRQ teardown,
or requeue timestamp work that accesses registers after runtime suspend
has disabled the controller clocks.

Call close_candev_cancel_restart_sync() at the start of ndo_stop(), while
the resources needed by a running restart are still available. Keep
close_candev() after IRQ teardown for final cancellation and echo cleanup.

During restart, mask the device's interrupts and drain active handlers
without disabling the shared IRQ line. Suspend handler access to the
controller until reinitialization is complete, and publish the initialized
state before resuming IRQ handling.

Drain timestamp work before reinitializing the timecounter, and initialize
the delayed work once at probe. Keep asynchronous cancellation in the
bus-off path. Also disable RX offload if request_irq() fails during open.

Fixes: ff60bfbaf67f ("can: rockchip_canfd: add driver for Rockchip CAN-FD controller")
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>

---
Changes in v3:
- Replace disable_irq()/enable_irq() with device interrupt masking,
  mask readback, an irq_suspended flag and synchronize_irq().
- Pair release/acquire accesses to publish reinitialized state before
  the IRQ handler resumes, without disabling other shared IRQ users.
- Initialize timestamp delayed work once at probe and synchronously
  cancel it before reinitializing the timestamp state during restart.
- Disable RX offload when request_irq() fails during open.
---
 drivers/net/can/rockchip/rockchip_canfd-core.c      | 20 ++++++++++++++++++++
 drivers/net/can/rockchip/rockchip_canfd-timestamp.c |  6 +++++-
 drivers/net/can/rockchip/rockchip_canfd.h           |  2 ++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 37c1c22c40c9f..4b3db07242395 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -20,6 +20,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/smp.h>
 #include <linux/string.h>
 
 #include "rockchip_canfd.h"
@@ -356,7 +357,18 @@ static int rkcanfd_set_mode(struct net_device *ndev,
 
 	switch (mode) {
 	case CAN_MODE_START:
+		rkcanfd_chip_interrupts_disable(priv);
+		/* Flush the interrupt mask write before suspending the handler. */
+		rkcanfd_read(priv, RKCANFD_REG_INT_MASK);
+		/* Keep shared IRQs from accessing the device during restart. */
+		WRITE_ONCE(priv->irq_suspended, true);
+		/* Wait for handlers that already passed the suspended check. */
+		synchronize_irq(ndev->irq);
+		rkcanfd_timestamp_stop_sync(priv);
+
 		rkcanfd_chip_start(priv);
+		/* Publish the initialized state before resuming IRQ handling. */
+		smp_store_release(&priv->irq_suspended, false);
 		rkcanfd_chip_interrupts_enable(priv);
 		netif_wake_queue(ndev);
 		break;
@@ -666,6 +678,10 @@ static irqreturn_t rkcanfd_irq(int irq, void *dev_id)
 	struct rkcanfd_priv *priv = dev_id;
 	u32 reg_int_unmasked, reg_int;
 
+	/* Pairs with the release after restart has initialized the device. */
+	if (smp_load_acquire(&priv->irq_suspended))
+		return IRQ_NONE;
+
 	reg_int_unmasked = rkcanfd_read(priv, RKCANFD_REG_INT);
 	reg_int = reg_int_unmasked & ~priv->reg_int_mask_default;
 
@@ -747,6 +763,7 @@ static int rkcanfd_open(struct net_device *ndev)
 	return 0;
 
 out_rkcanfd_chip_stop:
+	can_rx_offload_disable(&priv->offload);
 	rkcanfd_chip_stop_sync(priv, CAN_STATE_STOPPED);
 	pm_runtime_put(ndev->dev.parent);
 out_close_candev:
@@ -758,6 +775,7 @@ static int rkcanfd_stop(struct net_device *ndev)
 {
 	struct rkcanfd_priv *priv = netdev_priv(ndev);
 
+	close_candev_cancel_restart_sync(ndev);
 	netif_stop_queue(ndev);
 
 	rkcanfd_chip_interrupts_disable(priv);
@@ -934,6 +952,8 @@ static int rkcanfd_probe(struct platform_device *pdev)
 	if (err)
 		goto out_free_candev;
 
+	rkcanfd_timestamp_work_init(priv);
+
 	err = rkcanfd_register(priv);
 	if (err)
 		goto out_can_rx_offload_del;
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
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 95bea9bfd8a2f..e1debab54534e 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -480,6 +480,7 @@ struct rkcanfd_priv {
 
 	u32 reg_mode_default;
 	u32 reg_int_mask_default;
+	bool irq_suspended;
 	struct rkcanfd_devtype_data devtype_data;
 
 	struct cyclecounter cc;
@@ -551,6 +552,7 @@ int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv);
 
 void rkcanfd_skb_set_timestamp(const struct rkcanfd_priv *priv,
 			       struct sk_buff *skb, const u32 timestamp);
+void rkcanfd_timestamp_work_init(struct rkcanfd_priv *priv);
 void rkcanfd_timestamp_init(struct rkcanfd_priv *priv);
 void rkcanfd_timestamp_start(struct rkcanfd_priv *priv);
 void rkcanfd_timestamp_stop(struct rkcanfd_priv *priv);

-- 
2.34.1


