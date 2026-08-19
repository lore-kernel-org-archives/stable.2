Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98064746B0
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787149919; cv=none; b=rZpWFYs6NfZDkjFtwOEnDWaQlUE9Z0N8AyPC01NKqELJjMRIEuDnrdxW22mM3ijgmwV7ny15WENprwybHz1A+gsW7NAgnuYZgSzoQs5oE6AOWYijUSfu27Bu0A32RgakMWtI4EJTr+4jVdPMU0YvDhVljhIuu3NLPGziJWjlLpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787149919; c=relaxed/simple;
	bh=1MKRDKwuRIIHvknKmyIquQOvqu3uhZBcKDY16r6pLn4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O3BnjkYHwEt8kdreG7x/Oh65qB7Xgt+zpnn6gn8tQFf6jrRurqflLpoIx7+tMPvsAmUHo5qvbhCDZFh5UhaZkdDKnlmgJM6JyU53ueo2giMXbhkuBHD8PFZNZsF1GsQHBCYTAq5QWj+6ovl9+4MOfnfUO1sCFHgRv+2uQhqXGk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ArbsRggO; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="ArbsRggO"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6aaf3f54dbeso893440eaf.2
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 07:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787149915; x=1787754715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VkoXOaewtypOLXOO1su20hvl0GXnYwGIOvpcPDd9wJQ=;
        b=ArbsRggO0ZnBh1eHy/StL473bhtYKkNy8+EC7ueY0Vba8R22lnScbJmQ6LIMpygJby
         fODYhTEgUtUA2XLDQeIGeXNypTZiQA3XnrU4jMbuJ/KQYnRN2yspi1/arzM3Ramc29NM
         q6gv2Z2CtNNnMzkr3HSFCjQZ34hzqe4vtfJdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787149915; x=1787754715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VkoXOaewtypOLXOO1su20hvl0GXnYwGIOvpcPDd9wJQ=;
        b=E8nEhAngQh3h4q5vyQ0e4DhCFMxtIRz4Wkyl91z0n/67woBzjt38cswX+CkD0O7Zt3
         Yekz6jluTcyos+pPXksiSQc5JRqT3pTOhceT/RtY2WH8SR+31+BkBzRd8sm+CJtZw4dg
         U0pc7PPBCJn+9yzBXDZDo78utXIv8w/XWhuAHhaeGrmndwpxf7vk8PNakBfiFq9TJwYP
         mhJVr00LC3fjjIXnJJoQEY2IA643Em9r1GZSmJoPPPALY0PBQv5zt/GDG1Xbt6VJBwv5
         QPtLj0OAuwwk6IZkYG3V+CH8/l6GIhd4HneAE58YC8b9cLdfjksoiezWL+cLLX3DSY6D
         I2uQ==
X-Forwarded-Encrypted: i=1; AHgh+RpawhRWL5Ur2sptzz679t5hYB7rJEz39sWTV3KQ9u03PXiaQI4bCdrc2E+U4U7dFQvSC2oKQjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwziytGEeiPT3Qi2jdgJojGboL2Wblw25fd5bOFopOJGvQRK2f/
	F1B/tpVD4949n1LZ54XBUvx8dz/UKfXkKWdNFNvgL5yM1qr5iEVdlxv2Ne9o4LP3Pw==
X-Gm-Gg: AR+sD119i9xRd82sZxuhdx2UWOoR+upWrFSdmymaabvl4w4HvEYpvcbU0A0ydanJ/tR
	6yUfXPReoj5+KgFUPQSyjNWdvS1PC171cOiNq3Cjb6ZL3t9r5gH8FJYqWHXVqFimzna/ZdgkcQ4
	e1FkasYoSCyPsMTpdcB5dkCiniDbNg62GiLsLS3yZt6PHprUTIhNxczTGjLyRg5gTHfMXtQFAO/
	5tHSaaLf2fYFy540AFx+pzaLbMc/reDoM0luIeuxN7JWB5jL3PU8L9HjGTsfe8JsItAM3pQr5NT
	Fq45VlbsybXy/Vm5qgi3MV3ptun+MIgQEJ3xreOuE4LbHflLMVCCB9R51zAG1DmEsHjj1fLubYe
	cEWs8qaPh5MoPMlGDVeCO8GTApSUcv6vrz4vjKqzo93efa39voYGatfWA6iYYPQ2x9Zw7yic47r
	CEifcY+shSdZdo/TzxGjIQKOUX1Vu5/tWvxef89LlSV1p3QyzjiVCjmRNhzzFJ3Olky9LbxUiCs
	4j3gfMU+vnIElC1eCg8q97XNvXb/OmdTyxVzrSoHxJl2w==
