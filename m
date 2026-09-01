Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7187247A88B
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254772; cv=none; b=X0aL5SdW6PTGfa8vQVslhGl3xewjMmDDcdcYBkZrIUeMUgORzKUS7OEPUEEJjy9jlHFBlmVt/tGu/AWr3j9DOqa2ADfr/xWCnSw/9G9aG1BrQ0aJYkD1UnDISqsc8HmdCJrW80+M0Ng38i+lQCyt6AHoOPhveIinxGISdP9EWfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254772; c=relaxed/simple;
	bh=MYpe/Z1p0ZiJD8P4f3o11AFUnEQqyk4kJPvQKGzIS1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RkOHBWaOveJBmBL3iUY1xPkK3QYkT2m5Ju0M1mP7PxxsZjOrcsFBag3OD3LnO+bowemyDLdysjup9yIjcqFp70ZBjH0kEf7w+BiUFYTPdRaHShaSXPwL3tHBV0DcpOYrPVTSvvu9+B/eNGB7hAuWEqHB3JBaK2bXd5a6tvABdmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=h6e4nZ+X; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="h6e4nZ+X"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso3113000a12.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 02:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788254768; x=1788859568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zbp7iZ8vuRr1z3SL6rzE0qfaWAAIyC6FAmZl9lP8kD0=;
        b=h6e4nZ+XBLeDYod0E93P1U3E5NqZbpX/jSflAEWcSIq90h9zgAew4o0+CaaFvJnnjL
         mHjtzGXfmJqG9UJ34w/RaTrIE5ZVDL9aAYGu3JjIf8/u9Ypyk21VpRPcBFArEHp9LdT1
         FNeyzVjq8WTbscGm3x5Zf926Y1vdWdPkvlwpaAtJqCTZ54ULQ/RN8ZbsP/Ye3/Mv3dzo
         KpGydeMbGcb3uY8Q0N9KUZ69kQ/m1dIsOe2C/CecYhyyvp6YPhAPxFvyHRf+1Z2y/gUV
         /mmC2GdFlAIxppYBZKnesxB7S6oVWIamZ2KyXxlCRUEiDuRXpwnMkffs99RnAfpTM88X
         lKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788254768; x=1788859568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zbp7iZ8vuRr1z3SL6rzE0qfaWAAIyC6FAmZl9lP8kD0=;
        b=mo0qxsRk/HXElzLlUhjD0fmxk9gGF9z/6Y7XkeRItyHCwxxJH6qyHwWkvqQSfIpawu
         kyJncKIwffxUhMjKjPiMRuAtYZpHPqXC9edynd7J0/d3pM0MhWeNE8dtSeIVOqUPYx0N
         f3UJpSlJEAdpwW4S6aM7bUkXp8lR7Rm5pqL+cVd2a5x9hhriZ8zwR+tXTm7HTTaQt7Ya
         rJ6j3c+blslVjXy+lRJUPA33aHtslorn08CtaG0sGeraqB+rCldvz2B8Exx7ugQEgIi7
         sskrKG6JPH2tlWE2NEyg0EYsdB4CL8PkMZ+I6w7n0f5XXy4oStLWwKEQOZbZL55nxubW
         yEuA==
X-Forwarded-Encrypted: i=1; AHgh+Roj22LzXWIWg4ggi+fDs0C3S5tH356yKpGBmIBM+lBUk0z/0HtTei5TaPpXrD4Z5eadsZfNId8=@vger.kernel.org
X-Gm-Message-State: AFuF++m1aMbwcfZ5/vPyR3flw6VqTZ+2iyqpyfnT/yxqgTQ/sXjMYeF4
	4nNckxKwm8CZVJf2YfISIgSS6WfZV/BBgJiReGrZGtpHRFAjehQKZBmItzeyXM/+x/n9
X-Gm-Gg: AR+sD11CmCocjRqWhxeejXSm15jqdYPQ7CfNL+77pLHYDqkpGNc+H+lQKdbUDaC0g0f
	cHAR1B6sQh0YeMDsfXscUUCOF0kcwBGN1A3Av7RkUmSAsw9TuHvvcU7oKUf4/+6LCKmtjjg1XBH
	+KlpFRHYeLx5PMB+LxN9dbsFq895YgdX2atVceQOi3uKt1cNpPFKhc3c7QtpIAv4ovETZXRAn30
	qy1Mm0NnC6QwjDkHzYbUUvWRvcpWK39yHqK71D8WvZaSpFxI8oA21AbAe5kNOHMBVPNSHJ4zQfP
	HlG4Fuz/kbQPMpM8Jo2fYXUO24uNvBp8DUoXOSfZZ1BmVnjaurO/ACuWmSKb9xno7P6siW738MX
	MElUG+iX1LTJKWx6cZvuTFl3nTXTO6IDO6ofwt27LgN+1BZB19vRUhXFunyJUEXkEUMk87gPA4g
	+K3ABXr6i2h43tFkxu1vahKOCI0UtWaYd8niEIhfUZXVrK0x20JHXox8CG7d0Z8oGo3tFs2bjth
	5fRrG09mVV63muPVZDj
