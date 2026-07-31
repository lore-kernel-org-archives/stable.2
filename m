Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3CC3F12C8;
	Fri, 31 Jul 2026 10:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494382; cv=none; b=DS04ec41iWYqNXSaRVsfRcgDf2mEeo8dsksik4T7tYnfdJs2l7domkjv2KtNHpyBON4XE/t1GFq2bcP7BqvZR6WUaXkU7RTx5SY6Hr//9wWms86Px0CBw7fDR9HuiACn5E96ZAGducWosSAWiLRH+KMIajOiVnzjL0C4pLkAPmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494382; c=relaxed/simple;
	bh=ymmYIt4w0NwA8n/+Fhp8T42/fjndZ2N5zfQ+aZGLc1s=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:References:
	 In-Reply-To:To:Cc; b=Q4hzC9/gV5wR4uhN6mY+ETYaUVJSFUswfQSlthsIjwTvS7dUCRfgce3taikmzaF1M2c0iDdilx65GhCEpxeeL2JEbAntCDT7wDTFYkGjfu9NtcpPRrTuaEqzrCxECzLJ9WZCC01QA/gZumb5pr08q675Ayn7zwUv3E9xNh0+BjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=nM3gX43O; arc=none smtp.client-ip=43.163.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="nM3gX43O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785494354; bh=m7qxUfNuNYwHLukQ/v7wucFmPYkJnNgWcHS1M9XrEsU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nM3gX43OQYGpPrbi+jc9/p9TtaRTAjubxcDis8p1PThEW3aJd0jdv8FNd9eNckNQJ
	 yUhEXiaNXuT2CyEVMc/ur/FLYGe5QKcMyrSbDbP3V3Vmwe6yW+HaKjLNjImxvseo1v
	 8a0VNDrEftsNUn0qhUKyAN8dBvIwHBY6dDaPcRVo=
