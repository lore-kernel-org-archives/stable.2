Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214203;
	b=uJAo4341NSEED+i5XSch09IGA2OZqu/fPa2UvowbwqJyO6vDAZGgFVwHPmO9MxYWI5XS
	 trnTUIIWCNAe+8dR7lJQBG1fkzwopncIWEcfaDphvfU0FiqnHgIShba88pAKk+srR0n1b
	 czfyp0NA43bvj0zatvGNLgPI/I1bHO4FCuWsKQSSdjE4iNWgdQZWoJSjWCkhTKuYQakdX
	 hjEvttIHl5IQsfwB8rPZsm0idCrXwpxIeMhCWgRn5sX3RLedP+A8oDJh3lU9pdsZpv4LR
	 fm+mQkOcYj66r/HDgI/L4l39zxXTV4+xT6p9JozowT5ANlhYJVdsl9XX8gNXMWpONsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214203;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jD+wdiTs1kXKqDcvBj+j76oJ2TKy7JZAYBiI96zbwpI=;
	b=N0hFdZG5DwC7w/rgq2dfgbkbjOsSV9Z8LDert1cEyWpglic3IFCvzlu5vZhK7AbeqAXr
	 BOBIV5VuN4QWaXj1FDbXXrC6vcKrXbRwX4ryfxNFMaYfG8XDNPHLOns9Jo7Cqm51ue0PH
	 1ATYGIkeozZYWh0RFTqIB8pPNtrZADuW2a6TKQOzePzJql5tfb5eHXcZmfBUWdPiQue/L
	 F3dl/J6Cew6NHny9frqaagTwHL8UYYdXDoIm/aLh8sc4FTaJsNqbJNoliR0Gthty0vQOi
	 t5031sdrlfKJAr/nugZPpr0YrlSgKY+pxLdYWWEbjhYyTrjW6O8rowir/YKFtliKa+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LbUs6VlA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52E1606BF94
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LbUs6VlA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4A31F013C5;
	Wed, 28 Oct 2026 19:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793214202;
	bh=jD+wdiTs1kXKqDcvBj+j76oJ2TKy7JZAYBiI96zbwpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LbUs6VlA4FFwXVRXsWsZmg6JJIEhVoRyHV4Ew7WurYHjQy1pImQxHkC8PmrqUjJnT
	 mJFlBzPzEpCWfs9PQfSZ/cM8+ipGxXgUC58u2EGelXjevj1r//F262ajhU8Mi0BOSC
	 8I648W1S5sL45OyFUcGExXIPtQjvclXKqlsSH2F+LRsdRu21Lss+c7ksMzfIaZEghf
	 Ewsf1phhDSiYdCApnwHnC++NkV8u63SMfgo0t1EWWz8BpltkUiD9KFSo1xZ7whzcHM
	 bXVb1/vJepI1HXFWXBxgMw+mNZ/rTvBdaYCAUSKpatTLU+Gl2Mo26omUq3bhGWBhvg
	 pb0okQUAxpRQQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Chris Mason <mason@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] fork: release the files of a failed fork after sched_cancel_fork()
Date: Wed, 28 Oct 2026 15:03:19 -0400
Message-ID: <20261028190309.2072845-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028190309.2072845-1-sashal@kernel.org>
References: <2026102801-oaf-percolate-96a4@gregkh>
 <20261028190309.2072845-1-sashal@kernel.org>
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

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 296a98c1fa50778c3b31eebed1a3f903f9684349 ]

Reorder copy_process() cleanup so sched_fork() taking scx_fork_rwsem
scx_pre_fork() is safe and isn't held around exiting files. Right now, a
fork that fails while another thread closed the bpf link fd will
deadlock against its own read side. It also blocks every fork on the
system:

    copy_process()                  holds scx_fork_rwsem for read
      exit_files()
        close_files()
          filp_close_sync()
            bpf_scx_unreg()
              kthread_flush_work()  waits for the disable work
                scx_root_disable()
                  percpu_down_write(&scx_fork_rwsem)

Simply release the child's files after sched_cancel_fork() dropped the
lock. The task starts out as a copy of its parent so p->files points to
the parent's table until copy_files() replaces it. exit_files() must not
run for a fork that failed before that. Clear p->files up front so
exit_files() is a no-op for those and make copy_files() set it
explicitly for CLONE_FILES.

Reported-by: Chris Mason <mason@kernel.org>
Link: https://patch.msgid.link/20260921-work-coredump-fixes-v3-7-8e4adb1619e6@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/fork.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 7a83b068364d5..b273dcce3bca2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1645,6 +1645,7 @@ static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
 
 	if (clone_flags & CLONE_FILES) {
 		atomic_inc(&oldf->count);
+		tsk->files = oldf;
 		return 0;
 	}
 
@@ -2250,6 +2251,8 @@ static __latent_entropy struct task_struct *copy_process(
 	INIT_LIST_HEAD(&p->sibling);
 	rcu_copy_process(p);
 	p->vfork_done = NULL;
+	/* Set by copy_files(), exit_files() on the error path skips NULL. */
+	p->files = NULL;
 	spin_lock_init(&p->alloc_lock);
 
 	init_sigpending(&p->pending);
@@ -2352,7 +2355,7 @@ static __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_cleanup_semundo;
 	retval = copy_fs(clone_flags, p);
 	if (retval)
-		goto bad_fork_cleanup_files;
+		goto bad_fork_cleanup_semundo;
 	retval = copy_sighand(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_fs;
@@ -2630,8 +2633,6 @@ static __latent_entropy struct task_struct *copy_process(
 	__cleanup_sighand(p->sighand);
 bad_fork_cleanup_fs:
 	exit_fs(p); /* blocking */
-bad_fork_cleanup_files:
-	exit_files(p); /* blocking */
 bad_fork_cleanup_semundo:
 	exit_sem(p);
 bad_fork_cleanup_security:
@@ -2642,6 +2643,8 @@ static __latent_entropy struct task_struct *copy_process(
 	perf_event_free_task(p);
 bad_fork_sched_cancel_fork:
 	sched_cancel_fork(p);
+	/* ->release() of a file may need scx_fork_rwsem for write. */
+	exit_files(p); /* blocking */
 bad_fork_cleanup_policy:
 	lockdep_free_task(p);
 #ifdef CONFIG_NUMA
-- 
2.53.0

