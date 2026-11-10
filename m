Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.167
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794333635;
	b=hkFTKiL0xRmncWdu7m7rqLmVZgpNlIevUFzbkraPnXo4UVhgzvcJVxAqShxfbrVo8oGV
	 MJlir7ZMO6usx5/RBPF/PLbAFr0iAvPM0QfB/49mJjCXxDFJPDJLqesTXMRhCaTQ1D70I
	 MxjAQFz0iTRpbYCbnkdlhdMLsz0YYEx4D1A4CpdxQStWq+Yc3TXurwNP/5LSowQ9dLr72
	 G+YDzWvB/xx2ofsKapbYUguGZa/fN+C1274jYEGfMhnnWf6eLx8EEN59vo6m7zpwSTP+u
	 khZDASpFgda9lBJbRxgOsnf7wXcGjGBDKQ1yjDwYYyV1v2zFljdwk98gq7yzkzlshGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333635;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=1XrR/S6g2zBWZdJjjD605mj5DN4AjfSgOPkNRzXkD2g=;
	b=JMZGb4NHyAgwZWEWXOlAbcltPswU9ealcqK63w2gbe5a4+lQLESPmwVtajGN63Mji1oZ
	 4msRN6lorobYfcUB+PSyQQDLVvgRd2stLylQl5OV1y3wWFvUIHC2BjPxRFr2nNyh1gOaz
	 azPzJOwT5GEe2CvaI2zNZ9ahR+iobqmGlk1N0s/ai4F04AIarwqDyLZ17tti3XPH5m4Gv
	 yEQLTh6eT4futvpOAM1i8xBC6imJ6cbC8vlWX4KUrc4LdOJ74cFLtIoM6KvAWS228aG2B
	 RFFCJ9M6CqUJRIir3un3/uRZXVV7biYHHYao0+diNXGJFlc59rmfe6q9yeMFgwxT/mQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=UnQPj3dZ;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=fuWfG0wB;
	arc=fail smtp.remote-ip=81.169.146.167
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01556606A334
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01556606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=UnQPj3dZ;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=fuWfG0wB
ARC-Seal: i=1; a=rsa-sha256; t=1794333621; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pFPTfMwp0VN03p8yKKEFSu1Saenm9gj7G0p7tvoheyfCESBIrGWZ5ugOMcYw+fVuBt
    OsrYhiuay2ou9MkB7nGOJVeKVvK2hoWUt5JCk5cEAq9s0X48ALE5u4K+kBe8Fk2EMy/r
    ffa8C1PxYB4dige7VXJjx40jYT1uRYXZanQ2lHWpO4Xqd1MICKn0C3OwqbipmBs0bpa+
    k2V2CVq9KHHtfPsjjzMxi15CliyKR26Bhc2p19rVnxOrAUFGF0QhbcTjAIO/tWygw2ui
    Et+xsN0LlRxG8ftL8YBy0XakivbCSVTpgp6d91awbvyW1nJwlfzRCh/QVIknqc5IOg63
    t4JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794333621;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=1XrR/S6g2zBWZdJjjD605mj5DN4AjfSgOPkNRzXkD2g=;
    b=VEkop7Lg3mqEv39irFPeT4UYJnIIOg83DAVmMNZf4dNy+N41JlPmcQuaVk8+XJUztM
    nn8j9wCv44xoODqYNhqPOL3HVB5K47ZqnWboVvTkX9EU0/YZaVhDHRW69oDrjnAErRBn
    q8TJqbDEz/DGsFIQxcBB1SIQeyoX/D5X82B6YJVzZQT9RIzQmdjO+XrQLLo9E393ZWLY
    AAwW+kDGhzUECf/kcRkb4BDziE6bhlavDDgn/bp4OMxkZy5yT0kQHLHz6rNV7Ofc/xF6
    1VhqQWT1bk5aOqYdmIWH4X/nJ5mjU0tK9XCaXb/6HRqcFQYcEgWHLAdNyy8KQQaUcoUd
    4MMw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794333621;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=1XrR/S6g2zBWZdJjjD605mj5DN4AjfSgOPkNRzXkD2g=;
    b=UnQPj3dZlByoohfz7mn5EFycPPAvPQHb69DvgTy6CPX3tAprvCkYuGNfUGdm4hOipk
    6JCH4jLUYDA04tP4gfw3OZY43I8/Jn7UbAgbH5PUf9KSrK1sjqt1GEbkJfYJVu/d0Ixz
    NB4cy4RLHaluZXDpO1EwEM943r3ipkJF6Qz2J4HlzQl917db/s+TvysVvddC5WRaEoOC
    XLZCfeLWgPURQEHHoo4aUgxXrks8LTYqjtXeFXHbpqjXyw7C1L3QkEgXeoUDYHAWVJch
    d6JuwA7V9qFKILdvzwWVL0LTsCG++uoHfAs+TxW64kJJ2wqYrTq7QDZitp7P8CmmJ8lP
    P3bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794333621;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=1XrR/S6g2zBWZdJjjD605mj5DN4AjfSgOPkNRzXkD2g=;
    b=fuWfG0wBDtSnYUwhwoSoaJKO6rhEyUlAuqFFrT1U5aN8gNl7xJ+SmWXt3vAxIwfCJH
    tJgK53m8Yo6lOOfdVGDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AAI0L1co
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 10 Nov 2026 19:00:21 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 6.12.y] can: raw, isotp: copy socket options outside of lock_sock()
Date: Tue, 10 Nov 2026 19:00:15 +0100
Message-ID: <20261110180015.791954-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200848-failed-6.12-43c973a0887d@kernel.org>
References: <20261109200848-failed-6.12-43c973a0887d@kernel.org>
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
Content-Type: text/plain; charset="us-ascii"

