Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793033131;
	b=x0Td6VEsnbhqcvNmRbnI4+1KYBDUASafVLk/qsdb0MsUB/gQ9bKYgLUL6PUwMHFBPElp
	 4mmEMBlwVzUbU2tmdPpattABlCb9+XND4LirwbVAZLL9OBzPh6f0/u4UbchiDddsNLWfY
	 DAlR8v4mKkzOLovDB0eZbsXPsncbA3W0IXIPg7qvEkiGdwdeqwUvtr0gs0CM8n/TJPm7j
	 0BV6OUjCFBEYPR9P+lScLBYaGVrUCHJZAqFq45nQ9yGxtRVYmt6Pgiy4FCKR5t/n99MJ/
	 QRGIHDDpFvCksexK+0nF5cdxVHK6NgsgzbDJ2s/MufzUd1igvpEd+h8gYHaUlWhAhfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033131;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=gzqvCXUxAiBvbMROfVnJpVOaWr7Kd+9TvqdSl276L7w=;
	b=ViC3gJbe+x1ekJDc6ENN712vlQQF7ngXpE4JNVt98DJy/JKnkrC6YNqyIVt/cB2+G+IV
	 DHgiSLQt1WDTMYbeyVMaUq1ggu23UGMT3vH+++Ag31Zodf2VTcVCuIwMu82zmg2JOF180
	 P15mCgUtCLPlswKE68nGOgG3RcO6LGc1c/dzRiahozDMbcZtKYHVWlmslBdV6XFQUk+8v
	 mesnFne38zSDq+82XAFSizqcM50I0m31ytGZ/8zNcMoBm9k8SwNJKXwpmVoSwHr2q2HPE
	 5NIPNOVT3VHXXV68uF7qSMo2lGY4kycuxLOI9Y7vA9nhElLXhFjHPAZchde0AnbTlYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=dT3gpzU8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7395E606A31D;
	Mon, 26 Oct 2026 16:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7395E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=dT3gpzU8
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9DD6820291F;
	Mon, 26 Oct 2026 17:45:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793033123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gzqvCXUxAiBvbMROfVnJpVOaWr7Kd+9TvqdSl276L7w=;
	b=dT3gpzU8y9xdEs+OkdCz8ddsV1EVHCTsRGQfY7eZRzPSSINYD28j0tcdMCp4IAA5AEwLp8
	7tohQ9SVTUBwKt/UIEpIwwpCU3WZ5gK5MSzAAmLv/mA88TFOnAm36PQcguReK29u+PA2N6
	A09TvzRmLYuD0k3S/G8RRx/lAOG9Tu5dhFq2neNPEZr/xACSHgUgg/zSRUPGLIzXFUi+pe
	PfqHFS0MkcO7Rt8KBpSldqfwh5o0N1IwLK9WcemSxj0uYFXx0kvXuRvHnBvIHfLO27RD4Y
	Rr6q5VkQCJn1izCw6xTrvgbSP9DCVmBUf15QBVtFLbOmxjeV+HtHeRcD1lb4rA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793033123; a=rsa-sha256;
	cv=none;
	b=Y6G9bhX4MHSpqAQ434NnnSzf7k05kBMfSCsniG5EypiK/mBLfnrwMmZ+qtAglvy5191+gZ
	T0xSJ9DXQu5mRfVVOLiWFa2l4jEKTSmVzHGTZIxchs1LyYBnxur91y8l7E+S5tkVV9PY2x
	YxssK4sRHTx2oOWB6Hmu708HFE9QatZULSCrjZTB9rln5FxQh9rJW9zXn/rkj0gP2kBWSI
	4Ju/H5/aUNJeZ6yJzAmosjkNbHhWX89Tg3xpybsscHaFxVbdDxs0gA3jZ/DqIe38XY8+LD
	cl0HC6+nnJFl14hRloi3O7bHU7+plYIuuojsX+j68hFdzIlC607uVjdChZ0PYg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793033123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gzqvCXUxAiBvbMROfVnJpVOaWr7Kd+9TvqdSl276L7w=;
	b=Is6O2vJYZ7cIlRit0wlKGQDKx2xCwuYFWW7OS98USm+Ynt7SkhxnLmP/zX7IKrLRWB2HDk
	zDS0XB+IRvoz0qb/QJjkHttNXI5f6WOEyqpQeXd6K+oaJ9LKXbnv2Y35wrEUpn3T7jhxcR
	Pma8zNWaDP4X0HdobgGDS0EkXdFCATZqMI0sdihsuTfAgZ8uoTif13GYDEY3ToVsRmo6IM
	nxf4tdOW8U3Ar95FVqaqYoog1omnaREMbNeQ0RVBqCu7MOKNmtc+R5mDj8rBwlZhVwynAD
	j0EgeCUSU6wjY5k+L+9W4/6/YUhjB4dmRY6bYqfInYaHSfjA+5/lPf53jk7PYw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xLNp5-001JFb-1j;
	Mon, 26 Oct 2026 17:45:23 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D9B875D7168;
	Mon, 26 Oct 2026 16:45:22 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 26 Oct 2026 17:45:05 +0100
Subject: [PATCH v3 1/4] can: gs_usb: gs_can_start_xmit(): don't leak
 uninitialized memory over USB
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-gs_usb-fixes-v3-1-3a68f1f62813@pengutronix.de>
References: <20261026-gs_usb-fixes-v3-0-3a68f1f62813@pengutronix.de>
In-Reply-To: <20261026-gs_usb-fixes-v3-0-3a68f1f62813@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=1117; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=xMzMzZuOb1bhvyVgFQl8vx69LoqShxppSYb1Nul7mjw=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi63zw3+uOh0qd3WR7PnfNd7Obj+nTfjw/jr1ff8TjYY
 7LjaIYTS0cpC4MYF4OsmCLL0h8nFAUCHUp7XyZMgpnDygQyhIGLUwAmsjKF4X/KY5ttXw3kOG95
 7pVVuZa/7snDLdX3EuKuPdtwe5tPx14rhj/c/wrY/yc+jPV/pXDqU/KllxdbZgtvOTyrR6jpQkJ
 inwMDAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

The driver allocates the transmission buffer using kmalloc(), which means
the memory remains uninitialized. Then various headers are filled and, but
only the actual CAN frame data payload (of length cfd->len or cf->len) is
copied into the buffer, leaving the remaining buffer uninitialized.

Fix this information leak, allocate the buffer with kzalloc().

Closes: https://sashiko.dev/#/bug/linux-0a8c0e8a-c623-426a-8db3-f55111f6cd84
Fixes: 26949ac935e3 ("can: gs_usb: add CAN-FD support")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 3b9b2f104d86..15f28833f2de 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -861,7 +861,7 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 	if (!urb)
 		goto nomem_urb;
 
-	hf = kmalloc(dev->hf_size_tx, GFP_ATOMIC);
+	hf = kzalloc(dev->hf_size_tx, GFP_ATOMIC);
 	if (!hf)
 		goto nomem_hf;
 

-- 
2.53.0

