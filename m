Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795612720;
	b=iEVnv57WZMFORsGzmIgShyzTFntgGdxoIZFZZ/qzXsQ+XPVn+1QI5CxXDqvE9i+JqPNv
	 BCD69S+CL65rEwDcyNOcxZWlQwVuNZWKZldTkULQRwNdd0advYU68xdstEDebKOXivS2c
	 Htz2M2InRnfme6PzxQX54U4CDncvG7j8ImVtmtxnO0dEUl2jD3MLGtMA7K6KTWX7gE3pl
	 vQydPNrGt6CsjDfdi8XCVSYw8O9S2hvmT/jmRMVQouUC/wNwcCRgjpQ24R1D0KAtQSJnT
	 xSzrQHS+C8NmL0KzMGTv3QRFruul8+gy0h4k2l+DLZ+nfbQRClfgNzKdkgvF1rM0PoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zmQxbS2Pzyr403mMXc+EmnsoWsyXIcrAr0cIMkTXGRY=;
	b=obzNk6y88ovF5eZB918bQYsCLc9D3hfgD7u9rIi2asDTAXx/zPAc/MPCk0ffGnPmtVG8
	 5UOtQF0fAUBKKCIlLpklvG2RN7afVCF3NpsDRr7meDF5BkLArPwULjXYDph7rCee5nHFa
	 rTUiru1oN9TxcA81t8338fL6V+ln/kl09k/snsW3L9EVRei9ixEJMvss5q/Ti0JsJdzS6
	 mZY7Cvp0FYiV5XlEconLQeJVfxLJ5rWmCjVZn60WuKAbwEHMcln6lWe/kQcyUyJStmuo/
	 5u8WNh8rd+GCgIh2EBf5WxBtO+/hbHo/RL9tbPkBngM3kfpJOoZMJ1uIUrjNqXvpXdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="zs0UXdU/";
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20ED606A681
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C20ED606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zs0UXdU/
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1ae58d17cd9so6142951c88.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 05:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795612719; x=1796217519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zmQxbS2Pzyr403mMXc+EmnsoWsyXIcrAr0cIMkTXGRY=;
        b=zs0UXdU/zRHE1kSUgGbjeftAZpi43MHN61VetSLNwwKtDCJRGQaAOfnU+0yoN43ici
         rLRy+zWhYBYZGwPiPPbSC20v1HLo/QwwgJnX16LMAeiVDut68Q2rNMFp/VEUkIxiAvit
         skt0jdSbfbg6NGKURFb0VyamxjUmX4wO0Rcgpxl2eDbUWiP/Xt14opMpkGM/MvHXuCKw
         d2CPwO+y83kcsu9/zxMUtQw2PBHGbr9ZL3JkWoy7wxCGhUN3iTcAl/ctPAg7oGggATmk
         /8yhHBjgL7hbJmh4yC3TO9uClQ2xbPoBegVks1iXlFl7QKBJzOc1xgIq7XHvU9+SAPDf
         2pog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795612719; x=1796217519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zmQxbS2Pzyr403mMXc+EmnsoWsyXIcrAr0cIMkTXGRY=;
        b=O4S6Rah58syxSmYsiEKoP8jZLYQjYv3SuatciA5vXZ1fl6/dEns1IEvG7PBcb33DhB
         Xh7FR+i1UY0xvUgJQ8xyAM3CY1TpSzHucjLCNrZ50a0GECG0/xOJtjY9XkjmEnBGxtwV
         nV5PT+FjQcH6bPt1Zjngz+rBQbWZSF781vtIfgIg41Y5UuiupX4WNk3CROuOah+BcIPV
         G5kQcOdKrKf5a3Q7vGMaVffcTOyx0mfsJ/kevclBIPgRzroi64CAlP/6vIkd+0UUweP6
         jMZ/iHZ/OxNUJ64+iaK5Q2Aetlhg//RQqAVsT6f89RinYlqG5G71ldQvArUuZe8BF2a5
         CI5g==
X-Gm-Message-State: APuU4Z9fwuC9AXM9JHo9i/cUenplkXwt/RPDuGW9iS2QAaW0mP5oIe+3
	9yWbXtTMNZQz+f0d/OkxHYjZ5JltugiBkIRTrSnkBi7PNGrQRfGVEzqUcdOIQQ==
X-Gm-Gg: AZFdTZfEQTyYXakYSUCn+2jBRxFM9NMygqFqitGvSvQe7LkT/CLO6Z3pjAbFbqwZeq3
	Dx/tmPJJuVYeoQZblhfCHLeqKE0H9AFR+UG9REst9iLRP3+iWPWQ76oYgppeBWNIaU7ZPOKajGd
	c9DlBjJ5i0waQENGryD3k1kQTpKy7hgzbuPgMWZMbTctVQ3yglpcOhxB6GhuUTc/JcBWU6zjFeA
	9BC/Vnxtb2nrkX5GgKOUjhRFzwhQZj7HteHl5yZNY5qcYCe+yOr8i3ZmQL2vaKM39rkNKunoz/u
	5BN4YBdfpDKtrFRHO3hN1TScEByMBxkH3laofveAykDdvRFPwgsz3CiG8l6uPFqsMVhNND0eVr8
	9+X4NEjo5MapWZUrxKvotWTvTqNm1gY9ruGKUkdQBq8gClgJ4lyT0w2Na4UmYrsJpADY0lEMpAB
	tujmdfQDBpmu4oETxl17eR9ysw46Y743Sfxdf77AcFQy6VrqT3Ra2W/Hs4Zs9DSIBnvNCPfqn4V
	8wFd9Q6NUEKzt+tVpSF9NwFOGDv1n29oWDwDI8pl3wGz9l4VQ9+65+XM1nNZJwxJn8smxsbOR+g
	BqCO/ETsdtkrUHVhtx2LmIvuxg0mGxcIafmse6tiHTvBT65CsSxAw9azA+fg1uIG3WmiCw+VpPt
	fJD4mQMZi9NOqHOM5SrfMGS1J/KSw/0hQGA==
