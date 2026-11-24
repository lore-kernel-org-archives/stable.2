Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795510689;
	b=Mu/DMtQuW73LscXhZ8yGOEtp4nqi9F1rqGCXorbdvFWm75fE9I00zrVDZaxQz0HLRaac
	 0CJHsO1rnoXkeeudnMXcAv5LA1S00zI/oPs/RjD7In9G3EvdQ62T5sVOxn+Gh3aTuLsJ2
	 4qLfEzSbNnZu7Nsu/WigoAlALssFSrV5XsjegmM25lMzrV1EFAL2MYgbkEEhe6gYvVfdZ
	 CQhPGFApIsGvWNQs4p/2Def/OuCEJ1VDtEqaGEhe0vQ0ofpLfAZTbAZcwlFGYdWlmDx0A
	 ROprzriDpDLM1J7QOAmvOuXSPpMYgcjDbgufv07uC8LeBiZykx7GtPDg+54Lu6AyG6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510689;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1yOSFFH/0TasklYpw+j1hzQeQIP5cWPqmoN+6l0x1HM=;
	b=EBv5Kg6dzE/fQXHu4QEgj/1z3UBs4Xxm9ir77Rmid3lptUuAec+edmGd/WV6eUmyp4zn
	 xM0EDHtWa0C5bKK6G+gh5fbVy1rMtsD9L6I+06oKFI9UaVWnPKbHP2OjjM4dk3GOsIwVf
	 8aHeZ7foEa5rYLZiV4RyXfed5wis5euotHVGhDq+Gt1v2zpbTK9hs4jt2RMWHzyPrV76r
	 nkuTvSg8jy0YmPEO8tU3Rb+vcZyizx1HUkXw/T5IAOSkc4CICNMDGXgUrXS7qifqdthzn
	 o8D8MZJdvLylzZpb5DcOHgENr5UJ5N/WOEaSCjoR37akJDvYi/MjCAd/ymrxlQ1aMtw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=aJTN9D0N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E822A606A6BA;
	Tue, 24 Nov 2026 08:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E822A606A6BA
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=aJTN9D0N
Received: from pengutronix.de (p20030102af17cb00d2e697ee776c6466.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:d2e6:97ee:776c:6466])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 67E10205A24;
	Tue, 24 Nov 2026 09:58:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1yOSFFH/0TasklYpw+j1hzQeQIP5cWPqmoN+6l0x1HM=;
	b=aJTN9D0NECev+A/fRH0q1p8f4Vkv5u6A0qm/47pq3dE1XCA4bB0c9tXrKr1u2j/RYBoOgf
	H01C66cJoPvF+EJND9OwKijpDiWGnGfsIaFL47yCYmiKnU3es1he57tXlkk88XxQnoAnPw
	EIE/fTYxALrr4YrshGdqTuY/PpcS1dP3T3RItJreM9xWZ/NbWIqeN3AHX1U7QBggY5Zpq5
	iX2PXU/GNKoPlN5YSUTazlqOka4ueOaZasPbGhBMRd26UjJtqoghRhQ2RDJzEqURe1qzxv
	EnKIYgN9PuNSlNNlEzzvFfIMLgBTekoBp/nrny3tXMSKU+nI6Af+n6f1wLgnEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1yOSFFH/0TasklYpw+j1hzQeQIP5cWPqmoN+6l0x1HM=;
	b=YyIRSG4CBBpbRP0wbwz8uUirN1CmG+p/PMokD+11Dwyu2a3cjZ19ZEwy0txVX1JT1x1cKN
	4Y40LM9T19veO6kN/Q/8e+KXwdU9meHpxD3Wmh4HMBEHC6MBDb2jicqOU3jNIkaTE1MNaf
	mIm9vSb1MC3E3H+ruWHoCzJDfGGJ77cS7FsnV5goznjAkTxd8SiK5kRPUqtPwft+Otk+Iu
	ClmWW5rVn6j1Bx5qE2CCk7kw2lzPJwf9ULTa3ikw/e45vDgsMJAHIGpgqTwtO+/b14wMBt
	ia1f6IQZ7BUnAUw8kb03sXoL7BVAkZwVwQ8M3HGsKz3h1QsFNcmlbUtsKWHEGw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795510686; a=rsa-sha256;
	cv=none;
	b=BrR8foKGYbWur0aiINTGbOWJjQD8I2FPN3woIDFvirKD0NOusT9fnEDsT7AFkBwG4pI30O
	oXC8N1XkRBnDFjfEXwBfYbDtECDBMjxEBQlR1LqxSxJrVqlYIXWNWe3J7i96b9oAWXJSWo
	qttXqfR9SUdGqVcsh/7WxyIO7QKF3MLiUvdJUBlbwivnCt4wZC9g8XWAmvIM6NwCjAWFrq
	H+9io7N9UPowlaSoloxlcTtU670+kRfFmpjC9SOkVk6JCY9l/Tn+g+4VeQKs1Gm83HX8vB
	uw0q9tBI6iNiaIJwRWeAX5koRHJS6lr27vJOC9Jh2rwsfB7m84tk0Emq1Kfvcg==
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 07/12] can: isotp: reject socket options while a transfer is active
Date: Tue, 24 Nov 2026 09:51:34 +0100
Message-ID: <20261124085757.1093632-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124085757.1093632-1-mkl@pengutronix.de>
References: <20261124085757.1093632-1-mkl@pengutronix.de>
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

