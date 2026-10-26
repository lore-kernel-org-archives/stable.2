Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792975122;
	b=V3FYo5MwaaQd/DF1EoZhjZt/Zrenn4PyVzcy/HiciYjIXpD8yPlFzYeSvDrIPeT5yefB
	 b8Fb3o0/Pblkd2CxfDHK3L+sGyqKRHykRDe70qeTW9DWMagMaMkNSBlAl905MtEgAaLWE
	 F0sd5gmhc02CZD7Gghb6OZyDHnXBeiKG1n32+awbxCvRaOzqnRN7SeqMj9sflsen3rw/l
	 KqZN6h1MDSK6Tc1sAEVoPAEkTvy+sFZjgn8kdWud9RJ+qDoXXdCSaKPr3z6wOcMfvVjml
	 b3j30AEFXrSg3XyIMxB5Gn+bn6HIfusizNEwL/zy1DE381RJxlBM/KB0iimXKDZJJBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792975122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SnNXIBCZzM+7Fe/NhRu/VEylCPAE7iggYNK2LASmGYM=;
	b=HALWiAAXeZxweHGgnggMD6ogBICbTBBlWnglJry8pqjiEPedJGYNp6eEWOcC9qkbmwLR
	 /3TvZLdEyC8cIdkuVJXZh+WhdmXOziDLSPWv4lMLxv81wmlAYY7SlmvIrXhcOAkWLBQOO
	 XZ9o7EkACBNXaQyfQD8QxYEtE7jyWHA8h2JPH59yibPR//UVyGqis2MPOB+jpfbYxrjDW
	 G8tDnkxPqvYaiHsLFHgcRhChLUcqlpZv+bkTXilw8hY7CY3TD35eYP0Dk1LijYeDcVUjh
	 yTLE4kRBKeMns7IMLCSEfRFuwQQh6cb4nxSz1wRRckDZDW3OHNdPszM6RIAlKGjwpFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O2iGEOAU;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF730606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 00:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF730606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O2iGEOAU
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35f1f76ea84so4181316eec.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 17:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792975121; x=1793579921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SnNXIBCZzM+7Fe/NhRu/VEylCPAE7iggYNK2LASmGYM=;
        b=O2iGEOAU0israU7Eo2H9IozkROd3a049upIWgp46TWD9y0JVWf74EUo0XPmxbJBuS+
         i9EQ1ybvA4Oxbys8EKykEVo/bXNufjADlpQlcQjgvQ/L8WocUlkrBPgTU2ngC7y4elth
         z3691j2rdxlnRvd7rRQZGYHw3Wp3/FrJYYlydAp7hIxMTE32Nu1vOv13rTQla8lypEji
         bAU3V2SH0tJ5/x+aOuakzBMhqEml77nIDUqLLQ/op/wF9v+LI8PumH0DpBzhXhpS/xhY
         U1a9PNh++wpcl6P619ymo33HsJAM9A6SxGx4lZ3oqagfgl/AyVWCUR9q95Mw3cKUJrcD
         BTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792975121; x=1793579921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SnNXIBCZzM+7Fe/NhRu/VEylCPAE7iggYNK2LASmGYM=;
        b=BBq9W58PJO15uW/rGOJpjzY7AbRDyme7sRW/j2af2HjmUPHacfqfzJ2MPTynBn9Vm9
         KurEUgd/UcxCZpXry3L5Of3CcfCbVeFJ+9zrPdMmd6kQvE44VBkrW49Ofejasft/NPlf
         NLXM9ePVEfaWIbNAV3WsebFkTeel7s61qwJroe3FOalCAPE3U09MooBwxKoAfNrcYPgT
         mBIyr545H0oolJ32iI+gnxIr83D+y2EGY5S3IGQ0MtZ1hB93A5nEpCiM/SlNwgSADBL1
         krnXUUuvV1Jkau1nngxAVojsX966UfsBTvAZWODemBwnxmm26Tk9QoexN0McmMLbCJh3
         /sxQ==
X-Forwarded-Encrypted: i=1; AKwUvBxnsLn9//bVHrVHTfobGNTh8ye488ZYLUZZCXDVKcplTUgbO0MJWrswhFumS1f9QyuzThyh1Q4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKo67k3ady2Ezmqg7Xz0yiNxEFX8sq261m4WQOdZhL65DymrIlc
	FLTHejPjeelJ55N3vbhvu9J1QcaJC7pXaRJE7C9+Si+ZyLyL0MGF3i4N
