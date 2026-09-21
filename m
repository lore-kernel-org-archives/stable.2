Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87264A49B5;
	Mon, 21 Sep 2026 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998327; cv=none; b=kPP6x5XjPvJKlORQvFJf3Go2kd89pvHf1bTy3eZwY9Fd+iJIwlfd8XiyVjkqgPZpEy9t2B7frUprXP5uXRJ2so92FwYNbxpvyIEamxMjEpqXec4qSaF379OVDrvz2fmNHoCsCq0Ilmj1wCOhrjUw988hiuR/F884rtgajV4K8Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998327; c=relaxed/simple;
	bh=NXtk4J120gvy6duSbM7CGMlQIgVMXPYHLccJxo13+TM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aUyiv8dSILibIZXNb8KSeY5RmgRgqTwZ3e+qH8xDaWCymBd5h13uyUvv6b2ysU+lcbewyCJ1YOg1sNFt/08hbSGDwdqIsF3gSysayPPLBwCayO5+0uekbC788Z/fsgm9+oYBv0Y+f8VYaIAv/IHNQkb4ZeN2WzjaLemP8Wl3Vag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXXdeRh3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXXdeRh3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575E61F000FF;
	Mon, 21 Sep 2026 13:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789998325;
	bh=b32xekZALDJ73u8pNgOkOniEszxsMWAgHksCs7g4tyE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VXXdeRh35T9i1/ADIdWf8z7aG6ksc04+VkB5STDx4Keu3VjrFeVir8HzGTUPSEFoQ
	 uYpVIZocN+hq6enflkH/uE+gY/AT4JY/eQZj2UobHgbyYaHUB8XEm2eWk16SOkIyjF
	 5GKp/nv7D2Jmbx/Y60Ra/3EjVm8pvfN0btMXoEmAOS84Tfm/EURd3qrwR1iZsXKQ5n
	 5fI07y6F3NyfvrpEWEbI5LkJKA0phbqx29KNvxt65faoYPOLP57nnWrNBmAUV3iZQw
	 iWC6yLOk/1s62qdSCtvpEMUwsUjSc2t+QPKIHEUnYa2Svs3Vm+RJ1f2G3LKcw1+pge
	 gVswbNbkcIy1A==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 21 Sep 2026 15:44:54 +0200
Subject: [PATCH v3 05/17] signal: don't retarget shared signals in a dying
 thread group
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-work-coredump-fixes-v3-5-8e4adb1619e6@kernel.org>
References: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
In-Reply-To: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Chris Mason <mason@kernel.org>, 
 linux-fsdevel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 linux-mm@kvack.org, io-uring@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1843; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NXtk4J120gvy6duSbM7CGMlQIgVMXPYHLccJxo13+TM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtNLlzePcG6a9a3w7tc8ydY3Fyl+UFjmkv3qySODjXP
 FdkwvXsNR2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATiWVjZNi+pjv63mODniep
 wecDuRav+6uZ9dp1Z6TLAW6hZYHHdj1j+B+tOd0vdlbJ5lZJh9qWhlsKXxiuZsleXvvuzrzv1tc
 PNnADAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

If the calling thread has blocked a signal then
retarget_shared_pending() slingshots a shared pending signal to a
sibling thread. Today it only skips PF_EXITING threads but not a
coredumping thread.

But if SIGNAL_GROUP_EXIT is set no thread in the thread-group can
dequeue such signals anymore as get_signal() sends SIGKILL to every
thread and prepare_signal() drops any other signal.

exit_signals() also returns early on SIGNAL_GROUP_EXIT. But neither
sigprocmask() nor the mask restore in sigtimedwait() do.

Say a thread sleeps in sigtimedwait() and a sibling thread crashes. The
sleeping thread gets woken by the zap call. It restores its mask on the
way out and retargets a signal that was queued for the coredumping
process. That means TIF_SIGPENDING is set on the coredumping task which
zap_threads() had cleared. So a blocking write sees TIF_SIGPENDING and
truncates the dump.

Stop retargeting signals when SIGNAL_GROUP_EXIT is set and avoid
needlessly truncating coredumps.

Fixes: e6fa16ab9c1e ("signal: sigprocmask() should do retarget_shared_pending()")
Cc: stable@vger.kernel.org
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/signal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index d8bb1f168055..c3bad983dd37 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3117,6 +3117,10 @@ static void retarget_shared_pending(struct task_struct *tsk, sigset_t *which)
 	sigset_t retarget;
 	struct task_struct *t;
 
+	/* Nobody dequeues them in a dying group, see get_signal(). */
+	if (tsk->signal->flags & SIGNAL_GROUP_EXIT)
+		return;
+
 	sigandsets(&retarget, &tsk->signal->shared_pending.signal, which);
 	if (sigisemptyset(&retarget))
 		return;

-- 
2.53.0

