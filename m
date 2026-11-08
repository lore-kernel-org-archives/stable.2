Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794137683;
	b=Gjo+dD0OcPpofXEYyiFnnlrPf9uw+z4TpBDNRctAvAWG3UXtxfLKZDhawRMru1rsCWj8
	 g6OLQJuntU07d9bdQUjuD7P03drUEIcE6EaZhlgW8DPVhrK6SyMGxhzpx7jnWgWfrlGXo
	 POl/9p6oWr9ISIDwakS1LdDm5+bC2bqeIRJOXQu6lYp+Aej3/0Q0VosInbD+BZWmb+J0n
	 5eh6X0aZpZP1YhbfeyMHKmi2DCB/5tmfMMZl/qo9PJy612IY+e5ztE9shAYUytCKvto3N
	 EDhfiH4Ia/TMLetQdeHg6yb1r5lu45VayvJvBMreIokpQma1UB38EBm/o0DZ1XS3oEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794137683;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YkNa4LzKCG0sfUYqqyB6cFxFKiIQsb94NY5wfB85N+Y=;
	b=UtluDosNi1OXqzX4samKqy6DVX69ykv20R3ck9Xk1pgDa1mVKuefHq/dQy9/lurPUzAQ
	 FLFc8D2wRaR5PG5U921EnL2ryrRUQrqFO7Y/l3VckWJ1mmTKBfcakgf0OgZ/nUSvuhS9k
	 u5Hsz502POg9lMKmU0Jc/gmSSdkYCsJiEPiHcY3zg4zIcSMtla5MgBwR2PUlsJJvjWpUb
	 yd+IBaxvQZ0mTNgO1f+Ko4+ldZF+IzffvvBNii2mt+6UTKH9J9auts+Y9Z3qNOa2FE6QA
	 SO4IHaqlgvXz3KFMBKhPqmTRID/z5dKe7vNb1xqtnHsGZDmuESqCGoqDL/+Md4jJDgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aRxIL4WE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13EA606A338;
	Sun,  8 Nov 2026 11:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aRxIL4WE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794137682;
	b=aOuq2toje0NL/OJtJQ2IyzJdG/+4zi7A5b4rGBr91AR2kWesk3w07OXQlyNJcex88BK+
	 YOAjdd4MlP+XcyOmBbuR72Myso6d8jovNE/vWkkqajh7O/LDsGf5yDaAgXLS9xfWtug2n
	 +Zt14xNtujHRuHIcG2NyVinc0+4+JDqF5zCIeznZZV3le2NEOBIPf+nw1O3xYWUAFEbiR
	 w1pQO6YTlSWCfRX6nDg8ngOz24CU6ncqcV2FNv6J3cfDoUI+bQaiq53MZCKKUjc1rr8z3
	 UBC5kTW8l55qboRQC/pe7C3zGUA9KeHz3u2CjxHO4mouqrwMPjw5Ay50YqIB3BeVE6Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794137682;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YkNa4LzKCG0sfUYqqyB6cFxFKiIQsb94NY5wfB85N+Y=;
	b=OCajYGo0EGOV3JX6k6Uuyd3R78RzvBA8wnZ02ACoOqEZsJn7BCkfN3kfoxC2HvvhdI/H
	 JKbFIhQb2KcL54TmqadLeYh5m/yMQU1gr4J0RlEregyDbHIl8eNaIiRzE+HfdkuHujElC
	 1uiQzUZytQi73cAR3OIAenINA7AIDHLYHfalGgHI7h0YUIhEcwr9eF0FvCc3zLBDQb9GG
	 yqxZAk6F2xCVsraN3Is5CcwqTkmDchdKro2jX7XoRTEmBkh+vy4Dh1wBtTICq72L1Ll9G
	 g/KN8zXBO7j25YgwGa6vOA3TP4lUFI9jy0SpZm/XsAwzV3BLEChnonFN5FGjKjPtG1g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B64901F0089F;
	Sun,  8 Nov 2026 11:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794137682;
	bh=YkNa4LzKCG0sfUYqqyB6cFxFKiIQsb94NY5wfB85N+Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=aRxIL4WEEPdDis1HGZTks1P20hg/51fp+Tws1OlkYEZK46F11EKsa4mNZ1jYjQafv
	 sE3q1ZNSIUUjyHcMeFxAkNQA60TBsV4rxsY0QRy5FBKRNovVMG9+pNmLuPm3QOHawG
	 OyxgFGcIN3FmR9jb6cziDf8Xd9vyeK4XGDAOPsvSUYBedr05h+c2/auMK9sIgxaiPL
	 ac8Cz1lliG9jN4bV1Q7NIReBZdjG3hMaZIsM4XRXnjhRjVB/FdhO8PYMilE/a2CZKr
	 XzTeXTN6bIyT+BBndstFOL9JClsKiv1R6kb6SW6dgGqG93kBWbk0TjcFbgf30O2Oit
	 4vDSEUt3NX66Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 29C6847F0B;
	Sun,  8 Nov 2026 11:34:40 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Sun, 08 Nov 2026 19:33:28 +0800
Subject: [PATCH net v8 01/10] can: rockchip_canfd: prevent TX stall on echo
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
Message-Id: <20261108-rockchip-canfd-restart-close-v8-1-3e7a23fd9eae@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794137678; l=2976;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=yFeGM8b4hExYb+05VKnGUsT2mfVsfGSbgmFllNqgntM=;
 b=DL4bwb9oHxwLG4Vnt4QK64megKO+phFOIcM3PHByH0wMm6SZ8aMC3ZV/sNfoLpnoG2N4cL5Jo
 AzNm1RBFiJlBgup+YfCnPrqXzA3oStpSvkhkVBgCIin7yhOATEZyc4f
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


