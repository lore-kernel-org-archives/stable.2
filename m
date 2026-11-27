Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804962;
	b=QSvCIAYdSr13x6q1yCxAln+7NOwz3zH7YllV7EEOqHpZRMcF/3IZYwcFiZzZOWM6pr7H
	 5wbk76uSnHUzZ2maR3gc/+j1jrUeLursJyUKJfuwAHyslZN7qbqyAbD8ck/dy7A1vy2IA
	 RMdJrIX41rXUdh3/0u6BcTrnNqdAeR3Bcw4fL2THuzI7kZJhSP9jJTCXZ2JGrX+SMaGBp
	 4VuDKG3ZI7N4IsmKnInKKx8bu1yAAuQ88+SuiRYr4bMszP/ne68oPiyTkXp4Vq8D3mKUs
	 8tCloksoajag862iUphnhOPst2GS5W7icUkUiXXzPyMR6y8kPyaePViNNDak0w2dRyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804962;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=2On8z9YrZ2YRUF1avFAjveI30LuxpYB7VBbLzLcIbmk=;
	b=ath/9qGufDsUmSh+O25K4MxZTOpAgAsS7a92JJNpDhw63XQEW4rcHxPlZuJUAljRTA4X
	 VLUN18xxAWFtlnQAwSQLNKCBX+L7ccJKJhUJqDOMDplNfNNMRirQi/FB+n+pWHWWXFfR0
	 Zim/NF3fEF8ycu1NaqVyezI4t7pd+8iV88MFnvvjqB+qVZJicugJsi/WHo8mubo8KuKKi
	 9gY89utk/LorxrJLQ+mcN7TslBKjRNlfzzTrVETx+pdUPzPII+0HjprMlASYp+oSloE01
	 GRBB83x+C4q/6BSeSKXEqaKc+VvQEvT25y+YZZcfj0jHXzcm4nWuo5feOtVFpaFAu/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GQSA6Ro8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7464606A680;
	Fri, 27 Nov 2026 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GQSA6Ro8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711B01F00937;
	Fri, 27 Nov 2026 18:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795804962;
	bh=2On8z9YrZ2YRUF1avFAjveI30LuxpYB7VBbLzLcIbmk=;
	h=Date:From:To:Cc:Subject:References;
	b=GQSA6Ro8rErp5qg6Vr4AJ1iaH64Z7rJ3wKfNyC8ec+opzmzQu2xJj+SWHUosjcbiN
	 fdRKqhsnoXE4Z20vBkma/z2QEfkPSitf8S0N2pCJjaijsLCKFb9Iu5EOkt0BQbDncG
	 NzdwOw5n/QeUzDSk/5IhMld6OM1g3i/6u4igqLpJt7rGEQsA08r5Y/wDhGNKFX8eMP
	 AD79dgiw6SB8jDiw/G8SCW1jgDmMLU80K7lCpE3x+V5h6oKbUuzJ9A/P9FCP8Y31cZ
	 8Oti9JZWTyqUiOwnVpoEh1tJMtkw5iYzk3XsItEsCKuXIJquNxxJ+8+uvbZXHhPLgm
	 zoSZmbQFAMkVg==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xX0u9-000000085Yo-38Ko;
	Fri, 27 Nov 2026 13:42:41 -0500
Message-ID: <20261127184241.554209298@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 27 Nov 2026 13:42:04 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Jeff Barnes <jeffbarnes@linux.microsoft.com>,
 Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-linus][PATCH 1/5] tracing/user_events: Fail fork when event state duplication fails
References: <20261127184203.439481361@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Jeff Barnes <jeffbarnes@linux.microsoft.com>

Registered user events are retained across fork, but duplicating their
state for a child with a separate mm can fail. Both user_event_mm_dup() and
user_events_fork() currently return void, so allocation failure silently
creates a child without the inherited registration state.

The child can consequently retain a stale copy-on-write enable word and
miss later event enable and disable updates.

Return an error from user_event_mm_dup() and user_events_fork(), and
perform the duplication in copy_process() while failure can still be
unwound. Return -ENOMEM when the child user_event_mm or any of its enablers
cannot be duplicated.

Add a cleanup path so successfully acquired user-events state is removed if
a later fork operation fails. Preserve the existing CLONE_VM behavior and
its task reference accounting.

A deterministic allocation-failure test on upstream master previously
allowed fork() to succeed while the child missed an enablement update. With
this change, the same fork fails with ENOMEM. The complete user_events ABI
suite passes.