Received: from ubuntu2204.localdomain ([2409:8d20:22b:54c:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 9C92DE69; Fri, 31 Jul 2026 18:39:09 +0800
X-QQ-mid: xmsmtpt1785494351tx3mh9mqp
Message-ID: <tencent_C82C09E7235101CC88A97E154D2534183208@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb541XAeqd43cOdeeHJFxxvmwp8y4jTE0nEspTojKTJ+gYXgKdzpH
	 ADS6Fgpgss50hz0G/FZuFM7F7Qyw/0v5lEuWyl5ECnImL64fZHcljs9Ul/qjUaPUkjb5S25+z3eS
	 3GKdYgkXALJgui7F5NNVpRPe2ssZntf1Nfyv3Om0QYIRegohB4IK1ZC/Xgynd5foe5d1OO7aaji4
	 m6nnPDtlCz0KtXYHFbBIheo8P6LEbLu31FtP8Yts7WiGKG5+ta/GKUj3cL7+JwS9k/E5fxiOaYW2
	 ADc7J/Xf0Cvec5P384xEU7eLzpeIBWUTVj73QnoJfQ8Cmy1aim1Tx5VYrAxTz+Q129LUz4zaXGTH
	 OiagMwtXRaOf+IzOx0EqLKlL1p9WGH6/hxJHv6rVTACLGnW2T7+OLyt40PoPCXjGa2y2Wk/haWFL
	 YiB6X/+Yj2KJ8CPEy4dLKVRtgkOgfatkxGtkucAB3QOHUKLsAIzlyEe2qOCfS47WZIvWrXsx3FaI
	 FsSFAU9UtsQpN/ac3tLS3+vYIbdtXCRlMB2b/AGPYOYfIyAzZhf5Gag9a+TElWH6qOdhOnV2z6U3
	 h/pYLQfSwK2rC0gRYmhk27Y/FuuDDGF931tk0fulYENUhyqJia86M5fT/rY/RxSkLJOvW0AcC+YY
	 uE0QlfZzTEgH+QRnynPmluKksqz1+4KJGfFDhraLnTD3nPFP2H96ejKKHdV1S3xuQjCAKBrEvgmz
	 7jeanJ4XqHPSk7mEyPfjs4ZIelmrFnp665iwyHsCpVqoPJVi1qPH3VrXPiT3dCM0MLf9qChce5pU
	 bi8VFxV2K+31bTIFga7VHPHn0AQXZ/lGnL9c+p2Q9BLWNPhfGDxVL+zvhRU3qrvDilNdy2aIzS0F
	 gH2LrdiDQxALDh2ozH9lx8Bv8K1jvLbS+cn3wvqC2EdxPlpaiJK7K/5jFjNv3G8agEs+xQc2emBd
	 cN+fpXQJAlApAWfo4qNQVvpdh797/SpglyqvSZJTpsbiS7zQlsvWmgc5QGlAKOBJFKQfZ5uzLo5u
	 y42nJSbY1WBLD+5yXY+J9+EaNQ2Yg1zsuignSLtMleX+/6CSO6bu2jRQCRKSCgsytk49V3GAwujo
	 jlAhIWE5T0B8n9tQw=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Cunhao Lu <1579567540@qq.com>
Date: Fri, 31 Jul 2026 18:39:03 +0800
Subject: [PATCH v5 1/3] can: rockchip_canfd: prevent TX stall on echo skb
 failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260731-master-v5-1-5b27029dee20@qq.com>
References: <20260731-master-v5-0-5b27029dee20@qq.com>
In-Reply-To: <20260731-master-v5-0-5b27029dee20@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, kernel@pengutronix.de, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Cunhao Lu <1579567540@qq.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2

rkcanfd_start_xmit() advances tx_head and requests transmission even when
can_put_echo_skb() fails. This creates a pending TX entry without the echo
skb that the RXSTX completion path needs to match the self-received frame.
The entry cannot be completed, and the netdev TX queue can remain stopped
after the two-entry software FIFO fills.

Install the echo skb before loading the hardware TX buffer. If installation
fails, account the frame as dropped and leave both the hardware FIFO and
software TX state unchanged. After the echo skb is installed, use the
stored echo skb as the source for the hardware frame data.

This depends on the standalone can_put_echo_skb() ownership fix. It makes
the remaining -EINVAL path consume the skb and was posted at:

Link: https://lore.kernel.org/linux-can/tencent_944DADCC4B42C8484EC01DA2B15F42132906@qq.com
Fixes: b6661d73290c ("can: rockchip_canfd: add TX PATH")
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 drivers/net/can/rockchip/rockchip_canfd-tx.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
index 12200dcfd338..86fa8f2e1c8b 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
@@ -88,7 +88,16 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		return NETDEV_TX_BUSY;
 	}
 
-	cfd = (struct canfd_frame *)skb->data;
+	tx_head = rkcanfd_get_tx_head(priv);
+	frame_len = can_skb_get_frame_len(skb);
+	err = can_put_echo_skb(skb, ndev, tx_head, frame_len);
+	if (err) {
+		ndev->stats.tx_dropped++;
+		return NETDEV_TX_OK;
+	}
+
+	skb = priv->can.echo_skb[tx_head];
+	cfd = (const struct canfd_frame *)skb->data;
 
 	if (cfd->can_id & CAN_EFF_FLAG) {
 		reg_frameinfo = RKCANFD_REG_FD_FRAMEINFO_FRAME_FORMAT;
@@ -114,7 +123,6 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 					    cfd->len);
 	}
 
-	tx_head = rkcanfd_get_tx_head(priv);
 	reg_cmd = RKCANFD_REG_CMD_TX_REQ(tx_head);
 
 	rkcanfd_write(priv, RKCANFD_REG_FD_TXFRAMEINFO, reg_frameinfo);
@@ -123,10 +131,7 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		rkcanfd_write(priv, RKCANFD_REG_FD_TXDATA0 + i,
 			      *(u32 *)(cfd->data + i));
 
-	frame_len = can_skb_get_frame_len(skb);
-	err = can_put_echo_skb(skb, ndev, tx_head, frame_len);
-	if (!err)
-		netdev_sent_queue(priv->ndev, frame_len);
+	netdev_sent_queue(priv->ndev, frame_len);
 
 	WRITE_ONCE(priv->tx_head, priv->tx_head + 1);
 

-- 
2.34.1

