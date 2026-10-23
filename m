Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.166
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792757907;
	b=4fgUP5EUVVTIjeVGIHqvMe9Pu0KpPj53FPhpmp7WkF0f6E77OPCnEwcoRdyAXq8MUB7I
	 u2bq3XccEYeXsc5i7iavp5P1miEINWIBwbTH3aI4QY0AhLbby0oIYTUialJaswlM3aBO2
	 fVi8O414PbIyY4mR2DSyevrV0owLM758XZWPcKXMUwNv0ItZjoIe72tVPMfHWDBqUH0nH
	 kyHJTnBY4ANn9AYz+gRQsVaGL8i7RrGrNfh5iNeijvELfQlG92GZTtjkve1XEXHhNYmYM
	 BVa99c7wwRxqw7QztYEHp+bjThcdaEH1uzT7lnEEsUTu5nj7CnFy/wWd/+n5NmT4y5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757907;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=VVR3bygMbGmEBO4qCU1gfb/dCExjsoIHlE9yOWyPdSw=;
	b=cYDDi7scJFmLBdQ9EuU1nPx47Puc4cdbjL2bQtz/53BlvNVXqU9csm0AvpBaSHR9/90t
	 LTXw+2SkWDeJlbH7CubqHYTfXh9N4Krr3vuykGqSY38GSVpKjrdlWPt0qcssqWbNaUYmk
	 1l5LfJv07j1bRD90gfUghLIhEpsXTiEpC3qI/uielW9+cmpKk459kXo3E7t2L+oYIy5Pf
	 8jbO9ntuSP5MhIOHvfIDUsTAtZJQaFGOpXTE6u3hPjEcolfGkomBbPSNEBXszJYCLe8A+
	 ES3A/4yEIUfJWBEmNCPEnMg5cv196QYoMxMu/wq8b9z8V7aov5y+iwP7T3lD7I/diAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=J7SbVDB0;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=xI3tEVAG;
	arc=fail smtp.remote-ip=81.169.146.166
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD349606A31B;
	Fri, 23 Oct 2026 12:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD349606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=J7SbVDB0;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=xI3tEVAG
ARC-Seal: i=1; a=rsa-sha256; t=1792757897; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=I4HGOR81vyfRt8PUcEGKcCd5xV+m3ILEpzjbQDuxvBk4A2GS1tG3/tGLzcHCB+FAdN
    XNCjrzobuOMgghPS6RHyLUV2b5T6YtuIL+daoMSJo71mLGeqe63wP9LN576/9YbAKW9f
    2PZM3Z0PJve0q4R0Y2jykeXdPnQfUQKgb2SuD1yEIKc4uC6uk1FfkZCYeEwTQoK9Ij5i
    KBe+/gSeJNiexEJ28u5cKqvfewGrKykNBhkgOAzBcwhBCddMcwOVQG0a/MzruUisyy5y
    xY7b6zWvMZyXFOEUd8izIflx6xCF/UKB194tKmZQAuH5QFYwv/zbmF7QjGQRIL00BU+P
    WDhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792757897;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=VVR3bygMbGmEBO4qCU1gfb/dCExjsoIHlE9yOWyPdSw=;
    b=GslaM4sH2qZRX9ndb5QM4v9rhdFFPtqWiK6ssIFqPMeg4jBzDFZ6O9YF29Y1kYHUKG
    R3iWClO843fylW+XfwHz6vMt3U94eJnhQAfCzV6KHjnREvOk4bvlQ5Dp0apdyUwLlgo9
    Cgt+azMreLoGGD7rIwwc8D1AbJ1P2+kBauLJfH+v+IU/Hvsb9TyJ7tKlhu8kdS8/7TCu
    pyWhc0yLj7It8vYNKAxlSm51teDTBFGyEXM9rwgOxn1rJuVGlkyGYJZJ/SFBMHcJ8ttn
    TqfM4uYBCB66LV+NnWtguKV9/u0HVC8TuDiZFs/T6Qy7rw0gQg/k8L6niFGWRCRFS4Xp
    vh1w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792757897;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=VVR3bygMbGmEBO4qCU1gfb/dCExjsoIHlE9yOWyPdSw=;
    b=J7SbVDB0XiMC62ZOfZblo9gD44tiXaFUS2qvLd0nZrO49CB25pcMN0TJfWlcR4ZZPN
    XJA99VREm+wSn31vfrptXhiVQAcEhOVvGYNLrDmRkwOp7t7CpvfZX3EoSZX3oYidz9W4
    J/ZEuTS7EZDwrWt0gyTUv8k1zHE4+gwwvLiidcwfKvkyfaXzn4O1cE2sZjo5YGBE8vpd
    WbM23Ja0wQ7Qs7T0GCmm8xGFOUAVOZ5bSgpwhMlUDXFfHCOiC++2rfAcRhcP1x/HMlrX
    Lg3yok61MDzroDUYHS7EUgUmFQPjZGUJkKstNFVAso+PkQelbuIe0R2n+Us+CV0NwJyl
    485g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792757897;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=VVR3bygMbGmEBO4qCU1gfb/dCExjsoIHlE9yOWyPdSw=;
    b=xI3tEVAGVNrPgclCV5N5CeV4UyTd3sfFVqgmD3FA3WHA1gty51uxGENghP1JSBcVgL
    pTDlL/dWo8B3ygTEQuBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29NCIHt5q
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 23 Oct 2026 14:18:17 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	stable@vger.kernel.org
Subject: [PATCH v8 7/7] can: raw, isotp: copy socket options outside of lock_sock()
Date: Fri, 23 Oct 2026 14:18:01 +0200
Message-ID: <20261023121801.3052075-8-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023121801.3052075-1-socketcan@hartkopp.net>
References: <20261023121801.3052075-1-socketcan@hartkopp.net>
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

