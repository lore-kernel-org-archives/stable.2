Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594927;
	b=fblat6zlV6X2MTDunb20HJG3swsqtphywmBQzcoV8zajBei8qJ+wVLv2ZWheUKIne3wz
	 hDs1xajxE95RZj1MHJB1Vtq9VjFKnfjNuMTSNVQ1yQTunSW9cBuNLtmZWDAJe7kgW2qLZ
	 SEMDcA6Pj7UQzUj/2xarbffa3UHRady1K2jVdmF/la7eF8RqqAYBg/zZDo0QFnjcw2Yrj
	 00uhAWnIFYhU+xPZB9HkWS01lwHYCSJoQiE7ykFoD1VUzqq8EY8U0cHIY98QF2s/I5J5u
	 CLqBq7Tp4UZzl5XouZH7iMYhnjJbkwfMkWhIE6t+e3EO82PhaW+HBIFUUEk50o8kO7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594927;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=w4lZiXkDyMOr5gJpWCea7avZJRLTearhDV0QWUzJlkU=;
	b=PBLpJTWpIL+LeWlD8pBvUdAwGb+lYevnoaH0VV0G24gy0dCeacRbZEaO9Xt7Y7XQRFey
	 1u+6VHr0WTJnMuXY1QsrMODMp9jkSA4Ip8iAym8ffncrg0HCd0oW1tn+S8TT28lmDRuPw
	 RzuehwhagncCZaOxOV6URUmOsZI/duBIVOa3GV7VSdTNXd8f6S5WimF3WUCzrO9wMPj27
	 n4Vn88S0hLn/kY4D7Ksex0qm4My+of+9x8zv4LJ02JCWWtw1FprRz2rXZqtSpuuzV/eV3
	 xqaaFfoZ/nUX03u4Jta3HNm1WarNz0nsL0PUesUJToVrz7kVf1OHMeUdPCbbv/qj55Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=elqKrxuF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78846606A31D
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=elqKrxuF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7A51F000C1;
	Wed, 21 Oct 2026 15:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594927;
	bh=w4lZiXkDyMOr5gJpWCea7avZJRLTearhDV0QWUzJlkU=;
	h=Subject:To:Cc:From:Date;
	b=elqKrxuFxhiCDtX5/ETrjTMDD1zNA80uBiE2Ooax8BCf8U5BLaQ1JbNADG3fjzOZr
	 0xBDcAmUCdoMvdVGpRxz9MgZDSM28dO14dgDtWLPdA4OBiIs4yPk5PJfXDmojFsuZE
	 N8I/oPk1b1OmBa+pMHKQjDjfQ7k44N3l+Wq5kbxU=
Subject: FAILED: patch "[PATCH] sched_ext: idle: Respect task affinity in restricted CPU" failed to apply to 6.18-stable tree
To: sh_def@163.com,arighi@nvidia.com,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:49:36 +0200
Message-ID: <2026102136-landless-alienate-afa8@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 6ac4544eff796666ce6fbcc4be8181c81dfccc85
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102136-landless-alienate-afa8@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6ac4544eff796666ce6fbcc4be8181c81dfccc85 Mon Sep 17 00:00:00 2001
From: Hui Su <sh_def@163.com>
Date: Mon, 12 Oct 2026 02:31:00 +0900
Subject: [PATCH] sched_ext: idle: Respect task affinity in restricted CPU
 selection

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

diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
index aa9fb6de0ad6..28ed9e327085 100644
--- a/kernel/sched/ext/idle.c
+++ b/kernel/sched/ext/idle.c
@@ -952,12 +952,43 @@ static bool is_bpf_migration_disabled(const struct task_struct *p)
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
 	unsigned long irq_flags;
 	bool we_locked = false;
+	bool migration_disabled;
 	s32 cpu;
 
 	if (!scx_cpu_valid(sch, prev_cpu, NULL))
@@ -994,20 +1025,17 @@ static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
 
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
 
 	if (we_locked)
 		raw_spin_unlock_irqrestore(&p->pi_lock, irq_flags);

