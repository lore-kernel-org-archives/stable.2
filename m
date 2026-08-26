Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A183A1E8C
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 07:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787730068; cv=none; b=cJiF2+5i61oWgQmx6ZmYmpoPzAVu7AtBCcUJFTim/eV9mnn0Nq/fxH/5lQFpMnRjpB0yjvVIPCXrJtTW7AYnKGqhQnJSsCwvtAuz+CEsdw8mVdvvbpCKRM2Z3Bg6jlclNFsZzpW9xwcGzTEfTTcP149GRJF3PxjlTWfsj4OL/Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787730068; c=relaxed/simple;
	bh=cWQrMIxfLsjiSKyZlSnSQ4Se4+A/Iq8h/2uu4oxSA+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mYr4GRsN21vB5fNVR5cyhFX1GKaztKXNxBfzNvD4Sj7Pev/fIaOL7sxeV4O+mKGc+NnX5PvBvBfPjkZ1nHHhEy+q6wRR9zS1nTtzoW6nBelUD613ryfiD6HjiHK9PE5GTeEnRjZ8enEfETz18LrsksCP0lc9WESAV1moiMi3OB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=O+Z4wrA6; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="O+Z4wrA6"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51bfa429aa6so10244041cf.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 00:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787730062; x=1788334862; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C4DYIQHvMuYiODFDHPpNrtzb9aCp3wc4z9I9Y2wOhUg=;
        b=O+Z4wrA6HS9ziVtnvwjgmfFJMZXUXivfr0Sn7KwsOT8EcO3aU0fNRAM1kXNVkYxBeN
         P44XJP5eB/upQPYo9LDMgR/m+1kXfO0JRz3sT0yaeNrZ1s+pycWYDyV8g258N/pIufFO
         KgD+kCWGAWTGlDkaLv0cFvZh2cqmyU0VIfZ44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787730062; x=1788334862;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C4DYIQHvMuYiODFDHPpNrtzb9aCp3wc4z9I9Y2wOhUg=;
        b=NCQANjlQQuZgAT1WoFHs8FdwJrL0bipbZNmr30/5EkHan8oqwmPk5zRQvuv4DwXIvV
         wVrGr9E6csRbkkwzk2595GZxmxN9WwWvoHFXMYktkMsHPBwLWRZd4Ifw8NUBEc1OhyFz
         vtf8RqKVvQXcodUbAat8yoyNfF/r88r2yJDWsxAkhqGVJR+nEYBAT8PALvWhnLQFBpYx
         dy3xmqgOPSNOyTqfXHvF/BDpdOoaJAbFVqmlNeJMh0yyfkCAc6gqtz2T8H+4VViv0GJM
         wDnnwxG53ZV5qg2AKAkf2+gj9RxVD/2G9neM/ho/p4uDiSlD/I58zVgnZOoSNXICX+i9
         nBQw==
X-Forwarded-Encrypted: i=1; AHgh+RrVIkKeRJYmp0yK90/qExRRh1QlnJraoJzI/fJqikAtRGd5D2ekclbtA9wiawnAUUtsq/SfDZk=@vger.kernel.org
X-Gm-Message-State: AFuF++n/Rc/tWblcKe8rL6ZUw9D2ieztgdITZrdhOcgvROrCe5XDK6wC
	FXaDWTk1PR+Nr45yRJc2P8N9KVaOIYpKlmkJ/mInTHuoES9AUuJ/5aljZY3J0FtOIg==
X-Gm-Gg: AR+sD1164yCFG+YMUYwdRNGUKH1Xa20zICd5g2CA/i83xJUbf+92aXkuBS+vIyrDYoF
	9qLCCh8sv2kkJehNzYmP6dBlza0Qr2q5kStP8U9hxxl3DLEIQ4jQwBc2kBqf2nJWDc6ipbOGiEi
	ixcq6Gf7xn66Vr7JxNhp6MHbuhfUMorugih3ZykfrgtFLHxeGHIEyP0wuE/LYSaEMp/lCF1k8iY
	/LiE3oi0Yf2afSXLXkAL9sNG5/KhW81PDPREAKnQTSCxXJz/kc+2Oqp3QjdxiDLpYcfy+nV9+G1
	kZ/w16r4SKjs6IczEciw+cqcygqVM/29QOIP6vCf2DhOuj88ZpYo/KOAwEqoYtPD7cIiQy+NkIr
	zCN2Mj3g0izwRw2bQ+uT7dMylk2Ojr0y5zaBEkhN8Br9+eNedovmZhE+EyOmzxafhTaWNQXhrQX
	DrcV9U9v+Tog9IE8IEQ1xH8TxEiuEo4Zc/7Vhq9C4JJQWBlhGwL6cE1B1/L4rjV8T47L17KyP4v
	osJG28pYZZHhp+fWXGF8/5/CbOGWsf4EZcVmppfWbX2gA==
