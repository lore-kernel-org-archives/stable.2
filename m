Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793310179;
	b=HT6kI8op/7fInhRNlmyAUr3hTjSanvbT4XtgbvJcgblucpMnU5QT5SNxv/VRixXJt/m8
	 vDitoJ22WrHj471eCXNT8Ddj08RWHUjbIYRTWefg6htB3JE8e0hhb0Fv+AM6wlJ2yanTA
	 3if8OM5NIdgxQ6aDY8IuVAYnYuzJ1z3CVYen1EFGYvfhh4fNkqOdU1FsnQd+XxTBImq6M
	 Fs1UHE8rQfHvUuARHwu100iVDJzH1J78k5UQY+nQ/+NIG8Miah1HsZUbX2jdW2J50tNc0
	 il/QEis8jdupuLfIfMAPVcLaCsVPHEEMyg30WiPfwhFemDIcjqEMfDvBBjxT4IFBs+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793310179;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=E6EtwfrF7WPf7c2zBhkwy9HXJAUGpyAEaJ4Q/kLCoRg=;
	b=Sw0jAYE5Q+zpE/ep02ksRQrVFUqkdaMDjto+P8w8VyfaO2m+NoG5PZ3rgkM3kUIEXxI3
	 BN2GBuyezRtAk7TtUuaTprMfQQOkz9Ubz6Fyhvr1zSqp01E9bN4k7nII9auM33NavH3L2
	 iYqZIzzRsnokZE5Ke40e/2sVVy5Wrc9Bn5TvxReyhWkaboW3qT/k6qglgTwIx5U+xDlFv
	 r/nQuF4e6gcpQTUEZCwbUiPOpEkuRC/uj7N06h2NR5FYBgJk+4DdZdzvaZFfGTkk28W+c
	 utdSJ114mwOt4KrNfJdM8xezqt+jGKjLZRBXlRqjr8uQfuXT6uuhILcsqbT9eagDWvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oxbCHa8t;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01796606A31C
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 21:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01796606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oxbCHa8t
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3adc4590de4so40443a91.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793310178; x=1793914978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E6EtwfrF7WPf7c2zBhkwy9HXJAUGpyAEaJ4Q/kLCoRg=;
        b=oxbCHa8tm2WpZ3cj3oUo3qMc094q8NzJ2+EYNIppKXLJ8AJiOb6sNGH3vTgIyewLVF
         3T2IHbPGKxMM5NB9jyiIIwS1k7VebgqbZ4TsAIURS/CUCZtzH6wIjRiqoBLqQvp+vEZc
         CklUCY6xafR3kAmrPsOKelKCNCfuh058D0fScon4ewmIgO1LnH+NriFEf7oqbpNWPC9Q
         Lr3uampz68Lw6N8CNjut9suYV6WpVVY/uKJcwvwIDZ/l0mK0ECSasyGpb0vzKpdxLdE6
         5CkaqMwBmdgcy09fKiUvb71e9yfILWSUSoHp6tTjijOCsw1rY36042M4G9gm2fs//tt4
         pGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793310178; x=1793914978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E6EtwfrF7WPf7c2zBhkwy9HXJAUGpyAEaJ4Q/kLCoRg=;
        b=QJF/jqEmHjzbik6LRSCdDYCsdxYj1ShKpp6iVDD3UVKNEGN9byDbf/JPmsvJyhLZYN
         qYeFPhQOma3DcxQZ3nfjg+9GNFGEEx3+ryN6W3fc3aRSc9ouLIAquhJN6e3Es54UFZWH
         6QFJO6qTv3WEHBgxcP3stbEYD+h7VIf7LMpCuF85Hep0OcRblzEsCuQSuQIq91Oxp7C5
         cDsFYHWxJ4/lEQJMomq5QcJV5Ar4O2ov5rq1udrf0WZvxjUFFT6o7GYPR41CzJK+xHf1
         T8nL9lwYZ3xjh1QI0EkZ8VUry9hUL+PTjE5yDqTRZ88Tpc3RxBY9Pcf1A4YhYTxbRIEq
         DbMQ==
