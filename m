Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F41485921;
	Mon, 21 Sep 2026 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003611; cv=none; b=gXPNmXvYrLF1onqQPDqUOY2Xhr7lzuVL5ADysr8sUj8N7gIrkQnFod/TbwgNWDpFZxQTzRdtVrOrn5RaoCy0gA4Bi2c5bCfNvY66t7gl2z54pwTri/+j07RoAueEEWE7uxMbBng7EcEVCZU/LLmw4tj+uDwx5dxEDGz9Q+LDkt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003611; c=relaxed/simple;
	bh=VFVm3deGEZoOvkqNDfaTjIXJe/vQ5gsepPxoR8S/TAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYK7v5F895BD32xM9n587AofqfbEkyGaiQ7OddgeV0vKI4+qQk1ZIfOZgwR1S40DD6q3PCwhmhR7Jb9bLAAeMa+xZ6xOqrxwsc082DaXwMe16vW5Hu5GN1rJlUQX1f8c3dZGGdPWAdtEakzKZRS/KtTb0nSmp3//itJp4Cyz0Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S21YwvSR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S21YwvSR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856CE1F000FF;
	Mon, 21 Sep 2026 15:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003609;
	bh=8Z9pnwbujXH/q5I7qHSymHElSJLsHHgcLpqMH2sW6fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S21YwvSRTAURvYpdtUFXYGzC32u9zOXzKBqGe4fcTj7z9ti7V6ZPbyoOohMpQKfxI
	 Pd4rIy6vGoctpcvLTZEjVgOnV3TuWPOUMsIht/O9jGWkSsgGIWYmrC+chXUIhN2WTW
	 YpfQ+sLaX+CpizQEKtO03nM54fJ5u4ea9HjtyC6V+pcwkXAOCznmBYEH61G9D/RQgh
	 vsg9v7rYaDuWG+Hp0NiG0lOyFTzQFcDDHrMFphfUwB0bRuEQjXm5L9rEJWUz9nZDsS
	 jJrmiaht/AiS/0EzAWNnshVq9n6QTK10e+9MP1suSndz40qDiro1saK719V+4KkitO
	 ahJBGS7/G8Fmg==
Date: Mon, 21 Sep 2026 17:13:26 +0200
From: krzk@kernel.org
To: Hui Peng <benquike@gmail.com>
Cc: stable@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	linux-kernel@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] perf/core: fix user->locked_vm leak on secondary
 mmap()
Message-ID: <arFJlTQwGGnSs681@quoll>
References: <20260919221728.3707189-1-benquike@gmail.com>
 <20260921003306.426050-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921003306.426050-1-benquike@gmail.com>


On Mon, 21 Sep 2026 00:33:06 +0000, Hui Peng wrote:
> Commit 0c8a4e4139ad ("perf/core: Further simplify perf_mmap()") hoisted
> `user_extra = nr_pages` ahead of the existing-buffer checks (`if
> (event->rb)` and `if (rb_has_aux(rb))`), and subsequently
> commit 5d299897f1e3 ("perf: Split out the RB allocation") and
> commit 2aee37682391 ("perf: Split out the AUX buffer allocation")
> carried `long extra = 0, user_extra = nr_pages` into perf_mmap_rb() and
> perf_mmap_aux().
> 
> As a result, when an already-allocated ring buffer (`event->rb`) or AUX
> buffer (`rb_has_aux(rb)`) is mapped again via mmap(), perf_mmap_account()
> is called with `user_extra = nr_pages` instead of `0`, charging `nr_pages`
> to `current_user()->locked_vm` on every additional mapping. However,
> perf_mmap_unaccount() and perf_mmap_close() only subtract the ring buffer's
> and AUX buffer's pages once when the final `rb->mmap_count` /
> `rb->aux_mmap_count` reference drops to zero. Consequently, every secondary
> mmap() + munmap() cycle on a perf event permanently leaks `nr_pages` in
> `user->locked_vm`, eventually exhausting `perf_event_mlock_kb` and
> `RLIMIT_MEMLOCK` (-EPERM) for that user.
> 
> Fix this by only calling perf_mmap_account() when allocating a new ring
> buffer in perf_mmap_rb() or a new AUX buffer in perf_mmap_aux().
> 
> Tested in QEMU against Linux 7.3.0-rc3 with a standalone C reproducer
> running as an unprivileged user (UID 1000, RLIMIT_MEMLOCK=0,
> perf_event_paranoid=1) that opens a software perf event, maps a 65-page
> ring buffer, performs 10 secondary mmap() + munmap() cycles on the same
> event fd, and then unmaps and closes the event. On the unfixed kernel,
> subsequent perf_mmap() calls by UID 1000 permanently fail with -EPERM due
> to the leaked `user->locked_vm` (650 pages leaked), whereas with the fix
> applied `user->locked_vm` returns to 0 and subsequent perf_mmap() calls
> succeed.
> 
> Fixes: 0c8a4e4139ad ("perf/core: Further simplify perf_mmap()")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v2:
> - Dropped the cross-MM `pinned_vm` / `rb->mmap_mm` (`mmgrab`/`mmdrop`)
>   changes (which caused an RCU softirq context violation in `rb_free_rcu()`
>   in v1, flagged by sashiko-bot) to keep this patch focused on the
>   `user->locked_vm` leak on secondary `mmap()`.
> - Updated the `Fixes:` tag to `0c8a4e4139ad ("perf/core: Further simplify
>   perf_mmap()")` and added QEMU reproducer test details to the commit
>   message.
> 
>  kernel/events/core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 


You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem, how to document usage of LLM and how what you should not
do if this was posted in a good faith.

Best regards,
Krzysztof



