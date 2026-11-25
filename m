Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795612656;
	b=OAfrgI2Ddx67miM9lJlDFpqREYvfU+B2ShAadLtR4VkaxnOHk2GVW6YLK0s+bnfhZD6P
	 D2u1ElOT/aem5e2qhFBkC6LGeGFzk6blHAvBet+P58H1LuqfX+C2NE+2zFkxv5+1tglVG
	 WC2mguuoyLc79jOTm2v0A254RkcH69D2lDE67mRoj+9qYXxHI0/FXQLwnMXlMGLq3gmbp
	 SJ/ukaxT9EL5YnC3mBFyX5RTGawBhM0o62w7tLxh6CRAZuQKMZThS4XhgllB522PfDg7X
	 lMb5JtxdAXf2eCOoHL0bxntYp1rXqZyfrOnlFi3Zt2K2CHHGyfWrzKS0IWVAUQOq3GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612656;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=/UrsfFZkXWROjp5TSQw+cpCTXCeoTQ/Co/DesUDAyOo=;
	b=uprXyZRJjsO+ODYdeHEJy3wR60oZyjlnSRUaoUZcM0+oziEU6/LZjl5OfgDkFUpRmxAg
	 agClB7dV0KjAoSFPdGfZ/fG54HTUvQ7Ozj5BLS5cPxQvbmwDo31A462R5k8eIaMfPKXic
	 uRk25eb97Du76XztjKNs1ecs2ZLLocZm2eVC8UOF3m9yTLHm2Q4OrtexC+bNnjl4WHR/V
	 KP7CvDsTYRgyeeG7YphZILXRK7UIf/NiW0eSeMrUdD4r1iJ17S96Y1X8syjABS0gIAyEV
	 UCa15JKVnxezVI4HaM+VgGhfTyUqur3aMIR4xoLC/lpyMooM6DNAqHHOkvWqWpLkPww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KMc1CyHZ;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C135606A32D
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C135606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KMc1CyHZ
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-38692f62b22so6548136eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 05:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795612655; x=1796217455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/UrsfFZkXWROjp5TSQw+cpCTXCeoTQ/Co/DesUDAyOo=;
        b=KMc1CyHZe69HQVh93lVpOvhPXWSfpTzB3a4wmTSIadTEHUC21uCzPIVmPuudK9RfP+
         lHH6g/4U5l1/S3qS3x8h/XZQIiyl4MPwSlWv7TaRzSXiDVpRiu4YoW7wpia7d57p3BRm
         9WA+TovG1R6Bz3CSDupi8iZyWOCSHxeo5uJ7CJax0d4jMzpapmzyfBYKOBZ2sNkFWDKG
         9eLhBmwJYiwDzzL6r4SH4x5OGgGInEQdYdd1XZz7XYHT2J/gcVpnGAyp1HiUcpZO82W5
         GoSLCgM8PMdOvl6vVuGe+GSdI80yMPHz6NKpAirbXAYLwSqual8ec+1L7fodz7j8uHaA
         zoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795612655; x=1796217455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/UrsfFZkXWROjp5TSQw+cpCTXCeoTQ/Co/DesUDAyOo=;
        b=J+UkDui4Z9r0MOLIwIcEEiMsQNrdJXL9OfoAve2Kg5chhQfMQf3KcJyscbZqxTI62G
         iOXFUwp4cffTdkppnPmPpq16HCiwEpGOW7zwaV3LEhsr0Ewo5SScMPU0xR2NI5qQlULA
         9n5SZOHzhSswFnY20QW1frhVh+UPNQOzLRtEiVkUrt7fPjKNx18TJ8qer/51WUiDVFbi
         F05Tun2AxYTXd1KiYyPNk3/tH6lWmqEHll/GDh++q52iRoiKB30t3WPbLTA8ttcN+dmn
         3U+muZUhVKeG8jldc+o/QBE5gBUYujN/E37oP1qu6nN0lS99rFcaJMVvnWaYVf4bqgJr
         A49g==
X-Gm-Message-State: APuU4Z+bCF8GtvvEHafeZYZKMG6G24dvfMRfzTnsG8WEfe1eeJDV65c8
	r1/EqZZDZLpXdM75qfQuHAP2MCE0u7/DWahba0rtUvnHPx0XJHunOjOzr6YCmw==
