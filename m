Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D954E781F;
	Mon, 21 Sep 2026 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790011489; cv=none; b=jAcn+GJ2okRNbaZzwePrVJ2ok1y7QwaETgc73sIaSk8EsG2vaCwZpnXih0ULDR4Lb+HUtY/4wNpmkOMSVxBG5la7GFen2gIEsAZ0D6F/0GgnPf1b5w325VIHmgA92yMLDwg1gwzOZx7n4qOBbt9CeUoljjmsU6t+505egw7mscw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790011489; c=relaxed/simple;
	bh=j9KZ33MFe0YiEqyKSC1hK3OwkOrikm2nb6ce0fH0b84=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=krHfkCiKPJsIf8mFrhlXaIo3NdYlDNOIoYHDyv091HO81gxyGWAgnECxHff8O7FaJyBVE6LFHUZmtQF7H4UPf2NohUHqrNj9gCqY5oJg1AjWCLnGd6MWOx7CSQskzPgsSESdroPuXv5J0XOow9rZXmMzh+PyPZixh3fvY/v17k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlFwZU8w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlFwZU8w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0971F00893;
	Mon, 21 Sep 2026 17:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790011487;
	bh=gjYOlwCRz4zxA3pIOX0hHh4x8YB0O8SP9gSX7XtSeLQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OlFwZU8wp7YrD3ebzcRzzZUjV3rNm6to1xsAinHW9wRUsyDbYnqRv745aGqcBkptv
	 j+iWcuvqHhVYfCjKGOktLA0ndz5wJ2o/sz/PE36q8GrXrZYHJcW33HjMqVAUucMrdh
	 3vUnOkGpxo0xYeDkIcnKp1TBu95xOGCwaHxolmaamzHjsYwOidP6yfeS36rMtWKQxI
	 DGcXLbqU3XlfzyZL2ZxACCcO/x9ObIFpn7ufS7A5fhyaR+1i+C0k7+QEe5xOPWrTCS
	 Uo4cb72GmOYhvhWYJHn9WD0XyMeJGsZJp5N8RkHL5GSPkmM1/BD4XccUmXjiaUeQPR
	 IMYh66PdvW7tw==
Subject: Re: [PATCH] kcm: Fix socket use-after-free in kcm_unattach()
From: netdev-bot+sashiko@kernel.org
To: vulab@iscas.ac.cn
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, tom@herbertland.com, stable@vger.kernel.org
Date: Mon, 21 Sep 2026 17:24:46 +0000
Message-ID: <179001148656.2160803.18004232271699303811@kernel.org>
In-Reply-To: <20260917163656.2162621-1-vulab@iscas.ac.cn>
References: <20260917163656.2162621-1-vulab@iscas.ac.cn>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch fixes only one of the two sites that release the
  psock's socket references, leaving the identical (and strictly worse)…
- [Medium] The commit message's premise is not supported by the code, so
  the `Fixes:`/`Cc: stable` tags are unjustified.

Pre-existing issues:
- [Low] Stale/incorrect comment at the call site of the function this
  patch modifies: kcm_unattach_ioctl() has '/* Lower socket lock should…

--

kcm: Fix socket use-after-free in kcm_unattach()

This reorders the teardown in the unreserved (no_reserved) branch of
kcm_unattach() so that fput(csk->sk_socket->file) and release_sock(csk)
happen before the psock's sock_put(csk), and returns early from that
branch.  It carries a Fixes: tag for the original KCM commit and
Cc: stable.

> diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
> index 71af69d442f21..079b73af91559 100644
> --- a/net/kcm/kcmsock.c
> +++ b/net/kcm/kcmsock.c
> @@ -1458,9 +1458,11 @@ static void kcm_unattach(struct kcm_psock *psock)
>  		mux->psocks_cnt--;
>  		spin_unlock_bh(&mux->lock);
>  
> -		sock_put(csk);
>  		fput(csk->sk_socket->file);
>  		kmem_cache_free(kcm_psockp, psock);
> +		release_sock(csk);
> +		sock_put(csk);
> +		return;

