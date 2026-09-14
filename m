Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2873E4C90
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789373225; cv=none; b=fQuwfiGp3hl0FmFu8cTXTm5l2nd2LD22tZUrD1Ianxpqen+z2VvUsBSKu2APweNpLZlsiviq84nchQY6nCZ75BvzsJCJQn+qx0QvBMqB7HdXsdeAHkUu8Sf3R9Vk0LJLzqyCDnYIy2j4OFL+0eQkQCMbfj5/ZTy2CSAnxhz7Hvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789373225; c=relaxed/simple;
	bh=0rpz5RcfyLg/UdQ9j0n/J8aYvsCqteq/E6T+2rgP4EI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=egOqtRGcnzac46dSs0lDAYLHjPYmqgvYWK++Zf4ApRLcn2CpdSoIuZPDRs86ZdmJNVJTT9RC7hDTpg0o56SM19APiuYtoJqbPNzUa5j1VUV80OplCQcxIymODXdq1zK7Kheret9t//Ma/KGCzK4u5ZY9nIhMQRpPFoawGzAoGqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=nHvPkgvw; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="nHvPkgvw"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc6db0aso24277736d6.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 01:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789373221; x=1789978021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7pT3kEPEgpbWBj+9NNyMg+ukyMM8ao5jiiq0DN4Mn8A=;
        b=nHvPkgvwrtg/l3l6ShWepyXGQ6YfbIJp4dhIHLL2SvZ8ZKxfTBGmrpId9NDQSSJ0v1
         Zv8eOSra/j0lpOS0PRINQs4b8E9wZAm1B7Dq+kFidJNNdNpYuCBiOck3oN7BC4UAflUi
         KUseDPT8LQbl8QUs0IVjNqibXsycNqRAYt87Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789373221; x=1789978021;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7pT3kEPEgpbWBj+9NNyMg+ukyMM8ao5jiiq0DN4Mn8A=;
        b=DPSD/sm5cQDKAlNG/Mw8AnPSSTt5eyF30u1pUwBS4Xs0R6heCThL0CMhb0MAW46nRW
         h7IjtOcoq8oXK6L8xmpby/wB1+zAVeiSkQaAEgF2xID63Te4q8C+NSeLz5va+awKx8xS
         TkBPgJSW78r3bzfVvDSBdlww0jvNmN75Ka4MViRoe7P9Im/bf+CwNkB3L5Od47N16ULd
         yvWNgO+wKpcEckKcX8TEIKihtKoF/5QZ/Awwu0bC665Alaa6h05ZEjRMRKixNFUe1YwZ
         L3RHbga+naQpgnxk8Shy5RanW8QCi+KeYS20EpVj4xeqOTvOC6wVfByJp/ji4/9Z7ykA
         iiuQ==
X-Forwarded-Encrypted: i=1; AKwUvBz5cV86X6RX1TRZRjAToKHjzgQUxizl3Y1PCWNlr8Tgl8DD1x7dUNpmLj6bGV9WHOnN9y+LC2I=@vger.kernel.org
X-Gm-Message-State: AFuF++lxog1OzMWlYpkdPwV3sbAxxizyQdWCucV8rkcvGYV4e3iBHvYP
	sDoFAbIGO6o+HH9VxIET5b4O+IgjOi7EBTF4y8SWxo/enzM+Xpg9HyXiT9sDocxOqQ==
X-Gm-Gg: AYBFou1kl5NTOn0LoPWEfHLRVCN3itIRGg9ULY/sk3yhIoKqisIgbduaMxvsSkNluAA
	EnlCox10Uc4hh3ix6jtxVrlWbxWGntEwHQdyjfit7YeI65r4JYeXWJDItOSik7MN2ffBZZ3wX6P
	Muo84ujmeUN8VwV8iVRjbS4o8Nx9HsJ/B6QgM8HIa4turkKo31MOZzAreGVViZh7bEC8GRI+93q
	CGkH/iRqDCVmSpRBOvOhZyZDCAR/7NL9ATLtHe1vAqMp6wcPmgWktXU2/ABMjwklhtBKrLFzqIT
	etHTDuLSWkfgD9euwI67fWZmW+rB2O8dPH5AZdzY2DANTk/kEd8iFhVrCsXNXqdUhFNL6bWqWjh
	QKPedq/jrqqgz2g7BW7JAAMrA1lj+8cfELyTb+LI4y+H1CN45SuKSGpSuReZSsSwNDkWTfPlalB
	ieWNPAOGW8cqk0cR0M/qlltet2CD7tYD9/pQzdXrqQ7pQJlTDh4s9vhaNMdCY5lupu1z69Bxjzy
	xXrmECEjT4x/APlAK4gd0KNfsaVR/NiOjgIijOWsxWCtaJ4d/c8dhl4xXMPnYgQl13nZeONwifF
	1ESroR4TSrJa2UYRzIns5x8=