X-Received: by 2002:a05:622a:8c6:b0:52e:3820:a23c with SMTP id d75a77b69052e-52e41ba9abcmr49201351cf.13.1787730061817;
        Wed, 26 Aug 2026 00:41:01 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e42573987sm11809031cf.1.2026.08.26.00.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 00:41:01 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	vtahiliani@nitk.edu.in,
	toke@redhat.com,
	chia-yu.chang@nokia-bell-labs.com,
	subramanian.vijay@gmail.com,
	vega@nebusec.ai,
	stable@vger.kernel.org
Subject: [PATCH net] net/sched: clamp quantum and psched_mtu in change paths and missed siblings
Date: Wed, 26 Aug 2026 03:40:56 -0400
Message-Id: <20260826074056.7873-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a followup to commit 709f34f7c28d ("net/sched: fq: add
overflow bounds to quantum and initial quantum").
The quantum_backlog_overflow series and the five siblings that followed
clamped the init-path quantum to in fq, fq_codel, fq_pie, hhf, sfq.
The change() paths with the same pattern, same writer of q->quantum,
same privilege level (CAP_NET_ADMIN in a user namespace) were not clamped.
A user can override the init clamp via tc qdisc change, restoring the
small-quantum deficit spin that the init clamp was meant to prevent.

This follow-up also covers two siblings that were missed entirely by
the original series: sch_dualpi2 and sch_pie call psched_mtu() without
any clamp at all. With a crafted size table qdisc_pkt_len reaches ~2
GiB, so quantum=1 (or a zero psched_mtu on a headerless device) makes
the deficit-refill loop spin ~2^31 times under the qdisc lock (a soft
lockup / denial of service).

Fixes based on review of 709f34f7c28d:

1. fq_pie_change() accepts quantum=1 (NLA policy fq_pie_q_range.min=1).
   Add max(256U, ...) matching fq_codel_change()
   (Sashiko nipa gpt-5-6-sol-3-8 and gpt-5-6-sol-6-7)

2. sfq_change() accepts any non-negative quantum (only rejects
   (int)ctl->quantum < 0). Add max(256U, ...) matching fq_codel_change().
   Reject quantum > 1<<20 with -EINVAL, matching fq_codel_change() and
   the init clamp.
   (Internal review noticing same pattern)

3. hhf_change() accepts quantum=1 (only checks non_hh_quantum product).
   Add max(256U, ...) matching fq_codel_change()
   (Sashiko nipa v1 review + vega@nebusec.ai independent bug)

4. fq_change() accepts TCA_FQ_INITIAL_QUANTUM up to INT_MAX (iq_range.max
   = INT_MAX) while fq_init() now clamps to 1<<20.  Narrow iq_range.max
   to 1<<20, rejecting at parse time.  (Eric Dumazet)

5. sch_dualpi2: dualpi2_calculate_c_protection() and get_memory_limit()
   call psched_mtu() with no clamp. A huge MTU makes (s32)psched_mtu()
   overflow in the signed multiply for c_protection_init, and 2 *
   psched_mtu() wraps in get_memory_limit(). Clamp to [1, 1<<20] at
   all three call sites. (Sashiko nipa main-6-4)

6. sch_pie: pie_drop_early() calls psched_mtu() with no clamp.  With
   mtu=0x80000000 the bytemode divide silently zeroes the drop
   probability, disabling AQM. Clamp to [1, 1<<20] (Sashiko gemini)

7. sch_drr: drr_change_class() rejects explicit quantum==0 but falls
   back to psched_mtu() with no floor. Add max(256U, ...) after the
   zero reject and on the fallback path
  (vega@nebusec.ai independent bug)

8. sch_ets: ets_qdisc_change() falls back to psched_mtu() with no floor
   for bands without an explicit quantum.  Add max(256U, ...) on the
   fallback path (vega@nebusec.ai independent bug)

The init paths of fq_pie, sfq, and hhf delegate to their _change() when
opt is present, so the floor covers tc qdisc add ... quantum 1 as well
as change. The zero-quantum-from-psched_mtu case on a headerless device
(mtu==0) is also covered by the 256 floor in drr and ets; the
explicit-zero reject in drr_change_class() is preserved.

The sfq_change() silent clamp is user-visible: sfq_dump() reports the
clamped quantum, so a previously accepted quantum < 256 now reads back
as 256. Idempotent config managers that read back and compare will
see drift. fq_codel_change() made the same trade, so this is consistent.

Conditions to recreate the bug: create a fq_pie, sfq, hhf, dualpi2, or
pie qdisc (or a drr class / ets band), then tc qdisc change ... quantum 1
with a STAB size table inflating qdisc_pkt_len, e.g.:

  tc qdisc add dev dummy0 root fq_pie
  tc qdisc change dev dummy0 root fq_pie quantum 1 \
    stab data 32768 size_log 15 cell_log 0

Requires CAP_NET_ADMIN in a user namespace (unshare -Urn).

Fixes: 709f34f7c28d ("net/sched: fq: add overflow bounds to quantum and initial quantum")
Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")
Fixes: e4650d7ae425 ("net_sched: sch_sfq: handle bigger packets")
Fixes: 10239edf86f1 ("net-qdisc-hhf: Heavy-Hitter Filter (HHF) qdisc")
Fixes: 320d031ad6e4 ("sched: Struct definition and parsing of dualpi2 qdisc")
Fixes: d4b36210c2e6 ("net: pkt_sched: PIE AQM scheme")
Fixes: 13d2a1d2b032 ("pkt_sched: add DRR scheduler")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: stable@vger.kernel.org
---
 net/sched/sch_drr.c     |  3 ++-
 net/sched/sch_dualpi2.c | 10 +++++++---
 net/sched/sch_ets.c     |  2 +-
 net/sched/sch_fq.c      |  2 +-
 net/sched/sch_fq_pie.c  |  3 ++-
 net/sched/sch_hhf.c     |  2 +-
 net/sched/sch_pie.c     |  2 +-
 net/sched/sch_sfq.c     |  7 ++++++-
 8 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 91b1ef824afa..0ffdab27bae4 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -82,8 +82,9 @@ static int drr_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 			NL_SET_ERR_MSG(extack, "Specified DRR quantum cannot be zero");
 			return -EINVAL;
 		}
