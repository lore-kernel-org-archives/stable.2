Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795612172;
	b=2dICD2qatrOIIt1bia6JRMWaIFRLbAoAvdWJPHDTxGDIRyZcnPSP7M6LhqjmRjUxPEtI
	 7FWsw/SqjhudiQnAhF458t66nlsfLf9mCdAndkpaIR1NBm8BcHEencfuFk0QhrkqrbdmN
	 aLt8QecZQ+hbxQItl8hTtfH/CzDEWNm5oROiCmFHBvfijNGqSwA+WwSDgOAxu54UlFW1e
	 Gm5ftsRiNICSKw3TlxW3YbC4DwbwHZxTqoI/5Py/YAIjxJuk9fv/Rha5rq4yC7VqPu+M1
	 AeFybS27E2fLdcFjSZNH9nCOQgZirOtQt3jaRzniLTYdDK8CvKrRNlpCzqnR/ny+fjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612172;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VeIkLXadBzfbOrDPpbdspR9exzt+wCq4oLPW7m5A/5E=;
	b=DiMNLPsRu7dkl7l7lugWVvO4kU1d6CB2T/FfVyEkFd1K4XjUqW1w2cJ8iLHJad17XWNJ
	 38Ce/wmG+jxgPVu/W8s3dPiZ+hm7jmjgGJEqd580eA/Zen59xZVUnQbMDt8R0DCV8Il0N
	 NpUoWXaGGQtm2meNrJsuKBHBpUFJUsNHxZnzM7koIyrZj4p9HTJylGEq7Qpg4hgeCYh3l
	 DWrl+PVZfU/8jTrD6mRtjIlE1fVnnlO7oXOjcpChUyQr9dE3QrHfoovaz8DIKBDmVan+m
	 LclL30mS79P3jV7QQn27Ipf/1ocph6ttdGioTWkP+3gSQzP4hUA0LHCLCJyttrwC/nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UEGrEHd6;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA12606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DA12606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UEGrEHd6
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-385c497bf94so2672477eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 05:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795612172; x=1796216972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VeIkLXadBzfbOrDPpbdspR9exzt+wCq4oLPW7m5A/5E=;
        b=UEGrEHd6qMfSTGvho3nIPJlkWB2Vrb7HttCJ+RsJ1vgcG/1zMxNd+Wa5Hj4rHs5b8x
         EHxnGht3DetOv6TIpmZuoSaufCUiB92w5KVUPn42+B4aWj6ahQGayLU1VoFUxnchDz7+
         XwntB4GpmRhLxnLdkC2IySIxke/kvksqY6YTakxvIAwnugnwxAHHQJ77qKDsb+zf/LW2
         xKhDPZ8H67acLDX15BOYO63jbUud4ulMND/x0+7P1xTpL2Lm0jwFHbGz44yZ3Fl23yGd
         dVrNtcOJyXIQLkPQ122CmlCz/a3BqdJLWInf9M6ughCElLAQdWwj4Jq350FMTCtYwTq7
         6HfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795612172; x=1796216972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VeIkLXadBzfbOrDPpbdspR9exzt+wCq4oLPW7m5A/5E=;
        b=OdIi+JbPK9vwsSi/JFJjYGs0t/rBnVUW0MQeyd/Rn+3xPvRIr7aB73dTaEt5c2bGvR
         1JUYnjD44C8TENm65lzzPeWr00pWg3jhBNFD74d4dst/RKINT0QAZ0wfjHZZtdab1V10
         kmzWqMIikr7jvl5QhSCWrasHdXJOVWy5wFk+0/LJapqPpL2/hyzjrVmYXeS/542Nsgry
         iwDtA5+IwPcT2cOkTR2zDnXLQvSjLv2M8Ag6O10HGeUdtlTV525wkcCONfwVPbdxqUgX
         XoWTmHPPnSSQN5vL7NE34Mz5ebM0QYeVPqkZUFdzCoCv9qh5oH5lVdqOBlvo2EA9R5eW
         JN9Q==
X-Gm-Message-State: APuU4Z/gK7LDUDz5kH/8Ga9kcGK3IfdVsy7W9XGWATfNvMFfOQ5ku5Si
	BRgkPfnQRWprFfVJT/KQ2ya/eZTf41WHlDmxBVH/KSmiTaE/U7Wweb6nfeK+GA==
X-Gm-Gg: AZFdTZe02QA6HrgYxc959ORiEgwwTVyIvZls3gOMwKMSK1k4ooEGwexYyqTGaz6Fewg
	3p5s361QmVSNM5Vy3OMAfJ4RSrC57Pxrn2GD/bATuYkdrvNrxYHrxT/tCR9LtHj0f+Dl1wI5IbT
	RjNyW8nEkWg/LSS5OtGy5sFOakFoMXAzUYZfBnPPNwK1uPQ5jBCaTX4mty48TgVmQhaWP9pxWPT
	5i1O/u3e7rMt8NeODzsxPUQIg2a/OcYoF6XFPKkk6rVSbITttFT/N0zGuMkEnBa1sK5wrRiEtrs
	rUGljEk5MmCuxLneVQOw705Zsusso9VOhexlswrsaPsMY3cQB2+ajDBbpW6QVQgkpivxw7znpAh
	eQzENFanJoG8rOEF7bBQZqROO127NpmRtjFi0HTWxeEVVOWfUetICr9V0E4qQG9AcW+rsY22dfC
	b6YwD7fDXhokNrbIZc5/ffNTr5BAl3Ny6Y7TAVwC259oCxrfFjV/dNVYu41gK8l+XmyPAunyoC1
	DZwQsPhpG93ardHTY0yIKwsnG2JfjJtZjWS0F4TQyy5tramFMMzkeA4lx3bVkcxGtPj1utea0u0
	quBPIAlzrxxhjUG4YyI9AJm4MMmjHcCZrjcRzHBFS1g7yibbth7had5YYTcLVQb8awzuGLeMeDu
	5hc9InrQXyhWIfspMi9UNB55DLVLHU63fNA==
