Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795612776;
	b=1H9fDLFRyAry/4dv92fmG6MSGVNQ4adslEiL5uE+MaZPDnGQbdERcIenwm0Ly027xLVe
	 uQ+Tb/Vv1Y2kFO22l342xlKrXOKIaGdIK6mjlcpTBXSmLpNSctSTqruMGFp5LpWe/ahbC
	 qZRHb2p6BoeZ4btb1GoWS7BMiRvFE+Tlle1/DpJg9hwMxf+sPSa2WQ1L8DFMaQWLYXkJR
	 tDJHAWsH3TbOF8hBNdpbtjLW+BakxI5XydtmBhzIhxJG79NA8JMx2gAnqTIgb9lx9ZX59
	 d7JkoPn26NTm/L+7LW/XIjVEElJXo6oCwTTj3KUdws8+nRlCMRHSEemkKfA0b8TpCLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612776;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=eqZOzzzopo3sm3cxHtm2hJEGB2Ebnx1Gd60V+sJjbUU=;
	b=ecv+/OX9WRqMBH/9btF5LIS0VLJFED10PMaxluISh+ADSlzPwAcTc00zt1Plp2HtCsQJ
	 VepLsMAaAtA6ZDyiAUeC+p9mCsAPwwbSffAyzg7qCi+rUaKOLfdrBLtJysGzfR/J6bqBV
	 isIUHT8O/1Eox3CyldQtQBNBqt+hW9LcRy9Iit5dZi1h68q0euPunBZCuuTxbP34JVvqF
	 CJv3E80jAcly29iW125eoFDt8LiHP71CXHb1zmKgev1/1o7IG77qc6YZx35Y+9KrO1tSD
	 uR+EuOSfdO9dJPlr75zVBQhA4mW3rtP/iardklEYpqEmY+Hw+AD6NZu1m17e65VKeUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="SrFg/7pb";
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC552606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC552606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SrFg/7pb
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-386c336eab8so2137670eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 05:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795612775; x=1796217575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eqZOzzzopo3sm3cxHtm2hJEGB2Ebnx1Gd60V+sJjbUU=;
        b=SrFg/7pbeyZY81tnW39kO+q/kBi7JU9B1oULyPvKLtFzIv5cpqcH8JpN6s1/gBIq15
         W+JirQS4z3lYqFoltEpoEo73piIrH5ON3CmIDN0qO1RKuBN+PzN8a1pLRdYr6CKEH4mP
         dKWwWxVdoFbWuIsdTKR5qoL44EcFGfSYVaIkg1PwHhuMzrLj4/TCMZg+uqbZ4W2sBmmI
         ftQ13ClzlLkjw3opC8V0X9OaMZNr2V51Or4TAyrazvqCsKv3wZvzYw9s1/K2AYcoJ9F0
         g0N08hwj89i3vCviZ6C0KieSUYL2vuJcqDGcIBpm3KshZV/xgYh5bkoHDWJREuR1yylx
         nMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795612775; x=1796217575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eqZOzzzopo3sm3cxHtm2hJEGB2Ebnx1Gd60V+sJjbUU=;
        b=RTj1Y/gJkFDU9rbbBZkKvwFIgDGtk3ePy5ZMze9BxMwxMcWPrRyflP3GNmYzlVpc87
         JCom7y8UCUd2LloZwvSvirQpcNVUqAI5Lj4z/Lpq0A9UxtFdftc0cRIMBm1yox+eBB2u
         dG63oTGPE2OA/EidcE8f/7KyC89U0Bz4bf1U1I1t60kWSotMbfdoKJQJinR0zpD361iF
         S021qXRg2LxqzfWhnnFChzhLI7xZPpwuQity7FCSiWzIz1r3Mb30CSbkHRwZWB9fiUPN
         vAUHLRf3Rj26zTukIym8JdqOytsbyH8yY2RgEOMgYqMOHP4RQBBrp3MFlZMp0tPNjjyJ
         fy0g==
X-Gm-Message-State: APuU4Z8ExbTdbbjzNRmkyAonLjMGSmmxlUPvw6TrapFmrrjsvCOo4XhO
	u/nKKkwU3FgfqzrquTSBadHeG92PuMumIm1AEGUjNHI7ApDI8O6Yz9kV81e/qw==
X-Gm-Gg: AZFdTZd0mIqoMheURD5FYZ4EhgvPcJ9JgniVWLzqkQrTVV3p0yil3Ok5X9rpmDD1AR6
	ZzGW5ozCm5LhzcsTwq/izn0fPhZx0cqebePpJeGNNRMgy0TAZ7q3wO1V4y4w3FLTw4Ku3nW24Gg
	MtkBEIe99ZXNFgbLcn4nqJ7RhT5td052siso9PMbqceahNOUW5EuO0Ww389F1TFFJN058QYmfBB
	uyPwyd84vKFDro7+7ER1xNm4j+gisHLTkCAp14Gsz9dFeHa6Iefu/RwGK6FzGQKejECuzpqDQvH
	HSsNLXGXvelxYrYIivYXag7uwlhxcreyi+NDeFocm30ea4+ftQXS6+biP63quErF6Laf2L9Z7GA
	K+nq5W4l2WZxMA278Vzh9zqEUdO7s0Ienf/jorm1lwlRNsXEAtjglKTH7vhGrEkBOmAUmyzkM1k
	mXqOJZeBoCznBsBC/RsLGGATTkGI+xerONnf897iTOdXLHb+ayDdMqca1iVKs12lhRG9yPqQwCE
	FosNW7Qy0Rnlj6WmCTMsyZEowXi0ZmfTLvCHaOBJxuuJkQ5XdDJCO7vWFvnoPLGsKxet4l87U7L
	xfiYP6YaBqf3agIYGeui1LXXD86L7F2GyZ3R8Ar1mebeo3ijEwzaGO5DM7EzjC4hV1P0KKi0oaa
	TpeBi9CrQzhRP9Ny/H/UtpKTruJPOlV9sTg==
