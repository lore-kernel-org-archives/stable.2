Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795510696;
	b=0mjIgrZPhVpCxJHRFGXj5C47dAhr0VfxgoKnv0W9U1XVyCvtTN8CZBK5U+hWs80gPI8k
	 sf0QRgKckboMHQYPmCYyzT+fMSeSjULWhMla+YHBIdycqk8hIoAbgmeuBPQskkBL1vtkQ
	 uk/HNtj6rNpvCtayzcNL8sFM2rZ8xN2dEDaHst2GngYm4jOEZR+gdhPBWvC91DkGAOask
	 Di3TYotH3yQfaDGgwlgSGQK6BSlHM2CWOCi6gav1Jim269976GA2n0wD90WZWXflfjxMy
	 HRfKIxR/kGKLe3b83Hge71gSN9ANFdW/4RT9ltEHYxfoAfDKrOyxeCgKtDh9nABGODQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510696;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Y8ztBKlfMrvk22VB6Yeu0+pbAwuO0gz4h3N/vergbgE=;
	b=OKu44dCIhMeyRatZP1D8yZUZjSUgEk/PJgxcGPlB3mKwn/o91UtQXv5ObCLo073PIz2A
	 c76AO7Iwpz3ONW1Re/H3kccmxM0jWeqdTkFtDyt4FkN8nW1+VguVkNVvIiNxkP67BBO5V
	 ZENG2jsGk8PecGNQhpUZogXBeMonmNsyRa8Zp6qzLT/wGpn9wEhWwiEVRrjRPSPSB66Rv
	 4OLyJX9tS2S32+BoIPGNxJqtoneMDrUJA3+jv62wA7VvgmFUxAhE/IsdGkLPzQKxp/3a2
	 +Pl5UOx0YqfNqJJK4DAIvSvapBaII/jfQqHPRnXbQzV0iQ62m9H7XJlPcLwA5cyK0eQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NrHgHYrP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C5E606A692;
	Tue, 24 Nov 2026 08:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5C5E606A692
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NrHgHYrP
Received: from pengutronix.de (p20030102af17cb00d2e697ee776c6466.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:d2e6:97ee:776c:6466])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 129952004FC;
	Tue, 24 Nov 2026 09:58:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8ztBKlfMrvk22VB6Yeu0+pbAwuO0gz4h3N/vergbgE=;
	b=NrHgHYrPWBbjkU5FssoGuwa25D/0Bub70GJP8KKKYbEFbORp6L3JMGYYZb9JXPjpqokIR4
	brig9fRXXXxstW75POaIAndd1BgoBaLfuhSs8fH53dnmQy03DDsN3JeFw54dL8MwizBeCS
	pQpFz9FZNn/pnQtqkM0jzfwqKv4Me+Yo03GPSyE9R+x1Z4BadX4PCJLyOhJRltEupVDos9
	K3G5q9coAPIOp27bezyMYpZgbr30wxSUSdRcfjriPZzfzkjeXGxa+A4BU3YL1hvFQm3GLV
	w6Dd5hzAhrKmwUbmwhNjUdu5JC9p8s1FGM3R6YBx213Mauterhz0+1vi+6hLbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8ztBKlfMrvk22VB6Yeu0+pbAwuO0gz4h3N/vergbgE=;
	b=IHI2209F4j5107bfSz1HVo1C9xtzd9djBph87ehFY0/8RWM7llzQ/A6/ntz+cSmhqM+bc5
	wE+oOhJHAKWApxuic4UOeHALw28DXjQhAfM/HhJWMkH3GbKLtrIM4RvAc0EueCbmhWLdSo
	hEfCN8QRRHfOgCdtPiFZYZ3efh4NugGs+dp0yg8Q3/mzf1f+/a5hJT3IThgspOndahh7VW
	kB18KzLuqLJAWGiM/i0ydJ0v+mUW1YDCMKY7JbgXfvmKvy2Gf+hP0U3RDKrrlrVQLBzvL1
	+DG3798qAM0RTWizwBr2weRHdqPdOIeeSxdlfG3QEBUS6TwWv8pXLeYF31plKA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795510685; a=rsa-sha256;
	cv=none;
	b=KMYKS584CQOpKerADDrJps0daD2h8qy/CP92Sw4PtWmVmaMASucx4iMVt61a89+L6PKtPn
	jtJ0MGcrXRimWYh4yeHcusVi7evzVPA5Bh+9ryS1XlSIu6N0WUwxiWtqlmdrlBlxZKqS9c
	tgj1vES6Zq3dsx7Lplz+7MOPSq7HD53uPHvnAVZxL939zWyrAtdch5D/Yo8DCOEwl7/hxK
	qFu8ZA004YPiQujBjDGLipd5UIhhCZY4YSLsFnk1FVWPKr6IOTGxl3RZ8RYfEVaP4AwP18
	rtCGXbDjscvrSwUalbAZOPgirEsrxyj4mmtDi3Bz64UdJxm6ViJ3NOgiSeyMTw==
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 01/12] can: bcm: copy the CAN frames outside of lock_sock()
Date: Tue, 24 Nov 2026 09:51:28 +0100
Message-ID: <20261124085757.1093632-2-mkl@pengutronix.de>
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
Link: https://patch.msgid.link/20261120-can-bcmlock-memcg-v7-1-f6b84f5257b1@hartkopp.net
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

base-commit: 4392bb809812ac79449cd0cf1f5e00469ee102d1
-- 
2.53.0

