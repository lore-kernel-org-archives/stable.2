Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C546443AAB
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 11:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790250562; cv=none; b=oRpGn8tLceUDMc7TnVzgc6Gmkm3xMNnHZ+mjZwZQ/Q5wptmLx+kHdlgwmKEOPriymO9P2xu2PRFvsiWupqPbYAEgDsjSOP0xwjPF8hJKpN+Q1LYTVVchRUSwvT1tu6+Rjo0Zmrj2xkQAEEqEfRM2ecxQNDziqIJyy+9JF1uuzh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790250562; c=relaxed/simple;
	bh=GX/IG1l8s+2W7sIl+1ffAAioTI5PgJWOHPAvRQXCEkM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q82WJhzKXxOT2LGRuEpwZ6H9MRKM57XzT6j9kfME2Znd855/oZQhgds2/ZKsMOVFvp4+sMhcT3ttleHSQgHWldfgntbf0OegTr2FVbq7yM6lioOGTos0ppNN/dU4kBS1gtyB75hMNi9tAKso+gD0EEt+/7+jbQev8qhbU0+ZMx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=wc4bZxxW; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="wc4bZxxW"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc9b6e3so18837706d6.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 04:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790250559; x=1790855359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tXmzit9J6X6Kx8j00B92G7Rr7CR+3tTI5ONv9mj0xqM=;
        b=wc4bZxxWwk55gJ3Ll3lBiJmds0Oj1zslepztrwZibANVwa4Jzha+AOEQz7gNXk3Zey
         kLsz1PgM4zplcb+jn9MOBIZVrKcQ3fibYBt/h8SZFazkEIIOzfZwhEmGd4ZJXDe1HHTR
         c1Z2BiErhvC4ISnm6f2mYdrvZG3wJEYwaH0SE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790250559; x=1790855359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tXmzit9J6X6Kx8j00B92G7Rr7CR+3tTI5ONv9mj0xqM=;
        b=e0HcrNRQOv1nWJK1vuq6QXu2j/eX2Xv/P+YXOtFl4fOaG8J+NCYnCDGpYtG9Azc/Hz
         V13lWUgjVqI7TzzZ+bkWxfA1EH8T7Qc8jDeTsXazUgqE115eIoaT4AOkfc5mjhdLfweY
         fTzcJCw2Rc7gVQxLW9pwWC9NeFZnGPoJ2cpr/OBFjkpGd5XXh7BCW2RNzDhPHbtdxkvY
         u7wA77GFGtpc6UHGcyK2ujJW07llgzHR+m9wbjZpvSk30jyoNN1dv5TAiye8JYVHrDGo
         aV+GwzAZn0vMBQATxic7Us89rJt2qoCO6IXTbvjKKJQjd2HYDEuUPMHpwhk3ef3o7zr6
         /RuQ==
X-Forwarded-Encrypted: i=1; AKwUvBzcb/OmVJikLBfvTdnSR17V3sPfTcL9cduH5ua4hEW0bxsdR6tQUsJHQrdnuU8db7WVWNsv2V0=@vger.kernel.org
X-Gm-Message-State: AFuF++nx607VgcSLEA1fkLflFa/TO6KQfY2vxW2+6p/iivMPRL4WPfmC
	1AdjA/S0p6W3UZed7uswIWVy2osLZTHASYmZE1ICCHOkmWS1O3R9UdRH56+tvtQXaA==
X-Gm-Gg: AYBFou2u0Nq2h+ofbntvX/spOeqShtFcEQEIP7QzBqf68RhbHEuwS5zY619fxwIivG0
	fKFviLl2Ly/H0cNwRl5vfc6Lir6Fx1kZJRxhSMlmOXLqkPwOQLdF7/XpjJPLmDLrS1d8nG2rCEw
	TjCdsfOeejH+77H9uSMO3sS8zHqfNGkMAiCGDBXF7MKK3BtDtlH3QRgFgxO/mLFBTYI1QMAMmXo
	Co86C80biOL7iyOhmPWK9I0xrAG6S9NDOksxtac1/lBPwDpe2PJW5munz/4+mGk2S3ybsb8VMgE
	Sfusg2RNEY3r6S2jJyUgmMFFpZy298A14EJLMCqP22EkvyDYv8zlXY0l0m1b+Lg2LfrlQwA5itS
	YRI1TxaHMJt3FyNJZcIHDthbMBsoOWjlL43322cEsoD93hGVEzSOfqrdQjEN0d0Xj2Ncs8YNd/5
	LvQaLIBzmDJvZ8wtriNy+D4r4uRaTllapE860l19kCzXDkhZATX1hL4p39+XaCNa7wdwkaR+t7x
	z/QXbzYkwSu/JnanF5gWY4JeSH5ybNd0Fld8yFLyw1OLMN+Rg==
