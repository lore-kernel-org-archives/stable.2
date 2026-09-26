Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9143254707C
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 21:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790459329; cv=none; b=gigH9Qkle7XsKn9pSfKohkIR0Y4AXMCTasrGtaoj5Tou+Z2XGrGxRDqqgy5/4FC4jSwqP4fljvFRnSOAcNl2VyTeBltd8ecr4Ja/QkW7DiOIk3/bpJHlgM0KHsWfW0j3j6Kvnz87qO9mC4FCjPVeVjLD8iZDbchTnBvhnux/Ngg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790459329; c=relaxed/simple;
	bh=ltMzi6WSp1v1sPEAB0YuafeMHE6TDKR0i2K0CbEvpjY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MdwbF7CSUOndvbIM0MOEM2CrnXfU8/8S/+Cx+D4ex3U1E80EG9Z3txIPGmlZlXHdxXre0s5KrC7E4w/H5Suyzp0wX5dhfUab2S9a6DPeCZqr907FG0Ghn6Ul64kHY6hI5UZ2xs8xIjpvhpFHFK45nXqi8Kt4qNbZ6z7HuPbQ22Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=mmg5R3YS; arc=none smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="mmg5R3YS"
Received: by mail-yx2-f40.google.com with SMTP id 956f58d0204a3-67453dc240fso714721d50.1
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 14:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790459326; x=1791064126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XyQb/Kvi4xiTQoKBJXICuDhcx6oaxflcn/hQlo1w4JM=;
        b=mmg5R3YS0zzZ7rMfMYJo5GS6h4C6bRckXWGVeZcTkfD0ytV461ovsLVZmHDGTTtQd+
         I44kKQpV3Brs1JoPBKApc09dCtJOCTcjovRMGPUB4ErSdh9GG6MPktD9ZDp35c42ONPL
         Ucl/NwLqIb28R54YnIq/dPWiaBQn6yb5Z2QsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790459326; x=1791064126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XyQb/Kvi4xiTQoKBJXICuDhcx6oaxflcn/hQlo1w4JM=;
        b=eo+JqVdoFKfnvDraFLeN8UQWGtZEAKHXyUdujYn01bDjyocZykgMvScWp8yQKyouWp
         rLHxS6NtVa9G3hdZWx/Ps/p/5mo8XAONC9zNxY1c97f8LXb/QM5fphgdYOOGvEY2rOZl
         kCLIWKrC1mxzJJHR4yaH7RNPRnNLepSLTX4AHYed8FdVFIeAC19IpyTXbfdldQVjWoHn
         hdFvqCWASK7qfD8CsY2F69wrxjxNYeZvLOWKvWpCOqf8Pt+SCIHSzHlpSHY3D2htGo4C
         aKTYeyeEVDQD/pIiI59kcxxzt4Z03Cc353ViwUIYsMVivdXdzVbJcsolEqPqHwb1eFZx
         vqZA==
X-Forwarded-Encrypted: i=1; AKwUvBzoOj8a095+2A+46ezFoo2YNABgmpdS4K5WG+XEyMGR7iEUZRJoGKOp/oKqWbXkDger9yc55b4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdOtLitRU+z6wsM6jCf632sMd5XvBCnU1aahTjImBYbMxWtu6m
	jE5SGWHuSUq5SXic9R+9prywtBYuap6zDkFlkWjxSevRbNOsiMT2pQUDJTDOU1XJAA==
