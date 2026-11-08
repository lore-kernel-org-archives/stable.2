Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794137684;
	b=hfE3qH8RNed1GxyKsRphd+VHWP6jBOKPPL6YIpW3Bz5XkFzn8Ey8gkIeXgzkAmfO6oD1
	 j7/7m+960jYIo9aWeMMhyfwhMf/NL9ohvg4XD1kE7WCU6bswGIVThsQbP5zzB9J5R9vQO
	 T2hBNFeOHf6hMo5wkTKDkpgLL8YZg56QozUDXdCpbY6yRzstB6vWDrzlzpU82Sd6zfLxN
	 IMYxQADYophdk4UUCxo4E2s0PI8fQSZe04rIKuuncIyzQtx6fVjCzjbu01olUJqDVYKmX
	 i6nOynvYac8mCrEoPwLV/oJuBdIci6ZEdjUK/MA/v5uB5FVcNnPd1kA8mETiUtClRpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794137684;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Vy2qrURO3C2NVUk5rtQtWRK30u4eytr719WYCKwsdRg=;
	b=2gzayR732i34KR/P7FKg3YCmCTnGWNhy9FDP7vCM2yQbBdG6fAS7iCRfoS6suYbUUui2
	 eTVunl4vAeXJKRvy77gjD4OsGyNhsI/gzeTWsmYViMrdizwt9We2AVTUa8iSFJtJyjEpY
	 ojOp3oc1RWj+4G9JBZbkUXKG29sybDOavd1OPlIN7du8PJJXCz/8HtFflotvCeotIWrEC
	 mxdmQTazqB3hWPGukGNk/hV1SnefRj5fQd6CT/e0sgh/sUrh+ZKZ9vyf8XLnuaxk5qgYy
	 KVjMocNIDesezeDoGD4ZZOJoJbUjZmJpoXper0D0+9GIzD6DD+oclbnlgGCWOWOPkxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aVcIjb6U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCA8606A32A;
	Sun,  8 Nov 2026 11:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aVcIjb6U
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794137683;
	b=MMXqi+MtnhgaYnjB5qdpSJst63pOD4z0O10WIygr6qUFRoX/PYc4NxfUhM/RZb4giiAb
	 4Ah9QetNLpk55yhFcxCPZpP94Ho1oiQMdi2fJ8BBFoS5UI63/iaEIz1hOJF+abmvb/vDW
	 PdEl02nfaHS9aHDeAOVwilODhnn2ZYcxZb7NOP68cr+BB0IqOxNW8LBEZ4Dhru5wIjXss
	 ay9UxLrTHca/bBSIiCTU8NsFKM/Ozeu6Df6OEIw4NWpOnPEVJzMafQEqLYDUDrYPZvafE
	 uyn0IdfnLQyVGTZU6ZCoQiJzTZhQ580osCAq7QL/HCluoemfPHyHMJkNH78X0DyDTEw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794137683;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Vy2qrURO3C2NVUk5rtQtWRK30u4eytr719WYCKwsdRg=;
	b=JY+y3kcslN8yP0iQ4/r4Ngo5+DmwBd5uI0OjbdB2urF+8lnydNCjApQqp7pBp5ZXXY4Y
	 2nYN6HZhOVQtp0lspmtNGzdEhPscEzlFmwro0DhG0aoBANdBYqob3ngC7PJ5qCNWj6QwG
	 zMmfaqciLIknzJlkkunEJtozs2alZgz5zjmcXhGAXOGIZmjDeZJssUT9dMOddvD3AlT3h
	 LXwLJIHfK73z4sGAmujv5J2CGtrRX5t9PqXDbk53SU3IsFWqY7GANL7CGBtr8dwONs7wF
	 KBDU5bF2wyRP9geGlqXOw4E/ZqlJ0TJUSSItJtm85jeZtKtB0BW7dbYJAnUV/71P0zQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 26D2C1F008A2;
	Sun,  8 Nov 2026 11:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794137683;
	bh=Vy2qrURO3C2NVUk5rtQtWRK30u4eytr719WYCKwsdRg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=aVcIjb6UEbem2us9ESPX/c6uyptQmM8AzsFuGlx1qiJVnMuhNFq3WD9PGncZMXLJx
	 0xxuMYs1zWZWIOUuEWl3yc7B8MKoA1otyXpXS3UDnL5XeQ8ce79G3OzGtb7n4XnvfD
	 zqW+f8ptG5G6NtptMdGgnk0QlHb2CJY4AjrIqMjchFTla2KtUgIf83m6HUdtzxoP2m
	 Sv1Ni7U/HTB6QmK5tFetQzWbJDUQ0A/uhtmgUL9d3gmtBs6GMDFlT9CKsb+CtbEukI
	 8Xv2657SUXRmkVaTt9GM6PTrxTukaIp0u4226JK5/6Z9GMU8Vi52m5zI06PaZoSPRo
	 ggEN99QHnnFRg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C747747F31;
	Sun,  8 Nov 2026 11:34:40 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Sun, 08 Nov 2026 19:33:37 +0800
