Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517591386C9;
	Sun, 16 Aug 2026 00:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786838730; cv=none; b=SgI8Lk6yt7vlxtvOJiBy/VJFeLA2J62YcGoIX9qY9Z1A/Wf+IYVK2nM2ysIuOM0OzR2f4904Ql/JrLsKmez72N6SvCWaX9L5S/ylGrjqEe3HKU1BS9NuOexNeRlc78mzeZMEwzxfRb/iowismpINhb0Zak8/s+sRVaTMMILmVE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786838730; c=relaxed/simple;
	bh=pu0dh5W/IhUdr1nsxlU8728+km5hXd4CYcSKQPGuK1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChIsF/3oOypJ5F2u/0KBdrxdDQE8U1eq9/Sp72vmq/3CEWc6X8LJ3V+MSECpdplOcoo56BxRd91K4a/TUBLQlYXymg4W1pk6IvyHlEgi2FTbMVnfMHZkKTmjKW7cQX2cvqiy8h8vpR3Sbx16Idq1iU0KzmtfQ5hOPDg+M52NIzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJqRSJyH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJqRSJyH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7A91F00A3A;
	Sun, 16 Aug 2026 00:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786838728;
	bh=3xBxi/68wgiGwNVsuFrtjyaF8xWNLZZZl9Lv8DjZmm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oJqRSJyHkCE8pXZUkB2F+noQ14XNhr1jp4YR6Hrs0kLNw6d/0bmU5nxx4zKR7qQtJ
	 52fgAB3PgzxrS2tOqEHUZqJPtMprJVrSZjIkq+5oDFWGpskq4Gl5cvzAhQfjGKJmME
	 qh25csIBKYzJxgRSAoYUPUl9BuYD9/vX4uEQeY2cMFSCN/CIuIwt0/vQK6Y8KzlkPP
	 B2pQdULrrbq66AkDf+5yJNOsa2WOoYNC+01UGrVGSBXQwUbiE9GbsaIC63XUZNWkdg
	 55PvyubN4ekhlEGgjqzi0X6Cx6lkbAi64FEiPxjzV5Y8bCHds/YjKgJOY2qEHtAmqw
	 dsingVUrb1RLA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] sched_ext: Fix inverted ops.core_sched_before() invocation
Date: Sat, 15 Aug 2026 14:05:24 -1000
Message-ID: <20260816000527.988170-2-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816000527.988170-1-tj@kernel.org>
References: <20260816000527.988170-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_prio_less() implements prio_less() semantics - %true means that @a is
the lower priority and should run after @b. ops.core_sched_before() is
documented to return %true when @a should run before @b. scx_prio_less()
returns the op's value as-is, inverting the documented semantics at runtime.

Call the op with the arguments swapped.

scx_qmap followed the wiring instead of the documentation and returned %true
for the younger task, so the two inversions canceled out and it behaved as
intended. Flip its comparison to match. scx_qmap is likely the only current
user in or out of the kernel tree. Any scheduler written the same way needs
the same flip, while schedulers following the documentation are fixed by
this change.

Fixes: 7b0888b7cc19 ("sched_ext: Implement core-sched support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c         | 10 ++++++++--
 tools/sched_ext/scx_qmap.bpf.c |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index cbbf3fa7462b..ddf448d526e4 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3528,6 +3528,8 @@ void ext_server_init(struct rq *rq)
  *
  * When ops.core_sched_before() is enabled, @p->scx.core_sched_at is used to
  * implement FIFO ordering within each local DSQ. See pick_task_scx().
+ *
+ * Return: %true if @a should run after @b.
  */
 bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 		   bool in_fi)
@@ -3536,6 +3538,10 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 	struct scx_sched *sch_b = scx_task_sched(b);
 
 	/*
+	 * scx_prio_less() returns whether @a should run after @b while
+	 * ops.core_sched_before() returns whether its first argument should run
+	 * before the second. Swap the arguments.
+	 *
 	 * The const qualifiers are dropped from task_struct pointers when
 	 * calling ops.core_sched_before(). Accesses are controlled by the
 	 * verifier.
@@ -3544,8 +3550,8 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 	    !scx_bypassing(sch_a, task_cpu(a)))
 		return SCX_CALL_OP_2TASKS_RET(sch_a, core_sched_before,
 					      task_rq(a),
-					      (struct task_struct *)a,
-					      (struct task_struct *)b);
+					      (struct task_struct *)b,
+					      (struct task_struct *)a);
 	else
 		return time_after64(a->scx.core_sched_at, b->scx.core_sched_at);
 }
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index dd0434437835..723f45fe0cbc 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -900,7 +900,7 @@ static s64 task_qdist(struct task_struct *p)
 bool BPF_STRUCT_OPS(qmap_core_sched_before,
 		    struct task_struct *a, struct task_struct *b)
 {
-	return task_qdist(a) > task_qdist(b);
+	return task_qdist(a) < task_qdist(b);
 }
 
 /*
-- 
2.55.0

