Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793212519;
	b=Yk//RDApvYduv9I1hzjpvKX5XQpk2AJcu21qpADaO7mYRme2qp5dHds2zrc/JVYWXCSG
	 x2E2GwRWwxD+6Kx/YC2Kl8xYDgCU3pVKN+dsZjVZEfFCthLIPXJetD2rSjOg6fTNtPHG0
	 8asMEZuSqvVoPDcoCTl99jpinL4Y9MFH/+ha2Y6aiYsyGnpT80LM6tgPFZ1GhI2LiZMBN
	 9AocTeN6rZmsmWbJKo4fi0OGeA+/QsrR/4t4/e6Ob6NE7wwi3stNE2t9uE/Gk9yZXwyNY
	 biISSIa06H1mHD4NXk7Tg+C0zZwuftT2QPtuyu0Ec5h5vIA3WTuapw5h+mEduT//WKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793212519;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rVb6hAD/54DYNjEeuOXpuBsBpH6T2qGeIYMqAnBgfSk=;
	b=rQD8U6p2Q5XFKALD4OxXnFiBbCiAaRRbfqrGHppxBYhRruWbfXkBfmGQ2xvL5G+cz2b3
	 uSVXIMjQ9anhH/mirZUKRONJ5v4OxCtPvgYF+JkDHR0xn3XYUtqLHg6xiodgEZscxbHSS
	 A83l7lu+K4S5OG6RzrZR3uqJRHyUUAxTu2zcWYpHsJ0AcB+c6s4EV3U7aw8WeMK2muTkK
	 EvCsj7+oUoa2voKGNFP4ocwwtEi6SsA5EmLGm9THXeGtsOkU9A+w0RGfNFlsbV/5Rx4MP
	 6tfjFHPHYISBDMRCKvdygdTAalgsBXkM84rgnK7jDUEMqJIbP+UQ4aX1fiaieW6Zzaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KUozNoh3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC61606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 18:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KUozNoh3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD4F1F01825;
	Wed, 28 Oct 2026 18:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793212519;
	bh=rVb6hAD/54DYNjEeuOXpuBsBpH6T2qGeIYMqAnBgfSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KUozNoh3DhaRvpHqAlzdUdnDE1tSZfSiOt7tH7RDf4DphPgKJD2G+FThQwCBUfsu4
	 lNdUaAsl65Z0M12yYBBihv29CCM1xisEBvt32nFRnwICTwpIxq/ucJd6SMR5TDkMM1
	 N6Xpsp4ce75pyc1glrNjnNlu+t4bmQ2xDBIZH6me46bWJm4pI0cagAhZ1vczLgKgHN
	 n6aXHuDHhKQRrczlg2SuKRYVUz0UoeLJSBPkfa1bVhIUlFHnyWhsvtauAHBYPFho8m
	 BxTvWmsZGTCdYOODXEZuZ4G+lewRkdvGOXAJzFwvovdcT59Z6vRTGzDwDfshaC+8Dz
	 Yt4BfV8O75N6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Chris Mason <mason@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] fork: release the files of a failed fork after sched_cancel_fork()
Date: Wed, 28 Oct 2026 14:35:16 -0400
Message-ID: <20261028183504.1718588-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028183504.1718588-1-sashal@kernel.org>
References: <2026102801-startle-saddled-529f@gregkh>
 <20261028183504.1718588-1-sashal@kernel.org>
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
index 7d5ec03d7caca..88315fdd8f847 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1799,6 +1799,7 @@ static int copy_files(unsigned long clone_flags, struct task_struct *tsk,
 
 	if (clone_flags & CLONE_FILES) {
 		atomic_inc(&oldf->count);
+		tsk->files = oldf;
 		return 0;
 	}
 
@@ -2401,6 +2402,8 @@ __latent_entropy struct task_struct *copy_process(
 	INIT_LIST_HEAD(&p->sibling);
 	rcu_copy_process(p);
 	p->vfork_done = NULL;
+	/* Set by copy_files(), exit_files() on the error path skips NULL. */
+	p->files = NULL;
 	spin_lock_init(&p->alloc_lock);
 
 	init_sigpending(&p->pending);
@@ -2503,7 +2506,7 @@ __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_cleanup_semundo;
 	retval = copy_fs(clone_flags, p);
 	if (retval)
-		goto bad_fork_cleanup_files;
+		goto bad_fork_cleanup_semundo;
 	retval = copy_sighand(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_fs;
@@ -2782,8 +2785,6 @@ __latent_entropy struct task_struct *copy_process(
 	__cleanup_sighand(p->sighand);
 bad_fork_cleanup_fs:
 	exit_fs(p); /* blocking */
-bad_fork_cleanup_files:
-	exit_files(p); /* blocking */
 bad_fork_cleanup_semundo:
 	exit_sem(p);
 bad_fork_cleanup_security:
@@ -2794,6 +2795,8 @@ __latent_entropy struct task_struct *copy_process(
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

