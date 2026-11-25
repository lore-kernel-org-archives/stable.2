Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795612880;
	b=msxBN37U/hzrnxSGBvEvvTAOW3MLn7X+oSTxioCGWtjBiX/5+6SKteFthiRh92w1p5l5
	 Lel06vHT42asT0nSzsSqcMCo7yQbnwv57hZcqBG1F4MZyf70VujwC3FleV4UCpNmWgw/W
	 /fu3jO0dKF96NdDTbWNx9H4jmC5nh/Q/oVR/2WW7gRa+VVOBg1fUdKyM6L2qqRXv8UNe8
	 efLxqHO62pIHIhmYpcvSk0HNbTZKm6S2fcH8MQ7Qd7su9s7Oh++7LQIMWd8HNLuecCBk1
	 YmT+7kX/JjGN5IJw4508uAH13I4lxTRGp9Zaz5bGY5DnCffiBzvN5dcSqgoiz0d6VEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bJm9uVH0Bs7Of+G+WbstAS0wcCE4W7pJ9Bz1KuPI+3E=;
	b=t/1F5pXcuPEA0dGXbBCsBCxU5yZRTgmeM9DIfQoqoqhcfbcYh6CBfDIy56q7PoEEPSCd
	 EVn5gjHFgiCX5zSH03dOqYi3X68wZn1s2dPZKMDdFN1pugISKBqrEDsVHwyA/7uockhZs
	 iA6EiG8pt/XLfN4YaDp48m1BXSLoWYGBXpE7PdIIbN7onyGMLNrROzcgTYbfRWmrOAbhj
	 cv4B6G6hWvVkvqSsCcqcbOH9E+f53RZmcDIqpHIZ2yUn7wqYiR+IiC1W2cmY3JYFTy6Tf
	 zhOFzlJme9uq5a7qyylYROp6vtm32a4jNXG7lfYXIOS/BMC2gJpKSuZxEnoUxQ32FnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C0mm2dGr;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F20606A331
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6F20606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C0mm2dGr
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso12269152eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 05:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795612879; x=1796217679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bJm9uVH0Bs7Of+G+WbstAS0wcCE4W7pJ9Bz1KuPI+3E=;
        b=C0mm2dGr7moGZBxK+6lz9/RcEPawG2ikg/G/07zj+i6jVyvSJVz8uJMc+Ayl9g4SMs
         HdV9E+qtw1/jpDRJHnvI0RWf1oLewQ5R8Vv19D9q6GpX/K8KhLJoy06/GTaJFvYcdO8i
         Fi0zGyZmhiSVE3lbq4bAaqmp36fUzixTOI+X7HdOVNn0nHF41p12GtvnnR5dYESlkxH7
         nesbglrwknMQpHWS71PBkgGdygFmUmAnCzs43ZkkY8RG1GG2ROZfbqvS5l3SgQ6KWO3R
         L7P4aLWsJh7s297dUs5CaRoZEkvV+ifHByOdqxcxQsFhtP/V5okzQ3TXdZNero551xTG
         fUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795612879; x=1796217679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bJm9uVH0Bs7Of+G+WbstAS0wcCE4W7pJ9Bz1KuPI+3E=;
        b=R9sHLvswACNuO8olzgyKT6bxAr2kevyuGxJBwC3D5x+kmm31j2Z8CwmeYwvPllwwQg
         E96X3RgzzyOH9vIA3eGSXSMpTv36RXG2APtYMcxFUOgd1pD8K6YRp/LcTTdt567smyVB
         cnNXwncBNuesKJ5qHWjo5Fz2xBnTKKa4aovsDsfIpQGx+2HMnWG9iaE5dOAPLe7/5ju/
         DnFmZ7hjLLkL8sBQTiUZ+2VSRXbfLMbC8YwfXKJWnz3fpUMkqXR4qnNR3RvM9oAWd4CP
         a9dbVmvNchplZd4paYCt4TSCsSSg3RVcYJ+lUMiNZorfBDAKeMRwVAWBlRYGnD0n+zTQ
         pnJg==
