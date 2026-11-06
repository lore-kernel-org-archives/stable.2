Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793957855;
	b=oOmWkXa4+8yFu5kZ4AeoRXEwer02XFp675E+ytYHNXOYYl7gEAZXmkbpIVwumzg0bDo8
	 N21IbAHQPN5EpbL6AUUtADocGesybqTCTl7t0mEAQlPFBH4GvgFlCzSRn7IPQtn2gZAAr
	 ZWkDKLDaWvUjT3c02ra3+yWLMWQ+V0eSEddmUcladIe44xbmY/bVN5YozMjsrZcir2bgF
	 2aTa5oQBVvaxl48UIpG0sfko3yN6LRjA/AlCDv8HRc9nbguyoTV8MMwvNTE/BFOLpMNT8
	 yZb3R0H22T64b6GQ6wMmqOJH5SJPcMIEoctC1+gBSwKZ89vah/bUDFTZBOMxQpPENUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957855;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hoOu0Vyn1UsqFVigZaJGQ7Rr3+ALT0LUzsBJsVYCYy4=;
	b=fMGAikIYEa9rwFzR/mD9zZKyaluPGv8mEIUZfediYiCh5u3QQkXVJ/9nKADBAfU/9SHf
	 lqsqerY9bVqyyims0dLOElQG0GJzz7EBhfkH4mq8HQnEAk7Eb8C68sAm+jVH3GSpPNGPL
	 j8vxEII8TB7aev9R++9DgkrMq+5BFK/2bU97/yZ6uS0yC3DklqVkqL75HuMp+sUSFD/qX
	 TbLWl05JVNeb28Wp/Hco4Psulaf70i5UkVwWQc4HX+9NaZu4L+JXLNJb0diAxYEbgrb1r
	 VMQkK9d4XZFUkaPqlRMCmbpH8xo3WZ6Hx6fvkYM64xNqY/O1dFH5ok4AoEVfRLN2ohA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LLI5u5b2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA2B606D811;
	Fri,  6 Nov 2026 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LLI5u5b2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793957855;
	b=a3buqsalN6EOrhXY0BwpaIxS05xYyx6XAXnZGdC3u8nq+4asPdBVDA7R9ul182ZPx0tC
	 W+Ul0r3RmO/rhB9K2fUX5OXQGnqLDXoryAhD/fgcEIyeLD9PqK7brhpUHs6Wsv/wy1+qq
	 zTP1kTU97by4Ua2V2Rlr6pD1J7ifuO+lsseis4pOrVNEJjImvgVAkMWybnaTb5vTFWkNa
	 0Y+tK6HSCLAXAaH2jt8iyg+bR0TJDmWvEDK4IBe8wTgyGV9r4yP1ZXx3gziAiF2L9gKDW
	 8CXo0szbDaAWfQ5kAZipFJRZsJh0Wlpnvg6lWz/UuvxINcskBolclmGA6PvQNEG+yPQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793957855;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hoOu0Vyn1UsqFVigZaJGQ7Rr3+ALT0LUzsBJsVYCYy4=;
	b=OrfKIL2hQt/A7aNVdhW4Afx00VD3ICepg3WkqFLzVNui3iDZIQuEtgIZ4QLInxlFrB++
	 SRbOBjmLgp2m70EDWJvk6wgmP5Lzl/gQTNeeBVipr/mWpboz6gw9fIQDlJaN6AVjex0Uo
	 RgBEZzJM1iMoBmLwZyaEICDB5KCF6PYs+YSQP1BTAIGbiCmamdk9UGLx8Y/pHim1SIuCk
	 nilqZaNYOptuLjQ42LaRYwOmG1cvWutDoPYHN30gbd1cOXXcuE3CWa3rJkVisYWBZQlMt
	 MlxXESyawOV+U1m5R1TqIZMU5jYRQkFVLTiZqCBKqN+Q6S+YecMHe7x+z9PE9IJkB/Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 199781F00931;
	Fri,  6 Nov 2026 09:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793957855;
	bh=hoOu0Vyn1UsqFVigZaJGQ7Rr3+ALT0LUzsBJsVYCYy4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=LLI5u5b2i0VG6QNV8sf2QoGuZYm0NSmkjfFA/EL+Njsak5CI0oC0tkfv6FmTJG/sk
	 S3AyeHXqW6VptkbAOJ9MP82AT5EDBrgpSU/xxPW5bdQW7PGcAlM0zn8Ce2/HvBXMKS
	 OexEdKnJIlb7HWneSKA1vlbE8RiA+Sh2Cc135ttPk/w0vjKF+ZEzVhsj7dojVgzNMm
	 uTIFAFeWQT+CsQxaACoyYQwChq9MYPvAgJoGbAiGDB0dZUyUV8E9yTMyf0MhmvOJJD
	 sXIdLTKobNyLqUyUMVfRqtPerNIlSS+lJIbxvZ/jzOzsLPc3gktlc3JPGzAdw+8pLl
	 n9hi/cGXCIFIw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 89DE245CB5;
	Fri,  6 Nov 2026 09:37:33 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Fri, 06 Nov 2026 17:37:23 +0800
Subject: [PATCH net v7 4/7] can: rockchip_canfd: disable RX offload on open
 failure
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
Message-Id: <20261106-rockchip-canfd-restart-close-v7-4-accdb11bc845@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793957851; l=1266;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=cT3cBscQt29TWUgsPQ2sU0B4DpllcnyjvFZowBvWmU4=;
 b=GJuuhgV+/BkZR5n4Noe2sTohTWEcm2uFLtkkBOFouuWN6wHnFm7EOMs64iDyjlevfWxixb2GD
 CxpX1YOJ4tkBm1JTc1ZnmqSi1pQYIGwIDtzFdcrGj2ODKxRIEgdWlIz
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

rkcanfd_open() enables RX offload before requesting the IRQ. If
request_irq() fails, the error path leaves the offload enabled. A later
open calls napi_enable() on an already enabled NAPI instance.

Disable RX offload on that error path before stopping the controller and
releasing the runtime PM reference.

Fixes: ff60bfbaf67f ("can: rockchip_canfd: add driver for Rockchip CAN-FD controller")
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>

---
Changes in v7:
- Split the open error cleanup into a separate patch.

Changes in v3:
- Disable RX offload when request_irq() fails during open.
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 59a79fe057e6..d05264605efc 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -747,6 +747,7 @@ static int rkcanfd_open(struct net_device *ndev)
 	return 0;
 
 out_rkcanfd_chip_stop:
+	can_rx_offload_disable(&priv->offload);
 	rkcanfd_chip_stop_sync(priv, CAN_STATE_STOPPED);
 	pm_runtime_put(ndev->dev.parent);
 out_close_candev:

-- 
2.34.1