X-Gm-Gg: AYBFou0mmmmpGzEYyPSSsB5AWu6cQDRPrdnaz9Juvh714Mp0ZzxgQIL2Swe9/QcYO6J
	NadBjTiunYRfCx2w7w23596kV6XPg1Zl5CM58J9HFexh0hBjzqkAhNdvRahnLqJdjEjpVyRWskc
	IvlFUT03Ug6FH7rzg8WgHaG9YCowwxbqAE0SdNLb3Z7xnBJbyCJiwdWOkmruVZb0tj4fshP17R9
	j9PKY4WdiSCW7Gbfz8oihZPi8NtPA5UABz8IoxBgS8r5CKJOQm6j/lW5vajQjgku1Ak1Z6+86Tw
	u/GenFHURFtkkvwvD5YwQNXJ07W8OwedNcDEFPprLDzAZBb7X0Idmqv8UwKV4DNZp99aBNR5cTT
	cVwHheDJpVB/tpRW4TCZA4Fvs+yXOB1Kh9lQrZz0DVpdFRiIY1mTgBmF/J5QDVS+I96Qw974Wf/
	TA7jZhEYfRSGZZYMzszvbbt2TAXAxLPTYEKHvYhQnVS5DzopOm5S4TH97D+R7kahH5t+hMCjUV7
	nkHXFt4SEGCbUb5Mxhix4CbSQm0Cq5tUb/fjAvuTMxy6S/P/prCQfCPNj/C
X-Received: by 2002:a05:690e:b43:b0:674:118e:d32f with SMTP id 956f58d0204a3-674118f3307mr2036778d50.44.1790459326400;
        Sat, 26 Sep 2026 14:48:46 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6740ef2932dsm2543838d50.12.2026.09.26.14.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 14:48:45 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Simon Horman <horms@kernel.org>,
	Tonghao Zhang <xiangxia.m.yue@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Victor Nogueira <victor@mojatatu.com>,
	Zero Day Initiative <zdi-disclosures@trendmicro.com>,
	hybris <hybris@mojatatu.ai>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net v3] net: cap skb->queue_mapping when the tx queue is picked
Date: Sat, 26 Sep 2026 17:48:40 -0400
Message-Id: <QDISC-9R8V.v3.20260926072930@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skbedit can set skb->queue_mapping and raise the per-CPU skip_txqueue
flag so __dev_queue_xmit() honours the mapping. __dev_queue_xmit()
cleared the flag before sch_handle_egress() and only read it afterwards,
so the flag was not confined to the xmit that set it: a nested xmit
(mirred redirect or mirror, or a drop after skbedit) could set the flag
and the outer xmit would consume it for an skb that never went through
skbedit.

A forwarded packet still carries the ingress NIC's rx_queue + 1 in
skb->queue_mapping, so the outer device then indexes its tx queue state
with that stale value. Taprio's child array q->qdiscs[] is sized to the
device's queue count, so taprio_enqueue() indexes past its allocation
and dereferences the result as a struct Qdisc *.

Own the flag for the whole xmit frame: save the incoming value and clear
it before any of the frame's egress work can recurse, and restore it only
when the frame exits. A transmit-qdisc classifier is a documented flag
producer too (it runs in q->enqueue(), after sch_handle_egress()), so the
flag must be owned for the whole frame, not just around the clsact hook.
The flag then never crosses an xmit boundary in either direction. Also
store the value netdev_cap_txqueue() selected back into skb->queue_mapping
in netdev_tx_queue_mapping(), as netdev_core_pick_tx() already does, so
the skip_txqueue path never hands a later reader on the xmit path a
mapping the device cannot serve. A store made still later in the same
frame, by a tc BPF program attached to a transmit qdisc, is outside this
path and is not re-capped; a separate followup will resolve that path.

netdev_xmit_skip_txqueue() now returns the previous flag value so the
save-and-clear is one call, and a no-op stub is provided when
CONFIG_NET_EGRESS is disabled. This removes the inline #ifdef around the
save and the two restores.

A local user in a network namespace can redirect a packet from a device
with more TX queues to one with fewer after setting a mapping valid only
on the larger device. That reaches these reads and, under KASAN, faults
with "slab-out-of-bounds in taprio_enqueue".

