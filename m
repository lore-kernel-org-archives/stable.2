Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794377929;
	b=40TZgOWaqZyLhVUkC8kTefHdGJWU7ehSQscNAE6DOJVEfJoJ7BEavKVEndLkLw1nkjmu
	 pO2Aa9ft/5kQ8+2z+bhNxChqZgxHt5HfQLWQ2T2nH5SgOlqewJMGfLDupR6J4+yBazulg
	 ZX6OkL0/hoTMul+mD2qvHGZ5tK7L30u87F5NPwHJ0YYJkDHFy42PUaduzbwuV9TDyySWu
	 5aetoQtOGBzGcumPp0sJuZQSIpfx7A3Bk9wZkX9BYcCgY+3Jzo8UvK0rO+mBPNWJLOVPE
	 ZSSKhYpH0c63YbdN8C0v/FKODQPjBykY4hyHDTOMHFOvRbklR3+nVDqLC52zSBOos3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377929;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YkNa4LzKCG0sfUYqqyB6cFxFKiIQsb94NY5wfB85N+Y=;
	b=VgO6I/i5yBUMa3RMjyFFlD3SPMM5JJd/cZ0VjHryZ9MimgrTMsEKLbHX7uzfbOaBHwAS
	 zmbCwoPHAMTabz2NDI2lEn7nBeHw4SKKV7y3H2QwL5ejQZL5GnpqbAvURDPnRa2YfySwE
	 E6mEl5E6Xf82bZLWJRRoeLJ8DkDISbey/svHIJCQGq8BbZJ2bENviE6ZdUWzFSUHYSSd4
	 tmhGT0TZTiuh5q6mXzmQiQmYNiE/fXKc/nrkvD6w7jJYKehOk+tZz+24x/cnqrDaxiTB6
	 Nc+jJWgqHt9NwT4Es/ve6akQ+AlHWUR78HI4skiclrW7ozXSX1BJEeiytORs2zBLSuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eSbxDBE7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0376B606A33B;
	Wed, 11 Nov 2026 06:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eSbxDBE7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794377928;
	b=mXCOMKf16wHGR/ikc0Cr7egd/jxPHs9qYp6X8cAv3AS9iPaO9SehZdV5HiopMTkorzY7
	 LrqxjRsc3u3dipQyaSO+S8l/pnpsishZgCkX8klQrQFd/ZKzz8KgIU9MyQIL3+kxBHwdR
	 njOyoacHC/2LMdu6IrPdfRn6lsFZBK5W8ABQGS3nyfzSaJrd5aeCWDBZzjx1t5jqFAFto
	 9FpyBTx8t4IuKirc+cMBbWccEz8+9oJYwANHJoYoWuS2dcea4wokfKPOhyeklou0M2nmb
	 mk6UxxNQIzFqWbxPIv1t/3ee6JuaPVs+WxYDRi2Rfz6YU+tyjhUtRG/hL/TrZLvrC6A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794377928;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YkNa4LzKCG0sfUYqqyB6cFxFKiIQsb94NY5wfB85N+Y=;
	b=w2UOhqMemvMImz9DxGehgaiNJPLvPKFVu9tvICtkEoniO/9IrCeCrbN1A0pBkG40TNA7
	 Y4GHOmkDB1IdvAL1ZMz4Az7i8a0eAQAOSFCzOyiGkmvNQWXy2nsU7byZ8w7osyGmOh55+
	 QudAl7tXFkc/rm4lIp6AE115ACiyUE9Sbk6HhV71zNrDaaH5JqMIgXmFIr/auPXaeXLbt
	 +gNfHVnH6VZ3soy1bVBt4xA3Xfd6emFkKfS9Ke0TLSIaJIOHhA/RCdf8lIfe8iHe2lu1u
	 7QpttPnjgqPXFWAUtQGdZVkz1kbg0CiZiE4Rtu8DDYsdmEOx2dkMOQ5njqNp7t6k27A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 615A31F00A07;
	Wed, 11 Nov 2026 06:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377928;
	bh=YkNa4LzKCG0sfUYqqyB6cFxFKiIQsb94NY5wfB85N+Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=eSbxDBE7Bph7scktsNzn8ie0oKzFhB9LZmfveWiC7oi32A5+HR8N9O/NJuHSDwMPA
	 /yfum1ObFwV/oTjpTKNFb+eJeLIdZVhOx0hsQhRKaaaFK2bGVpzrNqp2iZ6vuYl3Xo
	 +XjkBMunhIpwxWvBr5rjKsgTHdQhrLgZ1BjkXoI8zEaKzjxwPDu6bldqrF4kCgZj0+
	 oudsu+uth4TKbJo/A0mkDvo1IfA2C5I2KNtKWLuRHd0IlXgsmtzosv+KvEF6ej+lq2
	 IYMChfgymAT4sNOQIURCkVgGm0qw07FRMPFsI7ajSSG+FNM0OgJstXuRCyhAqrRrhz
	 Ew7NqwJpWbH8w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CB04A48DDE;
	Wed, 11 Nov 2026 06:18:46 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Wed, 11 Nov 2026 14:17:55 +0800
Subject: [PATCH net v9 01/10] can: rockchip_canfd: prevent TX stall on echo
 skb failure
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
Message-Id: <20261111-rockchip-canfd-restart-close-v9-1-6643f3825ba3@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794377925; l=2976;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=yFeGM8b4hExYb+05VKnGUsT2mfVsfGSbgmFllNqgntM=;
 b=NCe1fQx4f7jjWdPi5B5K4EeTxUV4FlDnroKN7G5VSdRXzy9Q5Og8hGNFTiKIgVlujq1aQRelS
 +ZNbOOHK9fOD+LrfnS3bmRCwPm4rdY2Z3NteCs2wxafVbLLkOdgxgDL
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
can leave the TX queue stopped.

Install the echo skb before writing the hardware TX buffer. If echo
preparation fails or returns success without installing an echo skb,
drop the frame without writing TX data or commands, advancing tx_head
or adding BQL bytes.

Pass an extra reference to can_put_echo_skb() and retain the original skb
as the frame-data source until submission finishes. This keeps the data
alive even if echo cleanup removes the installed clone. Release the
retained reference on both success and failure.

Backports require can_put_echo_skb() to consume the passed reference on
every return path, including -EINVAL, or equivalent ownership handling.

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