X-Received: by 2002:a05:7300:51d4:b0:384:fef7:5876 with SMTP id 5a478bee46e88-384fef75c78mr21011360eec.24.1795612774803;
        Wed, 25 Nov 2026 05:19:34 -0800 (PST)
Received: from v4bel.. ([211.209.222.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm51253048eec.16.2026.11.25.05.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:19:34 -0800 (PST)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	imv4bel@gmail.com
Subject: [PATCH 6.6.y 1/2] tcp: Do not allow buggy transitions between ehash and lhash2.
Date: Wed, 25 Nov 2026 22:19:25 +0900
Message-ID: <20261125131928.3345385-1-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
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

[ Upstream commit 8cc3aef0cb198049805ecc061a2cc7b79b0ae43e ]

The following state transitions have long been a playground for
syzbot, and recently AI joined in, reporting a lot more bugs.

  * listen() + shutdown() + connect()
  * connect() + connect(AF_UNSPEC) + listen()

All the fix attempts would add more code to the fast path, which
is not worth it.

Instead of playing whack-a-mole with these edge-case bugs,
let's disallow these transitions.

Note that unhashed_state is placed in the 4-byte hole after
icsk_pmtu_cookie.

  $ pahole -C inet_connection_sock vmlinux
  struct inet_connection_sock {
  ...
	__u32                      icsk_pmtu_cookie;     /*  1208     4 */
	unsigned char              unhashed_state;       /*  1212     1 */

	/* XXX 3 bytes hole, try to pack */

Reported-by: Kyle Zeng <kylebot@openai.com>
Closes: https://lore.kernel.org/netdev/20260731140512.566464-1-david.lee@trailofbits.com/
Reported-by: Michal Luczaj <mhal@rbox.co>
Closes: https://lore.kernel.org/netdev/20260803-sockmap-lookup-tcp-leak-v2-0-306e025bfe66@rbox.co/
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Closes: https://lore.kernel.org/netdev/20260824033331.1084971-1-imv4bel@gmail.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260904033543.2635540-2-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Hyunwoo Kim: Check __inet_hash() for IPv4 and IPv6 on 6.6.y;
  record the state after each locked unhashed check. ]
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 include/net/inet_connection_sock.h |  1 +
 net/ipv4/inet_connection_sock.c    |  1 +
 net/ipv4/inet_hashtables.c         | 11 +++++++++++
 3 files changed, 13 insertions(+)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 0a33e7cdcc8b..96e29df15fe0 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -102,6 +102,7 @@ struct inet_connection_sock {
 	__u32                     icsk_rto_min;
 	__u32                     icsk_delack_max;
 	__u32			  icsk_pmtu_cookie;
+	unsigned char		  unhashed_state;
 	const struct tcp_congestion_ops *icsk_ca_ops;
 	const struct inet_connection_sock_af_ops *icsk_af_ops;
 	const struct tcp_ulp_ops  *icsk_ulp_ops;
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 527c258373bf..fa967465951d 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1198,6 +1198,7 @@ struct sock *inet_csk_clone_lock(const struct sock *sk,
 	if (newsk) {
 		struct inet_connection_sock *newicsk = inet_csk(newsk);
 
+		newicsk->unhashed_state = 0;
 		inet_sk_set_state(newsk, TCP_SYN_RECV);
 		newicsk->icsk_bind_hash = NULL;
 		newicsk->icsk_bind2_hash = NULL;
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index f3430f96db0c..1ca4a6cb27d6 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -748,6 +748,11 @@ int __inet_hash(struct sock *sk, struct sock *osk)
 		return 0;
 	}
 	WARN_ON(!sk_unhashed(sk));
+
+	if (unlikely(inet_csk(sk)->unhashed_state &&
+		     inet_csk(sk)->unhashed_state != TCP_LISTEN))
+		return -EINVAL;
+
 	ilb2 = inet_lhash2_bucket_sk(hashinfo, sk);
 
 	spin_lock(&ilb2->lock);
@@ -801,6 +806,8 @@ void inet_unhash(struct sock *sk)
 			return;
 		}
 
+		inet_csk(sk)->unhashed_state = sk->sk_state;
+
 		if (rcu_access_pointer(sk->sk_reuseport_cb))
 			reuseport_stop_listen_sock(sk);
 
@@ -815,6 +822,7 @@ void inet_unhash(struct sock *sk)
 			spin_unlock_bh(lock);
 			return;
 		}
+		inet_csk(sk)->unhashed_state = sk->sk_state;
 		__sk_nulls_del_node_init_rcu(sk);
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
 		spin_unlock_bh(lock);
@@ -1021,6 +1029,9 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 	int l3mdev;
 	u32 index;
 
+	if (unlikely(inet_csk(sk)->unhashed_state == TCP_LISTEN))
+		return -EINVAL;
+
 	if (port) {
 		local_bh_disable();
 		ret = check_established(death_row, sk, port, NULL);
-- 
2.43.0