X-Received: by 2002:a05:6820:818a:b0:6aa:e176:bcb5 with SMTP id 006d021491bc7-6b13c33635bmr4710780eaf.14.1787149913209;
        Wed, 19 Aug 2026 07:31:53 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45f226904b6sm5324071fac.0.2026.08.19.07.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 07:31:52 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v2] net: sched: fix quantum/backlog overflow in fq, fq_codel, fq_pie, hhf, sfq
Date: Wed, 19 Aug 2026 10:31:35 -0400
Message-Id: <20260819143136.57350-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several qdiscs derive their per-flow quantum or backlog from psched_mtu()
or accumulate qdisc_pkt_len() into a u32/int counter without an overflow
or zero clamp, which can drive the dequeue/credit-refill loop into a soft
lockup or a NULL deref.

vega@nebusec.ai provided reports and PoCs which illustrated the following:

- sch_fq: fq_init() computes quantum = 2 * psched_mtu() with no overflow
  check; a huge MTU wraps it into the sign bit, and fq_dequeue()'s
  credit-refill loop spins forever. TCA_FQ_INITIAL_QUANTUM is also
  unbounded up to INT_MAX in fq_change().
- sch_fq_codel: fq_codel_enqueue() accumulates qdisc_pkt_len() into a u32
  per-flow backlog; a crafted TCA_STAB inflates pkt_len to 1 GiB so a few
  packets wrap the counter to 0, and fq_codel_drop() then picks an empty
  flow and derefs NULL. fq_codel_init() also sets quantum =
  psched_mtu() with no clamp, so a huge MTU makes the deficit loop spin.
- sch_fq_pie: fq_pie_init() sets quantum = psched_mtu() with no clamp and
  fq_pie_change() accepts any u32 quantum; same deficit-loop spin as
  fq_codel on a huge-MTU dummy device.
- sch_hhf: hhf_init() sets quantum = psched_mtu() with no overflow check;
  a huge MTU makes weight * quantum overflow the signed deficit, and
  hhf_dequeue() loops forever.
- sch_sfq: sfq_init() sets quantum = psched_mtu() (unsigned); a huge MTU
  makes allot = INT_MIN, and INT_MIN + INT_MIN is UB that toggles between
  INT_MIN and 0 forever.

Clamp the quantum to a sane range at init/change time so the dequeue loops
terminate and the drop path never selects an empty flow. The clamps live in
the init/change paths, not the per-packet fast path, so no hot-path cost is
added for a configuration issue.

Conditions to recreate the bug: a device whose MTU (plus hard_header_len)
is large enough that 2 * psched_mtu() or psched_mtu() wraps into the sign
bit (e.g. a dummy device with max_mtu == 0 accepting a huge MTU), or a
crafted TCA_STAB that inflates qdisc_pkt_len to ~1 GiB. Requires
CAP_NET_ADMIN in a user namespace (Level 2) to configure the qdisc and MTU.

Fixes: afe4fd062416 ("pkt_sched: fq: Fair Queue packet scheduler")
Fixes: 4b549a2ef4be ("fq_codel: Fair Queue Codel AQM")
Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")
Fixes: 10239edf86f1 ("net-qdisc-hhf: Heavy-Hitter Filter (HHF) qdisc")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v1 to v2
Changes based on feedback from Eric and Sashikos[1][2] on V1.

1. Drop the fast-path changes in fq_dequeue() (Eric)

