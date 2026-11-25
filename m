Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795612658;
	b=VBkoUl4+Cvfokk+8uVwjvifsDtcOgOchy3nwsyIPaUYv31KSTJuuxqUt58SDuVdsILTR
	 oyEDSGrzhkSHPIXABBIMXJ3WC3WsInutBXuz83B3hPLko12++tXI1jHwsyim0HPtSyjnh
	 DBD+CFbaFeT0hgBBnj8MnOUbfezlY49/Qbky3ILhUHgORAxA49F1vfVVZElRwPml8M2vN
	 bEavDMpTr4dzHHRivJ2N5mmbjLwL3NkWtzty707efwhWf01DGcSizjv0iW6NWwNRLafdn
	 ixBc8bWVauYc2hKrHhA/a3kgyVpclNOvLlSNKulepEND6YhjitBTKCglB/Ar8cEPpkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hea3futv6aDh39dn8VrclESwObgS8OzNVyUysVcbckQ=;
	b=Ipx+aYuRMs8BuC6vIytRSt6NOrO9IMQxLdWswSOR/OSrh7mNQRVYNReezt3pVLmACbX7
	 ZL2/jyaXkswVmllyWj0fAuzfiLsgxY1rhIGpqZ/uwbQWn0S8birwnFYqIXjkJF1GWU43f
	 MTAuxE5I2myiCqX68nXWhJo4OiI2SBl+IE8hAKtss+pQPscAWcrY1atoSijzm2pDKPfku
	 bmNsIsLzdILQV7V96oc5GziwZVm9PmnHs6DjaZxwB+OufxlHmn6PC056fBAWFXMnIvAw1
	 ZCcejOZJgur/NzBc4aIVmXvst2rNQw/hYAHaa4bjuidZs4YkArcOC5ORe1r28Mq32fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MQAEDz4K;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42115606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42115606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MQAEDz4K
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-33fb4680717so14551951eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 05:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795612657; x=1796217457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hea3futv6aDh39dn8VrclESwObgS8OzNVyUysVcbckQ=;
        b=MQAEDz4K5LaA3yYNvUQd9GGj7UXnZorrWBzZf4HO01GnLQ9loKrsP/nw0oiF2cNdvB
         OfuXtn7P1n65wNoPbpKW89LQGgyc3A2DXkkk4a+35NumTJH+C9fG/DDGIwZMKF+FW9c9
         3Oo5JSVTsn7d7myeQregHm2gNIwqnxf4zlfc/sOixcLK4dYH5pZVUqQ03x3BXamhAcbu
         q9HO/ljuYjS9gwCwVJlOh4udJHVGMLheXQXR0dizuF9olHj8WtWsBq6YRM86PsLUrHGs
         l2j6K6A3yHtpIVQMO3xyjLRtPo+22GqFutYssiArbKCMjJu0TTkGZewU0go4kzMizOPm
         Vp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795612657; x=1796217457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hea3futv6aDh39dn8VrclESwObgS8OzNVyUysVcbckQ=;
        b=EF/ayiC/G+ubaiIlF4iROFthhQnF7aL4rXamL72QxbGv9WBAecxbjyPdI90CO6syJp
         DxTWrlzcYE/7eGsH3xtOwmYb5ALHZ+zyGGImruJDgi7MNqxpySpdZAemA8HAVj3vw4wd
         AWEdrGS6wznbo39VW24cPZ0OUY58cL6wE0X27ZQBmfXYgTqemV6DzZlWmV7t9P2safRY
         f7rIzaamMH4198Ee7pKPkbm19NtE3asjH9329esVxkDdcf/ft1QV3ZcO0UUf02/Ps8ID
         GpR4FP2V62/MAeWqcExFXmaeXNkc+FI0EKaCXiUTyJjROcMCMyl55TQsH8lSsJG+/evn
         BHbQ==
X-Gm-Message-State: APuU4Z9B79ATdrEiVjICY+RSCahDTYtoeGBxD0l+0fq42emQ0BU/mort
	FeI14Du1odDU+fDlG73ElMN6VDRd/opPCAZmdVN8I4eFTFCk5gK42VJuLW2C0w==