commit 43c973a0887d3d7b2ee0a446603c97bf0f38c58e upstream.

The CAN_RAW and CAN_ISOTP specific socket options are copied from and
to user space while holding lock_sock(). A copy that faults or stalls,
e.g. on a userfaultfd or FUSE backed mapping, holds lock_sock() for its
whole duration.

raw_notify() and isotp_notify() take lock_sock() of a socket that is
bound to the vanishing device while holding RTNL. As the CAN_RAW
options can also be changed on a bound socket, a stalled copy can block
RTNL on an unregistration or namespace change of the bound device.
Before "can: protect the receive lists with a per-device lock",
raw_setsockopt() even held RTNL itself during the copy. CAN_ISOTP only
copies its options for unbound sockets, which isotp_notify() skips
without taking lock_sock().

Keep the user space copies out of the locked sections: Check the option
name and length and copy the option values, including the CAN_RAW_FILTER
filters, to kernel memory before lock_sock(). raw_setsockopt_locked()
and isotp_setsockopt_locked() get the copied values directly and drop
their now redundant length checks and copies. As a side effect, a
failing copy can not leave partially overwritten options behind
anymore. In raw_getsockopt() duplicate the filters under lock_sock() and
copy them to user space after release_sock().

As the option name and length are now checked before lock_sock(), the
order of the checks in isotp_setsockopt() and accordingly the order of
the returned error values changes. This is in line with POSIX, which
does not define an order in which multiple error conditions are
detected and reported.

The generic SOL_SOCKET options in sk_setsockopt() are not affected by
this patch.

Fixes: c18ce101f2e4 ("[CAN]: Add raw protocol")
Fixes: 1e5185c09058 ("can: raw: add locking for raw flags bitfield")
Cc: stable@vger.kernel.org # depends on "can: protect the receive lists with a per-device lock"
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20261027-can-rx-lock-v12-4-eb5afc2d8b9b@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
[ backport to 6.12: This tree has no raw_setsockopt_locked() from commit
  1e5185c09058 ("can: raw: add locking for raw flags bitfield").
  raw_setsockopt() already copies all option values from user space
  before lock_sock() here, so only the raw_getsockopt() and isotp parts
  apply. raw_getsockopt() uses copy_to_user() and put_user() instead of
  the getsockopt_iter interface in this tree. Duplicate the filters
  under lock_sock() and copy them with copy_to_user() after
  release_sock(). Also move the put_user() of the needed filter space
  for -ERANGE behind release_sock(), which upstream writes to the kernel
  side opt->optlen. ]
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
This backport depends on the backports of
  962947b69589 ("can: replace ARPHRD_CAN type checks with can_get_ml_priv()")
  0f3ad9ab40e3 ("can: protect the receive lists with a per-device lock")
