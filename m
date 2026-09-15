Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A249D379C5C;
	Tue, 15 Sep 2026 06:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789453931; cv=none; b=sCPQ0gwtQ/lf6RVNqr3yDmilGK374DMXpY7jg1PRU806ZHjdfukjQNVFPkPfwdrFnteTSVbx1WDDrOZB+A1tqrcOdkxXMjgiMX0rgVAgb4tGmW7XK/tn04PQSeeYDg/0R+O2FwA8vj1uCfQXHo7EPFEi9d3YWAUOye8gp6wwSdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789453931; c=relaxed/simple;
	bh=AT7vWTodiZ6yGcWLQpP6M0t3ZRxY3YR+cyh51bhGn80=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OK/qZyXkoCG5YY1uIFc+Bl9BW3PgPqgoR+YCxdratKm7ilG1U5Os1NqKTGT3980rI4bqWWDSyb8OoKrF8rNvsz3wmA3k00K9xJcEJ+SAFcTy56HKF3xBoxTfb4fWjF2UUG1mwFQji9w7E75a13+0P69C6nHgtOPnp4jHd3L3zSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=w+mQa4vO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="w+mQa4vO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E011F000FF;
	Tue, 15 Sep 2026 06:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789453930;
	bh=5llc/XFrwgAZPw+/nwYOk6K5xOZoxnoq0F02YLYa//A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=w+mQa4vOvtao461etFNy2bwuQJ+upJnsGwE652+hpGOEoMlk/nYky6EIgrV6KXRUy
	 1cbKTVEQtCFd10rtBgeGldl1NksNKCc9FNi+T7C7F2GF9AA69QyHCrBJJxrwrLvFDK
	 PlNehJyAmx3ZMc8TvdW3h/3/+TR1fL97TQ1ZPl6s=
Date: Mon, 14 Sep 2026 23:32:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 liam@infradead.org, ljs@kernel.org, david@kernel.org, vbabka@kernel.org,
 jannh@google.com, wangjiexun@tinylab.org, sashiko-bot
 <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/madvise: reclaim isolated folios if PTE restart
 fails
Message-Id: <20260914233209.3fd5a6e848ee82d13e43a301@linux-foundation.org>
In-Reply-To: <20260912110832.3203902-1-gourry@gourry.net>
References: <20260912110832.3203902-1-gourry@gourry.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Sep 2026 07:08:32 -0400 Gregory Price <gourry@gourry.net> wrote:

> MADV_PAGEOUT collects isolated folios on a local list before reclaiming
> them after the PTE walk.  The reschedule path drops the PTE lock and then
> restarts the mapping with pte_offset_map_lock().
> 
> A concurrent operation can remove or replace the PTE table while the lock
> is dropped, causing pte_offset_map_lock() to return NULL.  Returning directly
> in that case bypasses reclaim_pages(), leaving the collected folios off the
> LRU with elevated references.

aw man, you got so close then left us hanging.

So what happened next?  Machine crashed?  Permanent leak?

> Route the failure through the existing cleanup path so any isolated folios
> are reclaimed or put back.
> 
> Simplest userland pseudo-code reproducer:
> 
> p = mmap(PMD_SIZE, ANONYMOUS);
> touch_every_page(p, PMD_SIZE);
> parallel {
>    while (1) madvise(p, PMD_SIZE, MADV_PAGEOUT);
>    while (1) {
>        madvise(p, PMD_SIZE, MADV_DONTNEED);
>        touch_every_page(p, PMD_SIZE);
>    }
> }
> 
> Reproduced in qemu trivially with some explicit widening of the race window.

How was the failure observed form userspace?  (repeating myself)

> 
> Fixes: b2f557a21bc8 ("mm/madvise: add cond_resched() in madvise_cold_or_pageout_pte_range()")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260821150912.183976-1-gourry@gourry.net
> Cc: <stable@vger.kernel.org>

#include "Documentation/process/stable-kernel-rules.rst"

(sorry, getting snarky.  I'm saying this stuff 100x/day at present and
it just isn't sticking).

> Assisted-by: LLM

Can I suggest you update LLM's prompts so it checks that the changelog
includes userspace-visible runtime effects and so that it checks that
the patch is approximately compliant with stable-kernel-rules?

If you do, please share that prompt with me and I'll put it in ~/.signature
