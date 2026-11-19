Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795077596;
	b=TcXgxxbxhiooVFaNF99LPE1WyBBwM+bHVwSlExIe7JGsm6h0ZwfyTCgRjhkQ8XIRSncv
	 HusBdLrrRdcsmUr7oB5cEG+thNX2KtXaWDUSoj8CS5WAuMuofk9QPPXdq/YVK7vj3wdV/
	 atg2ZAOAOo7/busgSUN40QB6V50GbgUthURQa1SVMET2+uyrKcUBILXohRjpsTYn76y8h
	 fRR6MYnEDqvCumNU0V+vnxmQ6mttDDq7ZCKWbvRrSAy6r7N2wmao1n8aWCTIsAoLMZFRt
	 4Xf5Cnr3VyiqiRpxiEFSCpaaEZAh+MXpCvaiaQDp1B7kgXbGqVcjwrWm1nrwzf5pDVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795077596;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8IIfBZwY0/Vipo2nut6FcxyoXPvE65VzNXft8alQwXE=;
	b=mdIAvDujE1rmT9WqOtph9K0wEPZDn1O1ve8HF+g8GLNxUOGjUaZQjAohRN5C5fxp9yFz
	 MzEAZiKqccWt0Dw2zYGcu6rpNHAGbSCpibuQcokLBwu0kqWg+L4ndh/RtTljEPCDsvW8H
	 044Ln/Kmz+We/qvJSSd0LX6nMHiEN00slWpi6/mtndVEqj0KtxVAGYwDHWDtqKqyRCuAK
	 ZUXD4pUusnu0BzljurZsmcPLLcfPgXBxWSebAqAgejdEVV10Tf7DJCaKnMc4MCfTPK0YQ
	 yS0IPTyNmCOEFORjzhwI2C8I/nEj8j2Hhy+MY7UWM+7+LCXA1i3qJaDYtmaexJjHB6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IiR7T7Yt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF57606A338;
	Thu, 19 Nov 2026 08:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IiR7T7Yt
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795077596;
	b=Dz6woBWFcyf1igbLOIXlp4zQyXP61lDE7LJH5TLb27WQ1tlRe9nQbqLDt9dRI8W18D+d
	 +erOzLWWRcZoQ0//CyxChXn3jKOJQUHYQSLtL0vs2coKsJEBqGblGJedJWrrQSyRIgI2d
	 HgCipyrkeuPaUz4z1P9gr+7HuTpentUEAJRHD4HOThpJs/y6QPHde6ljUFKQLVxKKHrL+
	 ocufzQvCWohwHt4SN6h0YDRowDsZTDmQm2GzmZ56siFFMLr4YZb0FF2tcX9MSzPo0afEs
	 1oZa3377ZeD/nOEjXPRI0xEv0d2Jmoa/9h0yJ97QOdips7Jy/tGh6X9WPnIU9hOnpdw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795077596;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8IIfBZwY0/Vipo2nut6FcxyoXPvE65VzNXft8alQwXE=;
	b=h+WiuwMJGjrOTUmJlRq6g+yyA/EXz41Iq3jzOLVj8Ig0bA7OqmukxaO7f/t2tLcAS9dN
	 ZkRO0MAZYh8HhoQAKhUYLHrIk7xeBdiyu50lldtjJoTMtkiqfQ//v/Ku109qdOLRXeGV9
	 uFkGM7q21srYGhez0BupAiJBitw0oKFrs5MPEfEyTP0RdHQYxdENkY9n5lHfvPtvMkPdw
	 QIS66InBExGAOP1UfnchK7AKqaCVTXgj0rdF9FwCKZE7220/5Lsj53YoegBg0FJYIOksc
	 FedEjtywImuDD4dQtDHqKiGGUmop7IHNjRJJHcVx1yJElFutnHGmFuxEWSO0eH8lAbQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B6F161F00930;
	Thu, 19 Nov 2026 08:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795077596;
	bh=8IIfBZwY0/Vipo2nut6FcxyoXPvE65VzNXft8alQwXE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=IiR7T7YtAqEWe+HcqCWx2M6O9uKOPPGmGUsudf7i6oi+twlO3sEP0SBkC+GI9iROD
	 bMmClxRY/gtilraMR6mwZ30hKF5g0O7gzY0g1uuxYAokxp/Jr7TIhcqf38R7C5u4Av
	 y5LPxPd1gDDkBLDrc41PyhP/kewFib170WJPxAX6Z1Zqzrr3QcqaVuS82liPuujcVN
	 NvlpAXfCizyjH5KfqBmAscgqb0krclB61iqLl/bRmOur6mz+mTHgnEIyC/O16poIFI
	 fWaQLHgSmUYbKGKk4pVY5Cf+dhN3ZIK1JxpjoRZMh3x9qG7akFUFQmEucRJt7ay0KF
	 ezCVP/QPpfvkA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3D92C4B1CA;
	Thu, 19 Nov 2026 08:39:50 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 19 Nov 2026 16:39:51 +0800
Subject: [PATCH net v10 10/10] can: rockchip_canfd: serialize timecounter
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
Message-Id: <20261119-rockchip-canfd-restart-close-v10-10-df23913aa33a@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795077587; l=2925;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=+r/q2Rl2I8NQ6adJiGUotbvYu4U8wC9txcC8z+mu+Ic=;
 b=ix+bj2eByxUlMPtJyr+VbT69M5muyWlJq24slJxXeYu686VBrz8FBX6VIAd43F5Bim12v+JMx
 ebL939YJJS/BRtrnI8cw7P6TGMI0jMQI9DvjZnet+AhiMH7POwU0r43
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
index 7c7b95343aa8..76d522ee972e 100644
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
index 9fa0327b3e74..b84ab01eaab4 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -477,7 +477,7 @@ struct rkcanfd_priv {
 
 	/* Serialize TX submission/completion with bus-off and restart. */
 	spinlock_t tx_lock;
-	/* Serialize timestamp work with start/stop. */
+	/* Protects tc and timestamp_active. */
 	spinlock_t timestamp_lock;
 	void __iomem *regs;
 	unsigned int tx_head;
@@ -561,7 +561,7 @@ void rkcanfd_ethtool_init(struct rkcanfd_priv *priv);
 
 int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv);
 
-void rkcanfd_skb_set_timestamp(const struct rkcanfd_priv *priv,
+void rkcanfd_skb_set_timestamp(struct rkcanfd_priv *priv,
 			       struct sk_buff *skb, const u32 timestamp);
 void rkcanfd_timestamp_work_init(struct rkcanfd_priv *priv);
 void rkcanfd_timestamp_init(struct rkcanfd_priv *priv);

-- 
2.34.1