X-Gm-Gg: AYBFou2xInbmyFLIoYq6BPo42lDTF3Uf9Qrg3WtkAO3yY+eiLhwWAeyJwPUkBKY45C2
	/iB45ied8qQHMe6SEnQO6NxCG5ZYH4AkvwEgpu1/ANSm7+bq1BI6vXDKwnQ2BgodQWHfW5iVBgL
	fIjfme7u2YNjL+vNlDBpMPTf/sFyeqWd0KIDlFAsqU1Q0Ce/QLwTEiGrLy//IZIqDfhsF7wGznW
	L2n7wOSylzKm+K6m2duLMCp/IySafAIMD1dDKvUPbyHjmgU/PLtiJylr+mUxjhq+JfysPPU9ACd
	Y0XEUc+ejTvjqaSP3rL4YhQU2MLGcLSX8atKOUepyEK/AFEPlRlemXtVrnYCTprc2XYXKfkuUjV
	/DrkMQQOiyWJ+1MeERwwQ2/nCFZFnUxiEnbpvqXGMcWDEKhBx8ilvSUC6TdEYjTE5AfbrDQ27fu
	1iIgPjDVUcUJ2XDIn6gi4zImh5nAD/w8eZdf8V7GDpJjB0BtTXaO+65zsJBhYbxLAhcfBlnbyZl
	ANTCv7RRbTLKMTS9FlVeYYyRLzBS7Cd7S6OC9Lfgg6OvOPDaRWkFRVS169n3m++Tjcvub5KjJqV
	Kg==
X-Received: by 2002:a05:7301:a02:b0:35c:f667:8b9a with SMTP id 5a478bee46e88-369e84dc400mr7908300eec.6.1792975120674;
        Sun, 25 Oct 2026 17:38:40 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec50bcsm37925013eec.23.2026.10.25.17.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 17:38:40 -0700 (PDT)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: edumazet@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
	martin.lau@linux.dev,
	john.fastabend@gmail.com,
	weiwan@google.com,
	sd@queasysnail.net,
	jiayuan.chen@linux.dev,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v4 1/2] inet: reject unhashed sockets during established lookups
Date: Mon, 26 Oct 2026 09:37:44 +0900
Message-ID: <20261026003804.61923-2-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026003804.61923-1-imv4bel@gmail.com>
References: <20261026003804.61923-1-imv4bel@gmail.com>
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

TCP established ehash lookups are lockless. The socket caches involved
use SLAB_TYPESAFE_BY_RCU, so memory can be reused before an RCU reader
that retained its old address has finished.

After a tuple match, __inet_lookup_established() and
__inet6_lookup_established() acquire a reference and repeat the tuple
check. They do not check whether the new object is hashed. If the
address is reused for a socket with the same tuple, the lookup can
acquire a reference to the new object and return it while its nulls node
is unhashed.

A PoC that drives reuse with a SYN cookie request socket reproduced the
crash. The new request socket is unhashed and has a NULL rsk_listener.
A lookup that had loaded the address of the old request socket acquired
the reference published by tcp_get_cookie_sock() and returned the new
object. tcp_v4_rcv() then read sk_state through the NULL listener.

