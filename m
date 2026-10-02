Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300AC137750;
	Fri,  2 Oct 2026 00:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790899569; cv=none; b=RY5gnxCVddEpZHOrqta9/r7u8XKb8PbafXW5SIICdPO23oeSEMGfB8HA7aMqKRK40M2tZHeQLd2F2u1Kdx7vITOOZGU5Dc5pCAcrJqvAntTw5rC74oEZuGoZRwXVqqDRkmJbQ2St2LZiZ/1w/XC047WPAt1oMYDah4Jm64QARBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790899569; c=relaxed/simple;
	bh=g94jov6pMGrVs41yGYhtm9xEFq+Qmo11P5lXohcmUZk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HgevocJgFyvd72B1xqrZGOPa9H0lmMZc8HJ/FMHdO0m8LofYC1Plpye83WD0iKjkBLxx0WPyD2WExHucOdnUs3BY/1zJqIg2yfjSHU50HV2S9LmUpCf6zYHEAfg+EndCUUf12l98wF9r6voPTaH7XQW8ObC+wefd5sUEgiMc9jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmqWKTae; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmqWKTae"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F471F000FF;
	Fri,  2 Oct 2026 00:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790899567;
	bh=lgfAp81SO0jY9MuFuSg3tociwcsO3svNropjUcMA+8Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WmqWKTae3wUMSHXHGld2ljOYDNrBVOlb+Qc+cXdCYs0U636v7BySVZ7lyW2oMr0TM
	 1eWw3gnG6t5ZTx5v2ZyUQmJA3eL3AP730fM38eB/JqDKKW4Vl1F4IEZExX8N5PnBAW
	 AqzuKJrQS/45Lcr9VvmUbXXu1fzNQoF3Y2mwZuhZ8MYXxYA2IrcEQrYvtHBwrfUjeW
	 AK254InNCDHJJKLsRauKeNzDcIAoSo2cgrLcRgahNBjWeao39Jt1Xb1ywmjEWULZ0V
	 qS6uXVkajev9crOBLDs2RA/yE9mkGlfuqOcYkbzBf8NrM/ivedwDlWeEg09x5F5hhO
	 /H00EiSFVyP+Q==
Subject: Re: [PATCH net v2] strparser: make sure __strp_recv isn't running
 before tearing down the parser
From: netdev-bot+sashiko@kernel.org
To: sd@queasysnail.net
Cc: netdev@vger.kernel.org, jiayuan.chen@linux.dev, imv4bel@gmail.com,
 stable@vger.kernel.org, kuba@kernel.org
Date: Fri, 02 Oct 2026 00:06:06 +0000
Message-ID: <179089956689.434549.15887968585245541352@kernel.org>
In-Reply-To:
 <f06217a9b95b7027286c7df21336e67e334c3e6e.1790674872.git.sd@queasysnail.net>
References:
 <f06217a9b95b7027286c7df21336e67e334c3e6e.1790674872.git.sd@queasysnail.net>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] strp_done() in net/strparser/strparser.c now calls
  lock_sock(strp->sk) and release_sock(strp->sk) (lines 514-516) with no…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the new sync
  in strp_done() relies on strp->stopped being reliably set, and in KCM…
