Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795612877;
	b=r7cNL819+GLYp6coTNoKB6SZUjbIpnGJaBf+m+DpWRSIbP0OK3xkN1bonIEBBFhIa6yR
	 EmSQ1BGrPzEvsB8F6TszaqQpOLinvGI8fki2/BO6L7iFIU1hUF+FYEScgpvVmt2rS4Kxy
	 yqfZG5qmFJ/XbCg5ltHAiy3Oubk2GtjfUY2SwmQXGBiL0hzowNEa+tl53uZwreBoHTQw5
	 UtztNGAFQnWRANhJKD5sSOt9F/FiAq3/Nkx9oZNrCS7Nd+JtsR1oAFfAMHMEaKo1fLbdb
	 v27QaJ5wU+nc4PfQ4lfummjnLa4r8gD6da6zV4E84KIYVAnJPAqhEXESgZ9Npkwl+Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=jSSWUEgzzAZbciPxcxUlXD90n5Ovu7mR3l7BPQua9xM=;
	b=BTZxlxzIh7opvnS8aQZCT9olknplXVQLiUGlsCsPSWD0pOpk9wSR54i6GlzRgtME+s8I
	 ESDyB0KAIvSkflpAXppt40AMhnKwNtC5TgEagGkEykOuZnqk25bdN18oroS5GIBL5Zs5W
	 vhNvpmQAEVjnLplFjhGWelV6mY+sKH01U42Lu79+rYgsyZY01DXBmUw0O7K7iXz3k8D8Z
	 h1ZFIXv02wBkIS9xKVhh0KxTLvgc1mI9AQniUXXnC/SRoNq4+HmDgwVgZNafjWYT8a4+j
	 PmfVkgIaUWLGCV2WWu4nMVhNZ9lyPRiKuSk66KNjkq7LxnAitFdc6+WZhgFEd6Y7XCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IwUUEImE;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FC6606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82FC6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IwUUEImE
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-38431138772so7417762eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 05:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795612877; x=1796217677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jSSWUEgzzAZbciPxcxUlXD90n5Ovu7mR3l7BPQua9xM=;
        b=IwUUEImER5r2aI3fBegXEw1okXHXyXALPBxW307VNZxiMtAJPb8lzJs6CVzoeWUIyI
         VlaOZpTCoEP+trgmKsBRU0gpefXOx4furEyKy1kWF++6/T0QH57ILSVUvUu/ivJ5Knd2
         9fXRhYZkDe7PUfTIW3inbaIShJrGd8V0zYNOMl70uWF1rOdkS/yzZae2MPROmvJ0dvnx
         knQH5q7DWWa+xHRD0qJ8jUMtB3dli3JP1m+MZEfJAML7erLoUN/e7uvSWOfU1IzV01o8
         6upM2SOcGoJq/cxLPez26S46g23PxRTSsA5NnGKLELOptooXrlOpw7OTZqk+xsP+3A4H
         4PwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795612877; x=1796217677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jSSWUEgzzAZbciPxcxUlXD90n5Ovu7mR3l7BPQua9xM=;
        b=OZc8Q295DaOjLPrFoUOci01HaJ4XHM55A7OecYpTUB049aGXX4Ir+lQoJxj7Z8m5uF
         3G99qClc2bGrxqx+GYo3O/BZ1MHGSxQIgn6tckkfdkJf6Wxahh4qaVS5BKUr2uzwL7pi
         yyft6Kx254HV8oOQc6Ckz3VTFOp8nM4XCPq9iWQ4IodnTKOSdYyVw2B1UNSRcb4HtM/M
         AcM2upSVOdfDBb4Lk8r673oYiA6kAgw5WgAgE103FBoBte5HEz18H+MhnybEd/hMQSBD
         xvidgLGuh2JnpIyI/KxMOSPtzMA8sE+Cu9w6fJ1rc9oloUM/xOkZpFtvrn3FTd7Qb7NF
         cbQA==
X-Gm-Message-State: APuU4Z9g97ZBGW4QZjIrAfAOXy4OMITT4D5qSEEvDayshu2li7OfARWv
	Ej4P0eDbKirJ4cuoQ5neY5iOhrwSmD1xfj93pVEB+RURoiEDkwFJw1xRM/ILLQ==
