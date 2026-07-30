Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E941C37C108;
	Thu, 30 Jul 2026 06:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785391988; cv=none; b=cLFRzIUVzlvEph12H10Mzh/XPV2HsbVpBk5gckkooql8TQvujktI4w2wkdB1BV0q0AI8yIcD5R8ir+LfMUuoKvlpsL1ePEcIc1RtBwQwMIsk/zQ8glDlVOCJGaHCf3yKqgwPkP4BIBw8sZ2z9G7FeyxGbvuXPcfUFw5f7XA5jsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785391988; c=relaxed/simple;
	bh=MZx6VkD93F9RnM2fvXsuQdmQ7kfmz09u4KGm9gQexNc=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:References:
	 In-Reply-To:To:Cc; b=B5WqTgTlA74L3bslfR5fLmvHqudN0vvff/GasyAiXldmd1O9rvo3Us6nznygtNYkFwh8LysM50lrDG4OfzQ/o9Jtj34XPmqtrnpAYxI/6dxvldBRfSEMvBAKu6zkKbdnw/ArypAKYBBxXFB+xzPoYBz7G+v4KIXVsKYBx0eVxaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=HIuxalHP; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="HIuxalHP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785391967; bh=6u/mJ1eHhtcpBfaCK5wQm5H38V9X2M73NOfbAlKBO2s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HIuxalHPoS76MHVf/v7qcVKY9OV3Zicir28tOnwbe0V0AyrmPQQQBY+EzLhsc0sDp
	 lk4RPO2Q2SEAxdhfk4nL4K3thH78FbnXTpnl/pDbho4je+DyuIuMb+H9d9/tVF/6Ya
	 KMdqmhb1GRZN8AZmxD2KqVMDWtlT0sC6UQqf7U2c=
Received: from ubuntu2204.localdomain ([2409:8d20:22b:54c:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 2DF15055; Thu, 30 Jul 2026 14:11:31 +0800
X-QQ-mid: xmsmtpt1785391893tsx1kpqqe
Message-ID: <tencent_D2D30ECD988C5C82D18863401362835F7606@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9XFoMCSl6ZInb3+GuQ8gajxOb7Om5LsBNl3hBTktMJbHRntZirGy
	 WEbXlXZrp3uCNOWqNT9oDgKKu69NUPTwn1zHvTdfHFLNy9i3tRuYB5y6GckaW/hdsEr+XsDAFUuN
	 xNLN6kEItGD8z58/qMEWgwXpBqo470jXo8K7NblLlHKp/MhOhRD07phKbNAJSgNzvtmrmqH/8EUu
	 eTVeHeHWzVt3pnc3Ax/pJ1cs2F3aTD63yNe+eRig/XcKfoZB85RiDJtrb+Xdg8H8ySKvWF83MQy4
	 dr4PABrhorsb4NW5lSF2wE5cxb4GRGIHk/fcNHLmlO+pVr6gMjlvn4HeW0+yGoLlMzR5PdO1DTYY
	 9cn6jnn2MQOvxF5vO+fzb7qVcH1iDrEObmbdpmfJ5LUD3AsDLd3q5K4010ltjgn6oC+Nwtjc16xd
	 2+kJAzIi1aTy2gWJkOcXySui0uATnGaSnwMtTRMpSjXN/igNwQkgCB6Cv1EBJkrUEQWf+ATgyldL
	 8T1vKtZYJUYzZiKbjHc/+/JnG75lz54jokhV4VmdcgHBECiV420/DHmnwRZG9F8HnKBxZ80lHW1n
	 5uJImI8U9tevQMnNF0dSq0VtguHUM64+RX+iJcKQrK0C7OFAGYzARDHkPxfIKW9xym8rmcHir9Ps
	 zoHm0Ka1KnaZA1ENzu/0+25CdGl3D2ygNGtM+z+cVt+Krde1nJ9qgxmQrV7GjDGEndx+a3msRDQU
	 26ZER9fJitGMRqcdJr11fCQBeNDMSEkYMD9v2I5CvUcVBzzS3pW51o3WQ3XfBy1GEaAvz2+Yyvn1
	 sbGSScLejuqF27Rm+w6nWObX7cYRejdywBusiY/hqLr9uJFKQxeiv4PGepHOWCXJeLR92aMU9kfG
	 3O4RNTIVu47GPZ1llU3eSgHzJ5WKWBQ/59ljn2iwxFU6NcOov2uQGpPtCaMRNgylYOfONDNMN9vA
	 LD2z06wUdMfTVTEacet+hUPXX/cSw806QB+gRpp4ZkjWqC4wH3v0ab8JRKYlhu5FWlGunQzYfp4h
	 83Ps1S0C9sqfW/bXIkrwYELJxNKRvkyygvvrSIRCly7+Bm0O0CHeXj/+/u2iwcIZv7exifR4k9ZW
	 A7A0EeN+RWxg4rqgVPRxp4inWAK2O1+CzTszP2zvZ6yVgfHxY=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Cunhao Lu <1579567540@qq.com>
Date: Thu, 30 Jul 2026 14:11:22 +0800
Subject: [PATCH 1/3] can: rockchip_canfd: prevent TX stall on echo skb
 failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260730-master-v1-1-6945fdd4f0ff@qq.com>
References: <20260730-master-v1-0-6945fdd4f0ff@qq.com>
In-Reply-To: <20260730-master-v1-0-6945fdd4f0ff@qq.com>
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