X-Gm-Message-State: APuU4Z83RNObvKm3Ei8zzKqLFGrdts+b7aXhlaWBCHTiOxlsru1ggowl
	UdGnX6/0yNpDAWlF6QrAvdPMajj9Mt8blUg7l1d+VNYpjl1a1B3mGWQ02skr+w==
X-Gm-Gg: AZFdTZcK0EuCvC1C4+zSGYIdBfm21KPmh18HzASbLkq0k4fPlf09sMgwJCOcFP5aoml
	gVAPZUqKzrpYBtJCu/XEV6G1Z8LuSEhxu8QOi3W/U1AmNqa20by7WIrM9xg1rADRwn7Dls8UA97
	i+5OnwG5bZ3wOBu3aHtkEEOTgSHza4LCOOaUX0NJx5j8jOWYhfI0l+SxYMUjHaTUQamOJEjiRR+
	C6kCGZEPnllM0jFcTq51nP27qCMJWwGDUvIbBW4LXPKqFftxh89lUGdXKojE6q0XxlWwdQMUMvt
	qpo/liPn/zyg4mo68SB4Ood/ZqBbvMoTmyu/NxkFuX23qScPRSOsi4QlxZu3i0zVXAzVKbt/9tN
	R98Z9l672tyYr54imKMqPmoaEukxoJw5A5c+KCpxpzdN7HWc+PdNauQ8hsTLMkMomQs+64OOE7V
	2h/hbI5qppdy8Ok9mMqorZjw7csoQlV9KdHhlT+QgaUuvOtZQDOln3sXWbN0dnuz+WNQweJp7uc
	0pn1riUSjfX8rZwisltIuKnl/m4JeHevtaocYSE+lX5C+Bxj928s5jjWGacI578d0EixwS4cxfx
	WLxiJs+bVn5LTvJTUsQ1HH2AvGAXAwhHoSmn/pSprXkR061jTCwGSiKeb51ojUCUtX/L189Y0EW
	oyf4QQ2UdvmbKGQrpUsL9gXZo7WuUyyfbGw==
X-Received: by 2002:a05:693c:42c5:b0:386:bc42:b5bd with SMTP id 5a478bee46e88-386bc42b660mr6541790eec.25.1795612878532;
        Wed, 25 Nov 2026 05:21:18 -0800 (PST)
Received: from v4bel.. ([211.209.222.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm45646768eec.25.2026.11.25.05.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:21:17 -0800 (PST)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	imv4bel@gmail.com
Subject: [PATCH 5.15.y 2/2] ipv6: Remove IPV6_ADDRFORM.
Date: Wed, 25 Nov 2026 22:21:06 +0900
Message-ID: <20261125132108.3345914-2-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125132108.3345914-1-imv4bel@gmail.com>
References: <20261125132108.3345914-1-imv4bel@gmail.com>
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

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit 31c5ea8a3296e1486ac34bccea452bfe8c0bb1f9 ]

Recently, IPV6_ADDRFORM has received many AI-driven bug reports.
Fixing them properly would needlessly churn the fast paths in TCP
and UDP.

IPV6_ADDRFORM was initially introduced in RFC 2133 in 1997,
but only two years later, it was removed from RFC 2553 in 1999.

In 2026, modern applications natively support dual-stack sockets;
notably, systemd's socket activation does not use IPV6_ADDRFORM.

Also, getsockopt(IPV6_ADDRFORM) can be replaced with SO_DOMAIN.

Let's remove IPV6_ADDRFORM.

Later, we can remove sk->sk_prot_creator and revert commit
c26c192c3d48 ("udp: properly deal with xfrm encap and ADDRFORM").

Reported-by: Daehyeon Ko <4ncienth@gmail.com>
Closes: https://lore.kernel.org/netdev/20260902010408.1057857-1-4ncienth@gmail.com/
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Closes: https://lore.kernel.org/netdev/20260824033331.1084971-1-imv4bel@gmail.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260904033543.2635540-3-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Hyunwoo Kim: Remove 5.15.y's UDP-Lite handling and the
  now-unused unlock label; retain the older inet_accept() and
  inet_sendpage() paths. ]
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/core/sock.c          |   4 +-
 net/ipv4/af_inet.c       |   2 -
 net/ipv6/af_inet6.c      |   4 --
 net/ipv6/ipv6_sockglue.c | 108 ---------------------------------------
 4 files changed, 1 insertion(+), 117 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index b81f198ca61c..1c16fe7a2aa1 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -715,7 +715,7 @@ bool sk_mc_loop(struct sock *sk)
 		return false;
 	if (!sk)
 		return true;
