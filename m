Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793957855;
	b=GRDncYxPHOt3XSIPbbW0rzOKk+zSnQOwekbFDb4B1syQuCgYp79YuBVmMCr2+1ePvVfT
	 6Kr1rGcBJO1xarDhYBBIYJzxAZceqU2tQxKthseAqmKUpfo7ta/whpKZyH+b0GNOr2eoE
	 PHVf15sdQkKjROVJmDG0vLKQU4NseSR8ZdUlic2Q02aZ5KcJzhHqaobYxezjgg8ocbZtX
	 W4COAXzn1x9aaMIP5mALABaX+sfx2IHDZ57rvaBlRGIyCaRM/HRkxxSyhE+pKs8uXQh+T
	 zc3S0ykOHQpJfDI4zaD+UZfdTLuloYBKr6sJOtcfu1FC2Pk7AG2EKwRBz2x18L+P37Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957855;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wmOVggW74oliLvC30oz+jR1YV9r4ay6p2Hc/0ykJl7s=;
	b=DKFUHHBL30ZMsdZQuCLLrgMUzCONbaGZOm+bfmfM01gQQPatGKM4356k//NEYlMBZ2w4
	 I3tMAywEKn20+wA/7J9Dy+cpYYRChOEvZxL3ymk94FrY50vdbA2WGaiNw14DORQdG9Qx/
	 8zABk8Mx6zy6yZGAe5ci5t03x7m/D70AxIon+3fBJKi/vuXwNhOJDJP9fgKGcmjU9RsZ5
	 4CJkdkr/sv4RxfDZvWTq85BrLzA1/ACuOU7GOzzrBUjdeDMO5+5iaMAGMif8eZ7QA9FiM
	 r0xYwkTvy78X8l8tXwoCsbLPUWgJG52flqe25F8syO3r3oblD0Aw1UW0rjOLtOidbCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BR/QJJwJ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A201606D836;
	Fri,  6 Nov 2026 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BR/QJJwJ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793957855;
	b=hi/ti+LH3E+qbp6dheAEXqU8gtCsbjIquj2ME4PI3oleY7ZrXEIFfusFQ3VecN4CaNwU
	 xjjfqm3uFGFdXDNakHtnXajafZwTA//tybvyfd+FWCVkxtE09PQIwHnLCQ5R+JajWV7v2
	 evnOL4nVfYYwruJiuYVnKYuxa7AVmwiAZQOlu9e2rffhV6N9sbe5kyzRBSV9T7jZRtOSo
	 kINhkdcrEyrT62rOyoa2WBMNRMA6qMyAmJZQBrhSfqKB6i185pYwx3Lh14WotTGugIzIe
	 IUL3qiVBJGGEJDlq9D75sMMwLrFpLIoILtHvpWThFWTrujEHdOvTQcK/oikENZeZRnw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793957855;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wmOVggW74oliLvC30oz+jR1YV9r4ay6p2Hc/0ykJl7s=;
	b=HrJEvu+BgoJoek555tWk/P/MZWKzUTtTcETKk2AHSrj3dszrj1sTFJwYx/gNQeZdnLNx
	 fHCHhHpHWVGq+sy+AlmKfgbOg9J/v5V8Yr7temhz2o4OK4VDPxsR+Txlu/J/yJP1jxYC1
	 fHD9QEBSYD6vQqZc/no/yQHxu7HtCMbzknCx3rykU16yahbhv4aLlIceQC8vT9/JG7Iz9
	 873FNMhZXaV9cCnO/2cKGqVo7Poz/xPWrzlRAVjUY5zU1HD81wL1xHb6IEd7Dv2WyV9G2
	 xiKEbiGAOEUrp3zJcRdPPWQI6oQeUFgdIlGoDFD7OgIJHI77sJrdt/OoM7Vpv3va/YA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id F2EA91F00935;
	Fri,  6 Nov 2026 09:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793957855;
	bh=wmOVggW74oliLvC30oz+jR1YV9r4ay6p2Hc/0ykJl7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BR/QJJwJz9cI0pcIxEiHZrdDhxIttafx219xjhExwNN+j1DcOQXybL4CtBJHByHwl
	 jw0mY9+1LpvjRhtxPK3he19PIcVXMWMb3e8Hgu6wJH4sMAEqQsvH+wh4NjMqPj4eGm
	 BP++yt0dgcnGCu/KSnuQP0r0FY+1DtZLTx4yA/Gnw8DL9tlV98H3pdlEvyUCeXF4E+
	 8uYWy/1GVtim8H/dQArz4VNTDhHb42/dhMpkbtdA1Z2gohtKQYWpOGRuIpd9T9PaDR
	 pWWsbFD79VteAVeWqWEHPPGBGkVd/iGaJYPRC0hHAYhTAykGCzO5g1tUI+xdHAMBk1
	 /bf+Yn4IH+GpA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 57D1A45CA2;
	Fri,  6 Nov 2026 09:37:33 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Fri, 06 Nov 2026 17:37:20 +0800
