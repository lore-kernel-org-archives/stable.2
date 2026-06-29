Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EB93FD946;
	Mon, 29 Jun 2026 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738101; cv=none; b=cahiyQC3BP+MC0KCFG5z2vJtdWMCBZ8TSmOvMRJ63bivSj6A6xON1qhseYtOvPP9zF+NV6vBUn2raBlx2Qo/dZ7fp/itZo3z1L+DL8zk3/rKsM3tA4U8ld+iDMdoU+DtHtkrzTFFVIgE/b15SgPSCC5aGHlzzrhSyspXjDr3TuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738101; c=relaxed/simple;
	bh=bpbtBvlcDoN/HUXWGBa+zYVTojN7b5hrzQ8YZBVMGvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJoUYgF/6yHZe9pFiXiVqoKq7ctYH136+y20YOSc/ItD167tQrX79gZo2SBLDK1D0g3eCg+Jyd8oPZQubNdPQs57ex4ujoy/+xL0cdw9J11gyxNnUDYxC4JvljKW51tHSbBy1AXVfsWDXoz00qmTy7JJnUJkJoxkutnkmZUUpuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=SP7WW+ZM; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="SP7WW+ZM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=j0V4eJittJ4seuh0EyBFJjqxDLMLo6RkQl/j1nvKW5k=; b=SP7WW+ZM7LP2+Ekac/8SELIHs0
	9qfXN+PyIKHWRRGb0aU2thEXBD6gTLRQeI+CQJBsSmnObFoJGz153RYf2XmRj0JCJESt11xT2PAmb
	1gLVdZIt81i6I76izTIUIzpIxIhZla1iVya8iioN9ZHUR4yFdTxW/PMwig6VTn23xZ9ZyOJ0mWm65
	rph0QXtBIi4hj3FHhQ7K1Ao8fbD/Q4t+rgYdD5EAosJILSVSk7ZhXZj1ic3vS41CcesVIkA2BhGJp
	Hfk+o+CdG5RrTCgcvk0PMAGVoL2yvbjYf7C52CxEwBIT45AwNEfsntyXSmqzpfubPoLVQbhWjIhVw
	zOpUyODQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1weBc8-000PI8-0N;
	Mon, 29 Jun 2026 15:01:28 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1weBc6-000BFC-2M;
	Mon, 29 Jun 2026 15:01:26 +0200
Message-ID: <a1a31c1e-b5bf-458f-a80a-bc324fc7a07c@iogearbox.net>
Date: Mon, 29 Jun 2026 15:01:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3 v2] net: Extend bpf_net_context lifetime to cover
 qdisc enqueue
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: jiri@resnulli.us, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 toke@toke.dk, Steven Rostedt <rostedt@goodmis.org>,
 Petr Machata <petrm@nvidia.com>, Alexei Starovoitov <ast@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, linux-rt-devel@lists.linux.dev,
 bpf@vger.kernel.org, security@kernel.org, stable@vger.kernel.org,
 Victor Nogueira <victor@mojatatu.com>
References: <20260629102157.737306-1-jhs@mojatatu.com>
 <20260629102157.737306-2-jhs@mojatatu.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20260629102157.737306-2-jhs@mojatatu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28046/Mon Jun 29 08:27:20 2026)

Hi Jamal,

