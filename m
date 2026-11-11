Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794377930;
	b=zKok506h+W8+6khi+E1NK1jfi91tRC4xMUqM8uAmPESndxVtMAaDhiAQdNfMD0LET+qL
	 SQ3gCq5XkorUKHM/r55eLulvZYqd22GjoOSNCOPcC12eOsBVaoVTH+LL2iilupKCCgVy8
	 /w/XdW8RlxzTlA3VdpNiaVwDPmgY8Lb2VD9tfhOjEU1aphA9DxjCAkazg95iiMsjp62//
	 7RaN15+MTDrfqgeoSLXcyURDU06pO3uiuqrYrfciBnHfIOPLWDzSmCqpsfspvTokBttoO
	 /f6XJcwQbpszTtep0vg/lLRx6k5cWwsNnDeM2CYNQ3sOEODZN4/da6PwGtxzgH3o+sQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377930;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3L3GEqPybJncyMpV9OdThdiq7p/DfA8qp1tin0/xc54=;
	b=JbLO5UW2zSEbCTFtFHOMeDdwdlkGE27NPxqrYg0orcFvlxoZuKIKuOJX93oxwyyNnT56
	 F9l5DV8BCZ7+Gssq4twgHB35DPr36aAyKhcWlA3lA73dGh4Dosr6f5uqPV2vZkGmwsLzC
	 2MjOThPvA3Rf0Kixi6kHklMsso7B/NV9d7rQILkYNSQieY9vXI4S3L7q+64KUPgEU8Aah
	 NJYUP/GhQc6LC/I2lgMOo6Pd0g3JGn+NpHOMAPGFLQ7lfQPigdXSxOtB/R5zqwJlqKDtH
	 mpQZhmLsDwm0yMxLgZ1UjIDYyG2wfY9/PDY4sZYzmyMim19eCDdzK52PrW5Ie3B5oZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=azYFGeca;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A086C60A2635;
	Wed, 11 Nov 2026 06:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=azYFGeca
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794377930;
	b=veqdxQh5recirq+aHmuRvuTZ8N3b8tsRm7KhVy2Hxkj7bczvDdJPgN13Jldu9IeDehQP
	 Ulz5YtnZ40ZhH3H95cdbXK6qt3+bbT8DFXI4jkWuD3OmGCGPO6y0gKcgPhSCuiXVt1e+1
	 NgI8ishF7NQFtBfNJQI4Fs/U6eq1nAXFxjdvt6qTQFU/gRn56CoUQbv4gpm5ZGnvgOxqD
	 fGUfteXXfopBCMUBi+dxLt5a1AHVWEu90Jfdi+4ByLCyaRik2yoFlgVmD2XNAV/L0DTkt
	 XF+ALnfAlatt0NxKfaHbKgoU2ZVoH/CvwoHEnsXm/4GIeBBdNZsaCBkr50rxCMUZspg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794377930;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3L3GEqPybJncyMpV9OdThdiq7p/DfA8qp1tin0/xc54=;
	b=qfHDR1fO5gc3pzpXI0nPhnBub8h/jOILlZZCh8L8BAitwmySnvLLY8B0i/5/Q+yHqH+h
	 elFSzfQ5OxRsR2GqaSRntyLtD7OEgqgOpwdCLwoTEZ/VfIOG2hWRM9o2eVnngouUUVBuY
	 ad8jvT7UYm8cyC7oAdf8+kpiv4b9NwtxIk3x0G+XSKWz8Cgo6LAFuCxnJnwnVDtveAS0y
	 q2LrdMWhdz5SB9EirF8jQ+nkMyqZc7u06TNDxLLG/OHW5ZmDMt6DWD79UvFdam8xItWbq
	 GF2D2PiHQMmaDgvWlrpG4SyO2ncrksAPEbHBHwbPcGFCY39XCZ3gw7Td0dnW7GcnVsA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 705701F00A0F;
	Wed, 11 Nov 2026 06:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377930;
	bh=3L3GEqPybJncyMpV9OdThdiq7p/DfA8qp1tin0/xc54=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=azYFGecaky/U9DNpggTn6iAOYxKv52HHqCqbn+YuLhWw4pp0EAEpDsA/vtrOR4zQl
	 5un/QLfsygvdwgkpAHsdJsABEFPLKUcAQ4ne+2fB49Ip4UQ4NRBwaei2IIXfSej7+W
	 xkLy3FZT6yx1kK6gMqINLFyJhyZC+6cLtHW7V5XjCsyECSHz9BAE+48ORMvZ3JgGOA
	 4VJThdz58rUco9W04iJsosSaEKXs7SpTiW0grjBQUIC/+kkO1iSx8EfdldyKy9doDz
	 +fyObKj+zRxQCOgJMTvAvMlvUe16+pDjhkN5RT9c4dEM3gno+Qu2pw74Q5D3q88rrU
	 A0+s7pDpKeQxA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7CB1648E22;
	Wed, 11 Nov 2026 06:18:47 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Wed, 11 Nov 2026 14:18:04 +0800
Subject: [PATCH net v9 10/10] can: rockchip_canfd: serialize timecounter
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
Message-Id: <20261111-rockchip-canfd-restart-close-v9-10-6643f3825ba3@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794377925; l=2925;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=/OJJmUKkxdYyl5IiheGp+Ad0jAHGaP15X9B+SAYXYJg=;
 b=rzNFrDFtn9neOimhyaAR3MyitGDvUgSv/M+6sLj6+QXm/7nfl6fZtJNwA+o+Pk076fe6+kq+E
 ilDE7Im1682AZ2njpnE+mlABAWwnLZBEBr52yV6m49x9xI1DJ3TnaVr
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
index 3ce996f52e45..da64a7c05008 100644
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
@@ -558,7 +558,7 @@ void rkcanfd_ethtool_init(struct rkcanfd_priv *priv);
 
 int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv);
 
-void rkcanfd_skb_set_timestamp(const struct rkcanfd_priv *priv,
+void rkcanfd_skb_set_timestamp(struct rkcanfd_priv *priv,
 			       struct sk_buff *skb, const u32 timestamp);
 void rkcanfd_timestamp_work_init(struct rkcanfd_priv *priv);
 void rkcanfd_timestamp_init(struct rkcanfd_priv *priv);

-- 
2.34.1