sent in reply to
  <20261109200845-failed-6.12-962947b69589@kernel.org>
  <20261109200850-failed-6.12-0f3ad9ab40e3@kernel.org>

 net/can/isotp.c | 100 +++++++++++++++++++++++++++---------------------
 net/can/raw.c   |  21 +++++++---
 2 files changed, 73 insertions(+), 48 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index b32f97c85b17..c3155d7473ab 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1683,8 +1683,8 @@ static int isotp_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
 	return ISOTP_MIN_NAMELEN;
 }
 
-static int isotp_setsockopt_locked(struct socket *sock, int level, int optname,
-			    sockptr_t optval, unsigned int optlen)
+static int isotp_setsockopt_locked(struct socket *sock, int optname,
+				   const void *val)
 {
 	struct sock *sk = sock->sk;
 	struct isotp_sock *so = isotp_sk(sk);
@@ -1695,11 +1695,7 @@ static int isotp_setsockopt_locked(struct socket *sock, int level, int optname,
 
 	switch (optname) {
 	case CAN_ISOTP_OPTS:
-		if (optlen != sizeof(struct can_isotp_options))
-			return -EINVAL;
-
-		if (copy_from_sockptr(&so->opt, optval, optlen))
-			return -EFAULT;
+		memcpy(&so->opt, val, sizeof(so->opt));
 
 		/* no separate rx_ext_address is given => use ext_address */
 		if (!(so->opt.flags & CAN_ISOTP_RX_EXT_ADDR))
@@ -1724,55 +1720,37 @@ static int isotp_setsockopt_locked(struct socket *sock, int level, int optname,
 		break;
 
 	case CAN_ISOTP_RECV_FC:
-		if (optlen != sizeof(struct can_isotp_fc_options))
-			return -EINVAL;
-
-		if (copy_from_sockptr(&so->rxfc, optval, optlen))
-			return -EFAULT;
+		memcpy(&so->rxfc, val, sizeof(so->rxfc));
 		break;
 
 	case CAN_ISOTP_TX_STMIN:
-		if (optlen != sizeof(u32))
-			return -EINVAL;
-
-		if (copy_from_sockptr(&so->force_tx_stmin, optval, optlen))
-			return -EFAULT;
+		so->force_tx_stmin = *(const u32 *)val;
 		break;
 
 	case CAN_ISOTP_RX_STMIN:
-		if (optlen != sizeof(u32))
-			return -EINVAL;
-
-		if (copy_from_sockptr(&so->force_rx_stmin, optval, optlen))
-			return -EFAULT;
+		so->force_rx_stmin = *(const u32 *)val;
 		break;
 
-	case CAN_ISOTP_LL_OPTS:
-		if (optlen == sizeof(struct can_isotp_ll_options)) {
-			struct can_isotp_ll_options ll;
-
-			if (copy_from_sockptr(&ll, optval, optlen))
-				return -EFAULT;
+	case CAN_ISOTP_LL_OPTS: {
+		const struct can_isotp_ll_options *ll = val;
 
-			/* check for correct ISO 11898-1 DLC data length */
-			if (ll.tx_dl != padlen(ll.tx_dl))
-				return -EINVAL;
+		/* check for correct ISO 11898-1 DLC data length */
+		if (ll->tx_dl != padlen(ll->tx_dl))
+			return -EINVAL;
 
-			if (ll.mtu != CAN_MTU && ll.mtu != CANFD_MTU)
-				return -EINVAL;
+		if (ll->mtu != CAN_MTU && ll->mtu != CANFD_MTU)
+			return -EINVAL;
 
-			if (ll.mtu == CAN_MTU &&
-			    (ll.tx_dl > CAN_MAX_DLEN || ll.tx_flags != 0))
-				return -EINVAL;
+		if (ll->mtu == CAN_MTU &&
+		    (ll->tx_dl > CAN_MAX_DLEN || ll->tx_flags != 0))
+			return -EINVAL;
 
-			memcpy(&so->ll, &ll, sizeof(ll));
+		memcpy(&so->ll, ll, sizeof(*ll));
 
-			/* set ll_dl for tx path to similar place as for rx */
-			so->tx.ll_dl = ll.tx_dl;
-		} else {
-			return -EINVAL;
-		}
+		/* set ll_dl for tx path to similar place as for rx */
+		so->tx.ll_dl = ll->tx_dl;
 		break;
+	}
 
 	default:
 		ret = -ENOPROTOOPT;
@@ -1786,13 +1764,49 @@ static int isotp_setsockopt(struct socket *sock, int level, int optname,
 
 {
 	struct sock *sk = sock->sk;
+	union {
+		struct can_isotp_options opt;
+		struct can_isotp_fc_options rxfc;
+		struct can_isotp_ll_options ll;
+		u32 stmin;
+	} val;
+	unsigned int size;
 	int ret;
 
 	if (level != SOL_CAN_ISOTP)
 		return -EINVAL;
 
+	/* copy the option values from user space before lock_sock() */
+	switch (optname) {
+	case CAN_ISOTP_OPTS:
+		size = sizeof(val.opt);
+		break;
+
+	case CAN_ISOTP_RECV_FC:
+		size = sizeof(val.rxfc);
+		break;
+
+	case CAN_ISOTP_TX_STMIN:
+	case CAN_ISOTP_RX_STMIN:
+		size = sizeof(val.stmin);
+		break;
+
+	case CAN_ISOTP_LL_OPTS:
+		size = sizeof(val.ll);
+		break;
+
+	default:
+		return -ENOPROTOOPT;
+	}
+
+	if (optlen != size)
+		return -EINVAL;
+
+	if (copy_from_sockptr(&val, optval, size))
+		return -EFAULT;
+
 	lock_sock(sk);
-	ret = isotp_setsockopt_locked(sock, level, optname, optval, optlen);
+	ret = isotp_setsockopt_locked(sock, optname, &val);
 	release_sock(sk);
 	return ret;
 }
diff --git a/net/can/raw.c b/net/can/raw.c
index 924f6c82eb2e..fd9f71ee32e9 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -812,29 +812,40 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 
 	switch (optname) {
 	case CAN_RAW_FILTER: {
+		struct can_filter *filter = NULL;
+		int fsize = 0;
 		int err = 0;
 
 		lock_sock(sk);
 		if (ro->count > 0) {
-			int fsize = ro->count * sizeof(struct can_filter);
+			fsize = ro->count * sizeof(struct can_filter);
 
 			/* user space buffer to small for filter list? */
 			if (len < fsize) {
 				/* return -ERANGE and needed space in optlen */
 				err = -ERANGE;
-				if (put_user(fsize, optlen))
-					err = -EFAULT;
 			} else {
 				if (len > fsize)
 					len = fsize;
-				if (copy_to_user(optval, ro->filter, len))
-					err = -EFAULT;
+				/* copy to user space after release_sock() */
+				filter = kmemdup(ro->filter, len, GFP_KERNEL);
+				if (!filter)
+					err = -ENOMEM;
 			}
 		} else {
 			len = 0;
 		}
 		release_sock(sk);
 
+		if (err == -ERANGE) {
+			if (put_user(fsize, optlen))
+				err = -EFAULT;
+		} else if (filter) {
+			if (copy_to_user(optval, filter, len))
+				err = -EFAULT;
+			kfree(filter);
+		}
+
 		if (!err)
 			err = put_user(len, optlen);
 		return err;
