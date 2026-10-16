Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659E24457BC;
	Fri, 16 Oct 2026 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140322; cv=none; b=HG/8yDK9KUpujtegVYT2YFJZTGab3lojlPofRHGT8Hhr/kQcT9mocGpVyM29IQwZ65HXJp6SbH3yywl1qL4llcDevcVuERAgbd+ZCRakCUt4lm/V+kV/wv+b0JcqXOSq1QjNbV8cLckf+0MIGldLF8WTsY4s4JaNKJWQKpkRPqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140322; c=relaxed/simple;
	bh=ffG3ujLaCcGnakxUWK/0aVmPawFTumgtHBab/ATdO+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2jNyisnOTPkXujUtcP1cs5qJE/IE7rQQ3S0DWEe9URYAsLy1qCxTe0kbMgvdLMrQybcrHDFf6ddH5wIoHOr0BnzYZ0ynqEI1c5IF7aNYOcuzLlWxmCfAKjN6Pqxb4uCvyDLAy2iBJD+95sdRjtN5y4ORY/rda5aEVeDron+ANY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BcSaD3hZ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BcSaD3hZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TVJANtvdJWf5QRMFuiNtti7YQ9uQJATM8AZIdiUsz1w=; b=BcSaD3hZmHXZ59Wga5DpwpUkr4
	LoGfl7WBfWPy56GDNeo70qiTAG44UX+nnfNaEhdZzHS8PoW9imCixnmWPRqn823cVjJ/ppecFaeMB
	33zRuBZ42/yKb9BjnIvOI3suDswdEGOWM/Qe8HkMNqmhK2ACijTScn11HxJooOPpGAPRtawNyhQUL
	9KdDt/tSEPfkxEPaHNOVDcQycpFt0hUZSUigiSL6Aajxto23p0d6WbWSUWsc4lsxbwaop5zY2gF2j
	12oaFxV0tqIGRCTpuj3xMyFy/iJ+ipWsNomcQ82JoJ6hDB9VreGNYVseSJzEwcx5oenRh4lQLd8zf
	yvWEYaHQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHdYs-00000001HK9-1diB;
	Fri, 16 Oct 2026 08:45:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0BB41300178; Fri, 16 Oct 2026 10:45:09 +0200 (CEST)
Date: Fri, 16 Oct 2026 10:45:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, elver@google.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] perf/core: Close owner-list publication race with
 remove-on-exec
Message-ID: <20261016084508.GQ2009045@noisy.programming.kicks-ass.net>
References: <20261015123416.795008-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015123416.795008-1-4ncienth@gmail.com>

On Thu, Oct 15, 2026 at 09:34:16PM +0900, Daehyeon Ko wrote:
> perf_event_open() makes a user event visible in the target context before
> adding owner_entry to the opener's perf_event_list.  For a remote task, it
> also releases exec_update_lock before adding the list node.
> 
> A concurrent target exec can therefore process a remove_on_exec event in
> this interval.  perf_remove_from_owner() sees the published non-NULL owner
> and calls list_del_init() on the zero-allocated, but not initialized,
> owner_entry.  DEBUG_LIST reports a NULL-link list corruption and can panic
> the kernel.
> 
> If list corruption reporting is non-fatal, list_del_init() initializes the
> node and clears the owner.  The open path then adds the ownerless event to
> the opener's list.  Closing the returned file descriptor frees the event
> while it remains linked, and the next owner-list insertion accesses the
> freed object.
> 
> Initialize owner_entry when the event is allocated.  After taking the
> opener's perf_event_mutex, add the node only if the exec side has not
> cleared the owner.  The existing mutex then makes both orders safe: the
> open side either publishes the list node before exec removes it, or skips
> the late add after exec clears the owner.
> 
> An unprivileged remote-task reproducer triggered the NULL-link panic on an
> unmodified hardened kernel.  With corruption reporting made non-fatal, the
> same reproducer triggered a KASAN use-after-free in the next owner-list
> insertion.  The patched hardened kernel completed 1,264,540 remote opens
> during 60 seconds of concurrent exec without a list diagnostic or panic.
> 
> Fixes: 2e498d0a74e5 ("perf: Add support for event removal on exec")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
> ---
>  kernel/events/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7846d70be57f6c..5e191757a08ccc 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -13382,6 +13382,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>  	INIT_LIST_HEAD(&event->rb_entry);
>  	INIT_LIST_HEAD(&event->active_entry);
>  	INIT_LIST_HEAD(&event->addr_filters.list);
> +	INIT_LIST_HEAD(&event->owner_entry);
>  	INIT_HLIST_NODE(&event->hlist_entry);
>  	INIT_LIST_HEAD(&event->pmu_list);
>  
> @@ -14252,7 +14253,8 @@ SYSCALL_DEFINE5(perf_event_open,
>  	}
>  
>  	mutex_lock(&current->perf_event_mutex);
> -	list_add_tail(&event->owner_entry, &current->perf_event_list);
> +	if (event->owner)
> +		list_add_tail(&event->owner_entry, &current->perf_event_list);
>  	mutex_unlock(&current->perf_event_mutex);


So per the locking rules (in the comment above
perf_event_ctx_lock_nested()), we can take perf_event_mutex inside
exec_update_lock.

Would not moving this list_add into that section also cure the problem
and with less races?

That is..

---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index db7b76d6b68a..4e8508194ee8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -14286,15 +14286,15 @@ SYSCALL_DEFINE5(perf_event_open,
 
 	mutex_unlock(&ctx->mutex);
 
+	mutex_lock(&current->perf_event_mutex);
+	list_add_tail(&event->owner_entry, &current->perf_event_list);
+	mutex_unlock(&current->perf_event_mutex);
+
 	if (task) {
 		up_read(&task->signal->exec_update_lock);
 		put_task_struct(task);
 	}
 
-	mutex_lock(&current->perf_event_mutex);
-	list_add_tail(&event->owner_entry, &current->perf_event_list);
-	mutex_unlock(&current->perf_event_mutex);
-
 	/*
 	 * File reference in group guarantees that group_leader has been
 	 * kept alive until we place the new event on the sibling_list.
