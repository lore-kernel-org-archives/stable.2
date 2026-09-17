Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3A94A8434;
	Thu, 17 Sep 2026 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636670; cv=none; b=RSWjsFXcTps7Sb6qPBj4fzlUQOLMRq6Ta39DW9OSrk1DzTBkwOsT9sguRLCCMoz2ke+8bP4qcovzFCaZSHOrpajzCHUgI4+fRm7HSw7OOQ+0QX/23+VbdoHdj/MsbW1CJzqyq2SHdSqKyC+UENFDwTTMvVcnndAcDYwiEz5ZEi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636670; c=relaxed/simple;
	bh=pBR6wf6bmu0Jm0F8OERiga+ILWUwBiuisWeTmCb8FHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uFhEs6kM65/ltGem1nS7J74WqSbK1aDMrPAkc5YVj8z7As1eWzWe2+DZliuWaZ60dZcnMI38/epuhtnSeWxk+ymo/gPoeEBAdREzJpYdlTGtwREpOu4WolahpOVB0ObJdn8el5UGjxLhhCRUonEOv/TbOK8TdSV5QglH3O/iGLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mH9JQpLF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mH9JQpLF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFBB1F00893;
	Thu, 17 Sep 2026 09:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789636668;
	bh=EPB1oCaQg9LjyGJ/5+CjlUgVcO/m+4cCdFm+eGUyeHw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mH9JQpLFoVE/3Fx/BiHYhQZrcIlVEnaz12k3lAb7jS8XsHmuPJH9Rr5oBz95d2uMn
	 DRE2eMpDvecXvDEwA0nzLpEJzfgrZsqheiXaWLJNEA1/AETUL2n1OldYykGidL0MwS
	 A+jeuwC40Yut6xOHXRj36G7x4PDUTqGHgUfrQuSQ4vFRwba7UeU2gyOuVnZm967urp
	 Jh73Kby9cXfYIvObI3u0l+a5BNpXfsex0sCAWGV0+23BzhHvBq+n7bDp6IkncRpN6E
	 SXVvqYvuCMAOywpOVlm5qpJeJdLN7F8FXYqJgA9GUvgKNeVtYl9DvfICHKfM6seZhE
	 4ntW/RUrWCDvA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 17 Sep 2026 11:17:28 +0200
Subject: [PATCH v2 1/7] fork: refuse new threads while a coredump or an
 exec is in progress
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-work-coredump-fixes-v2-1-f3787fcda051@kernel.org>
References: <20260917-work-coredump-fixes-v2-0-f3787fcda051@kernel.org>
In-Reply-To: <20260917-work-coredump-fixes-v2-0-f3787fcda051@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, 
 io-uring@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3020; i=brauner@kernel.org;
 h=from:subject:message-id; bh=pBR6wf6bmu0Jm0F8OERiga+ILWUwBiuisWeTmCb8FHM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt3mDCcHq5woIPv34tD9h13q+wK1lJ79S+2hnuJnlKX
 bzr7FsyO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDaEi1MAJiKwiZFhQ+Dl31bqu96+VY21
 vskapfa0VlJRYUbps80Pd9rfeTaXlZHh+ncGJRvz3yybfwqYhCy4KDdb9GTluVAL9bq2SwcurfV
 mBAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Say a SQPOLL thread is a member of a thread-group that coredumps.
The coredump code uses zap_process() and sends SIGKILL. The SQPOLL
thread uses io_sqd_handle_event() and calls get_signal(). It removes
SIGKILL from the pending set and returns. The SQPOLL thread breaks out
of the loop and drains its own task work.

Any pending io_req_task_submit() with REQ_F_FORCE_ASYNC creates a new
worker when no other worker is free. So it ends up calling
create_io_thread() from a thread whose fatal signal is gone. That means
copy_process() allows the creation. It's also possible for an exiting
io-wq worker to push new work onto the SQPOLL thread.

zap_threads() counts the number of coredumping threads. The coredump
client waits in coredump_wait_inactive() until all threads in the
thread-group are parked. The new thread exits right away because the
workqueue is going down. It inherited PF_SIGNALED from its creator so
it links itself onto core_state->tasks in coredump_task_exit(). The
problem is that it then decrements "threads_remaining" even though
zap_process() never actually counted the new thread. So the count goes
to zero too early. So either the coredump misses the thread or it dumps
a thread that is still alive.

The same race exists during exec. de_thread() zaps the other threads
the same way and counts them in signal->notify_count, and a zapped user
worker that has already dequeued its SIGKILL can still clone while
de_thread() waits for that count. And once de_thread() has cleared
signal->group_exec_task the exec'ing thread itself runs task work in
io_uring_task_cancel() and a pending create_worker_cb() creates a
thread after the group was made single-threaded.

Close all of that in copy_process(). Refuse to create a thread while:

(1) SIGNAL_GROUP_EXIT is set (set together with core_state by zap_process()
(2) signal->group_exec_task is set
(3) while current is in execve

Conditions (1) and (2) are handled with siglock help which means
copy_process() and zap_process() synchronize on it. create_io_thread()
treats the failure as a failed task creation and doesn't retry.

Fixes: 3bfe6106693b ("io-wq: fork worker threads from original task")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/fork.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 10be4a0ecb3f..6cd167a2b27b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2491,8 +2491,10 @@ __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_core_free;
 	}
 
-	/* Let kill terminate clone/fork in the middle */
-	if (fatal_signal_pending(current)) {
+	/* Let kill or a group exit, exec or coredump abort clone/fork */
+	if (fatal_signal_pending(current) ||
+	    (current->signal->flags & SIGNAL_GROUP_EXIT) ||
+	    current->signal->group_exec_task || current->in_execve) {
 		retval = -EINTR;
 		goto bad_fork_core_free;
 	}

-- 
2.53.0

