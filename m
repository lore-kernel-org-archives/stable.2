Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182A33CBE7A
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 12:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788267254; cv=none; b=TPC26JACZ802Zz0qZd1XXTbFVxu6F+FRQMjj7fen1hgsTHw+VlU19I0uD9EIUAzI/63e86EYn88j+c8kZ8Ho8sdSF+TAKNeaSo6nFlSg+mGN+NjHlj0nBLzMqZEVuNe4dnGeLsyB/vGE8HSQ4qhD5J7OCKF2IkVH0OjDIjtE9Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788267254; c=relaxed/simple;
	bh=uxW5j4A6X52FZbh8lJl8gie5IiK5qhRUh36oA7KEFoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0CHNW6pvmOc5gqEgopBN8In55+Tc0AG36ytkIGap4Ed2XxH9dR728yXmS70O82mpgd5WkVbVYtDla17rt5JWTOUDUEM/DTsIp2Ie532YHcTk1Q9C9hvz0tiQ8POkUTC1Y42WhymDLTZlMygYHgW4s3r7+DwD1tiHFnzgWAW6/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=nm8Ts0le; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="nm8Ts0le"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d72ae08fa1so39733665ad.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 05:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788267250; x=1788872050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7mMZ1zbpoXdqJJAf+iyw7TfdMbYoOVSHzzCFK3nTdQs=;
        b=nm8Ts0lefFlv+99h2jheV7ZjB2ZtHg3LM0w1R+sY8tPB/cQiFMK1imLo+REbt//h80
         0aleCpfCRZMmhx9JuPZyeRhHBFvLTrK8QcguBSgW1ZuLPEwXT9J1CIzyYocZXVv8DTo6
         NR60Lru0tRQKb7fvMJibw2FzFn6EwveF4pXp1Wfip4huPxLN1+1bDg9RxbghreOPRqh9
         BcfCZ02BUhu/gW7vfD1yscyuq8GSIcy8lG0BsE8pfeLn6nobW77bScwf2CUjeV0wmVi8
         2+spNnDyjbSGl4ptZneRL62BwrfhktRHZaiUFh6d5fQW1+0M75jUeFsa9lXmgo+1nwii
         srZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788267250; x=1788872050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7mMZ1zbpoXdqJJAf+iyw7TfdMbYoOVSHzzCFK3nTdQs=;
        b=kluyRgjZb97It5cpAdMLbw/jzM66IZ9tuuA76FCUe5gxrzVFvL29fj0lubfY+aRBME
         mA4liMiWzreof6/wNIlExWMFoZVyYRL1qI7pbR7zWiG5DB6N97WJwdGlLdRlC1fQGoAs
         W9hfowMMwzu8lLTbj56LcS7R/mYC4ChXMNyZMSzrukNewyZmwagBVWMe99KOc/9FRBIs
         Mjj+1I3n8XHso6E9nFyzFM1cXx6flrfIrcnz4+dOig+uLKczG8BygEwADGttINtLK/UH
         OxycIyNYWWzBQBgECilqspzOfSNJUtW4F7cdMAf0cGeM0qZ3ZosF6+guVGpd9q1bzKA1
         DatA==
X-Forwarded-Encrypted: i=1; AKwUvBzWIVF3/58RBbTbYFNMsjGm2DJQ0LfVF0A+WHD+tfPDkcq4dNfZ+4xeZ6N7IJWU5FaToddmbds=@vger.kernel.org
X-Gm-Message-State: AFuF++nOALHY9oC+H7PU8gA89IqYej8jBtn7y3VFuJrfdTnrz+KXh6jS
	t1Q/31gZXdBV1cnnRhned2Vl9PYGnLMx/pWiJG45f+48Ctt0r/u4SK8uSfRkM017KhUB
