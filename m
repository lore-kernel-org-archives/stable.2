Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792668898;
	b=riI5O3pFC/4WT0YSqPuEFY9mlCWtv9c/PX7nU9iC8rx3m5Pl+OJTQvLoD/cgB/InyscX
	 CoNTfs85BUBxRJ11p50jTACRo/FR/zKyZ/ZqtF7eTp6l0YNB1Uw/clicJMxqIxAh4J2nj
	 qfNqcw7BojvTBYXJB9niZHYfl4kXJvufcd7QfACUz8YPBLvMbIlEP9lAWGV9g64LkECzw
	 9EqCJlqQ07PFAR6RmfsnqsIchwHJN76vEDf9Zvg2HlZ5/HHLHolsPHjyFROEKB5lBbpmD
	 IUScDatCvzXXevODn09/IvstAuvqQH5zETcwt2ltF+i1Gg1BfS9vmYeKH/tliFMK4Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792668898;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DNEPsw8H4peVGAfn1gU70bLlWJ3sDy0G5hioQLtIBHI=;
	b=1/gOzLlBWYHdwDR654uuKP+NPtMyLXtWzdu1CV6LW6ohr/WKORDkzIgxErovTiApemGA
	 Em35UraFas4K124AW3YVBr0W2lUckzl4DzEX+evX4lHtZzbvx97cfZfA0HnJIVZGuxd5w
	 Gy2Ywh4sVOA9zD42NO1KnLNWcsUBkQLREP2f6X7TzdOd8VlAC6tIM9evWCUwhlHY4e6it
	 LWgSmBZ/Lib2fs/AcCMxWPgBiNeL2HMXOPuOwOfE8kDSnrVv/H4+oeJWrShFGk7IYrovQ
	 ndF/xauTu57KCyAW8Tr9njv6bFzhxDp9Y5g4XZja5RhFxUE0O8ZDwCaLiyQHo40Yb3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZJCzJR96;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED354606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 11:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZJCzJR96
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7FA1F000C1;
	Thu, 22 Oct 2026 11:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792668897;
	bh=DNEPsw8H4peVGAfn1gU70bLlWJ3sDy0G5hioQLtIBHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZJCzJR96RAgbkhraL69dPa3ndL+4CXO+xQRPgmLJv2ocaZhZVRGdbAyPAE0vXwn4B
	 gx0kHSzOU/QW9QGpHKdnaZEqcoPejteRso/3lBxnM0ptja0NbbdTbX649i0hnf4r/X
	 Cia2Qt+V1qTtWeOhWAaQuibv7JByyAt6hm8emCisIQR3TkVXi6FUgEn+89lDnQV9c0
	 sWgy0gePHhVzg7vBsIomjVonytGZ3UVwMeXuCQKPsUmjLASCaXJR2jKD7TQOIZWlHz
	 NPTs8zh92XGo1zlb9jJt5xItRmjuNmfDDo5Vt9NuVJktrt4mezHZsOfe4a2ztplFxb
	 Wzv9JN8NZlAXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hui Su <sh_def@163.com>,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] sched_ext: idle: Respect task affinity in restricted CPU selection
Date: Thu, 22 Oct 2026 07:34:55 -0400
Message-ID: <20261022113411.921725-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102136-landless-alienate-afa8@gregkh>
References: <2026102136-landless-alienate-afa8@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hui Su <sh_def@163.com>

[ Upstream commit 6ac4544eff796666ce6fbcc4be8181c81dfccc85 ]

The restricted select_cpu kfunc path handles single-CPU and
migration-disabled tasks without going through scx_select_cpu_dfl().

It currently uses prev_cpu as the candidate, even though prev_cpu is only a
hint and may no longer be usable after an affinity change. With a
caller-provided @allowed mask, this can also return an idle CPU outside
p->cpus_ptr.

Derive the candidate from task state instead: use the sole CPU in
p->cpus_ptr for single-CPU tasks and task_cpu(p) for migration-disabled
tasks. Validate it against p->cpus_ptr and @allowed before claiming its
idle state.

Since the derived candidate may be on a different NUMA node from
prev_cpu, also preserve SCX_PICK_IDLE_IN_NODE by rejecting cross-node
candidates.

Perform all checks before scx_idle_test_and_clear_cpu(), as a successful
call consumes the CPU's idle bit.

Fixes: 683d2d0faba1 ("sched_ext: idle: Introduce scx_bpf_select_cpu_and()")
Cc: stable@vger.kernel.org
Signed-off-by: Hui Su <sh_def@163.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
[ sashal: Adjusted declaration context to retain rq and rf for the existing task_rq_lock() locking. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext_idle.c | 50 ++++++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index d16a1de078656..d2024279939de 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -889,12 +889,43 @@ static bool is_bpf_migration_disabled(const struct task_struct *p)
 	return p->migration_disabled;
 }
 
+static s32 select_cpu_restricted(struct task_struct *p, s32 prev_cpu,
+				 const struct cpumask *allowed, u64 flags,
+				 bool migration_disabled)
+{
+	s32 cpu;
+
+	if (migration_disabled)
+		cpu = task_cpu(p);
+	else
+		cpu = cpumask_first(p->cpus_ptr);
+
+	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
+		return -EBUSY;
+
+	if (allowed && !cpumask_test_cpu(cpu, allowed))
+		return -EBUSY;
+
+	if (flags & SCX_PICK_IDLE_IN_NODE) {
+		int node = scx_cpu_node_if_enabled(prev_cpu);
+
+		if (scx_cpu_node_if_enabled(cpu) != node)
+			return -EBUSY;
+	}
+
+	if (!scx_idle_test_and_clear_cpu(cpu))
+		return -EBUSY;
+
+	return cpu;
+}
+
 static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
 				 s32 prev_cpu, u64 wake_flags,
 				 const struct cpumask *allowed, u64 flags)
 {
 	struct rq *rq;
 	struct rq_flags rf;
+	bool migration_disabled;
 	s32 cpu;
 
 	if (!ops_cpu_valid(sch, prev_cpu, NULL))
@@ -928,20 +959,17 @@ static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
 
 	/*
 	 * This may also be called from ops.enqueue(), so we need to handle
-	 * per-CPU tasks as well. For these tasks, we can skip all idle CPU
-	 * selection optimizations and simply check whether the previously
-	 * used CPU is idle and within the allowed cpumask.
+	 * per-CPU tasks as well. For these tasks, skip general idle CPU
+	 * selection and validate the task's only usable CPU directly.
 	 */
-	if (p->nr_cpus_allowed == 1 || is_bpf_migration_disabled(p)) {
-		if (cpumask_test_cpu(prev_cpu, allowed ?: p->cpus_ptr) &&
-		    scx_idle_test_and_clear_cpu(prev_cpu))
-			cpu = prev_cpu;
-		else
-			cpu = -EBUSY;
-	} else {
+	migration_disabled = is_bpf_migration_disabled(p);
+
+	if (p->nr_cpus_allowed == 1 || migration_disabled)
+		cpu = select_cpu_restricted(p, prev_cpu, allowed, flags,
+					    migration_disabled);
+	else
 		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags,
 					 allowed ?: p->cpus_ptr, flags);
-	}
 
 	if (scx_kf_allowed_if_unlocked())
 		task_rq_unlock(rq, p, &rf);
-- 
2.53.0

