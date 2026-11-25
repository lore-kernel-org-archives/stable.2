Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795612170;
	b=Jpd/k+qtKl8ObG0uYe79RD9roPaSZ+/0HeSbvrZ2BVtJhAgXENz/S1zS7IkiAnYRdTHO
	 ZJDNjIsaFy70De3REgu2iGLM6YWr0Vls0zsjyG4UyLpj5yMZG/NH3tH0Cug3BQWLzJljo
	 7L4NVYJfoJmSLE29h/E349pSMxq0E3v0lWtFDhs3/MEWyZiCAjwryHv01nksFkb13MVLr
	 bQc6EC2/NzxXqqiniXYq3KTNgLVwaKVihL0TBFFQyXl3CVy6Qqc8lo1BGYT6haFKSADUe
	 9XmgVvTQ6GPVYFUTTZuPQVi0fsRqv17jHg6A23UqGLCxKsoqAxk90N+2sKBfeauh00Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=vEEmgsA5gTq5H10w2IOmbMdBsujQC1vETHR2u2RbVjA=;
	b=sYPAXNhguZj62/oKdcz2f8J5lDgo6yFFQX4qVeM/0rjRBvtJqGz8g28vjSrvtUi84RCc
	 FJn4AlDqUsiBoCYQRxe/wPiMD1M2SWhoPwcgkT3D8PGuPf/2Ox04V6k2drd9uv4NFB0wk
	 D/nClOw+0FJ2+huSmTubhLSZcI10LVMSOJ5UouTleN4zS9Qm5QRFl8V2kM4n+PA6sW7eT
	 gojOGPucU/fZlsAfSAyUqEXNVeeeXgLb/SB2nFgwiIji4MDR4/SL0BzTj5b2L+qg2ki4i
	 +KMA87b2mnZrkhPHois0QJ77j1VWSUlobWJ9+pHmBv+b7lmaYmFT3ivrW6Fu3Q8H1hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=asPmUGD4;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFF5606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DFF5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=asPmUGD4
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3869f03af6aso4978646eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 05:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795612169; x=1796216969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vEEmgsA5gTq5H10w2IOmbMdBsujQC1vETHR2u2RbVjA=;
        b=asPmUGD4i9V684ZRC+Dwq4wzlA+KVztffQdslrlAcIcPGAwYMmIByZ58E152XEX02h
         RNEvkRa8BrrZ6HvRZwbuQBaGDAaXMgIaDpxXJO9NPGJZO8TB9G0rH5M0FVjjsiosq70s
         8kZkRE4Neu9kcdUDWcntvhx8Mv2xCal05VkuSzXyHk8IPUvRS8DiZ1q59/IQo5G8CF09
         tb+TIVQcYQRTdyBKrx9Pb4U/sbDvcDnWJh1X4GQO66PP64BqS0ry75S57+m5Mf9cZ80k
         3RqMfTCyKbPfnTfZfebzzmvP9DwSxNSNa+rJ9HAgTDYZa5eGnJMtqu0BKFnv7dyvPssw
         l9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795612169; x=1796216969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vEEmgsA5gTq5H10w2IOmbMdBsujQC1vETHR2u2RbVjA=;
        b=GVFnCyF9zWnrsHQ9/cvN330EVfo1no7P/K3/FT/DQE4JiBaQkexucn1NytNdFEpJs2
         yDHCUfPd0FaTWe6vy3daYoaZ9QmDguAlun0S8FY3C6G4xOHE+xdSyOmjC57g7RonvCeh
         ujWTAX1eNNFeq1oftavQEcQr4x7XH5fpgnVmXJVh6vdYXvswN1AwkGtDjUXEDXawaLhS
         XoUxFf162vRVPRuVYX/eZZodFaptT8IlKUvmqAybijLODQWgpa7ijLd9OEGJmLqdV1DX
         NiFimNM10GJJ8v+T7Ise/+SiaSRNWVblh8f4uRDUitzVJuPryoh3SMD4OjdSEFZ5ufng
         2P7g==
X-Gm-Message-State: APuU4Z8BlHLBqcQw1Qz7aajBdTVdo/8p0pvV+p1kbrjDRvXoxgXQFqLs
	xUopIJF6Nf+x6g4WMP9URFQLlotl57EamegrfKPl7cjcHkGFqNouyvXiv0CoRw==
