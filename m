Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794953350;
	b=a1e7cXwovrfIdweTYT0zdR4DjjxbK6fUgKJCZFfP5/aRzviuSZr5ztE5RxsdAEzkB46m
	 TfAHlS6pIJVO6/HP1fzimaNzDgD8kTqRZBWe48k+af9l1O853HFD1IEWiiIFNESjE0e3P
	 d7ssXaabN3mo5XJb1QcnZf7j7zpy0okulmylnYYQWmVAKZla7NQXaWEBDa7JYacdva0uO
	 t20KOILVcQR2liJ+ToKvYOU+7FhXiyM2MXgudum/C/9t8TRDx2FeP0iDu3bJkGuQvjStl
	 Hx2H+od1NnWZiGZ9yQ+EULuamdwCCMYeHpkMkQHsNJvwLV5Q3KqTrWNNZu5hAwEKMXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953350;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JR03lNHA+XAibQ2kHelS62vmj403ExKe9e8Eaj9RGz4=;
	b=mz5ktk0jNPieHG7kALsNZncWPRu4aC6QgUeEWDiPZkPO1TnLqZD+GLFlmPQhReuChsJO
	 jmkr7dPzjXNc58SqVK1mIE1MlwUO/uprOp+QKmNxNRPb/daCBs+HsuK0/Id48wW/F3QsW
	 uaz9i2LgiWX9PTo0ksiXpagDzUUKw50t1X+tcTBvCnQxNYSg75bxrCvfsBJRxQH8yF74T
	 sQ5RXckR+tdz0JzPDNwPg4KirNEv+0GVpD44zGXybUsQxrPNuo6V/ksP8jHBBUc9+OwN8
	 vvgdiuLW5Lnqam3CuByDIUbswjDoa+oDsIKYuKbZ5/xaeEVdopWd4ZUv2ymyY8XCiSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NpXwdmK8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7DF606A32A;
	Tue, 17 Nov 2026 22:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E7DF606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NpXwdmK8
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D1B0E205A36;
	Tue, 17 Nov 2026 23:09:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794953344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JR03lNHA+XAibQ2kHelS62vmj403ExKe9e8Eaj9RGz4=;
	b=NpXwdmK8VQpYh6jWMZB/YU9KV0v3I0Sl/YVEbkCrnHElUtoRibMebxdqB3ToZn+PNHOBL8
	uUbUbOhE7YEOa4/VEuDmTVExnbGHYW0XIP/3KDLcRyHVytF2AqHt000j4xlk7pAkRLakA0
	VITxUduwp5l399yWdQUNgDnpc10hLdOi/n8MGUgSdPx/3ky0LfA6AB588tHJ62oZsTepM1
	Ah1mtlosVMf1JU0SPXuYzZXua4OLjXIpVvmdOdb6CiGBKqg/LSl5weQZ2In3H0l4Is14Dj
	P78cbSbkxDPjyqPisBDy+TQOnoxHy2TbVj8HWm0jWTySgrFy2iUIj3p2fVtV0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794953344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JR03lNHA+XAibQ2kHelS62vmj403ExKe9e8Eaj9RGz4=;
	b=A/MBt9XrRtAoyZwHCgMUhDSCLoIaA3bUx17IUG+SYFQuZSSzDybpfDHFo+/LiG3CK5UkJa
	7Ifa/jd+MqJ6V0cJBOMz9BHhZp9tNLq7quLsDLYffMJrDG7xnBsvRFYenFWhLAaFD0pqqi
	5dE7wS3F6Jv+IqAoePoftaJJ7zPsMwUQnLPgbbxtVutL8Tv88I8uvPU5ib4Kujc7YEMgVg
	9uB/PUHv+OFIx6W5Hj7t7h+n9KFKBgDlp+AdgwLu66JfdZs+q3FWoXUPZKMMScRv4zDNJw
	K7DcVaJQwSUag6WeC9Yi/zEpGSn2F4VXSlGy7dSFdoH7AjfboBwQGeUIm2fC0w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794953344; a=rsa-sha256;
	cv=none;
	b=L1qUL/UteuQ7+WDqI4sRQbGttQYJHw4xeRl9O3dXl3E2w89D1Mct2OTp30faT05MWa/eZF
	BCkKYCUYgeYwua9vk8DV/5TgCA9dhesF2cQyoP170FY5B1DuV8ERDG9xlNm6lzZB4TPLYr
	QiszurHcR2kha1Bdi8SJHDOdNb7sLXsRSt/AkPvuQTevGFwtw8CuNHFhk/UwF4otlg77Ek
	1NC1kX6HROlcj8AdKkFX/cFVytiU8ichqtgZBQRz3CDvYVlXO6a5wAQmh7AF+m29EJMKuD
	roo7PDo2xLHXp9Kv4FOUYVfTZ9PQrcpVBlHpqGq/9fU+UURkkm1lMoi+Ltchlg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xTRMO-000Fmf-0i;
	Tue, 17 Nov 2026 23:09:04 +0100