X-Forwarded-Encrypted: i=1; AKwUvByEerKJ8AgOJgIfz35DWZBCso/gntGU6mXw1uEztmlk0ebkq8Av0m+NhY8K3iTYxBN9P3DDnBw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJh+fmwRH9+XfJrfkJ1qzkEWQSt26bANdX2p/ZBoRwrWBDNC8lQ
	D6p8hZNcFzyuhf2TtoxgNjuO2sG7UU6ikLE1IvAN/s/JAmfgQaM6D738
X-Gm-Gg: AYBFou1/jhT/MOg7GN9abSvng5Z27c8aVVcfamHkZ/aP1QXDMs5Pap9rvrkS6iZurdq
	SVjcVnfWyrXjhX7n+GlI/WWZr8+bKsGZf1m0/of1XiwMsq7f9Gbqy5yf+lW2hsLPhe3/fMm9weS
	nLvJ92Z7VUfgC7pQYoAweiqZM1REIfrNf5LV6BuCOdDznH/wIErqMl/ZNr10ccl15kL+D6xTlMr
	0x0O0/LHVc7oVywijaV5V5SdQzSLAfABvmdL9MBDQzSC5hhjqP/0kA3ltZTzqvvBXbB2rbChPPP
	jdDO87UkWJZz8CdVq295ICClYf0BI6DsLE90Jtk7Li7dbzhAPVVd+XfNLEP9R+P9coS5EJ49ZUa
	DKhcz9FQJ4He5f6XEjfXEhnSwNVWo/KwYzQ9Y4d/JrBIWSK6i2Bt5OTqLLI/p7SC00lH8kwjnFn
	4ixUskq9Jut+mGe2t7VyWXap+pVeEY9LMT85RG3qiwCd573YkqgaOxF/yfcHPBTvuO4Y46yIThb
	Xqx4AmnycoMV2vG3g6ACE3DTiRZcdJlypyq5hye8Fx0gUv2HYh+xd8sPIxv7yjq0xWfrJSSNT/g
	Bxl04vwsbyNskmuYD/8+BRWfFQjDa+fg6L1/fXB8LWfCPFKu9Xzmc1aRzzXr7bYqTKhucK2v
X-Received: by 2002:a17:90b:570c:b0:3ac:8897:7ba9 with SMTP id 98e67ed59e1d1-3ae8985d52dmr201068a91.56.1793310178224;
        Thu, 29 Oct 2026 14:42:58 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845ecaf5sm1122486a91.16.2026.10.29.14.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:42:56 -0700 (PDT)
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
Subject: [PATCH net v5 2/2] net: restore refcount ordering for lockless socket access
Date: Fri, 30 Oct 2026 06:42:17 +0900
Message-ID: <20261029214219.1035176-3-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029214219.1035176-1-imv4bel@gmail.com>
References: <20261029214219.1035176-1-imv4bel@gmail.com>
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

