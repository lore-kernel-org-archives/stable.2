Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3456518121;
	Wed, 14 Oct 2026 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984257; cv=none; b=kFicNO7ChJzcWaCUPjR8M/Fri2ThVovMT8ahvWmUpe3mSrAsRgGxVjZjXhVoVXc/VH3VQdAjyrf+TqN/YcZdTPq79OBH2YMdXbatA6iiNtZKcu//zW5jrI+JMl9kc/hW0cAOzN/L6FKFO7k/H9BynElOzIwLRU3B7BL9TKUGKLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984257; c=relaxed/simple;
	bh=7Y7PdKz6EY5ExxJR8yaSiHxXzEELTODbKg1w2cGzL2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lf+nKfWeRDu1jKDygbGAfxqoPmLyGnIVSUuEZ8Z/JLZwHr7UpNUtUeLhB+zLZqO80m4eY4xNBv2xlWWFHkWhktU2QdIQ/EoeeGPbUczrMS0kYXqtRQC3QRxSJ/UxgSd1r/B1YCqB5t6DLqws3YQTi8FzBBkpEJZxhNBLdONERJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqpu6uw+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqpu6uw+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7104FC2BCFF;
	Wed, 14 Oct 2026 13:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791984257;
	bh=7Y7PdKz6EY5ExxJR8yaSiHxXzEELTODbKg1w2cGzL2I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mqpu6uw+M6YygUI9mzGW814AJhFiOrxLqjSCIUEP7Nj9zkOQA4zHNd3KmcrWqTEwL
	 asYaHlJs177bF/Vd+v9x/zYp5bABOFg6zvlZBav1KtYaq9344mWHYjuxNqms1iZoMH
	 NPEb+eD2Mxw4x4RFr449IbTdkQ4ken1vk0twvGjqi0aZNYldO8f4E2Cezwlu1PAFcP
	 bx9hJQiaxCNNTJzblgqFXe34/9b85S3hjNGGQ9cb4zGtPXFqxc9NT64UdK7MhA+aLI
	 u+/dPBEpnYVqFF1IGIplB7MrJ2e3f8T3RwKExty1mJzR5AUgGRACCrf+e5MAp2LyYD
	 +59Jx3gDMVKpA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53077CC6B2A;
	Wed, 14 Oct 2026 13:24:17 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Wed, 14 Oct 2026 21:24:04 +0800
Subject: [PATCH net v3 2/5] can: dev: add
 close_candev_cancel_restart_sync()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-rockchip-canfd-restart-close-v3-2-f0eb41090242@qq.com>
References: <20261014-rockchip-canfd-restart-close-v3-0-f0eb41090242@qq.com>
In-Reply-To: <20261014-rockchip-canfd-restart-close-v3-0-f0eb41090242@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, kernel@pengutronix.de
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 stable@vger.kernel.org, Cunhao Lu <1579567540@qq.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791984254; l=2413;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=aG489DexWJ6o7nts419PazjO7IPQM9laJ1xaNGAvKlc=;
 b=wMxIqiuaXgUfaRB6l5pC20jB3TJL2dFd4Mg6qnUVuiq0gW3yjgWZlvU0rCAC7pljnO0Mkis2A
 Ip5VFf9WDAfADc8sRvaScDva5Poo8riROvNHYzR2rXiyfbmF4AfN4wM
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