X-Gm-Gg: AZFdTZdbnyMtcMkNfKSyJlbTiy95Hfc/8+ItHNNLNb/gY9/EfUWZR2dpAtdrG/FGFel
	PosKp0f2tKKOvYviWbfh2qiz4hmqkLWQXEZQZoxJ+o/QJTYeHFiqqcreOAoIVoSyyAL+k7Rt4AP
	9jUjnjxyQ7+TOgOnc769aBuKoLntJ11LlwvaDlbYsZdmafYEUaWBu1SzkTnCY3dDukaAYBUEWKU
	p2ZxHOM8x8ToFP8g4MUgCs3vtWcNYjtUcAKU9DnKgzejCR4mGa5NydI+OjhE14eute8zK1YuUe/
	x4gGmrQx/VEW6YwhtNbg6LL7aUcKm8Yfg1dTmBYet6j69vRQVjMBFdZGU+PbTqivOrD8NQtIvAP
	loINsYVMYEEQkOtyuh4OlJaqa8O0mfSaHtu3UX6+RuFkVsjlzZiM6JkuhHOJgJvU/c6OmqFAqx3
	VnSQnLPk/w189Ih8IYaL1jUfhVah1HAKRBYu2k0w4NJMvELG8cz+KyP5sEW/turUZ3c6/29bLEi
	zvxyq+pdyi13XyQipm37Lq1FFDC8v7kfVual+zJ6ybJk1wxVoBnMI4v+IW2BANA0boxQaRZ3yjR
	u9+BPVtsvapc+7DNQAqPiKXFGnu3nMd6ZKgFe3tUJwJk2y198hrMRVkSEkvp9YPwKIGV9joFXuS
	3LP4G7In3/ZM//geD+KIECaVloC4tf1tnnMsdhGEKh+e1gh8wsU66ogs=
X-Received: by 2002:a05:693c:2181:b0:385:5ea7:73f with SMTP id 5a478bee46e88-3856f94ed95mr19657492eec.7.1795612169371;
        Wed, 25 Nov 2026 05:09:29 -0800 (PST)
Received: from v4bel.. ([211.209.222.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3866f299d0bsm46312537eec.19.2026.11.25.05.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:09:28 -0800 (PST)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	imv4bel@gmail.com
Subject: [PATCH 7.3.y 1/2] tcp: Do not allow buggy transitions between ehash and lhash2.
Date: Wed, 25 Nov 2026 22:08:31 +0900
Message-ID: <20261125130843.3343543-1-imv4bel@gmail.com>
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
index 433c2df23076..903499581db7 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -94,6 +94,7 @@ struct inet_connection_sock {
 	u32			  icsk_rto_max;
 	__u32                     icsk_delack_max;
 	__u32			  icsk_pmtu_cookie;
+	unsigned char		  unhashed_state;
 	const struct tcp_congestion_ops *icsk_ca_ops;
 	const struct inet_connection_sock_af_ops *icsk_af_ops;
 	const struct tcp_ulp_ops  *icsk_ulp_ops;
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 71b0c344579f..e56beec43877 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1262,6 +1262,7 @@ struct sock *inet_csk_clone_lock(const struct sock *sk,
 	memset(&newicsk->icsk_accept_queue, 0,
 	       sizeof(newicsk->icsk_accept_queue));
 
+	newicsk->unhashed_state = 0;
 	inet_sk_set_state(newsk, TCP_SYN_RECV);
 
 	inet_clone_ulp(req, newsk, priority);
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 7ffa9171d6de..860145d810ed 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -804,6 +804,11 @@ int inet_hash(struct sock *sk)
 	inet_init_ehash_secret();
 
 	WARN_ON(!sk_unhashed(sk));
+
+	if (unlikely(inet_csk(sk)->unhashed_state &&
+		     inet_csk(sk)->unhashed_state != TCP_LISTEN))
+		return -EINVAL;
+
 	ilb2 = inet_lhash2_bucket_sk(hashinfo, sk);
 
 	spin_lock(&ilb2->lock);
@@ -833,6 +838,9 @@ void inet_unhash(struct sock *sk)
 		return;
 
 	sock_rps_delete_flow(sk);
+
+	inet_csk(sk)->unhashed_state = sk->sk_state;
+
 	if (sk->sk_state == TCP_LISTEN) {
 		struct inet_listen_hashbucket *ilb2;
 
@@ -1059,6 +1067,9 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 	int ret, i, low, high;
 	bool local_ports;
 
+	if (unlikely(inet_csk(sk)->unhashed_state == TCP_LISTEN))
+		return -EINVAL;
+
 	if (port) {
 		local_bh_disable();
 		ret = check_established(death_row, sk, port, NULL, false,
-- 
2.43.0