Before commit fb041bb7c0a9 ("locking/refcount: Consolidate implementations
of refcount_t"), default builds implemented refcount_inc_not_zero() using
atomic_add_unless(), which provided full memory ordering on success. The
commit removed that ordering on weakly ordered architectures, allowing
accesses after a successful reference acquisition to be reordered before
it.

Use refcount_inc_not_zero_acquire() in the IPv4 and IPv6 established
lookups and in inet_twsk_purge(), where the socket is validated again
after taking a reference.

bpf_sk_assign() can receive a socket pointer obtained through BTF
without a reference. Use acquire ordering when it takes its own reference
for a refcounted socket.

Use refcount_set_release() when setting refcounts in the SYN cookie,
TCP Fast Open, request migration, and TIME_WAIT paths. Keep the existing
TIME_WAIT smp_wmb(), which separately orders the refcount store before
ehash publication.

Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t")
Fixes: 27e5203bd9c5 ("bpf: Change bpf_sk_assign to accept ARG_PTR_TO_BTF_ID_SOCK_COMMON")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/core/filter.c               | 2 +-
 net/ipv4/inet_connection_sock.c | 6 +++---
 net/ipv4/inet_hashtables.c      | 2 +-
 net/ipv4/inet_timewait_sock.c   | 4 ++--
 net/ipv4/syncookies.c           | 2 +-
 net/ipv4/tcp_fastopen.c         | 2 +-
 net/ipv6/inet6_hashtables.c     | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 70dc621672f2e..6d87194c377df 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7989,7 +7989,7 @@ BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64, flags)
 	if (sk_unhashed(sk))
 		return -EOPNOTSUPP;
 	if (sk_is_refcounted(sk) &&
-	    unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
+	    unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
 		return -ENOENT;
 
 	skb_orphan(skb);
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index bd0bad96c93c3..837cb91e5b173 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1056,8 +1056,8 @@ static void reqsk_timer_handler(struct timer_list *t)
 		 * hold another count to prevent use-after-free and
 		 * call reqsk_put() just before return.
 		 */
-		refcount_set(&nreq->rsk_refcnt, 2 + 1);
 		timer_setup(&nreq->rsk_timer, reqsk_timer_handler, TIMER_PINNED);
+		refcount_set_release(&nreq->rsk_refcnt, 2 + 1);
 		reqsk_queue_migrated(&inet_csk(nsk)->icsk_accept_queue, req);
 
 		req = nreq;
@@ -1441,7 +1441,7 @@ struct sock *inet_csk_complete_hashdance(struct sock *sk, struct sock *child,
 				goto child_put;
 			}
 
-			refcount_set(&nreq->rsk_refcnt, 1);
+			refcount_set_release(&nreq->rsk_refcnt, 1);
 			if (inet_csk_reqsk_queue_add(sk, nreq, child)) {
 				__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMIGRATEREQSUCCESS);
 				reqsk_migrate_reset(req);
@@ -1494,7 +1494,7 @@ void inet_csk_listen_stop(struct sock *sk)
 		if (nsk) {
 			nreq = inet_reqsk_clone(req, nsk);
 			if (nreq) {
-				refcount_set(&nreq->rsk_refcnt, 1);
+				refcount_set_release(&nreq->rsk_refcnt, 1);
 
 				rcu_read_lock();
 				if (inet_csk_reqsk_queue_add(nsk, nreq, child)) {
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 58d54965036a2..7ffa9171d6de1 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -550,7 +550,7 @@ struct sock *__inet_lookup_established(const struct net *net,
 		if (sk->sk_hash != hash)
 			continue;
 		if (likely(inet_match(net, sk, acookie, ports, dif, sdif))) {
-			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
+			if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
 				goto out;
 			if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
 				     !inet_match(net, sk, acookie, ports, dif,
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index d4c781a0667fe..74ff40d42e56b 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -141,7 +141,7 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
 	 * Also note that after this point, we lost our implicit reference
 	 * so we are not allowed to use tw anymore.
 	 */
-	refcount_set(&tw->tw_refcnt, 3);
+	refcount_set_release(&tw->tw_refcnt, 3);
 
 	/* Ensure tw_refcnt has been set before tw is published.
 	 * smp_wmb() provides the necessary memory barrier to enforce this
@@ -328,7 +328,7 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo)
 			if (check_net(sock_net(sk)))
 				continue;
 
-			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
+			if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
 				continue;
 
 			if (check_net(sock_net(sk))) {
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 6440305615378..4b2d2713653b7 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -205,7 +205,7 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
 	child = icsk->icsk_af_ops->syn_recv_sock(sk, skb, req, dst,
 						 NULL, &own_req, NULL);
 	if (child) {
-		refcount_set(&req->rsk_refcnt, 1);
+		refcount_set_release(&req->rsk_refcnt, 1);
 		sock_rps_save_rxhash(child, skb);
 
 		if (rsk_drop_req(req)) {
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 471c78be55137..e40477b6b5549 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -364,7 +364,7 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
 	tcp_reset_xmit_timer(child, ICSK_TIME_RETRANS,
 			     req->timeout, false);
 
-	refcount_set(&req->rsk_refcnt, 2);
+	refcount_set_release(&req->rsk_refcnt, 2);
 
 	sk_mark_napi_id_set(child, skb);
 
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index aa5fa1dd062f7..1eea584d80df8 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -105,7 +105,7 @@ struct sock *__inet6_lookup_established(const struct net *net,
 			continue;
 		if (!inet6_match(net, sk, saddr, daddr, ports, dif, sdif))
 			continue;
-		if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
+		if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
 			goto out;
 
 		if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
-- 
2.43.0

