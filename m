Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.82
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794333820;
	b=lIn85Uoor2jTdNePeSz97M13VDjL/xr+FGP7H83oKZG5EULmA2RlP7YD0zK45jNlwx8W
	 kEgi/WFh3O1aBxbokAlQnhsWkt/74bm8JEw88c0AloSBJ229QK+kFQ9WPU2Kj0eE7KPqB
	 zZmIE+3MRgbmhkRTkOMBBXX3ibS/icMX0iVOmRNIfPtXW8+cSiKdH17npoik/1D3n8e1Z
	 V1fDjnRd3le9BCDQTHA6m82CYY0zVbV3xDBmh25+uBuonEQv7m5Rh+0B6z1wIS3Z9cA3E
	 yEOFwkvf25a8MDgK059xFxzKq3cnXL74p2TVGDg4F15y/Xoni0dklEb4rD7HFiJ31Tg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333820;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=cHptyhWveKRyrveCeVrsf2knK7nvNqr/kcjt08OW9IM=;
	b=EB57tB9d7XwuiMQRw2xlMmZZMczbTvRlnYVp3ixyQAM6lB19WSNTFMhEwm42vYQdt/K7
	 7bERL40gzALX0RoLBgBoT+in1Gfdzd3Czu+FMz1TzYTLHBi04PkK29zmTfhDdsiHYCmJI
	 iTTzlOG0JSWWQALwA4EWBwQj2SLijn80fQo3h0NLV9bp2a+54CzOlLcvYhANLrj6K+2+f
	 ujYLJd6rRNZscURxRznHXjV176Du8HsdcwzhY5pljni07shDCmWrOrtbZFfIu4m+Bcn0J
	 cuERzvSzy2csTyU4Pih3ncHCQlVRDfdESPCqiZrK8uebxNS3a3koAPxIrI9ZIiH80LQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=c7r3Lhv0;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=O04uSWiw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.82
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED26606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ED26606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=c7r3Lhv0;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=O04uSWiw
ARC-Seal: i=1; a=rsa-sha256; t=1794333796; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=U6RThykXquFT08DXZ9YwqZ3a7a3UWD4HjEO65taUyWk8Ep4Sra9oZOvx+nQQRDsjB7
    /L6lz5r88n3NMK3cfvX4O1bMiiwbhqquhh30/ILlk+7WQjY19H5ouH6M/lqKw40z+wCF
    +ZO4hRRkTcSg63RYwjkGrzO0etI5F5Y5ygiSFq/1ECiC6SRSAmYC808grurE66x8Sigt
    tu2QZZVP+0IMGbnCGtks2XCjOIOuU1SRO2xN9uXA7b3Xe0zwJr3ECxV1lZF0gLRje9I1
    BEJ5OmcpdMSNbmBHi2KkA2CWZ96RufD5u37vwFN9crxP7PWN3Icpd8TIt1+oJz/gpJpP
    xEqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794333796;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=cHptyhWveKRyrveCeVrsf2knK7nvNqr/kcjt08OW9IM=;
    b=dXffBMYTH+K95cAb6Ra/JPDkQOK4H2SPpkblvqukAU3TuyFQeBhE9OWA9PdXYwhUuL
    xsSL6j6emjuqkYOMg5ytEFWQLCMK/SgUIB6jhuNERG9dUIB8frmW36YfPSDtUywX3ISV
    84ZBKchWhv7Ruqn7/SOpboXSx8kw8tuH/3z7CL+t0zuga+AlJNBT1ABFbU7G914j0Sb2
    bPF+R0ZjPks6HSmvwkunOFhIxs5qGQcwAzQ9c7pJwNBPcptx9zM3BAwP0IenDse27Tnf
    FBKA28nRZQavuDjRbMU4DePMHZ6bGGgEl5HncapbmQYn2Yd7i0b1rffx5Tl1Tk/2T+gf
    81KQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794333796;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=cHptyhWveKRyrveCeVrsf2knK7nvNqr/kcjt08OW9IM=;
    b=c7r3Lhv0mkQxUl/wqVB/cY61WqCpRfx3bwzpsLZmRHJAj4QVMY7UA5n3Dcx4HMjwGd
    7lmB3tCNT7zhPm++aPgF9o7lJqwTLtBMytco2qnUHEyk7o3l13+2Ecf8UbpglfFnEo9T
    OrK7IHD5kAepGClcQpI9Pr2igPbK3RkSWsIG5wxtZ3DXIa16PuNjAEwHCGgxeaihr85i
    aDZXLpCN0TVJxzHC3hCkBKRMv9Y5PFFhrSsEulkU/mQEZzPu6PgrIpKmSlrnH5aE+PQn
    tQuszJv+og34Q2aIPHgrOM3md+L8hwOMxzOmKJcXIgtOsBIHMKEjezjhFovd5pljFHFr
    5sIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794333796;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=cHptyhWveKRyrveCeVrsf2knK7nvNqr/kcjt08OW9IM=;
    b=O04uSWiwrciX8tB/YdBTd5U7wJryYOKBmrJeGehkC154gqR3MN6cj43/ox25w1vYsS
    yy+wzT0NUvCPvh5uiTBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AAI3G1d7
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 10 Nov 2026 19:03:16 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 6.1.y] can: raw, isotp: copy socket options outside of lock_sock()
Date: Tue, 10 Nov 2026 19:03:10 +0100
Message-ID: <20261110180310.792162-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201813-failed-6.1-43c973a0887d@kernel.org>
References: <20261109201813-failed-6.1-43c973a0887d@kernel.org>
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
[ backport to 6.1: This tree has no raw_setsockopt_locked() from commit
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
  <20261109201808-failed-6.1-962947b69589@kernel.org>
  <20261109201810-failed-6.1-0f3ad9ab40e3@kernel.org>

 net/can/isotp.c | 100 +++++++++++++++++++++++++++---------------------
 net/can/raw.c   |  25 +++++++++---
 2 files changed, 76 insertions(+), 49 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index b89469e69d6b..ad72d9357003 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1648,8 +1648,8 @@ static int isotp_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
 	return ISOTP_MIN_NAMELEN;
 }
 
-static int isotp_setsockopt_locked(struct socket *sock, int level, int optname,
-			    sockptr_t optval, unsigned int optlen)
+static int isotp_setsockopt_locked(struct socket *sock, int optname,
+				   const void *val)
 {
 	struct sock *sk = sock->sk;
 	struct isotp_sock *so = isotp_sk(sk);
@@ -1660,11 +1660,7 @@ static int isotp_setsockopt_locked(struct socket *sock, int level, int optname,
 
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
@@ -1689,55 +1685,37 @@ static int isotp_setsockopt_locked(struct socket *sock, int level, int optname,
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
@@ -1751,13 +1729,49 @@ static int isotp_setsockopt(struct socket *sock, int level, int optname,
 
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
index 537e82717488..9138fbcd0027 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -776,31 +776,44 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
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
