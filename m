Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C688389DF3
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 10:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047899; cv=none; b=JIiXACSMdkC+MPgGzMs4C6/uEg2Gvhco0/vQf2xwaSbf7U9aU8eoZgOVSaJZlbb7sYW5jnPFjeG/oHe7+Y99JbVRdMAq4roxFLAihtEgewZwdLNJHzlhj91izLG7vhA34FuiGoivmGQWpzXTPd8KBolKJlf4OszETEDvZYxjVLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047899; c=relaxed/simple;
	bh=n9uS592vK4YB7Y1CRNW/6drETxni52k32ulGuNzMQRA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J0wHSWaEoDSenyfhK3jCITBdu6SJQbZbhHMrDDeYfsmujgoiLePd2hTBax7Vuzu7Jqz8gvrSuXR8uLnUa9OuIo58kpjiJUmDjtzaruxGKZwP+LTFBn/0Gcca0Huk0kHP3n5mQqnpxtKi8pm+vOP5gvrJqy2aX+cJ8y0o5JL1rM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=OhngKGaF; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="OhngKGaF"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e50a650a0so249765485a.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 03:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787047894; x=1787652694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b71sRhdkJRtl9KU/Cx4OakrI/5trNEkbpMjkx7EP9PU=;
        b=OhngKGaFwIAensNjAgj2xqQkURJRVDFUESQoki+EfdSwMro0lgLvaXzM40vg5fJH0Y
         DPRODpwCbdi0sUG9viHP3Qx3ZD0wNKvD2Kerp/SNnhPHu89AMJHs5HkXzdgUzIhcRH3U
         51BUviTfd6jaEfu8tvDrA8OHDCIF9o4uN8beE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787047894; x=1787652694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b71sRhdkJRtl9KU/Cx4OakrI/5trNEkbpMjkx7EP9PU=;
        b=WWoAvfzMk0IF/rG4QGzo8bkItfnWeFx6UcqdaIDhZcZfEQz81qqUF/8raILvm+kA/R
         KpV1hEynv+wApDogXeNRB/z6FNKqXN9U+hCvo7kcMRBa3Hknssx9a/qOsB5z/VZsiZyJ
         oJzPAM/m8FMWBxcHmQuyAYh+sokYpWKQZ2bLf2DyiBO1ms6j9Q6UTZwMDDJTzJwoXw3V
         RYP3yYmoPCbKntuSIEfKofqMml48pksn9LPwxv/RwfXSVqhZEeHKWWaqOKcjOh4svZgp
         VZgXze311+1NCmy42XX/h9MGXHQtqlbGDYSfd0N9mKF1EqwGTBLuyRufCZXsV/vl+ZTZ
         2QUg==
X-Forwarded-Encrypted: i=1; AHgh+Rpb9U6caVFHBE/CEP5z49VJIye55LcUmE9W3xLKJjNxgzvweEJfCSmdf/JoTkmZdh63LLgaWgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1GY994pAqTSMp6h5QDF+hHrCgGr9kLfpP4TA/diGVh2F/4Ojp
	9n6IsVGdbgu0T1KFh8Asugj2R15P1EsLw88jw3Raz9vbBUTIYDYdYFz0zcpz/X3hcnnOd5hNUrL
	ill3xaQ==
X-Gm-Gg: AR+sD13zFjXVK8oAhU4fnAyspm5sAnElbiwliIWMj4TCLEEw0wFJfdWadixrT0jRuQM
	gqpWTUArV4K+fekLCwbC84OoCbzxGMwTiCASe0hklI/SmhAl6EP7DEb097uwRYGW+w2MQX3i+cs
	oeBI5jWNc+7I3wnNL6Zww/nn5RodMOFyYux0TEW5iCeeWh8Ai+VDlia1oZx7REvb3I6ez8aSOKG
	GZjqsimlDebE7/mAUdCWXOxBxR4O88q8RI8CjE8JG6MfkhvykiS2cqZyaJN5ID/7Xpcbd4NjN7V
	irlGq0N17+WZfd9uDZ7a4nhgqz7piRKRxVYsXYTWYZQpOnYYx4dfy3e+s0W1/Hf+NUTkya7m6m9
	9wliDeWQAHo1D0Zgqi5qWmqzWT08kzT8a42WjmMPM2PAKXi+wGh02AvyUpsKEqbuOzwtQwHJReg
	bpNrZ0MlEYVVtrHT/pi+9EXO3hgelIQzdRHoiMdER7qo/1RzZ0Zfvjykdnuxe4TuaQBWp8wLnQT
	nZutibT/g6rKf7OekbUt8c9axwsL43s/S8UIZm/0Mc05g==