-	/* IPV6_ADDRFORM can change sk->sk_family under us. */
+
 	switch (READ_ONCE(sk->sk_family)) {
 	case AF_INET:
 		return inet_sk(sk)->mc_loop;
@@ -3430,7 +3430,6 @@ int sock_common_getsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	return READ_ONCE(sk->sk_prot)->getsockopt(sk, level, optname, optval, optlen);
 }
 EXPORT_SYMBOL(sock_common_getsockopt);
@@ -3458,7 +3457,6 @@ int sock_common_setsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	return READ_ONCE(sk->sk_prot)->setsockopt(sk, level, optname, optval, optlen);
 }
 EXPORT_SYMBOL(sock_common_setsockopt);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 894bd396270b..4ca3e414f87a 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -569,7 +569,6 @@ int inet_dgram_connect(struct socket *sock, struct sockaddr *uaddr,
 	if (addr_len < sizeof(uaddr->sa_family))
 		return -EINVAL;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 
 	if (uaddr->sa_family == AF_UNSPEC)
@@ -749,7 +748,6 @@ int inet_accept(struct socket *sock, struct socket *newsock, int flags,
 	struct sock *sk1 = sock->sk, *sk2;
 	int err = -EINVAL;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	sk2 = READ_ONCE(sk1->sk_prot)->accept(sk1, flags, &err, kern);
 	if (!sk2)
 		goto do_err;
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 4d5f5f2585da..bc1377e35b1c 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -453,7 +453,6 @@ int inet6_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	const struct proto *prot;
 	int err = 0;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 	/* If the socket has its own bind function then use it. */
 	if (prot->bind)
@@ -591,7 +590,6 @@ int inet6_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	case SIOCSIFDSTADDR:
 		return addrconf_set_dstaddr(net, argp);
 	default:
-		/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 		prot = READ_ONCE(sk->sk_prot);
 		if (!prot->ioctl)
 			return -ENOIOCTLCMD;
@@ -662,7 +660,6 @@ int inet6_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (unlikely(inet_send_prepare(sk)))
 		return -EAGAIN;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 	return INDIRECT_CALL_2(prot->sendmsg, tcp_sendmsg, udpv6_sendmsg,
 			       sk, msg, size);
@@ -681,7 +678,6 @@ int inet6_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	if (likely(!(flags & MSG_ERRQUEUE)))
 		sock_rps_record_flow(sk);
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 	err = INDIRECT_CALL_2(prot->recvmsg, tcp_recvmsg, udpv6_recvmsg,
 			      sk, msg, size, flags & MSG_DONTWAIT,
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 41e8b02c12c8..8c4e98de9483 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -417,105 +417,7 @@ static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		rtnl_lock();
 	lock_sock(sk);
 
-	/* Another thread has converted the socket into IPv4 with
-	 * IPV6_ADDRFORM concurrently.
-	 */
-	if (unlikely(sk->sk_family != AF_INET6))
-		goto unlock;
-
 	switch (optname) {
-
-	case IPV6_ADDRFORM:
-		if (optlen < sizeof(int))
-			goto e_inval;
-		if (val == PF_INET) {
-			if (sk->sk_type == SOCK_RAW)
-				break;
-
-			if (sk->sk_protocol == IPPROTO_UDP ||
-			    sk->sk_protocol == IPPROTO_UDPLITE) {
-				struct udp_sock *up = udp_sk(sk);
-				if (up->pending == AF_INET6) {
-					retv = -EBUSY;
-					break;
-				}
-			} else if (sk->sk_protocol == IPPROTO_TCP) {
-				if (sk->sk_prot != &tcpv6_prot) {
-					retv = -EBUSY;
-					break;
-				}
-			} else {
-				break;
-			}
-
-			if (sk->sk_state != TCP_ESTABLISHED) {
-				retv = -ENOTCONN;
-				break;
-			}
-
-			if (ipv6_only_sock(sk) ||
-			    !ipv6_addr_v4mapped(&sk->sk_v6_daddr)) {
-				retv = -EADDRNOTAVAIL;
-				break;
-			}
-
-			__ipv6_sock_mc_close(sk);
-			__ipv6_sock_ac_close(sk);
-
-			/*
-			 * Sock is moving from IPv6 to IPv4 (sk_prot), so
-			 * remove it from the refcnt debug socks count in the
-			 * original family...
-			 */
-			sk_refcnt_debug_dec(sk);
-
-			if (sk->sk_protocol == IPPROTO_TCP) {
-				struct inet_connection_sock *icsk = inet_csk(sk);
-
-				sock_prot_inuse_add(net, sk->sk_prot, -1);
-				sock_prot_inuse_add(net, &tcp_prot, 1);
-
-				/* Paired with READ_ONCE(sk->sk_prot) in inet6_stream_ops */
-				WRITE_ONCE(sk->sk_prot, &tcp_prot);
-				/* Paired with READ_ONCE() in tcp_(get|set)sockopt() */
-				WRITE_ONCE(icsk->icsk_af_ops, &ipv4_specific);
-				sk->sk_socket->ops = &inet_stream_ops;
-				sk->sk_family = PF_INET;
-				tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
-			} else {
-				struct proto *prot = &udp_prot;
-
-				if (sk->sk_protocol == IPPROTO_UDPLITE)
-					prot = &udplite_prot;
-
-				sock_prot_inuse_add(net, sk->sk_prot, -1);
-				sock_prot_inuse_add(net, prot, 1);
-
-				/* Paired with READ_ONCE(sk->sk_prot) in inet6_dgram_ops */
-				WRITE_ONCE(sk->sk_prot, prot);
-				sk->sk_socket->ops = &inet_dgram_ops;
-				sk->sk_family = PF_INET;
-			}
-
-			/* Disable all options not to allocate memory anymore,
-			 * but there is still a race.  See the lockless path
-			 * in udpv6_sendmsg() and ipv6_local_rxpmtu().
-			 */
-			np->rxopt.all = 0;
-
-			inet6_cleanup_sock(sk);
-
-			/*
-			 * ... and add it to the refcnt debug socks count
-			 * in the new family. -acme
-			 */
-			sk_refcnt_debug_inc(sk);
-			module_put(THIS_MODULE);
-			retv = 0;
-			break;
-		}
-		goto e_inval;
-
 	case IPV6_V6ONLY:
 		if (optlen < sizeof(int) ||
 		    inet_sk(sk)->inet_num)
@@ -981,7 +883,6 @@ static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		break;
 	}
 
-unlock:
 	release_sock(sk);
 	if (needs_rtnl)
 		rtnl_unlock();
@@ -1133,15 +1034,6 @@ static int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 	if (get_user(len, optlen))
 		return -EFAULT;
 	switch (optname) {
-	case IPV6_ADDRFORM:
-		if (sk->sk_protocol != IPPROTO_UDP &&
-		    sk->sk_protocol != IPPROTO_UDPLITE &&
-		    sk->sk_protocol != IPPROTO_TCP)
-			return -ENOPROTOOPT;
-		if (sk->sk_state != TCP_ESTABLISHED)
-			return -ENOTCONN;
-		val = sk->sk_family;
-		break;
 	case MCAST_MSFILTER:
 		if (in_compat_syscall())
 			return compat_ipv6_get_msfilter(sk, optval, optlen);
-- 
2.43.0

