Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574213BBFB9
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 16:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785168146; cv=none; b=dApmBBUa7E7d4UVZ+ieIA9vEC9k/1bhRzfmyVTA0vEeU+BXTTMcMViUmk4xdNecX79Z6LsCqQ3ZcCzfJFEfZZ7MkKC0RUneqhJZPLacUZmXXoBAFVcxyQrJEj6OUKFsWCFbHfnLQrS4LD9sUSzPsn5ixT0Y6BHeTx6ZccpEzTdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785168146; c=relaxed/simple;
	bh=r3vWekXmn7ID251pBtdeU7/oszaEFvjQCmYdAzBFhEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=teOgziNI6+NBcjoC5PHE7m/sNH5hFaGeg8EXhx/9uwdrazBPGVpeuEzurNug56H3GgGVPxcrvJSaGbvYyemfLsAGhwW+KGW87EWJn9JpWcUeEx+IMU4NsNv00Y61VcZ2xveqw/m7OPEjc5Mo3C4CPYnd6PwR6NHV7KevCslctKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDJPHHVN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDJPHHVN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B151F000E9;
	Mon, 27 Jul 2026 16:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785168145;
	bh=EBnaPfIYqExeEQ4L/WZ5ZPglkNbITQ+HlrPYoGPlaec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RDJPHHVNl6xhQVqdNdF6+VeghLjmDIUXhkOebLIovC+p3VheLiXWPWghy1fbI5pS8
	 ez7RIcw7aGzuDacJwfytWm0SFZeLzCl1mJvBKlbw00UARm3IALlv8tJitlTqWXo4jB
	 +xjMQbvpF3vIOVYNJIej2yWjFtfPJCrT3/XTR1c1P3dzIeYAMFaBP+37adZz80lxlQ
	 2Sh54YjtPLj8mEy7IhW5pqyabzvA3ihgPU+aKgtlOR09wo4ZDfMFgfVILXdFZ7FCYW
	 /i5qBDt/36e5023Qum8vwYHA8LPaczWu+PjKPHHwfMCkteziianruknWJCLNkf6MtY
	 0csv50TzdKZYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
	stable@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] bpf,fork: wipe ->bpf_storage before bailouts that access it
Date: Mon, 27 Jul 2026 12:02:22 -0400
Message-ID: <20260727160222.1760251-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072029-trend-escalator-b641@gregkh>
References: <2026072029-trend-escalator-b641@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jann Horn <jannh@google.com>

[ Upstream commit 9b51a6155d14389876916726430da30eabb1d4ed ]

Currently, copy_process() can bail out to free_task() before p->bpf_storage
has been initialized, with this call graph (shown here for the
!CONFIG_MEMCG case):

copy_process
  dup_task_struct
    arch_dup_task_struct
      [copies the entire task_struct, including ->bpf_storage member]
  [RLIMIT_NPROC check fails]
  delayed_free_task
    free_task
      bpf_task_storage_free
        rcu_dereference(task->bpf_storage)
        bpf_local_storage_destroy

In this case, the nascent task's ->bpf_storage member that
bpf_local_storage_destroy() operates on is a plain copy of the parent's
->bpf_storage pointer, not a real initialized pointer.
This leads to badness (kernel hangs, UAF).

This is reachable as long as the process calling fork() has been inserted
into a task storage map.

Cc: stable@kernel.org
Fixes: a10787e6d58c ("bpf: Enable task local storage for tracing programs")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/fork.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index f55be5303dc7af..46c4f83972881d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -983,6 +983,11 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 #ifdef CONFIG_MEMCG
 	tsk->active_memcg = NULL;
 #endif
+
+#ifdef CONFIG_BPF_SYSCALL
+	RCU_INIT_POINTER(tsk->bpf_storage, NULL);
+	tsk->bpf_ctx = NULL;
+#endif
 	return tsk;
 
 free_stack:
@@ -2252,10 +2257,6 @@ static __latent_entropy struct task_struct *copy_process(
 	p->sequential_io	= 0;
 	p->sequential_io_avg	= 0;
 #endif
-#ifdef CONFIG_BPF_SYSCALL
-	RCU_INIT_POINTER(p->bpf_storage, NULL);
-	p->bpf_ctx = NULL;
-#endif
 
 	/* Perform scheduler related setup. Assign this task to a CPU. */
 	retval = sched_fork(clone_flags, p);
-- 
2.53.0

