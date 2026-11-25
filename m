Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795612937;
	b=Kr8fg2rZOnWwUa68x/o4/OAi3jc/4j3HP0rfmF4migS9PC463J1lalDwu/55VaRE8lu7
	 cxPCgYpaxKpshRJR//ISFVul5zoHJCxEGFYShgn7hDAyWT2pw3HnB/6Zu7ACUh10mvVLu
	 ye2ucQNr+IBSGp2ddVNIclJjgBmeiz0tfNhxIojYOef1j/8rDB+EuEjlHU+mh/aAoU8Tx
	 gunPG6Ex0lWIbtDi/bYBKaqpGW6irgpcBNhUMS5Wsn7WVf+mVdObCXHVSe9jeHbaSPfUV
	 MyVwEugixMLtcJbzMBlQApYu+z6LHz6zBotu4NRgoUXxzuXhl5vcTS6oho9wxunkCdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612937;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=qPMs37yJl+YAr4oXShBJNSYAEEoxoF7Y2uLC74AOAcU=;
	b=0dz9RYwJv19zmEpgdMphxOJG1OdUFBfzvU0O7RhkCcFqq9duPtQ9zbTF1/yOcM08APll
	 oQapCxn6YR/W64cYiLuJzNrEW1zPqcb0+ZAdild4o3YfNqCqNWBF2KNHnqWoO58z0xAMs
	 xMvAb1/QLbp14kEtl4auJ/uQ/TygDwbeqk4P9pjtanYR6jDf5xPJxhd1n+wAMZCn6uyrP
	 n0RMdQD/y50AvLbK6vM3ESqDKAHJDCW8yCndkMp4VK1bjvXxAjdfEnrG1uMoF8yrP/oy0
	 1ilYfwk3pwZndycOpIQUUlBcg9CZFbJvNXpm8sKwC3Bh7X5oMGkU1JXBCXWx72B/d/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gtTTaimd;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9517F606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9517F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gtTTaimd
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cdb2893531bso3018823a12.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 05:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795612936; x=1796217736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qPMs37yJl+YAr4oXShBJNSYAEEoxoF7Y2uLC74AOAcU=;
        b=gtTTaimd/VEQ7z9eKuGr1GV/b6EzI4gM8Mh+XUGgLDOVfrp86gNHRv98j0j7iMBTi+
         4uQziJAj08kEGUalo5fudykAPaIuMSTOYaXkog2ru2je7V6F2vgfkniBQoLDRD6JT5L2
         4gxt91ZRjA8dhFjWASpbzLj36r3z/p/jCLIXK+v71pHlzmcK60QQlTL6MVNWpLGORse8
         RWn+vREl92pVKvyNd8DEUX3wnD246MJCxN1sceRbXUVcXfoGxpo6yWsHoUh4QdRALzt4
         IDM59CHa+r4Y5ordMOZFSzGHPavDRao/yELp8TZNrjQYQiETzd9Fnj8OO0uT1dlegIWg
         336w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795612936; x=1796217736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qPMs37yJl+YAr4oXShBJNSYAEEoxoF7Y2uLC74AOAcU=;
        b=Exq82N9+BhIYmTtMjJwiOZmGP2zXJLEXwkLAd3lRrTJNfj5I+MWDz5G/FkJu7KV2RN
         a/VzQMkFCmGqmhRlqjYpY3lv1tdjJGR0bZgQJTcgKu+bM5PZJMN8it+8clLm1Ljy1gwg
         QFjq9MwmDJ4qQBvYarpqUEXGt8VZZIRT41gGk38J+S7SYhYdvlmsKAxwftggaJFwqYhz
         1suKC/JpZXRahI6+XYOuonXZ3eDBw6Fp3BGEZ+KsxShRUknwQcYceRKiQDWjy8r9fbhG
         aKya578lMyhUGrRWHUuHuzO8TGiq5mN7pnWQAGNZ2+seHQc9TNsO4jkEljospjrJLAqK
         FPyA==
X-Gm-Message-State: APuU4Z84Qv3JE3MaTV0f+DEp+YtLRLO6AvhUJXrlauDnxHo7U17wvFnM
	UUUhCSUQFLhAVM9MMI9uq7onEw5lGzhMeDBiuQD7didocvwfpT9EzkPVuCs0Lw==
