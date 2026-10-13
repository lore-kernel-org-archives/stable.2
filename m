Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30543C07A;
	Tue, 13 Oct 2026 03:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791861858; cv=none; b=iFo+2phHkGn98R5H/yM+fTH/77LqEPwmegBhDgNYoDGqCKCAWE7kjyJLxxZutATMWjxWniNM/dWn2lXFHWLV86oRpJ/wUXzRmMyyOnb6KrmTOgVQuFyNhk5bsTTwXIlU/YP9cIlEOnSgtJvKMNmxQ6Jwr6PQDTxR6HX2vvzhrdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791861858; c=relaxed/simple;
	bh=jE5FBck0iwVfKsvvwnPJh+4Fn2qOZpSmZ/uBxGgOK3w=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=b5AxHje8THzAhPgSt5Vfy57aWm6vNc/RMstbSGAtccmA8cDh8j3fRjxR8ky+4vDxR3I3Rkbinl47TESJy6+Fv6HIcfxsqPnlBED7wC9lsa0ZBl2Qx/oAXJSWNMpS5iF8VE6ZXlwy4RPsEvyrWwGqFp3i0KUNA7bXdBTtaLd+OLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ckXNWsAQ; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ckXNWsAQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791861852; bh=n5aSjpi38d97JoTIKAE9ofjyp7sKD4gBZolpt7WmoUk=;
	h=From:Date:Subject:To:Cc;
	b=ckXNWsAQFnZJGmmwry5r/3S6EMV3MfSylxwl7ff+BoBX+Go8owP0KEYXhxD+HzcRA
	 L+fDJrLfgpNDOw0eTy0iy/A+WIrY9aHVi1ncTEZk8RjEr4rkqrXE9pCeDUeUTlT8Eb
	 HHUIR/smYzm7U+kUmQy6pyXKMh5cFkj8JvwC1cdw=