Conditions to recreate the bug: with CONFIG_NET_SCH_TAPRIO=y,
CONFIG_NET_ACT_SKBEDIT=y, CONFIG_NET_ACT_MIRRED=y,
CONFIG_NET_CLS_MATCHALL=y, CONFIG_NET_SCH_PRIO=y and KASAN enabled,
create qa (3 queues), qb (2 queues) and qc (1 queue) as dummy devices;
put a taprio root on qb and clsact on all three; then add an egress
matchall filter on every device. On qa: "action skbedit queue_mapping 2
pipe action mirred egress redirect dev qb". On qb: "action mirred egress
mirror dev qc". On qc: "action skbedit queue_mapping 0 pipe". Send one
packet out qa. qc's skbedit sets the flag while qb's outer xmit is in
flight; without the fix qb consumes it and reads its two-entry taprio
child array with the forwarded packet's stale mapping. A qc whose skbedit
is instead installed in a transmit-qdisc classifier (a matchall filter on
the qc root qdisc) reaches the same code path the same way.

Testing: on a KASAN build with panic_on_warn=1 the unfixed kernel panics
with "BUG: KASAN: slab-out-of-bounds in taprio_enqueue", a read 0 bytes
past a 16-byte taprio_init() allocation; the fixed kernel runs the
clsact-setter and the transmit-qdisc-classifier reproducers with no report
and no clamp notice, and a clsact skbedit-then-tc-BPF store with no report
but the expected "selects TX queue" clamp notice from the write-back;

Fixes: 2f1e85b1aee4 ("net: sched: use queue_mapping to pick tx queue")
Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
Link: https://lore.kernel.org/netdev/CANn89iLwYx8nCVf0pCEk_MmEiyC6kQaMwCQT9WkQVeeNzNQHqQ@mail.gmail.com/
Link: https://lore.kernel.org/netdev/179008581937.2160803.7117814290574262942@kernel.org/
Link: https://lore.kernel.org/netdev/179033713973.2160803.4914570693994398206@kernel.org/
Link: https://lore.kernel.org/netdev/20260925180407.63647514@kernel.org/
Suggested-by: Eric Dumazet <edumazet@google.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Tested-by: hybris <hybris@mojatatu.ai>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v2 -> v3:
- netdev_xmit_skip_txqueue() returns the previous flag value, so the entry
  save-and-clear is one call; a no-op stub is provided when
  !CONFIG_NET_EGRESS, removing the three inline #ifdefs (Jakub Kicinski).
- Narrow the capability claim: the capped write-back covers the
  skip_txqueue path only; a store made later in the frame by a tc BPF
  program on a transmit qdisc is not re-capped and is a separate followup
  (nipa Sashiko).
- Comment: "per-CPU (per-task on PREEMPT_RT)" (nipa Sashiko).
- Drop the now-redundant #ifdef in act_skbedit.c.

v1 -> v2:
- Rework the root cause to the per-CPU skip_txqueue flag lifetime: it was
  cleared before sch_handle_egress() and read after, so a nested xmit could
  set it and the outer xmit consume it for an skb that never went through
  skbedit (Eric Dumazet, nipa Sashiko).
- Own the flag for the whole xmit frame: save/clear it before any of the
  frame's egress work can recurse, and restore it only when the frame exits.
- Retain the v1 producer-side cap (netdev_tx_queue_mapping() writes the
  clamped value back).
- Correct the description of the reproducer to a three-device chain
  (qa 3q -> qb 2q taprio -> qc 1q).

 include/linux/rtnetlink.h |  7 ++++++-
 net/core/dev.c            | 33 +++++++++++++++++++++++++++------
 net/sched/act_skbedit.c   |  2 --
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 95729339e7a5..a54ec40d095c 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -186,7 +186,12 @@ void net_dec_ingress_queue(void);
 #ifdef CONFIG_NET_EGRESS
 void net_inc_egress_queue(void);
 void net_dec_egress_queue(void);
-void netdev_xmit_skip_txqueue(bool skip);
+bool netdev_xmit_skip_txqueue(bool skip);
+#else
+static inline bool netdev_xmit_skip_txqueue(bool skip)
+{
+	return false;
+}
 #endif
 
 void rtnetlink_init(void);
