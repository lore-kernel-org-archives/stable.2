Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.84
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794333961;
	b=bva5aLp4d0FWU//ZVvhFVdOkJn1HqSBOVmFBCsdcJPTKdDIJj5K7pkw8hSFK0Crf+l5p
	 rGILK5y1fe1ogrkBw9DvHiys4JGf9xqVaCThinTe+gORRsrn1AzdiM+sK5fPo7MVBIOA5
	 3X9DlOarZrIRoCxm8qXb5Miq/py28hlt7FvPTNhjdpOAxK5OxEultmh42pXn81bIyfb0s
	 KtZy2Gg4Mn6aVkKpDP9j7KaVLfBYpjRQJorSujOMpApUwB9St26bOD4i06OU+YfXaQyy5
	 KhC6ti6WNcAB7aK4r4ToLUp1El1lgmgS70vzieN4bS5ksHuJiPS3L3E2jFYFH0Gi5Zw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333961;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=QVoxcb4tiPcEIWckN32SEDBqxMIKGtDxDk9og2MAELI=;
	b=ZWGDmzAEUwN8z5PyjsgIQsUO+Zucnssuy6pACiCpNpEBXRE3wCD3l8rtGi+0vbcujGvg
	 iBIELtvenoAaDNGnZ+0KSCg0nbWCBUOvWiLL1pQhThoAUQgCJKjCFlZjgXzUoEApnQeKS
	 M1MxkWNk3yea3guZqCVBxTJNlRdBdoJr3DYGGeKrJM5CHAxfoY/eUPOCrav/uc6wXdHYe
	 WeZd6Yb4K/9naqB0IPEiTK408nLtYyIgnuVqjtkq6gK3E6IkIDhwBrrz+OHl4b0iTwbvA
	 KQEAKe/7EdpZHHNAYnnra52yS8XbqeA1k4WqRF45Axd0vX2r9ZwKOSQBSZgtXGl5RpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=GcwkeAbS;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Upbv9Kqm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.84
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8C1606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF8C1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=GcwkeAbS;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Upbv9Kqm
ARC-Seal: i=1; a=rsa-sha256; t=1794333950; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Ui3QdgCFZV7SL1OamkU5SuYzV+W2nrO2L5yipVv5Ya0Hard1HRtVPtM5oisxJCrvk5
    DQka86j6EOONidwryMMDtdTl4kLWXWUEqSr7lo8BQlv9UN4+5WyMW13DhnpkzB5wiGRo
    XGpT7+CDiduHgzrTTwQ05Tn3EC0wUcYB6DqLaCodswFKl1V1bN4q1b+OWG1q8IAPpoeg
    8GpjLTSR+fckgKxx6lDhh0MRdh5OtRORoySTxZNFOnR0bByhZM6U+tunEfMHhlkcOZZp
    0+OLCKY0aNSx+nb5s6uyXwRiUFVOazEC4/2sZsSd1Cu4KEQyo1jyrcsgfdis4O84d5MH
    qOpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794333950;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=QVoxcb4tiPcEIWckN32SEDBqxMIKGtDxDk9og2MAELI=;
    b=oMOH+/GbU5MaLht1eJDKIZfJ9F6pkV9jYEpRtGlMHYTQLSoTToa6A6d03wNxEgNDzG
    oCbsuViyOxcWHNgLQZN6F1jPt77RtxiMG+WbHKr74g7QIJnQ9TD8q+8+P0w7b/h02+gQ
    SYDSS2mwRcrWqGqYTRuTrtxL6x7lUUrSZwIbRsQ5Z2kJhk5WCeIuvmi0UURZaQU4JC0N
    Rw0EJrqxtAnX56y5RpStYI6m4FUEurUvx6q9JCkNIN6ut3aMgi2cZt4EI2QLz2RI2+1W
    oHHaDkaUutiXYQjylosjQMzkEPDqfN3+OZFtm+EEU283y5OMoG0upECe4ta0ek3OLlhC
    1a2A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794333950;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=QVoxcb4tiPcEIWckN32SEDBqxMIKGtDxDk9og2MAELI=;
    b=GcwkeAbSEcQAjby4aymZiculZV085jJj9Ty8raGG8AZekHuoDHIPv/ipSyZiIZ6U5b
    Kfvgrb8U7p7Vhqv/m5VXZ3TqjCkwxIKu6kYTpvUTUSw2dVDM8xXfSPwXn/iQ2ot5nzte
    VwvKd/V0pgqrJi50bNhqQZQF62NewK6apSVGD9lLeclcHzGvG6mklLT0fBvcmZjpdgT/
    PJzvylMUIOQwhQCG9I/NQYPXE7yg7sSRpvACQQTgczHucMbUFkHSspjIaGwRlVrsGHZ3
    8g/LoiFX8Elc1n6xmIyP7YAaAnT10YFrSdekSlSwYxGChwNe2MTK/nwMos5uc/U0ydne
    ACHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794333950;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=QVoxcb4tiPcEIWckN32SEDBqxMIKGtDxDk9og2MAELI=;
    b=Upbv9Kqm3W0kaAD1jew3HxfkiYg+Iz7Kh8n02tbrfR9RNiNbSah5Ffa4B7eVPt5sbt
    9SeVSyucq1m9Qk7xCVDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AAI5o1di
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 10 Nov 2026 19:05:50 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 5.10.y] can: raw, isotp: copy socket options outside of lock_sock()
Date: Tue, 10 Nov 2026 19:05:44 +0100
Message-ID: <20261110180544.792332-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202744-failed-5.10-43c973a0887d@kernel.org>
References: <20261109202744-failed-5.10-43c973a0887d@kernel.org>
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
[ backport to 5.10: This tree has no raw_setsockopt_locked() from commit
  1e5185c09058 ("can: raw: add locking for raw flags bitfield").
  raw_setsockopt() already copies all option values from user space
  before lock_sock() here, so only the raw_getsockopt() and isotp parts
  apply. raw_getsockopt() uses copy_to_user() instead of the
  getsockopt_iter interface and truncates the filter list to the user
  space buffer size in this tree. Keep that behaviour, duplicate the
  filters under lock_sock() and copy them with copy_to_user() after
  release_sock(). ]
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
This backport depends on the backports of
  962947b69589 ("can: replace ARPHRD_CAN type checks with can_get_ml_priv()")
  0f3ad9ab40e3 ("can: protect the receive lists with a per-device lock")
sent in reply to
  <20261109202741-failed-5.10-962947b69589@kernel.org>
  <20261109202746-failed-5.10-0f3ad9ab40e3@kernel.org>

 net/can/isotp.c | 100 +++++++++++++++++++++++++++---------------------
 net/can/raw.c   |  17 ++++++--
 2 files changed, 71 insertions(+), 46 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 2d230cefbb3f..d4239b497632 100644
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
index 262277783cc1..723495f2c6fc 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -755,23 +755,34 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 		return -EINVAL;
 
 	switch (optname) {
-	case CAN_RAW_FILTER:
+	case CAN_RAW_FILTER: {
+		struct can_filter *filter = NULL;
+
 		lock_sock(sk);
 		if (ro->count > 0) {
 			int fsize = ro->count * sizeof(struct can_filter);
 
 			if (len > fsize)
 				len = fsize;
-			if (copy_to_user(optval, ro->filter, len))
-				err = -EFAULT;
+			/* copy to user space after release_sock() */
+			filter = kmemdup(ro->filter, len, GFP_KERNEL);
+			if (!filter)
+				err = -ENOMEM;
 		} else {
 			len = 0;
 		}
 		release_sock(sk);
 
+		if (filter) {
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