2. Clamp to a range, not just a lower bound (Eric). Uses
   clamp_t(u32, ..., 1, 1 << 20) (upper bound 1M; lower bound 1, not 256).
   Sashiko (gemini, nipa gpt-5-6-sol-1-5) pointed out the v1 max_t() left
   bit 31 set, so a 0x80000000 quantum survived and still spun.
   Upper bound is 1M, not Eric's suggested 16M. fq_change() already caps
   TCA_FQ_QUANTUM at 1M; using 16M in fq_init() would be inconsistent.

3. Clamp TCA_FQ_INITIAL_QUANTUM in fq_change() too (Eric). It was unbounded
   up to INT_MAX; v2 clamps it to > 0 && <= 1M, matching TCA_FQ_QUANTUM.

4. Fold fq_codel_init() quantum clamp (Sashiko gemini + nipa gpt-5-6-sol-1-6)

5. Fold fq_pie_init()/fq_pie_change() quantum clamp (Sashiko gemini):

6. Reword the hhf/sfq comments (Sashiko nipa gpt-5-6-sol-2-15, gpt-5-6-sol-2-14)

[1]https://sashiko.dev/#/patchset/20260818101130.16203-1-jhs@mojatatu.com        
[2]https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101130.16203-1-jhs@mojatatu.com
---
 net/sched/sch_fq.c       | 17 ++++++++++++-----
 net/sched/sch_fq_codel.c | 16 ++++++++++++++--
 net/sched/sch_fq_pie.c   |  9 ++++++---
 net/sched/sch_hhf.c      | 12 ++++++++++++
 net/sched/sch_sfq.c      |  8 ++++++++
 5 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 7cae082a9847..f7c92df085e7 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -1112,9 +1112,16 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
 		}
 	}
 
