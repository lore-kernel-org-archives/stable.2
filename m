Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.83
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794333881;
	b=Wk+9exqbP3lX2j/akKIeXQeceeGXZsaCfFPVlmQC1HkAsJY+2rHWaCkS/xoFxinQB+cs
	 R1uwDEHcf31TiXBZDiWioSOpDmhW1ULZye9K0K2iX4iftSi4bFF4R44DdeTJXOkVofLYJ
	 RhUEIFY374V3wCWZobVNyIeK/lv8NNqdJ4VqWKUXrRIMgy2n8BEHlepwqKCFsRd77ebcI
	 RMnch5Hn1fjgxLQGJWQHbf0mCFoOe8b7fr4Fca092uZJGNTYSJJkZFgpArUIn1A8xnqap
	 9qiZC5JFnmjBjABkFopuuIMu+Fnnh7uXQmI3xHu49QImMang0JTJLhsJOoGLU1/ux/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333881;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=F6ct81QTqEkvHFMRxHuJIHGVfpgVQmeZyl8NDIie8yc=;
	b=UVkvipYnRgKS8kGg5HFGMuoGR/8fFw9Hbr6vX9BDW53/NMqj2a3MvmwZS/gotVCD9PXK
	 38HIF8siJspOA/wuDonAOs7HgP3Z3MMAxHSwuHJYeGPzVHeH6K1UtIbUYjfzRwyR6k264
	 zQhes15hZZn+S+Dq4+S8WcbEo36DHd/zIdywjW6payG8cpmQTRedINaE+2pkOxGlt5J8z
	 MU5AwouNrauMKEEzUNM0MNSxf9fyhcQeCMuHkkidl5MP4ahbImNrfk99MmVduso1IlddF
	 sgGgQryf+u7iZLG0EFzhU3Efmb8juQHD33vI0VB1d3heV4pVMwZZxbf82DZPn8wRn/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=YVrbXi+y;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=gMgZPNAu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.83
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A49606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11A49606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=YVrbXi+y;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=gMgZPNAu
ARC-Seal: i=1; a=rsa-sha256; t=1794333870; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VqcQWnQsgHqaVuDHfrs7m5wGjQ+G9zsk2+eyzNf9v8+PvpQzEOaOG/v1wNVYYBR9TX
    3qY/AF57NEbQim7Yva/7KsbnwwkN+Drr+cNUfL7+OekPA25yep/TxoKobBEP/R9qg7Ix
    12MrhTEqjtD3lRt7Vm7wWbWhYyZzQ6HEHf4D2DIkWf+ygbx47RQVhg3xXaAZjVsEEIhM
    tIP3+EarDkz3qlx94U4ymmKIEruIgA+olic18wnrMP0tlU90yHn/LMpkvGU3hJ3y31/y
    bjfUFwxIsFNRrMJ2CJ7XVEHgSC+pMwsy7BndKkvuyXIH64QJya9Wu51A8gn8N8AQEvih
    S4iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794333870;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=F6ct81QTqEkvHFMRxHuJIHGVfpgVQmeZyl8NDIie8yc=;
    b=DldZNyIlUwZLkByIHL0E+eA4mTLwHgqVl1BFfQdjf7CTFkx+TLtrRUCkwr++7GHUIz
    j0k4GbZJCUEtyOVgK/QXonqK0EwMZofxB5uVs8FIyO5YSuBwTQh2ULNaWWH49OZ0GNv6
    k9du30N4RBOrQk/wJWuKB+WX8IkLCcOTslGmVfnXRtE7KbZu3bEU3erShivOXERrw65k
    F3F2V62ZuZ1JmxAEwHCSZFzNweEL9Q5+H3rOmlNygfzvq9hF0O8CF5PPWCJS1b1LLen+
    hKbrDKU/PzkIeRIhiISpj82r0b1dAXgyGLmIUgq+Vs+rLLUntHPKYLVsg/QTGHZPBmZR
    GpXg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794333870;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=F6ct81QTqEkvHFMRxHuJIHGVfpgVQmeZyl8NDIie8yc=;
    b=YVrbXi+yejTSQMf++xx+tMbRlxVREgkQYCuizB7P3szj+cISME+NyJiXmaOQD72wRi
    K8/3vd2s/btcur1OY25vUrc6Dcnxl8Pm1H9jAShPtc1R/iwY9a8rZN+rpYkS6FzZxY5S
    5az2t2J6+WY85t1K6nZi4+JeMlp7L6h/HU/AZp/uGqLNhdGxTAj4EcRA2MDTLe5i+MWa
    muaSpeyytWBWAyIsD7XUK7P/nu07OmVH+3jzjoxl/65WH65xH/QrEaeVznvhAEcIjVWG
    lgDriHzm609VVNKJrZuQEQoGVD0cAqYcs5YtalYuun04P6KfQk4YZ1ZvAFUddutATvNc
    xCqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794333870;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=F6ct81QTqEkvHFMRxHuJIHGVfpgVQmeZyl8NDIie8yc=;
    b=gMgZPNAuQld/WSkojlBP1LQMgZkDiAM1nEZwXnFwPyvQkNpLUNDKK2OOTNdPb7JUPI
    UB7/Zp9H5vmDWnAScXAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AAI4T1dO
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 10 Nov 2026 19:04:29 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 5.15.y] can: raw, isotp: copy socket options outside of lock_sock()
Date: Tue, 10 Nov 2026 19:04:22 +0100
Message-ID: <20261110180422.792240-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202310-failed-5.15-43c973a0887d@kernel.org>
References: <20261109202310-failed-5.15-43c973a0887d@kernel.org>
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
[ backport to 5.15: This tree has no raw_setsockopt_locked() from commit
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
  <20261109202308-failed-5.15-962947b69589@kernel.org>
  <20261109202312-failed-5.15-0f3ad9ab40e3@kernel.org>

 net/can/isotp.c | 100 +++++++++++++++++++++++++++---------------------
 net/can/raw.c   |  25 +++++++++---
 2 files changed, 76 insertions(+), 49 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index cd9bb2629420..5d8a44c27696 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1642,8 +1642,8 @@ static int isotp_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
 	return ISOTP_MIN_NAMELEN;
 }
 
-static int isotp_setsockopt_locked(struct socket *sock, int level, int optname,
-			    sockptr_t optval, unsigned int optlen)
+static int isotp_setsockopt_locked(struct socket *sock, int optname,
+				   const void *val)
 {
 	struct sock *sk = sock->sk;
 	struct isotp_sock *so = isotp_sk(sk);
@@ -1654,11 +1654,7 @@ static int isotp_setsockopt_locked(struct socket *sock, int level, int optname,
 
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
@@ -1683,55 +1679,37 @@ static int isotp_setsockopt_locked(struct socket *sock, int level, int optname,
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
@@ -1745,13 +1723,49 @@ static int isotp_setsockopt(struct socket *sock, int level, int optname,
 
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
index 62adfa4b5d00..d63334da1fcf 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -755,31 +755,44 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
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
