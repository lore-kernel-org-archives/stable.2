Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795612819;
	b=bZBKaHcjCzzh6sM0PIgBpwN4L0vubrGQtnxcQkijqjUBRDKsauYC0Aon9T0fYJZEHwy4
	 LLV9lXzb3foK/GXu+CubZ0isw4quj+zuTuibA0ikKsv8ub27r45qz3Cs6XcYzIUaIA4BK
	 zcnzl/Wrl+c/mG9ZPhq2o5bVGjPH/wTA7go5r31pbTcsSetyXeIar41n5Beg9cHn1ZuVe
	 B5sUQZNpp1tUqAxRi1ePI15AK5ci6wBZKe8fblFxJsQ0P4cPVV7s6jvcvzAEMvF8TO8iN
	 Z102tugtFOQZp7csncdYgcscPce1vkJPlYA+y5xqWKTScSBQm6yO3wH/zMA/xhNr9lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612819;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aicxwI6NrMQQBKmYRf+g6l69zfEGctmMCopzx1BOaek=;
	b=bknidGVp837Eka3hiVLmIG0n/WYEmGqohNzmScefZx21yG8YeBaL5fkylxK6keYZprK7
	 +kH8IVwzf0tBoIldfqlD2u5kymUcA26zFLfc4pJFQLppy2HcLndIa2AyIW3zgtj8zQyyt
	 L29fa20cCqijnvwHAPw53DrLBqtbo3HNgwXyOUiS2y1nV7BIqVxFRzFljjXET1NLw/9Dn
	 7M0vdKvRAoXG+51HRH4Yjuy36ZxWK1ONbLCGZ7KX/0n/OBrORuJPf5Q6EGPYFa4N6QFKt
	 opSQq/AdoSzLpvFd5tPbYT5dq/PfpePkgkTnNAZBTnefoNxythy3NGo7kC4lu3UVHCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m5p1Qukt;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF1F606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AF1F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m5p1Qukt
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15ea896ddc8so9572905c88.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 05:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795612818; x=1796217618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aicxwI6NrMQQBKmYRf+g6l69zfEGctmMCopzx1BOaek=;
        b=m5p1QukteTAQr7YEafSGm8m6HbMu99mOZvwXQ5mPMeMk6ieik1A3pHj2WQedPJJYY7
         YbKibQyl84MWZfHVlKjkW2z/LUdA89AKXgN4XXfSaDOpeTTtbwMxxbnQVqnbjUDu0Lqb
         MVbWV6ggvwtF2dugb8IYS4CSmDixupH26no4D9T15KUHhqTGMZewFNi0uYjvVr6yl5//
         NYvWTJcPJ367x1AAofwFnXZl5LqxEOmRJpVIaCFq/BHCphntl4frQwFyaGCVcdIKvHAS
         DeUyaX+9Lxu2hW+eiaajryxPeCNHhhDbPU1QLiHOPI64Px3MmSNdCOwslFNYnK0YhgiY
         w+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795612818; x=1796217618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aicxwI6NrMQQBKmYRf+g6l69zfEGctmMCopzx1BOaek=;
        b=F5AAxPUFZt7OZTQVywSDEL95RxyP90VLAUf420xi1sSdftLlMQDn1s+cPhxOE13hEW
         5tEnAamqUtnXBFBp+BurxJtnEpdSuj3+ugaLXdV24BV9a138i9zUDB4Ymywep6r0KTdy
         zqy0xB1VTeZ+2MVsFZzIo7GeQzz8T6xwmUpyP0GA7ozvM/G9DLk8n34RRS8TPqHFlz+D
         hOfqdzGyNQI5Dv6nyHEFOMiSm8osPJVI3V/dJwcCm6pdOE2R4oLUvKeo9YBdSxV/iHf+
         6BPLCqV3wNiIxB5xbK68rVv/cll96xCDGDBoW0bsTGjh1OTQP1lLQ+PuY+uO0nRkT/wA
         NO9w==
X-Gm-Message-State: APuU4Z/x29quE9v5ovjarErmzyn0dVnkI0wmgB+rC/3+blhdh6oIChWT
	wNjcGBeziKwzOv3qUmfe7iEbmvAaPCrru0RzGMDDfjYxDRWDmxpoP/Ndyuu/FA==
X-Gm-Gg: AZFdTZcO8wXf5OZixPBd7p/8r/CKT52/Gle47obmOxWX7SsqykYMq+u8xhoLYCPxsxZ
	oVuwwyJE7WbnSqXGw16m1LOZQmA7N9q5wzsUCeKI872EieM7bQmYCd5l/AvcsZAtkbeLsfk7TXC
	ooFhgpqW2CraguMXdqg+4qLdZbFCbIsobzC6c1bXWRTz60BaL8OWlmjPzI0yLKDjpkPFDb2xcM5
	Z4rYj0+O+7tLPSl6uNjMIYq/sBFJYmrN+tKvaOS4ipI4G2eIJNlb4Cx3BeL+9TzxloENo0+0d1g
	bvaX3bhbMjsDoMByWzl3vP3ZX1wlL0tbWNl83B3/96yc6jIeKA2c4Fi/W5wQdfU/PcEmmxMB+jB
	kAS4FenuvKNM0vKukQ850K4TVwE096OBsbX6dCnueFeaW/CxO5CjclGJ4EX/AORlEgYHXZvwlIC
	19s9NiJbqDgHaRb8slWyynd9iQ8n0ORxhhE/CpVmngioxsHskuYxjQ4TJMrVfw18/b232qkuhEs
	QMaxa3ruJ0pGMwG6Sdn3TLZ/RavwmZqvwqxT9Byi4tCM92UH73KmTNJfjfV++A+FlHhRo11Suf8
	1t72y7VLdYzZYBJwxCHE70URhbEfSJEj30vYpmoBsw5ya47vkGiNsHzQ5sVnYmrEDCIQGH34n/+
	hwE/8v+CCrQTqLL5V2RmbpQ94e/cUZIVAhg==