[Severity: Medium]
The changelog says:

    "the reference held by the psock on the underlying TCP socket is
     dropped with sock_put() before the socket file is released with
     fput(csk->sk_socket->file) and before release_sock() is called at
     the end of the function.  If that was the last reference on the
     socket, both uses access freed memory."

Can that sock_put() actually be the last reference?  kcm_attach() only
accepts inet TCP sockets:

    if ((csk->sk_family != AF_INET && csk->sk_family != AF_INET6) ||
        csk->sk_protocol != IPPROTO_TCP) {

and the psock keeps the socket file reference for its whole lifetime.
kcm_attach_ioctl() returns success without sockfd_put(csock):

    /* Keep reference on file also */

    return 0;

so while the psock still holds its sock_hold() reference, the struct
socket also still owns the sk_refcnt reference taken in sock_init_data(),
which is only dropped via inet_release() -> tcp_close() -> sock_put().
That makes the refcount at this point >= 2.

On top of that, does fput() ever free the socket synchronously here?  For
an FMODE_OPENED file, fput() -> __fput_deferred() always defers:

    if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
        init_task_work(&file->f_task_work, ____fput);
        if (!task_work_add(task, &file->f_task_work, TWA_RESUME))
            return;

so the old trailing release_sock(csk) would not have touched freed memory
either.  The new ordering looks fine on its own, but could the impact
statement, the Fixes: tag and the Cc: stable be reconsidered if no
use-after-free is reachable?

[Severity: High]
Should the second release site be changed too?  unreserve_psock() has the
same pair in its deferred-free block, still in the order this patch calls
unsafe:

    if (unlikely(psock->tx_stopped)) {
        if (psock->done) {
            /* Deferred free */
            list_del(&psock->psock_list);
            mux->psocks_cnt--;
            sock_put(psock->sk);
            fput(psock->sk->sk_socket->file);
            kmem_cache_free(kcm_psockp, psock);
        }

Here psock->sk is dereferenced twice (->sk_socket, ->file) after the
reference has been dropped, and the whole block runs under
spin_lock_bh(&mux->lock), so under the changelog's premise the final
sock_put() would also run sk_free()/sk_destruct() with BH disabled.

This is the continuation of the path this patch touches.  When the psock
is reserved, kcm_unattach() does:

        kcm_abort_tx_psock(psock, EPIPE, false);   /* sets tx_stopped */
        ...
        psock->done = 1;
        smp_mb();
        queue_work(kcm_wq, &psock->tx_kcm->tx_work);

and the tx work reaches kcm_write_msgs():

    if (unlikely(psock && psock->tx_stopped)) {
        /* A reserved psock was aborted asynchronously. Unreserve
         * it and we'll retry the message.
         */
        unreserve_psock(kcm);

which takes the psock->done deferred-free branch above.  So for every
psock unattached while reserved (SIOCKCMUNATTACH or release_mux()), the
exact sequence declared unsafe still executes.

Would it make sense to factor the release sequence into one helper used
by both sites, so the intended ordering invariant is unambiguous?

>  	}
>  
>  	release_sock(csk);

[Severity: Low]
This is a pre-existing issue and not introduced by this patch, but while
the exit paths of kcm_unattach() are being changed, is the comment at the
kcm_unattach_ioctl() call site still accurate?

    /* Lower socket lock should already be held */
    kcm_unattach(psock);

kcm_unattach() takes the lower socket lock itself on entry:

    struct sock *csk = psock->sk;
    struct kcm_mux *mux = psock->mux;

    lock_sock(csk);

and now releases it on all three exits, including the early return added
here.  If the caller really held that lock, lock_sock() would deadlock;
kcm_unattach_ioctl() only holds a sockfd_lookup() reference on csock.
Could that comment be dropped or corrected?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917163656.2162621-1-vulab%40iscas.ac.cn
