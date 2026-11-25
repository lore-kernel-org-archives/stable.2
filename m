Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795612817;
	b=Z6piKAmuVcXBJgYYDJzU1FMBdAOGIDSC7UtsJ7dT+Atv3TZYSnAz1ZDqFlg8ZwZIlfSD
	 /qas+fhIW8dg+m+xcg6AwfENu86HBnkVsF7cAVpPukPnvtiaaz4hsj96baDdCsYfDaY1k
	 zzMtlvDn3W0dDJLb/s/zc0OOd4N3d9wqie5T6HEYEsVx+8Ysl0szluiAKphd0hPs0J5lp
	 8cwGp4YziFNjyrlg3QeHRQeLnsjO4M8RGp+n4WbfI8I8pUp6I5WobWd+XGNXKhqQSTf3u
	 r3aLCQL3gs2iLihYQ+Mu0JwkcLMo/kiUjd1yRSCWn8BD313m9/bhoJlz8hZYlo4jnaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=+ZdmTdmHNfE0iytsNn2AUMtuXvo4kt+7kbNz63EVvdg=;
	b=D1sjz4bpZ2LjzoofMifRUC5XJwqnXmUrPneNjtk00aVk3NCGBsF4xi+vlB7QyV4wNntN
	 5rll2a2DF8WWQWpcKhNKKbvF6yIyuiVmVmzWFcQX6PqqwHVbhcMy8PfxZH7IG6xIS3zuU
	 XsWxfCvFOvqSOJlOXjpGvOxOos2ZY4BAvlFSNVr24oln/TzAGHecPJ1G/4zDF4twD/4rB
	 G+H9ENCgYH+3dtmfco8xjP4Psl0AYAUUlVTVY3/2E+HX6Hib1VwuYxCC4IyM3gcA1uxpo
	 RjWicnwl++Cd/B8/LqiKhNFbKbk+RGHXD9u/g1lUm16dxRv2SGlbys4Vctr5nSzt18g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s01sJD33;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2122C606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2122C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s01sJD33
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1b24f4b15c4so2448616c88.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 05:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795612816; x=1796217616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+ZdmTdmHNfE0iytsNn2AUMtuXvo4kt+7kbNz63EVvdg=;
        b=s01sJD33LemUMfSlM+PGtgWPzskinjKaFEyanFum6ec9GBCLmb3MAnhLKTAt+CL7uA
         uZTGrrcm39/yOLVyUVxT1PkuzyxjWlhRor3cjSqmiwHkT5/EYD0szzV8kPs/JNoBnr3b
         A2MLrvlYXmgMYWOPc0X8kAEPdRPSZHevGwmmryQHdxKgIYfzsEIgX7/wvBWnw8bQKq9E
         GwvA4YFXivBulEOxdmSGP21+BkgtzlEmdbDZd4NLmAvRzI0LRZZcp+yvRfTsQ+5xmzaM
         UMnLGm7F4/3nIPM1i2s0lsxtvQhgNJY5DURHFwbe2oDnhcnCOA8QMV2asgYOmbVERlq/
         Mgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795612816; x=1796217616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ZdmTdmHNfE0iytsNn2AUMtuXvo4kt+7kbNz63EVvdg=;
        b=r8LdC2FtIIIzQBOzrqiSyHHtwzLfp1ny2BflApbUEcvXO0qONaeMbncziSCweZgp2x
         e48NKmg38XNSdM8tByp8k66c2g3njm1/lxNAZ3h0io5bwaWazFSHn+1/Jf5nsmpTsL9G
         iNyU2qZYG3zGyD1LEEc/Oo8oBcL91MXiJMSdVQpeIttSq2NPGo7ysQ4bNgrqIYJLjS0c
         SmjDbkTscIKJSNxuN4RCLwe6l9a3kSkz4JaDsyqGm3FFS0zDiq3b/Qs5ertiUFctyYJC
         cwE6p7UMlOqEINKNkqCXkhxxSYPOt0j/I90lrrI6hINZUTQ8qVNzc1KB5ahsROAX9yA0
         XpJQ==
X-Gm-Message-State: APuU4Z8KHUBqc3G+P272JKvA4LgVobngpq0EgZYX2Mt5Yq+wE66L7GQW
	SVNMpvACKW8U7CXVctbw+WwfFZnvUOy/W+r1i8ZTM0kY3/5H9xCT5qyyyXdxAg==