X-Received: by 2002:a05:6a21:38e:b0:3cc:917f:f302 with SMTP id adf61e73a8af0-3d26784f3b5mr52978464637.9.1788254768499;
        Tue, 01 Sep 2026 02:26:08 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f32f660fsm5612135a12.2.2026.09.01.02.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 02:26:08 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pavel Emelyanov <xemul@parallels.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>
Subject: [PATCH net 1/1] udp: diag: bound bucket lock hold time
Date: Tue,  1 Sep 2026 09:25:59 +0000
Message-ID: <133b6aee9e2c908c9da37d5585b3d2cd016906cd.1788187473.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1788187473.git.zihanx@nebusec.ai>
References: <cover.1788187473.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

udp_diag_dump() currently keeps the UDP hash bucket spinlock held while
running the request's bytecode filter and filling a netlink response for
every socket in the bucket.  A large filter and a heavily populated bucket
can therefore keep bottom halves disabled for an attacker-scaled amount of
time.

Collect a bounded batch of matching sockets under the bucket lock, taking a
reference for each socket, then run the filter and fill the response after
releasing the lock.  Keep a referenced hash-list cursor for the next
unprocessed entry so each locked walk stays within the batch size.  This
remains bounded when filtered entries are skipped.  Consume the previous
resume reference after the next batch is collected so an -EMSGSIZE retry
cannot put a socket twice.  Preserve the cursor across -EMSGSIZE retries
and release it when the dump is finished.  Count every hash entry,
including foreign-network sockets in a shared table, against the walk
bound.  Take an extra module reference while a dump is active so
dump_done() can still put the cursor after inet_diag unlocks the handler.

Fixes: b6d640c2286d ("udp_diag: Implement the dump-all functionality")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 include/linux/inet_diag.h |   1 +
 net/ipv4/inet_diag.c      |   2 +
 net/ipv4/udp_diag.c       | 154 ++++++++++++++++++++++++++++----------
 3 files changed, 119 insertions(+), 38 deletions(-)