X-Received: by 2002:a05:620a:4084:b0:939:6dfc:8abd with SMTP id af79cd13be357-93c36402f37mr241886585a.52.1790250558748;
        Thu, 24 Sep 2026 04:49:18 -0700 (PDT)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9141e0d3746sm15111276d6.6.2026.09.24.04.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 04:49:18 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Simon Horman <horms@kernel.org>,
	Tonghao Zhang <xiangxia.m.yue@gmail.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Zero Day Initiative <zdi-disclosures@trendmicro.com>,
	hybris <hybris@mojatatu.ai>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: cap skb->queue_mapping when the tx queue is picked
Date: Thu, 24 Sep 2026 07:49:06 -0400
Message-Id: <QDISC-9R8V.v2.20260924072708@mojatatu.com>
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
in netdev_tx_queue_mapping(), as netdev_core_pick_tx() already does, so a
mapping rewritten later in the same egress run (for example a tc BPF
store) cannot leave an out-of-range index for the later readers on the
xmit path.

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
the qc root qdisc) reaches the same read the same way.

Testing: on a KASAN build with panic_on_warn=1 the unfixed kernel panics
with "BUG: KASAN: slab-out-of-bounds in taprio_enqueue", a read 0 bytes
past a 16-byte taprio_init() allocation; the fixed kernel runs both the
clsact-setter and the transmit-qdisc-classifier reproducers with no report
and no clamp notice, and the taprio/multiq/matchall/skbedit/mirred tdc
tests pass (117 ok, 0 fail).

Fixes: 2f1e85b1aee4 ("net: sched: use queue_mapping to pick tx queue")
Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
Link: https://lore.kernel.org/netdev/CANn89iLwYx8nCVf0pCEk_MmEiyC6kQaMwCQT9WkQVeeNzNQHqQ@mail.gmail.com/
Link: https://lore.kernel.org/netdev/179008581937.2160803.7117814290574262942@kernel.org/
Suggested-by: Eric Dumazet <edumazet@google.com>
Tested-by: hybris <hybris@mojatatu.ai>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v1 -> v2:
- Rework the root cause to the per-CPU skip_txqueue flag lifetime: it was
  cleared before sch_handle_egress() and read after, so a nested xmit could
  set it and the outer xmit consume it for an skb that never went through
  skbedit (Eric Dumazet, nipa Sashiko).
- Own the flag for the whole xmit frame: save/clear it before any of the
  frame's egress work can recurse, and restore it only when the frame exits.
- Retain the v1 producer-side cap (netdev_tx_queue_mapping() writes the
  clamped value back), covering the residual in-frame rewrite nipa
  identified (e.g. a tc BPF store).
- Correct the description of the reproducer to a three-device chain
  (qa 3q -> qb 2q taprio -> qc 1q);

 net/core/dev.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 0292a16e16c2..e72a5c6dc63a 100644
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
@@ -4824,6 +4829,9 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 	int cpu, rc = -ENOMEM;
 	bool again = false;
 	struct Qdisc *q;
+#ifdef CONFIG_NET_EGRESS
+	bool skip_txq;
+#endif
 
 	skb_reset_mac_header(skb);
 	skb_assert_len(skb);
@@ -4847,6 +4855,14 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 
 	tcx_set_ingress(skb, false);
 #ifdef CONFIG_NET_EGRESS
+	/* The flag is per-CPU and a nested xmit can set it from its own
+	 * clsact hook or transmit qdisc. Own it for the whole frame: this
+	 * frame cannot consume a nested xmit's flag and a nested xmit
+	 * cannot inherit this frame's.
+	 */
+	skip_txq = netdev_xmit_txqueue_skipped();
+	netdev_xmit_skip_txqueue(false);
+
 	if (static_branch_unlikely(&egress_needed_key)) {
 		if (nf_hook_egress_active()) {
 			skb = nf_hook_egress(skb, &rc, dev);
@@ -4854,8 +4870,6 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 				goto out;
 		}
 
-		netdev_xmit_skip_txqueue(false);
-
 		nf_skip_egress(skb, true);
 		skb = sch_handle_egress(skb, &rc, dev);
 		if (!skb)
@@ -4952,12 +4966,18 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 
 	reason = SKB_DROP_REASON_RECURSION_LIMIT;
 drop:
+#ifdef CONFIG_NET_EGRESS
+	netdev_xmit_skip_txqueue(skip_txq);
+#endif
 	rcu_read_unlock_bh();
 
 	dev_core_stats_tx_dropped_inc(dev);
 	kfree_skb_list_reason(skb, reason);
 	return rc;
 out:
+#ifdef CONFIG_NET_EGRESS
+	netdev_xmit_skip_txqueue(skip_txq);
+#endif
 	rcu_read_unlock_bh();
 	return rc;
 }
-- 
2.43.0

