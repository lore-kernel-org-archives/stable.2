Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794377930;
	b=1iE+OPr3yHnWOo/KHWiXayo8zrfJhjJ/r5++K8wT3PVt/X7of/7Elec3LREkoc1qlTW0
	 dERnw4M0JOXWleJdq7oLLO2ZWWAglfFE9NdloQZneHlLZmjXLEo6WhakZZKrdUeQUz7mI
	 pSUe8kcB/qdo847lJbm+l5Lyrj92RmUK8h8Ld9UX4xlRmKfYaQpgd5zPMmfyeB2VSIIgd
	 Xva/9+bUEnv/4IrR4gOoYLOHFssvW+7SKSwaJkIgvTM4CIEY+rVBSuiAytICzYXQIi16Y
	 6iwLz8DwNM/oiZeqBm0Uik84sO6OLU2c4WS6OJ3eXsCqd1zlOEAnkWilmNuO3i9M/Hw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377930;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IAm1RnU3LXIK+q/reOMxdY6siUbNPc2TIpIN4Jo7ygE=;
	b=isaPjEKoLJWY9XO33LZ8t1uRfUi96NIgb0zNlkVU50qOE5/UqSXXPzwHQCZ6U/oKKwCi
	 c6oWxl6cVcU3jKM9np975lv4ZeYCdtTmEB67UZbQJEgdI3bEUWpuH1JZRkXX3RajcdqrT
	 cv1H5LKQUt7ayUCX8wEOaprajoitycSme/YwVZD8jCgavEsGB8NYJSYO++NNtaEJf+sGp
	 d8EfmkQZUR+Rn1WZy70MSWRSGcja5E8GgPZi1VOOiYORxyALTNbx4XAo2RVsEv0uUlTFp
	 qB/ElrabG3ZmgmnNzlDOVDnTeqo2pxXb/Kn0N19xShh/IZEl5KOV9DAui7fpAuNR+Ig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nms7VqAr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7139960A2626;
	Wed, 11 Nov 2026 06:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nms7VqAr
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794377930;
	b=pvb3SOjmKh+U2OIj1Vj1Kvdf2I3/k6ugUUWu/jq4bD4JnAL6/ev8x7g1V0FHb76ynEZ2
	 Eyo/dnjz7IMAlD+3JQvwk7bpYqZEWJpG9vjCq/9X+tW0WBvwa9arn1b603fft0AIxVlgz
	 C712C03VhQzn/rSdws8Q0cJmp0zn71i5eUXwCnWdisyNBYtqdfV9RnvTs+V2+zd7uTJGU
	 AuitGGQQKH5ax/d/DWBg8wBLeeI4AVNgkyIHGd7ZXPqLa1n7gxKdIM07jKZ+0JJMPqOfL
	 jlvw4hT4JZqQembj+h3hvKPzTULzBmnTnt/S+4Slem/rwnNpwDm7NMDxRH7SF+QuDmQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794377930;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IAm1RnU3LXIK+q/reOMxdY6siUbNPc2TIpIN4Jo7ygE=;
	b=2rifuLSJnpiNyIlYfguhQWez95E+3UwCKevqapMhVRYRcv5RAhf3BhWTFt49MRyePwlt
	 bxW2UT4NIOKpFo6fS8SiM9p7w7btRhiM5UJ/8gNMpdeNgnt8esjbvsQZwBUc/GEXgn5X5
	 4zPpw94vIM7LSxFFycPTla9EuTXkFEqOCoa2lsnXq9jUpXqK+dWCE4g6bCXH4eC3htEw/
	 hRxz+1ylPz8vj7oFEB6CZOIAzWOW5L0ppfK8gdCOd5UqL+q0hOaG/UqcyQiMs8oDp7W4C
	 GIKb244ZgBz1vhdSMZqoGTDw6dWgGgLTljRq6rjpMMLgHWfrexfNgsJ7Kx43n6a3gaA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A770C1F00A0C;
	Wed, 11 Nov 2026 06:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377930;
	bh=IAm1RnU3LXIK+q/reOMxdY6siUbNPc2TIpIN4Jo7ygE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Nms7VqArl9yZKeo1K2PBbJZdrfaYNCJcul1i3CArczTrSw225ytv2FmF2eZUPoNNi
	 FafglXGYQb+Utq/dyH6Exz0DIAyFGKk6Okiiacubri8hIdoWt6/pym8FMVYMd4+SnR
	 5Nl15idj+mlR1iC7WQZxbzEKUJ2RwIiwepWg1C/num2tqFgUbR9l+6rmQK5fx3Qfxk
	 kDMPo2DMWRIviP5QsDCmXYfBLX6nuHD3Tj68QdfQ4mGYnApEVu8G5gTyNLwKGVOQNe
	 GneD2Is8NQPIxPawdRqqxLFXYIRQlJ51Ih+UqXeMufYhGcpyiAMA5JfLhE5yyakZU2
	 OSsp7Q5m6Wywg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 31FD048E12;
	Wed, 11 Nov 2026 06:18:47 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Wed, 11 Nov 2026 14:18:00 +0800
Subject: [PATCH net v9 06/10] can: rockchip_canfd: cancel bus-off restart
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
Message-Id: <20261111-rockchip-canfd-restart-close-v9-6-6643f3825ba3@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794377925; l=1424;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=FqCrBu6JrjmPJcQNJBNICwgHwS2YwinHx4qtGS13N34=;
 b=NLBEFk8Dzy95cokydtlZ19Ep8PEioLeT3ycyxJpuYcp+8tPLjfp6JuZxhKe1RAB3uYJSrsfFH
 fZxio7G7OohAfN062PEnpiYXsq6OClIiba0x1erH5w1rmUcLB2Z3QL7
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


