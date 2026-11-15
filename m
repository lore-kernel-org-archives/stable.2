Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794736673;
	b=qwSiEdzDeHEx0ANMq+ny8akKVcvjE/6CL7fsLvw9xJAUYvCfyi3BNKJcU5OdgrjSqjNu
	 dbrgNT6dVdvlpKSqk3Y1nWScGbpLNYIfqSzTfJewVQSuGcxL7+yjGU/p7qAfCeosx26ZH
	 TeBqOXKrzyCNRUCJjEXipn0nEVGJmeWcwAH5agyF9W0g2dD2b7AuGXAKg0yxOt0laQFgU
	 qWL6jDnE7fZLldyVrNm8MOhhcgSoQwMFvXl+z60j6xg0pc30iiGQwOt+kYGd6O6DJTkly
	 FWm0nuzoNjpcptG0cSieknOFqgdD5aT+5dpd3AoLJHq4wrLbe6s7ddhRneye9L0yhOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794736673;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2nY/ayje3+JPnCx7z8WQFg6FuGXbG9QAAK0fBDATWBI=;
	b=pB3ajow3x+0cTIHJJeIuLoKdZlK+1Z/2fhhU2Cnqty5+tOw1XkIxgMtPZ8ZjW+69NBjY
	 4yR/jHQFS2x0szImEHL9cmhhJ/8t8O589Q9lAHoqnCw9PewqvuMShQpQJcBWbbyX2E2nX
	 kpeZgGjje29wUlMtrYjZ+6niQoseyHejTYTA5cby5CfTWSLl7mzki8Y3XkBjijMGqVu1g
	 /AgDGaRDN0ONoZAdw7E4RCPNqOVf15SJqS7hCaBY+byzuwpB32V5qMfNK5N8ugxYsxvAq
	 sHVlwhmuXd91yQs82AYWd/ozGDWswiuUxoDk7NFxjPtB0Gs3pgccNDggwwwKZIpjQRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=AQyovum+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69072606A329;
	Sun, 15 Nov 2026 09:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69072606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=AQyovum+
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 55CD2201E6E;
	Sun, 15 Nov 2026 10:57:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794736670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2nY/ayje3+JPnCx7z8WQFg6FuGXbG9QAAK0fBDATWBI=;
	b=AQyovum+9D21dgrW7E4RqmhFvZIX/zXdEfKaEw/SwH0WYV5qFvgZPfKy6tRSfznfjNzBme
	F/CoHstc/o0Xm04dfH9Z5A7bcTeUkUMWvNEM/C8saUxPv4OhwrHhCTDjNQUqA0hVj8Y/N5
	HI2qk0yqGbMBTr+bUuxZmTx9XW3IHy8l8tV+ivrp+5zrif6LDdL43CtF4s9jlt2TznLmTT
	DTclR8/XtmqGUDnodDR3/DyYh+lofQoSNK8UVaJT+DCjVlcIZoM19+cfbMggnaJzhjET7Q
	EdF3bug5hzjfxKMzTDVIG7QbvIvokdw/hYXpF5fmyF48beEXbqstaP136Omrkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794736670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2nY/ayje3+JPnCx7z8WQFg6FuGXbG9QAAK0fBDATWBI=;
	b=ZmFkz3Vmof08Tut+I5tBCDgTs+Enu6RdJmK4a8NIMpH+nrOuCc9GFH3UZqit5ItNih9Rso
	CblN3hjxTfQg4Eprvdl+RIjUv/Rlv1Z3gPNJJFJqHhCKoVm7u1O388Yr6bOT2gSRasQcCo
	dMuBsc/10VxDcnq4xnjB5YVEZl5WAu8yGlJLS3PIoiaZmfhxtNhuu+nUDw/KjF/ICb/jVN
	oN77un3jmghPklE3uFD82H+E3hu4etn0hR4kZb6KdcLH6NZmxaTFuPHcXE9yT50c9Jowij
	mklhTgJzeYxJE14nvCWPf2ZKx3vQ/16FEMHCFZ768p+y2cp96lz0Z1zQKVQB4Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794736670; a=rsa-sha256;
	cv=none;
	b=cu0xk3o/Q44suSLzrxq8LoPkpqP1Ur1fe5F1r8qMJPHVuNzuOjl4A8eu4JP8C1MssrW0XP
	ydQVEgcUP0fPwTg8FI+P15Cqhtk/hlS7+iaelRhyKXLyz3/VJDHT43U/elu4sbdaDFBVUK
	0DFpIiheFGd3dy97OZO0yUhvQW1o0/3WUcvZCrwBMCCbx23SebwZ0w/yid1CxLriE2j+1B
	odRtq3PKqdQ/ryZmDsZvnp3adIh/nzt12eDm0PBMvI5wYPukGBl970RJ0w2BZcywTGh4iR
	zTM/RLws22A7GMnVzLJOqdkKLXng7+bUrQsk4KOKTbYPaojRogW/JF0NSbg3CA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSWze-004GWG-0h;
	Sun, 15 Nov 2026 10:57:50 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EE5EF5EC24D;
	Sun, 15 Nov 2026 09:57:49 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 1/9] can: bcm: copy the CAN frames outside of lock_sock()
Date: Sun, 15 Nov 2026 10:54:52 +0100
Message-ID: <20261115095746.709371-2-mkl@pengutronix.de>
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