The CAN_RAW and CAN_ISOTP specific socket options are copied from and
to user space while holding lock_sock(). A copy that faults or stalls,
e.g. on a userfaultfd or FUSE backed mapping, holds lock_sock() for its
whole duration.

Since CAN_RAW and CAN_ISOTP do not take RTNL in bind() anymore,
raw_notify() and isotp_notify() wait for lock_sock() of a socket that
is bound to the vanishing device while holding RTNL. As the CAN_RAW
options can be changed on a bound socket, such a stalled copy can block
RTNL on an unregistration or namespace change of the bound device.
CAN_ISOTP only copies its options for unbound sockets, which
isotp_notify() skips without taking lock_sock().

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

Fixes: ee8b94c8510c ("can: raw: fix receiver memory leak")
Cc: stable@vger.kernel.org # depends on "can: protect the receive lists with a per-device lock"
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 100 +++++++++++++++-----------
 net/can/raw.c   | 186 +++++++++++++++++++++++++-----------------------
 2 files changed, 155 insertions(+), 131 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 649a3446c4f1..ad4996f29007 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1699,27 +1699,23 @@ static int isotp_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
 	addr->can_addr.tp.tx_id = so->txid;
 
 	return ISOTP_MIN_NAMELEN;
 }
 
-static int isotp_setsockopt_locked(struct socket *sock, int level, int optname,
-			    sockptr_t optval, unsigned int optlen)
+static int isotp_setsockopt_locked(struct socket *sock, int optname,
+				   const void *val)
 {
 	struct sock *sk = sock->sk;
 	struct isotp_sock *so = isotp_sk(sk);
 	int ret = 0;
 
 	if (so->bound)
 		return -EISCONN;
 
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
 			so->opt.rx_ext_address = so->opt.ext_address;
 
@@ -1740,59 +1736,41 @@ static int isotp_setsockopt_locked(struct socket *sock, int level, int optname,
 				so->frame_txtime = so->opt.frame_txtime;
 		}
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
 	}
 
