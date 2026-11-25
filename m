Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795612778;
	b=nf/TH99awnJsG83/gYtpGVCC4JzekQDVyXM6GZAXPbKRQMHf2421SG2ITR3bgEgfJgTj
	 wUZ5DUkzYOLKF6wo8Zy9mA0OHOT7PAhwLqJTelqzkSyzBH3hLtaHE0onpmzuZxRGxagaE
	 HzmRtKdcToIUpLf6t3CHtqu1cngxOVTHIuJCH2uX+pkgGOyDNXsydZXooA9cNl6dqdNHO
	 taHsJfVBR3ifOooLSq0zVwJ81xRLvFHKybmJr1gIp75s5zeOuR3dkqxWdmLrLLAqIi4AB
	 oVsWJKiE3dhpXg7CGQK8rR2352LKUXTbKIx3pEAMRpiRCWiVR008tkNBTwbn1g402qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612778;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6X5mqhMNk9ntnLdlJF4osPvOR+hyiqWR8Zyk14VwQ+E=;
	b=h/bJoYUU2nRGocujH8k/ae2LZx2VdBk28IGeJTOhjVzhwn1pB2hgT/Q7p2UXaHsq9x2U
	 nf3pcVaAsRMQxsmSrtZzxXSgJjViEyr5KIaTxqWJ0+EETrDvxmaW6+piXv6rLfNJBIVNc
	 GtxF6clhCfJVxyGDcuECf4Sj2aKh2GaatRDOR3N1qFtVWrpHqrhkI5mZAiyaYzaerv9Hz
	 bYpII+V6woVnrZMByXP54zkD99nT/gDQKijo6+u817VTM4UK8z6BnZIEVs8Ub1+KeOaWC
	 Jb3xaLFFlzpXM8R0RLUKmZDU+W3DBMlW9qH9+LDLVhcSzdFQjTBmFfZ9E6lWJhYNXFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YOCl1ZUc;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E158606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E158606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YOCl1ZUc
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-386c4d2e2ccso2933811eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 05:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795612777; x=1796217577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6X5mqhMNk9ntnLdlJF4osPvOR+hyiqWR8Zyk14VwQ+E=;
        b=YOCl1ZUcBKIzo3Zm5PmPJ9t7EHM/ardDEpb2p4+MTu6V3riQANVL7xYyybuHo4Rtow
         cWqU4q7VeRYOBOZ10wM03fosH8RCXUFwu4k00VtJslslyVVWlhn91jtrP33cG7KKvXq9
         zVYa0e3Ltva03hpbLq7iwVdCfGy4HsOLAiotz1hEVyNSylAwCR89EboDyQjJ0q2tX8gF
         EJAF8SKRBcDOEZC/b+JlKOAVJ+SyipGJVjqg6nIAHQVwYUTIQk3UlyD0GazFl+jgLJ0H
         trppGAa0H9+Huj6Z0y3Zf+HuFShAvUHBnR5L3QGHAd2Su8+43YHoVLRl7mws4OFUVqor
         tvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795612777; x=1796217577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6X5mqhMNk9ntnLdlJF4osPvOR+hyiqWR8Zyk14VwQ+E=;
        b=bKfLS6tYOzRr1CYAtsjqfd32t/LHo7r8BPj6SAz7edePSyL6KrXtIgkVnQ0e5A36/R
         K5F+umcd9kqmGEnPtr7y6LhI4Gbbft/h9WXQcQ5GRGQza7XXgQsUX3DHRwkEToj4uowG
         3TuaZZq5iC7GvAXTtiVopSbX/2G1rJS+EuOn+ujLjzO6CN93s90AcrL1lQkTNvwBbMRR
         WzfpNJc48Rrc8RvtGP47O59JqqJwh0Mg077fDKPOHrYFyC1+pWT1cchpjvyWNrHG6Foj
         byFsfQ8qdnOEx7llymFv4bTOCqkH0hXkevfj0PXNtTtt7A/kuB/bjy6/VkCBPg6Mx9iK
         I+0g==
X-Gm-Message-State: APuU4Z/e8L8FdcTO5OA79+EFmiDcOCJYLQr4U3srt5vTgx0bIGbM+0u4
	Ar4pw22mH6fYPHwPkUz+em/ioihLrtEBD6VaxclzK8xpHEuxuQMp91XkSeB8Pw==
X-Gm-Gg: AZFdTZcG3b1y2vUxyTQngxd5GxzJo4sSbSfkyEHI0DyiivExENYTSKFlDIe9xg5h2rv
	nACtO7Hmwvvkh3Fb8TER0pmNMe/yam6B+lwbOSHQqpbHJTjIqlFIBr8yI1tCVdv0WRmEriM+ME2
	ZxiPjALmZC7tHm2L9bHDXiczIu/L4834gCzmk8aYQyzDQpmkFMgXt7rc9np+JkPEq5lN4GH4Cji
	qkrEYiyZQB66cFB/OFuXvwk72Brj0NVCA5ol4RsnBGPOdMzTeUbpePmxhDISgUiQF/JInH/x4yn
	HB6fxl7qQr2JhOBEqKi/3f5gnSYr47ac77GlLqt9Nkidkpdw/LFwdKoRLnS+zLdtETOlqN9o607
	tnd9LLR7GpseqLUeEOZqXF58rsUrYe8dYEMTMov9sS4zGZUnA9vgNKDo0PP34hyfTKGu7h3fVCv
	sBTHC1LiKdJnU3j9Mn7v6gHdC2P0aA74q6KMKvUJEM/82AhM9haxFEW2qXKmw78hT83KrPEak3q
	EctBhIIQ1ULH3pANcyb9aG1bYG8a0yg3uBDZ/rt+pZBy+O29UB5KLBqOTlDHKgXgheFudAYVMoV
	VRy8dvueBQyWPmBtDTpr7SOH+cQOqK/I8j7KNaSjzvTk97Iju8ud6FN/p5QlIWlXCoyUIjq8JYv
	okSR7nOqeLERqaonfimjzTZ+VapWX8M85TA==