X-Gm-Gg: AZFdTZdwn0QUy6etgRDRLCWSE5b9m61VRSJriPLx09InnUJqS/lbuH3hIRMUMF2d6Wd
	XhMgG05zxY6jnixc95rAvV5wbo0+sFdiDX3RNaiYwjfY5g93UX835dW8dwCXMK4e84rbCnCt/jX
	Sm1Jtj4vqV4jGXo4AxvtruMHvg/inYJkIdV5sQ8Ewyb9NWWh+DwXkGiP6dt19Ulz9nYC2DKg4x+
	43IBJbKMl7QpLfI6vEdJLR/GK5FlrtxfmN8Y4h72SGY8bUpRX5q9lSguhFccdPqkvwGp5T0t37q
	x8ls8kz4UKlAYiVylNczNyStdxNGXUjz+vosYPmgxAurecy+3mnituu7yvG9GUwuAaaoNdazjrt
	w6tFV12rAJIeo8Nub0ndt+wwq/amFuvbRu5w5UO+ydHmaVi5+3o5kMxZGyvA8djW8Kk+3xSzqCR
	G5gJ81XOM04RFX67cwHbhdsn84RAac6A+rXrs/Q+8m9b5Qxccv7pIIjGEau2aAfLiPLQjj1YxY2
	/AWG01UWOAqq1m5bsmlQhsWgOB/Dow7/sekh2fzZDksRd4AViXiGtjrWGS5LlgiqDtv9kj5LRrs
	wVRaRU1x2KYjgpZ2uuqLuAhTNN/SAgUXgRV/8sXneaaZ1+1hkCzTLruUyNPtLTwGB45FiBJpDAs
	y4QU6IJrz36LgzS8Rd9c1S7eqDtR2TdVbGg==
X-Received: by 2002:a05:7301:152f:b0:376:203e:7d7b with SMTP id 5a478bee46e88-3856c6b35b5mr20316845eec.2.1795612876341;
        Wed, 25 Nov 2026 05:21:16 -0800 (PST)
Received: from v4bel.. ([211.209.222.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm45646768eec.25.2026.11.25.05.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:21:15 -0800 (PST)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	imv4bel@gmail.com
Subject: [PATCH 5.15.y 1/2] tcp: Do not allow buggy transitions between ehash and lhash2.
Date: Wed, 25 Nov 2026 22:21:05 +0900
Message-ID: <20261125132108.3345914-1-imv4bel@gmail.com>
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
[ Hyunwoo Kim: Check __inet_hash() for IPv4 and IPv6 on 5.15.y;
  record the state after each locked unhashed check. ]
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 include/net/inet_connection_sock.h |  1 +
 net/ipv4/inet_connection_sock.c    |  1 +
 net/ipv4/inet_hashtables.c         | 11 +++++++++++
 3 files changed, 13 insertions(+)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 041f164c98b9..e905c23c8daf 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -92,6 +92,7 @@ struct inet_connection_sock {
 	__u32                     icsk_rto_min;
 	__u32                     icsk_delack_max;
 	__u32			  icsk_pmtu_cookie;
+	unsigned char		  unhashed_state;
 	const struct tcp_congestion_ops *icsk_ca_ops;
 	const struct inet_connection_sock_af_ops *icsk_af_ops;
 	const struct tcp_ulp_ops  *icsk_ulp_ops;
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index ef18e663a547..aa8bd614627d 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1019,6 +1019,7 @@ struct sock *inet_csk_clone_lock(const struct sock *sk,
 		struct inet_connection_sock *newicsk = inet_csk(newsk);
 
 		newsk->sk_wait_pending = 0;
+		newicsk->unhashed_state = 0;
 		inet_sk_set_state(newsk, TCP_SYN_RECV);
 		newicsk->icsk_bind_hash = NULL;
 
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index e7c7b24011d7..ee64c25264a4 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -613,6 +613,11 @@ int __inet_hash(struct sock *sk, struct sock *osk)
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
@@ -666,6 +671,8 @@ void inet_unhash(struct sock *sk)
 			return;
 		}
 
+		inet_csk(sk)->unhashed_state = sk->sk_state;
+
 		if (rcu_access_pointer(sk->sk_reuseport_cb))
 			reuseport_stop_listen_sock(sk);
 
@@ -680,6 +687,7 @@ void inet_unhash(struct sock *sk)
 			spin_unlock_bh(lock);
 			return;
 		}
+		inet_csk(sk)->unhashed_state = sk->sk_state;
 		__sk_nulls_del_node_init_rcu(sk);
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
 		spin_unlock_bh(lock);
@@ -716,6 +724,9 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
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