isotp_setsockopt_locked() only checks so->bound before it changes the
CAN_ISOTP socket options. When the bound CAN device is unregistered,
isotp_notify() clears so->bound, but a transmission or reception that
is already in progress is not stopped and may still be draining.

isotp_sendmsg() claims so->tx.state and rechecks so->bound. After that
it can block in sock_alloc_send_skb(), while the device is unregistered
and so->bound is cleared. A concurrent setsockopt() can then change
so->opt, so->ll and so->tx.ll_dl, before isotp_sendmsg() reads so->ll.mtu
and so->tx.ll_dl again to build the CAN frame for the skb that has been
allocated with the former so->ll.mtu.

isotp_bind() already rejects a new binding while so->tx.state or
so->rx.state are not ISOTP_IDLE for the same reason. Add this check to
isotp_setsockopt_locked() and return -EAGAIN, so the socket options can
only be changed when no transfer is active. As the transmission and
the reception always end by their timeouts at the latest, this state
is only temporary.

isotp_sendmsg() reads the CAN_ISOTP_EXTEND_ADDR and
CAN_ISOTP_WAIT_TX_DONE flags at its beginning, before the transfer is
claimed. Read them after the claim and the so->bound recheck instead,
so that all socket options used by isotp_sendmsg() are covered by this
check.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-d1d3ef49-c24e-4f3a-91ce-20f8fb222684
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20261120-can-bcmlock-memcg-v7-7-f6b84f5257b1@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/isotp.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 0b7db1ead7a9..642fec500af9 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1128,8 +1128,8 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	struct can_skb_ext *csx;
 	struct net_device *dev;
 	struct canfd_frame *cf;
-	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
-	int wait_tx_done = (so->opt.flags & CAN_ISOTP_WAIT_TX_DONE) ? 1 : 0;
+	int ae;
+	int wait_tx_done;
 	s64 hrtimer_sec = ISOTP_ECHO_TIMEOUT;
 	struct hrtimer *tx_hrt = &so->echotimer;
 	u32 new_state = ISOTP_SENDING;
@@ -1188,6 +1188,10 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		goto err_out_drop;
 	}
 
+	/* read the options after the claim of the transfer */
+	ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
+	wait_tx_done = (so->opt.flags & CAN_ISOTP_WAIT_TX_DONE) ? 1 : 0;
+
 	/* PDU size > default => try max_pdu_size */
 	if (size > so->tx.buflen && so->tx.buflen < max_pdu_size) {
 		u8 *newbuf = kmalloc(max_pdu_size, GFP_KERNEL);
@@ -1726,6 +1730,14 @@ static int isotp_setsockopt_locked(struct socket *sock, int optname,
 	if (so->bound)
 		return -EISCONN;
 
+	/* A transmission or reception that outlived a previous binding
+	 * (unbound by NETDEV_UNREGISTER) may still be draining and uses the
+	 * socket options, see isotp_bind().
+	 */
+	if (READ_ONCE(so->tx.state) != ISOTP_IDLE ||
+	    READ_ONCE(so->rx.state) != ISOTP_IDLE)
+		return -EAGAIN;
+
 	switch (optname) {
 	case CAN_ISOTP_OPTS:
 		memcpy(&so->opt, val, sizeof(so->opt));
-- 
2.53.0

