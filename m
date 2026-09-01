Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3083AE718
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 12:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788267269; cv=none; b=cRdTdw0CPSjFjSDq4Fvm51uNusuZurDc0wfpkr9BXZ+Pepx2bvq1EAnaUuuGAor95S+cKuxHEgrIiVCQNZQHzpXjBxhRJCfg3Xp6Zj/G94ev7WwR345b31RhAKwwU3tECxG17UCLDs1qLMdj3mrEBhSqUP+waFKjRH5cZglZOYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788267269; c=relaxed/simple;
	bh=zarcyGPirVKljwxNeGDx0sin76rbHeFW2Cd7O0/qZDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqJOIrhIk3k2wTxyPjwMHZ7al6P3erbgzNiHgY8chY+vjZlJTprWOf7JZuwQ9Brt4ATrjuw0oICtwIP5nD3PKmNFpSSjmXOhydthk+5CA/UOPT8MNV+Qf34aN3AfixsCZdgR5CDvOGEOT3QNwEjm9h7Pt0WwSZqWdnRM7yKCNSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=cvzDpjpG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="cvzDpjpG"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d71ae3455aso13089675ad.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 05:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788267267; x=1788872067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nPBTnM4CiDrSs11VlMGUK8cKAPSAQrX+j7COGLEHoVw=;
        b=cvzDpjpG77x8Ar6J0vWudVI0IgTUkMZyTIRMZTfQLey5DnuUGhWlgew999ScibUIOJ
         QqtRlBWvtJEVp9dvvGg976Jk50ZaORFQ1lVpFtXXHSausq34z80afuGpRih5GSCPidYb
         9kl5+AS7lnnIPjEwH/yVUKDkQVUGgaulV1VgC2qHJ02eEla/MTL4dB4K6enBZ7nqGvXu
         NkQn4kU4ifjD/JprXsktU4EXRYZP/6QFM6N9EgzdPyO6iA3RuoFbQ6L+MSFft6Fp6lHj
         qv93MIPVKB6gNK6xOzrvx4bRIqgbE8VpVVEmAJR9xeFhzlInChUqRrt+UwaDecjVoEOu
         jw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788267267; x=1788872067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nPBTnM4CiDrSs11VlMGUK8cKAPSAQrX+j7COGLEHoVw=;
        b=Y5N0bXNK+p7BXz+jL+gdlpvgqpWMVIX6BULWYBkuOSiF8M81OX4D25We/ShHE5A4s2
         vG5bAOjzJSLPCrxiRnhU3C381xbLB77OFyYi+BNKNOHxZot9nWaI+XmR/MsJsz4+JHV4
         88Q1+/GXsJit8mTHgRbhC/zimXC7LqCG2zYtsVW7RcdxJsYC7fvl9aDR82SdLfhTVqUE
         Jj5dn6c8XH9mBYlzQ7aUeHIUgyf0m1sBIvjfNdHvV7gDmhp65+mAVg7Y47NTzIoBtoj5
         2LlPybk9fBH1URNWYtrtm+N7LlpOv8My30ltDRFtxRjc3Ij9OmnXtB+YSJradyy2hZDg
         EDsw==
X-Forwarded-Encrypted: i=1; AKwUvByjoWyMwFIAooDXv4umHTR00QzWRZ8bvCpo3kN/Red4Lk2tQBgMb/bh+RZSY+tFICU1vVy3Mtk=@vger.kernel.org
X-Gm-Message-State: AFuF++kDNAzzGFhrSCqwTniWq3mDAWtUueQheoRGzGuUkE4DiDxHWyq0
	ftOnH7tlueP5Vyb76UGmGQt2BuNoHA47N3GC/bwi3NIiz5bkalG3PwUSbGAFByVlafOl
X-Gm-Gg: AYBFou1pfvBZTMWwmauah4BgRKTEiunz/7bng/+oedGzOwsNWkUFADvmh8wsojLsZet
	EghUuoH5yjnrTG8Hi16FIDcl3AZHHstX4OJ2QZYOXc8X/CrihmabRhHLVvIPqGkRRRgZsuvZkIm
	jM8v6VgPprCkqoRr3wxCWs9T85/qHedFu9iN9l4+YIOFFfFaYzBid5pvjdyfg/jGqveQY8vVSc8
	k1qiNNch/cghkmqkeBftOyFEQR74TkQ8ibu3sZf+8bLn+IbzaBuwHOJHzT86kNXJzwLZIARU24A
	n8jlr8nYte2gDl6sNhlTBYVO179c96npNOu+sqLcwGHN6zlLCky78h47dQKzXwpaxVOJmIrR8AX
	0SqJZ+sXFXZ6wTRd3xzI3Wz9Yc3uUy5htIDcz6Rp/MBjrS9SqcE2vdmNYwqs1DU3lKWHnBrV8tk
	TpoYoEvEuvec+ewsid9w2KnDorpTKeljSgitolSiXvWXQPxcdl2/+1Yq+JVIsgg/ii3EyhLW8mC
	RuHNP8Z44VbbQMCpM4=