X-Received: by 2002:a05:7301:1506:b0:386:a554:1074 with SMTP id 5a478bee46e88-386a554157emr12944280eec.25.1795612171515;
        Wed, 25 Nov 2026 05:09:31 -0800 (PST)
Received: from v4bel.. ([211.209.222.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3866f299d0bsm46312537eec.19.2026.11.25.05.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:09:31 -0800 (PST)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	imv4bel@gmail.com
Subject: [PATCH 7.3.y 2/2] ipv6: Remove IPV6_ADDRFORM.
Date: Wed, 25 Nov 2026 22:08:32 +0900
Message-ID: <20261125130843.3343543-2-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125130843.3343543-1-imv4bel@gmail.com>
References: <20261125130843.3343543-1-imv4bel@gmail.com>
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
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 include/linux/net.h      |  2 +-
 net/core/sock.c          |  4 +-
 net/ipv4/af_inet.c       |  3 --
 net/ipv6/af_inet6.c      |  4 --
 net/ipv6/ipv6_sockglue.c | 87 ----------------------------------------
 5 files changed, 2 insertions(+), 98 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index 3d82966e2243..470100ae7107 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -166,7 +166,7 @@ struct socket {
 
 	struct file		*file;
 	struct sock		*sk;
-	const struct proto_ops	*ops; /* Might change with IPV6_ADDRFORM or MPTCP. */
+	const struct proto_ops	*ops; /* Might change with MPTCP. */
 
 	struct socket_wq	wq;
 };
diff --git a/net/core/sock.c b/net/core/sock.c
index a74be1cc9302..d5af5e3deb9a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -772,7 +772,7 @@ bool sk_mc_loop(const struct sock *sk)
 	sk = sk_const_to_full_sk(sk);
 	if (!sk)
 		return true;
-	/* IPV6_ADDRFORM can change sk->sk_family under us. */
+
 	switch (READ_ONCE(sk->sk_family)) {
 	case AF_INET:
 		return inet_test_bit(MC_LOOP, sk);
@@ -4023,7 +4023,6 @@ int sock_common_getsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	return READ_ONCE(sk->sk_prot)->getsockopt(sk, level, optname, optval, optlen);
 }
 EXPORT_SYMBOL(sock_common_getsockopt);
@@ -4045,7 +4044,6 @@ int sock_common_setsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	return READ_ONCE(sk->sk_prot)->setsockopt(sk, level, optname, optval, optlen);
 }
 EXPORT_SYMBOL(sock_common_setsockopt);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 14ce01092fda..c012e2afc6dc 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -582,7 +582,6 @@ int inet_dgram_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
 	if (addr_len < sizeof(uaddr->sa_family))
 		return -EINVAL;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 
 	if (uaddr->sa_family == AF_UNSPEC)
@@ -789,7 +788,6 @@ int inet_accept(struct socket *sock, struct socket *newsock,
 {
 	struct sock *sk1 = sock->sk, *sk2;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	arg->err = -EINVAL;
 	sk2 = READ_ONCE(sk1->sk_prot)->accept(sk1, arg);
 	if (!sk2)
@@ -875,7 +873,6 @@ void inet_splice_eof(struct socket *sock)
 	if (unlikely(inet_send_prepare(sk)))
 		return;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 	if (prot->splice_eof)
 		prot->splice_eof(sock);
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 282912a11999..f0efdc13baf4 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -429,7 +429,6 @@ int inet6_bind_sk(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len)
 	const struct proto *prot;
 	int err = 0;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 	/* If the socket has its own bind function then use it. */
 	if (prot->bind)
@@ -567,7 +566,6 @@ int inet6_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	case SIOCSIFDSTADDR:
 		return addrconf_set_dstaddr(net, argp);
 	default:
-		/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 		prot = READ_ONCE(sk->sk_prot);
 		if (!prot->ioctl)
 			return -ENOIOCTLCMD;
@@ -636,7 +634,6 @@ int inet6_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (unlikely(inet_send_prepare(sk)))
 		return -EAGAIN;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 	return INDIRECT_CALL_2(prot->sendmsg, tcp_sendmsg, udpv6_sendmsg,
 			       sk, msg, size);
@@ -651,7 +648,6 @@ int inet6_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	if (likely(!(flags & MSG_ERRQUEUE)))
 		sock_rps_record_flow(sk);
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 	return INDIRECT_CALL_2(prot->recvmsg, tcp_recvmsg, udpv6_recvmsg,
 			       sk, msg, size, flags);
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index b4c977434c2e..1f68fb64a43e 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -547,86 +547,7 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 
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
-			if (sk->sk_protocol == IPPROTO_UDP) {
-				if (udp_sk(sk)->pending == AF_INET6) {
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
-				sock_prot_inuse_add(net, sk->sk_prot, -1);
-				sock_prot_inuse_add(net, &udp_prot, 1);
-
-				/* Paired with READ_ONCE(sk->sk_prot) in inet6_dgram_ops */
-				WRITE_ONCE(sk->sk_prot, &udp_prot);
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
@@ -1088,14 +1009,6 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 	if (copy_from_sockptr(&len, optlen, sizeof(int)))
 		return -EFAULT;
 	switch (optname) {
-	case IPV6_ADDRFORM:
-		if (sk->sk_protocol != IPPROTO_UDP &&
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

