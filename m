Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795612719;
	b=Ncwn0FqBAa9qjVp08I9j792BPvQZ+tKqSRnGQd0vkQH9ZhEOaEj1vAAUxPQrOxzJBNx3
	 eL/TI3RRDt6KNWWVgEODd4dnW4ZMdrrVdIeELUjFvMe7zSnepPISiV0oUfHzkj3Hbr5vb
	 spvBfxgR+EvdzuHe8bTt7wirWNxq3avCpO3OhgfcZDMxhuTetgYZwGeiuWDtOk6xWYkjK
	 CuN4ep9DI9aAxWLdfTP20Ggsz8PIjdcbweV3ZfAJBaItBzP9NP+mv/zRVQm+F7H6Xavar
	 fTPop1U+VIvAkj8bLd+60pi5OR4HkGjDYMxfPd4Szpz8VKjXbv8geCHDdNn1gwdVDIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612719;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=hPRYrLMx8bXepIG4VXq81GdMR/g7AjAl+dXuKaeVQVM=;
	b=i0NyTEARdj3lwO/LT4Ht2cdb1DLNGAhDMFz6lpBPWlZ0gw52nvpnzqCkKt1EiZ26yg5B
	 E02yfGYIwpsEPv01FM6IDrphWiZlMlT5PS+E6v/NDe9dF1aasSqywrUzXZYnnPm+ZNkhB
	 D95dbZtsMRoj+Jn56hNBXI2tlwI76DjQAEzuaR6WWLe1nCA9ZEZsATRhDPCTSkbByfdt1
	 b3okAhhd5Rt06GgD/HU1zSEo8kPedCB9GHhu9SBGIidY9Rs5bhCZsBSUVBtaWitC3gb5o
	 odHRSuI6bv7bE3IoWeTmpjhSDCGIPHnvYvD63PCyFb43pnBtbCL8bvdAcAuuGirTj1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="uua88/7h";
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7CE606A329
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC7CE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uua88/7h
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso12263957eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 05:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795612716; x=1796217516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hPRYrLMx8bXepIG4VXq81GdMR/g7AjAl+dXuKaeVQVM=;
        b=uua88/7hmoJUaKdwu/Vnec797jNFT+67Ddzq4FfOokO6yfWl8QHzJbyEQRIYVEXli3
         +UtVtZwLzsJD9eiX4+z1oKe+5vcHnhxHVBraRCx1f5iKavWxDuuZCL1NIexXBXr9sTd9
         2aTK+ZzWElS4E++Nf3VYGm/4f0I7AdvqZScUAnFvs9TV4eIuGSxjCh/V7yqaiLulXTLe
         wTEwsu+RicWrGbuHSIdu0eSiaxa4ExXaLSiT6IC72lZHbcQyScf4wEN/4tIdlo0wyoXd
         avlFjSyfNA+Il6F4hZoMku+nAlh32Jk/qyYPWlLcYCyBXTx/TZMBQVQwm4qPJI9+hKCj
         U5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795612716; x=1796217516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hPRYrLMx8bXepIG4VXq81GdMR/g7AjAl+dXuKaeVQVM=;
        b=upyi9KdhtR1T6K+U8K3Vt4n0SS1o/nS7kPEQD5xpk38g9/NqhLBx+uWm4Qc4AB9v9u
         fhTnN1koJlHLnchvxWftZqopi/frhOyR7xyO/eoduMblZCK0mPoJwAVWyVmo1qR2obi/
         OjGwNeywhUokyssQQb1duDhaPOEozZfViEdb/j3RWBe2AQeUfTS9FMi5bQ4EE7EhXKHQ
         Bq4WeEtb/5O9DjuTy/psVbk/sMe7dzn1JI8PccCjTmw5AZor7T2KPhYpJWWS2HixZV+t
         p2N/AXDAteTCVGaOdjtN01+L94G531aUNeE6c36G7EF2xwoHhCXlr91QxGPR1B4/hgMS
         XSow==
X-Gm-Message-State: APuU4Z9x0kOhPzTGo7JjuF2x+T8dzV3bgNjX2b+tK5zmwPyID8MoUh3G
	zFf3W9rtBMAkZ3AbQpQyy1o+OugGkt0XVPr1kU+3OpG931hxtETU04Xk0BSzQg==