X-Gm-Gg: AYBFou3a65Ygf/ssY5pUMZ399J8l3JaYbkughC2sXBjvQy0AgSb9hHpkq2W7aeI+DxW
	cxEVhTz8vYVteeZnHMtTVLe+AuaqaiBBV0FILa0Dph3FfdjXFTTjyL+QFjjTMWvN/SXN0CQleeo
	eNVdqIKf3+EJq+Vkx7/nbwAk968LhUSCIqdM/a7G8SP6gXrApNu1phYBoWaNe62a9MRFVWH46eo
	Y4RcZbvt28wyKlpxGVAukguwoabbnLcTTQLfK/hzhLK3WZNJkJVeioZYEKWz4M748h82XyCnZDW
	3xDQz3piMa/2chAV2TLcariMfFvq+eZyEf6lqleSMPiNRR1oi3lLfRVgBdtYDtcpLodzAQ6K+qt
	fUYFudkyOKsam5cNw1nV8EgkfGCoG8W+Qj5ywZuldGrANzDtswlQ0YCVX+CklSW7GtHIT7cz890
	YRfDDX3GfsJ92IBx6UnH48FFALnLtHCRx8pB3t37as5e7YA+sDy2MDIhvNLd4yFchoovEazXaLY
	28P3G8LPzRS9Xrq5JE=
X-Received: by 2002:a17:902:d98c:b0:2d9:3083:a3ac with SMTP id d9443c01a7336-2d94a8fb674mr113217995ad.15.1788267250206;
        Tue, 01 Sep 2026 05:54:10 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d759869c96sm51184175ad.40.2026.09.01.05.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 05:54:09 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	linux-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>
Subject: [PATCH net v2 1/2] tcp: diag: bound bucket lock hold in tcp_diag_dump()
Date: Tue,  1 Sep 2026 12:53:46 +0000
Message-ID: <cdc628415cf10721480a51ce14837f846ec778c2.1788248601.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1788248601.git.zihanx@nebusec.ai>
References: <cover.1788248601.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

inet_diag dumps run request-supplied bytecode through inet_diag_bc_sk().
tcp_diag_dump() currently evaluates socket filters and fills replies while
holding the listener, bind, and ehash bucket locks.

The time spent under a bucket lock can therefore grow with the number of
sockets visited and with per-socket dump work. This defeats the intended
bounded nature of the bucket walk and can cause excessive lock hold times.

Fix this by collecting only referenced sockets while holding each bucket
lock. Move the filtering, bytecode evaluation, and fill work out of the
critical section, and keep a referenced dump cursor so each subsequent
batch resumes after the previous socket instead of rescanning the bucket
head. Validate a cursor against the current listener, bind, or ehash
bucket, and against the table implied by sk_state, before resuming from
it. Bind collection counts TIME_WAIT nodes toward the batch limit and
resumes them via tw_tb2.

Fixes: 5caea4ea7088 ("net: listening_hash get a spinlock per bucket")
Fixes: 91051f003948 ("tcp: Dump bound-only sockets in inet_diag.")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v2:
  - Rebased onto net commit e2a6641e3bfd (2026-08-27).
  - Added current-bucket cursor validation for listener, bind, and ehash
    paths, with safe restart on mismatch.
  - Reject listen/ehash cursors unless sk_state still matches the table
    being walked, so a reused sk_nulls_node cannot continue under the
    wrong bucket lock.
  - Count TIME_WAIT bind nodes toward SKARR_SZ and resume them via tw_tb2
    instead of skipping them under the bind lock.
  - Kept listener and bound-only Fixes tags; dropped 7e3aab4a9cd7 because
    that commit only converted the existing ehash dump lock type.
  - Sorted new listen/bind/ehash local declarations reverse xmas tree.
  - Left INET_DIAG_DUMP_CURSOR_MPTCP_LISTEN to the MPTCP patch.
  - Moved SKARR_SZ comment off "bh disabled" and aligned the ehash cursor
    continuation indent.
  - Refreshed the reviewed PoC and decoded crash-log artifacts.
  - v1 Link: https://lore.kernel.org/all/cover.1785307984.git.zihanx@nebusec.ai/

 include/linux/inet_diag.h     |  14 ++
 include/net/inet_hashtables.h |  18 ++
 net/ipv4/inet_diag.c          |  13 ++
 net/ipv4/inet_hashtables.c    |  18 --
 net/ipv4/tcp_diag.c           | 338 +++++++++++++++++++++++++---------
 5 files changed, 294 insertions(+), 107 deletions(-)

diff --git a/include/linux/inet_diag.h b/include/linux/inet_diag.h
index 704fd415c2b4..6ccd32bc48f9 100644
--- a/include/linux/inet_diag.h
+++ b/include/linux/inet_diag.h
@@ -6,6 +6,7 @@
 #include <uapi/linux/inet_diag.h>
 
 struct inet_hashinfo;
