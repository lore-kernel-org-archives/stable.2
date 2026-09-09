Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EB83AD501
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947190; cv=none; b=ZrB8Q4tX74oUgu5k2OF6s1rAAdt8Vwyo4rMFRwY2HWtOY6FrZ74mbJs4JRrnhRtmEQQ9Lfu9hwRRSIkuS25pBIqcBg2lWl62y5A/eHtXT50pjXYTX/MY1RzDwEIsoZgb36DtD02LbmzwEe9pS3JsvWh0+rusP1n2WztGXxjqYHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947190; c=relaxed/simple;
	bh=eGhxg8v3S0dk4vuBBGWSdGyl7SSld4ou8tNWDTiaBF4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mG+7P3D6fw7zRPS2D5uz7GHdhcfLPwU2hpU2j5cTCoh22suUA/2RGUUt+SJVK+H61ncOSWjaGVZYWdqeEexV+g5cBCYM41AK1FeCQXU42wmvPFMmzK8liFyEYm25FPgKjlnaWDFr8pglCnsJuLnjCD4vl2aCFYeRl/yF99cK2F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hjFmewsR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hjFmewsR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88091F00A3D;
	Wed,  9 Sep 2026 09:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788947188;
	bh=Dbv4a1UN8vEzbAbG8S1eJvHqJIkvKeVaYct7FPpOPI4=;
	h=Subject:To:Cc:From:Date;
	b=hjFmewsR5NJQSaEb4Wx+Vqh3Kfz4TTVtXyTHhpiuJWX0bfiTIDSf80j0lcc85OXXS
	 Kl+OkGyyHRUWS51HDPd2Id38yR7XKixjVsioo4x3UyXulxGJeo0C8E1Er2vYip6g1t
	 ejwhHheGTOT4pDZDC3Wg0jqnKIwRId9x1kzzdePg=
Subject: FAILED: patch "[PATCH] perf: Fix use-after-free when perf mmap() revival races with" failed to apply to 6.18-stable tree
To: yilinzhang@moonshot.ai,bug-report@moonshot.ai,peterz@infradead.org,shiweiming@moonshot.ai,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 11:39:47 +0200
Message-ID: <2026090946-pacify-trodden-af31@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 58a8108bc73de0740d5b88150465d6690ea5f85f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090946-pacify-trodden-af31@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 58a8108bc73de0740d5b88150465d6690ea5f85f Mon Sep 17 00:00:00 2001
From: Yilin Zhang <yilinzhang@moonshot.ai>
Date: Tue, 1 Sep 2026 00:21:55 +0800
Subject: [PATCH] perf: Fix use-after-free when perf mmap() revival races with
 the last munmap()

perf_mmap_close() drops rb->mmap_count *without* holding
event->mmap_mutex (the refcount_dec_and_test() right before the
refcount_dec_and_mutex_lock() of event->mmap_count). A concurrent
perf_mmap_rb() can slot its entire "revival" path into that window
(perf_mmap holds event->mmap_mutex for its whole duration, including
rb_alloc):

  munmap side (perf_mmap_close)          mmap side (perf_mmap_rb)
  -----------------------------------    --------------------------------
  rb->mmap_count 1 -> 0   (no lock)      (holds event->mmap_mutex)
                                         inc_not_zero(rb->mmap_count) fails
                                         ring_buffer_attach(event, NULL)
                                         rb_alloc() + attach new rb
                                         refcount_set(&event->mmap_count, 1)
  lock; event->mmap_count 1 -> 0
  ring_buffer_attach(event, NULL)
  ring_buffer_put() -> frees the *new* rb

The revival's refcount_set(&event->mmap_count, 1) is an invisible
1 -> 1 write: the close frees the just-revived buffer although the
other process still has it mapped -- a page-level use-after-free
allowing local privilege escalation to root by any unprivileged user
(default kernel.perf_event_paranoid=2).

Swap the order of the two counter updates: event->mmap_count is
dropped first via refcount_dec_and_mutex_lock(), so its 1 -> 0
transition and the ring_buffer_attach() stay serialized with
perf_mmap(). rb->mmap_count == 0 then implies every event using the
buffer is detached already, so the result of the rb->mmap_count drop
can gate the remaining teardown directly and detach_rest is no longer
needed.

An earlier fix for this race from Kyle Zeng and David Lee takes
event->mmap_mutex around both counter updates [0]; here the not-last
close stays lockless.

Fixes: 59741451b49c ("perf: Identify the 0->1 transition for event::mmap_count")
Reported-by: Kimi Security Team <bug-report@moonshot.ai>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Co-developed-by: Weiming Shi <shiweiming@moonshot.ai>
Signed-off-by: Weiming Shi <shiweiming@moonshot.ai>
Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/linux-perf-users/20260804060931.711308-1-david.lee@trailofbits.com/ [0]
Cc: <stable@vger.kernel.org>
Cc: stable@vger.kernel.org # 6.18+
Link: https://patch.msgid.link/20260831162155.1437652-1-yilinzhang@moonshot.ai

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a6c8e38a3110..f02780529b43 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7029,7 +7029,6 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	mapped_f unmapped = get_mapped(event, event_unmapped);
 	struct perf_buffer *rb = ring_buffer_get(event);
 	struct user_struct *mmap_user = rb->mmap_user;
-	bool detach_rest = false;
 
 	/* FIXIES vs perf_pmu_unregister() */
 	if (unmapped)
@@ -7060,17 +7059,18 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		mutex_unlock(&rb->aux_mutex);
 	}
 
-	if (refcount_dec_and_test(&rb->mmap_count))
-		detach_rest = true;
-
-	if (!refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
-		goto out_put;
-
-	ring_buffer_attach(event, NULL);
-	mutex_unlock(&event->mmap_mutex);
+	/*
+	 * Drop references in reverse order of perf_mmap() to prevent
+	 * rb revival after rb->mmap_count reaches zero.
+	 */
+	if (refcount_dec_and_mutex_lock(&event->mmap_count,
+					&event->mmap_mutex)) {
+		ring_buffer_attach(event, NULL);
+		mutex_unlock(&event->mmap_mutex);
+	}
 
 	/* If there's still other mmap()s of this buffer, we're done. */
-	if (!detach_rest)
+	if (!refcount_dec_and_test(&rb->mmap_count))
 		goto out_put;
 
 	/*

