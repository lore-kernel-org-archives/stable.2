Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1740D3E122D
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 10:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782728536; cv=none; b=i8/uMMaO6fsIeMZ8Dwf4H6Da32wsaEeNyA2D+KSNUe/25PZAUuBLNsSOpx7rhszmjmE81/I2C7AAvl8K9CJvUl5cJhq3GJOxK38iTrC+j3EZziVX937li8Mqon0nEPzU12MAY9AnaJjdAQM8LGJ/9R2st+u5ASD59QC471iE2Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782728536; c=relaxed/simple;
	bh=LQyuk+2XvgHA9CRUQzSGIGOjO95syCUcsge3kwP89SI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b3TIDvXcOdHi/MFgVqgOBZkxKQcIeublkbqPRye4ebyhZva+48Gx0rCG6sI/qIZ+v73ip7wjjKO43EHHAEm7Jvif3g43++eSz9lFqxg0GHfhb2uWXA8JhVTJ3gdA7JHNluox+guGB61dpnQJGI11WE3oj97v7oLkIqhgI64Y3cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ddB2d7eO; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="ddB2d7eO"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8e9c9d63815so18799386d6.2
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 03:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782728534; x=1783333334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKvM1smkzYAQlLOUZpGNh94x+wzWvVAEpjlRBYbmxwA=;
        b=ddB2d7eOFDQ1MbIGX5Etgcyp9FHFkwTarOXMACSOo3kJTRsC5JSSLU4YU9UYRnGwW/
         9wVfrW3xDp9S1RCELOczU9T92KdEf6kEmKpLSyf+jisuRfLDwi+9vxkChlRrXAtEHnQX
         CJxxLdmBR/t8idmoJApioWzu8O1Z97YqlqAQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782728534; x=1783333334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PKvM1smkzYAQlLOUZpGNh94x+wzWvVAEpjlRBYbmxwA=;
        b=kXmV4gD/i9fTegPxUCFDcLrJ5xvNfsQsKe9lDKbAf2ToSaLP4JrAAzuJTWOvFrYVsk
         P/jsXtHAh+ibsohupUrx9c9H9pXSIVI+vunOnSemvEgH3WyuYNHtHk6NQcN3UyFiXODX
         kkILGR1Lu20y4dv5Gawde39nHMvdXtl9ll3TCV5b5hzLNq+4W6S8x8cTLYg7PMkDwWAM
         seJRWndR+gnkbpYyZ687z9tMw8Ygal256tBhuwVpZxd6LvRfKxFGdhdrusJRslLQsWL5
         ObUHKf0peTuJm4Y0jKauRKEPFuuFmKxsH/QePeEECfvTezntggSaKN9t272zH1OrhCcT
         CnkA==
X-Forwarded-Encrypted: i=1; AHgh+RrEZLCBATp4IuhBFzcEazWb0YOnJx9XnB2ZMTILXAZs0NTtrNF0yU+8a8j0HkeuKe6j/LIMa3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPC5/k8FpSLrXXHgWJ7Urz6Dpj67H1t0y3a7WscENHPriDa5TT
	G+vTf8/nAJUiZfp6xg/W4cZhPbm5uNyaFSRZ2JvA79oWApqUs4fLeeWZH1hte0mn5g==
X-Gm-Gg: AfdE7ckm+ImNtvfN1WRayPDHfeZPd3J9Cmttf87VhRL1s8Ap3mKB/1LaijJLhc8Qc3Q
	y4qExxS7mhcStbDRQq73PGu8wjrKQx1gMQhH2USXVZS0isvYclZo4v+m93LNCZ1OPTF6hsMgAJM
	6BeaRYgx91A7j42rE8+uJhZBdmHzlWyWGzbvcz/Tv47QU8eJGRdv4jqQmQNQg3bSg8ePR/Pa0PJ
	vgHM9zt+hnF29VNzmAmIpA6d9w3xL46IFFGlmpnhLmuOvA6+HT3zgq3HG6wxno3cSUgMRl4MHcn
	E3SfBGXugxEBn71zP2MJei/HYxIJGSmH+sniGhyTfiz+cZRj+mvcQmRjrgWOKmPQlUYpwkYi7eg
	OR0shJAslt8Tj6xmQYXdUEhst53R/S7rJL1o5Hvrrm6SECW9t343hYnmdPVS9Sh3kAsLqyXLdEs
	uav4KjwA==
X-Received: by 2002:a0c:f00a:0:b0:8e9:f5de:d5c1 with SMTP id 6a1803df08f44-8e9f5ded9fcmr144265496d6.56.1782728533809;
        Mon, 29 Jun 2026 03:22:13 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ef0f2b9df0sm53589236d6.13.2026.06.29.03.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 03:22:13 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	toke@toke.dk,
	Steven Rostedt <rostedt@goodmis.org>,
	Petr Machata <petrm@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	bpf@vger.kernel.org,
	security@kernel.org,
	stable@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net 1/3 v2] net: Extend bpf_net_context lifetime to cover qdisc enqueue
Date: Mon, 29 Jun 2026 06:21:55 -0400
Message-Id: <20260629102157.737306-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629102157.737306-1-jhs@mojatatu.com>
References: <20260629102157.737306-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_net_context used by sch_handle_egress() is stack-allocated and torn
down in that function returned. By the time tcf_qevent_handle() runs
current->bpf_net_context is NULL.

