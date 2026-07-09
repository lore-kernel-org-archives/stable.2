Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52CA2C237E
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 14:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607357; cv=none; b=jbgHQxBPRo6fumfaewHEem/sdHMhwLOu365N9Rguj+2A2pM1Tl240idXTq6YSTVIN/c5gUlt5XghdfbzXUV6ZTZBIUr6sWf1Ukp6AjLzxzaLSKVI+kosSZv2iax8AjXk4sa+1cvW68p2KBDEL0wT7RwN/+2VVMC1ai27lBD+XNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607357; c=relaxed/simple;
	bh=Iu4eOmW5OFTlfmcZ4j5QOVxyD0LZCCHmxCVEYvjFGS8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ig5p/eQPhJzvPhJS+RCb2RACJ8BHSRParnawK07rBJbbicyn2C/tFFdMyQvGXEDCgV9KUnMgMVB8pSt9zTzYQbz0oD90nOo8nsjxct6+6o/opm6TraM02NajrEjYhlJGmP2NbVSq30mVw/8gvuoGP+Yu69utwL+yU3JXq/Xo27A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=AYXGiFum; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="AYXGiFum"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38175907a56so846272a91.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 07:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1783607355; x=1784212155; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aJ0aTaxiRIikqsBWv5Uf4B9z1s0BEHGFjpFfafk8OH8=;
        b=AYXGiFumVXgLvxcYYC/to/K77os7YsmNwyXvt1DW460h83ZOZ8Qfiy8HCM3Q6V4TM4
         HeACubI7TRG/nPILczU1+foNiYJRqiS4urDu3DVir3OUf5mj6Mfu2YJdyT9n9xzyXVJq
         Pc4qPG/ax8L+IR2HF53iGz53RwjhHqUCR3NgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783607355; x=1784212155;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aJ0aTaxiRIikqsBWv5Uf4B9z1s0BEHGFjpFfafk8OH8=;
        b=pyfiWIeQvAk+ZRMrgJ4uzm8RULZ2aHFy0rzPZ9L3A8lioBdnMAl2Dyna0eZq1I8iiP
         6+1bSrTuTkjntmNqbtDu9KXXsxW/TGzZDdGLvvkECyRTKtS2A6uT46dAZ/BY7j+ESsoy
         bCNo8Ets72aOOy8zTZYzE7LLzofoDHcG4BxUynPClJKA+lUzczemPDJGAofK2eeZYXJq
         qW4lzEkpUyL9Plml/TC95kMjttX3OHtpypTOUqT0tVcOxjNSsmAQIWYSq121seg1vUEI
         ENihGxUs6lV5KK6gnNK3smgeIyWWEjzNEOV4m5DWjbXZF3pnKXVuU7gBDe6+PrXcopZV
         OAIg==
X-Gm-Message-State: AOJu0YwIV8DLsWoKmQtL1/8RfaGh7yGa8wS1jjK0HH8UQWouYokodivY
	6jR4+VUtwC6DG9jHgcjyU4VtR7QGwGtkJXGGvwJ8Is/8ckZwuxbRByE7BAwyaO3mfyazWLtRBuv
	9oqDa
X-Gm-Gg: AfdE7cknjih61kiBPM0oC8b6dgwtogw13lN1YMzxqFHt6/IhnsKoMaImPynEdilXOaj
	H5v8DtdgypuA6zPe3YFBJ69zC4R8SrAFFzDoyokrU3PSaSOocC9F7YyjDzhEdkxjAYtiOO090pF
	dH7MVHlKM5h1P+yxD+nZCBXuhDjLD74s0LJQo2C5PVeUybs03r7UKrStWk3oCLERW99ZzGdfAeh
	9DHuLphTsiUP8NoW3cCA95WMAcvf+filWfEH6ULbiapqp/HkBq/6/SrnM9vZChoUOcMgu74Wbxe
	SlKs5EK0loVvnM0nVmMk0vPl3hS62GiZlREukwKAcFNWVM6x49ckdmEBHYpGgqy4Y9OmHGhj6YK
	AzXLpo4zf+gFeXCkQkhBs/IcSrB0GqsPT3dbD8fsSIn23rWbTUu1QbHA9J/VE/7lYaYJG2cKuK0
	UNrHxs0im+fh6hX0owUAajWzmJ77ihe4ikOH37n/pjN3FsBvffDEyQM05x1XYmkmhiwv8=
