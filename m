Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB4E3A1A35;
	Sat, 17 Oct 2026 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792248656; cv=none; b=ULR2HnLpOhnP8GSlrqLju7B4f2zC6LIB4XxeeZ9BD62delNVHo1QxdBdetKPic3cbSimj6liUcRyidlQ0X/p367MzQXce5ul9Qj9cwa4oUVw6jFV6AzD8/v59WEGFXFl/YTCZ2GYYpgQsci1nGgdIKUayive/28kpOOYJYSb1tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792248656; c=relaxed/simple;
	bh=HpjYOLfBJm5ttjl2VKp8Qd+WjxxgiMjYtLa1agXHI3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=asyK+UVKa6wcBp3veWmvQilQljfPYoQmeRGkal3eD/oLQr1KgAgcfsIASo4q0PvB6M41BxcYlSnMTKYPcA+zKzF76xJzxjIj/OYxemeoW3H/cmznA3pTlnrrT+7rV0dm/a5984incWcEKa/O7PRA2/roJyzGSfDurGgxMaIE1CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeIzBhmC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeIzBhmC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DE63C2BCFD;
	Sat, 17 Oct 2026 14:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792248656;
	bh=HpjYOLfBJm5ttjl2VKp8Qd+WjxxgiMjYtLa1agXHI3U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WeIzBhmC8gt9sw0LCMH2t6/sakhJ+hIRsWK+31oslbEfei01bj0rqTbyuJ+Kcg4Yz
	 +KqgLJvy/Mvmgc028XSsXKgI7diEAnY34eudvHeaECz0jOEArQt67bUVgm2iB3HKEU
	 Ab2pVJvy1WdD+fTqN8tr31TytzVP0lGglLWf12+II7j+jMu/mnUc5j66fg9HH9edwT
	 SufkhzFJuaZC4fVbgdu6h17Rpt7bb99ANMGeFAAvKyWhuF0YSvubTpCmUYWtZrxTVw
	 GO+ptfoUyTC8ZdemZW7hlHFlF4P7CK9Da+TQW0sLAm4tnpfPUGQJwRu+oNwrGel7bA
	 YAMJpX5y33uDA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15B7CCF2C1;
	Sat, 17 Oct 2026 14:50:55 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Sat, 17 Oct 2026 22:50:51 +0800
Subject: [PATCH net v6 1/6] can: dev: prevent bus-off recovery when the
 interface is not running
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-rockchip-canfd-restart-close-v6-1-ed605feb4b6e@qq.com>
References: <20261017-rockchip-canfd-restart-close-v6-0-ed605feb4b6e@qq.com>
In-Reply-To: <20261017-rockchip-canfd-restart-close-v6-0-ed605feb4b6e@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, kernel@pengutronix.de, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, stable@vger.kernel.org, 
 Cunhao Lu <1579567540@qq.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792248654; l=3984;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=g1Lt1jcKFwF1Vjymzk/CqbM4Jz0xSuU4KCs88UQRpAk=;
 b=/fF4/xeJUnIWzANKza1S3FgMd5nX/SnOpmAQl5M2yU02k2VzrFPe70CFxgfVUZs5tAyjgKhdD
 Ize2Ycj1rkaASV/xSlc1WPJIsUXe6UkEXJ2QytF/fQHliljzYwPGHN+
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com

From: Cunhao Lu <1579567540@qq.com>

The networking core clears __LINK_STATE_START before calling ndo_stop(),
but CAN bus-off recovery neither checks this state before queuing work
nor before calling the driver's restart callback. Recovery can therefore
be queued or started after the interface has begun closing, potentially
re-enabling hardware while the driver is tearing it down.

Check netif_running() in can_restart() before flushing echo skbs, sending
the restart notification or enabling the carrier. Keep the existing
unsupported-operation check first. In can_bus_off(), only schedule
recovery for a running interface and make the log message reflect that
decision. Keep reporting bus-off and disabling the carrier.

These checks do not wait for recovery that has already passed the check,
nor serialize the check with work submission. Drivers still need to
cancel restart work before tearing down resources and quiesce its
producers before their final cleanup.

Fixes: 39549eef3587 ("can: CAN Network device driver and Netlink interface")
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>

---
Changes in v6:
- Update the can_bus_off() comment and document the running-interface
  requirement for automatic recovery.
---
 Documentation/networking/can.rst |  6 ++++--
 drivers/net/can/dev/dev.c        | 11 ++++++++---
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index 536ff411da1d1..861397e4ce906 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -1298,7 +1298,8 @@ More info to the above output:
 	Automatic restart delay time. If set to a non-zero value, a
 	restart of the CAN controller will be triggered automatically
 	in case of a bus-off condition after the specified delay time
-	in milliseconds. By default it's off.
+	in milliseconds, provided the interface is running. By default
+	it's off.
 
 "bitrate 125000 sample-point 0.875"
 	Shows the real bit-rate in bits/sec and the sample-point in the
@@ -1372,7 +1373,8 @@ before you can start it to avoid error-prone default settings::
 A device may enter the "bus-off" state if too many errors occurred on
 the CAN bus. Then no more messages are received or sent. An automatic
 bus-off recovery can be enabled by setting the "restart-ms" to a
-non-zero value, e.g.::
+non-zero value. Recovery is only scheduled and started while the
+interface is running, e.g.::
 
     $ ip link set canX type can restart-ms 100
 
diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 769745e22a3c7..d5cb22db2a346 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -198,6 +198,9 @@ static int can_restart(struct net_device *dev)
 	if (!priv->do_set_mode)
 		return -EOPNOTSUPP;
 
+	if (!netif_running(dev))
+		return -ENETDOWN;
+
 	if (netif_carrier_ok(dev))
 		netdev_err(dev, "Attempt to restart for bus-off recovery, but carrier is OK?\n");
 
@@ -259,13 +262,15 @@ int can_restart_now(struct net_device *dev)
  *
  * This functions should be called when the device goes bus-off to
  * tell the netif layer that no more packets can be sent or received.
- * If enabled, a timer is started to trigger bus-off recovery.
+ * If automatic recovery is enabled and the interface is running,
+ * delayed work is scheduled to trigger bus-off recovery.
  */
 void can_bus_off(struct net_device *dev)
 {
 	struct can_priv *priv = netdev_priv(dev);
+	const bool restart = priv->restart_ms && netif_running(dev);
 
-	if (priv->restart_ms)
+	if (restart)
 		netdev_info(dev, "bus-off, scheduling restart in %d ms\n",
 			    priv->restart_ms);
 	else
@@ -273,7 +278,7 @@ void can_bus_off(struct net_device *dev)
 
 	netif_carrier_off(dev);
 
-	if (priv->restart_ms)
+	if (restart)
 		schedule_delayed_work(&priv->restart_work,
 				      msecs_to_jiffies(priv->restart_ms));
 }

-- 
2.34.1