X-Gm-Gg: AZFdTZe8J2itiGYjtYeB9kQw4jalXHzeAa99ZBorEkVB5vfqQ069fKSQtg/yM0lzPFC
	MBpjvzRW/gaOaPIKBm6O1rGSspWeZQNwWjTuC7SfAuWGXo5AKg1/0D2c4h/T/MeWG8Sdjroq7rT
	bq0QSlWYUQb5W0DEvQFsFX1p6/4iy3iZMcAUhKDdiDZ0lmyHDw3Vdt5bRmLgAAZbAcmdATQNe3G
	Yk7U1qMDZiIqUETjnAr9KL3hhm782/SYzsKlbFPOB8eDCoNtdllrdYNvT4Y3gcY2Y70omOO9BbB
	XpdiFTwxvyfUMzLSt8ELcA8CgEl57YY9DIshs01BSnq5S4KZK479agrFUbkWZSutS1sry04lyig
	5dYmszToLFZgNOuLAvkEM4vz5070YSlOhZ6sOxvtGDg/JBmxXL7R9YNK6yH7sUeewJvMk8Z4G42
	jnM9Wowr1km2vh10DCgoLqinLSUzZfsqYvLJTVjR/PZQKbNFOTfNKl1LWQ52b6IdBQk6q0A5HnX
	/KFTE91sMLLP0Z5RIs4pME7tMwld8a1xM7qX3Kjo05x2JVGdpg+nzoqvT/hBFT2QY61UgQUeJXN
	gyAGW77GPmzVtntm9AKmVWdskNUyuhRb+CrwvQQ5Rucp0Ptp8czOJkpYXn5AXvtF58oG54JHf9i
	W+jNOrSi8XEj8QWC8K4aKkGoW8lVdiW9OKA==
X-Received: by 2002:a17:90b:17cd:b0:3ab:884b:65a8 with SMTP id 98e67ed59e1d1-3b41c9032bfmr16062100a91.26.1795612935730;
        Wed, 25 Nov 2026 05:22:15 -0800 (PST)
Received: from v4bel.. ([211.209.222.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad48786sm27907278a91.9.2026.11.25.05.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:22:15 -0800 (PST)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	imv4bel@gmail.com
Subject: [PATCH 5.10.y 1/2] tcp: Do not allow buggy transitions between ehash and lhash2.
Date: Wed, 25 Nov 2026 22:22:04 +0900
Message-ID: <20261125132207.3346169-1-imv4bel@gmail.com>
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
[ Hyunwoo Kim: Check __inet_hash() for IPv4 and IPv6 on 5.10.y;
  record the state in __inet_unhash() after its locked
  unhashed check. ]
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 include/net/inet_connection_sock.h |  1 +
 net/ipv4/inet_connection_sock.c    |  1 +
 net/ipv4/inet_hashtables.c         | 10 ++++++++++
 3 files changed, 12 insertions(+)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 2614ef5e922e..13534bf5d0d8 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -93,6 +93,7 @@ struct inet_connection_sock {
 	__u32                     icsk_rto_min;
 	__u32                     icsk_delack_max;
 	__u32			  icsk_pmtu_cookie;
+	unsigned char		  unhashed_state;
 	const struct tcp_congestion_ops *icsk_ca_ops;
 	const struct inet_connection_sock_af_ops *icsk_af_ops;
 	const struct tcp_ulp_ops  *icsk_ulp_ops;
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 3d5816a8894f..bef6c7bf25a5 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -870,6 +870,7 @@ struct sock *inet_csk_clone_lock(const struct sock *sk,
 		struct inet_connection_sock *newicsk = inet_csk(newsk);
 
 		newsk->sk_wait_pending = 0;
+		newicsk->unhashed_state = 0;
 		inet_sk_set_state(newsk, TCP_SYN_RECV);
 		newicsk->icsk_bind_hash = NULL;
 
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index ff5c972d7dea..3ca1a896ab0f 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -650,6 +650,11 @@ int __inet_hash(struct sock *sk, struct sock *osk)
 		return 0;
 	}
 	WARN_ON(!sk_unhashed(sk));
+
+	if (unlikely(inet_csk(sk)->unhashed_state &&
+		     inet_csk(sk)->unhashed_state != TCP_LISTEN))
+		return -EINVAL;
+
 	ilb = &hashinfo->listening_hash[inet_sk_listen_hashfn(sk)];
 
 	spin_lock(&ilb->lock);
@@ -690,6 +695,8 @@ static void __inet_unhash(struct sock *sk, struct inet_listen_hashbucket *ilb)
 	if (sk_unhashed(sk))
 		return;
 
+	inet_csk(sk)->unhashed_state = sk->sk_state;
+
 	if (rcu_access_pointer(sk->sk_reuseport_cb))
 		reuseport_detach_sock(sk);
 	if (ilb) {
@@ -758,6 +765,9 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
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

