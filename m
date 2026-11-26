Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795693557;
	b=LfFcmiTmMycmjcEynT6UOFjijd3msuITm3oSoH5I4rr/jZ/9aD79NUzTt3WyialGAs3N
	 hBmjktagE/l2IvY/dEzmQRUoiz9xhq2L36zLB9lyNY84Zf2S0283d4pPTVqgN9hI68EQ0
	 JsAJ1JwN0HkWFVpS3vUTy1eZ9Ahk7liTevtdK6uINABnSpoRMR6s1k8RbMFFWFDWy3weF
	 zO2kXaRppS1kATwGaO8lojzQ6CU74NvyeWiBnXrNoE2KisIpbxa+8MsOE9Qtk4/K/avTN
	 pb0Lb+n0wdGeNv4BsMHOz9n7C5FkEaq28zcKm2/l+XgdrMehQrWzUP9Ge5QDWlWQ92g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693557;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=FNKns3gyFAdDED/1Hf1/425AjRowkLWFqvQBq4QUpFA=;
	b=HRmMp5tZ5MzdkXOjba0tGuPTnPsauXaFEmvgxbWrRe3MirIPIPDXOUVeVAwasZ1yVVdP
	 wb0d5RpqzZitCKS5oAiIjlt+WKdstmzRllG3GPgypZ15e91gIYa2b4M6mbkmmumeE64sZ
	 arfdiKotCoP5vNOErSrj6hbZJtVzemnX6qkmM2WSuS34rrcRnk5tkSh+1t8GYT9/fVCBT
	 jEyq5O7IU+nWa8rGmnYMHVJl3ucAi4gMlGUEp0bVMELZfm1xNvuUhZbemTtuOLAQoAVzw
	 Pyr20KAQOsPu/NpBcGl0b7gSnZqPTa5h9b6mh3Pf/kvlRi74TVS+tPV6hmzXjbikNkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HL6iAbdU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3871F606A32A;
	Thu, 26 Nov 2026 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HL6iAbdU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFED61F000C6;
	Thu, 26 Nov 2026 11:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795693556;
	bh=FNKns3gyFAdDED/1Hf1/425AjRowkLWFqvQBq4QUpFA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HL6iAbdUYL4nJtPp2xIxIny+mNpjDhogMmtqxgPcySbU7VjHLr6/nbLQl5Zdvjw6E
	 fjya6FBooRr/NS33BviQSJhVL0lxhKH5p6peiH79m0YBtS+o0D4o2KVJTNnqnXXEWN
	 ha6oyclICvJ0rnHKM6EvNFrflNIpksd8+qQw/V+Cc1F9QUMyvw4JJhE7msxQc/p9T7
	 N8Llmsgk2CNoE+PruZG3zjE9Wd2TmqErWmD1gKZ61Ocze2o85jvd692rl9qBlIwfiQ
	 EBy6NGaQ4xdJXOlB4p4CNOgyTuZueoQLQ7hSth1GgDYCjyEf2kv9hYhz5/MCEQ6Uq7
	 RLAIY1aqgoEHw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 26 Nov 2026 12:45:37 +0100
Subject: [PATCH 1/2] perf: look up address filter files without ctx->mutex
 held
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-work-exec-update_lock-leftovers-v1-1-1024b26792bc@kernel.org>
References: <20261126-work-exec-update_lock-leftovers-v1-0-1024b26792bc@kernel.org>
In-Reply-To: <20261126-work-exec-update_lock-leftovers-v1-0-1024b26792bc@kernel.org>
To: linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jann Horn <jannh@google.com>, 
 linux-kernel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=7014; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KBYOMBwCQRoT9CyHO2JsIyAh19vNc1S8oSOwZ+1EmdY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRzSL8+7rPj1fv394z9z+2ddbpebO0LyW7fBMkjp7X+r
 t48Wzz9U0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE+NIZGXrXch/pSP1zg0Xv
 +E7dR596f0wNe+6Qt6Z6818r4/QYTU9Ghq/rIoULl+3x4FR7O59hQcwT0YvXI9Q+KOvvyWLJTpL
 dxAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

PERF_EVENT_IOC_SET_FILTER parses the address filters with the mutex of
the event's context held. A filter can name a file and the parser looks
that file up with kern_path(). So the mutex is held for as long as the
lookup takes and on a FUSE filesystem it's the caller who decides how
long that is.

