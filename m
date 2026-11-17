Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794953327;
	b=b5QpAJBW1I0vfkBamHDoop58Tiwhr/6xbOTnbyjm5Jrhw31esTL6CgUTbGRZuFyWllwq
	 7xMPDSHPP+kwrEI9K2zhgE6JXB9QWumpyA9o7qhfBAxZ+bGAq+wcxyuRsB3yMwVAfVpFm
	 MSDltEQBzYCC4QSi6bDORPlPuccxqMs9k6rFef21fZ7aZHDLSCA4CrLSNojGt1Q44YiYZ
	 Y04zcolfBEmyTlda7sxh14DJvQfq/3ZSD0LxmN4NMyi4UcOA8wgcC8eRXk6aE5zMXp23J
	 30dnroesfjDeMHEp97KH9y4/hxGFdnFo++AKuV5cIDRFEWJnVvBZ0aZNVq2+UFAuBNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953327;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jGXd+rBBMwStp2Z+C0Hxpf0TwUDeeEucKjYzkxMWFSk=;
	b=sF2uwXuHF2xAv8yWE3v76kK9ZPgCtbJpLu2OwzgBiwohRjGfVMZhq1NA75qDUAqB2N8i
	 4/4lpxLRChp17r+/kyJw0wgoSjpXVb6V2w6HWFqH7Qk8PjytjFTHiAcBeKn2W6qG2E47e
	 QPOZ2HcH6+gW/f6DfEgHlf75Tg3C5KYCM3Jnt9j6pt/ypqCiQVXopI37NjqG56HYlf9jt
	 KqlcLkRuHEDbkM9ARZjfP/yk8XiGTNrVAFwOY1/7XcnGvXO5Tm88UIuDX3lyitESzNjNi
	 Dq3gpEBEeQW+Vfn8cQa4DOFqkNvelB+a+i9So8/gT37FG5qOcCgJVk0DW6NXTYp7VIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=dzmndMZu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB78606A33D;
	Tue, 17 Nov 2026 22:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BB78606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=dzmndMZu
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E8B77205A6E;
	Tue, 17 Nov 2026 23:08:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794953320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jGXd+rBBMwStp2Z+C0Hxpf0TwUDeeEucKjYzkxMWFSk=;
	b=dzmndMZuIIK/NXD8/nv6YELtkcs40ZVOu1R1QstdvRpoTqC8mUF8JAqXvAmVqrPipU65c3
	WiYM/RFyV8x3/vjfoIyJrxN5SjoqhmNt8Jvq/BTSzFkdiZcm0pufKt042oLoTi6+RKhmzH
	ixZ50yn325pxPFu/WWNcQaSZtJ7w4UCAYPOiQjAHaGR9uuZdlQdehCxk+tUR+0vugEiIkN
	pvQnMbm9/AbDkBnGWoM0cHI4IB7PAe9tAovEgnVeUTa+Wqr5ZNvY86p6RDUqGNLTc7TfrW
	Y33kCcADnXH9JGZEsGJBxCZwvnweTmlwbyp8BnqUkJwgmmS9v6+jmzTm89yrOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794953320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jGXd+rBBMwStp2Z+C0Hxpf0TwUDeeEucKjYzkxMWFSk=;
	b=Wn1YPTMIAxA2+oIgvBrul/ITJVLbVcu5kHNFBKbWsiqdCwPQV+NhVnjusGT7rT9wlt7Msx
	9WDDiTF7Mq5GpSS0Y8xMN957IVf5WRWlGlOLRDV8gSZOnrI0LPFMzbGZoL51qXYfRiqQkP
	Oq4t3sEqlPHVPXXcS8pDTl9+j6m8Stft5mraXw4auvW5eN9rF0zKvWbSjgpJBlmif6qccl
	2LYB9q/C7tpC6wrjTCD6WT2XNULbEpG8nhwt3p1KsUV5RZnEp5wvqjFmaFsfyhZAdwDB0Z
	KKK60ZtZRA0Ksw1gMynGOYlDO1QBxLwahBMpTrk7bZyjqRsM8lvYTM47k2DmOA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794953320; a=rsa-sha256;
	cv=none;
	b=am0V7sZncSuES2LYmEN3wRP0wxwdLKfNFEJ6TQy9orPIJm7r9cZ4sIzwvX6V4+pLZmskBE
	30dN2DrZ2uatMhYr/o/PgaHf3qtz/F0CO7UZLiNDUCA/Xya8qAiclMjw7ESWn7tyXTO6ab
	qZH3JJ5JtRbBY+p5Cnf5OZseO6/bz4GubE+p/K/Io2CLCv9CMTAFyWjKC8tLeKVlX3T1pd
	qgoJj4gdnpwWzTWDxsOYJrAP7qUyxDllosFSIMWqbtmEMOSrTWXjcQSUt9cINhpop3Yyi5
	NgJoU23chwVG6glZB5b2TkItZG0e078KOmVQ3YxeMoF1rjC6OCe/QXH9YU1/5g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xTRM0-000FmM-0y;
	Tue, 17 Nov 2026 23:08:40 +0100
Received: from blackshift.org (unknown [192.145.8.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8676E5EDA24;
	Tue, 17 Nov 2026 22:08:37 +0000 (UTC)
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
Subject: [PATCH net 01/11] can: bcm: copy the CAN frames outside of lock_sock()
Date: Tue, 17 Nov 2026 23:03:06 +0100
Message-ID: <20261117220818.1142581-2-mkl@pengutronix.de>
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
Link: https://patch.msgid.link/20261117-can-bcmlock-memcg-v6-1-6826a6227d36@hartkopp.net
Cc: Vincent Mailhol <mailhol@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Zhu Ling <zhuling0805@qq.com>
Cc: linux-can@vger.kernel.org
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

base-commit: 5e9b2ad9b8384cd3c417cd5e2c3bc7eee4a72791
-- 
2.53.0