diff --git a/net/core/dev.c b/net/core/dev.c
index f660fccfc0db..3b114fbf7015 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4404,9 +4404,14 @@ EXPORT_SYMBOL(dev_loopback_xmit);
 static struct netdev_queue *
 netdev_tx_queue_mapping(struct net_device *dev, struct sk_buff *skb)
 {
-	int qm = skb_get_queue_mapping(skb);
+	int queue = skb_get_queue_mapping(skb);
+	int capped;
 
-	return netdev_get_tx_queue(dev, netdev_cap_txqueue(dev, qm));
+	capped = netdev_cap_txqueue(dev, queue);
+	if (unlikely(capped != queue))
+		skb_set_queue_mapping(skb, capped);
+
+	return netdev_get_tx_queue(dev, capped);
 }
 
 #ifndef CONFIG_PREEMPT_RT
@@ -4415,9 +4420,13 @@ static bool netdev_xmit_txqueue_skipped(void)
 	return __this_cpu_read(softnet_data.xmit.skip_txqueue);
 }
 
-void netdev_xmit_skip_txqueue(bool skip)
+bool netdev_xmit_skip_txqueue(bool skip)
 {
+	bool prev = netdev_xmit_txqueue_skipped();
+
 	__this_cpu_write(softnet_data.xmit.skip_txqueue, skip);
+
+	return prev;
 }
 EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
 
@@ -4427,9 +4436,13 @@ static bool netdev_xmit_txqueue_skipped(void)
 	return current->net_xmit.skip_txqueue;
 }
 
-void netdev_xmit_skip_txqueue(bool skip)
+bool netdev_xmit_skip_txqueue(bool skip)
 {
+	bool prev = netdev_xmit_txqueue_skipped();
+
 	current->net_xmit.skip_txqueue = skip;
+
+	return prev;
 }
 EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
 #endif
@@ -4824,6 +4837,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 	int cpu, rc = -ENOMEM;
 	bool again = false;
 	struct Qdisc *q;
+	bool skip_txq;
 
 	skb_reset_mac_header(skb);
 	skb_assert_len(skb);
@@ -4846,6 +4860,13 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 	skb_update_prio(skb);
 
 	tcx_set_ingress(skb, false);
+	/* The flag is per-CPU (per-task on PREEMPT_RT) and a nested xmit can
+	 * set it from its own clsact hook or transmit qdisc. Own it for the
+	 * whole frame: this frame cannot consume a nested xmit's flag and a
+	 * nested xmit cannot inherit this frame's.
+	 */
+	skip_txq = netdev_xmit_skip_txqueue(false);
+
 #ifdef CONFIG_NET_EGRESS
 	if (static_branch_unlikely(&egress_needed_key)) {
 		if (nf_hook_egress_active()) {
@@ -4854,8 +4875,6 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 				goto out;
 		}
 
-		netdev_xmit_skip_txqueue(false);
-
 		nf_skip_egress(skb, true);
 		skb = sch_handle_egress(skb, &rc, dev);
 		if (!skb)
@@ -4952,12 +4971,14 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 
 	reason = SKB_DROP_REASON_RECURSION_LIMIT;
 drop:
+	netdev_xmit_skip_txqueue(skip_txq);
 	rcu_read_unlock_bh();
 
 	dev_core_stats_tx_dropped_inc(dev);
 	kfree_skb_list_reason(skb, reason);
 	return rc;
 out:
+	netdev_xmit_skip_txqueue(skip_txq);
 	rcu_read_unlock_bh();
 	return rc;
 }
diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
index bfec6b668410..9c1ade20c004 100644
--- a/net/sched/act_skbedit.c
+++ b/net/sched/act_skbedit.c
@@ -72,9 +72,7 @@ TC_INDIRECT_SCOPE int tcf_skbedit_act(struct sk_buff *skb,
 	}
 	if (params->flags & SKBEDIT_F_QUEUE_MAPPING &&
 	    skb->dev->real_num_tx_queues > params->queue_mapping) {
-#ifdef CONFIG_NET_EGRESS
 		netdev_xmit_skip_txqueue(true);
-#endif
 		skb_set_queue_mapping(skb, tcf_skbedit_hash(params, skb));
 	}
 	if (params->flags & SKBEDIT_F_MARK) {
-- 
2.43.0

