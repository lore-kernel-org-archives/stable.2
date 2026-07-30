Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1045B3E8C4C;
	Thu, 30 Jul 2026 10:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785406328; cv=none; b=KVucBU04iJxrKoOiyIpfu/7JMPdWb/+Dtvt5AQXIJaeh+OIi5RIA1btDbsENDZGtuZH0x/+spzznipLhDy6nfaUFMzhDe4yPHCouDuoMTN1QmcxbN6V+ydh/pjqXq4qlXjPbu0wGXEpKfXheWfUJVAXgJNtY3zZm9Rwo3MJYlVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785406328; c=relaxed/simple;
	bh=MZx6VkD93F9RnM2fvXsuQdmQ7kfmz09u4KGm9gQexNc=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:References:
	 In-Reply-To:To:Cc; b=LKkgyhO2mabp0nEe/BlpNt9WcaBEHi0Nm3IW5NrTR2vufp5/L7JE00Y8ynco7xYporMrU6WGpqoFFbbmtGVhDkXiIYjbkz1hIGsquaxWxpTbL16wsaDSNdnIWWd7bjdfbKMx1wvlCNXXxgUhDQlSkU857z/CWUdJmuIknIoIkmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=wpifDs9f; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="wpifDs9f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785406321; bh=6u/mJ1eHhtcpBfaCK5wQm5H38V9X2M73NOfbAlKBO2s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=wpifDs9fiALLmaZ3TOoltWT7FNrduusmZfFq/um49qsxm/8FiyUJwXBtjZUHY0YK1
	 2TYLFAB1D9O2QW51uRyqfxRAfVrw0JQ+VAMJal2MXFQZhNHdzy6X1hUbA/DrGvxNH8
	 6Jk/LaaUb4ahNFT5cOp09JgQWppdferNVwCdtq1Y=
Received: from ubuntu2204.localdomain ([2409:8d20:22b:54c:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 2F88CE83; Thu, 30 Jul 2026 18:11:56 +0800
X-QQ-mid: xmsmtpt1785406318td0ibiusl
Message-ID: <tencent_5E44473FC626379A34998A84DF11E6000807@qq.com>
X-QQ-XMAILINFO: MUl6Z5IrFzo7cvYTPQmep32758Pqrx6xuzT5e+ZVJgC2qfDUG0/jobNOP6ufZ9
	 Shs9z5TOddb7ODPyiq73Lj8ntxQDWfsT7Ebwc7YR6UQHZNJmh0MBsnGv1xvPpxvtTUxWXV/ch/py
	 0pI1h9KFlXKekKZUT/d19DV2CNNh28uFpQGDwwMWfGMwHANt+6yxBZGH+QjZXi626vI5VVOSCdG/
	 mE7EmMgWWFCkSUZRCJpCfEDWKK/Q20134/aeSeelF4oH1JCSLVc+UURZwhn7SSQ9bqe4P2MVs6pc
	 kyexliKwTyhNGP7sejYxZUOEAAuGWY5xLIsmlRJlMXOj2RJLWepcZow+8SVeSSDdeJp48KCKgvs3
	 ux8aBXEd3jPR0iKmzdt3bgbJSzz1Fnw3265XMlZiZPmVbT/cj2Cq2PNY+h/bcsR7HxdV9H6R+K8D
	 zKcRimk7SYEOAgWIM6mfhRVCXTZYj4w0UxHGiT8NJ145qvDfn+ULlAieJ23OWaKtPUhgEi/1CCCo
	 KQFCgfB28h75ZaUXbHDPV5A6JGmByw8LpQG3uUXeR0RcoDRzIHLYYwozS4HorvXcmx0zDC5mEos3
	 oUsKe7x8LUuH3uMIJ98PN1AtsPir7PpucpmDrUL8jEGKAobO9tl3v4wppDyn/Dd3XBv9d+MmEG7H
	 fORkjRgGq4ooZrkx81flxQ6b53IgYjTRV6aZ9RDCnMDNQyhN5sDij73DadCTrP+fBd0Bu7sk4e1x
	 BAj+jfPbAujVCfgkiemMtG1pSOFqQngP70JS89hYyMjtHb7K1bvmPdEXUI7UrhEDUMdi/rBmgA8S
	 KKYNWMeVakBwdMiTLwQgbniwdwx6oQeazwJvmYA7cQ14tXCiWLvA8AomYVtxEPS9nbbq1Yg1R5aw
	 dvhcawDuotWrjyZVV+lTNFpgKlfXqalpN29RAd50BSgyXwxeVcWSQF9RZTMQDWJeqaUF2CQr4KFx
	 t4UM3thDIW+mSw3Ah83nj79RCzp9WEvs8yy0tK1vJwGBF/HNM9cnuIPc4uyz5fQRYIQzHD2qf2Yg
	 OBNxWWImr+BHsZyD6k2pTC2Xk/TwaFXcSrsrXsj0iLEWqiXPoQmwsVVzcvMPst38WyuvNcZ7a5vu
	 SWtV1CGFc0+Fk0QYNNOXqEGgxmEPPhw/FPLSIalncZYqgMF66rNf7sPT/qOj3jSZdemX5ul0GiVl
	 TtflIXiPyqgHmBtzqv/m4PiV6JEMxAvtyRBPG/f5NE5R3VPg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Cunhao Lu <1579567540@qq.com>
Date: Thu, 30 Jul 2026 18:11:46 +0800
Subject: [PATCH v2 1/3] can: rockchip_canfd: prevent TX stall on echo skb
 failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260730-master-v2-1-572974052400@qq.com>
References: <20260730-master-v2-0-572974052400@qq.com>
In-Reply-To: <20260730-master-v2-0-572974052400@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Vincent Mailhol <mailhol@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Cunhao Lu <1579567540@qq.com>
X-Mailer: b4 0.15.2

rkcanfd_start_xmit() advances tx_head and requests transmission even when
can_put_echo_skb() fails. This creates a pending TX entry without the echo
skb that the RXSTX completion path needs to match the self-received frame.
The entry cannot be completed, and the netdev TX queue can remain stopped
after the two-entry software FIFO fills.

Do not advance tx_head or request transmission if the echo skb cannot be
installed. Account the frame as dropped and report the error. The
-ENOMEM and -EBUSY paths have already consumed the skb; explicitly free
it on -EINVAL, where ownership remains with the caller.

Fixes: b6661d73290c ("can: rockchip_canfd: add TX PATH")
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 drivers/net/can/rockchip/rockchip_canfd-tx.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
index 12200dcfd338..d2cbe25c46d6 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
@@ -125,8 +125,18 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 
 	frame_len = can_skb_get_frame_len(skb);
 	err = can_put_echo_skb(skb, ndev, tx_head, frame_len);
-	if (!err)
-		netdev_sent_queue(priv->ndev, frame_len);
+	if (err) {
+		if (err == -EINVAL)
+			dev_kfree_skb_any(skb);
+
+		ndev->stats.tx_dropped++;
+		if (net_ratelimit())
+			netdev_err(ndev, "%s: failed to put echo skb: %pe\n",
+				   __func__, ERR_PTR(err));
+
+		return NETDEV_TX_OK;
+	}
+	netdev_sent_queue(priv->ndev, frame_len);
 
 	WRITE_ONCE(priv->tx_head, priv->tx_head + 1);
 

-- 
2.34.1