+struct sock;
 
 struct inet_diag_handler {
 	struct module	*owner;
@@ -32,12 +33,23 @@ struct inet_diag_handler {
 };
 
 struct bpf_sk_storage_diag;
+
+enum inet_diag_dump_cursor_type {
+	INET_DIAG_DUMP_CURSOR_NONE,
+	INET_DIAG_DUMP_CURSOR_TCP_LISTEN,
+	INET_DIAG_DUMP_CURSOR_TCP_BIND,
+	INET_DIAG_DUMP_CURSOR_TCP_EHASH,
+};
+
 struct inet_diag_dump_data {
 	struct nlattr *req_nlas[__INET_DIAG_REQ_MAX];
 #define inet_diag_nla_bc req_nlas[INET_DIAG_REQ_BYTECODE]
 #define inet_diag_nla_bpf_stgs req_nlas[INET_DIAG_REQ_SK_BPF_STORAGES]
 
 	struct bpf_sk_storage_diag *bpf_stg_diag;
+	struct sock *dump_cursor;
+	unsigned int dump_cursor_slot;
+	u8 dump_cursor_type;
 	bool mark_needed;	/* INET_DIAG_BC_MARK_COND present. */
 #ifdef CONFIG_SOCK_CGROUP_DATA
 	bool cgroup_needed;	/* INET_DIAG_BC_CGROUP_COND present. */
@@ -53,6 +65,8 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 
 int inet_diag_bc_sk(const struct inet_diag_dump_data *cb_data, struct sock *sk);
 
+void inet_diag_dump_clear_cursor(struct inet_diag_dump_data *cb_data);
+
 void inet_diag_msg_common_fill(struct inet_diag_msg *r, struct sock *sk);
 
 static inline size_t inet_diag_msg_attrs_size(void)
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 6e2fe186d0dc..d95639ac70c6 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -188,6 +188,24 @@ inet_lhash2_bucket(struct inet_hashinfo *h, u32 hash)
 	return &h->lhash2[hash & h->lhash2_mask];
 }
 
+static inline struct inet_listen_hashbucket *
+inet_lhash2_bucket_sk(struct inet_hashinfo *h, struct sock *sk)
+{
+	u32 hash;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (sk->sk_family == AF_INET6)
+		hash = ipv6_portaddr_hash(sock_net(sk),
+					  &sk->sk_v6_rcv_saddr,
+					  inet_sk(sk)->inet_num);
+	else
+#endif
+		hash = ipv4_portaddr_hash(sock_net(sk),
+					  inet_sk(sk)->inet_rcv_saddr,
+					  inet_sk(sk)->inet_num);
+	return inet_lhash2_bucket(h, hash);
+}
+
 static inline struct inet_ehash_bucket *inet_ehash_bucket(
 	struct inet_hashinfo *hashinfo,
 	unsigned int hash)
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 34b77aa87d0a..41148e880054 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -891,10 +891,23 @@ static int inet_diag_dump_start_compat(struct netlink_callback *cb)
 	return __inet_diag_dump_start(cb, sizeof(struct inet_diag_req));
 }
 
+void inet_diag_dump_clear_cursor(struct inet_diag_dump_data *cb_data)
+{
+	if (!cb_data->dump_cursor)
+		return;
+
+	sock_gen_put(cb_data->dump_cursor);
+	cb_data->dump_cursor = NULL;
+	cb_data->dump_cursor_slot = 0;
+	cb_data->dump_cursor_type = INET_DIAG_DUMP_CURSOR_NONE;
+}
+EXPORT_SYMBOL_GPL(inet_diag_dump_clear_cursor);
+
 static int inet_diag_dump_done(struct netlink_callback *cb)
 {
 	struct inet_diag_dump_data *cb_data = cb->data;
 
+	inet_diag_dump_clear_cursor(cb_data);
 	bpf_sk_storage_diag_free(cb_data->bpf_stg_diag);
 	kfree(cb->data);
 
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index ba0faa9ae2bb..1c839fe3d7e0 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -331,24 +331,6 @@ int __inet_inherit_port(const struct sock *sk, struct sock *child)
 	return -ENOMEM;
 }
 
