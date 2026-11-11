Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794377931;
	b=YvYuRUdHiLCLFmg2UXC49cKMi2saZ4wsYZnp0w3kbyCqxPjM4AkYftxD9fp3eZFKcQh9
	 OWPyrPai3Xrnh6xiW4ouBFXMTDNnn4zhFpVGHhAifXUB9EZCpVsCAFBpJyJsAmmcjhGmp
	 ggvg94uXl4TFQ28/KyeVaeCC4NUEYOOyC4NNmVFPkBfMyoVk8Zj4dFdZ1PsL9EJLz60bV
	 AmF4ftu+dfAbqk0CmGfpLZgKth1lVOCYEmX76gyHoHMsHiwIMAnfLzxmfKCBnSHdfraGo
	 Fq6ZhnR/0Q3Rse074JkYr1DA01rC9B3lh05EYqeNhhv17r61eSkzGBDiwTDermWTJlw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377931;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=x5X8EYURuKn/7X627usknV/yyXb+kYv1CRAi9eXfVxQ=;
	b=IpLe9LN2+cAltYgb07nJPuGv6CKAp1//OPNQROqkW9trTa7YvbgeF1afPLSQyChGmipJ
	 Nd0eWbWDKV9KszX3CqhMBQ4+XX4McXMATBxhPoDejZYBkfLTkMVpbud8eHdTSEYdImr1k
	 8c7VrpIwYsIMDJhy7qBNb6RTQkiYh1AMWFCYD7ngXh1TO6rCMvliVyQBFA6da3rIOEOLv
	 wbQuKw9SNwhgAf/0XgqMShj9J1AeIR3rhDIY/O3tLYVAEsNrcXrzFoaWlVNq7m4/XDaWJ
	 zaMsAcPIi9P2ptuylVxsD2L26IBRXZogedkyJtE5hbTtCxpuv+nLhhxyL0L8xJqyqVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WoJJjtSE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7284060A382C;
	Wed, 11 Nov 2026 06:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WoJJjtSE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794377931;
	b=SdgdNbZjB1lAnozICCWqN9fvF2ZtWQqZmRj29TuS4ycjnUsRdtqS/11dMQBZ6jd3QBNF
	 nDZfBj2uwmRFfGJ/5o0neOnf6nAKSBdm1xYROWkFC2LUOdu13NdpYMyekQUvFAptR0l2V
	 6+OWXnv6CLzBRxrX135Dh3z2sdRX37Ud0DEsltttOFpWOPKGWbsEUsUXix4NMARPE1bA6
	 PEbNZBlzWYkD5poHKO33fRAR6VEtfeDkli9sg8XLHcNmc4KtB7aa0VOGucux0B48d2Okz
	 cySUayIRe7lL1TBSc66u0DeGbSvlfg7lHtQ3Hrh2UzVKtdfwBh637wjFRW/VjkuBYlg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794377931;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=x5X8EYURuKn/7X627usknV/yyXb+kYv1CRAi9eXfVxQ=;
	b=IcEgVDoGpImmK9r+1P6AEE+Ol75ZnP5spIpf4lIxZlrCevnVEr9yfzviuuTqdkeJVnbr
	 NiTRMzdQ+m9A2zEoqutok0NBSY5ETKPesAwbmyJN+mAOAqyqwIsp9pfWHOImGpNPRgewY
	 HUNUsibdbzAo3l4iVFm8QBZw9Oul87H6DCQya/kDPt+ci1KDGagoloG1rLyYJ9xsCYH5E
	 1sW2yU8E/eZgRYUhi65we8oWc8ZKgwpCr9+C73lw57xqigdux5Im0sV4LgGgsduBqlqqQ
	 F4kFWStWx2CPRYLIp15CO1OjzxkJAiEXI68vtbA+nKKQLb1t59czPz3tM8S+wSSMBEg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 818441F00A09;
	Wed, 11 Nov 2026 06:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377931;
	bh=x5X8EYURuKn/7X627usknV/yyXb+kYv1CRAi9eXfVxQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=WoJJjtSEVG5501CZVecN4tyChc5cxBsDdZ2msOm4cnh+Ad8GzcwVWxA6KPaCSF5we
	 66nuInTn5nE3Nq11T5llTcew1mBM8W7hwxbmO8YVQMOwMpqmC7CkB34nDhQtMG4Q6g
	 hXI/1JuC7TI++A7xbyXBS2FVwzHl1Odq/4XgqxfsoExD9XeDGdMndCpRPAeBJ74fMH
	 t0kA2u8lg0jOU4BCLvgPy0jaHEI0AByb37PZJdxF/vE+xj5kulugh9nuq6TmOksSUJ
	 SRAu9y44fTGDtJc3vzrvQeyyMofL6H4axDFpGqC5qlTDI7tfQVWoTRuIE9WFwOBgBC
	 PYUtivRJadtEg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0D8B248E0A;
	Wed, 11 Nov 2026 06:18:47 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Wed, 11 Nov 2026 14:17:58 +0800
Subject: [PATCH net v9 04/10] can: dev: check netif_running() before
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
Message-Id: <20261111-rockchip-canfd-restart-close-v9-4-6643f3825ba3@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794377925; l=5740;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=lSfO05WxZKbUGYfufnG16jV7I5aalY2A58BbhwHwTvU=;
 b=Ipawlslf9+rOi+tI+kJO/yW+1uVe8LxR4ymweqd69/PVhgSk2P8O3c92UGEfp5k+njVMCFm96
 nW5xOOb/nY8BAhFZgdyH6TvBkBspfjJUvWzJ5cB6u40LEdp3ZiqLcfJ
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
index 51bc70748f753..9debef8702d5f 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -1302,7 +1302,8 @@ More info to the above output:
 	Automatic restart delay time. If set to a non-zero value, a
 	restart of the CAN controller will be triggered automatically
 	in case of a bus-off condition after the specified delay time
-	in milliseconds. By default it's off.
+	in milliseconds. Recovery is skipped if the interface is found
+	to be down. By default it's off.
 
 "bitrate 125000 sample-point 0.875"
 	Shows the real bit-rate in bits/sec and the sample-point in the
@@ -1376,9 +1377,14 @@ before you can start it to avoid error-prone default settings::
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


