Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D391E388E7A;
	Thu, 15 Oct 2026 01:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029233; cv=pass; b=oHTxUanHS8MWGEV4IaIdHto6A5BRa8FGyq52j8RtxjceJpNJry5Vm98iCVcDTAq1X6zVQFG6p2kvOFdo4zDpzq0RkSXg6KmrEY7o4rsfoe23J4Ru8Ef405+BcSRVubmhOA89jJgx9svTduEEJNsxSSN7aNy24WrfzTVuscU5X68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029233; c=relaxed/simple;
	bh=BESL33sk3k1xclMOoMRpgLNVC45Kv63CRKha9knGykw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzvcWbdYza7bRFJptZ6sWe5EBc+LHuAQGrDWIN/SNbGe7FMPS79fYfu8KyW2BV9mTshmuT+UwiwNV9ydEctj01ASyESCSqA/LgOJEE50ApHRF0NwIl4GRGzoTXK7NEfzmiMeYAdIOfu+Nmp7b/jjdcyiNUe0123isqseTOS3zHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=d4rz1260; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="d4rz1260"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 526A82027E7;
	Thu, 15 Oct 2026 03:53:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6G+/AuoMi7sn+vQXqcaOUcrwvr1jRSmQH82PqRnpUv0=;
	b=d4rz12605r0GqE/0GQf+qXdTB3X6ARWtU5z0iDmTd0tyCYbSC1g1Z20mXmkst3lZ8g0NqY
	cnY5Fs+efNkot3tSYzwZMDuwrNwxAS3U3M4KHinwUJ8lfYNBfF5ZRrfzKQJn/mvlqVbSXf
	XA15n0shXB+CkixGVegkUlFWbP4bBb+eJedkqXpRsPcvzcL4DMaIOBtT9L6r1025JLJGTG
	gUYC/LD7wP8j2qvdQ6HQBvhjCjCpDiuNeguoYQYH9R3mr8h/DS9AeovA4QJzWGYwNzicAW
	uZO4RY4GenI4g4HeiULv783hTCTTpESAt4UwxaLftqt4xjh2hPhkKp6m1E0Qbw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029222; a=rsa-sha256;
	cv=none;
	b=MyRXi8IgT24TJjzRyJtL+1wZX3m/sfpCV5CB5VrmoCFzYqrAKn6+3W8WpCp79onmsX+sHP
	n+78c1dQ0CNFLl5dnsqmKBHsTB3i/dudGaWUryoVYYRL/Lei+Uzs+NkE+hqSplJBWadQzR
	yN1TNzYGT/dKNXKJ6yGblTzUHj2bYbYKLolb4MCFJiBEOkl2tpVOPWveG7+xcR96dOj+bH
	jQj5UjlQ+0iKhmZSK40wCaqQEiwhL3QyrQRL77NO2iiPMwV6lIftVZmgoGlwUnZGoiNxjJ
	q2Tz3J3eSbEDjq0gX9Ney5Jh5FSqwYi06P3k06bHlaD4RRJ700n7uifbke3ICg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6G+/AuoMi7sn+vQXqcaOUcrwvr1jRSmQH82PqRnpUv0=;
	b=aU1nYQd64mYp/EXcG2048ci/6lvVxfsq1ZnRQMAzXP097KzarXhFO9U7xOa6yywGm+trZl
	ScTpIKNlWCWRcEljo19gQIyrbVQuhlPtadaOXXGgFR74JKW9CQqrV9oMItIjU6GEEOVU8C
	8jmx7hArQ2V8rvfN6uSGoKS8ONwh0c3GKe/k1lyN5tiJurt+lNTSsXuVC1zhsnGZfhQ+RN
	juc+9ATs1hBi+T6AGhpURlW1Cy3ZyzexpkJjhwCFRvqIAhwg63m388f6QUxD5cgncIy6rJ
	7C4qb0N6s6E9jrwc3nWrmBk59DwS6XxcapQ8qq3gGzLQWtO6u0kgmzzLoQps6Q==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf8-005wrW-0j;
	Thu, 15 Oct 2026 03:53:42 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EAAFF5C47AB;
	Thu, 15 Oct 2026 01:53:41 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH net-next 29/37] can: esd: acc_start_xmit(): avoid use-after-free of skb after can_put_echo_skb()
Date: Thu, 15 Oct 2026 03:40:27 +0200
Message-ID: <20261015015336.816543-30-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015015336.816543-1-mkl@pengutronix.de>
References: <20261015015336.816543-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the call to can_put_echo_skb() in acc_start_xmit() the skb is invalid
and not accessed anymore, but acc_txq_put() will access the skb's data.

So far acc_txq_put() first loads the CAN data into the controller then
starts the TX. Move the start-TX functionality into the acc_txq_start()
function.

In acc_start_xmit(), first load the data into the controller using
acc_txq_put(), then can_put_echo_skb() and finally start the TX with
acc_txq_start().

Link: https://patch.msgid.link/20260929-esd-fix-skb-deref-v2-1-542e3e19fb25@pengutronix.de
Fixes: 9721866f07e1 ("can: esd: add support for esd GmbH PCIe/402 CAN interface family")
Cc: stable@vger.kernel.org
[mkl: update subject + commit message]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/esd/esdacc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/esd/esdacc.c b/drivers/net/can/esd/esdacc.c
index 73e66f9a3781..05d41ed34a02 100644
--- a/drivers/net/can/esd/esdacc.c
+++ b/drivers/net/can/esd/esdacc.c
@@ -62,14 +62,17 @@ static void acc_resetmode_leave(struct acc_core *core)
 	acc_resetmode_entered(core);
 }
 
-static void acc_txq_put(struct acc_core *core, u32 acc_id, u32 acc_dlc,
-			const void *data)
+static void acc_txq_put(struct acc_core *core, u32 acc_dlc, const void *data)
 {
 	acc_write32_noswap(core, ACC_CORE_OF_TXFIFO_DATA_1,
 			   *((const u32 *)(data + 4)));
 	acc_write32_noswap(core, ACC_CORE_OF_TXFIFO_DATA_0,
 			   *((const u32 *)data));
 	acc_write32(core, ACC_CORE_OF_TXFIFO_DLC, acc_dlc);
+}
+
+static void acc_txq_start(struct acc_core *core, u32 acc_id)
+{
 	/* CAN id must be written at last. This write starts TX. */
 	acc_write32(core, ACC_CORE_OF_TXFIFO_ID, acc_id);
 }
@@ -287,11 +290,12 @@ netdev_tx_t acc_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 		acc_id = cf->can_id & CAN_SFF_MASK;
 	}
 
-	can_put_echo_skb(skb, netdev, core->tx_fifo_head, 0);
+	acc_txq_put(core, acc_dlc, cf->data);
 
+	can_put_echo_skb(skb, netdev, core->tx_fifo_head, 0);
 	core->tx_fifo_head = acc_tx_fifo_next(core, tx_fifo_head);
 
-	acc_txq_put(core, acc_id, acc_dlc, cf->data);
+	acc_txq_start(core, acc_id);
 
 	return NETDEV_TX_OK;
 }
-- 
2.53.0