X-Received: by 2002:a05:693c:600c:b0:36a:1bac:6bf4 with SMTP id 5a478bee46e88-38570451dbemr20837475eec.18.1795612718503;
        Wed, 25 Nov 2026 05:18:38 -0800 (PST)
Received: from v4bel.. ([211.209.222.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b1965c02sm24228659eec.27.2026.11.25.05.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:18:37 -0800 (PST)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	imv4bel@gmail.com
Subject: [PATCH 6.12.y 2/2] ipv6: Remove IPV6_ADDRFORM.
Date: Wed, 25 Nov 2026 22:18:23 +0900
Message-ID: <20261125131824.3345131-2-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125131824.3345131-1-imv4bel@gmail.com>
References: <20261125131824.3345131-1-imv4bel@gmail.com>
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
[ Hyunwoo Kim: Remove UDP-Lite handling from the IPV6_ADDRFORM
  set/get branches on 6.12.y. ]
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 include/linux/net.h      |  2 +-
 net/core/sock.c          |  4 +-
 net/ipv4/af_inet.c       |  3 --
 net/ipv6/af_inet6.c      |  4 --
 net/ipv6/ipv6_sockglue.c | 95 ----------------------------------------
 5 files changed, 2 insertions(+), 106 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index c6d92428c71a..6d2241615532 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -144,7 +144,7 @@ struct socket {
 
 	struct file		*file;
 	struct sock		*sk;
-	const struct proto_ops	*ops; /* Might change with IPV6_ADDRFORM or MPTCP. */
+	const struct proto_ops	*ops; /* Might change with MPTCP. */
 
 	struct socket_wq	wq;
 };
diff --git a/net/core/sock.c b/net/core/sock.c
index c71b175d1320..b77cb9cfcdb2 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -765,7 +765,7 @@ bool sk_mc_loop(const struct sock *sk)
 	sk = sk_const_to_full_sk(sk);
 	if (!sk)
 		return true;
-	/* IPV6_ADDRFORM can change sk->sk_family under us. */
+
 	switch (READ_ONCE(sk->sk_family)) {
 	case AF_INET:
 		return inet_test_bit(MC_LOOP, sk);
@@ -3849,7 +3849,6 @@ int sock_common_getsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	return READ_ONCE(sk->sk_prot)->getsockopt(sk, level, optname, optval, optlen);
 }
 EXPORT_SYMBOL(sock_common_getsockopt);
@@ -3876,7 +3875,6 @@ int sock_common_setsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	return READ_ONCE(sk->sk_prot)->setsockopt(sk, level, optname, optval, optlen);
 }
 EXPORT_SYMBOL(sock_common_setsockopt);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index b67c20019978..b61d07620c1f 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -575,7 +575,6 @@ int inet_dgram_connect(struct socket *sock, struct sockaddr *uaddr,
 	if (addr_len < sizeof(uaddr->sa_family))
 		return -EINVAL;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 
 	if (uaddr->sa_family == AF_UNSPEC)
@@ -776,7 +775,6 @@ int inet_accept(struct socket *sock, struct socket *newsock,
 {
 	struct sock *sk1 = sock->sk, *sk2;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	arg->err = -EINVAL;
 	sk2 = READ_ONCE(sk1->sk_prot)->accept(sk1, arg);
 	if (!sk2)
@@ -861,7 +859,6 @@ void inet_splice_eof(struct socket *sock)
 	if (unlikely(inet_send_prepare(sk)))
 		return;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 	if (prot->splice_eof)
 		prot->splice_eof(sock);
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 5cbb20e3788c..3b701dbb4691 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -444,7 +444,6 @@ int inet6_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	const struct proto *prot;
 	int err = 0;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 	/* If the socket has its own bind function then use it. */
 	if (prot->bind)
@@ -583,7 +582,6 @@ int inet6_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	case SIOCSIFDSTADDR:
 		return addrconf_set_dstaddr(net, argp);
 	default:
-		/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 		prot = READ_ONCE(sk->sk_prot);
 		if (!prot->ioctl)
 			return -ENOIOCTLCMD;
@@ -654,7 +652,6 @@ int inet6_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (unlikely(inet_send_prepare(sk)))
 		return -EAGAIN;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 	return INDIRECT_CALL_2(prot->sendmsg, tcp_sendmsg, udpv6_sendmsg,
 			       sk, msg, size);
@@ -673,7 +670,6 @@ int inet6_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	if (likely(!(flags & MSG_ERRQUEUE)))
 		sock_rps_record_flow(sk);
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 	err = INDIRECT_CALL_2(prot->recvmsg, tcp_recvmsg, udpv6_recvmsg,
 			      sk, msg, size, flags, &addr_len);
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 0f1242138d17..df5858ffa058 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -557,93 +557,7 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
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
@@ -1107,15 +1021,6 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
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

