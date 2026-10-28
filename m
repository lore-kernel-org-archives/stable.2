Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793216617;
	b=HBh07LHaUmOoJKfz6xOQAMII/auHdbcBmQjVLYCIqjZHf+TNik/Eab7CkHvrwf/VzmQx
	 8oi45Vvcoq3lLlejKA0nE38mp68BB8eNpCOIs92a3T4PwrIiOAjbStODObYfxUXdtJf+c
	 KoCwQhsldGXpYEVFagoLsHICEfbc66Ep5wEtn+MNhlrj62EDr5Mh/XVbbGpgi11d7/zeJ
	 KUDzRPdFi1Pm491UXEnkzDyU+2tN4SmyquE+952bX9W/kKRgC2GBxIoqSuDUAPjUjRire
	 93YtjFPAt0pYdEJqcBQd5FdvTYPjfnkW3bbLNKVHvbIcofuvgJVqsXlckXBmNkc7yPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793216617;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GctOGWF+MGHHlKuM+rkMHlIP4T6r5rESJqlr7XA6+Hc=;
	b=u+ECxxpgf2XKfE2Ej/saqNcrYDwFAiDGaOoRakAmVqkCpyQg21ZqVyzOo3Kx+rezdAAc
	 5m49k3cIPEQqtfpch4ingJtzbyrBNID51GWgTW6emplYd6l2r8s/AseEZNp+ob9lYA8RC
	 A/brWSR4P1L3Zt5rYd7GdLwsfLHaQLSkzbPbf6+axsTQUTbcMKmVuv8pUU4d+v3fDAncX
	 debQwT5kNDaQPj0vJQyN2gwi/BBYr6iep4g4jZ0pchazmC2YaZ5UQKpNINLZ4uxefMKd7
	 z21lrL4PcycoKRZdaThcf6R1Tv/AO03gy9BesKqBkRNdnect2NV7TGgZrhs/xhEPDxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DhLK869P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB41606A322
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 19:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DhLK869P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CBD1F01825;
	Wed, 28 Oct 2026 19:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793216616;
	bh=GctOGWF+MGHHlKuM+rkMHlIP4T6r5rESJqlr7XA6+Hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DhLK869Pm3wceRNzOGasJkivKMd37K0bOFeJ39OAOSQSYmW15fIbbsH1Pn1vJRGUM
	 nMA7vyE1GKHNPREHCabmE2JQPnn5Nr1l0QOi63GTBQ5jIwOZdcIdlqP+gspVEI9ZRv
	 9X+jQ4+ywKWKigeboFVyQlDtEWl9NNiuReEptrrp40W2bKmAD5DbdB0E7/4dfNnHeP
	 Jh6Z4hceJk/fpqagdxMFi0LOBe++2anpY7Kf0eXQo4OdubgjinfHTbLmURku03tyPc
	 DIg4YHkf13WQt+mRD+yN0qWAKfUmoECob8PQY/gfKlATGxfE6XsByz1XnrheubRwvU
	 fLzr5EQxyQPOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Chris Mason <mason@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] fork: release the files of a failed fork after sched_cancel_fork()
Date: Wed, 28 Oct 2026 15:43:33 -0400
Message-ID: <20261028194315.2086000-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028194315.2086000-1-sashal@kernel.org>
References: <2026102802-progress-trodden-c504@gregkh>
 <20261028194315.2086000-1-sashal@kernel.org>
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
index 8f925267e9c2d..032b969e32b18 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1567,6 +1567,7 @@ static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
 
 	if (clone_flags & CLONE_FILES) {
 		atomic_inc(&oldf->count);
+		tsk->files = oldf;
 		return 0;
 	}
 
@@ -2199,6 +2200,8 @@ static __latent_entropy struct task_struct *copy_process(
 	INIT_LIST_HEAD(&p->sibling);
 	rcu_copy_process(p);
 	p->vfork_done = NULL;
+	/* Set by copy_files(), exit_files() on the error path skips NULL. */
+	p->files = NULL;
 	spin_lock_init(&p->alloc_lock);
 
 	init_sigpending(&p->pending);
@@ -2297,7 +2300,7 @@ static __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_cleanup_semundo;
 	retval = copy_fs(clone_flags, p);
 	if (retval)
-		goto bad_fork_cleanup_files;
+		goto bad_fork_cleanup_semundo;
 	retval = copy_sighand(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_fs;
@@ -2571,8 +2574,6 @@ static __latent_entropy struct task_struct *copy_process(
 	__cleanup_sighand(p->sighand);
 bad_fork_cleanup_fs:
 	exit_fs(p); /* blocking */
-bad_fork_cleanup_files:
-	exit_files(p); /* blocking */
 bad_fork_cleanup_semundo:
 	exit_sem(p);
 bad_fork_cleanup_security:
@@ -2583,6 +2584,8 @@ static __latent_entropy struct task_struct *copy_process(
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

