Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794059811;
	b=jYChl4by3aN7w+IEBM6/uYmre01VRD4ZKD3U5PDYq7lvkAbvFm3rFX7YGNwVGmBCWW3c
	 YNdYtsUjA4DC89hcNXAKeD2t24YuH4c7Y4iGrfd03PQ8lDIb/gB2TO4Q577Hjx4oArM87
	 vAFUpoURAPzM7fMMBBw4O3SR37XDeMHof9JNEX9EBw8W/XOR+/6EtEu1mKIWUE74sPLxB
	 Yh9o0pE+SQ2gVlWBxI6PBVDAAqoBOERbizHZhi7TwgyXXE1i1lmR6H8H9EeK6YXN8Kq29
	 cdbRZP6knZunbxlPxABdeY8AdX4iT6LxrQybJUmh3KbsHtdauHZTF8xNNJ6C8UBPFNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794059811;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OFOaqbQI8CraQc/AcpuDqJvbAFWgVv1MoJKngam8ras=;
	b=XPYw5vgigKgghRTteDrXTX4VIOhMCDzSY5VNpNDfLGZtt3QgzkYmXxnWqtZ9lHOuIrNU
	 n4Qh7EQXruAxezVW4Xu7Bq9QmWKgxgw6xqh9Dm5Ae67bSRGOmgU6ERQ/juNedzTKPKksY
	 S+KyI44sDSW04Ued/cDfQ8C921k3QFDaS7NzEyKyWf45JeY3+aL5P5PFciyQLNykBXMUS
	 sxlqtnz1XfWOsJE9IGxOnsdlrXtXsHtM/RUS/HQmMbOvC2eduyipZye6Nvx7KNEwlcEIS
	 pDjgS26+RaX2EnL3Khwgcr823iBYY6UzTDkSNlGEkOVnScnNaPAOmpAix7E79tFTYsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XO6NrkcB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E94606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XO6NrkcB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47751F008A4;
	Sat,  7 Nov 2026 13:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794059810;
	bh=OFOaqbQI8CraQc/AcpuDqJvbAFWgVv1MoJKngam8ras=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XO6NrkcBedllw5LIHFts56pBMkYmxsqNq4dKK1F3wIwIzwnMU4NzQydB6DT8r6ETD
	 ve0olUvyQEvH11Iwx64cVCWrEQ15d677Ze6DudePE2T3pQCltIrEVQ9oV6MSJD1u1B
	 8tWL+ZFEA1IcUnr2Y6l02c+dVSv7OOFvS5YoQBK5gTTDc0zr3arZg8TQd7gNrWZ7OD
	 HI6wN8EIZHyqOb0On6f+m7mDWP7Wmi+esE3vrCqXKSDrx6mddjMsbYA8LQnuiXVzSu
	 9h7RNOXvmgcqDbAsn0DfNNDm+3eXIkilVO53g00OWipjMiz6KWuQTqeiI6CToC2Zhu
	 7mn+oBgeX4k4g==
Date: Sat, 7 Nov 2026 14:56:46 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: nickolai@csail.mit.edu, brauner@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] ucount: take the rlimit reference before
 checking the limit" failed to apply to 5.15-stable tree
Message-ID: <au8uHh_iq7Ojywef@example.org>
References: <20261107061036-failed-5.15-b14fcabd34e0@kernel.org>
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
In-Reply-To: <20261107061036-failed-5.15-b14fcabd34e0@kernel.org>

On Sat, Nov 07, 2026 at 06:10:36AM -0500, Sasha Levin wrote:
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x b14fcabd34e02c40f72d3cd1e9bd4fd18df40ff1
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061036-failed-5.15-b14fcabd34e0@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

The 5.15-stable is too old for this change. The branch does not contain
commits that separate ucounts and rlimits.

9e05e5c7ee87 ("signal: restore the override_rlimit logic")
de399236e240 ("ucounts: Split rlimit and ucount values and max values")
(and most likely there are still a few more.)

I don't think it's worth backporting these changes.

