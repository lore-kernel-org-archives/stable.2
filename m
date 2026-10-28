Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793201772;
	b=Kyy2sl+mPsn3F+h8bmu9KDGJSJY2vhrMNP/jNVdZiUn8TwvZai8WqdUfYtyh7xfMWNqZ
	 16HC/ss5XPdD0+GZ9uYn6TijjvVydHZPEunN0BLDYjbqNzOsWpGFBA14REIIyPrI55MNK
	 2TSZyKYUPjnSbi7In16LKQYXHwMJeo0JcX0ii4rLbFbnHzLmbK0mR7lt/tZF0JQ14Pt74
	 WAdJGIDLHo+Pzm3W8GX/w9Kt3ygEGEDqLlqL8HvX1eqjaWEYKV7ZYmsnGUuYZ3PXrs/H2
	 JF3iX8lbQMVf/btJEet5YxMWGUM98gsnMCV35hE6yMez4CZeGOpxN7JyGZ4Uj0oISGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201772;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Qg+LfE3DCx2d+5VgHOMZNtPnwNxdC1neTq9Nn3QTpvI=;
	b=fcRnI9ZxznWrZAa5Unf6sADjh5sjfEj9pzIVqLcL5z3xt6MwAQUfI+ql1y2d7vR/a7oM
	 +7l0Xzinyb5QpCSiilsKGVDvc+WqwXnYIstcKaHb2oQqTgY7tK7+Dhg3lVILE2jim/CIT
	 S9dJBBs0TkorRGO8FshhDjry0ZShAfKrCbX6sDEGhJiCP+va1/kBjHc/jOt1Ai8lwnFUZ
	 WchS2/XRIz0hBeJ0LaRzF44foR6URxZndx+FW6S5taGunBNwgpuWNg5qkjrYxDsJOqtXG
	 ZMzu/uuCG0HtdzpMHdLENhoxVPgaabQOzpW3ZdNuxk0PQm4sb5Q2CBPYWn0kHhFAN6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=z9G99ye0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E3360A2618
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=z9G99ye0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA19E1F01240;
	Wed, 28 Oct 2026 15:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793201771;
	bh=Qg+LfE3DCx2d+5VgHOMZNtPnwNxdC1neTq9Nn3QTpvI=;
	h=Subject:To:Cc:From:Date;
	b=z9G99ye0LywcfmESkd5QdvU7j6Lzgq05Nr4aXU15b61jtHjTutX68uGhbyjrN9vM4
	 3Hmd3QNNj9s0dGY+xk/VbzD2AFPYbat2O0fckpjfaY2uszaTWrbUqIkF0jZEYtOl/q
	 yNF9BS20P/eMWM1w3f1YtKxS51YifpL26xvrn0ms=
Subject: FAILED: patch "[PATCH] fork: release the files of a failed fork after" failed to apply to 6.1-stable tree
To: brauner@kernel.org,mason@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 28 Oct 2026 16:36:01 +0100
Message-ID: <2026102801-oaf-percolate-96a4@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 296a98c1fa50778c3b31eebed1a3f903f9684349
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102801-oaf-percolate-96a4@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 296a98c1fa50778c3b31eebed1a3f903f9684349 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 21 Sep 2026 15:44:56 +0200
Subject: [PATCH] fork: release the files of a failed fork after
 sched_cancel_fork()

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

diff --git a/kernel/fork.c b/kernel/fork.c
index 10be4a0ecb3f..50f5b3e2ca87 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1676,6 +1676,7 @@ static int copy_files(u64 clone_flags, struct task_struct *tsk,
 
 	if (clone_flags & CLONE_FILES) {
 		atomic_inc(&oldf->count);
+		tsk->files = oldf;
 		return 0;
 	}
 
@@ -2199,6 +2200,8 @@ __latent_entropy struct task_struct *copy_process(
 	INIT_LIST_HEAD(&p->sibling);
 	rcu_copy_process(p);
 	p->vfork_done = NULL;
+	/* Set by copy_files(), exit_files() on the error path skips NULL. */
+	p->files = NULL;
 	spin_lock_init(&p->alloc_lock);
 
 	init_sigpending(&p->pending);
@@ -2300,7 +2303,7 @@ __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_cleanup_semundo;
 	retval = copy_fs(clone_flags, p, args->umh);
 	if (retval)
-		goto bad_fork_cleanup_files;
+		goto bad_fork_cleanup_semundo;
 	retval = copy_sighand(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_fs;
@@ -2613,8 +2616,6 @@ __latent_entropy struct task_struct *copy_process(
 	__cleanup_sighand(p->sighand);
 bad_fork_cleanup_fs:
 	exit_fs(p); /* blocking */
-bad_fork_cleanup_files:
-	exit_files(p); /* blocking */
 bad_fork_cleanup_semundo:
 	exit_sem(p);
 bad_fork_cleanup_security:
@@ -2625,6 +2626,8 @@ __latent_entropy struct task_struct *copy_process(
 	perf_event_free_task(p);
 bad_fork_sched_cancel_fork:
 	sched_cancel_fork(p);
+	/* ->release() of a file may need scx_fork_rwsem for write. */
+	exit_files(p); /* blocking */
 bad_fork_cleanup_policy:
 	lockdep_free_task(p);
 #ifdef CONFIG_NUMA

