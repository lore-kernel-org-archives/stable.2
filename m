Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795077592;
	b=FsRqOJ7YFhfVTR6SmBkbUPdzYavHc64hzW/CJq6T0ozWNWJhqO+e/XdAr+EOceWjQw7F
	 O44djqS8zVDo677d8nqe0xQlbxpIaiSMFCQrNtAuYEbjBwEmPgLhyKKAuuE8yXowCN7nG
	 Ixr4HGvWNNhwZ6NejlZVVYItxr9PozxhsMPbLwBZ8W5B6XzbR8TiXGCwzWVbdVcJT/Xmr
	 Tq00c4rlHLBB7OyopDdx1US2E4JdmYZVcH3OAgflqugobOdwzStT0Sov8uG8/+t7R7E3n
	 AgHMCSnvO92g0KEC1vKSY7GEvfwGr1tK7YfBhyGhBp8cQTNyNtF9UNiwxjQEeqLjhkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795077592;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NtttrPvs/78iNQ9sA09ImKffZUBly9ET31v9eoeUGIY=;
	b=UH87kW193VNq5bHNLS7/tIC/j+P9sBRXGNFjdHmh7rVYjNgHoyrfFkyuMgf+4fMwUzt4
	 almNLSVcpPkoAtTMlTcz7RB4OtOW2ZSlkycwzVgSNOQgifiHpyXzVmeW9wxnUHa6PPpQh
	 sSz3St8R3/GmxnEwbDRpfBamsYURIq+pWPme8QUzNf8YXZp3OoJUA1Y7dTjNmH9DP8Ers
	 ht+dEobUJ9afbCxa5mbqhaEgEmn/0YPDyvVx86krNWPFXZzCOjkdE/mZtUAlg4SOBKzN2
	 TS+GnK7sNeuKNQTl/CwYwg9ZCphScn2cmrBx6RXgPEJsmFMrVn2nRdbxwad7FqaPaNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NkphdFhp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC2F60A380A;
	Thu, 19 Nov 2026 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NkphdFhp
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795077592;
	b=dNOmedvmSu3XOia2L+5UEMA7QMxF/O5s/Ff9+Y1KECaKnxgyrtFYbF/H3Hqexwq2rxar
	 97kiA3RTWF0FjxF7quKtGmX12kQk6EnW00ayir7PKUkeQuoT9JmUfA7BF5v633KVKdQ1S
	 nimcfhIi7p5yXZEtCLm1v5X5WcnRfXfN1t/sNMG6iBex80Gna0qZxU/70w4eZr+pMyqGS
	 6uIFV5e2wl1vvxODstWLeyCeko5wP7sKdzWpdWaC/HS6Zl8URXDQDcS5HRwZJR0yTVUrV
	 uS1yFoqgE/yM5HYi6CRHFGUWal2WQH/vqBl7k8YCOkxRQwTM13RL6JNtMEdk3LtkOQg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795077592;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NtttrPvs/78iNQ9sA09ImKffZUBly9ET31v9eoeUGIY=;
	b=mTKUE5DzW1Gauvkyth9fCcPwWvuRQaDJpTLrAnbGzVb751zukEBuksFVxMTk+bQSpibn
	 fPxdph7ZwUR8xSkPEZWLEadiG1xzWJoISfv6xJzTa71NOrHMwVF2zrBD46Gi/bQW2BNKS
	 rzb6T+opcK2DlBR4h0WZTRqCJNvHyX2dZoH8cKgJWVKzIoS6Kff2h/xLTnfzxyWqNRyDP
	 hOapemCuFAnbCpkx0qOPJyap97wpwOuz1U5V5Y0H8lOPH5NbJOMraGL4JsnqmdAURA75Y
	 AZYHZeUiDHT3rcw/0Pb1dFki/1UPrgRPyai78/nsOcGWTJqUHObZAup5inAa8BKv0Lg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E19BB1F000C4;
	Thu, 19 Nov 2026 08:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795077592;
	bh=NtttrPvs/78iNQ9sA09ImKffZUBly9ET31v9eoeUGIY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=NkphdFhpkHaG9pYXirPgMGWpuCVf6/drMwCn5jQ3woQgRYvR+JQupap2YIX2xf+zr
	 3vCS6xro8ZQ+P7cDVt+ZLTqIqZtIG8j4YQWY22x2tJ/pdJ9d7eXpoR7x+I9q5l8hK3
	 0EFehPMxbX32UnuEKdYTGaQev/APQ97oJvEwpr6nZuHVLHwft3KN4KL0pGyDv1Djt2
	 0c6AGeM3+E1sLXZrCpWnQajA1TJj7AT5SyBikcU4aWUIM7JO6r0Lpuz/hho1uIlV6Z
	 /WigcghONGmhKovi/uO14Ig9xOrkhjrv/0GtZHNu1aiVn6hVbXk3t+a1NBqVEYv9Al
	 tJcnuUBDit/dA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5B2054B1A6;
	Thu, 19 Nov 2026 08:39:49 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 19 Nov 2026 16:39:42 +0800
