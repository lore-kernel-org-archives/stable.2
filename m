Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9844C3B27DB
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166861; cv=none; b=Vfm8R4MHVSMfGmeUI9p1CSY96PMUFwT9zZP9cd+sROFT7xbgaZtrUkHbX/i8NJwz0//LcheK2kLBgzp1UvPjc5aqJoS5n6qOkUX7UUr8W1SgmrJKrA2AoS0+hPc5VjNYeIB9Balb/LEFVdlUA4oFqEBLcQzPzJJZKPHzQsBCkN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166861; c=relaxed/simple;
	bh=MPcCYvOyCvmfxut9ONfVjbfMDO3nZDdz59TURvak+xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rY3EeIbwkjEEF2PD2DbV+koySuGkZlOfD3mXIN+Sp+Rwyt9Sq06RTzr0hAS8RQqzho1XaSegonHnVKcu26JDlw/xnaxndzFFQLkFALtYU9C73vWHwcNGmyvU1jV76NUGGy6Cl0NPxsIRuChGHh/cqxM1IEBX8XFQRmwRX4iIPqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsxIS2Qt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsxIS2Qt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976A21F000E9;
	Mon, 27 Jul 2026 15:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785166860;
	bh=qDkvyFXWfKEUDg3VgDtMD1URPtVpw/j64q9JjMED1fQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OsxIS2QtV5914jGtl25XMRezeaHSM5Fqe52KFgXrRQJCP2hLf2BJ3YxVSAdUr4avu
	 sseXuxSy8OEEKL8jzasc3tv7Z3ZATHOGd9XZbPaK9yylAHYdL8FQsa3xHNM8/JC54C
	 k7M22HC/NO6naXAqV3+JVVuTPdUx9pnx9ALy3CcuM2g1/KBBacByJH/07GIJdhbzSI
	 JEYqIYXR7fDnxXwiZRyG1xERukdNmKjnMRntMCj4yXzQobNd2gRcwPYqKDS03f36rh
	 n1kpIFzM6cvdE4agi3nuzy+Fh3avGuFzanQtlcZqg+wyGf93zsTI0rWkbkwZ1MajEt
	 +7tu25huMy/GQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
	stable@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] bpf,fork: wipe ->bpf_storage before bailouts that access it
Date: Mon, 27 Jul 2026 11:40:58 -0400
Message-ID: <20260727154058.1514238-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072029-cringing-silent-7b1b@gregkh>
References: <2026072029-cringing-silent-7b1b@gregkh>
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
 kernel/fork.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index db2a9016f636f4..69b62740adc3b5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1068,6 +1068,10 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->reported_split_lock = 0;
 #endif
 
+#ifdef CONFIG_BPF_SYSCALL
+	RCU_INIT_POINTER(tsk->bpf_storage, NULL);
+	tsk->bpf_ctx = NULL;
+#endif
 	return tsk;
 
 free_stack:
@@ -2318,10 +2322,6 @@ static __latent_entropy struct task_struct *copy_process(
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

