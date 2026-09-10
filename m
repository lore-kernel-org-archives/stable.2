Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4663A388893
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058726; cv=none; b=U8CtKXsus0SBbEuDjKjTTWkB3VKxVY6Uyph1fYCpiTgHIj9K9WxBRhqDZ5YtTjUp38K2ZBAioXUUuFl6C8XtiAjN21/L5xvExJyy3qN/f2fClADv/LhG08v3BwZxyN3EAAfdEd4bIcD7TOcC1xz/UY8vtVoijEEScZNMKZl5yzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058726; c=relaxed/simple;
	bh=tvHzbcw30pbjhEJWNAWRaem0spdPcvtbzGwuV7nD/Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAH5l6nUuy+9uARUi/o2MHalMCakAdAGcgvzbLVviFOzRHcAgaTyT+36GwqohZPsh3fYNUNfYLJRHdhN9w55VuCyptdbFR9srxJicZxPGCYjjtgZo76+Aq6VVijmKwKyDigoSHEil/3TRGoS/AjdnMhifwlRA71+/meDzhjJBTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lb601A/X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lb601A/X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557DF1F000FF;
	Thu, 10 Sep 2026 16:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789058724;
	bh=eYCxIvJkcbgHrPUIS3ccwKbFvwJgCshMRVAvNALZuDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lb601A/XP/yfirL0GZ/r41V+IMn1YmbgMRpvxtFCzPXqHJEUFKO97ErKeI5ZR7KtO
	 FeJFLJODL7bsRfP50cwt5v7rD4ZrDzGpqZl68mBXutfC8POg9bxtRSx/nGrGdXYCxj
	 eFpHGl33gQtUiFHu9mKFXolWBPJdc6ZLjOfIjCteKcTbVuzZnNDXGFCGQyrhmy0mrC
	 jvmeOisYqnQ/DLWDbgDAadTtPO0lgucBdC+/fDlqzfr1jhdhXSDOZ/zAfoOhMGhfYe
	 2RZJDp0PIJrKX9zrMMUODK+8s6nMqqIm0J5DOKXDwt6IoAYDNWrhgx1Bj9agr29cvK
	 WOXaReLEXLTcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ian Rogers <irogers@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] perf/core: Fix deadlock in perf_mmap() failure path
Date: Thu, 10 Sep 2026 12:45:21 -0400
Message-ID: <20260910164522.1249555-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090946-pacify-trodden-af31@gregkh>
References: <2026090946-pacify-trodden-af31@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit c69df06e4e26e50611190ce04eab92c5cc261b61 ]