+		quantum = max(256U, quantum);
 	} else
-		quantum = psched_mtu(qdisc_dev(sch));
+		quantum = max(256U, (u32)psched_mtu(qdisc_dev(sch)));
 
 	if (cl != NULL) {
 		if (tca[TCA_RATE]) {
diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 4f678d4ff10e..4947def7c49e 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -208,9 +208,11 @@ static void dualpi2_reset_c_protection(struct dualpi2_sched_data *q)
 static void dualpi2_calculate_c_protection(struct Qdisc *sch,
 					   struct dualpi2_sched_data *q, u32 wc)
 {
+	u32 mtu = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
+
 	q->c_protection_wc = wc;
 	q->c_protection_wl = MAX_WC - wc;
-	q->c_protection_init = (s32)psched_mtu(qdisc_dev(sch)) *
+	q->c_protection_init = (s32)mtu *
 		((int)q->c_protection_wc - (int)q->c_protection_wl);
 	dualpi2_reset_c_protection(q);
 }
@@ -285,8 +287,9 @@ static bool must_drop(struct Qdisc *sch, struct dualpi2_sched_data *q,
 	u64 local_l_prob;
 	bool overload;
 	u32 prob;
+	u32 mtu = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
 
-	if (sch->qstats.backlog < 2 * psched_mtu(qdisc_dev(sch)))
+	if (sch->qstats.backlog < 2 * mtu)
 		return false;
 
 	prob = READ_ONCE(q->pi2_prob);
@@ -712,7 +715,8 @@ static u32 get_memory_limit(struct Qdisc *sch, u32 limit)
 	/* Apply rule of thumb, i.e., doubling the packet length,
 	 * to further include per packet overhead in memory_limit.
 	 */
-	u64 memlim = mul_u32_u32(limit, 2 * psched_mtu(qdisc_dev(sch)));
+	u64 memlim = mul_u32_u32(limit, 2 * clamp_t(u32, psched_mtu(qdisc_dev(sch)),
+						     1, 1 << 20));
 
 	if (upper_32_bits(memlim))
 		return U32_MAX;
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index 25fcf4079fec..f23c8dc68f8c 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -636,7 +636,7 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 	 */
 	for (i = nstrict; i < nbands; i++) {
 		if (!quanta[i])
-			quanta[i] = psched_mtu(qdisc_dev(sch));
+			quanta[i] = max(256U, (u32)psched_mtu(qdisc_dev(sch)));
 	}
 
 	/* Before commit, make sure we can allocate all new qdiscs */
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 6144b5686f13..ab8e7c6ae203 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -980,7 +980,7 @@ static int fq_resize(struct Qdisc *sch, u32 log)
 }
 
 static const struct netlink_range_validation iq_range = {
-	.max = INT_MAX,
+	.max = 1 << 20,
 };
 
 static const struct nla_policy fq_policy[TCA_FQ_MAX + 1] = {
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index b27d95418707..5982847df8f8 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -341,7 +341,8 @@ static int fq_pie_change(struct Qdisc *sch, struct nlattr *opt,
 			   nla_get_u32(tb[TCA_FQ_PIE_BETA]));
 
 	if (tb[TCA_FQ_PIE_QUANTUM])
-		WRITE_ONCE(q->quantum, nla_get_u32(tb[TCA_FQ_PIE_QUANTUM]));
+		WRITE_ONCE(q->quantum,
+			   max(256U, nla_get_u32(tb[TCA_FQ_PIE_QUANTUM])));
 
 	if (tb[TCA_FQ_PIE_MEMORY_LIMIT])
 		WRITE_ONCE(q->memory_limit,
diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index 96acab6a8da0..bb8e8952f555 100644
--- a/net/sched/sch_hhf.c
+++ b/net/sched/sch_hhf.c
@@ -551,7 +551,7 @@ static int hhf_change(struct Qdisc *sch, struct nlattr *opt,
 		return err;
 
 	if (tb[TCA_HHF_QUANTUM])
-		new_quantum = nla_get_u32(tb[TCA_HHF_QUANTUM]);
+		new_quantum = max(256U, nla_get_u32(tb[TCA_HHF_QUANTUM]));
 
 	if (tb[TCA_HHF_NON_HH_WEIGHT])
 		new_hhf_non_hh_weight = nla_get_u32(tb[TCA_HHF_NON_HH_WEIGHT]);
diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index b41f2def2e2c..3b7863ffd284 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -35,7 +35,7 @@ bool pie_drop_early(struct Qdisc *sch, struct pie_params *params,
 {
 	u64 rnd;
 	u64 local_prob = vars->prob;
-	u32 mtu = psched_mtu(qdisc_dev(sch));
+	u32 mtu = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
 
 	/* If there is still burst allowance left skip random early drop */
 	if (vars->burst_time > 0)
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 187d3ed578f2..8bbcfc9e85d9 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -660,6 +660,11 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		return -EINVAL;
 	}
 
+	if (ctl->quantum > 1 << 20) {
+		NL_SET_ERR_MSG_MOD(extack, "quantum too large");
+		return -EINVAL;
+	}
+
 	if (ctl->perturb_period < 0 ||
 	    ctl->perturb_period > INT_MAX / HZ) {
 		NL_SET_ERR_MSG_MOD(extack, "invalid perturb period");
@@ -688,7 +693,7 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 
 	/* update and validate configuration */
 	if (ctl->quantum)
-		quantum = ctl->quantum;
+		quantum = max(256U, ctl->quantum);
 	if (ctl->flows)
 		maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
 	if (ctl->divisor) {
-- 
2.43.0

