Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792624312;
	b=xJePa1W+6EoT3ws2XTCwL0aoZMYIidWYgzTHp9Ivl/cdflABmgOfjN2t6k9yDmocJY9h
	 AteQogcR0ZubaTLnNwnr3Df5ZGLjqrrmxRj4WatByXqG95ITPLQdwxIIXqA0uONSGqUUa
	 2NAeuZE00tedxp+Yg/AfvC6AF0KKfkyTpz1cdY8lrDvdWN0VLnk1+wKuKvecuXxZxFRCH
	 4JATNXCwA2ETxvusHd0GNNFM99gbamuG+EgK8N8JJcIG+1eLpo7+dpLsv5yfMC1WQccP1
	 wcMOnjISJMmmpBqzqvs0vCKJRIrHb+LgTPYdudGz8cb+F7cYd9Y0zGua+Ou+oYQRQ4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792624312;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eALao68/H5C/VsMyz1IjAZA3Cs8TeVJx3ISpy1cycgI=;
	b=QrVdW993wezF0iCCUuyo1WtcqYJuaKOVwjuGTVYwT5BqmteSlfjK6yVhripwKMdrSVqi
	 xPNJorF6ZzxXcSZg0t4ovTKYq28URjzgftBmiHHLmHaofFXzHnwRfmPfTVEKK2qXScbN/
	 uykrak8f6L61hXc9P0dkAssjN4Yi+qXBb9mlRKSCOdw1MxgUgaKBt6hOOvyzKv9tX3Pva
	 1RzPZ5lgFF6Iwd72Kft+g+6rXJFiGy4X8C4T+HF2c4uqO2jIdkLWqsB+RJCr5QVWgHqJP
	 NrsbZKGtNMyfqL/Ja/agM92UTXjz3p7kxpr6MmtjMXg7k3lrVjJV2yKttX9TCkYxW6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE4E606A33B;
	Wed, 21 Oct 2026 23:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EE4E606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B80FE201E09;
	Thu, 22 Oct 2026 01:11:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792624295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eALao68/H5C/VsMyz1IjAZA3Cs8TeVJx3ISpy1cycgI=;
	b=KSyvJjD5T5vJ7kJThO4mrcf+SY9jKViZ+zWOpBSuYWGZ94mNZAdCBH74t1+VyIw1HZ0zFM
	WUHvIfEjcMJyeierhuZ9Ml84KTqiDLGxAUlm2YVllvgRv+/bd+5ifGYyR1fjwXKbfl32hG
	rkOgZm0bWi0JtSozqaxE6v/b0ZHtzWUQxJUyJ/9LR5Dqwu0Ly09W95LiClnl8O4gCH7hcb
	9/GRHRtCzCy/GCjcfyxTpt3znxB6byxcmH35i4pd61aFHkKZfF4hI9ww46LgWHC2j4wfw4
	r4EYVUPUUr8O9L84TKCu3KHGakCyDyo3dGzxRpBheuo2SODWNjWOoPw2kRgLEw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792624295; a=rsa-sha256;
	cv=none;
	b=C1PR7XTDY4K9O0FMZ7bpmWtmQGGY+vHwjRSTcECPOlMFEci6VfH+KbTpxcCg5n+AO0VEhF
	lAEjlEsaLJ7T1m7PPaQVTbQkXpvL4vUHXwp0hx/8WgxjqlSeH0qvhj/4VCTZnYyHY79/qq
	v6M4tqscCDYY+jBwo0iLak0y7x5D2xddCuu1r/JGH1imGc30t/E8BuLMVD4wCXKQXPfeVB
	0MKHsTbazhm84ycRdaS0/CQCyon4/Ajiilm2C2jI+jbBRZ7MRZbYRxv6vtQFAUdyqaojjP
	eAR2+OP8vxzxe8MboSOlzwkUWFAbDcF47P6IBfJ3i3ExrVco2hwIK2YQSzafXQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792624295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eALao68/H5C/VsMyz1IjAZA3Cs8TeVJx3ISpy1cycgI=;
	b=QlSl5yWgIbNQWc8/Sr6YpViUHL25RORVNR9HsRQ71AiI3io84MSPZs1oDxTbI5uwDrAFD3
	8LCIJgbSswtSJ1C+6grOwHcUSqtMgd1WAfnpPdnddEFISDmMz+S6mMlBfOlIG4js6EHsYW
	thCD87u3PD9IyuOm3JxQz1SMUQGZw7Sth8hC5gxumRw2fxCzs+RFMQ1X4pqQhqO9wfla2N
	qvJLANJ3n4nsUg7tCV/+sUHMO0YD21YBIoF3ozHtcC9O34wFSBUmCu/dxyL9IN+8+g0C3h
	9xAz3iJVho6SK18jk2Z36eiCKeh74tnqncYytDRxSf6AWnqQomD15yEP6RfvaQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJfT5-000cWK-22;
	Thu, 22 Oct 2026 01:11:35 +0200
Received: from blackshift.org (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E4BC55D06DA;
	Wed, 21 Oct 2026 23:11:34 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Kaixuan Li <kaixuanli0131@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Quchaosheng <quchaosheng000406@163.com>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 05/11] can: isotp: check the frame type, not just the length
Date: Thu, 22 Oct 2026 01:07:52 +0200
Message-ID: <20261021231130.2085690-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021231130.2085690-1-mkl@pengutronix.de>
References: <20261021231130.2085690-1-mkl@pengutronix.de>
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

From: Kaixuan Li <kaixuanli0131@gmail.com>

isotp_rcv() separates Classic CAN from CAN FD by skb->len alone:

	if (skb->len != so->ll.mtu)
		return;

	cf = (struct canfd_frame *)skb->data;

A CAN XL frame with cxl->len 4 is CAN_MTU bytes, so it passes, and is then
read as a canfd_frame whose len comes out of canxl_frame.flags: at least
0x80.

Of the paths that follow, only the flow control one uses that length
without bounding it first, so check_pad() walks to 255 over a 16-byte
frame and the caller reports EBADMSG on an unrelated socket.

bcm_rx_handler(), j1939_can_recv(), can_can_gw_rcv() and raw_rcv() check
the frame type here, and can_dropped_invalid_skb() switches on
skb->protocol on the transmit side. isotp_rcv() is the gap.

Fixes: fb08cba12b52 ("can: canxl: update CAN infrastructure for CAN XL frames")
Signed-off-by: Kaixuan Li <kaixuanli0131@gmail.com>
Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Reviewed-by: Quchaosheng <quchaosheng000406@163.com>
Link: https://patch.msgid.link/20260920035626.2581040-1-kaixuanli0131@gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/isotp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index f5dc9d04bd68..d3e43ab48425 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -755,6 +755,14 @@ static void isotp_rcv(struct sk_buff *skb, void *data)
 	if (skb->len != so->ll.mtu)
 		return;
 
+	/* check for correct CAN CC/FD frame content */
+	if (so->ll.mtu == CAN_MTU) {
+		if (!can_is_can_skb(skb))
+			return;
+	} else if (!can_is_canfd_skb(skb)) {
+		return;
+	}
+
 	cf = (struct canfd_frame *)skb->data;
 
 	/* if enabled: check reception of my configured extended address */
-- 
2.53.0