Ian noted that commit 77de62ad3de3 ("perf/core: Fix refcount bug and
potential UAF in perf_mmap") would cause a deadlock due to
event->mmap_mutex recursion.

This happens because we're now calling perf_mmap_close() under
mmap_mutex, while that function itself can also take mmap_mutex.

Solve this by noting that perf_mmap_close() is far more complicated
than we need at this particular point, since it deals with scenarios
that cannot happen in this particular case.

Replace the call to perf_mmap_close() with a very narrow undo for the
case of first-exposure. If this is not the first mmap(), there is no
race and it is fine to drop the lock and call perf_mmap_close() to
handle to more complicated scenarios.

Note: move the rb->mmap_user (namespace) handling into the rb
init/free code such that it does not complicate the mmap handling.

Fixes: 77de62ad3de3 ("perf/core: Fix refcount bug and potential UAF in perf_mmap")
Reported-by: Ian Rogers <irogers@google.com>
Closes: https://patch.msgid.link/CAP-5%3DfVJyVMZw%3DDqP53Kxg58nUmJ_0bxoaeOKAbC03BVc11HaA%40mail.gmail.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260326112821.GK3738786@noisy.programming.kicks-ass.net
Stable-dep-of: 58a8108bc73d ("perf: Fix use-after-free when perf mmap() revival races with the last munmap()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c        | 70 +++++++++++++++++++++++++++++--------
 kernel/events/internal.h    |  1 +
 kernel/events/ring_buffer.c |  2 ++
 3 files changed, 58 insertions(+), 15 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 04c9d49150931..b27d51a51ef37 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6737,6 +6737,7 @@ static void perf_mmap_open(struct vm_area_struct *vma)
 }
 
 static void perf_pmu_output_stop(struct perf_event *event);
+static void perf_mmap_unaccount(struct vm_area_struct *vma, struct perf_buffer *rb);
 
 /*
  * A buffer can be mmap()ed multiple times; either directly through the same
@@ -6752,8 +6753,6 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	mapped_f unmapped = get_mapped(event, event_unmapped);
 	struct perf_buffer *rb = ring_buffer_get(event);
 	struct user_struct *mmap_user = rb->mmap_user;
-	int mmap_locked = rb->mmap_locked;
-	unsigned long size = perf_data_size(rb);
 	bool detach_rest = false;
 
 	/* FIXIES vs perf_pmu_unregister() */
@@ -6848,11 +6847,7 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	 * Aside from that, this buffer is 'fully' detached and unmapped,
 	 * undo the VM accounting.
 	 */
-
-	atomic_long_sub((size >> PAGE_SHIFT) + 1 - mmap_locked,
-			&mmap_user->locked_vm);
-	atomic64_sub(mmap_locked, &vma->vm_mm->pinned_vm);
-	free_uid(mmap_user);
+	perf_mmap_unaccount(vma, rb);
 
 out_put:
 	ring_buffer_put(rb); /* could be last */
@@ -6994,6 +6989,15 @@ static void perf_mmap_account(struct vm_area_struct *vma, long user_extra, long
 	atomic64_add(extra, &vma->vm_mm->pinned_vm);
 }
 
+static void perf_mmap_unaccount(struct vm_area_struct *vma, struct perf_buffer *rb)
+{
+	struct user_struct *user = rb->mmap_user;
+
+	atomic_long_sub((perf_data_size(rb) >> PAGE_SHIFT) + 1 - rb->mmap_locked,
+			&user->locked_vm);
+	atomic64_sub(rb->mmap_locked, &vma->vm_mm->pinned_vm);
+}
+
 static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
 			unsigned long nr_pages)
 {
@@ -7056,8 +7060,6 @@ static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
 	if (!rb)
 		return -ENOMEM;
 
-	refcount_set(&rb->mmap_count, 1);
-	rb->mmap_user = get_current_user();
 	rb->mmap_locked = extra;
 
 	ring_buffer_attach(event, rb);
@@ -7207,16 +7209,54 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 			mapped(event, vma->vm_mm);
 
 		/*
-		 * Try to map it into the page table. On fail, invoke
-		 * perf_mmap_close() to undo the above, as the callsite expects
-		 * full cleanup in this case and therefore does not invoke
-		 * vmops::close().
+		 * Try to map it into the page table. On fail undo the above,
+		 * as the callsite expects full cleanup in this case and
+		 * therefore does not invoke vmops::close().
 		 */
 		ret = map_range(event->rb, vma);
-		if (ret)
-			perf_mmap_close(vma);
+		if (likely(!ret))
+			return 0;
+
+		/* Error path */
+
+		/*
+		 * If this is the first mmap(), then event->mmap_count should
+		 * be stable at 1. It is only modified by:
+		 * perf_mmap_{open,close}() and perf_mmap().
+		 *
+		 * The former are not possible because this mmap() hasn't been
+		 * successful yet, and the latter is serialized by
+		 * event->mmap_mutex which we still hold (note that mmap_lock
+		 * is not strictly sufficient here, because the event fd can
+		 * be passed to another process through trivial means like
+		 * fork(), leading to concurrent mmap() from different mm).
+		 *
+		 * Make sure to remove event->rb before releasing
+		 * event->mmap_mutex, such that any concurrent mmap() will not
+		 * attempt use this failed buffer.
+		 */
+		if (refcount_read(&event->mmap_count) == 1) {
+			/*
+			 * Minimal perf_mmap_close(); there can't be AUX or
+			 * other events on account of this being the first.
+			 */
+			mapped = get_mapped(event, event_unmapped);
+			if (mapped)
+				mapped(event, vma->vm_mm);
+			perf_mmap_unaccount(vma, event->rb);
+			ring_buffer_attach(event, NULL);	/* drops last rb->refcount */
+			refcount_set(&event->mmap_count, 0);
+			return ret;
+		}
+
+		/*
+		 * Otherwise this is an already existing buffer, and there is
+		 * no race vs first exposure, so fall-through and call
+		 * perf_mmap_close().
+		 */
 	}
 
+	perf_mmap_close(vma);
 	return ret;
 }
 
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index d9cc570830918..c03c4f2eea571 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -67,6 +67,7 @@ static inline void rb_free_rcu(struct rcu_head *rcu_head)
 	struct perf_buffer *rb;
 
 	rb = container_of(rcu_head, struct perf_buffer, rcu_head);
+	free_uid(rb->mmap_user);
 	rb_free(rb);
 }
 
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 20a9050237362..dc2aa2a7109ef 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -340,6 +340,8 @@ ring_buffer_init(struct perf_buffer *rb, long watermark, int flags)
 		rb->paused = 1;
 
 	mutex_init(&rb->aux_mutex);
+	rb->mmap_user = get_current_user();
+	refcount_set(&rb->mmap_count, 1);
 }
 
 void perf_aux_output_flag(struct perf_output_handle *handle, u64 flags)
-- 
2.53.0