Received: from blackshift.org (unknown [192.145.8.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3037D5EDA29;
	Tue, 17 Nov 2026 22:09:02 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	stable@vger.kernel.org,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Zhu Ling <zhuling0805@qq.com>
Subject: [PATCH net 06/11] can: isotp: always start the rx timeout in ISOTP_WAIT_DATA state
Date: Tue, 17 Nov 2026 23:03:11 +0100
Message-ID: <20261117220818.1142581-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117220818.1142581-1-mkl@pengutronix.de>
References: <20261117220818.1142581-1-mkl@pengutronix.de>
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

From: Oliver Hartkopp <socketcan@hartkopp.net>

The rx timeout is only started at the end of isotp_send_fc() and for
consecutive frames inside a block in isotp_rcv_cf(). So so->rx.state
can stay in ISOTP_WAIT_DATA without a running rx timeout:

- isotp_send_fc() returns early, when it can not allocate the skb or
  does not find the CAN device anymore
- isotp_rcv_ff() does not send a flow control frame in listen mode
- isotp_rcv_cf() has stopped the rx timeout and does not restart it at
  the end of a block, when the flow control frame is not sent

On a bound socket the next first frame or single frame resets the
state. But when the CAN device has been removed, no further CAN frame
is received and so->rx.state remains in ISOTP_WAIT_DATA. isotp_bind()
then rejects a new binding with -EAGAIN until the socket is closed.

Start the rx timeout in isotp_rcv_ff() and isotp_rcv_cf() whenever the
reception continues in ISOTP_WAIT_DATA state, before a flow control
frame is sent. isotp_send_fc() restarts the rx timeout as before. All
this runs under so->rx_lock, so the order of the rx timeout start and
the transmission of the flow control frame does not matter.

In listen mode a first frame that is not followed by consecutive
frames now leads to ETIMEDOUT, like a missing consecutive frame inside
a block already does. So a listening socket reports a missing
consecutive frame consistently, independent of its position in the
PDU.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20261117-can-bcmlock-memcg-v6-6-6826a6227d36@hartkopp.net
Cc: Vincent Mailhol <mailhol@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Zhu Ling <zhuling0805@qq.com>
Cc: linux-can@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/isotp.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 8229b6a69ecd..0293d590186c 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -634,6 +634,10 @@ static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
 	so->rx.sn = 1;
 	WRITE_ONCE(so->rx.state, ISOTP_WAIT_DATA);
 
+	/* start rx timeout, isotp_send_fc() restarts it */
+	hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
+		      HRTIMER_MODE_REL_SOFT);
+
 	/* no creation of flow control frames */
 	if (so->opt.flags & CAN_ISOTP_LISTEN_MODE)
 		return 0;
@@ -726,13 +730,13 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 		return 0;
 	}
 
+	/* start rx timeout, isotp_send_fc() restarts it */
+	hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
+		      HRTIMER_MODE_REL_SOFT);
+
 	/* perform blocksize handling, if enabled */
-	if (!so->rxfc.bs || ++so->rx.bs < so->rxfc.bs) {
-		/* start rx timeout watchdog */
-		hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
-			      HRTIMER_MODE_REL_SOFT);
+	if (!so->rxfc.bs || ++so->rx.bs < so->rxfc.bs)
 		return 0;
-	}
 
 	/* no creation of flow control frames */
 	if (so->opt.flags & CAN_ISOTP_LISTEN_MODE)
-- 
2.53.0