Since commit 2e498d0a74e5 ("perf: Add support for event removal on
exec") perf_event_exec() takes that mutex with exec_update_lock held
whenever the task has a perf context. So an exec of the task the event
counts for hangs past the point of no return until the lookup is done
and can't be killed. And everyone who needs the exec_update_lock of the
task waits with it.

It gets worse. Since commit 6255da28d4bb ("proc: protect
ptrace_may_access() with exec_update_lock (FD links)") looking up
/proc/<pid>/exe takes the exec_update_lock of the task. So with such a
file in a filter the ioctl takes the two locks the other way round:

  WARNING: possible circular locking dependency detected
  ------------------------------------------------------
  perf-addr-filte/113 is trying to acquire lock:
  (&sig->exec_update_lock){++++}-{4:4}, at: call_proc_get_link+0x4f/0x110

  but task is already holding lock:
  (&ctx->mutex){+.+.}-{4:4}, at: perf_event_ctx_lock_nested+0xb2/0x200

         CPU0                    CPU1
         ----                    ----
    lock(&ctx->mutex);
                                 lock(&sig->exec_update_lock);
                                 lock(&ctx->mutex);
    rlock(&sig->exec_update_lock);

and an exec of the task deadlocks with it:

  task:exec-task       state:D pid:114
  Call Trace:
   __schedule+0x53e/0x13f0
   schedule+0x36/0x100
   schedule_preempt_disabled+0x11/0x20
   __mutex_lock+0x7bf/0x11f0
   perf_event_exec+0xb9/0x640
   begin_new_exec+0x622/0xf90
   load_elf_binary+0x12a/0x1990
   bprm_execve+0x39d/0x870
   do_execveat_common.isra.0+0x165/0x180
   __x64_sys_execve+0x38/0x50
   do_syscall_64+0x110/0x600
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  task:paf-setter      state:D pid:116
  Call Trace:
   __schedule+0x53e/0x13f0
   schedule+0x36/0x100
   schedule_preempt_disabled+0x11/0x20
   rwsem_down_read_slowpath+0x186/0x5f0
   down_read_killable+0x78/0x1b0
   call_proc_get_link+0x4f/0x110
   proc_pid_get_link+0x3c/0x70
   pick_link+0x52b/0x640
   step_into_slowpath+0x16a/0x3a0
   path_lookupat+0x169/0x2e0
   filename_lookup+0x124/0x230
   kern_path+0x2c/0x50
   _perf_ioctl+0xbd9/0xea0
   perf_ioctl+0x50/0x90
   __x64_sys_ioctl+0xb4/0x100
   do_syscall_64+0x110/0x600
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

The parser doesn't need the mutex. So drop it while the filters are
parsed like perf_event_set_filter() already does for the filter of a
tracepoint. The pmu may be unregistered in the meantime so check again
whether the event has been revoked once the mutex is back.

The parser bumped the event's count of file based filters as it went
along and looked at event->ctx->task. Count in a local, store that when
the new filters are installed and test PERF_ATTACH_TASK instead.

This also makes the count exact. It was only ever reset when a set of
filters was refused. So once an event had a file based filter every
later set took the mmap lock of the task and for a task without an mm
the new ranges were never written.

Fixes: 2e498d0a74e5 ("perf: Add support for event removal on exec")
Fixes: 6255da28d4bb ("proc: protect ptrace_may_access() with exec_update_lock (FD links)")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/events/core.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e870f12c3ad81..7ee954bc14dfb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12165,7 +12165,8 @@ static const match_table_t if_tokens = {
  */
 static int
 perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
-			     struct list_head *filters)
+			     struct list_head *filters,
+			     unsigned int *nr_file_filters)
 {
 	struct perf_addr_filter *filter = NULL;
 	char *start, *orig, *filename = NULL;
@@ -12277,7 +12278,7 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
 				 * different processes.
 				 */
 				ret = -EOPNOTSUPP;
-				if (!event->ctx->task)
+				if (!(READ_ONCE(event->attach_state) & PERF_ATTACH_TASK))
 					goto fail;
 
 				/* look up the path and grab its inode */
@@ -12292,7 +12293,7 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
 					     ->i_mode))
 					goto fail;
 
-				event->addr_filters.nr_file_filters++;
+				(*nr_file_filters)++;
 			}
 
 			/* ready to consume more filters */
@@ -12323,6 +12324,8 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
 static int
 perf_event_set_addr_filter(struct perf_event *event, char *filter_str)
 {
+	struct perf_event_context *ctx = event->ctx;
+	unsigned int nr_file_filters = 0;
 	LIST_HEAD(filters);
 	int ret;
 
@@ -12330,14 +12333,30 @@ perf_event_set_addr_filter(struct perf_event *event, char *filter_str)
 	 * Since this is called in perf_ioctl() path, we're already holding
 	 * ctx::mutex.
 	 */
-	lockdep_assert_held(&event->ctx->mutex);
+	lockdep_assert_held(&ctx->mutex);
 
 	if (WARN_ON_ONCE(event->parent))
 		return -EINVAL;
 
-	ret = perf_event_parse_addr_filter(event, filter_str, &filters);
+	/*
+	 * Parsing the filters looks up the files they refer to. That can
+	 * block for as long as the filesystem likes and a lookup below /proc
+	 * takes exec_update_lock which nests outside of ctx->mutex. So don't
+	 * hold ctx->mutex for it. As per perf_event_ctx_lock() we already
+	 * have a reference on ctx and an event with address filters isn't
+	 * moved to another context.
+	 */
+	mutex_unlock(&ctx->mutex);
+	ret = perf_event_parse_addr_filter(event, filter_str, &filters,
+					   &nr_file_filters);
+	mutex_lock(&ctx->mutex);
 	if (ret)
-		goto fail_clear_files;
+		return ret;
+
+	/* The pmu may have gone away while ctx->mutex was dropped. */
+	ret = -ENODEV;
+	if (event->state <= PERF_EVENT_STATE_REVOKED)
+		goto fail_free_filters;
 
 	ret = event->pmu->addr_filters_validate(&filters);
 	if (ret)
@@ -12345,6 +12364,7 @@ perf_event_set_addr_filter(struct perf_event *event, char *filter_str)
 
 	/* remove existing filters, if any */
 	perf_addr_filters_splice(event, &filters);
+	event->addr_filters.nr_file_filters = nr_file_filters;
 
 	/* install new filters */
 	perf_event_for_each_child(event, perf_event_addr_filters_apply);
@@ -12353,10 +12373,6 @@ perf_event_set_addr_filter(struct perf_event *event, char *filter_str)
 
 fail_free_filters:
 	free_filters_list(&filters);
-
-fail_clear_files:
-	event->addr_filters.nr_file_filters = 0;
-
 	return ret;
 }
 

-- 
2.53.0

