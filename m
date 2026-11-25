Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795612939;
	b=cbpIq9z7ILA6F96E5vhNn7n1BECgXbH2tFaS/OE7AoDHRiCl2tYJY4MCLhkiA/NInZcL
	 kYHfbhWiODuGqRWFywhQRj6+Qy01aN3u8pjhs1JuKI+dd37X1nEHV+QTXULPcheIcuKZe
	 GmYpELSdOiKgs5MaH8I3lerLRt5N/eToBuVp+/nLEoHrpikXEScoldrRbxBo7ygqz2Qtg
	 ipr5m8zi2edS9iDUHGsTnasUoXS4CDaNKYcjVkItrjS7c6+H+LkvNV4iEA5L/a3BkrEAo
	 ILfznn7UcGZN++kwlVfQtIxjUZ5yPhxQNeHgrN7t1IR5pTA6UrWjH2eNsBmodfuHrww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4pQsX1Q086T84xhF1YXrHKEbV7uhAm02wYX+QsKTnqI=;
	b=DAV+VV6F5GPufSKtBT27+Z/4VFVFFN7CicXgnzWLRxNfgzXJc82yWvwf17qlV6wox6LB
	 EbiLL/wz3+g+nJuB1dfbGQ9FdXcgUwy3rlW9K+YN+zbD3mgl9Zp4OAZCQKcKMDNVtFQhH
	 +A9dCAK1oshG+6IgDIv4mUES0nk0R2uhvFdwmW7D1GYGBsCZc9r4CQFw+m0srMweVZr8x
	 2l42ghRTCkvrsDc7w5TNX7tBB4z86AQMDiq9TEjX5Y2a7Z1jbW4OaNgqWKQnlqadhDHjt
	 HJiWdrqlr3iDUy98l7acZyWjK/OMiyQ4wBfF86GTFiCF8//4jrEoN2LRLwwZZy8HW/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XBhxmiQM;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089CD606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 089CD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XBhxmiQM
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f0458cc9easo45062045ad.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 05:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795612938; x=1796217738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4pQsX1Q086T84xhF1YXrHKEbV7uhAm02wYX+QsKTnqI=;
        b=XBhxmiQMWI57hJAlyVCx+i1GPm7s0A6/Kpv2+1l0pHcbstnmZKHMdJltgtP/SHkPOU
         jX/BsljyySSFMDPEGPMG8smbZBAwAHC7mMtEh+vqR3Bn+f0VpGotMjaIPpv3yKT1TgO7
         94LRioR3s/ueKs+LJaQQmmH4zsYX8H4sAfmJjWNyWWPvCowDeUS9/AvAi7RAdqsEOaeu
         JHwjoXuGdLwE9/yPvHEd/9ozNfSsouWHu9Qg6w2gg7w4AhtGTKU8o+0o5wboANywXXNW
         6ozgbuHd3q+9jlwodU7f/C7kVVHY7B/3TYGzA6GUXNE66X6wG8SsKrFdEv9b8pn/vuMi
         vtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795612938; x=1796217738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4pQsX1Q086T84xhF1YXrHKEbV7uhAm02wYX+QsKTnqI=;
        b=qoNmaW5pDmAZDsNl3YAjLOedrhVLiQKoLPgWrpE7nX3wv3RH7mPXL8wx9f5I5tmzEX
         K3QFwDFpw/5DAi18FPXF2Udl6ughzGMIfHwo0ERhnNYML8Bl/Qex19V2fVSMVulMD/Eg
         JFmyE4cyjnJcreAyM//TwT6fMl4UmKjokN/W0x8BJcLO43EjySh862e+SbBiL9wqJwxc
         cj5gnOs7PgWlKxzfczYydUNj1QSgf/Nw0lPYpSimAh4pAPablzL4BS/OkagnWSwzuiv4
         w1zk3AL6/U/QE10QXc/mQ6HQmLnU8eEQ6+yD+6x4bArUr+BcitRMMO89Cxr8mMYaoqeN
         nKTw==
X-Gm-Message-State: APuU4Z+ka/hqRuIAFW1VvbHaViGa11SmYIvxIKqEMwwtHdm9GPtaOmfF
	Zc5Paf3UNOrudlyJwnVLbS69iuwPAxpOuPCRAxADAez+GOv1RZEv0wjy7a0cKw==
