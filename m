Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795077596;
	b=N5tbIwx8EL6mIGPpZBbHPrrxpGz7I4McxqypP4U2XIn87lkqpWtIxjTc9PP9rURScS9I
	 kug5JXkm5DCqNMMwkOQ11HO/stHL5ijo0NkRWhJy64Z96/9EIejXOzwmpcXre9FfQhIGK
	 ixzzI14PJ7RSsFzmqxR9Yk+5++/DA6Atin1sDoOs8ScnXf1lj5Zs1I1l2qcyIn2cX84vn
	 BcM7hZMQVlBQDeF0hXAo6fANrC1W9IGfWczqmPTML38mGufxV/RblJALk8jZ+KlkOoEsL
	 3JDZEz6HfUNdDCuLx6DDSMRI6WT9Bm2pL3rSCs4kIJJ+bAeOuBjq1CcYZNmxBX8Zf7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795077596;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aZMftFDuzPDxrelr5RS5F4HiQ0xG8bnhuyKm8opOJxs=;
	b=Z0/t/0vuSDre36tg5Esb0n6/JY1R8uuiiQggSah4Scl01PQSh2HpFuLJ96JXyBA5Ys55
	 X917dciI76LAsnIFk7GJktINgyXouNw2uPLrZREqlNDrZA8O7WV78Qq3j6haosI8B1Dji
	 Xyfx40hUr/rXrl9axZ1EJK6wfxe3GXSX9q8yXDSHBr378ZSEwin1YdVXvmiMx8HKe8ggG
	 YCbTbEV+vPec5rQsShxfb15oOp0QzyGaJ+9K5zZp4rqORODtJLevM4SOLtH0LSQwdp2Pe
	 B5Bn/QNxscVt4P8h77Lv2WJHM1+caI4E3UTckHYBLZ/pxGjZLQNgr4CDTOHddLF5iDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d3NPz4lQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CD460A5BDF;
	Thu, 19 Nov 2026 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d3NPz4lQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795077595;
	b=W6/PObqX7208sTBOcg1+TWyNcjNIZiYZgG9kSNWVXlKUHCL5TWSprEpn2guTmaxM/FeO
	 dW05Sm9h5131BPDV1TBaMJPUHUSTpd4HQERzyWKiV7zlsMm5JsoQDXTyrEu0dL9AYG+Z0
	 BxmAF/6SSZUnGnf3/3ZDf4780DrhLm9RG1a10JKR6fPbLG8sRnP8f/mGgd1CJ9BtaJG4I
	 WWu49ea7msx9FErcIRmo7wEy04657i42LVmkiPn6Fwm3pqzdIRvC+X3Tfmo94EWEhM+8k
	 bNADqtjR3uTtusFCnZ1hfvL1VRwKO+uzUjQME0WpvH2mpmIAsLMBekuqVtyfqkz9OxA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795077595;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aZMftFDuzPDxrelr5RS5F4HiQ0xG8bnhuyKm8opOJxs=;
	b=V0l/IESyi40Ciz3yWpkODSnZWpolX6f6h7Vf6DJWFg2GVbCVXrnezgzjLeyXO1BIBo9Q
	 h+v0lDlobOnkjMP2QzsgvRrurbf2ck3gZTjSguKYBzk9o18I88vC4HsVYUqW+CQGBsFYA
	 kSSVScFS86+K3l8qz8Dgvwuw6zC1JaV2dQN3HxG+vrblnpQ79zjwIJ/svGh0M0bvdiL63
	 5i0AMywWBZnnV6C5bME/BjvJQogjNzVOrAIVQhvsu4rLdnlmEUXkp/Mv0EZtpV3tZStTL
	 VMzg0WgOAB2H1v4a3ivxBoZFbzNuHbeDX2+HWOY2PVKFL9cEP/C82JQ3iPENrwr//yQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0E7321F000D1;
	Thu, 19 Nov 2026 08:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795077595;
	bh=aZMftFDuzPDxrelr5RS5F4HiQ0xG8bnhuyKm8opOJxs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=d3NPz4lQjdwjzJuGX5JzDqbvaPLRfnCjo+nIjsremJF5I28kWsizSa7uWJO8I/4pz
	 e/yx3ulID+Rr1fC4Ccocp5buY+Rs/jeRSukR/M7AzOiZMVzuORrGuN+A86EEz0YTb5
	 J2VU0t+wH8uN5bMvQEhM1i8am5PpwBg3xTvtuoAxnajsyVoqa1D4puq6sXDod7j6wA
	 Yqs0i5T86YJh1S9myqJXavgHzGxUb0Y2QT4rN8tuCnacG0fY99T3Lt8xzUrN2QP7uA
	 ByqpmPMsNxFta+f0cfsinbjLmyopVxv+RIZDeDQL35Z8rEkq7LFbOlVIHAuVFCw1Hk
	 FNzRjLdPJHRGA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 88C524B1AF;
	Thu, 19 Nov 2026 08:39:49 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 19 Nov 2026 16:39:44 +0800