X-Received: by 2002:a05:6214:1945:b0:910:34c8:ac46 with SMTP id 6a1803df08f44-9122e657768mr23016236d6.25.1789373221522;
        Mon, 14 Sep 2026 01:07:01 -0700 (PDT)
Received: from majuu.waya (pool-174-112-106-84.cpe.net.cable.rogers.com. [174.112.106.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4d51ffsm90187336d6.45.2026.09.14.01.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 01:07:01 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	Sashiko <sashiko-bot@kernel.org>,
	hybris <hybris@mojatatu.ai>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] net/sched: sch_hfsc: bound the classify inner-filter walk with a drift budget
Date: Mon, 14 Sep 2026 04:06:55 -0400
Message-Id: <QDISC-CTUU.v2.20260913192614@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hfsc_classify() applies the "filter may only point downwards" level
check only when the filter result carries no bound class. A filter
created with a flowid gets res.class set once at bind time, so the
check never runs for it during classification. hfsc_adjust_levels() can
later raise a class's level without revalidating existing bindings,
leaving two binds that were each legal at bind time pointing at each
other; the classify walk then bounces between two interior classes
forever with the qdisc lock held and BH disabled — a soft lockup from a
single packet.

Bound the traversal, mirroring HTB: count only the non-descending hops,
which a legitimate walked tree can only take by level drift after bind
time; anything beyond a small budget is a cycle.
Drop the packet with a rate-limited warning when the budget is
exhausted. Descending hops never consume budget, so legitimately deep
trees are unaffected, and a terminating lateral chain (the level-drift
false-positive family) still classifies normally.

Conditions to recreate the bug:
- CONFIG_NET_SCHED, CONFIG_NET_SCH_HFSC, CONFIG_NET_CLS_U32,
  CONFIG_LOCKUP_DETECTOR.
- Build a cycle with two legal-at-bind-time flowid binds and a level
  drift: class X 1:1 (child of root) with leaf child 1:10; class Y 1:2
  (sibling of X) with children 1:20 and 1:200; root u32 filter flowid
  1:1; filter on X flowid 1:2 (legal when Y is a leaf); after Y's level
  rises to 2, filter on Y flowid 1:1 (legal then). Send one packet (ping
  on the device). Unfixed kernel: classify spins with the qdisc lock
  held; with softlockup_panic=1 it panics.
- Reachable from unprivileged user via unshare -Urn (CAP_NET_ADMIN).

Fixes: a2f79227138c ("net_sched: sch_hfsc: fix classification loops")
Reported-by: Sashiko (gemini + nipa) <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/QDISC-CTUU.v1.20260908094501@mojatatu.com
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Tested-by: hybris <hybris@mojatatu.ai>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v2 changes:
   -  Replace the absolute hop bound (root->level) with a budget that
      counts only non-descending hops, so a legal lateral level
      chain still classifies. (Sashiko)
   -  Reword the "strict descent" changelog claim (Sashiko).

 net/sched/sch_hfsc.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index e87f5021a199..b073efaf2bf5 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -386,6 +386,12 @@ cftree_update(struct hfsc_class *cl)
 #define	SM_MASK		((1ULL << SM_SHIFT) - 1)
 #define	ISM_MASK	((1ULL << ISM_SHIFT) - 1)
 
+/*
+ * bound on consecutive non-descending (lateral / upward) hops in a
+ * classify walk, mirroring htb's TC_HTB_MAXDEPTH headroom
+ */
+#define	HFSC_CLASSIFY_MAX_DRIFT	8
+
 static inline u64
 seg_x2y(u64 x, u64 sm)
 {
@@ -1133,6 +1139,7 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 	struct hfsc_class *head, *cl;
 	struct tcf_result res;
 	struct tcf_proto *tcf;
+	unsigned int drift;
 	int result;
 
 	if (TC_H_MAJ(skb->priority ^ sch->handle) == 0 &&
@@ -1142,6 +1149,7 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	head = &q->root;
+	drift = HFSC_CLASSIFY_MAX_DRIFT;
 	tcf = rcu_dereference_bh(q->root.filter_list);
 	while (tcf && (result = tcf_classify_qdisc(skb, tcf, &res, false)) >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
@@ -1167,6 +1175,16 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 		if (cl->level == 0)
 			return cl; /* hit leaf class */
 
+		/*
+		 * flowid binds skip the level check above (res.class is set
+		 * at bind time and levels drift after), so a walk can follow
+		 * lateral hops without descending; bound them here.
+		 */
+		if (cl->level >= head->level && drift-- == 0) {
+			pr_warn_ratelimited("hfsc: classify loop detected, dropping packet\n");
+			return NULL;
+		}
+
 		/* apply inner filter chain */
 		tcf = rcu_dereference_bh(cl->filter_list);
 		head = cl;
-- 
2.43.0