X-Received: by 2002:a17:902:f70a:b0:2d9:56d8:75f with SMTP id d9443c01a7336-2d956d80878mr80857275ad.9.1788267267455;
        Tue, 01 Sep 2026 05:54:27 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d759869c96sm51184175ad.40.2026.09.01.05.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 05:54:26 -0700 (PDT)
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
Subject: [PATCH net v2 2/2] mptcp: diag: bound listener bucket lock hold
Date: Tue,  1 Sep 2026 12:53:47 +0000
Message-ID: <db1f34ca8461c7b0dc5ec504ea1b99c24b909e34.1788248601.git.zihanx@nebusec.ai>
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

MPTCP listener diag dumping reuses sk_diag_dump(), which executes
inet_diag_bc_sk() before filling the netlink reply. The listener walk in
mptcp_diag_dump_listeners() currently performs that work while holding the
listener bucket lock.

The time spent under the listener bucket lock can therefore grow with the
number of sockets visited and with per-socket dump work. The resume state
also requires later batches to revisit the bucket prefix.

Fix this by collecting only referenced listener sockets while holding the
bucket lock. After dropping it, re-check the listener properties, obtain
the parent MPTCP socket reference, and call sk_diag_dump(). Keep a
referenced cursor so later batches resume after the previous listener
instead of rescanning the bucket head. Validate a cursor against the
current listener bucket and TCP_LISTEN state before resuming from it.
After dropping the lock, read icsk_ulp_data with rcu_dereference().

Fixes: 4fa39b701ce9 ("mptcp: listen diag dump support")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v2:
  - Rebased onto net commit e2a6641e3bfd (2026-08-27).
  - Added current-bucket cursor validation and safe restart.
  - Reject MPTCP listener cursors unless the socket is still TCP_LISTEN.
  - Read icsk_ulp_data with rcu_dereference() after dropping the listener
    lock.
  - Moved INET_DIAG_DUMP_CURSOR_MPTCP_LISTEN into this patch.
  - Moved MPTCP_DIAG_BULK_SZ below the includes and sorted new local
    declarations reverse xmas tree.
  - Refreshed the reviewed PoC and decoded crash-log artifacts.
  - v1 Link: https://lore.kernel.org/all/cover.1785307984.git.zihanx@nebusec.ai/

 include/linux/inet_diag.h |   1 +
 net/mptcp/mptcp_diag.c    | 124 +++++++++++++++++++++++++++-----------
 2 files changed, 89 insertions(+), 36 deletions(-)