X-Gm-Gg: AZFdTZeXfrMy6yG2vjoNUHpbK7i/x8gfQQ58QeCXlqJsUWwskqtCoN//B6841bzqfg4
	dKTdHAuk42rQkDR60MrngupQK6nGtHKZApkIyzpmfnpt3l7DKO08vmAjX6+Ti0VoPsVISOB7hgj
	ebnkFMV5iX79z/CoUlC37jdPVv52OBz7rlN8EF5dr7g1s3PCDxGyHjnSFHerAXI/wONLMyFUPpT
	4VHKgRMwga5ke8fRFaAp+jFNeogsj/QQyb8O9b1m/uogVsoBZLJf6E3lQJIJh+ZSQcQB7juv2tK
	h14vINzcKiv6gAUzWB9PuZ9Iyv8dFxYvv9dBX6eecWT7a9SbboOt6vT8IXYv7/57zMNGXtIcULh
	z4O3iHopkTkRl+2cJzSTQmmzYNorx6Q9Egbjg6mtSFTHROjCCyqkSYjZVW3o3sCvQpZyyZiIyuF
	2Y0Nt3biF/TXgBYWnKzEgBjYCDUZFBQ+AoelAV7HoDig2fxlaH6ntpmULdKlfD3iEVJHx4pVZT3
	1y7nZbrFz3ngIn7GdO4ckbLJdKHUyRWi4EYGsGKsHWblsMBV7p3vgkCWqzc2hXzzpE0ryn5KQUg
	yPQBLan45yLmn4DFBBR6O/nYcRZBm6yX7EIU8VLPVt1UdrQJMlmdl1mdiWoRqXkxLO6l5zlYIF+
	NVjFfi+KhoiHsEpvpHf4iO1f945tPaQi7crVgKDDSnmhPhk2dp/FwSHk=
X-Received: by 2002:a05:693c:805a:b0:376:a6d7:8f51 with SMTP id 5a478bee46e88-3856e63bbe9mr21608995eec.12.1795612655148;
        Wed, 25 Nov 2026 05:17:35 -0800 (PST)
Received: from v4bel.. ([211.209.222.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c0c1dsm60283698eec.21.2026.11.25.05.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:17:34 -0800 (PST)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	imv4bel@gmail.com
Subject: [PATCH 6.18.y 1/2] tcp: Do not allow buggy transitions between ehash and lhash2.
Date: Wed, 25 Nov 2026 22:17:23 +0900
Message-ID: <20261125131728.3344877-1-imv4bel@gmail.com>
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
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 include/net/inet_connection_sock.h |  1 +
 net/ipv4/inet_connection_sock.c    |  1 +
 net/ipv4/inet_hashtables.c         | 11 +++++++++++
 3 files changed, 13 insertions(+)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 39ccb785dd4c..24e0b62143f5 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -95,6 +95,7 @@ struct inet_connection_sock {
 	u32			  icsk_rto_max;
 	__u32                     icsk_delack_max;
 	__u32			  icsk_pmtu_cookie;
+	unsigned char		  unhashed_state;
 	const struct tcp_congestion_ops *icsk_ca_ops;
 	const struct inet_connection_sock_af_ops *icsk_af_ops;
 	const struct tcp_ulp_ops  *icsk_ulp_ops;
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 2db9ceda0456..58aff248278d 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1284,6 +1284,7 @@ struct sock *inet_csk_clone_lock(const struct sock *sk,
 	memset(&newicsk->icsk_accept_queue, 0,
 	       sizeof(newicsk->icsk_accept_queue));
 
+	newicsk->unhashed_state = 0;
 	inet_sk_set_state(newsk, TCP_SYN_RECV);
 
 	inet_clone_ulp(req, newsk, priority);
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index c0accacdc3eb..030276cde581 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -791,6 +791,11 @@ int inet_hash(struct sock *sk)
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
@@ -821,6 +826,9 @@ void inet_unhash(struct sock *sk)
 		return;
 
 	sock_rps_delete_flow(sk);
+
+	inet_csk(sk)->unhashed_state = sk->sk_state;
+
 	if (sk->sk_state == TCP_LISTEN) {
 		struct inet_listen_hashbucket *ilb2;
 
@@ -1050,6 +1058,9 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 	int step, l3mdev;
 	u32 index;
 
+	if (unlikely(inet_csk(sk)->unhashed_state == TCP_LISTEN))
+		return -EINVAL;
+
 	if (port) {
 		local_bh_disable();
 		ret = check_established(death_row, sk, port, NULL, false,
-- 
2.43.0

