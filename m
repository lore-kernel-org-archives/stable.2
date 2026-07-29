Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC9348EBC6
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342280; cv=none; b=ShrdN/3jiWrEayn3b4e+D76930HWk3XeiSVRmt0GlDMabz7NXdxdnEyXC4zKcqRpIx2MX/u9gMkUSFLaWckgrnfdQugQjHytJ9MY4NP4HvWTZky8w8tPkKK37g8/duV3yGQ+62MmOCyw7RfGRAOceXosppt5rCYxbfwzJgYFDVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342280; c=relaxed/simple;
	bh=AEZTK4S3qC1W+in8H29Jpul1egX1x8a1gJydVcla6NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKTFjVLV7Hb8KAQeAyLOAzi2oKJaSFveu3hhYPd06BbXB/PnW27PMXiA9TvjD7YMVDeiUAje7xi7Nlx20gnW1APKT2wzcMtMsSqSgq7Xz3AS3+RA82bmfK1IAfWnLX/d1hEKNUttD41/zVW2uVoZoYvwSfCnshK3dndNixzWiI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+5es00f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+5es00f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25691F00A3A;
	Wed, 29 Jul 2026 16:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785342276;
	bh=HckMboG1b3Wk6205LJ76VckL1Q7VGEYIhJ4FWgoxfss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W+5es00finBTFN/JGosg5iEo62xKgYVvJriG9m0NnhXcKLzp7P08kQBHqrPYTrki0
	 P567whVCvb89yg3X65n6+ixF1H1fmsGk+7vCRWacuEcLfflK8ikM9CHOV7JS0kkkOb
	 8Sif+NTGHy/9wfw58uVucskBmH2dO3wcam1KmJRISCpe+suphPjkPeYDwbjBHk5jyk
	 5rT7HVhkW84BeYOd9e7g0FR4PGyI7tL7vwILdMojLU4sCanpcd2lLamVT82gSdEZrO
	 ZgZkXHJmfOTTuLucmB7pOEDafuM3fRJ4DL4jixfhfNuUBJRQehKMGWx1sbSEQEEsFR
	 cHh6OwRmm8afA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrea Righi <arighi@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 1/2] sched_ext: Move shared helpers from ext.c into internal.h and cid.h
Date: Wed, 29 Jul 2026 12:24:32 -0400
Message-ID: <20260729162433.3523095-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072116-antivirus-displace-b981@gregkh>
References: <2026072116-antivirus-displace-b981@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 4437ad129cf5b37c00a5bc9fa5989d1da4d64d07 ]

idle.c and cid.c are included into build_policy.c together with ext.c and
use helpers that ext.c defines. Because the helpers live in ext.c, the two
files can not parse as standalone units and clangd reports errors in them.

