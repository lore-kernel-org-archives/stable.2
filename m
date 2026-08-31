Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B664DB54B;
	Mon, 31 Aug 2026 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183564; cv=none; b=NdxQrZFnsvDNTbsU2CfPzeMU5MUar1oyzb1KqfI+m7k9QfQ3uo8yFSubsd81/p3Zn6tn43K/3VQX7zjxsRqEz6cQ4r0L5uLjkC5qAlaTRgVBAgN5a31jybAjq38+aalDdIL17RwVFc9MQHON/zKhqHtY0v0CzY7yMIrqIqzLAZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183564; c=relaxed/simple;
	bh=BTOOB8n92tQTyiQl38o3xCaugY6QFTvu/rgPpOqqht8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/cqIalFKGBts1BnpmwB6oQVW1i1xVPOWcvEz+7+cKQbsG+B6ZTTCSMx75+Mhea0H5sFAt1d65AoT8vfdJVOACzKoQp47A6rqeeeb0dHW2aTkVf1exA4tlEUIj3ReFJ4GE6qgWtOxPpCuVoMDDuRJ7uXhgws9KDRjkLA6VgQprY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PjwOnfQj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PjwOnfQj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zO+VV8pGvER/TXhygGNJbtUeGH8oI5huNNGYwyEb9Co=; b=PjwOnfQjb6mYm7pJcJMlPAcxew
	o7ZdPo2i8E9ccHRjnFphtImXsfCBejL9hdsi0M6LdBdQoTNsVyqG2h8fSJc52Z2cHqL/Mjqsmh2g1
	xRq51vNNfbcV326QWpIqlNaR2+Ilk63daurw9msS/GFyjIiqxsj55Cr8PuvusrJTUPyahxTotbUOx
	DLXjlhh57MbWkUMt2kPUuwLOYrhvep7Px9KJahViqeghVroSUd8R2EXDAUyFUlZYd7HSXNUrL7b0F
	agKgggqRUC1EbnUWDdPHyzrjMbvdOgfneEMN29sK/h2kStYSn19yzIludLlRXz77KV0Hjguydii5k
	ANjgeB3g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x12EF-00000003Jzg-2Yqw;
	Mon, 31 Aug 2026 13:39:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2366F30056B; Mon, 31 Aug 2026 15:39:15 +0200 (CEST)
Date: Mon, 31 Aug 2026 15:39:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Yilin Zhang <yilinzhang@moonshot.ai>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	kylebot@openai.com, david.lee@trailofbits.com,
	linux-perf-users@vger.kernel.org, stable@vger.kernel.org,
	Kimi Security Team <bug-report@moonshot.ai>,
	Weiming Shi <shiweiming@moonshot.ai>
Subject: Re: [PATCH v3] perf: Fix use-after-free when perf mmap() revival
 races with the last munmap()
Message-ID: <20260831133915.GH4121339@noisy.programming.kicks-ass.net>
References: <20260831133152.1231045-1-yilinzhang@moonshot.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831133152.1231045-1-yilinzhang@moonshot.ai>

On Mon, Aug 31, 2026 at 09:31:52PM +0800, Yilin Zhang wrote:
> perf_mmap_close() drops rb->mmap_count *without* holding
> event->mmap_mutex (the refcount_dec_and_test() right before the
> refcount_dec_and_mutex_lock() of event->mmap_count). A concurrent
> perf_mmap_rb() can slot its entire "revival" path into that window
> (perf_mmap holds event->mmap_mutex for its whole duration, including
> rb_alloc):
> 
>   munmap side (perf_mmap_close)          mmap side (perf_mmap_rb)
>   -----------------------------------    --------------------------------
>   rb->mmap_count 1 -> 0   (no lock)      (holds event->mmap_mutex)
>                                          inc_not_zero(rb->mmap_count) fails
>                                          ring_buffer_attach(event, NULL)
>                                          rb_alloc() + attach new rb
>                                          refcount_set(&event->mmap_count, 1)
>   lock; event->mmap_count 1 -> 0
>   ring_buffer_attach(event, NULL)
>   ring_buffer_put() -> frees the *new* rb
> 
> The revival's refcount_set(&event->mmap_count, 1) is an invisible
> 1 -> 1 write: the close frees the just-revived buffer although the
> other process still has it mapped -- a page-level use-after-free
> allowing local privilege escalation to root by any unprivileged user
> (default kernel.perf_event_paranoid=2).
> 
> Swap the order of the two counter updates: event->mmap_count is
> dropped first via refcount_dec_and_mutex_lock(), so its 1 -> 0
> transition and the ring_buffer_attach() stay serialized with
> perf_mmap(). rb->mmap_count == 0 then implies every event using the
> buffer is detached already, so the result of the rb->mmap_count drop
> can gate the remaining teardown directly and detach_rest is no longer
> needed.
> 
> An earlier fix for this race from Kyle Zeng and David Lee takes
> event->mmap_mutex around both counter updates [0]; here the not-last
> close stays lockless.
> 
> Fixes: 59741451b49c ("perf: Identify the 0->1 transition for event::mmap_count")
> Link: https://lore.kernel.org/linux-perf-users/20260804060931.711308-1-david.lee@trailofbits.com/ [0]
> Cc: stable@vger.kernel.org # 6.18+
> Reported-by: Kimi Security Team <bug-report@moonshot.ai>
> Tested-by: Weiming Shi <shiweiming@moonshot.ai>
> Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
> ---
> v2: https://lore.kernel.org/linux-perf-users/91825d0335d2f7cc017ee23886ffeef44c1cc633.f061f277.0045.493a.937e.53242f19a7de@feishu.cn/T/#u
> v3: swap the counter drop order instead of serializing both under
>     mmap_mutex; keeps the lockless fast path, drops detach_rest, and
>     references the earlier independent fix [0]

I presume this means you and your AI agree with my pre-wakeup-juice
morning musings?

Also, you seem to have lost the 'helpful' comments that I drafted :-(


>  kernel/events/core.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a6c8e38a3110..f56f9d9e4f01 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7029,7 +7029,6 @@ static void perf_mmap_close(struct vm_area_struct *vma)
>  	mapped_f unmapped = get_mapped(event, event_unmapped);
>  	struct perf_buffer *rb = ring_buffer_get(event);
>  	struct user_struct *mmap_user = rb->mmap_user;
> -	bool detach_rest = false;
>  
>  	/* FIXIES vs perf_pmu_unregister() */
>  	if (unmapped)
> @@ -7060,17 +7059,14 @@ static void perf_mmap_close(struct vm_area_struct *vma)
>  		mutex_unlock(&rb->aux_mutex);
>  	}
>  
> -	if (refcount_dec_and_test(&rb->mmap_count))
> -		detach_rest = true;
> -
> -	if (!refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
> -		goto out_put;
> -
> -	ring_buffer_attach(event, NULL);
> -	mutex_unlock(&event->mmap_mutex);
> +	if (refcount_dec_and_mutex_lock(&event->mmap_count,
> +					&event->mmap_mutex)) {
> +		ring_buffer_attach(event, NULL);
> +		mutex_unlock(&event->mmap_mutex);
> +	}
>  
>  	/* If there's still other mmap()s of this buffer, we're done. */
> -	if (!detach_rest)
> +	if (!refcount_dec_and_test(&rb->mmap_count))
>  		goto out_put;
>  
>  	/*
> -- 
> 2.43.0