When a filter attached to a qevent block (e.g. RED's early_drop or mark
qevents, which always use shared blocks) returns TC_ACT_REDIRECT,
tcf_qevent_handle() calls skb_do_redirect(), which in turn calls bpf helper
bpf_net_ctx_get_ri().  That helper unconditionally dereferences
current->bpf_net_context resulting in a NULL pointer dereference.

Note: The same holds for actions that invoke BPF redirect helpers
(e.g. act_bpf running a program that calls bpf_redirect()) during qevent
classification itself.

Fix:
Move the bpf_net_context lifecycle out of sch_handle_egress() into
__dev_queue_xmit(), so that it spans both the egress TC fast path and the
qdisc enqueue.
Note: The call is placed outside the egress_needed_key static branch
to cover the case where clsact static key is disabled. Unfortunately this
adds a small unconditional penalty to the code path _per packet_ only
guarded by CONFIG_NET_XGRESS (two writes and one read).

As pointed by sashiko [1]:
The same context must also be set up in net_tx_action()'s qdisc drain
path, since qdisc_run() -> netem_dequeue() -> qdisc_enqueue( RED child)
can trigger qevent classification asynchronously from softirq context.

This keeps all bpf_net_context management in net/core/dev.c i.e the
existing boundary between tc core and BPF without requiring any net/sched/
code to know about BPF plumbing.

Reproducer:

  tc qdisc add dev eth0 root handle 1: red limit 1MB min 10KB max 20KB \
      avpkt 1000 burst 100 qevent early_drop block 10
  tc filter add block 10 pref 1 bpf obj redirect.o

  traffic through eth0 triggers red_enqueue() -> tcf_qevent_handle() and,
  on a redirect verdict, a NULL deref in skb_do_redirect().

Fixes: 3625750f05ec ("net: sched: Introduce helpers for qevent blocks")
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/core/dev.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 4b3d5cfdf6e0..b95a8b153c76 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4527,14 +4527,11 @@ sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 {
 	struct bpf_mprog_entry *entry = rcu_dereference_bh(dev->tcx_egress);
 	enum skb_drop_reason drop_reason = SKB_DROP_REASON_TC_EGRESS;
-	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	int sch_ret;
 
 	if (!entry)
 		return skb;
 
-	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
-
 	/* qdisc_skb_cb(skb)->pkt_len & tcx_set_ingress() was
 	 * already set by the caller.
 	 */
@@ -4550,12 +4547,10 @@ sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 		/* No need to push/pop skb's mac_header here on egress! */
 		skb_do_redirect(skb);
 		*ret = NET_XMIT_SUCCESS;
-		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	case TC_ACT_SHOT:
 		kfree_skb_reason(skb, drop_reason);
 		*ret = NET_XMIT_DROP;
-		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	/* used by tc_run */
 	case TC_ACT_STOLEN:
@@ -4565,10 +4560,8 @@ sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 		fallthrough;
 	case TC_ACT_CONSUMED:
 		*ret = NET_XMIT_SUCCESS;
-		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	}
-	bpf_net_ctx_clear(bpf_net_ctx);
 
 	return skb;
 }
@@ -4767,6 +4760,9 @@ struct netdev_queue *netdev_core_pick_tx(struct net_device *dev,
  */
 int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 {
+#ifdef CONFIG_NET_XGRESS
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx = NULL;
+#endif
 	struct net_device *dev = skb->dev;
 	struct netdev_queue *txq = NULL;
 	enum skb_drop_reason reason;
@@ -4795,6 +4791,9 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 	skb_update_prio(skb);
 
 	tcx_set_ingress(skb, false);
+#ifdef CONFIG_NET_XGRESS
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
+#endif
 #ifdef CONFIG_NET_EGRESS
 	if (static_branch_unlikely(&egress_needed_key)) {
 		if (nf_hook_egress_active()) {
@@ -4898,12 +4897,18 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 
 	reason = SKB_DROP_REASON_RECURSION_LIMIT;
 drop:
+#ifdef CONFIG_NET_XGRESS
+	bpf_net_ctx_clear(bpf_net_ctx);
+#endif
 	rcu_read_unlock_bh();
 
 	dev_core_stats_tx_dropped_inc(dev);
 	kfree_skb_list_reason(skb, reason);
 	return rc;
 out:
+#ifdef CONFIG_NET_XGRESS
+	bpf_net_ctx_clear(bpf_net_ctx);
+#endif
 	rcu_read_unlock_bh();
 	return rc;
 }
@@ -5815,6 +5820,9 @@ static __latent_entropy void net_tx_action(void)
 
 	if (sd->output_queue) {
 		struct Qdisc *head;
+#ifdef CONFIG_NET_XGRESS
+		struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
+#endif
 
 		local_irq_disable();
 		head = sd->output_queue;
@@ -5824,6 +5832,10 @@ static __latent_entropy void net_tx_action(void)
 
 		rcu_read_lock();
 
+#ifdef CONFIG_NET_XGRESS
+		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
+#endif
+
 		while (head) {
 			spinlock_t *root_lock = NULL;
 			struct sk_buff *to_free;
@@ -5860,6 +5872,10 @@ static __latent_entropy void net_tx_action(void)
 			tcf_kfree_skb_list(to_free, q, NULL, qdisc_dev(q));
 		}
 
+#ifdef CONFIG_NET_XGRESS
+		bpf_net_ctx_clear(bpf_net_ctx);
+#endif
+
 		rcu_read_unlock();
 	}
 
-- 
2.54.0

