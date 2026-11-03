Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793738604;
	b=RlDMGdzZbfRalxfjxcfvqqrRXOqyv7Bvp6/ncddRubDgCHzACumhAJk441b5BzvO5+wB
	 /FSKP1aMXjJw1ThFCriDBJdf25z5mPkN7Kf1iXU+/ejRcYhQMykE+a70xgifnVIBfnxIS
	 BpJpOL4UlfgBdgH6QL2nnoUQg1QNTPsTjH3Wh1bQQoPKP4sFrAlJf4wNoNMeM1N4+2cug
	 WwKVV3jQznN3NchMjR3INoNFpxxtM8y3gSiZH6q8AQsqTnPNCpKib18qbjift7nvWFN9v
	 jEoedZ3CrTuWnci9GAK13H+iD+qMv/6P1NIMDDy8EJu4rVvkhevyhyUdfw4UOFPab7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738604;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iXBDFNkgLi1OBwy3Jvp2GyEuECCn6BuOzEhmZb+Xr6E=;
	b=C/RRriTlRVQbq2PZxg3abzofIlsQTBzBEe0hqAUKrMawjOEnpEAiC5q6Q38s/uB+Fl8J
	 13/5ZrusappRWKTUfkdy8NdKbCzcY/nzVzRttszfQRSbOfSAMD1RzHijuXQWukNtpiufU
	 6SkC7at9FTSUYdrej6VmvVxek9KkY5PMpKwFjKM8EYS4uK6NJGi42zG+clgshlZJBDBGp
	 x+obpOjtr5X3IGWyvv1skc2zp0ni8GFTDkzji8t2JffCmMYO1U34xr6G23h24g01QEIns
	 BCP1hrDYKBK/iKVPVMqf1vIOOIbnk13BjYu3K2ZaKMmVS+Sa61Xe6TBEOOcJaGJfNQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="cj0/m3bM";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02328606A338;
	Tue,  3 Nov 2026 20:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02328606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=cj0/m3bM
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4884820282F;
	Tue, 03 Nov 2026 21:43:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793738598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXBDFNkgLi1OBwy3Jvp2GyEuECCn6BuOzEhmZb+Xr6E=;
	b=cj0/m3bMIxcN0RDXdgnlSuOgFKmFEcDH2Y2Rj+AoymUu+YxRihFJrrVcURWCCQzv9xJ1YR
	6h+SK1yi8KvllXyTdU9O939vJv2z2AhogiobjsSeU5BKvKL4O3f6UUdsU9LyHx92tkhoxC
	EnbK0e2rEsslcj8TJ94l/Tr9kfux8hcPb/l/S+iQE9x9iiLI8CzOJuP9xaOym0+xlx706k
	O2GBkREGdy5chV5tO83u6tEMhgELIGg93dK/cwybWv3SLifCjFKApeEsV3McTguOfj0jGv
	7Udp0HcChqU46DSeRlIDj4d4AuF/oxhD/hbFjUmXLdVUAJv1/vuGQ1vnOBw6OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793738598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXBDFNkgLi1OBwy3Jvp2GyEuECCn6BuOzEhmZb+Xr6E=;
	b=N7MYOodlCwcAyIS7yOA2h/AnxenvvCUX1I2pXV4eqJUM2w4xtljoAKpaPrO2ljlnaysN7Y
	GU8841q2DgDgHKd12AqPiqCGSzKqhFjC6gyLejxUnhL7T1Vp8FcOTsYWkg2iKhVQgYmfBb
	Dyj74gjQ3+KAITzqZSEEh1U3Oz2cxtGB8jRGqUBBkG9PruEVMiKjDXhoBoYj2Lvd4NQBPl
	QewyjiLnULwi7pR5FcLVai8nFBTBcqCBfwBIC0UeX0kZtWuPkvgYgVnn8HeIGEA9dHjCeh
	gJGSif5ARqDeKTqhv6q4EHn2lbs5U6C85C8oQOqAJSlTbBHieYHfR0HTJztJog==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793738598; a=rsa-sha256;
	cv=none;
	b=Iah61Bhcea8TiHjyeOORhBmquUIP84wxq/qMJPHoJJQhNRas8QTCKmdFMqImsc0QPihbKs
	R41WzbRNFaxHAmJ+keC/YF15xf5IGBK1R5ViFpeGUGxguIDmEB8STkWhKcDPZruEr++tol
	snXIHDYk1H02djnxK6AdaufmxqVyUhoajnOGEtgLcm6RrlLNU7ZkuaY3qnMmDazoS6FBQ+
	4dyb+ctSa0J8mvIUyB+2ZOmnOutdz+nh4cpDdLmMbQWGAGS3jaYYRlaIud8se8673ixAfW
	LSrILS049FZTZhQlIllXLGBOQBpYr+Pnrr9mbb1ZnE98Drfzy95nXTTlsqMY4w==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xOLLi-002V8b-0Z;
	Tue, 03 Nov 2026 21:43:18 +0100