diff --git a/include/linux/inet_diag.h b/include/linux/inet_diag.h
index 6ccd32bc48f9..4859e77a28c7 100644
--- a/include/linux/inet_diag.h
+++ b/include/linux/inet_diag.h
@@ -39,6 +39,7 @@ enum inet_diag_dump_cursor_type {
 	INET_DIAG_DUMP_CURSOR_TCP_LISTEN,
 	INET_DIAG_DUMP_CURSOR_TCP_BIND,
 	INET_DIAG_DUMP_CURSOR_TCP_EHASH,
+	INET_DIAG_DUMP_CURSOR_MPTCP_LISTEN,
 };
 
 struct inet_diag_dump_data {
diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index 136c2d05c0ee..37b33ea5d79d 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -12,6 +12,19 @@
 #include <net/netlink.h>
 #include "protocol.h"
 
+/* Process a bounded number of listeners per bucket lock hold. */
+#define MPTCP_DIAG_BULK_SZ 16
+
+static void mptcp_diag_save_cursor(struct inet_diag_dump_data *cb_data,
+				   unsigned int slot, struct sock *sk)
+{
+	sock_hold(sk);
+	inet_diag_dump_clear_cursor(cb_data);
+	cb_data->dump_cursor = sk;
+	cb_data->dump_cursor_slot = slot;
+	cb_data->dump_cursor_type = INET_DIAG_DUMP_CURSOR_MPTCP_LISTEN;
+}
+
 static int sk_diag_dump(struct sock *sk, struct sk_buff *skb,
 			struct netlink_callback *cb,
 			const struct inet_diag_req_v2 *req,
@@ -77,6 +90,7 @@ static void mptcp_diag_dump_listeners(struct sk_buff *skb, struct netlink_callba
 				      bool net_admin)
 {
 	struct mptcp_diag_ctx *diag_ctx = (void *)cb->ctx;
+	struct inet_diag_dump_data *cb_data = cb->data;
 	struct net *net = sock_net(skb->sk);
 	struct inet_hashinfo *hinfo;
 	int i;
@@ -84,64 +98,102 @@ static void mptcp_diag_dump_listeners(struct sk_buff *skb, struct netlink_callba
 	hinfo = net->ipv4.tcp_death_row.hashinfo;
 
 	for (i = diag_ctx->l_slot; i <= hinfo->lhash2_mask; i++) {
+		struct sock *tmp, *sk, *sk_arr[MPTCP_DIAG_BULK_SZ];
 		struct inet_listen_hashbucket *ilb;
+		int num_arr[MPTCP_DIAG_BULK_SZ];
 		struct hlist_nulls_node *node;
-		struct sock *sk;
-		int num = 0;
+		int accum, idx, num, ret;
+		struct sock *cursor;
+		bool use_cursor;
 
+resume_listen_walk:
+		num = 0;
+		accum = 0;
 		ilb = &hinfo->lhash2[i];
+		ret = 0;
 
 		rcu_read_lock();
 		spin_lock(&ilb->lock);
-		sk_nulls_for_each(sk, node, &ilb->nulls_head) {
-			const struct mptcp_subflow_context *ctx = mptcp_subflow_ctx(sk);
-			struct inet_sock *inet = inet_sk(sk);
-			int ret;
-
-			if (num < diag_ctx->l_num)
-				goto next_listen;
-
-			if (!ctx || strcmp(inet_csk(sk)->icsk_ulp_ops->name, "mptcp"))
-				goto next_listen;
-
-			sk = ctx->conn;
-			if (!sk || !net_eq(sock_net(sk), net))
-				goto next_listen;
-
-			if (r->sdiag_family != AF_UNSPEC &&
-			    sk->sk_family != r->sdiag_family)
-				goto next_listen;
-
-			if (r->id.idiag_sport != inet->inet_sport &&
-			    r->id.idiag_sport)
+		cursor = cb_data->dump_cursor;
+		use_cursor = cursor &&
+			     cb_data->dump_cursor_type ==
+			     INET_DIAG_DUMP_CURSOR_MPTCP_LISTEN &&
+			     cb_data->dump_cursor_slot == i &&
+			     inet_sk_state_load(cursor) == TCP_LISTEN &&
+			     !hlist_nulls_unhashed(&cursor->sk_nulls_node) &&
+			     cursor->sk_nulls_node.pprev != LIST_POISON2 &&
+			     inet_lhash2_bucket_sk(hinfo, cursor) == ilb;
+		node = use_cursor ? cursor->sk_nulls_node.next :
+				    ilb->nulls_head.first;
+		hlist_nulls_for_each_entry_from(sk, node, sk_nulls_node) {
+			if (!use_cursor && num < diag_ctx->l_num)
 				goto next_listen;
 
 			if (!refcount_inc_not_zero(&sk->sk_refcnt))
 				goto next_listen;
 
-			ret = sk_diag_dump(sk, skb, cb, r, net_admin);
-
-			sock_put(sk);
-
-			if (ret < 0) {
-				spin_unlock(&ilb->lock);
-				rcu_read_unlock();
-				diag_ctx->l_slot = i;
-				diag_ctx->l_num = num;
-				return;
-			}
-			diag_ctx->l_num = num + 1;
-			num = 0;
+			num_arr[accum] = num;
+			sk_arr[accum] = sk;
+			if (++accum == MPTCP_DIAG_BULK_SZ)
+				break;
 next_listen:
 			++num;
 		}
 		spin_unlock(&ilb->lock);
 		rcu_read_unlock();
 
+		for (idx = 0; idx < accum; idx++) {
+			const struct mptcp_subflow_context *ctx;
+			const struct tcp_ulp_ops *ulp_ops;
+			struct inet_sock *inet;
+
+			sk = sk_arr[idx];
+			rcu_read_lock();
+			ctx = rcu_dereference(inet_csk(sk)->icsk_ulp_data);
+			ulp_ops = READ_ONCE(inet_csk(sk)->icsk_ulp_ops);
+			inet = inet_sk(sk);
+			tmp = ctx ? ctx->conn : NULL;
+			if (!ctx || !ulp_ops || strcmp(ulp_ops->name, "mptcp") ||
+			    !tmp || !net_eq(sock_net(tmp), net) ||
+			    (r->sdiag_family != AF_UNSPEC &&
+			     tmp->sk_family != r->sdiag_family) ||
+			    (r->id.idiag_sport != inet->inet_sport &&
+			     r->id.idiag_sport) ||
+			    !refcount_inc_not_zero(&tmp->sk_refcnt)) {
+				rcu_read_unlock();
+				goto processed_listener_sk;
+			}
+			rcu_read_unlock();
+			if (ret >= 0) {
+				ret = sk_diag_dump(tmp, skb, cb, r, net_admin);
+				if (ret < 0)
+					num = num_arr[idx];
+			}
+			sock_put(tmp);
+processed_listener_sk:
+			if (ret >= 0)
+				mptcp_diag_save_cursor(cb_data, i, sk);
+			sock_put(sk);
+		}
+
+		if (ret < 0) {
+			diag_ctx->l_slot = i;
+			diag_ctx->l_num = num;
+			return;
+		}
+
 		cond_resched();
+
+		if (accum == MPTCP_DIAG_BULK_SZ) {
+			diag_ctx->l_num = 0;
+			goto resume_listen_walk;
+		}
+
+		inet_diag_dump_clear_cursor(cb_data);
 		diag_ctx->l_num = 0;
 	}
 
+	inet_diag_dump_clear_cursor(cb_data);
 	diag_ctx->l_num = 0;
 	diag_ctx->l_slot = i;
 }
-- 
2.43.0