Subject: [PATCH net v8 10/10] can: rockchip_canfd: serialize timecounter
 timestamp conversion
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
Message-Id: <20261108-rockchip-canfd-restart-close-v8-10-3e7a23fd9eae@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794137679; l=2957;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=9VhCsHzQVgwKjVIZpuLTsjW3kBG025wPmIX2/tRYdvQ=;
 b=h+37yVex9KuC9pcGTXb3sYEez/gyJOACzqtpKUPAcVH9OPPoB+RvL9FOxd5jPxhnjx9X1p2Rm
 biQ+iWgKOeZBozIDHs5AJKfkJBOjgtf0mEDmU8BMmylAUsRgdd4Uh13
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

The timestamp worker advances the timecounter with timecounter_read()
while RX, TX completion and error-frame paths use timecounter_cyc2time()
to convert hardware timestamps without holding timestamp_lock.

timecounter_read() updates frac, cycle_last and nsec in separate steps.
A concurrent conversion can observe the new cycle_last with the old
nsec and produce an incorrect timestamp.

Hold timestamp_lock across timecounter_cyc2time(), using the same lock
as timecounter_read() and timecounter_init(). Keep the SKB timestamp
assignment outside the critical section.

TX completion nests timestamp_lock inside tx_lock; no timestamp-lock
holder acquires tx_lock.

Fixes: 4e1a18bab124 ("can: rockchip_canfd: add hardware timestamping support")
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 drivers/net/can/rockchip/rockchip_canfd-timestamp.c | 5 ++++-
 drivers/net/can/rockchip/rockchip_canfd.h           | 4 ++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
index 1d2a122770dc..e255bb33a20d 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
@@ -15,13 +15,16 @@ static u64 rkcanfd_timestamp_read(struct cyclecounter *cc)
 	return rkcanfd_get_timestamp(priv);
 }
 
-void rkcanfd_skb_set_timestamp(const struct rkcanfd_priv *priv,
+void rkcanfd_skb_set_timestamp(struct rkcanfd_priv *priv,
 			       struct sk_buff *skb, const u32 timestamp)
 {
 	struct skb_shared_hwtstamps *hwtstamps = skb_hwtstamps(skb);
+	unsigned long flags;
 	u64 ns;
 
+	spin_lock_irqsave(&priv->timestamp_lock, flags);
 	ns = timecounter_cyc2time(&priv->tc, timestamp);
+	spin_unlock_irqrestore(&priv->timestamp_lock, flags);
 
 	hwtstamps->hwtstamp = ns_to_ktime(ns);
 }
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 078876769a05..ecb9e2d6aa19 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -477,7 +477,7 @@ struct rkcanfd_priv {
 
 	/* Serialize TX submission/completion with bus-off and restart. */
 	spinlock_t tx_lock;
-	/* Protects timestamp_active and worker reads/requeueing. */
+	/* Protects tc, timestamp_active and worker requeueing. */
 	spinlock_t timestamp_lock;
 	void __iomem *regs;
 	unsigned int tx_head;
@@ -557,7 +557,7 @@ void rkcanfd_ethtool_init(struct rkcanfd_priv *priv);
 
 int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv);
 
-void rkcanfd_skb_set_timestamp(const struct rkcanfd_priv *priv,
+void rkcanfd_skb_set_timestamp(struct rkcanfd_priv *priv,
 			       struct sk_buff *skb, const u32 timestamp);
 void rkcanfd_timestamp_work_init(struct rkcanfd_priv *priv);
 void rkcanfd_timestamp_init(struct rkcanfd_priv *priv);

-- 
2.34.1