Received: from blackshift.org (unknown [IPv6:2a00:20:73c1:227f:2cd5:5d72:938f:f03c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0102A5DDEC0;
	Tue, 03 Nov 2026 20:43:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 07/15] can: isotp: check the return values of can_rx_register() in isotp_bind()
Date: Tue,  3 Nov 2026 21:30:28 +0100
Message-ID: <20261103204305.3211144-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103204305.3211144-1-mkl@pengutronix.de>
References: <20261103204305.3211144-1-mkl@pengutronix.de>
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

isotp_bind() ignores the return values of can_rx_register() for the RX
and the echo receiver and binds the socket anyway. When a receiver can
not be allocated, bind() succeeds without this receiver, so the socket
does not receive frames or its transmissions time out. isotp_release()
and isotp_notify() later try to remove the missing receiver, which
triggers the "receive list entry not found" warning in
can_rx_unregister().

As the device has been checked before and RTNL prevents a namespace
change during bind(), only -ENOMEM can be returned here.

Check the return values and register the RX receiver as the last step.
The echo receiver is registered first, as it only handles the socket's
own echo frames and does nothing while no transmission is in progress.
So a failed RX registration only needs to remove the echo receiver, and
isotp_rcv() has never processed a frame for this socket.

Set so->ifindex before the registrations, so that a First Frame received
before so->bound is set can be answered with a Flow Control frame and
the RX timeout is started as usual. As the RX receiver is registered
last, this can only happen for a bind() that succeeds. Reset so->ifindex
when bind() fails.

Check IFF_UP only after the receivers have been registered, so that a
bind() that fails on a down device does not report ENETDOWN. As bind()
holds RTNL, the device state can not change in between.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20261027-can-rx-lock-v12-2-eb5afc2d8b9b@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/isotp.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index e4957855829e..28e9d22772fa 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1550,7 +1550,6 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 	struct sock *sk = sock->sk;
 	struct isotp_sock *so = isotp_sk(sk);
 	struct net *net = sock_net(sk);
-	int ifindex;
 	struct net_device *dev;
 	canid_t tx_id = addr->can_addr.tp.tx_id;
 	canid_t rx_id = addr->can_addr.tp.rx_id;
@@ -1627,26 +1626,36 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 		err = -EINVAL;
 		goto out_put_dev;
 	}
-	if (!(dev->flags & IFF_UP))
-		notify_enetdown = 1;
 
-	ifindex = dev->ifindex;
-
-	if (isotp_register_rxid(so))
-		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
-				isotp_rcv, sk, "isotp", sk);
+	/* switch to new settings */
+	so->ifindex = dev->ifindex;
+	so->rxid = rx_id;
+	so->txid = tx_id;
 
 	/* no consecutive frame echo skb in flight */
 	WRITE_ONCE(so->cfecho, 0);
 
-	/* register for echo skb's */
-	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
-			isotp_rcv_echo, sk, "isotpe", sk);
+	/* register for echo skb's first (no echo traffic at this point) */
+	err = can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
+			      isotp_rcv_echo, sk, "isotpe", sk);
+	if (err)
+		goto out_put_dev;
+
+	if (isotp_register_rxid(so)) {
+		err = can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
+				      isotp_rcv, sk, "isotp", sk);
+		if (err) {
+			/* unregister echo skb subscription */
+			can_rx_unregister(net, dev, tx_id, SINGLE_MASK(tx_id),
+					  isotp_rcv_echo, sk);
+			goto out_put_dev;
+		}
+	}
+
+	/* report a down device only for a successful bind() */
+	if (!(dev->flags & IFF_UP))
+		notify_enetdown = 1;
 
-	/* switch to new settings */
-	so->ifindex = ifindex;
-	so->rxid = rx_id;
-	so->txid = tx_id;
 	so->bound = 1;
 
 	/* bind() ok -> hold a reference for so->dev so that isotp_release()
@@ -1657,6 +1666,9 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 	netdev_hold(so->dev, &so->dev_tracker, GFP_KERNEL);
 
 out_put_dev:
+	if (err)
+		so->ifindex = 0; /* reset on failed bind() */
+
 	/* remove potential reference from dev_get_by_index() */
 	dev_put(dev);
 out:
-- 
2.53.0