X-Received: by 2002:a05:693c:8642:20b0:386:9e22:ca4c with SMTP id 5a478bee46e88-3869e22cc7emr16378496eec.35.1795612777034;
        Wed, 25 Nov 2026 05:19:37 -0800 (PST)
Received: from v4bel.. ([211.209.222.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm51253048eec.16.2026.11.25.05.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:19:36 -0800 (PST)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	imv4bel@gmail.com
Subject: [PATCH 6.6.y 2/2] ipv6: Remove IPV6_ADDRFORM.
Date: Wed, 25 Nov 2026 22:19:26 +0900
Message-ID: <20261125131928.3345385-2-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125131928.3345385-1-imv4bel@gmail.com>
References: <20261125131928.3345385-1-imv4bel@gmail.com>
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
[ Hyunwoo Kim: Keep the 6.6.y inet_accept() signature and remove
  UDP-Lite handling from the IPV6_ADDRFORM set/get branches. ]
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 include/linux/net.h      |  2 +-
 net/core/sock.c          |  4 +-
 net/ipv4/af_inet.c       |  3 --
 net/ipv6/af_inet6.c      |  4 --
 net/ipv6/ipv6_sockglue.c | 95 ----------------------------------------
 5 files changed, 2 insertions(+), 106 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index c9b4a63791a4..45bd92b817ff 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -123,7 +123,7 @@ struct socket {
 
 	struct file		*file;
 	struct sock		*sk;
-	const struct proto_ops	*ops; /* Might change with IPV6_ADDRFORM or MPTCP. */
+	const struct proto_ops	*ops; /* Might change with MPTCP. */
 
 	struct socket_wq	wq;
 };
diff --git a/net/core/sock.c b/net/core/sock.c
index 9c04591a1bed..0aab349934fd 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -768,7 +768,7 @@ bool sk_mc_loop(const struct sock *sk)
 	sk = sk_const_to_full_sk(sk);
 	if (!sk)
 		return true;
-	/* IPV6_ADDRFORM can change sk->sk_family under us. */
+
 	switch (READ_ONCE(sk->sk_family)) {
 	case AF_INET:
 		return inet_test_bit(MC_LOOP, sk);
@@ -3736,7 +3736,6 @@ int sock_common_getsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	return READ_ONCE(sk->sk_prot)->getsockopt(sk, level, optname, optval, optlen);
 }
 EXPORT_SYMBOL(sock_common_getsockopt);
@@ -3763,7 +3762,6 @@ int sock_common_setsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	return READ_ONCE(sk->sk_prot)->setsockopt(sk, level, optname, optval, optlen);
 }
 EXPORT_SYMBOL(sock_common_setsockopt);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index dd4e334a4788..8d75cee4232d 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -574,7 +574,6 @@ int inet_dgram_connect(struct socket *sock, struct sockaddr *uaddr,
 	if (addr_len < sizeof(uaddr->sa_family))
 		return -EINVAL;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 
 	if (uaddr->sa_family == AF_UNSPEC)
@@ -776,7 +775,6 @@ int inet_accept(struct socket *sock, struct socket *newsock, int flags,
 	struct sock *sk1 = sock->sk, *sk2;
 	int err = -EINVAL;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	sk2 = READ_ONCE(sk1->sk_prot)->accept(sk1, flags, &err, kern);
 	if (!sk2)
 		return err;
@@ -860,7 +858,6 @@ void inet_splice_eof(struct socket *sock)
 	if (unlikely(inet_send_prepare(sk)))
 		return;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 	if (prot->splice_eof)
 		prot->splice_eof(sock);
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index e009cdb699d7..e329473df4e5 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -442,7 +442,6 @@ int inet6_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	const struct proto *prot;
 	int err = 0;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 	/* If the socket has its own bind function then use it. */
 	if (prot->bind)
@@ -581,7 +580,6 @@ int inet6_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	case SIOCSIFDSTADDR:
 		return addrconf_set_dstaddr(net, argp);
 	default:
-		/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 		prot = READ_ONCE(sk->sk_prot);
 		if (!prot->ioctl)
 			return -ENOIOCTLCMD;
@@ -652,7 +650,6 @@ int inet6_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (unlikely(inet_send_prepare(sk)))
 		return -EAGAIN;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 	return INDIRECT_CALL_2(prot->sendmsg, tcp_sendmsg, udpv6_sendmsg,
 			       sk, msg, size);
@@ -671,7 +668,6 @@ int inet6_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	if (likely(!(flags & MSG_ERRQUEUE)))
 		sock_rps_record_flow(sk);
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 	err = INDIRECT_CALL_2(prot->recvmsg, tcp_recvmsg, udpv6_recvmsg,
 			      sk, msg, size, flags, &addr_len);
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 48fe3eb42f01..c6908912024c 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -443,93 +443,7 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
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
-				WRITE_ONCE(sk->sk_socket->ops, &inet_stream_ops);
-				WRITE_ONCE(sk->sk_family, PF_INET);
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
-				WRITE_ONCE(sk->sk_socket->ops, &inet_dgram_ops);
-				WRITE_ONCE(sk->sk_family, PF_INET);
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
-			module_put(THIS_MODULE);
-			retv = 0;
-			break;
-		}
-		goto e_inval;
-
 	case IPV6_V6ONLY:
 		if (optlen < sizeof(int) ||
 		    inet_sk(sk)->inet_num)
@@ -1124,15 +1038,6 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
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

