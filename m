Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E353FBEC6
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782728538; cv=none; b=GUSqCCoESp6S2tKOUpo2CNCR94cJQS2Fa5dA1I9pc1a6ETVFtunTNMT8ytkJthS6OMbRKsydD2Qdw/XyQsfKlHJ58yU+kb6IUGr993TfVbP1MHlgmB8Ccp3I+ZQkpKq3yE+LV+xeee1/UGZKRzM5vKyE3BJYo0fXhQNlJjsXH+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782728538; c=relaxed/simple;
	bh=xRnw7242z9WbMB6XdZLIajDiBJC82CJfwz1kTnEwOQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l3rAOg9DB8RxFpgXPQqj73EsnChb9ZbHzECcFjTaqzYjbQvHXvJulO3O0obzsphOVyh8/LY9LUosv1zsAzov4FMZNOpvZCWiCbjmCX57j2pEoR99Ws95Vk3wJszPRU519rNoYUy+lb3u5SiOGqOLvHuTzilNDPn7HT8/NWYuPWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=UlpdHP8E; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="UlpdHP8E"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e5b048375so28050985a.1
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 03:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782728535; x=1783333335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eHozVOxctx8ZnBOZ6mIPq3LTpcSDR+UEeGb+/4LThc=;
        b=UlpdHP8EaNz8zXxPwSb8o4lpvsnSW5Gg9QsxPPv2t583GPbW3OBpMdJgmmyfuiHhvI
         Hn7r8yVuTHvbEs5dltimoE81LORxP9u2MA144HRBIvDhjryuVV7U8E7UkC6825pMI3Vn
         9KmIBb6RF3Zy/aViGESCCLfdIfP9xQ8CtjEGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782728535; x=1783333335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9eHozVOxctx8ZnBOZ6mIPq3LTpcSDR+UEeGb+/4LThc=;
        b=MN7abOEWZfsc0eOxHwEcAiw/VCxIZQFv/2kADXQ445A5vIHKvFCzmnvzSNjIpJdqR7
         9G06RiqztaQj/gQDG2GxFDJ3Sl52SN1Lr8S7A6V+LHHVvK89XAxgtU6VTu9fZIwA1hRG
         WDM+i5MUtaVuwN0hf8AQ7MowwEn2bylmJ9eSO16U2DSDOFxBqbStLZpyjTXbzg9h+4tj
         iPN1vcAA9hoCXvyM2+V3g/G+Zso1g0vku+MuCyW2bjmsT2v95RSKjYUgwvxFRfKclgx0
         aC9MbBwJN5KItmBmzkGaXtc1V3cwW2mV0BVw3Teb35pQDxlu5dGjmLwvir6DNWUGAqvO
         tU1g==
X-Forwarded-Encrypted: i=1; AFNElJ+4VpICwnvD5ouNwnjlylOrcmAjd5Y8m0BVG/ciyKO6+VSQR5SVki0u0k/5DvaP8RYScqHZAiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVPynMU6fd9XV8TMqdKKk3seB+OGKzYRwtgdjFxCSMirMAStAN
	qmjk3GRuzPSLzjtUSvLdOWQ2TzbJ5F2xhTw+5hnePwsF7F9mc7/B6nM1gf5/CPGSGQ==
X-Gm-Gg: AfdE7cnzu6pcAnqdHnyoC3o5IImJomA1qWKG2V6tdopaosURH3PveGxpxqgijt0/vA5
	Ra751G2NUbjhxpiUSpTLyeedBgf7llu/ZyFLY/oIx0+dLu9fw76AwXbtTKzREsk5J1SjdkgI4bM
	nwzb6CXvkKs49rdgAf7EY02NChvQ7APrh6W4LHyOqSGoPUlSjQY3iHpSu1ZNNFxnIW5kqYT1hpS
	rIWvXGEB6USbnM/gZ04vXyOaj89wHyWygwUDP6oeah1hoXetS401MixzADzl80fN7N+iPeRV0iQ
	akoSMJ4FAQwG5/Ggle/nNNoMglIgKFgmJcGydf2bkJMq/3hCMeRskON8BAFPS5DWROAqE4udZko
	2T01ssYktqtEBjIv6EjQHOcJgYM81Yp6cWZW7D08rWr6tFgrTPZoKTz7hrmdjvYrJnciH7+HH1Z
	xqmob5pA==
