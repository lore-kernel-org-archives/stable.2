Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9A44BAA13
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445975; cv=none; b=IXvh6Ij33iHWhIuY9n/F8OAySCAg2IlfNnYHjzJ3Z2OQGJc0MBTNSEnP41ImXYALjrc8OS7fG5WXQx6orO+U8tkitGTV0aElCuzeHP98/xhy2MEsAZ7l6s8AluEXy+CunZjk0ExkWLKW4Um7PA25+mr/zWQRqGwrDPMDmv5Cd4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445975; c=relaxed/simple;
	bh=YvrHb9eSCiZeE28eJsh6mpxozf+17PNVfsdcxZ/LBN0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FDRHJh7wwphBR/YkBwKE8OlCzlIgWGN39BORXolBm9EZQZQ6CpBciakSC1rKo9V+F4gFeshaoYyROMDDwu+YkDsNBnuyS/WL0JTsLyMWMpUfM5VGf21JQm04c7spEo32Fp5KBVuiBgbTalK2pwxJD4VTxXTpcxfPM8C1P9Bbsjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g0SMwaQq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g0SMwaQq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B251F00AC4;
	Thu,  3 Sep 2026 14:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445965;
	bh=txfMwvzBaBb41Zt08A3GaQke3pTWyxNsdmxSW6MLBmA=;
	h=Subject:To:Cc:From:Date;
	b=g0SMwaQqI1shXfSsQFZ/Y1+CdZQVylN25uCbW8OGqxUFQ9DNlo8isDAPG94Wn3K+M
	 AEJSTGvP1dcE/ZuBVBdT4IndOVHEv+hphi3KoLziPnVjKmSpiklT+Aq0akyhXQBDQ8
	 B8J6PUaC1qFqgqQ6vK/G1VId1w+OgnUkhuJfreDo=
Subject: FAILED: patch "[PATCH] sched_ext: Fix inverted ops.core_sched_before() invocation" failed to apply to 6.12-stable tree
To: tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:15:00 +0200
Message-ID: <2026090300-shifting-wobbly-b1a8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f7b6d128dd49a6eec09066ecfd29095f12588786
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090300-shifting-wobbly-b1a8@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f7b6d128dd49a6eec09066ecfd29095f12588786 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Sat, 15 Aug 2026 13:08:28 -1000
Subject: [PATCH] sched_ext: Fix inverted ops.core_sched_before() invocation

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

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 2ae1df58939d..9014c814a00a 100644
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

