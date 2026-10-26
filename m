Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792975126;
	b=hAEUtzKKSGkZx69Or8AOANJPaODCD32fv7PE4GAWELz4lxHlbKIZKJQeqVNUXwdQVD1d
	 P+Mo31s6fHAB6wWwnGuy6ax/S3lzDVkfHDVh3+InhDjcbQj3tNo/eREUV9E4UiRN4WhGu
	 FpJlmcWZ5H1wRFnTSDY/owPoapqwSIap1yeRQY5ivOxjhXHPLKEwDcT6paXtH7/EgfNtG
	 cijwsawyBf7fktvMTtWSepY7scGkZO2WRYBUxmMAiC10EDQ9+Dv+/ujcloaFPeUvVVP3z
	 mgo9P/ASjlpxNqcKAzq10et97SVG5/lCBJdAfbvlvCHejmoLlcu0X4H6e5kFei0L8iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792975126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IVUYgHeIBWVpXUeqXYcWVjDk2UZb78txWIi5FVEjbpo=;
	b=VfVZZrLofavHhSutEAgCy4GujWKMrjX20tUjUia/nDsC1KoL7p3Id5yWadT7P0Y2sN0j
	 caau21/jUz9U2c1CGQOs7xWRcfep+0Wdy1QCNkBv9z/nix/PS2kNlRkcasVz+/LuSAf8F
	 tfnsndEF5vYLvdOEwzR63GPFhA6GNEGjfNLoBt7fbfqefvhxKt4pPgLaLXabN+2fWK+dp
	 U9RnK/zwpT86jbX2o0LT50wPpVOyFrssZFK/nnXmI3B3cNYe0bpHTwoGX/5bDsrlVRVHM
	 h69MZe4qE6nrfpOEmNLQtmxd/PJA/gGqwRIQy2CkT8QWngnkqbIcJhJrqGvqRjJvOhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mBJzcGIq;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708A8606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 00:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 708A8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mBJzcGIq
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso4778072eec.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 17:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792975124; x=1793579924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IVUYgHeIBWVpXUeqXYcWVjDk2UZb78txWIi5FVEjbpo=;
        b=mBJzcGIqxIYH7QzlQLHBPKrjskMhg+OhTFX9zvLAM3kBiXLSDw/27dgrphc/drt8au
         cVM4oyjapVYUYaDxvTZ86RB+UsuLKK+u8IOdBXf/5PSC30o500nC1BMGUcH2W406uson
         fNqpu+yQroZejB1JBvd72DyGoVgZmFL6bjwM271RWZfylEC3bcl4OJuyg3KEYh8Hv4dd
         fEnKodbqiaIsHzKtaMHxk+a/44/0mmV5GstfVdaE1dcacIED6eyW4pfM48ryOC1Gobae
         enMW1VwOZceqI4WLpH7jOJRAmN/GecI05/eApep8joQlH3RwpfwhhOTwfS8a9QMr47xt
         TYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792975124; x=1793579924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IVUYgHeIBWVpXUeqXYcWVjDk2UZb78txWIi5FVEjbpo=;
        b=d2+edA8hvwlYBYO189xtfXOMA77QAOs845BbZCx/3q12JCCutgC2QOx0O8lMHX97UE
         33CjqMLEN732MM6FBqCQfg4354WyWoCAbKisknatTgS27HbWoXVzkiiMlI2tnX5V4IEJ
         lV2gi6xTREhHVeJh0ioGKGyxRHp8dNu7ckJeyG2P8dezyqM/fBcBcGaDjNcNpvLFwa0Y
         K5gRkOWyLPUaXMJ5HqadZLbXxSfzglRlN54b2LZPMxdXF34vSXBGdhxO8v5IcQ5QyrE1
         +lhkrhunr/gu48BRlsQ7/6O3y4yHExdZyCIdFWvK2bgczeaQnHbm6sJnPsElexxw2mx9
         F/8g==
X-Forwarded-Encrypted: i=1; AKwUvBxC6bFuGzqblBYoBFPHgIU0aW4pVddy98HLKZA3Jr3J8kekn/kEFqMFDCpGIgl7y3rAIgcyU84=@vger.kernel.org
X-Gm-Message-State: AFq9FYIY3MZgohDaCaU/G1oc/vBEUXXImDAYf/TGwxO3f3CJf77Cso0o
	G6ESvy2kt+DSNah+IWPjuuSis/VbKMrsWUUTAuhOOhC3Rqxp6Qh4dpdM
X-Gm-Gg: AYBFou1aL+aBkaAJV1CO4RuDNFbwLJwhSnKaoDRsnjmp4vFjNU8rNoqGB/Y8siTvKEU
	SmqrqIAnip54jWkepGKNABChAM3s7mKIzahtnZPca33iUY+BuxjYyVdH66hxr/xoIasrXiCq7CB
	AWGJUUyl9Lt8huCYzfVdBWsPCHEUR6X2baSUo9wGqIjSpSkQiDy8yNytfVQIiVrxxUKQLvafmku
	Zn5/zlvJ1tttQ3z3ZWwQCNUHz4tyxQxpi61G0Vn8CXLbCNpEdEIr8vTK+XxmpKZT+NJThKBPmyR
	SyAV89if+QiJELr9L038F+rVbhjuoTC+AH/ByV6g09zuUMfmh0A3IoSJyLlrDDWiGc9tId2qEoJ
	jty2IIN9XP6hdD2yJ9YJ8UhjwPXtzs099o9YhHg4F+f1nb6q4lJlLfHFNr06QZWrskMN7w56EmI
	lS2dd1ZwwtA070qPnrslU/xjRiaBRMEkS2W0xtmM/Ef8LyUZqP1+gSiUTpRk2oJiUrdyZiCCFfO
	2nidEi+cIvil2C+j8UOytNLKvZcl9f42H1OMQgN0uijkYpJPixyDAOgw8SiLuszJzEwRRRYAQ2q
	3A==
X-Received: by 2002:a05:693c:8099:b0:360:ca2f:ce6f with SMTP id 5a478bee46e88-369ffdddf39mr2418635eec.1.1792975124383;
        Sun, 25 Oct 2026 17:38:44 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec50bcsm37925013eec.23.2026.10.25.17.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 17:38:43 -0700 (PDT)
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
Subject: [PATCH net v4 2/2] inet: restore refcount ordering for lockless ehash walks
Date: Mon, 26 Oct 2026 09:37:45 +0900
Message-ID: <20261026003804.61923-3-imv4bel@gmail.com>
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

Before commit fb041bb7c0a9 ("locking/refcount: Consolidate implementations
of refcount_t"), default builds implemented refcount_inc_not_zero() using
atomic_add_unless(), which provided full memory ordering on success. The
commit removed that ordering on weakly ordered architectures, allowing
validation after a successful reference acquisition in lockless ehash
walks to be reordered before it.

Use refcount_inc_not_zero_acquire() in the IPv4 and IPv6 established
lookups and in inet_twsk_purge(), where the network namespace is validated
again after taking a reference. Use refcount_set_release() when setting
refcounts in the SYN cookie, TCP Fast Open, request migration, and
TIME_WAIT paths. Keep the existing TIME_WAIT smp_wmb(), which separately
orders the refcount store before ehash publication.

Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/ipv4/inet_connection_sock.c | 6 +++---
 net/ipv4/inet_hashtables.c      | 2 +-
 net/ipv4/inet_timewait_sock.c   | 4 ++--
 net/ipv4/syncookies.c           | 2 +-
 net/ipv4/tcp_fastopen.c         | 2 +-
 net/ipv6/inet6_hashtables.c     | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

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