X-Gm-Gg: AZFdTZfvOJi14ElKPsHQGHbfYajcqu0LFts/T3TwUOJpUKZWWFm/H8IHqXzBqVblrx5
	Vrjgp5LVD/3awHJRnHu0VE6Y30igBBs/IQjEOyDjeTGKvwfsfcV5GLBijOFRQkpBqOC6vTcdqcJ
	e/L04ynru+iSf7fhRmeJJBKuBnimVqj689lrMCNMXUzRUMVIlHNbyOPgteUR5yuaWU5ouIRDpAs
	1pK0TcUQITPEKsr9c0AK8WtdwBV7Qs6nIl6HsUDo7DdCwBJgIIY1bXfOoIGgSU67StaqWAbQiif
	50rpNlRE0bdMRj7aDeMywA1c09cv6ra2rGC8BzQllN+NtiUZWRWaTI7VGL9ud0eDFtpqKn1+fyh
	2ybMwHh6loEit10HWtJrdeaMBLL4KxlujLOiXeJ1QDg4qkIfe5VgVjsBoXU3xxWe9/JHOfGkTin
	R+HscOmNtGZpjIXaTXJhY6d7J88ALPrD+9yJaae5U6wsh3Dno3xwiKDXvAk471FhAiPdVFNeeLa
	kx7T3kwrB9bm4SE5a5/cdBo7PBAooAM4049cW0b5na2efwisiGNDBuzVmEDKE+NQY4hh8Pimkji
	6Xoaw8xgW6fAmTGuSqRb2Kwz6oA29R9mBxxiGVaYvJBdBO6mF+c/4nub4oZ0YlxC9e1+3rVw3ZH
	UyPgs39I/UUdICy0W6tbDZZMNHOhNIZ0Z7g==
X-Received: by 2002:a05:7023:a41:b0:1b2:67f9:43cb with SMTP id a92af1059eb24-1b5525e786cmr19012879c88.17.1795612816014;
        Wed, 25 Nov 2026 05:20:16 -0800 (PST)
Received: from v4bel.. ([211.209.222.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556840494sm43081206c88.12.2026.11.25.05.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:20:15 -0800 (PST)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	imv4bel@gmail.com
Subject: [PATCH 6.1.y 1/2] tcp: Do not allow buggy transitions between ehash and lhash2.
Date: Wed, 25 Nov 2026 22:19:59 +0900
Message-ID: <20261125132002.3345611-1-imv4bel@gmail.com>
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
[ Hyunwoo Kim: Check __inet_hash() for IPv4 and IPv6 on 6.1.y;
  record the state after each locked unhashed check. ]
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 include/net/inet_connection_sock.h |  1 +
 net/ipv4/inet_connection_sock.c    |  1 +
 net/ipv4/inet_hashtables.c         | 11 +++++++++++
 3 files changed, 13 insertions(+)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 51be99667a23..76ec18fdc5bb 100644
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
index 3ade0dd5cdbc..b53cc36efd78 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1196,6 +1196,7 @@ struct sock *inet_csk_clone_lock(const struct sock *sk,
 	if (newsk) {
 		struct inet_connection_sock *newicsk = inet_csk(newsk);
 
+		newicsk->unhashed_state = 0;
 		inet_sk_set_state(newsk, TCP_SYN_RECV);
 		newicsk->icsk_bind_hash = NULL;
 		newicsk->icsk_bind2_hash = NULL;
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index d4fc6ad1e2d5..7510330e2dc1 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -735,6 +735,11 @@ int __inet_hash(struct sock *sk, struct sock *osk)
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
@@ -788,6 +793,8 @@ void inet_unhash(struct sock *sk)
 			return;
 		}
 
+		inet_csk(sk)->unhashed_state = sk->sk_state;
+
 		if (rcu_access_pointer(sk->sk_reuseport_cb))
 			reuseport_stop_listen_sock(sk);
 
@@ -802,6 +809,7 @@ void inet_unhash(struct sock *sk)
 			spin_unlock_bh(lock);
 			return;
 		}
+		inet_csk(sk)->unhashed_state = sk->sk_state;
 		__sk_nulls_del_node_init_rcu(sk);
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
 		spin_unlock_bh(lock);
@@ -1008,6 +1016,9 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
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