X-Received: by 2002:a05:620a:8811:b0:92e:4613:5b0b with SMTP id af79cd13be357-92e5f3e9a4fmr15169185a.68.1782728535288;
        Mon, 29 Jun 2026 03:22:15 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ef0f2b9df0sm53589236d6.13.2026.06.29.03.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 03:22:14 -0700 (PDT)
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
Subject: [PATCH net 2/3 v2] net/sched: Handle TC_ACT_REDIRECT from qdisc filter chains
Date: Mon, 29 Jun 2026 06:21:56 -0400
Message-Id: <20260629102157.737306-3-jhs@mojatatu.com>
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

When a TC filter attached to a qdisc filter chain returns
TC_ACT_REDIRECT (ex: via an eBPF program calling bpf_redirect() or an
act_bpf action), the redirect was silently lost i.e no qdisc classify
function handled TC_ACT_REDIRECT, so the packet fell through the
switch and was enqueued normally instead of being redirected.

This has been broken since bpf_redirect() was introduced for TC in
commit 27b29f63058d ("bpf: add bpf_redirect() helper"). We got lucky
for a long time because bpf_net_context was a per-CPU variable that
was always available.
commit 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
turned bpf_net_context into a task_struct member that is only set up by
explicit callers. Without a caller setting it up, bpf_redirect() itself
crashes with a NULL pointer dereference in bpf_net_ctx_get_ri().

The NULL deref is fixed separately by extending the bpf_net_context
lifetime to cover qdisc enqueue. However, even with bpf_net_context
available, TC_ACT_REDIRECT from qdisc filter chains cannot be honored
without adding skb_do_redirect() calls to every qdisc classify
function, which would require changes across net/sched/. Isolate it
to ebpf core where it belongs.

Instead, add a tcf_classify_qdisc() inline helper in pkt_cls.h, as a
wrapper around tcf_classify() for use by qdisc classify functions and
tcf_qevent_handle(). When the classify verdict is TC_ACT_REDIRECT,
the wrapper converts it to TC_ACT_SHOT, dropping the packet rather
than letting it continue silently. Dropping is preferred over
letting the packet through because the user immediately sees packet
loss and, with the help of the rate-limited warning in the log
("use eBPF with clsact or mirred redirect instead"), can quickly
identify and fix the misconfiguration. Silently passing the packet
through would hide the problem and leave the user wondering why their
redirect is not working.

The clsact fast path, tc_run() continues to call tcf_classify() directly
and is unaffected: TC_ACT_REDIRECT is returned as-is and handled by
sch_handle_egress/ingress() calling skb_do_redirect() as before.

Also (to emphasize again to Sashiko):
Remove the TC_ACT_REDIRECT case from tcf_qevent_handle() as well.
skb_do_redirect() belongs in the BPF plumbing layer (net/core/), not
in net/sched/. The case was never consistent with the rest of the qdisc
classification infrastructure, where no classify function handles
TC_ACT_REDIRECT. It appears to have been a cut-and-paste artifact from
the qevent introduction rather than a deliberate design decision.

