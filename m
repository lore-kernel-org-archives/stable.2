Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794171225;
	b=h2DrRDVRujykmRNuevlp7r0QTQGlCQHFrutw5d73Cd0B0H+us6ToWt+E6+5PT0qgLhq1
	 kEMn8cO22V+vamz8bLxjWrvipgHHMvUAGF4DGuSKDeGYu8EG5Smsgnv1aMSz4QNfpLDrJ
	 Rkg46Xpl1Ux67liCDRUW4WKd/C3IW58DlZZUt/7zUGyxXvKfg728BAvOhVsllzP5iXdIq
	 Yaw1n9+2/kwud13W7FQzLlwd5+Vxzkm1hsuLksXaj6fdf/bw/sbeYb3eqKktsw5l0AKE3
	 o1s6DFyyv4C3axLsRZCD20V8kvEyq0sVSY+YO1/S0ER2/OFqxcEBeN7IiDH3UA1/PJA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794171225;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=6cqMOzRjZhRECM21udATCgBCEYUZW00d+/7h7UE8Xsc=;
	b=Y8/z8GI62uWIgMEWYO7fucKU0+cUgikNRnmwK+8DxTp3gZdp25d/XnndoRWcY4taPFYX
	 2dtANrO23rEXTV/+cx9Bf+6L+2oPxNvMxouQ4/+ZdzVKQ2XGFxmtCXvkyJ+hQ6tbtGuR3
	 9TRQYFVF1vVRWMIFfG/MlidzcnBAzpYm7dRp/VdbMChUUg/jOTt9P0RP0lBiKMAYzZcDA
	 XtZI/7UJb9uxlezyybDVkyq9k1FsCU3qzadg8oyqdTtwRpnSFYoINSC8f5q/mz6urDNgP
	 8mqKNXXPyivuza/61j3cqeN7M0Zzhi9UPPrr0ZeKpoWuKKCXGNzBRsF+2Lobh5DSknw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=aeiJGcVD;
	arc=fail smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3DD606A326;
	Sun,  8 Nov 2026 20:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC3DD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=aeiJGcVD
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id CF73720185A;
	Sun, 08 Nov 2026 21:53:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794171219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6cqMOzRjZhRECM21udATCgBCEYUZW00d+/7h7UE8Xsc=;
	b=aeiJGcVDqevSzO6BBTtjBLbQBsvRF1QSQte26PvR1Ga5wLbgV0Hbejkp30eionUg9FkNwo
	r2OxjKO+Sjg3dt70SeWjFZ7v/1oTOQO022v5iiE4ZEj/XTAfikZZ6j/ypfIZDUVdP6vL2s
	Kw6wiI10B/VNu7CrcrBbBSQ6CejNmr8FQ4DHDGOW9ro9sZfhG81eKWvI5kK0hRfPQjjYDw
	/nwQEorGToSXZV72n9sBee3ZR1ADcuwSo+w8t3XJkeGHO0d7J3DCysss0iIaO2/ysn/tbE
	Eanzx5kqz8w8Bf5wqUGeAMrK73rNl/n6Zmj+wJoSD45D/YtGSmEOjl62y7Zy7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794171219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6cqMOzRjZhRECM21udATCgBCEYUZW00d+/7h7UE8Xsc=;
	b=SZA9iB5Vww2mG0xBE/nPGLE6LitJd6dPkedCUzMQdACCexeeH3gKRx0c8jrUp8R2rqnGko
	i0MqAiARicJCiix4w5mXq0rF9HHwXoN5j95YT0d/w3eq5iXxPjxWbrBJ0n0wbTbG4tD/GV
	JVfxcRrYHnGPBkx8G7RRHFa39TFtYIO91hf+kR4FtXkdvufmdGSMMvVfq0whdciaH7rm38
	GyAjPcV8TF+fwpEUr7UJ6ItOSufZq3JVTdsB849jNtHe1zqocXBBYAotk+eZdeXhRmeRNl
	LonewIeznvQgPv4+mW5DJrc8fFWnlQ9oN03v/y2qBh5kA2zOVVo7zY/o6hCMpA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794171219; a=rsa-sha256;
	cv=none;
	b=cyBPSu2JCIHfyhSH9Mc31rf27CAhAqQqmbMoQqJd9nvy6D+EPdx9Drc7dll82KSFUnAwl8
	arZV39Kb2eGT8ll06vWTy43mGQBgSiblrPR/QmuPiALKh/8PHg5p+ISgMff/wkYd68j6la
	LDJGIPcQlMeXeLavUA+ug0Wme2u0YxQIr51QpAvnDm1X5tBnqhsOfCm2dFYjqmGBCqY5OV
	HUSmVxtRLjdsGCk5Tobu3f1NqlQ8t/TWA84R3iaNVOBrmQlEMso9r26dloJ6w1INlAllgO
	Le0P4kJCayp6tbrCyA0DTam5ErAUVOjyJUCzSATTnDBTe7FsklGvuB/qrEBlFQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xQ9tT-003EmJ-2J;
	Sun, 08 Nov 2026 21:53:39 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5FB165E3E72;
	Sun, 08 Nov 2026 20:47:37 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 08 Nov 2026 21:47:23 +0100
Subject: [PATCH can-next v5 2/6] can: gs_usb: gs_can_start_xmit(): don't
 leak uninitialized memory over USB
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
Message-Id: <20261108-gs_usb-fixes-v5-2-d52dd4940d46@pengutronix.de>
References: <20261108-gs_usb-fixes-v5-0-d52dd4940d46@pengutronix.de>
In-Reply-To: <20261108-gs_usb-fixes-v5-0-d52dd4940d46@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=1117; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=a6NuAStUzeESNtc4MicggnAylqn/ya4PCoKR3IoI5fU=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj6cP+xwjqmm7xBRipVrB4vDX3XO8XVPOK+manOc+3vP
 qOtVRLzOkpZGMS4GGTFFFmW/jihKBDoUNr7MmESzBxWJpAhDFycAjCRb+sZ/gexOTeUVly8kvbO
 hLHM12Xm6ZnS/6q+OvyQvJca6rR9YiTDP3W9xnk+Qa9P+QteO2p3wP7Z75ijQReCH/8IOT7V+Yj
 NBgYA
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
index cac4ce323a1d..aa90cc58f28b 100644
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