diff --git a/include/linux/inet_diag.h b/include/linux/inet_diag.h
index 704fd415c2b4..8dfcc37cc29d 100644
--- a/include/linux/inet_diag.h
+++ b/include/linux/inet_diag.h
@@ -38,6 +38,7 @@ struct inet_diag_dump_data {
 #define inet_diag_nla_bpf_stgs req_nlas[INET_DIAG_REQ_SK_BPF_STORAGES]
 
 	struct bpf_sk_storage_diag *bpf_stg_diag;
+	void (*dump_done)(struct netlink_callback *cb);
 	bool mark_needed;	/* INET_DIAG_BC_MARK_COND present. */
 #ifdef CONFIG_SOCK_CGROUP_DATA
 	bool cgroup_needed;	/* INET_DIAG_BC_CGROUP_COND present. */
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 34b77aa87d0a..1a5ea36348e7 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -895,6 +895,8 @@ static int inet_diag_dump_done(struct netlink_callback *cb)
 {
 	struct inet_diag_dump_data *cb_data = cb->data;
 
+	if (cb_data->dump_done)
+		cb_data->dump_done(cb);
 	bpf_sk_storage_diag_free(cb_data->bpf_stg_diag);
 	kfree(cb->data);
 
diff --git a/net/ipv4/udp_diag.c b/net/ipv4/udp_diag.c
index f4b24e628cf8..18cfe0df654d 100644
--- a/net/ipv4/udp_diag.c
+++ b/net/ipv4/udp_diag.c
@@ -24,6 +24,36 @@ static int sk_diag_dump(struct sock *sk, struct sk_buff *skb,
 				 net_admin);
 }
 
+/* Process a maximum of SKARR_SZ hash entries at a time when walking hash
+ * buckets with bh disabled.
+ */
+#define SKARR_SZ 16
+
+static bool udp_diag_cursor_valid(struct udp_table *table,
+				  struct udp_hslot *hslot,
+				  struct sock *sk)
+{
+	if (!sk || hlist_unhashed_lockless(&sk->sk_node))
+		return false;
+
+	return sock_net(sk)->ipv4.udp_table == table &&
+	       udp_hashslot(table, sock_net(sk),
+			    udp_sk(sk)->udp_port_hash) == hslot;
+}
+
+static void udp_diag_dump_done(struct netlink_callback *cb)
+{
+	struct inet_diag_dump_data *cb_data = cb->data;
+	struct sock *sk = (struct sock *)cb->args[2];
+
+	if (sk) {
+		cb->args[2] = 0;
+		sock_put(sk);
+	}
+	cb_data->dump_done = NULL;
+	module_put(THIS_MODULE);
+}
+
 static int udp_diag_dump_one(struct netlink_callback *cb,
 			     const struct inet_diag_req_v2 *req)
 {
@@ -90,55 +120,103 @@ static void udp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 			  const struct inet_diag_req_v2 *r)
 {
 	bool net_admin = netlink_net_capable(cb->skb, CAP_NET_ADMIN);
+	struct sock *cursor = (struct sock *)cb->args[2];
+	struct inet_diag_dump_data *cb_data = cb->data;
 	struct net *net = sock_net(skb->sk);
-	int num, s_num, slot, s_slot;
+	unsigned int slot = cb->args[0];
 	struct udp_table *table;
 
 	table = net->ipv4.udp_table;
-	s_slot = cb->args[0];
-	num = s_num = cb->args[1];
+	/* Keep this module loaded until dump_done() drops the cursor. */
+	if (!cb_data->dump_done) {
+		__module_get(THIS_MODULE);
+		cb_data->dump_done = udp_diag_dump_done;
+	}
 
-	for (slot = s_slot; slot <= table->mask; s_num = 0, slot++) {
+	for (; slot <= table->mask; slot++) {
 		struct udp_hslot *hslot = &table->hash[slot];
-		struct sock *sk;
-
-		num = 0;
-
-		if (hlist_empty(&hslot->head))
-			continue;
-
-		spin_lock_bh(&hslot->lock);
-		sk_for_each(sk, &hslot->head) {
-			struct inet_sock *inet = inet_sk(sk);
-
-			if (!net_eq(sock_net(sk), net))
-				continue;
-			if (num < s_num)
-				goto next;
-			if (!(r->idiag_states & (1 << sk->sk_state)))
-				goto next;
-			if (r->sdiag_family != AF_UNSPEC &&
-					sk->sk_family != r->sdiag_family)
-				goto next;
-			if (r->id.idiag_sport != inet->inet_sport &&
-			    r->id.idiag_sport)
-				goto next;
-			if (r->id.idiag_dport != inet->inet_dport &&
-			    r->id.idiag_dport)
-				goto next;
-
-			if (sk_diag_dump(sk, skb, cb, r, net_admin) < 0) {
-				spin_unlock_bh(&hslot->lock);
-				goto done;
+
+		for (;;) {
+			struct sock *sk, *next_cursor = NULL;
+			int idx, accum = 0, walked = 0, res;
+			struct sock *old_cursor = NULL;
+			struct sock *sk_arr[SKARR_SZ];
+
+			spin_lock_bh(&hslot->lock);
+			sk = cursor;
+			if (sk && !udp_diag_cursor_valid(table, hslot, sk)) {
+				old_cursor = sk;
+				cursor = NULL;
+				sk = NULL;
+			}
+			if (!sk)
+				sk = hlist_entry_safe(hslot->head.first,
+						      struct sock, sk_node);
+
+			while (sk && walked < SKARR_SZ) {
+				struct inet_sock *inet = inet_sk(sk);
+				struct sock *next;
+
+				next = hlist_entry_safe(sk->sk_node.next,
+							struct sock, sk_node);
+				if (net_eq(sock_net(sk), net) &&
+				    (r->idiag_states & (1 << sk->sk_state)) &&
+				    (r->sdiag_family == AF_UNSPEC ||
+				     sk->sk_family == r->sdiag_family) &&
+				    (r->id.idiag_sport == inet->inet_sport ||
+				     !r->id.idiag_sport) &&
+				    (r->id.idiag_dport == inet->inet_dport ||
+				     !r->id.idiag_dport)) {
+					sock_hold(sk);
+					sk_arr[accum++] = sk;
+				}
+
+				walked++;
+				if (walked == SKARR_SZ) {
+					if (next) {
+						sock_hold(next);
+						next_cursor = next;
+					}
+					break;
+				}
+				sk = next;
 			}
-next:
-			num++;
+			spin_unlock_bh(&hslot->lock);
+			/* Consume the resume ref; remaining refs are in
+			 * sk_arr / next_cursor.
+			 */
+			if (old_cursor)
+				sock_put(old_cursor);
+			else if (cursor)
+				sock_put(cursor);
+			cursor = NULL;
+
+			for (idx = 0; idx < accum; idx++) {
+				res = sk_diag_dump(sk_arr[idx], skb, cb, r,
+						   net_admin);
+				if (res < 0) {
+					cursor = sk_arr[idx];
+					while (++idx < accum)
+						sock_put(sk_arr[idx]);
+					if (next_cursor)
+						sock_put(next_cursor);
+					goto done;
+				}
+				sock_put(sk_arr[idx]);
+			}
+
+			cursor = next_cursor;
+			if (!cursor)
+				break;
+
+			cond_resched();
 		}
-		spin_unlock_bh(&hslot->lock);
 	}
+
 done:
 	cb->args[0] = slot;
-	cb->args[1] = num;
+	cb->args[1] = 0;
+	cb->args[2] = (unsigned long)cursor;
 }
 
 static void udp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
-- 
2.43.0