Fixes: 27b29f63058d ("bpf: add bpf_redirect() helper")
Fixes: 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/pkt_cls.h    | 13 +++++++++++++
 net/sched/cls_api.c      |  6 +-----
 net/sched/sch_cake.c     |  2 +-
 net/sched/sch_drr.c      |  2 +-
 net/sched/sch_dualpi2.c  |  2 +-
 net/sched/sch_ets.c      |  2 +-
 net/sched/sch_fq_codel.c |  2 +-
 net/sched/sch_fq_pie.c   |  2 +-
 net/sched/sch_hfsc.c     |  2 +-
 net/sched/sch_htb.c      |  2 +-
 net/sched/sch_multiq.c   |  2 +-
 net/sched/sch_prio.c     |  2 +-
 net/sched/sch_qfq.c      |  2 +-
 net/sched/sch_sfb.c      |  2 +-
 net/sched/sch_sfq.c      |  2 +-
 15 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index 3bd08d7f39c1..3a542a72e9a5 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -159,6 +159,19 @@ static inline int tcf_classify(struct sk_buff *skb,
 
 #endif
 
+static inline int tcf_classify_qdisc(struct sk_buff *skb,
+				     const struct tcf_proto *tp,
+				     struct tcf_result *res, bool compat_mode)
+{
+	int ret = tcf_classify(skb, NULL, tp, res, compat_mode);
+
+	if (unlikely(ret == TC_ACT_REDIRECT)) {
+		pr_warn_once("TC_ACT_REDIRECT from qdisc filter chains is not supported; use eBPF with clsact or mirred redirect instead\n");
+		ret = TC_ACT_SHOT;
+	}
+	return ret;
+}
+
 static inline unsigned long
 __cls_set_class(unsigned long *clp, unsigned long cl)
 {
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 3e67600a4a1a..3ca56d060e28 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -4033,7 +4033,7 @@ struct sk_buff *tcf_qevent_handle(struct tcf_qevent *qe, struct Qdisc *sch, stru
 
 	fl = rcu_dereference_bh(qe->filter_chain);
 
-	switch (tcf_classify(skb, NULL, fl, &cl_res, false)) {
+	switch (tcf_classify_qdisc(skb, fl, &cl_res, false)) {
 	case TC_ACT_SHOT:
 		qdisc_qstats_drop(sch);
 		__qdisc_drop(skb, to_free);
@@ -4045,10 +4045,6 @@ struct sk_buff *tcf_qevent_handle(struct tcf_qevent *qe, struct Qdisc *sch, stru
 		__qdisc_drop(skb, to_free);
 		*ret = __NET_XMIT_STOLEN;
 		return NULL;
-	case TC_ACT_REDIRECT:
-		skb_do_redirect(skb);
-		*ret = __NET_XMIT_STOLEN;
-		return NULL;
 	case TC_ACT_CONSUMED:
 		*ret = __NET_XMIT_STOLEN;
 		return NULL;
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index a3c185505afc..94eb47ac54ee 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1730,7 +1730,7 @@ static u32 cake_classify(struct Qdisc *sch, struct cake_tin_data **t,
 		goto hash;
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-	result = tcf_classify(skb, NULL, filter, &res, false);
+	result = tcf_classify_qdisc(skb, filter, &res, false);
 
 	if (result >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 020657f959b5..91b1ef824afa 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -312,7 +312,7 @@ static struct drr_class *drr_classify(struct sk_buff *skb, struct Qdisc *sch,
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	fl = rcu_dereference_bh(q->filter_list);
-	result = tcf_classify(skb, NULL, fl, &res, false);
+	result = tcf_classify_qdisc(skb, fl, &res, false);
 	if (result >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 5434df6ca8ef..98364f74211e 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -364,7 +364,7 @@ static int dualpi2_skb_classify(struct dualpi2_sched_data *q,
 		return NET_XMIT_SUCCESS;
 	}
 
-	result = tcf_classify(skb, NULL, fl, &res, false);
+	result = tcf_classify_qdisc(skb, fl, &res, false);
 	if (result >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index cb8cf437ce87..25fcf4079fec 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -391,7 +391,7 @@ static struct ets_class *ets_classify(struct sk_buff *skb, struct Qdisc *sch,
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	if (TC_H_MAJ(skb->priority) != sch->handle) {
 		fl = rcu_dereference_bh(q->filter_list);
-		err = tcf_classify(skb, NULL, fl, &res, false);
+		err = tcf_classify_qdisc(skb, fl, &res, false);
 #ifdef CONFIG_NET_CLS_ACT
 		switch (err) {
 		case TC_ACT_STOLEN:
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index cafd1f943d99..6cce86ba383c 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -91,7 +91,7 @@ static unsigned int fq_codel_classify(struct sk_buff *skb, struct Qdisc *sch,
 		return fq_codel_hash(q, skb) + 1;
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-	result = tcf_classify(skb, NULL, filter, &res, false);
+	result = tcf_classify_qdisc(skb, filter, &res, false);
 	if (result >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 72f48fa4010b..069e1facd413 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -96,7 +96,7 @@ static unsigned int fq_pie_classify(struct sk_buff *skb, struct Qdisc *sch,
 		return fq_pie_hash(q, skb) + 1;
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-	result = tcf_classify(skb, NULL, filter, &res, false);
+	result = tcf_classify_qdisc(skb, filter, &res, false);
 	if (result >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 7e537295b8b6..e87f5021a199 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1143,7 +1143,7 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	head = &q->root;
 	tcf = rcu_dereference_bh(q->root.filter_list);
-	while (tcf && (result = tcf_classify(skb, NULL, tcf, &res, false)) >= 0) {
+	while (tcf && (result = tcf_classify_qdisc(skb, tcf, &res, false)) >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
 		case TC_ACT_QUEUED:
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 908b9ba9ba2e..fdac0dc8f35a 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -243,7 +243,7 @@ static struct htb_class *htb_classify(struct sk_buff *skb, struct Qdisc *sch,
 	}
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-	while (tcf && (result = tcf_classify(skb, NULL, tcf, &res, false)) >= 0) {
+	while (tcf && (result = tcf_classify_qdisc(skb, tcf, &res, false)) >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
 		case TC_ACT_QUEUED:
diff --git a/net/sched/sch_multiq.c b/net/sched/sch_multiq.c
index 4e465d11e3d7..004f0d275caf 100644
--- a/net/sched/sch_multiq.c
+++ b/net/sched/sch_multiq.c
@@ -36,7 +36,7 @@ multiq_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 	int err;
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-	err = tcf_classify(skb, NULL, fl, &res, false);
+	err = tcf_classify_qdisc(skb, fl, &res, false);
 #ifdef CONFIG_NET_CLS_ACT
 	switch (err) {
 	case TC_ACT_STOLEN:
diff --git a/net/sched/sch_prio.c b/net/sched/sch_prio.c
index e4dd56a89072..79437c587e7e 100644
--- a/net/sched/sch_prio.c
+++ b/net/sched/sch_prio.c
@@ -39,7 +39,7 @@ prio_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	if (TC_H_MAJ(skb->priority) != sch->handle) {
 		fl = rcu_dereference_bh(q->filter_list);
-		err = tcf_classify(skb, NULL, fl, &res, false);
+		err = tcf_classify_qdisc(skb, fl, &res, false);
 #ifdef CONFIG_NET_CLS_ACT
 		switch (err) {
 		case TC_ACT_STOLEN:
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index cb56787e1d25..6f3b7273cb16 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -709,7 +709,7 @@ static struct qfq_class *qfq_classify(struct sk_buff *skb, struct Qdisc *sch,
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	fl = rcu_dereference_bh(q->filter_list);
-	result = tcf_classify(skb, NULL, fl, &res, false);
+	result = tcf_classify_qdisc(skb, fl, &res, false);
 	if (result >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
diff --git a/net/sched/sch_sfb.c b/net/sched/sch_sfb.c
index b1d465094276..ed39869199c0 100644
--- a/net/sched/sch_sfb.c
+++ b/net/sched/sch_sfb.c
@@ -260,7 +260,7 @@ static bool sfb_classify(struct sk_buff *skb, struct tcf_proto *fl,
 	struct tcf_result res;
 	int result;
 
-	result = tcf_classify(skb, NULL, fl, &res, false);
+	result = tcf_classify_qdisc(skb, fl, &res, false);
 	if (result >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 758b88f21865..77675f9a4c46 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -171,7 +171,7 @@ static unsigned int sfq_classify(struct sk_buff *skb, struct Qdisc *sch,
 		return sfq_hash(q, skb) + 1;
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-	result = tcf_classify(skb, NULL, fl, &res, false);
+	result = tcf_classify_qdisc(skb, fl, &res, false);
 	if (result >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
-- 
2.54.0