On 6/29/26 12:21 PM, Jamal Hadi Salim wrote:
> The bpf_net_context used by sch_handle_egress() is stack-allocated and torn
> down in that function returned. By the time tcf_qevent_handle() runs
> current->bpf_net_context is NULL.
> 
> When a filter attached to a qevent block (e.g. RED's early_drop or mark
> qevents, which always use shared blocks) returns TC_ACT_REDIRECT,
> tcf_qevent_handle() calls skb_do_redirect(), which in turn calls bpf helper
> bpf_net_ctx_get_ri().  That helper unconditionally dereferences
> current->bpf_net_context resulting in a NULL pointer dereference.
> 
> Note: The same holds for actions that invoke BPF redirect helpers
> (e.g. act_bpf running a program that calls bpf_redirect()) during qevent
> classification itself.
> 
> Fix:
> Move the bpf_net_context lifecycle out of sch_handle_egress() into
> __dev_queue_xmit(), so that it spans both the egress TC fast path and the
> qdisc enqueue.
> Note: The call is placed outside the egress_needed_key static branch
> to cover the case where clsact static key is disabled. Unfortunately this
> adds a small unconditional penalty to the code path _per packet_ only
> guarded by CONFIG_NET_XGRESS (two writes and one read).
> 
> As pointed by sashiko [1]:
> The same context must also be set up in net_tx_action()'s qdisc drain
> path, since qdisc_run() -> netem_dequeue() -> qdisc_enqueue( RED child)
> can trigger qevent classification asynchronously from softirq context.
> 
> This keeps all bpf_net_context management in net/core/dev.c i.e the
> existing boundary between tc core and BPF without requiring any net/sched/
> code to know about BPF plumbing.
> 
> Reproducer:
> 
>    tc qdisc add dev eth0 root handle 1: red limit 1MB min 10KB max 20KB \
>        avpkt 1000 burst 100 qevent early_drop block 10
>    tc filter add block 10 pref 1 bpf obj redirect.o
> 
>    traffic through eth0 triggers red_enqueue() -> tcf_qevent_handle() and,
>    on a redirect verdict, a NULL deref in skb_do_redirect().
> 
> Fixes: 3625750f05ec ("net: sched: Introduce helpers for qevent blocks")
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Could we simplify patch 1 & 2 by just moving the bpf_net_ctx_set() and
bpf_net_ctx_clear() into a tcf_classify_qdisc() wrapper where we don't
end up having to touch the core TX code?

Untested diff :

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index 3bd08d7f39c1..1828cc16c5d7 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -93,6 +93,8 @@ int tcf_classify(struct sk_buff *skb,
  		 const struct tcf_block *block,
  		 const struct tcf_proto *tp, struct tcf_result *res,
  		 bool compat_mode);
+int tcf_classify_qdisc(struct sk_buff *skb, const struct tcf_proto *tp,
+		       struct tcf_result *res, bool compat_mode);
  
  static inline bool tc_cls_stats_dump(struct tcf_proto *tp,
  				     struct tcf_walker *arg,
@@ -157,6 +159,13 @@ static inline int tcf_classify(struct sk_buff *skb,
  	return TC_ACT_UNSPEC;
  }
  
+static inline int tcf_classify_qdisc(struct sk_buff *skb,
+				     const struct tcf_proto *tp,
+				     struct tcf_result *res, bool compat_mode)
+{
+	return tcf_classify(skb, NULL, tp, res, compat_mode);
+}
+
  #endif
  
  static inline unsigned long
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 3e67600a4a1a..982409702c7f 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -23,6 +23,7 @@
  #include <linux/jhash.h>
  #include <linux/rculist.h>
  #include <linux/rhashtable.h>
+#include <linux/filter.h>
  #include <net/net_namespace.h>
  #include <net/sock.h>
  #include <net/netlink.h>
@@ -1884,6 +1885,24 @@ int tcf_classify(struct sk_buff *skb,
  }
  EXPORT_SYMBOL(tcf_classify);
  
+int tcf_classify_qdisc(struct sk_buff *skb, const struct tcf_proto *tp,
+		       struct tcf_result *res, bool compat_mode)
+{
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
+	int ret;
+
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
+	ret = tcf_classify(skb, NULL, tp, res, compat_mode);
+	bpf_net_ctx_clear(bpf_net_ctx);
+
+	if (unlikely(ret == TC_ACT_REDIRECT)) {
+		pr_warn_once("TC_ACT_REDIRECT from qdisc filter chains is not supported\n");
+		ret = TC_ACT_SHOT;
+	}
+	return ret;
+}
+EXPORT_SYMBOL(tcf_classify_qdisc);
+
  struct tcf_chain_info {
  	struct tcf_proto __rcu **pprev;
  	struct tcf_proto __rcu *next;
@@ -4033,7 +4052,7 @@ struct sk_buff *tcf_qevent_handle(struct tcf_qevent *qe, struct Qdisc *sch, stru
  
  	fl = rcu_dereference_bh(qe->filter_chain);
  
-	switch (tcf_classify(skb, NULL, fl, &cl_res, false)) {
+	switch (tcf_classify_qdisc(skb, fl, &cl_res, false)) {
  	case TC_ACT_SHOT:
  		qdisc_qstats_drop(sch);
  		__qdisc_drop(skb, to_free);
@@ -4045,10 +4064,6 @@ struct sk_buff *tcf_qevent_handle(struct tcf_qevent *qe, struct Qdisc *sch, stru
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

Thanks,
Daniel