X-Received: by 2002:a05:620a:4153:b0:930:fad2:fd with SMTP id af79cd13be357-93704b523fbmr641342485a.17.1787047894399;
        Tue, 18 Aug 2026 03:11:34 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937033ceb9bsm256178185a.23.2026.08.18.03.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 03:11:33 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net] net: sched: fix quantum/backlog overflow in fq, fq_codel, hhf, sfq
Date: Tue, 18 Aug 2026 06:11:30 -0400
Message-Id: <20260818101130.16203-1-jhs@mojatatu.com>
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

- sch_fq: fq_dequeue() credit-refill loop with a small quantum spins ~1B
  iterations under the qdisc lock (soft lockup); fq_init() computes
  quantum = 2 * psched_mtu() with no overflow check.
- sch_fq_codel: fq_codel_enqueue() accumulates qdisc_pkt_len() into a u32
  per-flow backlog; a crafted TCA_STAB inflates pkt_len to 1 GiB so a few
  packets wrap the counter to 0, and fq_codel_drop() then picks an empty
  flow and derefs NULL.
- sch_hhf: hhf_init() sets quantum = psched_mtu() with no overflow check;
  a huge MTU makes it 0x80000000, and hhf_dequeue()'s deficit += weight *
  quantum loops forever.
- sch_sfq: sfq_init() sets quantum = psched_mtu() (unsigned); a huge MTU
  makes allot = INT_MIN, and INT_MIN + INT_MIN is UB that toggles between
  INT_MIN and 0 forever.

Clamp the quantum to a sane minimum and promote the backlog/credit sums to
avoid the wrap, so the dequeue loops terminate and the drop path never
selects an empty flow.

Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_fq.c       |  9 ++++++---
 net/sched/sch_fq_codel.c | 14 +++++++++++++-
 net/sched/sch_hhf.c      | 12 +++++++++++
 net/sched/sch_sfq.c      |  7 +++++++
 4 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 7cae082a9847..66e9c6e530d8 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -750,7 +750,10 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 	f = head->first;
 	retry = 0;
 	if (f->credit <= 0) {
-		f->credit += q->quantum;
+		if (f->credit + (int)q->quantum > 0)
+			f->credit += q->quantum;
+		else
+			f->credit = q->quantum;
 		head->first = f->next;
 		fq_flow_add_tail(q, f, OLD_FLOW);
 		goto begin;
@@ -1226,8 +1229,8 @@ static int fq_init(struct Qdisc *sch, struct nlattr *opt,
 
 	sch->limit		= 10000;
 	q->flow_plimit		= 100;
-	q->quantum		= 2 * psched_mtu(qdisc_dev(sch));
-	q->initial_quantum	= 10 * psched_mtu(qdisc_dev(sch));
+	q->quantum		= max_t(u32, 2 * psched_mtu(qdisc_dev(sch)), 256);
+	q->initial_quantum	= max_t(u32, 10 * psched_mtu(qdisc_dev(sch)), 256);
 	q->flow_refill_delay	= msecs_to_jiffies(40);
 	q->flow_max_rate	= ~0UL;
 	q->time_next_delayed_flow = ~0ULL;
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 6cce86ba383c..990f8b1cc57e 100644
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
 
diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index d85cb0263b67..7634d6cbeed8 100644
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
+		 * hhf_dequeue() forever. Clamp to the same minimum quantum
+		 * floor fq_codel uses (max(256U, ...)).
+		 */
+		if (non_hh_quantum == 0 || non_hh_quantum > INT_MAX)
+			q->quantum = 256;
+	}
+
 	if (opt) {
 		int err = hhf_change(sch, opt, extack);
 
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 77675f9a4c46..b84aa7614cc9 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -800,6 +800,13 @@ static int sfq_init(struct Qdisc *sch, struct nlattr *opt,
 	q->divisor = SFQ_DEFAULT_HASH_DIVISOR;
 	q->maxflows = SFQ_DEFAULT_FLOWS;
 	q->quantum = psched_mtu(qdisc_dev(sch));
+	/* A device with max_mtu == 0 (e.g. dummy) accepts an MTU that makes
+	 * psched_mtu() wrap into the sign bit; that would set slot->allot
+	 * negative and spin sfq_dequeue() forever. Fall back to a sane
+	 * quantum (10 KiB) that fits a signed int and is >= one MTU.
+	 */
+	if ((int)q->quantum <= 0)
+		q->quantum = 10 * 1024;
 	q->perturb_period = 0;
 	get_random_bytes(&q->perturbation, sizeof(q->perturbation));
 
-- 
2.34.1

