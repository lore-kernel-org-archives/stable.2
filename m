Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793957855;
	b=s1OZjQvOZTObcmfzNlZLHqlPEckx/uTsjg/N7zxRwPEPFVU+eOF5xTCqiXSfOiP1pVsW
	 3Mu495h/D35RtHe6U+sNo++x4th726kg+N5AN5EJnDGe1ZpRVMEBbJbefSe4DIu61bweb
	 YnVXR3Bdi7gaQv+6/fKbEEsUIXUr5p6AmLH3X2txo+MJtWZOrH/Sqw2llHeH0H4LVkwqD
	 1+pWdUbZCgOd6z1IadRdkF8c5tncFzngnmDQ+aXw/+iYzNd0sM8MjVleVNljMKGgNGUAw
	 AC4g39qOpcJ2hNQlWQ8KWUOAqwR8HRqTDfWmZEDQAJmV5hRspxdFYDQrM8vtSerA4iA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957855;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IAm1RnU3LXIK+q/reOMxdY6siUbNPc2TIpIN4Jo7ygE=;
	b=qdO7j+Vy7CM/kWGYXFW4rbpGPBF3XPSYlk160nYvsgjjHEIXpElcjLwKLOP1FJAIpIvA
	 PDO3wuh+Wsf3Lad+tvij+Rk2DUnCCfX3aljS7hsZdS8ju3r5ta5W0AmnbILGUsV5ob8Cv
	 brY5qfvBiQx4Kj6b5irNVgwb5Pn66DCsyNQZ26RP8xbD5JpEwKs5mpVcqgjKt2r2M7hfQ
	 ubIsNH+wgXwhjEwxFxTJVbqNlIoE51TfqOFfZU50zcjD0/DVDMbxqMGGbTj1YY3GDN/Wl
	 NwlLVWubPJvmmmQ3RLwkvVz9e5uuC7wS/Oez5przL/nC+Yu7CzkrOoNS+tiQ69dTOtw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C8Oi7t6C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E12606D80B;
	Fri,  6 Nov 2026 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C8Oi7t6C
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793957854;
	b=fdMZYZ2UxV7zpk7RiLp4HE0Db6UsMMCFIAd9fwxRGIlFY5utNiwhW+2K25vqeJDSnwnI
	 sce91VhrLjW1iG151nI2h5JirevGUwZ6qeeqGgsCwJ/Sbr9xMU9OtrPndrP5o4Yw0G050
	 x2jnLj2AyGEg6W9z9TQN56bjeBnduhX9OsIeLDF6HJ6NAoNvvFz2sJlrC7+YSK0rCtsZH
	 620BQsftDKgAiu2F+9vn7ydp9w2WJQ8Vdkp2w9ofCTuGoHpxT28HZUFdbW8ke5Kh92O1N
	 Zyy4/4Oi3/wbe9/ytIZwXC6fKJ703KMcSqIPstW55uSxzM49cxn5GPQJbJTjCRbzqOw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793957854;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IAm1RnU3LXIK+q/reOMxdY6siUbNPc2TIpIN4Jo7ygE=;
	b=wh7XG3GcfT8DhrrornMU9TUwqj7yg2rOHXe3D5xX1AElShiqKZRSt56LJmQu7Hi7PhVz
	 1sqoTWbRzoBvL/tiVgYkF/KrNTYJSycehC4HN2udT7HXcbJcsb+/6MRUPQyDQoaQK4Wg8
	 xvH0/8W4T/3A7kOK47nuAJPsFpjM2CKCwc2CgOSCzj144N+Vjnwa6xmyD+geb0wYV9Ij5
	 P15ZGGKVsEsbqzJLRWMy6s8EsoZ4zqP7pAfeTgWKLXLkv7a5FwOS5dOZ6D2b0xiHOLYBQ
	 CQMe4bJEkvoRabmoHds8ikR8Dcy8+gKFPNpeVRC/IXozbMuuxT+Zfvgp9aXGGztIjKw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0AA641F00939;
	Fri,  6 Nov 2026 09:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793957854;
	bh=IAm1RnU3LXIK+q/reOMxdY6siUbNPc2TIpIN4Jo7ygE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=C8Oi7t6CW0X2COZY4GjH8xcSFVN+/n3g3XIYg1Ep5aKTpMETd96souPUQDGqou4Xk
	 aH4rea2BKO6swdaQD+botzOP7kJZ76DYRX/JJ/0xx2SHBULE/yfXd6o6yybk/K0qHV
	 1FmNyc3iME5BFre4KX0o6wMU7y93w8cxZ6SXHSP/LDizgTBWncNNOkdwDurl48nSwZ
	 Sgf971pu8cYYBqIXr4abNnyS3y1UB7GVMmtHHY4fiXbVujhSN5I6iUeqs4TD7oqi3X
	 h3bsalGBGPkWPx3RYrLTtalElV8clV5I8/m1WJ5nEXLy+VE01/FHokrU4fF+xfOFy9
	 A+kg1z4Zpg1LA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 796D145CB1;
	Fri,  6 Nov 2026 09:37:33 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Fri, 06 Nov 2026 17:37:22 +0800
Subject: [PATCH net v7 3/7] can: rockchip_canfd: cancel bus-off restart
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
Message-Id: <20261106-rockchip-canfd-restart-close-v7-3-accdb11bc845@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793957851; l=1424;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=FqCrBu6JrjmPJcQNJBNICwgHwS2YwinHx4qtGS13N34=;
 b=EksO5sKz1C4ZmTUOQfpAgWiVrw0MsWrGt2EerKcA1mXzUc6TuBGyNWHEzcgtCgH4H/GXC/5cF
 PFYy8SKy+okC2MSp6zM/SrGgJCHVUs9tqiA6gz37vO3QwkK4s6WxLYe
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