> Thanks,
> Sasha
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From b14fcabd34e02c40f72d3cd1e9bd4fd18df40ff1 Mon Sep 17 00:00:00 2001
> From: Nickolai Zeldovich <nickolai@csail.mit.edu>
> Date: Mon, 19 Oct 2026 14:59:13 -0400
> Subject: [PATCH] ucount: take the rlimit reference before checking the limit
> 
> inc_rlimit_get_ucounts() takes the reference that pins a ucounts level
> while its rlimit count is non-zero only in the walk whose increment is
> the 0 -> 1 transition, and only after that walk passed the limit check.
> A walk that raises the count from zero and then fails the limit backs
> out without the reference, while a concurrent walk that raised it past
> one keeps its increment and never takes one either:
> 
>   CPU0 (obeys the limit)              CPU1 (overrides it)
>   new = add_return(1) -> 1
>                                       new = add_return(1) -> 2
>                                       new != 1, no get_ucounts()
>   new > max -> dec_unwind
>   sub_return(1) -> 1   (no put)
> 
> The count is 1 with no reference held. When CPU1 drops its charge,
> dec_rlimit_put_ucounts() takes the count to 0 and puts a reference
> nobody took, which frees the live struct ucounts, and the user_namespace
> it pins, with kfree_rcu(). The mirror interleaving leaks the reference
> instead.
> 
> An unprivileged user reaches this on a kernel with CONFIG_USER_NS=y: in
> a user namespace with RLIMIT_SIGPENDING 0, one process taking
> synchronous SIGSEGVs (forced, so override_rlimit is set) races a second
> process in the same namespace and uid that queues real-time signals,
> which obey the limit. The two hold different sighand->siglock but charge
> the same per-namespace SIGPENDING ucounts. Unpatched, with rcuref
> debugging:
> 
>   rcuref - imbalanced put()
>   WARNING: lib/rcuref.c:266 at rcuref_put_slowpath+0xf4/0x120
>    put_ucounts+0x5a/0x180
>    do_dec_rlimit_put_ucounts+0x70/0x90
>    __sigqueue_free+0x33/0xc0
>    get_signal+0x56f/0xd20
>    arch_do_signal_or_restart+0x87/0x380
>    irqentry_exit+0x243/0x650
>    asm_exc_page_fault+0x26/0x30
> 
> Take the reference on the 0 -> 1 transition before the limit is checked,
> so the walk that raises the count from zero owns that level's reference
> even when its request is rejected, and unwind a rejected level through
> do_dec_rlimit_put_ucounts(), which releases the reference when the count
> returns to 0. The get_ucounts() failure path is unchanged. With the
> patch the same interleaving, forced some 80000 times in a KASAN build,
> produces no warning and no KASAN report.
> 
> Fixes: 15bc01effefe ("ucounts: Fix signal ucount refcounting")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
> Link: https://patch.msgid.link/20261019185913.805378-1-nickolai@csail.mit.edu
> Acked-by: Alexey Gladkov <legion@kernel.org>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  kernel/ucount.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index ec8b1445e2877..c3de5b94d25f7 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -308,23 +308,26 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type,
>  
>  	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
>  		long new = atomic_long_add_return(1, &iter->rlimit[type]);
> -		if (new < 0 || new > max)
> +		/*
> +		 * Take the extra reference on the 0 -> 1 transition before the
> +		 * limit check: a rejected walk must not leave a concurrent one
> +		 * holding the surviving increment with no reference.
> +		 */
> +		if (new == 1 && !get_ucounts(iter))
>  			goto dec_unwind;
> +		if (new < 0 || new > max) {
> +			/* undo iter too, releasing the reference taken above */
> +			do_dec_rlimit_put_ucounts(ucounts, iter->ns->ucounts, type);
> +			return 0;
> +		}
>  		if (iter == ucounts)
>  			ret = new;
>  		if (!override_rlimit)
>  			max = get_userns_rlimit_max(iter->ns, type);
> -		/*
> -		 * Grab an extra ucount reference for the caller when
> -		 * the rlimit count was previously 0.
> -		 */
> -		if (new != 1)
> -			continue;
> -		if (!get_ucounts(iter))
> -			goto dec_unwind;
>  	}
>  	return ret;
>  dec_unwind:
> +	/* get_ucounts() failed for iter: undo iter without a put */
>  	dec = atomic_long_sub_return(1, &iter->rlimit[type]);
>  	WARN_ON_ONCE(dec < 0);
>  	do_dec_rlimit_put_ucounts(ucounts, iter, type);
> -- 
> 2.53.0
> 
> 
> 
> 

-- 
Rgrds, legion