Subject: [PATCH net v10 03/10] can: dev: check netif_running() before
 bus-off recovery
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
Message-Id: <20261119-rockchip-canfd-restart-close-v10-3-df23913aa33a@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795077587; l=6091;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=DnoB8zc7Is7z8ZQl3mTaQJmTJBOXYb3Oll83YYKwpco=;
 b=Q6sI11+/G85CX2GlScT1mPE/VCe4rwglRCRbKwg3SRVIreGD8xrIMIJd/kPbKGFuuM35DNVNR
 GGxUe3Ld746BPm3eI4lWXz5TMp1QpSOHTUIcM3gQp+Og7AT132bfL3f
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

The networking core clears __LINK_STATE_START before calling ndo_stop(),
but the CAN core can still schedule or start bus-off recovery after the
interface is down.

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
Changes in v10:
- Limit the recovery documentation to CAN core software recovery and
  checks that observe the interface down; retain driver shutdown
  synchronization requirements.

Changes in v7:
- Clarify the running checks' limits and configure restart-ms while down.

Changes in v6:
- Update the can_bus_off() comment and document the running-interface
  requirement for automatic recovery.

---

Q: Do the running checks serialize recovery with device close?

A: No. A worker can pass the check before close clears the running bit.
FlexCAN cancels restart work after stopping hardware and removing RX
offload, so that worker can restart after shutdown. This race predates
the patch, and the running checks do not widen it. FlexCAN must drain
active restart work before tearing down those resources. That driver fix
is not part of this patch.

Q: Can HI3110 queue restart work after close and outlive the device?

A: Yes. With restart-ms enabled, its IRQ thread can decide to schedule
before close, then enqueue after close_candev() returns. free_irq() drains
the producer but leaves that core work queued. A quick reopen permits
stale recovery and echo cleanup; removal can leave work referring to
freed private data. The driver's private workqueue does not own the core
work. These races predate the patch, and the running checks do not widen
them. HI3110 must stop producers before final cancellation and drain
both core recovery and work queued by its callback before teardown.
That driver fix is not part of this patch.

Q: Why not replace cancellation with disable/enable_delayed_work() here?

A: Disabling work can reject late submissions, but doing it at the end
of ndo_stop() still lets an already running callback overlap teardown.
A core-wide conversion would need to balance disable and enable across
initialization, open, failed open and close. Rockchip instead cancels
restart_work before teardown and again after free_irq(). The restart
races in FlexCAN and HI3110 predate this patch, and the netif_running()
checks do not widen them. Fixes for those drivers are outside this series.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261017-rockchip-canfd-restart-close-v6-0-ed605feb4b6e%40qq.com
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-rockchip-canfd-restart-close-v9-0-6643f3825ba3%40qq.com
---
 Documentation/networking/can.rst |  9 ++++++++-
 drivers/net/can/dev/dev.c        | 13 ++++++++++---
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index 51bc70748f753..f44b9c96848de 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -1376,9 +1376,16 @@ before you can start it to avoid error-prone default settings::
 A device may enter the "bus-off" state if too many errors occurred on
 the CAN bus. Then no more messages are received or sent. An automatic
 bus-off recovery can be enabled by setting the "restart-ms" to a
-non-zero value, e.g.::
+non-zero value while the interface is down, e.g.::
 
+    $ ip link set canX down
     $ ip link set canX type can restart-ms 100
+    $ ip link set canX up
+
+The CAN core checks the interface before queuing a restart and again
+before starting it. If it finds the interface down, it skips that step.
+Drivers must still synchronize recovery with shutdown. Controller-managed
+recovery bypasses these checks.
 
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


