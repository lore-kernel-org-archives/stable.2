Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794736675;
	b=Rd19fDAr7yD5aSZOOKvVthHwAsAC9mvxcZrIzSk95in+6RxrxnfoI1o3tbA8swJ04k4c
	 jfR3crLyr1iWmN7NHpLJOrh0evME1/jvOGtoSiREhTD/8LEA7IJbfVvnXKOFJ3UPJfUtS
	 Q05srCnJrrQHGfusEC8euWXNrLzqENSfz5XyTP8mT/afCpFXAwFBkyt+84VzuwpMFJb0U
	 4BX6XsZ2kVCNcNTndq6ja7KtRBtxdI/zpadTdNDBRY6WCzbbZT7V1+RtcLUHShHFjBFx6
	 BzT6meWzK6oNQxBQYlMt3CI369EoFRRCYsi48+5SqJ6MUIzHeGblkMPHyt5f4Jul94Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794736675;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sXVOFq7OpstFUNryPthfsCINYLwKy9AAup6V1x6fyig=;
	b=5OptmgxeQuPM3H9mf+FIHRygcrYUg3S+3RFh9uAY1hX4Luc+Kujs4C4Iuf0fB0YY3Sz6
	 WKapZD0kG6SrZIK2cfdkOrZogV5pBpPNK/wPMsH5hpKof1z6oDBYqdZlQzADAnPH92zCu
	 VCl97226s+ry77Y+HR4t5ublpSJFSxRR32IoPqC80kMLh7iOf5A/cUFs3NdxTVZk2we5J
	 T4TROEMX8NcgotGsDa2qo0vuiYhSlgK+5fxvSTWg523MzpxqkIwqOywta1oOqk8aVi3WO
	 fRW1JIN5DKamkm7/3IQCPiEY/YB5A074GKencERQ6yHppuaQpWOxTAdqSRn6iPRZd1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="J+1QZz/7";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590D6606A32F;
	Sun, 15 Nov 2026 09:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 590D6606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=J+1QZz/7
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7EDB7205A02;
	Sun, 15 Nov 2026 10:57:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794736670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sXVOFq7OpstFUNryPthfsCINYLwKy9AAup6V1x6fyig=;
	b=J+1QZz/7fPouF6Ao6NDhLpFey8WnExpdG9WK6E1FC0jU3Xz6kcTdt8hBhfSxo75FPYpl38
	XUqzlZSgyyyzLsgQrkZEnzdVaH5ZLrH4U8WLEvI3vhmUemRp9jYHFXWOI5dvpHyl6cl8I5
	9pn0P7WTgJUqmp6+IFxfbI7E7Psgq4T7N5k8Rm7y1GMqdbXcwcAVtZKM1x8P7g31LeNeg1
	7GUDvtiyQ2o+w8WX0GmYnrPpUMgZxwZ4Tnw8J5WLxqaLVy/w3DTd7ZfmCUHn5owwUTKed/
	a5mcpIUufEn3ECyxtNuVKOtHsqRkcIb590VvjfMY6EMof5hUoYPQOgo9sTHgOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794736670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sXVOFq7OpstFUNryPthfsCINYLwKy9AAup6V1x6fyig=;
	b=dmoJ7+3KbEzCzHEn1bjg4RYHanZzvc7LrXkEkWMo6aDnFsD/9i+pZwcfsWIvHs0JuaNQc2
	96BZvZNgB6+ERZ5maRx1fPWayHMAAQop+OS3g2+j4uE8u7RS+hXfSOXwN8ekZWGO349Rfb
	EU92Sh5lcTmK8Fu9LS0hUtG0pztWBbbA1Lg4zSNAeCMgptNUe7mI6PHKVs3EihF7rGc/Y9
	nTbcsc1VmYMq0yVRANOtuOzljA0lZmlHmuOJP03x5NreFDxna0eahBrHtKFWwa5sX8DJWX
	W1sRgrNDKluI8YtZlKv/5Q7M7SZ4MTg6ks5X+QvuGPXwU1VMKX8TlQwWRo8OiA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794736670; a=rsa-sha256;
	cv=none;
	b=X8kz3ocojTp/U+BzejbmKOMpddBl04jU/kF4hgw1657hFq99am2RSPg/tHOJbwafUVCdf+
	sGQtISkPPqCoqHsG8ZO462JP9pOA6srGyeWEAyFf0CJjwwT5YUqlyraAAWMwa+/6c+FWcJ
	omwOEVH7LatGqZzfmtfdWHMY6xZPyU1RK3KyoOr/7AFa+u8SvhhwmTbiL288atGIkqPs48
	YRjYRPauu8rD9v/PdlszvAh3Jesm3CSUZ2GDiomULMdJK/VcndAQk9FHdabLtljJeNfxE8
	EklF9OZlN4FbWZ8KnT6cLYMqMTUVjAzdmaq4igQEXzWWbuflq3xb0GjBm2FCEA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSWze-004GWM-1M;
	Sun, 15 Nov 2026 10:57:50 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1FA305EC251;
	Sun, 15 Nov 2026 09:57:50 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Zhu Ling <zhuling0805@qq.com>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net 5/9] can: netlink: fix IFLA_CAN_BITRATE_MAX attribute sizing
Date: Sun, 15 Nov 2026 10:54:56 +0100
Message-ID: <20261115095746.709371-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261115095746.709371-1-mkl@pengutronix.de>
References: <20261115095746.709371-1-mkl@pengutronix.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhu Ling <zhuling0805@qq.com>

can_fill_info() emits IFLA_CAN_BITRATE_MAX with nla_put(), which consumes
space for both the attribute header and its aligned payload. However,
can_get_size() accounts for the payload only. The resulting underestimate
can make filling the netlink response fail with -EMSGSIZE when the skb has
no remaining slack.

Use nla_total_size() to account for the complete attribute.

Fixes: 2290aefa2e90 ("can: dev: Add support for limiting configured bitrate")
Cc: stable@vger.kernel.org
Signed-off-by: Zhu Ling <zhuling0805@qq.com>
Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
Link: https://patch.msgid.link/tencent_D1C873B86B0E92011A264B0E196B911D5308@qq.com
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-3924d490-baed-49dc-880a-6fd1163cf08d
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---

Notes:
    FAQ:
    
    Q: What about netlink payload size underestimation in `can_pwm_get_size()`
       when PWM capabilities exist but `CAN_CTRLMODE_XL_TMS` is disabled?
    A: This issue will be fixed in a follow up patch, to ease backporting to
       stable.

 drivers/net/can/dev/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 0cd55613a616..c0367c9e65f4 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -825,7 +825,7 @@ static size_t can_get_size(const struct net_device *dev)
 	if (priv->bitrate_const)				/* IFLA_CAN_BITRATE_CONST */
 		size += nla_total_size(sizeof(*priv->bitrate_const) *
 				       priv->bitrate_const_cnt);
-	size += sizeof(priv->bitrate_max);			/* IFLA_CAN_BITRATE_MAX */
+	size += nla_total_size(sizeof(priv->bitrate_max));	/* IFLA_CAN_BITRATE_MAX */
 	size += can_ctrlmode_ext_get_size();			/* IFLA_CAN_CTRLMODE_EXT */
 
 	size += can_data_bittiming_get_size(dev, &priv->fd,
-- 
2.53.0

