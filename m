Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792957916;
	b=NSz1bnLADEPU0xLzSFiYHVREALF54ASumn0TZMJIziLADDNLxMEjxmN5Cd8cpmAM7hRR
	 j4xRN5UndDwvL5PC/dzm2CYiq/hdssYk+e+BPqHDTjLY+UtCKDNsktFxNuMQOHHDarj+r
	 JxtDFV6NwtJVvx9bwfchn2h3qVCuTBXQ05wjwR2G747ViZ+55z0qmCZFusGm52gpIi29v
	 OaN8bVOfaNpbVcedfCJ2fvjwg8HHrhO0Dq1QhfqWkaAgV9LYKoQGZnaL0plzo19dq7Xf8
	 6iom4tJro4EEgVBgyW9Y8Clv1HpArrZfyEUwjgBwM40oqgcpX5DGIXXApcdcuSyB3aQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792957916;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=gzqvCXUxAiBvbMROfVnJpVOaWr7Kd+9TvqdSl276L7w=;
	b=asX/QpMZQnQrM9ut6jEDkWLlz+WkG6rfGkYs3sTVhStECRTmPFgkJ7USjm1Wce+BRtaL
	 Jxl9ocn4lzaD0Ee4jKynOBWsxcBs2qq2OtYE5cN/0bV/O/N8WbZBX1nFOQU1CEMq2/7Qe
	 DMk42ZpZyfqogN1fAI5OKnDnNEQK/kaBIy3wMDB4pKMsyP5Jui5C1sXBewp/il2gDJyhG
	 lY7c6qhV4U5B0u9v5zAHDQGOKxHrXPSYK9/S9o6N5hZCZGVSyccJJ+CZTRS1pIJFy9079
	 sgFAAOyOcDFwNAVmxwVOApBj2YZseWXNVph15JrCGS0Jv6Le27fZUJXA//ovczldcXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=e+UaXVPq;
	arc=fail smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52FE606A31B;
	Sun, 25 Oct 2026 19:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A52FE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=e+UaXVPq
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id DB2D9201E0D;
	Sun, 25 Oct 2026 20:51:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792957912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gzqvCXUxAiBvbMROfVnJpVOaWr7Kd+9TvqdSl276L7w=;
	b=e+UaXVPqFiKQUlM60M5R2aZyVCabFa0zt7P3yPBdTvrQT/po5NwegvROGQrlj3XR4xyW6y
	thKioIo76axU1bzIkpO/+dozoVAbDh0KeOw/CpUnkGhzP1Udtf+4NUAEqWfJU/fvE9F2yM
	l9181PrqdQo2XLBnXgVaJ8i26FN8CzxPF7vTm+1dGhwoTM/kiwKCK1YFLlwdABWnAZ7NgR
	1iYah4CVWokN7fuTWgyHqoAewKi2z4uOV3q1wk+4FBmyWnKe1uuiZrPRVA24jj43Vkh4kA
	GZ6nuZ4jq+SdSKefiK8KqqiYtkrBJsKKb/9YgZPJGreS8X+V5YX6w9O0BRTIrw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792957912; a=rsa-sha256;
	cv=none;
	b=N5TbPRorPNfpF99yzD2IhPtJB8Wbqd708AfdOcN9RTcup92/veMemdGA3G1aPMwdVHTi8b
	HeOLyv4dA72RxXKLxBuRGuvA6pWU4tJ+cEqv6F3pEWzvicLMWyUBEhn5qkUWMlfwJh2brG
	+h7x3vNwH1+RB3WYUAosHAnvAfHXtyxi7nVJ0ohtmeVuX+CjRNu9HJaTRA4rnNxwn2CSmD
	/cqgUHdZ4SniAKpV56SjsNVN/NVn1RHSAlySlDucAC+JBwSK50WOXiVicf3cOp2+FlmHSa
	h0hPASh1CS3DLVwcYMzaCZZklS051L2+koy7ZbyFmCB49HUWkm6wYcAv8TLa0A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792957912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gzqvCXUxAiBvbMROfVnJpVOaWr7Kd+9TvqdSl276L7w=;
	b=CY7rWDla+al34Z6wELEdZMwXC4B+TJezJtPrU3IzT0eMcRb1Pga7B4QVFtbt9nWo92YU7/
	sWDZAj0xLoaPaaRWYGiijCQf38nShuK5POTRL/crrYQVz9l02CH8yrkjtWgreqN91cfCFF
	FiHfloG4nY8FsrCYQ3N2Y4UD7qEcW+oPsX2CcQAnAeSfnj0dGmJTf5qSPPt/IP5b9NAqWP
	V1LdMS7IKc3TtG/i0sr5oc8cJspBld1K0PwHrRUeEygV8dU6PNe/NZJaP1fZeEkbEsusUo
	bBoI/fMh0UEZtq/J/NS1tlJpDuj3GmH/LdfqIoLFWvNkSw379w2+qV6TIUR7Zg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xL4G0-001AwO-2V;
	Sun, 25 Oct 2026 20:51:52 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7FF105D41F4;
	Sun, 25 Oct 2026 19:51:52 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 25 Oct 2026 20:51:41 +0100
Subject: [PATCH v2 1/4] can: gs_usb: gs_can_start_xmit(): don't leak
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
Message-Id: <20261025-gs_usb-fixes-v2-1-535d45097f72@pengutronix.de>
References: <20261025-gs_usb-fixes-v2-0-535d45097f72@pengutronix.de>
In-Reply-To: <20261025-gs_usb-fixes-v2-0-535d45097f72@pengutronix.de>
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
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi6F3spg+O6SIj19iDlhpZZig8XnFNb5hceqVgTU1Fh/
 2kl2332jlIWBjEuBlkxRZalP04oCgQ6lPa+TJgEM4eVCWQIAxenAEzEyYThN9unjRuP2Sm4tV7W
 r1oTrH3VVOXz3vX3JnOJnd90btO0f7yMDBPTVgtMevCXb+3OqN2luxzfc81KvDDhVpjlj0SzJVM
 T/jECAA==
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