Move the helpers to the headers they belong to. The op-dispatch macros and
helpers plus scx_parent() to internal.h, and scx_cpu_arg()/scx_cpu_ret() to
cid.h. No functional change. idle.c and cid.c now parse clean standalone.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Stable-dep-of: 18d62044cda7 ("sched_ext: Preserve rq tracking across local DSQ dispatch")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c          | 29 -----------------------------
 kernel/sched/ext_internal.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5d2d19473a82e8..dc6138461ae3de 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -218,8 +218,6 @@ static __printf(4, 5) bool scx_exit(struct scx_sched *sch,
 #define scx_error(sch, fmt, args...)	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
 #define scx_verror(sch, fmt, args)	scx_vexit((sch), SCX_EXIT_ERROR, 0, fmt, args)
 
-#define SCX_HAS_OP(sch, op)	test_bit(SCX_OP_IDX(op), (sch)->has_op)
-
 static long jiffies_delta_msecs(unsigned long at, unsigned long now)
 {
 	if (time_after(at, now))
@@ -234,20 +232,6 @@ static bool u32_before(u32 a, u32 b)
 }
 
 #ifdef CONFIG_EXT_SUB_SCHED
-/**
- * scx_parent - Find the parent sched
- * @sch: sched to find the parent of
- *
- * Returns the parent scheduler or %NULL if @sch is root.
- */
-static struct scx_sched *scx_parent(struct scx_sched *sch)
-{
-	if (sch->level)
-		return sch->ancestors[sch->level - 1];
-	else
-		return NULL;
-}
-
 /**
  * scx_next_descendant_pre - find the next descendant for pre-order walk
  * @pos: the current position (%NULL to initiate traversal)
@@ -295,7 +279,6 @@ static void scx_set_task_sched(struct task_struct *p, struct scx_sched *sch)
 	rcu_assign_pointer(p->scx.sched, sch);
 }
 #else	/* CONFIG_EXT_SUB_SCHED */
-static struct scx_sched *scx_parent(struct scx_sched *sch) { return NULL; }
 static struct scx_sched *scx_next_descendant_pre(struct scx_sched *pos, struct scx_sched *root) { return pos ? NULL : root; }
 static void scx_set_task_sched(struct task_struct *p, struct scx_sched *sch) {}
 #endif	/* CONFIG_EXT_SUB_SCHED */
@@ -455,18 +438,6 @@ static bool rq_is_open(struct rq *rq, u64 enq_flags)
  */
 DEFINE_PER_CPU(struct rq *, scx_locked_rq_state);
 
-static inline void update_locked_rq(struct rq *rq)
-{
-	/*
-	 * Check whether @rq is actually locked. This can help expose bugs
-	 * or incorrect assumptions about the context in which a kfunc or
-	 * callback is executed.
-	 */
-	if (rq)
-		lockdep_assert_rq_held(rq);
-	__this_cpu_write(scx_locked_rq_state, rq);
-}
-
 /*
  * SCX ops can recurse via scx_bpf_sub_dispatch() - the inner call must not
  * clobber the outer's scx_locked_rq_state. Save it on entry, restore on exit.
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index a075732d4430d8..6d57f1d0b86f91 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1377,6 +1377,20 @@ static inline struct rq *scx_locked_rq(void)
 	return __this_cpu_read(scx_locked_rq_state);
 }
 
+static inline void update_locked_rq(struct rq *rq)
+{
+	/*
+	 * Check whether @rq is actually locked. This can help expose bugs
+	 * or incorrect assumptions about the context in which a kfunc or
+	 * callback is executed.
+	 */
+	if (rq)
+		lockdep_assert_rq_held(rq);
+	__this_cpu_write(scx_locked_rq_state, rq);
+}
+
+#define SCX_HAS_OP(sch, op)	test_bit(SCX_OP_IDX(op), (sch)->has_op)
+
 static inline bool scx_bypassing(struct scx_sched *sch, s32 cpu)
 {
 	return unlikely(per_cpu_ptr(sch->pcpu, cpu)->flags &
@@ -1457,6 +1471,20 @@ static inline struct scx_sched *scx_prog_sched(const struct bpf_prog_aux *aux)
 
 	return NULL;
 }
+
+/**
+ * scx_parent - Find the parent sched
+ * @sch: sched to find the parent of
+ *
+ * Returns the parent scheduler or %NULL if @sch is root.
+ */
+static inline struct scx_sched *scx_parent(struct scx_sched *sch)
+{
+	if (sch->level)
+		return sch->ancestors[sch->level - 1];
+	else
+		return NULL;
+}
 #else	/* CONFIG_EXT_SUB_SCHED */
 static inline struct scx_sched *scx_task_sched(const struct task_struct *p)
 {
@@ -1480,4 +1508,6 @@ static struct scx_sched *scx_prog_sched(const struct bpf_prog_aux *aux)
 {
 	return rcu_dereference_all(scx_root);
 }
+
+static inline struct scx_sched *scx_parent(struct scx_sched *sch) { return NULL; }
 #endif	/* CONFIG_EXT_SUB_SCHED */
-- 
2.53.0