Subject: [PATCH net v10 01/10] can: rockchip_canfd: prevent TX stall on
 echo skb failure
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
Message-Id: <20261119-rockchip-canfd-restart-close-v10-1-df23913aa33a@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795077587; l=2989;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=bHnym469T+y9JYwEnQeqSfFXdELLH4SGreNtjJc4rCU=;
 b=n9YejEbRq+CwBhqMFLW6BKMhOFzYg97rcE83TpW3VxBi87ROCFCC47Wg3KVPbmNBY2LHOGijy
 g6Bwq+t5shyCXofsgqECgXsXSq8I22pqzu0V8ub/cbKp8fTB96otVi+
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

rkcanfd_start_xmit() advances tx_head and requests transmission even when
can_put_echo_skb() fails. Completion matches self-received frames against
the echo ring, so an entry without an echo skb cannot be completed and
can leave the TX queue stopped. While that empty entry blocks tx_tail,
frames already read from the RX FIFO fail echo filtering with -ENOMSG.
They are discarded before reaching sockets, including ordinary frames
from other nodes, and the current FIFO drain ends early.

Install the echo skb first. On error or an empty echo slot, drop the
frame before writing TX data or commands, advancing tx_head or adding
BQL bytes.

Pass an extra reference to can_put_echo_skb() and retain the original skb
as the frame-data source until submission finishes. This keeps the data
alive even if echo cleanup removes the installed clone. Release the
retained reference on both success and failure.

Fixes: b6661d73290c ("can: rockchip_canfd: add TX PATH")
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>

---
Changes in v8:
- Retain the original skb as the frame-data source and release it after
  submission or failure.
- Reject successful echo preparation if no echo skb was installed.
---
 drivers/net/can/rockchip/rockchip_canfd-tx.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
index 12200dcfd3389..420e59b41059c 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
@@ -117,16 +117,21 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	tx_head = rkcanfd_get_tx_head(priv);
 	reg_cmd = RKCANFD_REG_CMD_TX_REQ(tx_head);
 
+	/* Retain the original skb as the frame-data source even if the
+	 * echo skb is removed before submission finishes.
+	 */
+	frame_len = can_skb_get_frame_len(skb);
+	err = can_put_echo_skb(skb_get(skb), ndev, tx_head, frame_len);
+	if (unlikely(err || !priv->can.echo_skb[tx_head]))
+		goto out_drop;
+
 	rkcanfd_write(priv, RKCANFD_REG_FD_TXFRAMEINFO, reg_frameinfo);
 	rkcanfd_write(priv, RKCANFD_REG_FD_TXID, reg_id);
 	for (i = 0; i < cfd->len; i += 4)
 		rkcanfd_write(priv, RKCANFD_REG_FD_TXDATA0 + i,
 			      *(u32 *)(cfd->data + i));
 
-	frame_len = can_skb_get_frame_len(skb);
-	err = can_put_echo_skb(skb, ndev, tx_head, frame_len);
-	if (!err)
-		netdev_sent_queue(priv->ndev, frame_len);
+	netdev_sent_queue(priv->ndev, frame_len);
 
 	WRITE_ONCE(priv->tx_head, priv->tx_head + 1);
 
@@ -137,6 +142,14 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 				  RKCANFD_TX_STOP_THRESHOLD,
 				  RKCANFD_TX_START_THRESHOLD);
 
+	dev_consume_skb_any(skb);
+
+	return NETDEV_TX_OK;
+
+out_drop:
+	ndev->stats.tx_dropped++;
+	dev_kfree_skb_any(skb);
+
 	return NETDEV_TX_OK;
 }
 

-- 
2.34.1