X-Gm-Gg: AZFdTZfO5m0y2Ld2qASlpy7UE4TXTfnePkSOpSeh2h8Az0y+4aOMmaISHylKiF3oFBi
	bye6wAZWzOAjGW1OR+2jk1eAWdB+7/yZoZ3VKNCWBdTwKR9wW2zMpZ+CmOyP2zjiObWyfzTZTAI
	J/zIc8vECvcRhpoN6RXyPeJy4voNI5lT/CXQBvU0ybxoGXKyd9keQmPaSU0Zn8yr98r6cpFs7Tc
	cX59jOwrg80kTxmKhaLXxwj5dwuN2ae2rx66jbXt9h1X0vAfdpP/h3UFEO32lX9oej2n9H/2Vcv
	jL7R3bmTZzWcituUr+Q68W9L0V1L7htmFzKN1OA0yUKd0RiZX2/Hiq2JOaI0ZrqzmsOx1GDbRed
	ZseowiEj480XK/y39EMNIy90J6mAZ48x778XFcYUaML5my5bA00k7zBtd7DyIf0wJwGXySPmpjb
	JF7BtvL5wGdsIhh37PPbK9FDXS5LtwR9dFvETPDRMuY3IWGPFOsYrSKMv/74edFeNMzPt5tRww/
	M9P4nRaSr5LQGMD+s9D/MfWvRppjr6tiAk/3kUbhuKa1YFtTs+k3AXEGJTfCbCdRwg8igQiWPKZ
	CqGeIYd8OcdY28Vco70ybB0VkdS7k7eq4R1WarSsNetRLlVilis6nDXHBTbaSuh3IAxEe6Xlo8X
	cJvfxjI5vK+f2WChg4mRJK9UTe5XB1VyqQw==
X-Received: by 2002:a17:90a:e7d0:b0:3ab:e588:c275 with SMTP id 98e67ed59e1d1-3b41c8d4881mr14983575a91.20.1795612937942;
        Wed, 25 Nov 2026 05:22:17 -0800 (PST)
Received: from v4bel.. ([211.209.222.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad48786sm27907278a91.9.2026.11.25.05.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:22:17 -0800 (PST)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	imv4bel@gmail.com
Subject: [PATCH 5.10.y 2/2] ipv6: Remove IPV6_ADDRFORM.
Date: Wed, 25 Nov 2026 22:22:05 +0900
Message-ID: <20261125132207.3346169-2-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125132207.3346169-1-imv4bel@gmail.com>
References: <20261125132207.3346169-1-imv4bel@gmail.com>
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
[ Hyunwoo Kim: Remove 5.10.y's UDP-Lite handling and the
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
index 6cf0b1a7c2a7..0141a5f6e281 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -690,7 +690,7 @@ bool sk_mc_loop(struct sock *sk)
 		return false;
 	if (!sk)
 		return true;
-	/* IPV6_ADDRFORM can change sk->sk_family under us. */
+
 	switch (READ_ONCE(sk->sk_family)) {
 	case AF_INET:
 		return inet_sk(sk)->mc_loop;
@@ -3279,7 +3279,6 @@ int sock_common_getsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	return READ_ONCE(sk->sk_prot)->getsockopt(sk, level, optname, optval, optlen);
 }
 EXPORT_SYMBOL(sock_common_getsockopt);
@@ -3307,7 +3306,6 @@ int sock_common_setsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	return READ_ONCE(sk->sk_prot)->setsockopt(sk, level, optname, optval, optlen);
 }
 EXPORT_SYMBOL(sock_common_setsockopt);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 221f58e5fc15..683d07961103 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -566,7 +566,6 @@ int inet_dgram_connect(struct socket *sock, struct sockaddr *uaddr,
 	if (addr_len < sizeof(uaddr->sa_family))
 		return -EINVAL;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 
 	if (uaddr->sa_family == AF_UNSPEC)
@@ -746,7 +745,6 @@ int inet_accept(struct socket *sock, struct socket *newsock, int flags,
 	struct sock *sk1 = sock->sk, *sk2;
 	int err = -EINVAL;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	sk2 = READ_ONCE(sk1->sk_prot)->accept(sk1, flags, &err, kern);
 	if (!sk2)
 		goto do_err;
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index ace50b41b28a..59ced48c335c 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -450,7 +450,6 @@ int inet6_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	const struct proto *prot;
 	int err = 0;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 	/* If the socket has its own bind function then use it. */
 	if (prot->bind)
@@ -585,7 +584,6 @@ int inet6_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	case SIOCSIFDSTADDR:
 		return addrconf_set_dstaddr(net, argp);
 	default:
-		/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 		prot = READ_ONCE(sk->sk_prot);
 		if (!prot->ioctl)
 			return -ENOIOCTLCMD;
@@ -656,7 +654,6 @@ int inet6_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (unlikely(inet_send_prepare(sk)))
 		return -EAGAIN;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 	return INDIRECT_CALL_2(prot->sendmsg, tcp_sendmsg, udpv6_sendmsg,
 			       sk, msg, size);
@@ -675,7 +672,6 @@ int inet6_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	if (likely(!(flags & MSG_ERRQUEUE)))
 		sock_rps_record_flow(sk);
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 	err = INDIRECT_CALL_2(prot->recvmsg, tcp_recvmsg, udpv6_recvmsg,
 			      sk, msg, size, flags & MSG_DONTWAIT,
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index dbbe53260b00..30029b375faf 100644
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
-				local_bh_disable();
-				sock_prot_inuse_add(net, sk->sk_prot, -1);
-				sock_prot_inuse_add(net, &tcp_prot, 1);
-				local_bh_enable();
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
-				local_bh_disable();
-				sock_prot_inuse_add(net, sk->sk_prot, -1);
-				sock_prot_inuse_add(net, prot, 1);
-				local_bh_enable();
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

