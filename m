Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.81
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794333735;
	b=kpOwaOcG9zy51WdcnR0RbzkA4WfbL0YUmuj6j8PiDNtpJo8swEQnBZd1GZ3kPGCs4Co/
	 UhOvlXw9fXeeDjZ0bSdHgPGhDsdFQpojozs8rpHGWL4U/4UH2PakJt2WYpSYw8U1BjBzJ
	 juOCSr/IxXuVRuN9GOBAJ6AFF+SlwiMbxfkE7PPwIlf00z9owP21dhXmTvFS4iYE3ERJI
	 0gMXxS2CEdMZxJro7f1tCfP8N4B/zlCI1piAQIvL+r0LiI88iskvPGr8mzrn9qbxitjfd
	 qGYmuoAHSO2dK+rrink254l6AqKRsZaz4xJtHJTTx7ZIxnIu6z1hpkXXWal0z7FnuYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333735;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=Gouqm9Ua1BRzimdjEEfF4UiaMX5OuFftGRRxf5a8D+A=;
	b=JyszAKCX0TXFvMzhKARx6msYg2j3lNmcxd9qPCcC5AlYTAbe4tmuZ/dYeUz3nYNwlMbZ
	 cLXYVmatUEwd4E28HBm3tFSDsGWptfO/lhl9YPtj6F+vowXn9msJpNhmBajFu7vCJdWzq
	 N7s19lCQuaQHZ0oeXvCGs380wiNasWSaUXoT0KDthARXGai6zsxLDr9BBH5/5IECX6K1X
	 qAwzJK03jGVPSUocIpiNLYu76b8V1WcwSZxQ3IN9s5UKYovTr1dHKj8qFcCwiXpfe+7md
	 jEkAYb3YwAVWUlYzQwQlLBruegu5CVNO1ELkhiP2ACMWpYs26i7j2PV24ZvNoQ6hbQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=MAt6UE9m;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=d8tYpQls;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.81
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A8F606A323
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1A8F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=MAt6UE9m;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=d8tYpQls
ARC-Seal: i=1; a=rsa-sha256; t=1794333712; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KHkDkhz9AFRwiO8LLiQA4l0Rq9dLGSF2sK3xP9w1MdzrQg5pTzACJMjeZjzOXfA55B
    qO49sL6EJzT2RqHp8uLiCJdAzORir1D+1Dwiw5icMXKTxlKh+htVjMXtMMZfSZ5wNWGf
    gcNlhZefxf689S3ikudmC8LhmR3iD3Pygim8U/DlwWG9QFUmMG+Xj9WlogUl7deWywZM
    ANqnx84w6YhAGYpGCwFmEQWTJyq7pofoKhBlqTKJJ8AI2GcRqj8SjBd2DrgCoiNXAX/M
    5bGL7AM3b+aa5sM1a0CnNx69338a+iMKsBM2+Z83fqYgaV2dMpuO7V3Gd9hO0K9uXCAJ
    WHAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794333712;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Gouqm9Ua1BRzimdjEEfF4UiaMX5OuFftGRRxf5a8D+A=;
    b=C2raelB3WTU5guPca0xZmO5MUu1sbQRTA3uWMbjt12e4pi+iJ1pqWy4773gJvpSRq/
    +nkDsLKicikwT6fdyjDgCswYRRjfKKIXSRFHmhkFlHyj43SMi0fKUV8+770b/Oq8/GM+
    Rimn24WOiPR9UGQ9EbCiAYXVxHh4b3hSXmVbG+cHGL5sm6xaLLdUAJSks6aauSb/bSBa
    XQcZBzM6IuqmrAwyZzJSFs0nZDlBcEVaTYUe8o9zEwsGi92VPhfAc55TdTQi/oYUUTW0
    mMNYIUojbymZ/W3dpgsxmjc4ppx4NDB1NPRmJdzy50Eq4FhiFRcyhyVzCIZGVS+oGlkh
    5cVg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794333712;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Gouqm9Ua1BRzimdjEEfF4UiaMX5OuFftGRRxf5a8D+A=;
    b=MAt6UE9meRzdjfDZ2M4pG3AlIpRhATETJw8KXD1Ztp35TUyuLcLM5Yn9rt9JR0HfYG
    NDOMc9UqZbq7NJsMrZi2Yh3GL/l6pbzToFMhkt1hMY08yEgWIMb5CC988HWC+Ii5dhW6
    2/hql8rAUaIPF9A2VcA/9+i2k5tLXdDwgrx+kkxqZBUkZ7p3SAdf4e88D8lef8VXLB8g
    XXAtSjg8BOxpRgc8wijDHJw4VGDAUauyGt/e4CV/v7VphBjZFgPGdmLiDWki37GQBIts
    oDUREzbCm052griITHAbqAWU/uXY099sOV6zLB5NpvNFW/VDCnKPMgQLRHNKIaj8qLSd
    Huiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794333712;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Gouqm9Ua1BRzimdjEEfF4UiaMX5OuFftGRRxf5a8D+A=;
    b=d8tYpQls3Gt8BgmTkKJqh2XyYXgWZkNyweX7C8FzS6oNgFR7eqkFhxuX27nFkP4xkN
    +yNYG5LHT+STESxtldDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AAI1q1cw
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 10 Nov 2026 19:01:52 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 6.6.y] can: raw, isotp: copy socket options outside of lock_sock()
Date: Tue, 10 Nov 2026 19:01:45 +0100
Message-ID: <20261110180145.792066-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201318-failed-6.6-43c973a0887d@kernel.org>
References: <20261109201318-failed-6.6-43c973a0887d@kernel.org>
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
[ backport to 6.6: This tree has no raw_setsockopt_locked() from commit
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
  <20261109201316-failed-6.6-962947b69589@kernel.org>
  <20261109201321-failed-6.6-0f3ad9ab40e3@kernel.org>

 net/can/isotp.c | 100 +++++++++++++++++++++++++++---------------------
 net/can/raw.c   |  25 +++++++++---
 2 files changed, 76 insertions(+), 49 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 69366f957507..ad99d1543b16 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1681,8 +1681,8 @@ static int isotp_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
 	return ISOTP_MIN_NAMELEN;
 }
 
-static int isotp_setsockopt_locked(struct socket *sock, int level, int optname,
-			    sockptr_t optval, unsigned int optlen)
+static int isotp_setsockopt_locked(struct socket *sock, int optname,
+				   const void *val)
 {
 	struct sock *sk = sock->sk;
 	struct isotp_sock *so = isotp_sk(sk);
@@ -1693,11 +1693,7 @@ static int isotp_setsockopt_locked(struct socket *sock, int level, int optname,
 
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
@@ -1722,55 +1718,37 @@ static int isotp_setsockopt_locked(struct socket *sock, int level, int optname,
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
@@ -1784,13 +1762,49 @@ static int isotp_setsockopt(struct socket *sock, int level, int optname,
 
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
index ead9e2713a27..d3c8bf057cce 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -777,31 +777,44 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 		return -EINVAL;
 
 	switch (optname) {
-	case CAN_RAW_FILTER:
+	case CAN_RAW_FILTER: {
+		struct can_filter *filter = NULL;
+		int fsize = 0;
+
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
+	}
 
 	case CAN_RAW_ERR_FILTER:
 		if (len > sizeof(can_err_mask_t))