Cc: stable@vger.kernel.org
Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
Link: https://patch.msgid.link/20261002222639.1964370-1-jeffbarnes@linux.microsoft.com
Signed-off-by: Jeff Barnes <jeffbarnes@linux.microsoft.com>
Reviewed-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/user_events.h      | 16 +++++++---------
 kernel/fork.c                    |  8 ++++++--
 kernel/trace/trace_events_user.c |  8 +++++---
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/include/linux/user_events.h b/include/linux/user_events.h
index 57d1ff006090..75f184126727 100644
--- a/include/linux/user_events.h
+++ b/include/linux/user_events.h
@@ -27,28 +27,26 @@ struct user_event_mm {
 	struct rcu_work		put_rwork;
 };
 
-extern void user_event_mm_dup(struct task_struct *t,
-			      struct user_event_mm *old_mm);
+int user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm);
 
 extern void user_event_mm_remove(struct task_struct *t);
 
-static inline void user_events_fork(struct task_struct *t,
-				    u64 clone_flags)
+static inline int user_events_fork(struct task_struct *t, u64 clone_flags)
 {
 	struct user_event_mm *old_mm;
 
 	if (!t || !current->user_event_mm)
-		return;
+		return 0;
 
 	old_mm = current->user_event_mm;
 
 	if (clone_flags & CLONE_VM) {
 		t->user_event_mm = old_mm;
 		refcount_inc(&old_mm->tasks);
-		return;
+		return 0;
 	}
 
-	user_event_mm_dup(t, old_mm);
+	return user_event_mm_dup(t, old_mm);
 }
 
 static inline void user_events_execve(struct task_struct *t)
@@ -67,9 +65,9 @@ static inline void user_events_exit(struct task_struct *t)
 	user_event_mm_remove(t);
 }
 #else
-static inline void user_events_fork(struct task_struct *t,
-				    u64 clone_flags)
+static inline int user_events_fork(struct task_struct *t, u64 clone_flags)
 {
+	return 0;
 }
 
 static inline void user_events_execve(struct task_struct *t)
diff --git a/kernel/fork.c b/kernel/fork.c
index 5efceb8d58a7..cdba6ba6335d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2328,9 +2328,12 @@ __latent_entropy struct task_struct *copy_process(
 	retval = copy_mm(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_signal;
-	retval = copy_namespaces(clone_flags, p);
+	retval = user_events_fork(p, clone_flags);
 	if (retval)
 		goto bad_fork_cleanup_mm;
+	retval = copy_namespaces(clone_flags, p);
+	if (retval)
+		goto bad_fork_cleanup_user_events;
 	retval = copy_io(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_namespaces;
@@ -2598,7 +2601,6 @@ __latent_entropy struct task_struct *copy_process(
 
 	trace_task_newtask(p, clone_flags);
 	uprobe_copy_process(p, clone_flags);
-	user_events_fork(p, clone_flags);
 
 	copy_oom_score_adj(clone_flags, p);
 
@@ -2625,6 +2627,8 @@ __latent_entropy struct task_struct *copy_process(
 		exit_io_context(p);
 bad_fork_cleanup_namespaces:
 	exit_nsproxy_namespaces(p);
+bad_fork_cleanup_user_events:
+	user_events_exit(p);
 bad_fork_cleanup_mm:
 	sched_cache_fork_cleanup(p);
 	if (p->mm) {
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index e29e1c772aa7..c561443f7947 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -868,7 +868,7 @@ void user_event_mm_remove(struct task_struct *t)
 	queue_rcu_work(system_percpu_wq, &mm->put_rwork);
 }
 
-void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
+int user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
 {
 	struct user_event_mm *mm = user_event_mm_alloc(t);
 	struct user_event_enabler *enabler;
@@ -877,7 +877,7 @@ void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
 	t->user_event_mm = NULL;
 
 	if (!mm)
-		return;
+		return -ENOMEM;
 
 	rcu_read_lock();
 
@@ -889,10 +889,12 @@ void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
 	rcu_read_unlock();
 
 	user_event_mm_attach(mm, t);
-	return;
+	return 0;
 error:
 	rcu_read_unlock();
 	user_event_mm_destroy(mm);
+
+	return -ENOMEM;
 }
 
 static bool current_user_event_enabler_exists(unsigned long uaddr,
-- 
2.53.0