- [Low] The concern is that the comment above strp_done()
  (net/strparser/strparser.c:507-509, 'strp must already be stopped so…

--

strparser: make sure __strp_recv isn't running before tearing down the parser

This commit adds a lock_sock()/release_sock() pair to strp_done(). The
pair makes sure that any strp_recv() already running under bh_lock_sock
or lock_sock has finished before the parser is torn down. It fixes a
race in espintcp teardown reported by Hyunwoo Kim.

Link: https://lore.kernel.org/all/aZgpkyTDU3aXe_V0@v4bel/

> diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
> index a23f4b4dfc673..401e67533005f 100644
> --- a/net/strparser/strparser.c
> +++ b/net/strparser/strparser.c
> @@ -511,6 +511,10 @@ void strp_done(struct strparser *strp)
>  {
>  	WARN_ON(!strp->stopped);
>  

[Severity: High]
This is a pre-existing issue, but the new sync here depends on
strp->stopped being set reliably. In KCM, that store looks like it can
be lost.

struct strparser packs stopped, paused, aborted, interrupted and
unrecov_intr as 1-bit fields in one u32. That means strp_stop() and
strp_unpause() both do a read-modify-write of the same word:

strp_stop():
	strp->stopped = 1;

strp_unpause():
	strp->paused = 0;

In kcm_unattach(), strp_stop() runs under lock_sock(csk) and
write_lock_bh(&csk->sk_callback_lock), before mux->rx_lock is taken.
kcm_rcv_ready() holds only mux->rx_lock when it does:

	strp_unpause(&psock->strp);
	strp_check_rcv(&psock->strp);

Can this interleaving lose the stop?

CPU0 (kcm_unattach)             CPU1 (kcm_rcv_ready)
                                strp_unpause()
                                  load word (stopped=0, paused=1)
strp_stop()
  store stopped=1
                                  store paused=0, stopped=0

After that, strp_check_rcv() queues strp->work. do_strp_work() blocks in
lock_sock(csk) until kcm_unattach() calls release_sock(csk) just before
strp_done(). It then sees stopped == 0 and runs:

do_strp_work()->strp_read_sock()->strp_recv()->kcm_rcv_strparser()
  ->reserve_rx_kcm()

That path can put the psock back onto mux->psocks_ready with
list_add_tail(), or set it as kcm->rx_psock. Either happens after
kcm_unattach() has already removed the psock under rx_lock. The
WARN_ON(!strp->stopped) above would fire. Later, kcm_unattach() calls
kmem_cache_free(kcm_psockp, psock) while the mux may still reach the
psock.

Would that be a use-after-free of struct kcm_psock?

AF_KCM has no capable() check, so an unprivileged user can reach both
paths: SIOCKCMUNATTACH on one side and kcm_rfree()->kcm_rcv_ready() on
the other. The window is a single read-modify-write.

For espintcp, a lost update fixes itself. The only concurrent bitfield
writes there are the interrupted/unrecov_intr stores in __strp_recv()
under bh_lock_sock. In the same critical section they are followed by
strp_parser_err()->strp_abort_strp(), which sets stopped again, and the
new lock_sock()/release_sock() waits for that section to finish.

> +	lock_sock(strp->sk);
> +	/* sync with pending strp_recv */
> +	release_sock(strp->sk);

[Severity: Medium]
Can this oops for a parser set up in general mode? strp_init() still
accepts a NULL sk as long as cb->lock and cb->unlock are supplied, and
stores it unchanged:

strp_init() {
    ...
	if (!sk) {
		if (!cb->lock || !cb->unlock)
			return -EINVAL;
	}

	memset(strp, 0, sizeof(*strp));

	strp->sk = sk;
    ...
}

For such a parser, strp_init(strp, NULL, cb) -> strp_stop() ->
strp_done() now ends up calling lock_sock(NULL). lock_sock_nested() then
dereferences sk->sk_lock. Before this patch, strp_done() never touched
strp->sk.

Documentation/networking/strparser.rst still says sk is set to NULL in
general mode, and that strp_done() must be called once the parser is
stopped.

Other code in this file also treats a NULL sk as a normal state.
strp_abort_strp() checks if (strp->sk), and do_strp_work() and
strp_msg_timeout() lock through strp->cb.lock()/strp->cb.unlock().

The commit message acknowledges the crash:

  This could crash on strp->sk ("general mode" of strp), but this mode
  has been here for 9 years and has never been used.

It also says:

  Only espintcp can be affected by this race condition, but this patch
  makes sure no future user of strp can have the bug.

A future user of general mode would crash here instead.

All in-tree strp_init() callers pass a real socket: espintcp_init_sk(),
kcm_attach(), sk_psock_init_strp() and ovpn_tcp_socket_attach(). None of
them overrides cb.lock/cb.unlock, so nothing in-tree hits this today.

This is headed to stable, and the API and documentation still allow
general mode. Would one of these be better?

  - guard the sync with if (strp->sk)
  - use strp->cb.lock(strp)/strp->cb.unlock(strp) instead; for every
    in-tree user that is lock_sock()/release_sock() via
    strp_sock_lock()/strp_sock_unlock()
  - drop general mode from strp_init() and the documentation

> +
>  	cancel_delayed_work_sync(&strp->msg_timer_work);
>  	cancel_work_sync(&strp->work);

[Severity: Low]
This isn't a bug introduced by this patch, but the comment above
strp_done() reads:

/* strp must already be stopped so that strp_recv will no longer be called.
 * Note that strp_done is not called with the lower socket held.
 */

With the new lock_sock() here, would "must not be called" be clearer
than "is not called"?

The requirement itself isn't new. do_strp_work() and strp_msg_timeout()
already take strp->cb.lock(), which for every in-tree user is
lock_sock(strp->sk) via strp_sock_lock(). So the cancel_work_sync() and
cancel_delayed_work_sync() calls here could already deadlock if the
caller held the socket lock.

All in-tree callers release the socket lock before calling strp_done(),
so this is only a wording nit.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/f06217a9b95b7027286c7df21336e67e334c3e6e.1790674872.git.sd%40queasysnail.net