From: Oliver Hartkopp <socketcan@hartkopp.net>

bcm_sendmsg() copies the CAN frames of TX_SETUP, RX_SETUP and TX_SEND
from user space while holding lock_sock(). A copy that faults or
stalls, e.g. on a FUSE backed mapping, holds lock_sock() for its whole
duration.

bcm_notify() takes lock_sock() of every CAN_BCM socket in the namespace
of a vanishing CAN device while holding RTNL, independent of the
binding of the socket. So a stalled copy on any CAN_BCM socket can
block RTNL on the unregistration or namespace change of a CAN device in
this namespace, e.g. of a vcan device in an unprivileged user and
network namespace.

Copy the CAN frames that the opcode handler reads to kernel memory
before lock_sock() and hand them to the handlers with a kvec based
msghdr. bcm_tx_setup(), bcm_rx_setup() and bcm_tx_send() keep their
checks and read the frames with memcpy_from_msg() as before. Up to
sizeof(struct canfd_frame) bytes, i.e. a single CAN FD frame or up to
four CAN CC frames, are copied to a buffer on the stack, more frames to
a kvmalloc() buffer of up to MAX_NFRAMES + 1 CAN FD frames.

As the frames are copied before lock_sock() now, a failing copy is
reported before the error conditions that are checked under
lock_sock(). This is in line with POSIX, which does not define an
order in which multiple error conditions are detected and reported.

The generic SOL_SOCKET options in sk_setsockopt() and sk_getsockopt(),
e.g. SO_ATTACH_FILTER, still access user space under the socket lock.
This is not specific to CAN_BCM and not addressed by this patch.

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20261113-can-bcmlock-memcg-v5-1-634c0e04bc72@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/bcm.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 7bd2aa39777a..3f4c8d828337 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1643,6 +1643,11 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	struct bcm_sock *bo = bcm_sk(sk);
 	int ifindex;
 	struct bcm_msg_head msg_head;
+	struct msghdr fmsg = {};	/* CAN frames copied to kernel memory */
+	struct kvec kv;
+	struct canfd_frame sframe;	/* stack buffer for up to CANFD_MTU bytes */
+	void *frames = &sframe;
+	size_t flen = 0;
 	int cfsiz;
 	int ret; /* read bytes or error codes as return value */
 
@@ -1663,6 +1668,47 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if ((size - MHSIZ) % cfsiz)
 		return -EINVAL;
 
+	/* Copy the CAN frames from user space before lock_sock(), so a
+	 * stalled copy can not block bcm_notify() waiting for lock_sock()
+	 * under RTNL. Only the frames the opcode handler reads are copied.
+	 * The handlers keep their checks and read the frames from fmsg.
+	 */
+	switch (msg_head.opcode) {
+	case TX_SETUP:
+		if (msg_head.nframes >= 1 && msg_head.nframes <= MAX_NFRAMES)
+			flen = msg_head.nframes * cfsiz;
+		break;
+
+	case RX_SETUP:
+		if (!(msg_head.flags & RX_FILTER_ID) &&
+		    msg_head.nframes <= MAX_NFRAMES + 1)
+			flen = msg_head.nframes * cfsiz;
+		break;
+
+	case TX_SEND:
+		if (msg_head.nframes == 1 && size == cfsiz + MHSIZ)
+			flen = cfsiz;
+		break;
+	}
+
+	/* a message with missing frames still fails in the handler */
+	flen = min(flen, msg_data_left(msg));
+
+	if (flen > sizeof(sframe)) {
+		frames = kvmalloc(flen, GFP_KERNEL);
+		if (!frames)
+			return -ENOMEM;
+	}
+
+	if (!copy_from_iter_full(frames, flen, &msg->msg_iter)) {
+		ret = -EFAULT;
+		goto out_free;
+	}
+
+	kv.iov_base = frames;
+	kv.iov_len = flen;
+	iov_iter_kvec(&fmsg.msg_iter, ITER_SOURCE, &kv, 1, flen);
+
 	lock_sock(sk);
 
 	/* Re-validate under the socket lock: a concurrent bcm_notify()
@@ -1721,11 +1767,11 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	switch (msg_head.opcode) {
 
 	case TX_SETUP:
-		ret = bcm_tx_setup(&msg_head, msg, ifindex, sk);
+		ret = bcm_tx_setup(&msg_head, &fmsg, ifindex, sk);
 		break;
 
 	case RX_SETUP:
-		ret = bcm_rx_setup(&msg_head, msg, ifindex, sk);
+		ret = bcm_rx_setup(&msg_head, &fmsg, ifindex, sk);
 		break;
 
 	case TX_DELETE:
@@ -1759,7 +1805,7 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		if ((msg_head.nframes != 1) || (size != cfsiz + MHSIZ))
 			ret = -EINVAL;
 		else
-			ret = bcm_tx_send(msg, ifindex, sk, cfsiz);
+			ret = bcm_tx_send(&fmsg, ifindex, sk, cfsiz);
 		break;
 
 	default:
@@ -1769,6 +1815,9 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 out_release:
 	release_sock(sk);
+out_free:
+	if (frames != &sframe)
+		kvfree(frames);
 
 	return ret;
 }

base-commit: aa40afa831ebfe45e40a23721711059f2ac584d4
-- 
2.53.0