Subject: [PATCH net v7 1/7] can: dev: check netif_running() before bus-off
 recovery
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
Message-Id: <20261106-rockchip-canfd-restart-close-v7-1-accdb11bc845@qq.com>
References: <20261106-rockchip-canfd-restart-close-v7-0-accdb11bc845@qq.com>
In-Reply-To: <20261106-rockchip-canfd-restart-close-v7-0-accdb11bc845@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, kernel@pengutronix.de, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: Cunhao Lu <1579567540@qq.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793957851; l=5740;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=k2fsudDP/7Iskth15EZj3YKv5SVEzCbeAxaC/fD1nEI=;
 b=oOH4cuUqqoEvOY+siJ+XLiZml2kHSzsPl/RsHNKh5qoeGNl3an4GYhwhP6kCq7jUZJbXpo2B7
 0uIKybEVyGoBV6GpF3v50P2iBDkhFXuuC4W7SNMB80mmEwLUY0EhwcL
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

The networking core clears __LINK_STATE_START before calling ndo_stop(),
but CAN bus-off recovery neither checks this state before queuing work
nor before calling the driver's restart callback. Recovery can therefore
be queued or started after the interface has begun closing, potentially
re-enabling hardware while the driver is tearing it down.

Check netif_running() in can_restart() before flushing echo skbs, sending
the restart notification or enabling the carrier. Keep the existing
unsupported-operation check first. In can_bus_off(), schedule recovery
only when the check observes the interface running, and make the log
message reflect that decision. Keep reporting bus-off and disabling the
carrier.

These checks do not wait for recovery that has already passed the check,
nor serialize the check with work submission. Drivers still need to
cancel restart work before tearing down resources and quiesce its
producers before their final cleanup.

Fixes: 39549eef3587 ("can: CAN Network device driver and Netlink interface")
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>

---
Changes in v7:
- Clarify the running checks' limits and configure restart-ms while down.

Changes in v6:
- Update the can_bus_off() comment and document the running-interface
  requirement for automatic recovery.

---

Q: Do the running checks serialize recovery with device close?

A: No. With automatic recovery enabled, a worker can pass the check
before close clears the running bit. Drivers such as FlexCAN still
cancel it after hardware teardown, so their restart callback can run
after shutdown. The Rockchip patches in this series wait for an active
restart before teardown and cancel again after draining the IRQ.
Other drivers need separate lifetime fixes; these checks only reject
recovery that observes down.

Q: Can HI3110 queue restart work after close and outlive the device?

A: Yes. With restart-ms nonzero, its IRQ thread can sample running
before close, then queue work after close_candev() returns. The later
free_irq() drains the producer but does not cancel the queued core
work. A quick reopen can execute stale recovery; removal can leave
work referring to a freed can_priv. The driver's private workqueue
does not own this work. A separate fix must quiesce producers before
final cancellation and protect teardown from an active restart. The
running checks narrow this window but cannot protect freed memory.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261017-rockchip-canfd-restart-close-v6-0-ed605feb4b6e%40qq.com
---
 Documentation/networking/can.rst | 10 ++++++++--
 drivers/net/can/dev/dev.c        | 13 ++++++++++---
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index 536ff411da1d1..41ba5cffdf108 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -1298,7 +1298,8 @@ More info to the above output:
 	Automatic restart delay time. If set to a non-zero value, a
 	restart of the CAN controller will be triggered automatically
 	in case of a bus-off condition after the specified delay time
-	in milliseconds. By default it's off.
+	in milliseconds. Recovery is skipped if the interface is found
+	to be down. By default it's off.
 
 "bitrate 125000 sample-point 0.875"
 	Shows the real bit-rate in bits/sec and the sample-point in the
@@ -1372,9 +1373,14 @@ before you can start it to avoid error-prone default settings::
 A device may enter the "bus-off" state if too many errors occurred on
 the CAN bus. Then no more messages are received or sent. An automatic
 bus-off recovery can be enabled by setting the "restart-ms" to a
-non-zero value, e.g.::
+non-zero value while the interface is down, e.g.::
 
+    $ ip link set canX down
     $ ip link set canX type can restart-ms 100
+    $ ip link set canX up
+
+Before scheduling or starting recovery, the kernel checks whether the
+interface is running and skips recovery if it is down.
 
 Alternatively, the application may realize the "bus-off" condition
 by monitoring CAN error message frames and do a restart when
diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 769745e22a3c7..a893a49a33813 100644
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
 
@@ -259,13 +262,17 @@ int can_restart_now(struct net_device *dev)
  *
  * This functions should be called when the device goes bus-off to
  * tell the netif layer that no more packets can be sent or received.
- * If enabled, a timer is started to trigger bus-off recovery.
+ * If automatic recovery is enabled, schedule delayed work unless the
+ * running check observes the interface down. Drivers must still synchronize
+ * recovery with device close.
  */
 void can_bus_off(struct net_device *dev)
 {
 	struct can_priv *priv = netdev_priv(dev);
+	bool restart;
 
-	if (priv->restart_ms)
+	restart = priv->restart_ms && netif_running(dev);
+	if (restart)
 		netdev_info(dev, "bus-off, scheduling restart in %d ms\n",
 			    priv->restart_ms);
 	else
@@ -273,7 +280,7 @@ void can_bus_off(struct net_device *dev)
 
 	netif_carrier_off(dev);
 
-	if (priv->restart_ms)
+	if (restart)
 		schedule_delayed_work(&priv->restart_work,
 				      msecs_to_jiffies(priv->restart_ms));
 }

-- 
2.34.1