X-Received: by 2002:a05:7022:f907:b0:1b2:558a:d781 with SMTP id a92af1059eb24-1b5567b5788mr15916701c88.5.1795612818146;
        Wed, 25 Nov 2026 05:20:18 -0800 (PST)
Received: from v4bel.. ([211.209.222.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556840494sm43081206c88.12.2026.11.25.05.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:20:17 -0800 (PST)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	imv4bel@gmail.com
Subject: [PATCH 6.1.y 2/2] ipv6: Remove IPV6_ADDRFORM.
Date: Wed, 25 Nov 2026 22:20:00 +0900
Message-ID: <20261125132002.3345611-2-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125132002.3345611-1-imv4bel@gmail.com>
References: <20261125132002.3345611-1-imv4bel@gmail.com>
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
[ Hyunwoo Kim: Remove 6.1.y UDP-Lite conversion handling and
  the now-unused unlock label with IPV6_ADDRFORM; keep the older
  inet_accept() interface. ]
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/core/sock.c          |   4 +-
 net/ipv4/af_inet.c       |   3 --
 net/ipv6/af_inet6.c      |   4 --
 net/ipv6/ipv6_sockglue.c | 108 ---------------------------------------
 4 files changed, 1 insertion(+), 118 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 211eb9ba9a29..b2ddba9528b7 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -763,7 +763,7 @@ bool sk_mc_loop(struct sock *sk)
 		return false;
 	if (!sk)
 		return true;
-	/* IPV6_ADDRFORM can change sk->sk_family under us. */
+
 	switch (READ_ONCE(sk->sk_family)) {
 	case AF_INET:
 		return inet_sk(sk)->mc_loop;
@@ -3697,7 +3697,6 @@ int sock_common_getsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	return READ_ONCE(sk->sk_prot)->getsockopt(sk, level, optname, optval, optlen);
 }
 EXPORT_SYMBOL(sock_common_getsockopt);
@@ -3724,7 +3723,6 @@ int sock_common_setsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	return READ_ONCE(sk->sk_prot)->setsockopt(sk, level, optname, optval, optlen);
 }
 EXPORT_SYMBOL(sock_common_setsockopt);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 73881ce0ca56..61a3ad6259a0 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -566,7 +566,6 @@ int inet_dgram_connect(struct socket *sock, struct sockaddr *uaddr,
 	if (addr_len < sizeof(uaddr->sa_family))
 		return -EINVAL;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 
 	if (uaddr->sa_family == AF_UNSPEC)
@@ -768,7 +767,6 @@ int inet_accept(struct socket *sock, struct socket *newsock, int flags,
 	struct sock *sk1 = sock->sk, *sk2;
 	int err = -EINVAL;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	sk2 = READ_ONCE(sk1->sk_prot)->accept(sk1, flags, &err, kern);
 	if (!sk2)
 		return err;
@@ -851,7 +849,6 @@ void inet_splice_eof(struct socket *sock)
 	if (unlikely(inet_send_prepare(sk)))
 		return;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 	if (prot->splice_eof)
 		prot->splice_eof(sock);
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 49031e40551f..717f92db5ede 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -454,7 +454,6 @@ int inet6_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	const struct proto *prot;
 	int err = 0;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 	/* If the socket has its own bind function then use it. */
 	if (prot->bind)
@@ -592,7 +591,6 @@ int inet6_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	case SIOCSIFDSTADDR:
 		return addrconf_set_dstaddr(net, argp);
 	default:
-		/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 		prot = READ_ONCE(sk->sk_prot);
 		if (!prot->ioctl)
 			return -ENOIOCTLCMD;
@@ -663,7 +661,6 @@ int inet6_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (unlikely(inet_send_prepare(sk)))
 		return -EAGAIN;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 	return INDIRECT_CALL_2(prot->sendmsg, tcp_sendmsg, udpv6_sendmsg,
 			       sk, msg, size);
@@ -682,7 +679,6 @@ int inet6_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	if (likely(!(flags & MSG_ERRQUEUE)))
 		sock_rps_record_flow(sk);
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 	err = INDIRECT_CALL_2(prot->recvmsg, tcp_recvmsg, udpv6_recvmsg,
 			      sk, msg, size, flags, &addr_len);
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 2924aa45adbc..9709ba8747d0 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -418,105 +418,7 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		rtnl_lock();
 	sockopt_lock_sock(sk);
 
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
@@ -996,7 +898,6 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		break;
 	}
 
-unlock:
 	sockopt_release_sock(sk);
 	if (needs_rtnl)
 		rtnl_unlock();
@@ -1147,15 +1048,6 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 	if (copy_from_sockptr(&len, optlen, sizeof(int)))
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
 			return compat_ipv6_get_msfilter(sk, optval, optlen, len);
-- 
2.43.0