X-Gm-Gg: AZFdTZd3s5KEg9Yr3RRD9EKBTVh7RKnMHT4Kpi1ieQ1xK0aTuHMoKue9ahBmstFCowO
	VUpvpeD1mt7pXlZjck3P7hD65O5eNjUqdP5dMzTOfm6RACPSV4XndJbpVO24BKeq1uWsCqHElIL
	kn3wTH7NpnODMB8UZf9M1UOaXzyJ+5LMS+dOrbuIiVZrmHfmVwfRzsXqU66UzD0oLTI6K+vg81v
	7G9i/MC3TdgbGb9mJh16wQMD2375dGXoCOclt80UcSUnmwxWbcmQCZp5GLcwW4eFwTXjvuwgGOx
	ecs01bcTht5PHSDRruUNarfoSYVJ4qDfKfbU+VjwJPrIhPodHQlZ+jL6ivpbLVjv7n7Y7hzp551
	1kUeEnEKQfVVkkwxACdiMeo74UCWWsDRvKU+hOWMyjHw3iQdwXt67DW24TcRfBxPkBqgO9b9G1+
	NFA8oVh47b7BfsEFuBODjXjl0S0ojohrrdfhcU773NU3D/uZLNVoa8udFWUlEjUWUAQpZMOLjU7
	VxoGJqsMzsQvlwhUv2od+5xDyV088oWqCPwAvuf1c7gY0sXX7yxhx7VhsFKDL2ObOTRH1shoYKm
	jmAIf5YYwXpedQ2OoDx2DZHloNvzZgq6q2E4odu3XpdS7d5Lj3p9mpbNJ2iGU3qbojlfWZhzwIR
	sKrhUpnGtyaHEy8YflhFbUN6xML8vM4xoSQ==
X-Received: by 2002:a05:7301:160e:b0:384:c1bd:aa5d with SMTP id 5a478bee46e88-386a87f00a6mr11732504eec.30.1795612715875;
        Wed, 25 Nov 2026 05:18:35 -0800 (PST)
Received: from v4bel.. ([211.209.222.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b1965c02sm24228659eec.27.2026.11.25.05.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:18:35 -0800 (PST)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	imv4bel@gmail.com
Subject: [PATCH 6.12.y 1/2] tcp: Do not allow buggy transitions between ehash and lhash2.
Date: Wed, 25 Nov 2026 22:18:22 +0900
Message-ID: <20261125131824.3345131-1-imv4bel@gmail.com>
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
[ Hyunwoo Kim: Check __inet_hash() for IPv4 and IPv6 on 6.12.y;
  record the state after each locked unhashed check. ]
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 include/net/inet_connection_sock.h |  1 +
 net/ipv4/inet_connection_sock.c    |  1 +
 net/ipv4/inet_hashtables.c         | 11 +++++++++++
 3 files changed, 13 insertions(+)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index e8ee9164ec5a..2ff01a8fbef2 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -101,6 +101,7 @@ struct inet_connection_sock {
 	__u32                     icsk_rto_min;
 	__u32                     icsk_delack_max;
 	__u32			  icsk_pmtu_cookie;
+	unsigned char		  unhashed_state;
 	const struct tcp_congestion_ops *icsk_ca_ops;
 	const struct inet_connection_sock_af_ops *icsk_af_ops;
 	const struct tcp_ulp_ops  *icsk_ulp_ops;
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 61fbcaa913b3..ef0672473b2c 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1261,6 +1261,7 @@ struct sock *inet_csk_clone_lock(const struct sock *sk,
 	if (newsk) {
 		struct inet_connection_sock *newicsk = inet_csk(newsk);
 
+		newicsk->unhashed_state = 0;
 		inet_sk_set_state(newsk, TCP_SYN_RECV);
 		newicsk->icsk_bind_hash = NULL;
 		newicsk->icsk_bind2_hash = NULL;
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index e7b312f7cd98..7f839354641d 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -743,6 +743,11 @@ int __inet_hash(struct sock *sk, struct sock *osk)
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
@@ -796,6 +801,8 @@ void inet_unhash(struct sock *sk)
 			return;
 		}
 
+		inet_csk(sk)->unhashed_state = sk->sk_state;
+
 		if (rcu_access_pointer(sk->sk_reuseport_cb))
 			reuseport_stop_listen_sock(sk);
 
@@ -810,6 +817,7 @@ void inet_unhash(struct sock *sk)
 			spin_unlock_bh(lock);
 			return;
 		}
+		inet_csk(sk)->unhashed_state = sk->sk_state;
 		__sk_nulls_del_node_init_rcu(sk);
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
 		spin_unlock_bh(lock);
@@ -1015,6 +1023,9 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 	int step, l3mdev;
 	u32 index;
 
+	if (unlikely(inet_csk(sk)->unhashed_state == TCP_LISTEN))
+		return -EINVAL;
+
 	if (port) {
 		local_bh_disable();
 		ret = check_established(death_row, sk, port, NULL);
-- 
2.43.0

