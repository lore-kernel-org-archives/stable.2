Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582E3381B1D;
	Thu, 15 Oct 2026 05:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792042754; cv=none; b=dzP+dYM8isWpfgwoQM2JPc3XG+8nJXuvYstBkhZ8ElIG7bCAoTLAUsqttNgnOLj8FlEw7uN42xgMRgmTSJHyA4tIhG2pMYrS9YWM0T1dutfn0UFO0KlnawIB9k5F8HSZDJsM0kPBxa0YSsDZpA/TVwlEgHBAtRq5r+tvfVeDoWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792042754; c=relaxed/simple;
	bh=7Y7PdKz6EY5ExxJR8yaSiHxXzEELTODbKg1w2cGzL2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QCOMiRvRn1QKndHpVcoVkqxSRTJTC8a+QfKqCqQO4BKTJXVxspnRPiAS8kvv5XOIWGq88JM57PDHvlJft1mXj3SEcizx1vdTf4aG1LAUDlorhMCPbxQQO9z5fX4nho3inO6+ag0rXPtUVpnbYnpKIYi3xfCKpkkwJpZ65FZhAt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhrviLge; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhrviLge"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF80BC2BCFF;
	Thu, 15 Oct 2026 05:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792042754;
	bh=7Y7PdKz6EY5ExxJR8yaSiHxXzEELTODbKg1w2cGzL2I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XhrviLgeZHW1YMjzIk6vo7SazOk/NtonujGC/sMaGXio6X9kmmA0aHiqm+QU5TDH/
	 W5ZdO/e6bsrOaj/ICDz7ilpeAMVVtufGIjEn4o1ZYfe7nzR+xumrGj3mfpGVB6tWQI
	 rT9ZH57aiV3hJcMgPIrOMZvpLpSdsa8PCyyBJFOHZWZb3heE1EFcFmTbkvfQy7Lr+b
	 m5w2n58oHXFR87EofvPpj2qWtJjSk6wS6RJk1ZgQ5fTYxy7npzYwGvQIdYr8AMpfWt
	 TrLW8U/0cREmM1KlZcmp6exBzk5d/hlzrUBL8PQ3tpmRDvNHbUS3fbCWiTuI4uGUON
	 vSAd3jZYiAz2Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0836CC6B38;
	Thu, 15 Oct 2026 05:39:13 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 15 Oct 2026 13:38:56 +0800
Subject: [PATCH net v4 2/6] can: dev: add
 close_candev_cancel_restart_sync()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-rockchip-canfd-restart-close-v4-2-ad149ff79450@qq.com>
References: <20261015-rockchip-canfd-restart-close-v4-0-ad149ff79450@qq.com>
In-Reply-To: <20261015-rockchip-canfd-restart-close-v4-0-ad149ff79450@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, kernel@pengutronix.de
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 stable@vger.kernel.org, Cunhao Lu <1579567540@qq.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792042751; l=2413;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=aG489DexWJ6o7nts419PazjO7IPQM9laJ1xaNGAvKlc=;
 b=jpKUQeZu2CVzq8TT6MUPNlPeDqTzoyuwm9qVw56Y3cDD4eJrOhgl/o2cc5WXLHntt+fol7XM3
 jjKU2+uBksuCk9qbgStQsDQvyKRHegvFZf20gCSNiKbQnS25DLs1vj1
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com

From: Cunhao Lu <1579567540@qq.com>

Drivers may need to wait for bus-off recovery before tearing down the
IRQ and hardware resources used by their restart callback. Calling
close_candev() at that point also flushes echo skbs, which belongs after
the driver has quiesced the users of those buffers.

Add close_candev_cancel_restart_sync() in linux/can/dev.h so drivers can
cancel the core restart work separately, without accessing can_priv's
work item directly. The helper only cancels restart work; callers must
still stop its producers and call close_candev() for the final cleanup.

Use the helper in close_candev(), preserving its existing cancellation
and echo cleanup order.

Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 drivers/net/can/dev/dev.c |  4 +---
 include/linux/can/dev.h   | 12 ++++++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 92492c503446e..52e8c4854ae0d 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -534,9 +534,7 @@ EXPORT_SYMBOL_GPL(of_can_transceiver);
  */
 void close_candev(struct net_device *dev)
 {
-	struct can_priv *priv = netdev_priv(dev);
-
-	cancel_delayed_work_sync(&priv->restart_work);
+	close_candev_cancel_restart_sync(dev);
 	can_flush_echo_skb(dev);
 }
 EXPORT_SYMBOL_GPL(close_candev);
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 6d0710d6f571d..a277d12332f15 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -22,6 +22,7 @@
 #include <linux/can/skb.h>
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
+#include <linux/workqueue.h>
 
 /*
  * CAN mode
@@ -115,6 +116,17 @@ struct can_priv *safe_candev_priv(struct net_device *dev);
 
 int open_candev(struct net_device *dev);
 void close_candev(struct net_device *dev);
+
+/* Cancel bus-off restart before tearing down resources used by the restart
+ * callback. The driver must still call close_candev() for the final cleanup.
+ */
+static inline void close_candev_cancel_restart_sync(struct net_device *dev)
+{
+	struct can_priv *priv = netdev_priv(dev);
+
+	cancel_delayed_work_sync(&priv->restart_work);
+}
+
 void can_set_default_mtu(struct net_device *dev);
 void can_set_cap_info(struct net_device *dev);
 int __must_check can_set_static_ctrlmode(struct net_device *dev,

-- 
2.34.1


