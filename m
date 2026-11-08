Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794137683;
	b=SvZ9jUkyn8omBheinX/PKormxWx6f7L11SUZ0Ir90+yCoNLad+/FjRRQkeykKQscVkpF
	 PUXEszMy3EsUbOeDVntj1XM+eMS2sRaQ7jumsS2RD8yPZoKI4CuztP24P+dW7MheyI082
	 eAXlzVY3ydbTzt4GQNh7z852t5NzOvscpvUcrHtyEup33lGIMg+sDbIhbZr8kYI0Q7OHA
	 SH/BZbzdGIaVF4jZmGdIwuj2nDFPK/E5Qayxhj3rYN72lqw0OtQjlkyiHSBApD9X3pTPR
	 0LQfMR4roJG5Hnk9IaJPp/JJQvPKDIq00DGX9fcn1ZoAQa3A1Mr2omqhNIEnA47GFUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794137683;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IAm1RnU3LXIK+q/reOMxdY6siUbNPc2TIpIN4Jo7ygE=;
	b=XF2po4QdSW5GYTKwyS8XN5zC8N7QKTu1qrNvKZ3FPXkSG7UY+axT4hMxqhSx/g1qxpmX
	 Tgd8urNSe+HDz6sCWjksfAeqlskBLSp7+B9W9LMu4NfY3BBqYtOxsC+iP2v8TiRFFsZDw
	 jdC4qhRPLMOVYekGXfJWZbk1qX2fZb+3CCSzmH7ia3J0Rky5eMNXE+mogDeXeSVPgyIrq
	 OE6iC82M2/jxBempu7ojZE6FSwLwRWrMcpFc/TUPuwQYjZTpRe43CYsKyjxhBwKFc0f8e
	 UG7w/KAa9ynL/Vjf3368h1o2MQeSed4sDqSmmR3p5dC3xt5HQdtL0z5O1HT6Z6ACEcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VLMf6vS7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3398A606D809;
	Sun,  8 Nov 2026 11:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VLMf6vS7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794137682;
	b=v6LsmYO7zm5RFvL/ZOa+clhuXMDhJ6cmSiMq94KIy3t5Miqxahqqt2yMSclpvR8+morj
	 4R+SBj88gdx+sOOFw9o76J1W0IZvp8KXGHOKZlfAMLgcM23TxonsYHlKZJeZ38UqmoKQ5
	 F/HlBdS5pmbehMHvqQ5p+TRselN6/vpA/zJAL6qdBzB4uoRS6ggzn3TplVglgc+lZqRlf
	 TiQxHEjPYsI/xQV8iyM5GomD5ssfG/s34lp+XIyF5/ORYSlPDU56PhYbEWZCjIVk6kJAC
	 U0n+wORRX31VHQpWMhz7nO6mg45a2KcVxq+0BrXabXFxR8cxuh0oiSrHc9ZRc9AnF6Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794137682;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IAm1RnU3LXIK+q/reOMxdY6siUbNPc2TIpIN4Jo7ygE=;
	b=p8bR5ymSC6dn5LzahRI97d4wpBsUMUrAhBNivJGVya09cGFrUDQyiQ7io9DfWJaWk0/Q
	 ESzwQ0QK/1TXoZ979U3BueY2of8tLsQmEkXTbJjYELuPyZECmHbPWw6ZFVegvCM+VPSKM
	 gU3tVPi1/CN3hfg2IPWXcV1E1PAJpAvMViINBf/GgdYl7c/WdDyruXFN++rt9kcD84qlw
	 hYwAGxmv/AyDLX0KzBVkAJolNUxX5ANu1qaK+ThGnMgbt+fFMmq1vwolcDHdwHnUHvXEn
	 fYro1c4fI2ec4ycxXp65P8rF+TfyYmatIMz4hhccu46mdGVsbvJuEcUpbjjR4dFZsHw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 04ED71F008A6;
	Sun,  8 Nov 2026 11:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794137682;
	bh=IAm1RnU3LXIK+q/reOMxdY6siUbNPc2TIpIN4Jo7ygE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=VLMf6vS77Ajd/Xry5fLiNS4AU7N3xD+txIiu3Vwn56fh/Lq4rXMQHFgh80iDyCvTi
	 7JMeQInMR8Z32u31p1OyVF9ufwDf9SSA4Ezy487QW5VWu6tZech6qg6SycUFeUaiw+
	 QzvQD5nJ65QAZ+SougA/BYH/jFL7CQLZEK+rfIKUC0KIW8IyOIpCyfZUp/XJX5+6gA
	 eO/qZNATyYXDdmwBEngQNSXTG2xtFYv3BpZsaCIdpT3h+yIYX7MbWBlPUwv0OccuR/
	 0XXJw9FaIZkzDw4/slW7yI8zrLDRCgcVcHX0l7IXUrfGWQdsgIZOqAxMsijAkka2Mh
	 gAL9VzPZ0BxUA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7EDB647F21;
	Sun,  8 Nov 2026 11:34:40 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Sun, 08 Nov 2026 19:33:33 +0800
Subject: [PATCH net v8 06/10] can: rockchip_canfd: cancel bus-off restart
 before closing the device
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
Message-Id: <20261108-rockchip-canfd-restart-close-v8-6-3e7a23fd9eae@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794137678; l=1424;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=FqCrBu6JrjmPJcQNJBNICwgHwS2YwinHx4qtGS13N34=;
 b=i2Ci5E0tAafzS0qAJEBGydAg1E86nZBqbEkK2yxFhtabt/ier7jiHqpaKFV0ZFU7zlbJu2TB3
 a99U/UPov8XDLMYRVe1ltx1KnCgScl/y+Mqb5XAPtHXNXAItMVqr6L6
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

The close path cancels restart_work in close_candev() only after freeing
the IRQ, disabling RX offload and stopping the controller. A concurrent
restart can re-enable the controller and interrupts after IRQ teardown,
or requeue timestamp work that accesses registers after runtime suspend
has disabled the controller clocks.

Call close_candev_cancel_restart_sync() at the start of ndo_stop(), while
the resources needed by a running restart are still available. Keep
close_candev() after IRQ teardown for final cancellation and echo cleanup.

Fixes: ff60bfbaf67f ("can: rockchip_canfd: add driver for Rockchip CAN-FD controller")
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>

---
Changes in v7:
- Keep close cancellation separate from restart and open error handling.
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 1cae86973da5..59a79fe057e6 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -758,6 +758,7 @@ static int rkcanfd_stop(struct net_device *ndev)
 {
 	struct rkcanfd_priv *priv = netdev_priv(ndev);
 
+	close_candev_cancel_restart_sync(ndev);
 	netif_stop_queue(ndev);
 
 	rkcanfd_chip_interrupts_disable(priv);

-- 
2.34.1