Received: from ubuntu2204.localdomain ([2409:8d20:7f:35d:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 5AA184C4; Tue, 13 Oct 2026 11:22:42 +0800
X-QQ-mid: xmsmtpt1791861762takf3foip
Message-ID: <tencent_5802EE88434010229EDF7A53084D994C6106@qq.com>
X-QQ-XMAILINFO: MlsYLnHA0UVjWnp7hi0CZSt7AYwx3Dlpux5tMi53y2dxpTPQTxCoE7WziwLp/l
	 V9WsvrSu2jmFlr2nf/vrfvlmSOWV40/V1Rrx4/INqVH3CQOiTfzHUlJFxh+p7i6/iisSafKzXi8r
	 6y2LdHMQDvMPS9hN0ujcgVZolio/nkv2HcpQPc7fJpKR7Tq6V506QsoNdj5NXv5gU3TiCMDxjpuE
	 q74ONYXjm5qLjYrfKFAFLtnMKtVIRoeH5UtApQnoRO2Ky6prnDsU75kTJySU8eZK66IQKfzk7JfG
	 Yl5Gru/A61Sw6ni8SyHEK8tKDOu7gOenphyWJjvJgyFPlOZYByFsUk603I2yTDetxjlMWE5DlXHO
	 6XtfClD30Sm9PtN2So7rGf2rjIozhQdXQha9SaawaX8aie91AC+JXKN5afEmRh0IAyfcaUSQqnc9
	 vEHXCrK6uECPcYNrZADd3gJsbtlHORLRJeSz8Ry+sKIhp9btZ/M/8U8i38YfJYAd1tkns9JeYlFX
	 3jwmJB9A/+n2dP6Pww/UlniRdD89B2aLgOAI2jaCpRTYAMGW+xS339GHm8lX1rjMKykLi7jLvK6G
	 RXfWe6NObbXnqhjO5E3G+4IBo2mTJXvxL8PDar9BcmItjd/9v5iaDAIBMjNLvDgB615LPDEDKFOZ
	 Ts/2Nk8qd9fLs+5saJwqT//VQf8SGQpqfjv+TEreL93dcXAqgFExbu/aMNsYzg2aF1llwfaHo37W
	 onqV+q8e8W38IlFxgjCxyBB9Miw+DJIc2AmRyyTdQZalfC75HFt9IM1l3dbUYgUHmKZXk2DrumLD
	 HyeO5aHQqwjKZxhFqnya7NfyGhue6XhdPzWqlXGXhuue9XbDjBJ03L9Tp4gG6FNAeHkgKPNaKcog
	 kEn2G/EW/KsyDqmgzR+JkWtpY+tdwbSgy1ip+6PHbMKv6BIW9xYkt/C4Uq3YP97z6aSvmLqgqK9z
	 /88uB08Oly/aPF1ezaC483aolF6iJ4sofO4xaMU36Nhsz1O9NaiLMipOCYepT/d10L8KttsnHfmo
	 nhVSd9mB4H+S+EDdwAeDH8zW8J5NnoaTPS9OVpMwS90dhlqWR2fPfIYnfDQcCST6pTko38zpOt/6
	 8qP0WA5jDceBDRcpLPApCT9WK8MHDUE5xRfSdV1uBoOwTG3utYLmSCSs5iBHHp1dUwgwBoONW/Kh
	 nHDEY=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Cunhao Lu <1579567540@qq.com>
Date: Tue, 13 Oct 2026 11:22:37 +0800
Subject: [PATCH net] can: rockchip_canfd: stop bus-off restart before
 closing the device
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20261013-rockchip-canfd-restart-close-v1-1-72cac4f932cf@qq.com>
X-B4-Tracking: v=1; b=H4sIAPyjzWoC/yXMwQrCMAyA4VcZORtYpxP0VcRDm6YuKu1IOhHG3
 t2qx/8/fCsYq7DBuVtB+SUmJbdwuw5o8vnGKLE1DP1wdL3boxZ60CQzks8porJVrxXpWYyRQ+T
 xNB6SCwkaMSsnef/4C2SucP1PW8KdqX5h2LYPhSdx8oUAAAA=
X-Change-ID: 20261013-rockchip-canfd-restart-close-ebde5954f1bf
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 kernel@pengutronix.de, Heiko Stuebner <heiko@sntech.de>, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Cunhao Lu <1579567540@qq.com>
X-Mailer: b4 0.15.2

The close path cancels restart_work after freeing the IRQ and stopping
hardware. A queued bus-off restart can therefore enable the controller
and interrupts after teardown. It can also restart timestamp work before
runtime suspend.

Serialize restart with the close transition using a mutex. Mark the
device closing and mask its interrupts before synchronizing the IRQ.
Release the mutex before cancelling restart_work, so a queued restart
can observe the closing state without deadlocking.

Exclude the IRQ handler while reinitializing the hardware on restart.
Do not disable the shared IRQ line while waiting for work to finish.

Fixes: ff60bfbaf67f ("can: rockchip_canfd: add driver for Rockchip CAN-FD controller")
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
When automatic bus-off recovery is enabled, bringing the interface down
can race with a pending or running restart. The driver currently relies
on close_candev() to cancel restart_work, but calls it only after freeing
the IRQ, disabling RX offload and stopping the controller. A restart in
that interval can re-enable the controller and its interrupts after IRQ
teardown, and requeue timestamp work after it has been stopped. That work
can subsequently access registers after runtime suspend disables the
controller clocks.

Serialize the restart callback and the close transition with a mutex and
a closing flag. The close path marks the device as closing and masks its
interrupts, then synchronizes the IRQ before cancelling restart_work.
This drains any handler that could still schedule a restart. Cancellation
runs outside the mutex so that a restart waiting for the lock can observe
the closing flag and exit. IRQ teardown, RX offload shutdown and the final
hardware stop follow only after restart work has finished. The shared IRQ
line is disabled only around hardware reinitialization in the restart
callback, not while cancelling work in the close path.

The standalone fix was tested on a LubanCat-5IO running a PREEMPT_RT
kernel. The 1 Mbit/s CAN bus was connected to four CANopen motors
operating at 100 Hz and four sensors operating at 20 Hz.
A bitrate mismatch forced bus-off, with automatic restart set to 100 ms;
25 iterations brought the interface down at delays spanning immediate
close through 130 ms after bus-off. Every iteration reached bus-off and
scheduled recovery, with no crashes or kernel traces observed. Automatic
recovery was also checked with the interface left up, including a 1 s
restart delay. The reported build completed without warnings.
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 40 +++++++++++++++++++-------
 drivers/net/can/rockchip/rockchip_canfd.h      |  5 ++++
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 37c1c22c40c9..e38ddd143a3a 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -244,6 +244,8 @@ static void rkcanfd_chip_interrupts_enable(const struct rkcanfd_priv *priv)
 static void rkcanfd_chip_interrupts_disable(const struct rkcanfd_priv *priv)
 {
 	rkcanfd_write(priv, RKCANFD_REG_INT_MASK, RKCANFD_REG_INT_ALL);
+	/* Flush the mask before synchronizing a shared IRQ. */
+	rkcanfd_read(priv, RKCANFD_REG_INT_MASK);
 }
 
 static void rkcanfd_chip_fifo_setup(struct rkcanfd_priv *priv)
@@ -353,19 +355,27 @@ static int rkcanfd_set_mode(struct net_device *ndev,
 			    enum can_mode mode)
 {
 	struct rkcanfd_priv *priv = netdev_priv(ndev);
+	int err = 0;
 
-	switch (mode) {
-	case CAN_MODE_START:
-		rkcanfd_chip_start(priv);
-		rkcanfd_chip_interrupts_enable(priv);
-		netif_wake_queue(ndev);
-		break;
-
-	default:
+	if (mode != CAN_MODE_START)
 		return -EOPNOTSUPP;
+
+	mutex_lock(&priv->state_lock);
+	if (READ_ONCE(priv->closing)) {
+		err = -ENETDOWN;
+		goto out_unlock;
 	}
 
-	return 0;
+	disable_irq(ndev->irq);
+	rkcanfd_chip_start(priv);
+	rkcanfd_chip_interrupts_enable(priv);
+	enable_irq(ndev->irq);
+	netif_wake_queue(ndev);
+
+out_unlock:
+	mutex_unlock(&priv->state_lock);
+
+	return err;
 }
 
 static struct sk_buff *
@@ -666,6 +676,9 @@ static irqreturn_t rkcanfd_irq(int irq, void *dev_id)
 	struct rkcanfd_priv *priv = dev_id;
 	u32 reg_int_unmasked, reg_int;
 
+	if (READ_ONCE(priv->closing))
+		return IRQ_NONE;
+
 	reg_int_unmasked = rkcanfd_read(priv, RKCANFD_REG_INT);
 	reg_int = reg_int_unmasked & ~priv->reg_int_mask_default;
 
@@ -736,6 +749,7 @@ static int rkcanfd_open(struct net_device *ndev)
 	rkcanfd_chip_start(priv);
 	can_rx_offload_enable(&priv->offload);
 
+	WRITE_ONCE(priv->closing, false);
 	err = request_irq(ndev->irq, rkcanfd_irq, IRQF_SHARED, ndev->name, priv);
 	if (err)
 		goto out_rkcanfd_chip_stop;
@@ -758,9 +772,14 @@ static int rkcanfd_stop(struct net_device *ndev)
 {
 	struct rkcanfd_priv *priv = netdev_priv(ndev);
 
+	mutex_lock(&priv->state_lock);
+	WRITE_ONCE(priv->closing, true);
+	rkcanfd_chip_interrupts_disable(priv);
+	mutex_unlock(&priv->state_lock);
+	synchronize_irq(ndev->irq);
+	cancel_delayed_work_sync(&priv->can.restart_work);
 	netif_stop_queue(ndev);
 
-	rkcanfd_chip_interrupts_disable(priv);
 	free_irq(ndev->irq, priv);
 	can_rx_offload_disable(&priv->offload);
 	rkcanfd_chip_stop_sync(priv, CAN_STATE_STOPPED);
@@ -921,6 +940,7 @@ static int rkcanfd_probe(struct platform_device *pdev)
 	priv->can.do_set_mode = rkcanfd_set_mode;
 	priv->can.do_get_berr_counter = rkcanfd_get_berr_counter;
 	priv->ndev = ndev;
+	mutex_init(&priv->state_lock);
 
 	match = device_get_match_data(&pdev->dev);
 	if (match) {
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 95bea9bfd8a2..c81233142a74 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -12,6 +12,7 @@
 #include <linux/can/rx-offload.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/mutex.h>
 #include <linux/netdevice.h>
 #include <linux/reset.h>
 #include <linux/skbuff.h>
@@ -478,6 +479,10 @@ struct rkcanfd_priv {
 	unsigned int tx_head;
 	unsigned int tx_tail;
 
+	bool closing;
+	/* Serializes restart with the close transition. */
+	struct mutex state_lock;
+
 	u32 reg_mode_default;
 	u32 reg_int_mask_default;
 	struct rkcanfd_devtype_data devtype_data;

---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261013-rockchip-canfd-restart-close-ebde5954f1bf

Best regards,
--  
Cunhao Lu <1579567540@qq.com>