-	if (tb[TCA_FQ_INITIAL_QUANTUM])
-		WRITE_ONCE(q->initial_quantum,
-			   nla_get_u32(tb[TCA_FQ_INITIAL_QUANTUM]));
+	if (tb[TCA_FQ_INITIAL_QUANTUM]) {
+		u32 initial_quantum = nla_get_u32(tb[TCA_FQ_INITIAL_QUANTUM]);
+
+		if (initial_quantum > 0 && initial_quantum <= (1 << 20)) {
+			WRITE_ONCE(q->initial_quantum, initial_quantum);
+		} else {
+			NL_SET_ERR_MSG_MOD(extack, "invalid initial quantum");
+			err = -EINVAL;
+		}
+	}
 
 	if (tb[TCA_FQ_FLOW_DEFAULT_RATE])
 		pr_warn_ratelimited("sch_fq: defrate %u ignored.\n",
@@ -1226,8 +1233,8 @@ static int fq_init(struct Qdisc *sch, struct nlattr *opt,
 
 	sch->limit		= 10000;
 	q->flow_plimit		= 100;
-	q->quantum		= 2 * psched_mtu(qdisc_dev(sch));
-	q->initial_quantum	= 10 * psched_mtu(qdisc_dev(sch));
+	q->quantum		= clamp_t(u32, 2 * psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
+	q->initial_quantum	= clamp_t(u32, 10 * psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
 	q->flow_refill_delay	= msecs_to_jiffies(40);
 	q->flow_max_rate	= ~0UL;
 	q->time_next_delayed_flow = ~0ULL;
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 6cce86ba383c..19dde45794a6 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -152,12 +152,24 @@ static unsigned int fq_codel_drop(struct Qdisc *sch, unsigned int max_packets,
 	 * amortizing this linear lookup to one cache line per drop.
 	 */
 	for (i = 0; i < q->flows_cnt; i++) {
-		if (q->backlogs[i] > maxbacklog) {
+		if (q->backlogs[i] > maxbacklog && q->flows[i].head) {
 			maxbacklog = q->backlogs[i];
 			idx = i;
 		}
 	}
 
+	/* TCA_STAB can inflate qdisc_pkt_len enough to wrap per-flow
+	 * backlogs (u32) to zero; fall back to a flow with packets.
+	 */
+	if (maxbacklog == 0) {
+		for (i = 0; i < q->flows_cnt; i++) {
+			if (q->flows[i].head) {
+				idx = i;
+				break;
+			}
+		}
+	}
+
 	/* Our goal is to drop half of this fat flow backlog */
 	threshold = maxbacklog >> 1;
 
@@ -516,7 +528,7 @@ static int fq_codel_init(struct Qdisc *sch, struct nlattr *opt,
 	q->flows_cnt = 1024;
 	q->memory_limit = 32 << 20; /* 32 MBytes */
 	q->drop_batch_size = 64;
-	q->quantum = psched_mtu(qdisc_dev(sch));
+	q->quantum = max(256U, psched_mtu(qdisc_dev(sch)));
 	INIT_LIST_HEAD(&q->new_flows);
 	INIT_LIST_HEAD(&q->old_flows);
 	codel_params_init(&q->cparams);
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 069e1facd413..8fe6634b9aa9 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -340,8 +340,11 @@ static int fq_pie_change(struct Qdisc *sch, struct nlattr *opt,
 		WRITE_ONCE(q->p_params.beta,
 			   nla_get_u32(tb[TCA_FQ_PIE_BETA]));
 
-	if (tb[TCA_FQ_PIE_QUANTUM])
-		WRITE_ONCE(q->quantum, nla_get_u32(tb[TCA_FQ_PIE_QUANTUM]));
+	if (tb[TCA_FQ_PIE_QUANTUM]) {
+		u32 quantum = max(256U, nla_get_u32(tb[TCA_FQ_PIE_QUANTUM]));
+
+		WRITE_ONCE(q->quantum, quantum);
+	}
 
 	if (tb[TCA_FQ_PIE_MEMORY_LIMIT])
 		WRITE_ONCE(q->memory_limit,
@@ -427,7 +430,7 @@ static int fq_pie_init(struct Qdisc *sch, struct nlattr *opt,
 	pie_params_init(&q->p_params);
 	sch->limit = 10 * 1024;
 	q->p_params.limit = sch->limit;
-	q->quantum = psched_mtu(qdisc_dev(sch));
+	q->quantum = max(256U, psched_mtu(qdisc_dev(sch)));
 	q->sch = sch;
 	q->ecn_prob = 10;
 	q->flows_cnt = 1024;
diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index d85cb0263b67..483e70df0ce8 100644
--- a/net/sched/sch_hhf.c
+++ b/net/sched/sch_hhf.c
@@ -624,6 +624,18 @@ static int hhf_init(struct Qdisc *sch, struct nlattr *opt,
 	q->hhf_evict_timeout = HZ;      /* 1  sec */
 	q->hhf_non_hh_weight = 2;
 
+	if (!opt) {
+		u64 non_hh_quantum = (u64)q->quantum * q->hhf_non_hh_weight;
+
+		/* A device with max_mtu == 0 (e.g. dummy) accepts an MTU that
+		 * makes weight * quantum overflow the signed deficit and spin
+		 * hhf_dequeue() forever. Fall back to a sane minimum quantum
+		 * when the weighted product overflows or is zero.
+		 */
+		if (non_hh_quantum == 0 || non_hh_quantum > INT_MAX)
+			q->quantum = 256;
+	}
+
 	if (opt) {
 		int err = hhf_change(sch, opt, extack);
 
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 77675f9a4c46..0e8d034ef2e3 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -800,6 +800,14 @@ static int sfq_init(struct Qdisc *sch, struct nlattr *opt,
 	q->divisor = SFQ_DEFAULT_HASH_DIVISOR;
 	q->maxflows = SFQ_DEFAULT_FLOWS;
 	q->quantum = psched_mtu(qdisc_dev(sch));
+	/* A device with max_mtu == 0 (e.g. dummy) accepts an MTU that makes
+	 * psched_mtu() wrap into the sign bit; that would set slot->allot
+	 * negative and spin sfq_dequeue() forever. Fall back to a safe
+	 * positive quantum so the refill loop terminates; the qdisc_pkt_len
+	 * cap in __qdisc_calculate_pkt_len() bounds the deficit depth.
+	 */
+	if ((int)q->quantum <= 0)
+		q->quantum = 10 * 1024;
 	q->perturb_period = 0;
 	get_random_bytes(&q->perturbation, sizeof(q->perturbation));
 
-- 
2.43.0

