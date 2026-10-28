Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793201775;
	b=Do707gplET/DB607jswD40zwPPvL34clZ6FmFYLVMWvjCcIM1Sj+uqiJkDv43tq3VHyi
	 0Pi1jxrbPbUjbpNhUMA7pJrQzvn1i1sdvwm63KVRhAIRbwUT/quN831Yd0h7BmeTymVL2
	 P5UdzfVYYzLbUQ3jZpSPwFwaYlAekcPWwooFFvGj0QseiuAnrN8jHXGH6jpCYzlfEtaG6
	 kcEqREMs4PqJoap0lRLrlBZQW3ykQ82RcheKZXddyW0FapMCmkr+zXInnHSxXB5QshhsG
	 +K9XJZdOtcs6BLbmz6hUDDH5gvQ0BKcifzMtM7AGy57NrfQ3LO7QlqaIwZHKGX94hEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201775;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0N8eT8glS/RLVbHg1ps+ZMaooTmSZp3jZ0TQ+u+DQD0=;
	b=Bk7iz9hO78NHX4gglSr320kvZW8Q9WPLa6SczH8edYkvHPJqJfHOA1U8FlJEbdAoutj7
	 eiTf6iGeOjrEkpoeT5UfuYK7HacjM/Fqe6Op1TEhsZfJhxcVOlBQqMBmyiq/uodp7S+/c
	 sDpsdiv7tE19qLaOInqPqniBp7y12AtBF/xJpjNc341ExLdPaM6XkIl1CTgqw+wtbBNgC
	 FUXTCXrJDaTKN1jW5QVOMgTRgKIL8T2GpKlH5dBuQ85hm7RDx03BqPmA6KQ19FoJ3Cb1j
	 oAD81Fv9nOMUOyRknyVLKgzDP+kyw912T6lNtK6Vgm0NxM7bAHvidlRiy1bp4FOQjLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=aTuIVxVP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6670606A324
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=aTuIVxVP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55101F01254;
	Wed, 28 Oct 2026 15:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793201774;
	bh=0N8eT8glS/RLVbHg1ps+ZMaooTmSZp3jZ0TQ+u+DQD0=;
	h=Subject:To:Cc:From:Date;
	b=aTuIVxVPASeRkHKS5uklqaouWAxI3/GLki+Fw66Ige9WloA32Hkj50HwSfO065HeA
	 3Fyc9ve591B6539gIr3qqX4mnS4WI1GJWjG2+KdCsxG5vHbFOy8aF//dWotp49wp8B
	 4sDQxi8PZX1pQK7/fXh78w1iGLPolnRCMehYIdj8=
Subject: FAILED: patch "[PATCH] fork: release the files of a failed fork after" failed to apply to 5.15-stable tree
To: brauner@kernel.org,mason@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 28 Oct 2026 16:36:02 +0100
Message-ID: <2026102802-progress-trodden-c504@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 296a98c1fa50778c3b31eebed1a3f903f9684349
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102802-progress-trodden-c504@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