X-Gm-Gg: AZFdTZc1Ulzw3kL71MqnZxYm+HCtmwskxh+0hDNUOc2fCaUuBhPHAO+uhzMCzdoKZME
	+XLcODO8Wo/HHq5r6FFX04S/ClUv/rHFid59fvcjOhkCfyJmqOCL6cF9Qn+DmKPOtpVVkWpAAHe
	D+J7XCBvvwOIcBQc8hnSaFInRBfvkJjjuTnSJuyZ8UwbNFsn2ADDurAyPF0yTmdo9Qa8qkDkpEh
	9wv0SNlLcVGJkdHZdBFV576fMBwBt2UiUGbvVHCNO8AiNslRlUTnO+PFFUiOqkWHBMz29+w29ca
	sDul62E2vu7zc/peqecF5jH34ci/9hwLfI1EeOWTUHWYOusYylNuwJ3CkVNjmraku0yo/7bGfUr
	JzVXnK9DRvnOmR4lDIiu3bIUwDbbG1hq7jXWSCkKjRQcG0kGZWYi4VzbFS0PHWJYEwq3HWXf4Kp
	nhbIPDEXSJWmyACJjpBOzfO1rBHbKVY9hGTBbQwgtukkX3MaMHmtJzTydQ8sTs+4/FAgQOyHeId
	1YpfQ8LhujZdF6Go/dLHNDie/SzZOOvgH9nud28mxaUF72jPG3jqS0IxuY/spXG6oqkj4z6sHFF
	aZ6YCE7J4T6/OSlz78JC/ifZGkCQiDP58vz+H0WCxc0IQGXKWN2uizJ9QUwquxIJZhYJ7bXh3+T
	EUYlk0ZHJEVEsCEFJgmNMJzlEllAEhFhZ4g==
X-Received: by 2002:a05:7301:df48:b0:386:a5d0:15d9 with SMTP id 5a478bee46e88-386a5d018c8mr11985706eec.37.1795612657140;
        Wed, 25 Nov 2026 05:17:37 -0800 (PST)
Received: from v4bel.. ([211.209.222.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c0c1dsm60283698eec.21.2026.11.25.05.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:17:36 -0800 (PST)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	imv4bel@gmail.com
Subject: [PATCH 6.18.y 2/2] ipv6: Remove IPV6_ADDRFORM.
Date: Wed, 25 Nov 2026 22:17:24 +0900
Message-ID: <20261125131728.3344877-2-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125131728.3344877-1-imv4bel@gmail.com>
References: <20261125131728.3344877-1-imv4bel@gmail.com>
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
  set/get branches on 6.18.y. ]
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 include/linux/net.h      |  2 +-
 net/core/sock.c          |  4 +-
 net/ipv4/af_inet.c       |  3 --
 net/ipv6/af_inet6.c      |  4 --
 net/ipv6/ipv6_sockglue.c | 95 ----------------------------------------
 5 files changed, 2 insertions(+), 106 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index ec09620f40f7..e3b4c1af3091 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -122,7 +122,7 @@ struct socket {
 
 	struct file		*file;
 	struct sock		*sk;
-	const struct proto_ops	*ops; /* Might change with IPV6_ADDRFORM or MPTCP. */
+	const struct proto_ops	*ops; /* Might change with MPTCP. */
 
 	struct socket_wq	wq;
 };
diff --git a/net/core/sock.c b/net/core/sock.c
index 857790b478e9..ed625b8ac32a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -771,7 +771,7 @@ bool sk_mc_loop(const struct sock *sk)
 	sk = sk_const_to_full_sk(sk);
 	if (!sk)
 		return true;
-	/* IPV6_ADDRFORM can change sk->sk_family under us. */
+
 	switch (READ_ONCE(sk->sk_family)) {
 	case AF_INET:
 		return inet_test_bit(MC_LOOP, sk);
@@ -3901,7 +3901,6 @@ int sock_common_getsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	return READ_ONCE(sk->sk_prot)->getsockopt(sk, level, optname, optval, optlen);
 }
 EXPORT_SYMBOL(sock_common_getsockopt);
@@ -3923,7 +3922,6 @@ int sock_common_setsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	return READ_ONCE(sk->sk_prot)->setsockopt(sk, level, optname, optval, optlen);
 }
 EXPORT_SYMBOL(sock_common_setsockopt);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 72cb7d9aee91..a58128938479 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -577,7 +577,6 @@ int inet_dgram_connect(struct socket *sock, struct sockaddr *uaddr,
 	if (addr_len < sizeof(uaddr->sa_family))
 		return -EINVAL;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 
 	if (uaddr->sa_family == AF_UNSPEC)
@@ -778,7 +777,6 @@ int inet_accept(struct socket *sock, struct socket *newsock,
 {
 	struct sock *sk1 = sock->sk, *sk2;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	arg->err = -EINVAL;
 	sk2 = READ_ONCE(sk1->sk_prot)->accept(sk1, arg);
 	if (!sk2)
@@ -863,7 +861,6 @@ void inet_splice_eof(struct socket *sock)
 	if (unlikely(inet_send_prepare(sk)))
 		return;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 	if (prot->splice_eof)
 		prot->splice_eof(sock);
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 1c45e1d15506..6301428bb6c1 100644
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
@@ -671,7 +668,6 @@ int inet6_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	if (likely(!(flags & MSG_ERRQUEUE)))
 		sock_rps_record_flow(sk);
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 	return INDIRECT_CALL_2(prot->recvmsg, tcp_recvmsg, udpv6_recvmsg,
 			       sk, msg, size, flags);
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index d784a8644ff2..f4a84817579e 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -548,93 +548,7 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 
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
@@ -1096,15 +1010,6 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
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