-static struct inet_listen_hashbucket *
-inet_lhash2_bucket_sk(struct inet_hashinfo *h, struct sock *sk)
-{
-	u32 hash;
-
-#if IS_ENABLED(CONFIG_IPV6)
-	if (sk->sk_family == AF_INET6)
-		hash = ipv6_portaddr_hash(sock_net(sk),
-					  &sk->sk_v6_rcv_saddr,
-					  inet_sk(sk)->inet_num);
-	else
-#endif
-		hash = ipv4_portaddr_hash(sock_net(sk),
-					  inet_sk(sk)->inet_rcv_saddr,
-					  inet_sk(sk)->inet_num);
-	return inet_lhash2_bucket(h, hash);
-}
-
 static inline int compute_score(struct sock *sk, const struct net *net,
 				const unsigned short hnum, const __be32 daddr,
 				const int dif, const int sdif)
diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
index ba1fdbe9807f..842e13ee79e5 100644
--- a/net/ipv4/tcp_diag.c
+++ b/net/ipv4/tcp_diag.c
@@ -285,6 +285,73 @@ static int sk_diag_fill(struct sock *sk, struct sk_buff *skb,
 				 net_admin);
 }
 
+/* Process a maximum of SKARR_SZ sockets at a time when walking hash buckets
+ * while holding a bucket lock.
+ */
+#define SKARR_SZ 16
+
+static void tcp_diag_save_cursor(struct inet_diag_dump_data *cb_data, int type,
+				 unsigned int slot, struct sock *sk)
+{
+	sock_hold(sk);
+	inet_diag_dump_clear_cursor(cb_data);
+	cb_data->dump_cursor = sk;
+	cb_data->dump_cursor_slot = slot;
+	cb_data->dump_cursor_type = type;
+}
+
+static struct inet_bind2_bucket *tcp_diag_sk_bind2(const struct sock *sk)
+{
+	if (sk->sk_state == TCP_TIME_WAIT)
+		return inet_twsk(sk)->tw_tb2;
+
+	return inet_csk(sk)->icsk_bind2_hash;
+}
+
+static bool tcp_diag_bind_collect_sock(struct sock *sk, struct sock **sk_arr,
+				       int *num_arr, int *accum, int num)
+{
+	sock_hold(sk);
+	num_arr[*accum] = num;
+	sk_arr[*accum] = sk;
+
+	return ++*accum == SKARR_SZ;
+}
+
+static bool tcp_diag_bind_collect_owners(struct hlist_head *owners,
+					 struct sock **sk_arr, int *num_arr,
+					 int *accum, int *num, int s_num)
+{
+	struct sock *sk;
+
+	sk_for_each_bound(sk, owners) {
+		if (*num < s_num) {
+			(*num)++;
+			continue;
+		}
+
+		if (tcp_diag_bind_collect_sock(sk, sk_arr, num_arr, accum, *num))
+			return true;
+		(*num)++;
+	}
+
+	return false;
+}
+
+static bool tcp_diag_bind_collect_owners_continue(struct sock *sk,
+						  struct sock **sk_arr,
+						  int *num_arr, int *accum,
+						  int *num)
+{
+	hlist_for_each_entry_continue(sk, sk_bind_node) {
+		if (tcp_diag_bind_collect_sock(sk, sk_arr, num_arr, accum, *num))
+			return true;
+		(*num)++;
+	}
+
+	return false;
+}
+
 static void twsk_build_assert(void)
 {
 	BUILD_BUG_ON(offsetof(struct inet_timewait_sock, tw_family) !=
@@ -335,8 +402,15 @@ static void tcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 		for (i = s_i; i <= hashinfo->lhash2_mask; i++) {
 			struct inet_listen_hashbucket *ilb;
 			struct hlist_nulls_node *node;
+			struct sock *sk_arr[SKARR_SZ];
+			int num_arr[SKARR_SZ];
+			struct sock *cursor;
+			int idx, accum, res;
+			bool use_cursor;
 
+resume_listen_walk:
 			num = 0;
+			accum = 0;
 			ilb = &hashinfo->lhash2[i];
 
 			if (hlist_nulls_empty(&ilb->nulls_head)) {
@@ -344,52 +418,81 @@ static void tcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 				continue;
 			}
 			spin_lock(&ilb->lock);
-			sk_nulls_for_each(sk, node, &ilb->nulls_head) {
-				struct inet_sock *inet = inet_sk(sk);
+			cursor = cb_data->dump_cursor;
+			use_cursor = cursor &&
+				     cb_data->dump_cursor_type ==
+				     INET_DIAG_DUMP_CURSOR_TCP_LISTEN &&
+				     cb_data->dump_cursor_slot == i &&
+				     inet_sk_state_load(cursor) == TCP_LISTEN &&
+				     !hlist_nulls_unhashed(&cursor->sk_nulls_node) &&
+				     cursor->sk_nulls_node.pprev != LIST_POISON2 &&
+				     inet_lhash2_bucket_sk(hashinfo, cursor) == ilb;
+			node = use_cursor ? cursor->sk_nulls_node.next :
+					    ilb->nulls_head.first;
+			if (!use_cursor)
+				s_num = 0;
+			hlist_nulls_for_each_entry_from(sk, node, sk_nulls_node) {
 
-				if (!net_eq(sock_net(sk), net))
-					continue;
+				sock_hold(sk);
+				num_arr[accum] = num;
+				sk_arr[accum] = sk;
+				if (++accum == SKARR_SZ)
+					break;
 
-				if (num < s_num) {
-					num++;
-					continue;
-				}
+				++num;
+			}
+			spin_unlock(&ilb->lock);
+
+			res = 0;
+			for (idx = 0; idx < accum; idx++) {
+				struct inet_sock *inet;
+
+				sk = sk_arr[idx];
+				if (!net_eq(sock_net(sk), net))
+					goto processed_listen_sk;
 
+				inet = inet_sk(sk);
 				if (r->sdiag_family != AF_UNSPEC &&
 				    sk->sk_family != r->sdiag_family)
-					goto next_listen;
+					goto processed_listen_sk;
 
 				if (r->id.idiag_sport != inet->inet_sport &&
 				    r->id.idiag_sport)
-					goto next_listen;
-
-				if (!inet_diag_bc_sk(cb_data, sk))
-					goto next_listen;
+					goto processed_listen_sk;
 
-				if (inet_sk_diag_fill(sk, inet_csk(sk), skb,
-						      cb, r, NLM_F_MULTI,
-						      net_admin) < 0) {
-					spin_unlock(&ilb->lock);
-					goto done;
+				if (res >= 0 && inet_diag_bc_sk(cb_data, sk)) {
+					res = inet_sk_diag_fill(sk, inet_csk(sk),
+								skb, cb, r, NLM_F_MULTI,
+								net_admin);
+					if (res < 0)
+						num = num_arr[idx];
 				}
+processed_listen_sk:
+				if (res >= 0)
+					tcp_diag_save_cursor(cb_data,
+							     INET_DIAG_DUMP_CURSOR_TCP_LISTEN,
+							     i, sk);
+				sock_put(sk);
+			}
+			if (res < 0)
+				goto done;
 
-next_listen:
-				++num;
+			cond_resched();
+
+			if (accum == SKARR_SZ) {
+				s_num = 0;
+				goto resume_listen_walk;
 			}
-			spin_unlock(&ilb->lock);
 
+			inet_diag_dump_clear_cursor(cb_data);
 			s_num = 0;
 		}
 skip_listen_ht:
+		inet_diag_dump_clear_cursor(cb_data);
 		cb->args[0] = 1;
 		s_i = num = s_num = 0;
 	}
 
-/* Process a maximum of SKARR_SZ sockets at a time when walking hash buckets
- * with bh disabled.
- */
-#define SKARR_SZ 16
-
 	/* Dump bound but inactive (not listening, connecting, etc.) sockets */
 	if (cb->args[0] == 1) {
 		if (!(idiag_states & TCPF_BOUND_INACTIVE))
@@ -400,7 +503,9 @@ static void tcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 			struct inet_bind2_bucket *tb2;
 			struct sock *sk_arr[SKARR_SZ];
 			int num_arr[SKARR_SZ];
+			struct sock *cursor;
 			int idx, accum, res;
+			bool use_cursor;
 
 resume_bind_walk:
 			num = 0;
@@ -412,34 +517,46 @@ static void tcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 				continue;
 			}
 			spin_lock_bh(&ibb->lock);
-			inet_bind_bucket_for_each(tb2, &ibb->chain) {
-				if (!net_eq(ib2_net(tb2), net))
-					continue;
-
-				sk_for_each_bound(sk, &tb2->owners) {
-					struct inet_sock *inet = inet_sk(sk);
-
-					if (num < s_num)
-						goto next_bind;
-
-					if (sk->sk_state != TCP_CLOSE ||
-					    !inet->inet_num)
-						goto next_bind;
-
-					if (r->sdiag_family != AF_UNSPEC &&
-					    r->sdiag_family != sk->sk_family)
-						goto next_bind;
-
-					if (!inet_diag_bc_sk(cb_data, sk))
-						goto next_bind;
-
-					sock_hold(sk);
-					num_arr[accum] = num;
-					sk_arr[accum] = sk;
-					if (++accum == SKARR_SZ)
+			cursor = cb_data->dump_cursor;
+			use_cursor = cursor &&
+				     cb_data->dump_cursor_type ==
+				     INET_DIAG_DUMP_CURSOR_TCP_BIND &&
+				     cb_data->dump_cursor_slot == i &&
+				     !hlist_unhashed(&cursor->sk_bind_node) &&
+				     cursor->sk_bind_node.pprev != LIST_POISON2;
+			if (use_cursor) {
+				tb2 = tcp_diag_sk_bind2(cursor);
+				use_cursor = tb2 &&
+					     inet_bhashfn_portaddr(hashinfo, cursor,
+								   sock_net(cursor),
+								   inet_sk(cursor)->inet_num) ==
+					     ibb;
+			}
+			if (!use_cursor)
+				s_num = 0;
+			if (use_cursor) {
+				sk = cursor;
+				if (tcp_diag_bind_collect_owners_continue(sk, sk_arr,
+									  num_arr,
+									  &accum,
+									  &num))
+					goto pause_bind_walk;
+				hlist_for_each_entry_continue(tb2, node) {
+					if (tcp_diag_bind_collect_owners(&tb2->owners,
+									 sk_arr,
+									 num_arr,
+									 &accum,
+									 &num, 0))
+						goto pause_bind_walk;
+				}
+			} else {
+				inet_bind_bucket_for_each(tb2, &ibb->chain) {
+					if (tcp_diag_bind_collect_owners(&tb2->owners,
+									 sk_arr,
+									 num_arr,
+									 &accum,
+									 &num, s_num))
 						goto pause_bind_walk;
-next_bind:
-					num++;
 				}
 			}
 pause_bind_walk:
@@ -447,15 +564,33 @@ static void tcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 
 			res = 0;
 			for (idx = 0; idx < accum; idx++) {
-				if (res >= 0) {
-					res = inet_sk_diag_fill(sk_arr[idx],
-								NULL, skb, cb,
+				struct inet_sock *inet;
+
+				sk = sk_arr[idx];
+				if (!net_eq(sock_net(sk), net))
+					goto put_bind_sk;
+
+				inet = inet_sk(sk);
+				if (sk->sk_state != TCP_CLOSE || !inet->inet_num)
+					goto put_bind_sk;
+
+				if (r->sdiag_family != AF_UNSPEC &&
+				    r->sdiag_family != sk->sk_family)
+					goto put_bind_sk;
+
+				if (res >= 0 && inet_diag_bc_sk(cb_data, sk)) {
+					res = inet_sk_diag_fill(sk, NULL, skb, cb,
 								r, NLM_F_MULTI,
 								net_admin);
 					if (res < 0)
 						num = num_arr[idx];
 				}
-				sock_put(sk_arr[idx]);
+put_bind_sk:
+				if (res >= 0)
+					tcp_diag_save_cursor(cb_data,
+							     INET_DIAG_DUMP_CURSOR_TCP_BIND,
+							     i, sk);
+				sock_gen_put(sk);
 			}
 			if (res < 0)
 				goto done;
@@ -463,13 +598,15 @@ static void tcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 			cond_resched();
 
 			if (accum == SKARR_SZ) {
-				s_num = num + 1;
+				s_num = 0;
 				goto resume_bind_walk;
 			}
 
+			inet_diag_dump_clear_cursor(cb_data);
 			s_num = 0;
 		}
 skip_bind_ht:
+		inet_diag_dump_clear_cursor(cb_data);
 		cb->args[0] = 2;
 		s_i = num = s_num = 0;
 	}
@@ -483,43 +620,35 @@ static void tcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 		struct hlist_nulls_node *node;
 		struct sock *sk_arr[SKARR_SZ];
 		int num_arr[SKARR_SZ];
+		struct sock *cursor;
 		int idx, accum, res;
+		bool use_cursor;
 
 		if (hlist_nulls_empty(&head->chain))
 			continue;
 
-		if (i > s_i)
+		if (i > s_i) {
+			inet_diag_dump_clear_cursor(cb_data);
 			s_num = 0;
+		}
 
 next_chunk:
 		num = 0;
 		accum = 0;
 		spin_lock_bh(lock);
-		sk_nulls_for_each(sk, node, &head->chain) {
-			int state;
-
-			if (!net_eq(sock_net(sk), net))
-				continue;
-			if (num < s_num)
-				goto next_normal;
-			state = (sk->sk_state == TCP_TIME_WAIT) ?
-				READ_ONCE(inet_twsk(sk)->tw_substate) : sk->sk_state;
-			if (!(idiag_states & (1 << state)))
-				goto next_normal;
-			if (r->sdiag_family != AF_UNSPEC &&
-			    sk->sk_family != r->sdiag_family)
-				goto next_normal;
-			if (r->id.idiag_sport != htons(READ_ONCE(sk->sk_num)) &&
-			    r->id.idiag_sport)
-				goto next_normal;
-			if (r->id.idiag_dport != sk->sk_dport &&
-			    r->id.idiag_dport)
-				goto next_normal;
-			twsk_build_assert();
-
-			if (!inet_diag_bc_sk(cb_data, sk))
-				goto next_normal;
-
+		cursor = cb_data->dump_cursor;
+		use_cursor = cursor &&
+			     cb_data->dump_cursor_type ==
+			     INET_DIAG_DUMP_CURSOR_TCP_EHASH &&
+			     cb_data->dump_cursor_slot == i &&
+			     inet_sk_state_load(cursor) != TCP_LISTEN &&
+			     !hlist_nulls_unhashed(&cursor->sk_nulls_node) &&
+			     cursor->sk_nulls_node.pprev != LIST_POISON2 &&
+			     inet_ehash_bucket(hashinfo, cursor->sk_hash) == head;
+		node = use_cursor ? cursor->sk_nulls_node.next : head->chain.first;
+		if (!use_cursor)
+			s_num = 0;
+		hlist_nulls_for_each_entry_from(sk, node, sk_nulls_node) {
 			if (!refcount_inc_not_zero(&sk->sk_refcnt))
 				goto next_normal;
 
@@ -534,13 +663,42 @@ static void tcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 
 		res = 0;
 		for (idx = 0; idx < accum; idx++) {
-			if (res >= 0) {
-				res = sk_diag_fill(sk_arr[idx], skb, cb, r,
-						   NLM_F_MULTI, net_admin);
+			int state;
+
+			sk = sk_arr[idx];
+			if (!net_eq(sock_net(sk), net))
+				goto put_estab_sk;
+
+			state = (sk->sk_state == TCP_TIME_WAIT) ?
+				READ_ONCE(inet_twsk(sk)->tw_substate) : sk->sk_state;
+			if (!(idiag_states & (1 << state)))
+				goto put_estab_sk;
+
+			if (r->sdiag_family != AF_UNSPEC &&
+			    sk->sk_family != r->sdiag_family)
+				goto put_estab_sk;
+
+			if (r->id.idiag_sport != htons(READ_ONCE(sk->sk_num)) &&
+			    r->id.idiag_sport)
+				goto put_estab_sk;
+
+			if (r->id.idiag_dport != sk->sk_dport &&
+			    r->id.idiag_dport)
+				goto put_estab_sk;
+
+			twsk_build_assert();
+			if (res >= 0 && inet_diag_bc_sk(cb_data, sk)) {
+				res = sk_diag_fill(sk, skb, cb, r, NLM_F_MULTI,
+						   net_admin);
 				if (res < 0)
 					num = num_arr[idx];
 			}
-			sock_gen_put(sk_arr[idx]);
+put_estab_sk:
+			if (res >= 0)
+				tcp_diag_save_cursor(cb_data,
+						     INET_DIAG_DUMP_CURSOR_TCP_EHASH,
+						     i, sk);
+			sock_gen_put(sk);
 		}
 		if (res < 0)
 			break;
@@ -548,9 +706,11 @@ static void tcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 		cond_resched();
 
 		if (accum == SKARR_SZ) {
-			s_num = num + 1;
+			s_num = 0;
 			goto next_chunk;
 		}
+
+		inet_diag_dump_clear_cursor(cb_data);
 	}
 
 done:
-- 
2.43.0