The resulting crash was:

  BUG: kernel NULL pointer dereference, address: 0000000000000012
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  ...
  Oops: Oops: 0000 [#1] SMP NOPTI
  CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Not tainted 7.3.0-00591-g0e135910deec #1 PREEMPT(lazy)
  ...
  RIP: 0010:tcp_v4_rcv+0x44e/0x1280
  ...
  R10: 0000000000000001 R11: 00000000024ca8c0 R12: 0000000000000000
  ...
  CR2: 0000000000000012 CR3: 0000000103d50004 CR4: 0000000000770ef0
  ...
  Call Trace:
   <IRQ>
   ? raw_local_deliver+0xae/0x240
   ip_protocol_deliver_rcu+0x2d/0x180
   ip_local_deliver_finish+0x84/0x100
   ip_sublist_rcv_finish+0x5f/0x70
   ip_sublist_rcv+0x12a/0x1d0
   ip_list_rcv+0xfd/0x130
   __netif_receive_skb_list_core+0x223/0x250
   netif_receive_skb_list_internal+0x1d2/0x2c0
   ? try_fill_recv+0x39/0x7b0
   napi_complete_done+0x74/0x170
   virtnet_poll+0x445/0x600
   __napi_poll+0x27/0x1e0
   net_rx_action+0x2fe/0x3b0
   handle_softirqs+0xc2/0x2c0
   __irq_exit_rcu+0x74/0xd0
   common_interrupt+0x7f/0x90
   </IRQ>
  ...
  Kernel panic - not syncing: Fatal exception in interrupt

After taking a reference, check whether the nulls node is unhashed in
both IPv4 and IPv6 established lookups. If it is unhashed or the tuple
no longer matches, drop the reference and restart the lookup.

Lookups racing with the TIME_WAIT hashdance, or with a request being
replaced by its child, now restart and find the new socket instead of
returning the old one.

Request sockets that were never inserted into ehash can have a nonzero
refcount, and a stale lookup can hold a transient reference. Therefore,
when SYN cookie, Fast Open, and request migration paths fail after
setting a nonzero refcount, release the references held by those paths
with reqsk_put() instead of freeing the request directly.

Fixes: 079096f103fa ("tcp/dccp: install syn_recv requests into ehash table")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
---
 net/ipv4/inet_connection_sock.c | 10 +++++++---
 net/ipv4/inet_hashtables.c      |  5 +++--
 net/ipv4/syncookies.c           |  2 ++
 net/ipv4/tcp_input.c            |  4 +++-
 net/ipv6/inet6_hashtables.c     |  4 +++-
 5 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 6a30f11384547..bd0bad96c93c3 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1136,10 +1136,14 @@ static void reqsk_timer_handler(struct timer_list *t)
 	 */
 	if (nreq) {
 		__NET_INC_STATS(net, LINUX_MIB_TCPMIGRATEREQFAILURE);
+		/* The timer was not armed, drop its reference here. */
+		reqsk_put(nreq);
 no_ownership:
 		reqsk_migrate_reset(nreq);
 		reqsk_queue_removed(queue, nreq);
-		__reqsk_free(nreq);
+		/* Drop the temporary reference and the one reserved for ehash. */
+		reqsk_put(nreq);
+		reqsk_put(nreq);
 	}
 
 drop:
@@ -1447,7 +1451,7 @@ struct sock *inet_csk_complete_hashdance(struct sock *sk, struct sock *child,
 
 			__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMIGRATEREQFAILURE);
 			reqsk_migrate_reset(nreq);
-			__reqsk_free(nreq);
+			reqsk_put(nreq);
 		} else if (inet_csk_reqsk_queue_add(sk, req, child)) {
 			return child;
 		}
@@ -1502,7 +1506,7 @@ void inet_csk_listen_stop(struct sock *sk)
 					__NET_INC_STATS(sock_net(nsk),
 							LINUX_MIB_TCPMIGRATEREQFAILURE);
 					reqsk_migrate_reset(nreq);
-					__reqsk_free(nreq);
+					reqsk_put(nreq);
 				}
 				rcu_read_unlock();
 
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index ba0faa9ae2bb3..58d54965036a2 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -552,8 +552,9 @@ struct sock *__inet_lookup_established(const struct net *net,
 		if (likely(inet_match(net, sk, acookie, ports, dif, sdif))) {
 			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
 				goto out;
-			if (unlikely(!inet_match(net, sk, acookie,
-						 ports, dif, sdif))) {
+			if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
+				     !inet_match(net, sk, acookie, ports, dif,
+						 sdif))) {
 				sock_gen_put(sk);
 				goto begin;
 			}
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 73e1297681847..6440305615378 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -218,6 +218,8 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
 
 		bh_unlock_sock(child);
 		sock_put(child);
+		reqsk_put(req);
+		return NULL;
 	}
 	__reqsk_free(req);
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 99baf14afdfd8..3583867487d7f 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7777,7 +7777,9 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 		if (!inet_csk_reqsk_queue_add(sk, req, fastopen_sk)) {
 			bh_unlock_sock(fastopen_sk);
 			sock_put(fastopen_sk);
-			goto drop_and_free;
+			/* tcp_disconnect() already dropped one reqsk ref. */
+			reqsk_put(req);
+			goto drop;
 		}
 		READ_ONCE(sk->sk_data_ready)(sk);
 		bh_unlock_sock(fastopen_sk);
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index b111b51d69fc9..aa5fa1dd062f7 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -108,7 +108,9 @@ struct sock *__inet6_lookup_established(const struct net *net,
 		if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
 			goto out;
 
-		if (unlikely(!inet6_match(net, sk, saddr, daddr, ports, dif, sdif))) {
+		if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
+			     !inet6_match(net, sk, saddr, daddr, ports, dif,
+					  sdif))) {
 			sock_gen_put(sk);
 			goto begin;
 		}
-- 
2.43.0

