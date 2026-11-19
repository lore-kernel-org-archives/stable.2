Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795087994;
	b=X50EGaqL5+XEEECHx21At0O3h0wJCs/2V+wmuJ2+PXmZrmU1i0wfQuvEFaZJJRqiUJlh
	 ZhYPLPB9z5Z96ftzR3Rvc+CzvrfllZIRf7ofIaXMUZJX505w+LoxiAizmeBfHWUgGZYiF
	 ie1D1eB6CUiFdjFhxxCfiMvx+HYXzRN7Q9frf3ZT07YTKm9Yims1RRiXo+OEzOgLn2MLj
	 9aKROflLQKy/++r9RsZCgXnMGQ1/pKOzr9GYafceQXl+LxsSfmTsQqAFO2Y+ktluYOFUw
	 BLiHhqzuNGEXbWszEuSMeL0AKEKhgY8KRi8axiHb7jeaweuOyn2VoPwHv+ToAryOZuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087994;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3jA+oZ+5iHu+6qDUVQHLEuIm2QvBD2uST/vEYY3WW1M=;
	b=dFnVYciJaLRTTYyIKgcLneFomYYpv7q+6lbWjImUWqTbZ1uYOXIxRIcdRDtL5LyMl6p0
	 OL7O/sGORWxsREzCv2csQzLlrKjmVVOw7ItdCqlpZiv6ud6CL4LRXfUMN7zSYdFvus69s
	 FN3cB85OyeI+9S6zzhXGIZyyTwgQF6rlLvzDSgMR2TxFaRWZUrmKOxPF1UqfTuPdw2yru
	 Qn3gu4+QrvHFbiwgGlTasIERlojwmS+TrH/4JJe0tbK7p75QvuBXAZIg+Ayqz5EyVKxo2
	 WMv+rpVQEkqvRfXkaV3db9aOTrslQLibuOqSxPRfMPTghBvy7T/GL8VRhlx0O9soEGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GURvDvKB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F575606A320;
	Thu, 19 Nov 2026 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GURvDvKB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52A61F000C8;
	Thu, 19 Nov 2026 11:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795087994;
	bh=3jA+oZ+5iHu+6qDUVQHLEuIm2QvBD2uST/vEYY3WW1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GURvDvKBbWgEGx0orgwtNauW3gLt2TOPbl2oLQ797swNjSd+tOF6ti/U/myWq/oDx
	 OePh4v1sE3qP1ttZduAMVjZ3daFXGbkOnFmcsG7H5GKN4Esr7lRaguphv57fT9Pj26
	 JdLakKqfdjvkVXCK3p1JP0N0RzLjlN83OO8VtiUglo+sQgyvynPVbmkwoUHUk4uSsM
	 Ift8s/gM+NRwen4hkUOyiCOaieIAW2pT05wgbPR9X88d9J/7+iVKlTp5q6G0EDf2Rp
	 UGkDxNavpvDyMYUtJsegN6Qw1IgLo2+MKMZnheS68iS/R/HhFaQ5KrzA0cZnDBtGZx
	 XRxCk8VoWdy7A==
Date: Thu, 19 Nov 2026 11:33:03 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kees Cook <kees@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Ingo Molnar <mingo@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Chris Mason <mason@kernel.org>, Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] fork: clear p->mm when copy_process() fails
Message-ID: <av7b64FqD9Op5Avz@gremlin>
References: <20261119-mm_failed_fork-v1-1-b3019f43d197@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-mm_failed_fork-v1-1-b3019f43d197@kernel.org>

On Thu, Nov 19, 2026 at 09:04:58AM +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
>
> When copy_process() fails after copy_mm(), the error path drops the mm
> reference but leaves p->mm set. Perf and BPF can still reach the
> task, and take a reference on the already freed mm through get_task_mm()
> or bpf_find_vma(), resulting in a use-after-free:

Good lord :)

>
>     copy_process()               PERF_EVENT_IOC_SET_FILTER
>     ==============               =========================
>     perf_event_init_task(p)
>     copy_mm(p)
>     a later step fails
>     mmput(p->mm)
>       /* frees the mm */
>                                  perf_event_addr_filters_apply()
>                                    get_task_mm(p)
>                                      /* use-after-free */
>
> Similarly, a BPF program on the task_free LSM hook can call bpf_find_vma(p)
> before the task is freed.
>
> Fix it by clearing p->mm under task_lock() before dropping the reference,
> just like exit_mm() does.

Sounds sensible.

>
> Further, if copy_process() fails before copy_mm(), p->mm is still the
> parent's mm pointer copied by dup_task_struct(), without having taken a
> reference. While nobody can access it concurrently, there is the
> chance that it might get accessed later when a BPF program is attached
> to free_task().
>
> With CONFIG_MEMCG the task is freed after an RCU grace period, so the
> parent might already be gone and p->mm in the child points at something
> that was already freed. So let's just clear p->mm before freeing the
> task. No lock is required as there cannot be concurrent access (and we
> might not even have the lock initialized yet).
>
> This has medium urgency.

It sounds... horrendous though :) but I guess possibly hard to hit?

>
> Fixes: 375637bc5249 ("perf/core: Introduce address range filtering")
> Fixes: 7c7e3d31e785 ("bpf: Introduce helper bpf_find_vma")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/sashiko-outbox-180866@kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify description and comments ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
> I can take this through my tree (rather soonish) unless someone else
> wants to pick this up.
> ---
>  kernel/fork.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 5efceb8d58a78..77d6c8fc38c66 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2628,8 +2628,14 @@ __latent_entropy struct task_struct *copy_process(
>  bad_fork_cleanup_mm:
>  	sched_cache_fork_cleanup(p);
>  	if (p->mm) {
> -		mm_clear_owner(p->mm, p);
> -		mmput(p->mm);
> +		struct mm_struct *mm = p->mm;
> +
> +		/* Perf events and BPF programs can still reach p. */
> +		task_lock(p);
> +		p->mm = NULL;
> +		task_unlock(p);
> +		mm_clear_owner(mm, p);
> +		mmput(mm);
>  	}
>  bad_fork_cleanup_signal:
>  	if (!(clone_flags & CLONE_THREAD))
> @@ -2663,6 +2669,11 @@ __latent_entropy struct task_struct *copy_process(
>  	exit_cred_namespaces(p);
>  	exit_creds(p);
>  bad_fork_free:
> +	/*
> +	 * If set, p->mm points at the parent's mm without a reference. Nobody
> +	 * can access it concurrently anymore, but prevent later access.
> +	 */
> +	p->mm = NULL;
>  	WRITE_ONCE(p->__state, TASK_DEAD);
>  	exit_task_stack_account(p);
>  	put_task_stack(p);
>
> ---
> base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
> change-id: 20261119-mm_failed_fork-a46141b503d0
>
> Best regards,
> --
> David Hildenbrand (Arm) <david@kernel.org>
>

--
Cheers, Lorenzo
