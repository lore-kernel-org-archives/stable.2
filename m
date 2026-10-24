Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792820275;
	b=aVH9WzXpS92TAT/DFh4zrQ4/iZIALPwi34WQHHuWOvMcfYxIWr8NgpApcJFk7LDOAytU
	 jAQU6HvsCrIkEBq9PP7CUdlaOhDYSxUFS4q8Ws5a9yd6pTAOuvc69zhrNkAT5ncN1BTxM
	 L1gO/1CYJiE9NypdcS+iMQ7g/t8+aKUiGG1dzrYs2QBxagK7198DameCJ+c07WoSmHP4D
	 /wMYlFRcQ7Bb4hnzrBjKzuGS8xtNDuA25HHJw2EU2JP8scNPRCx4IdXjo4iboOt9xufGN
	 siaIUo3oAYWcpZgSYqwq1LdAlWEo7IDAx4qpMcj8i9HSmt2ODCcFO+CY+6pw+UD+55Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792820275;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=u1kTAV7kZo1f8uJ6uI/HfVvkXNhvmCW79ofPzPlPbAo=;
	b=FLbRjrfzzNCG0BAXIXDUyGnrIxCZLk49f2HGaj36TV/HiwhTuX0VyI6ChmkRxmkvNfFB
	 Oo5IM3gQheAwXEL0ZuViT6Ro9pzNicWeuxxiJPzXV3ojAzFO19pxcTXnIEo+Nk0imncvZ
	 SKMbl0fdDCI9oSc6KhXF+rM6oDEfHYMW/zlwvA3I8IaRzHK9e7SBpjAe/QLn/bDBxDun+
	 BBXQbcq0+cet7MygURj365XaFU7s56bDw5rp9gltdBfVoVQxWVdbT9Ql0dAYWoT9S4MNp
	 +ntZZ9kW9jTt9YLlNm+V2RIoUiLcoC5oUZrWQiz35+gxVOsKsNjxe1iOhfuOqH8BgTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h1a+XbhN;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AB4606A322
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 05:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70AB4606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h1a+XbhN
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e9e53d011eso11088075ad.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 22:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792820275; x=1793425075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u1kTAV7kZo1f8uJ6uI/HfVvkXNhvmCW79ofPzPlPbAo=;
        b=h1a+XbhNiXuyFkU+0t2jFqYMiNtEXXQFk5rvbir0hcCw8wNQwmpDF2fagg8+MO2Ks7
         coevx42zyrC6qgu3d0gUcyhBvhLOCrfk7Uw2gTjcxTDRORo0QTnkggrw9N2ov70fCead
         PUNjDRCC+v0Ehdd3P6adiFOrhqpvWayQWbBhA9phXu/FJCUEfm87bIdFrO4PWFjU9zVS
         2GVF8DKavMhy+/zr+W1V8lk+1vCt21osfUUTmWLAoNG6QcqRDTaVqRjupurhuTt7nrMb
         VQRvFkdxpB8GppY8BO2IQ7VGFKvCrjpimzKGisBKSZt0/kPHAcp8enhgowlo4V+2bs+q
         GM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792820275; x=1793425075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u1kTAV7kZo1f8uJ6uI/HfVvkXNhvmCW79ofPzPlPbAo=;
        b=uYw8djXNUKPulXdp+2xgyzwQ3mRuMlRwbu9uev+PvnsWRex7KhUyt4w4caRnElNKl3
         d/ucxM2TZ0kyE8L8B1Psk2Rs88M3e/v3T/vx/2B9+t/okYOiUXePErMxFmH3T2VPzOc7
         VUZDf3kboXGwUejBztIN+QQBU5hre3JE3pCLAOp+BeNs7pgVKS9k+KGVN8HQgfazkGH1
         e8/KYCi6PnNLIqAdRm3VbDIXy55XetdrZR8EEEk631Od7kmfBZm/DiWoE6xjOVTTxzSA
         Rb0HgNxoYxQP6dpqOj3LIOkBUyfZqfTFIbIWeRsOfFkpA/xZ8cuP23RvP8c2XQrOgeLa
         K1xg==
X-Forwarded-Encrypted: i=1; AKwUvBx2v3/jQ7aPn17uQTtNpBcE1oqnC0hpcGFO41sr0YBoMh5CYLvoZneNYWTjlT5edP8FGZqeC+M=@vger.kernel.org
X-Gm-Message-State: AFq9FYKOOSJ6Dbf+lKo/MwKLn4720pgoMOf2QW98pMdw5P0GVCFMHMoV
	sor4edS3quyFdvGoH4pXEfg00PArxAxhlhJtyJ1laxSjT8QaRl9wZv/0
X-Gm-Gg: AYBFou0B9sRYTGVe2FhI6zRKcuZf4bL0PPypG6F0+eCMuOb2lelhVVF+L29lUrP1kit
	3aOCuH+lYxU4RK5SRx8I50/YroFf+1HiA5rmQdWZdFOkwAqJYcvf3U2AEmeXNZSt7WA8NYXeFO+
	s40lr1CGy3R6hZl/qyyinFDKWwYUhmF82A7xWNrKDKtamA1eLTJM1IAkF/0l/JOzVyutUBQZAca
	mU4ndMjgmXdCZv3DJmW6kosocLKYh6xsjs84oCPuKiTQoglO0uVLvXDvS9M6XiBRGkr7JmKSAOJ
	pKzl8AAn9Yl3KP9VR740PyHybZgsUQvU5PbfQybwtmyqKQHpWduvmriQCCaFIxqF8EvGIONQTkK
	HM6XB7010zoZlnEwJissGaLKjaaQ2QJNU07obkh0iDfr+rziAG+i4VbI51b5D3KtlyS5j5ScAYp
	HVAYYMOUfXp5sKY6O2eT5Z1ZZkFEN2MBIAWjPvymbtwMMXjcOqvJD0VbcMsHaJSVpiSIZG1MaV/
	4BDjav/6yNuMuXxGViZruU5YvRSn5tbP7ER3Y/0Rf4LzIyF7NfE0cnbWDA02LnsePVyt+QDCnDE
	XA==
X-Received: by 2002:a17:903:1a0d:b0:2e9:4f73:83d1 with SMTP id d9443c01a7336-2ea9c674e67mr10386525ad.22.1792820274840;
        Fri, 23 Oct 2026 22:37:54 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a2676sm2692485ad.50.2026.10.23.22.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 22:37:53 -0700 (PDT)
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
Subject: [PATCH net v3 2/2] inet: restore refcount ordering for established lookups
Date: Sat, 24 Oct 2026 14:37:13 +0900
Message-ID: <20261024053720.1147022-3-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024053720.1147022-1-imv4bel@gmail.com>
References: <20261024053720.1147022-1-imv4bel@gmail.com>
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
validation in established lookups to be reordered before a successful
reference acquisition.

Use refcount_inc_not_zero_acquire() in the IPv4 and IPv6 established
lookups. Use refcount_set_release() when setting refcounts in the SYN
cookie, TCP Fast Open, request migration, and TIME_WAIT paths. Keep the
existing TIME_WAIT smp_wmb(), which separately orders the refcount store
before ehash publication.

Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/ipv4/inet_connection_sock.c | 6 +++---
 net/ipv4/inet_hashtables.c      | 2 +-
 net/ipv4/inet_timewait_sock.c   | 2 +-
 net/ipv4/syncookies.c           | 2 +-
 net/ipv4/tcp_fastopen.c         | 2 +-
 net/ipv6/inet6_hashtables.c     | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

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
index d4c781a0667fe..88ea3a101849a 100644
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