@@ -1802,17 +1780,53 @@ static int isotp_setsockopt_locked(struct socket *sock, int level, int optname,
 static int isotp_setsockopt(struct socket *sock, int level, int optname,
 			    sockptr_t optval, unsigned int optlen)
 
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
 
 static int isotp_getsockopt(struct socket *sock, int level, int optname,
diff --git a/net/can/raw.c b/net/can/raw.c
index 0267b4300c24..66e41bf9db3e 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -601,67 +601,40 @@ static int raw_getname(struct socket *sock, struct sockaddr *uaddr,
 
 	return RAW_MIN_NAMELEN;
 }
 
 static int raw_setsockopt_locked(struct socket *sock, int optname,
-				 sockptr_t optval, unsigned int optlen)
+				 const void *val, struct can_filter *filter,
+				 int count)
 {
 	struct sock *sk = sock->sk;
 	struct raw_sock *ro = raw_sk(sk);
-	struct can_filter *filter = NULL;  /* dyn. alloc'ed filters */
-	struct can_filter sfilter;         /* single filter */
 	struct net_device *dev = NULL;
-	can_err_mask_t err_mask = 0;
-	int count = 0;
+	can_err_mask_t err_mask;
 	int flag;
 	int err = 0;
 
 	switch (optname) {
 	case CAN_RAW_FILTER:
-		if (optlen % sizeof(struct can_filter) != 0)
-			return -EINVAL;
-
-		if (optlen > CAN_RAW_FILTER_MAX * sizeof(struct can_filter))
-			return -EINVAL;
-
-		count = optlen / sizeof(struct can_filter);
-
-		if (count > 1) {
-			/* filter does not fit into dfilter => alloc space */
-			filter = memdup_sockptr(optval, optlen);
-			if (IS_ERR(filter))
-				return PTR_ERR(filter);
-		} else if (count == 1) {
-			if (copy_from_sockptr(&sfilter, optval, sizeof(sfilter)))
-				return -EFAULT;
-		}
-
-		/* The reg_state check is only a shortcut: On a concurrent
+		/* @filter has been copied by raw_setsockopt(). It is linked
+		 * to the socket on success and freed by the caller on error.
+		 *
+		 * The reg_state check is only a shortcut: On a concurrent
 		 * unregistration or namespace change raw_notify() waits for
 		 * lock_sock() and removes the filters set here.
 		 */
 		dev = ro->dev;
 		if (ro->bound && dev &&
-		    READ_ONCE(dev->reg_state) != NETREG_REGISTERED) {
-			if (count > 1)
-				kfree(filter);
+		    READ_ONCE(dev->reg_state) != NETREG_REGISTERED)
 			return -ENODEV;
-		}
 
 		if (ro->bound) {
 			/* (try to) register the new filters */
-			if (count == 1)
-				err = raw_enable_filters(sock_net(sk), dev, sk,
-							 &sfilter, 1);
-			else
-				err = raw_enable_filters(sock_net(sk), dev, sk,
-							 filter, count);
-			if (err) {
-				if (count > 1)
-					kfree(filter);
+			err = raw_enable_filters(sock_net(sk), dev, sk, filter,
+						 count);
+			if (err)
 				return err;
-			}
 
 			/* remove old filter registrations */
 			raw_disable_filters(sock_net(sk), dev, sk, ro->filter,
 					    ro->count);
 		}
@@ -671,25 +644,19 @@ static int raw_setsockopt_locked(struct socket *sock, int optname,
 			kfree(ro->filter);
 
 		/* link new filters to the socket */
 		if (count == 1) {
 			/* copy filter data for single filter */
-			ro->dfilter = sfilter;
+			ro->dfilter = *filter;
 			filter = &ro->dfilter;
 		}
 		ro->filter = filter;
 		ro->count  = count;
 		break;
 
 	case CAN_RAW_ERR_FILTER:
-		if (optlen != sizeof(err_mask))
-			return -EINVAL;
-
-		if (copy_from_sockptr(&err_mask, optval, optlen))
-			return -EFAULT;
-
-		err_mask &= CAN_ERR_MASK;
+		err_mask = *(const can_err_mask_t *)val & CAN_ERR_MASK;
 
 		/* lockless shortcut, see CAN_RAW_FILTER */
 		dev = ro->dev;
 		if (ro->bound && dev &&
 		    READ_ONCE(dev->reg_state) != NETREG_REGISTERED)
@@ -712,78 +679,46 @@ static int raw_setsockopt_locked(struct socket *sock, int optname,
 		/* link new err_mask to the socket */
 		ro->err_mask = err_mask;
 		break;
 
 	case CAN_RAW_LOOPBACK:
-		if (optlen != sizeof(flag))
-			return -EINVAL;
-
-		if (copy_from_sockptr(&flag, optval, optlen))
-			return -EFAULT;
-
-		ro->loopback = !!flag;
+		ro->loopback = !!*(const int *)val;
 		break;
 
 	case CAN_RAW_RECV_OWN_MSGS:
-		if (optlen != sizeof(flag))
-			return -EINVAL;
-
-		if (copy_from_sockptr(&flag, optval, optlen))
-			return -EFAULT;
-
-		ro->recv_own_msgs = !!flag;
+		ro->recv_own_msgs = !!*(const int *)val;
 		break;
 
 	case CAN_RAW_FD_FRAMES:
-		if (optlen != sizeof(flag))
-			return -EINVAL;
-
-		if (copy_from_sockptr(&flag, optval, optlen))
-			return -EFAULT;
+		flag = *(const int *)val;
 
 		/* Enabling CAN XL includes CAN FD */
 		if (ro->xl_frames && !flag)
 			return -EINVAL;
 
 		ro->fd_frames = !!flag;
 		break;
 
 	case CAN_RAW_XL_FRAMES:
-		if (optlen != sizeof(flag))
-			return -EINVAL;
-
-		if (copy_from_sockptr(&flag, optval, optlen))
-			return -EFAULT;
-
-		ro->xl_frames = !!flag;
+		ro->xl_frames = !!*(const int *)val;
 
 		/* Enabling CAN XL includes CAN FD */
 		if (ro->xl_frames)
 			ro->fd_frames = ro->xl_frames;
 		break;
 
 	case CAN_RAW_XL_VCID_OPTS:
-		if (optlen != sizeof(ro->raw_vcid_opts))
-			return -EINVAL;
-
-		if (copy_from_sockptr(&ro->raw_vcid_opts, optval, optlen))
-			return -EFAULT;
+		memcpy(&ro->raw_vcid_opts, val, sizeof(ro->raw_vcid_opts));
 
 		/* prepare 32 bit values for handling in hot path */
 		ro->tx_vcid_shifted = ro->raw_vcid_opts.tx_vcid << CANXL_VCID_OFFSET;
 		ro->rx_vcid_shifted = ro->raw_vcid_opts.rx_vcid << CANXL_VCID_OFFSET;
 		ro->rx_vcid_mask_shifted = ro->raw_vcid_opts.rx_vcid_mask << CANXL_VCID_OFFSET;
 		break;
 
 	case CAN_RAW_JOIN_FILTERS:
-		if (optlen != sizeof(flag))
-			return -EINVAL;
-
-		if (copy_from_sockptr(&flag, optval, optlen))
-			return -EFAULT;
-
-		ro->join_filters = !!flag;
+		ro->join_filters = !!*(const int *)val;
 		break;
 
 	default:
 		return -ENOPROTOOPT;
 	}
@@ -792,21 +727,88 @@ static int raw_setsockopt_locked(struct socket *sock, int optname,
 
 static int raw_setsockopt(struct socket *sock, int level, int optname,
 			  sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
+	struct can_filter *filter = NULL;  /* dyn. alloc'ed filters */
+	struct can_filter sfilter;         /* single filter */
+	union {
+		can_err_mask_t err_mask;
+		int flag;
+		struct can_raw_vcid_options vcid_opts;
+	} val;
+	unsigned int size = 0;
+	int count = 0;
 	int err;
 
 	if (level != SOL_CAN_RAW)
 		return -EINVAL;
 
+	/* Copy the option values from user space before lock_sock(), so a
+	 * stalled copy can not block raw_notify() waiting for lock_sock()
+	 * under RTNL.
+	 */
+	switch (optname) {
+	case CAN_RAW_FILTER:
+		if (optlen % sizeof(struct can_filter) != 0)
+			return -EINVAL;
+
+		if (optlen > CAN_RAW_FILTER_MAX * sizeof(struct can_filter))
+			return -EINVAL;
+
+		count = optlen / sizeof(struct can_filter);
+
+		if (count > 1) {
+			/* filter does not fit into dfilter => alloc space */
+			filter = memdup_sockptr(optval, optlen);
+			if (IS_ERR(filter))
+				return PTR_ERR(filter);
+		} else if (count == 1) {
+			if (copy_from_sockptr(&sfilter, optval, sizeof(sfilter)))
+				return -EFAULT;
+			filter = &sfilter;
+		}
+		break;
+
+	case CAN_RAW_ERR_FILTER:
+		size = sizeof(val.err_mask);
+		break;
+
+	case CAN_RAW_XL_VCID_OPTS:
+		size = sizeof(val.vcid_opts);
+		break;
+
+	case CAN_RAW_LOOPBACK:
+	case CAN_RAW_RECV_OWN_MSGS:
+	case CAN_RAW_FD_FRAMES:
+	case CAN_RAW_XL_FRAMES:
+	case CAN_RAW_JOIN_FILTERS:
+		size = sizeof(val.flag);
+		break;
+
+	default:
+		return -ENOPROTOOPT;
+	}
+
+	if (size) {
+		if (optlen != size)
+			return -EINVAL;
+
+		if (copy_from_sockptr(&val, optval, size))
+			return -EFAULT;
+	}
+
 	lock_sock(sk);
 
-	err = raw_setsockopt_locked(sock, optname, optval, optlen);
+	err = raw_setsockopt_locked(sock, optname, &val, filter, count);
 
 	release_sock(sk);
 
+	/* on error free the filters allocated for CAN_RAW_FILTER above */
+	if (err && count > 1)
+		kfree(filter);
+
 	return err;
 }
 
 static int raw_getsockopt(struct socket *sock, int level, int optname,
 			  sockopt_t *opt)
@@ -823,10 +825,11 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 	if (len < 0)
 		return -EINVAL;
 
 	switch (optname) {
 	case CAN_RAW_FILTER: {
+		struct can_filter *filter = NULL;
 		int err = 0;
 
 		lock_sock(sk);
 		if (ro->count > 0) {
 			int fsize = ro->count * sizeof(struct can_filter);
@@ -837,19 +840,26 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 				err = -ERANGE;
 				opt->optlen = fsize;
 			} else {
 				if (len > fsize)
 					len = fsize;
-				if (copy_to_iter(ro->filter, len,
-						 &opt->iter_out) != len)
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
 
+		if (filter) {
+			if (copy_to_iter(filter, len, &opt->iter_out) != len)
+				err = -EFAULT;
+			kfree(filter);
+		}
+
 		if (!err)
 			opt->optlen = len;
 		return err;
 	}
 	case CAN_RAW_ERR_FILTER:
-- 
2.43.0