X-Received: by 2002:a17:90b:384b:b0:387:d5bd:622f with SMTP id 98e67ed59e1d1-38b74d2dcd9mr2733193a91.18.1783607355053;
        Thu, 09 Jul 2026 07:29:15 -0700 (PDT)
Received: from Taeyangs-MacBook-Pro.local ([59.6.107.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a5213f28csm1313907a91.0.2026.07.09.07.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:29:14 -0700 (PDT)
Date: Thu, 9 Jul 2026 23:29:08 +0900
From: Taeyang Lee <0wn@theori.io>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 6.12.y] perf/core: Detach event groups during remove_on_exec
Message-ID: <ak-wNFDs7hzmggnp@Taeyangs-MacBook-Pro.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[ Upstream commit 037a3c43edfb597665dd34457cd22b14692f2ba3 ]

perf_event_remove_on_exec() removes events by calling
perf_event_exit_event(). For top-level events, this removes the event from
the context with DETACH_EXIT only.

This can leave inconsistent group state when a removed event is a group
leader and the group contains siblings without remove_on_exec. If the group
was active, the surviving siblings can remain active and attached to the
removed leader's sibling list, but are no longer represented by a valid
group leader on the PMU context active lists.

A later close of the removed leader uses DETACH_GROUP and can promote the
still-active siblings from this stale group state. The next schedule-in can
then add an already-linked active_list entry again, corrupting the PMU
context active list.

With DEBUG_LIST enabled, this is caught as a list_add double-add in
merge_sched_in().

Fix this by detaching group relationships when remove_on_exec removes an
event. This preserves the existing task-exit and revoke behavior, while
ensuring surviving siblings are ungrouped before the removed event leaves
the context.

Fixes: 2e498d0a74e5 ("perf: Add support for event removal on exec")
Signed-off-by: Taeyang Lee <0wn@theori.io>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/ai65GgZcC0LAlWLG@Taeyangs-MacBook-Pro.local
---
 kernel/events/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9099c0cc933b..482ac3f636fb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4537,7 +4537,8 @@ static void perf_event_enable_on_exec(struct perf_event_context *ctx)
 
 static void perf_remove_from_owner(struct perf_event *event);
 static void perf_event_exit_event(struct perf_event *event,
-				  struct perf_event_context *ctx);
+				  struct perf_event_context *ctx,
+				  unsigned long detach_flags);
 
 /*
  * Removes all events from the current task that have been marked
@@ -4564,7 +4565,7 @@ static void perf_event_remove_on_exec(struct perf_event_context *ctx)
 
 		modified = true;
 
-		perf_event_exit_event(event, ctx);
+		perf_event_exit_event(event, ctx, DETACH_GROUP);
 	}
 
 	raw_spin_lock_irqsave(&ctx->lock, flags);
@@ -13478,10 +13479,11 @@ static void sync_child_event(struct perf_event *child_event)
 }
 
 static void
-perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
+perf_event_exit_event(struct perf_event *event,
+		      struct perf_event_context *ctx,
+		      unsigned long detach_flags)
 {
 	struct perf_event *parent_event = event->parent;
-	unsigned long detach_flags = 0;
 
 	if (parent_event) {
 		/*
@@ -13496,7 +13498,7 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
 		 * Do destroy all inherited groups, we don't care about those
 		 * and being thorough is better.
 		 */
-		detach_flags = DETACH_GROUP | DETACH_CHILD;
+		detach_flags |= DETACH_GROUP | DETACH_CHILD;
 		mutex_lock(&parent_event->child_mutex);
 	}
 
@@ -13575,7 +13577,7 @@ static void perf_event_exit_task_context(struct task_struct *child)
 	perf_event_task(child, child_ctx, 0);
 
 	list_for_each_entry_safe(child_event, next, &child_ctx->event_list, event_entry)
-		perf_event_exit_event(child_event, child_ctx);
+		perf_event_exit_event(child_event, child_ctx, 0);
 
 	mutex_unlock(&child_ctx->mutex);
 
-- 
2.50.1 (Apple Git-155)

