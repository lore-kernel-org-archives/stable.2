Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F814399350;
	Sat, 10 Oct 2026 22:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791672930; cv=none; b=dLFqhuKb8KD/yI1RnnKaIyYFJQGj+e4dFj3u1MjTuMhv22kd5+hdl31ngUS+JYr4OMvW6w0evTVgcS7qeSXHlAdBTLCmTQ9L6yKgHUyhOxqPdF5gE1xfog1pCjEJUB7LUQB2rhKTZCl/y6zmtZ324oebKgvHDkPfNy+5OA1N5Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791672930; c=relaxed/simple;
	bh=Ersv1rRitKQ1BXXKj4ddDkK2o0lks/h/Lj6mQfbqD1I=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sm92Og7jsZUTrnKcPv9/gGgmgidMkeBjt3RjHKZIElrYCWbFIAs2mZ8JxEoF6kQN+VQX+GKF+jHYgATjIUXJcobynbyBi51KcvpwaighR5/oSY1NR0RuZLRsAPpAoJYIQmbXAqB5eK3WkBaiYn+tgL7MaxsYyQsy23MTY806swQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kq8djmns; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kq8djmns"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A23A1F00893;
	Sat, 10 Oct 2026 22:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791672929;
	bh=oSbAjsO8Daqmc/FHcAs+zGQUdudv8Ra7/x/JNn6yMTM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Kq8djmnsmf4jj23iPktlohHumQtiDII60OdQOvppce/h5/U0wmCjHIC3LhDDyJouC
	 fJCh/zaeSU4aS1MExxge0jA857MGzoswoNNpsSbbR+0VXWJBn2pkXU6K5zc5KiEvLh
	 Nr2/sXXzqQwgDVBhRD9gVQdHEJ38xgB938YpA93cQnHEhoi8tTBTo94LhOCBiQdnKz
	 l4eayN8rDeNu+YD4yDfCIFiClkKEGuhJ4wDHQGrfU/Dfz3cqq9QNvgEjJRo3J6oi34
	 WutRx7wgte+R/KXB/jg0vhynQLa8YZ+PspZJqqXlNtI1MYxT2eb8+Cf/Fo63cAEaJG
	 9lDzjVrw58kog==
Subject: Re: [PATCH net] ipv6: fix fib6 walker UAF on NLM_F_REPLACE
From: netdev-bot+sashiko@kernel.org
To: cenzhang@linux.microsoft.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 mazziesaccount@gmail.com, greearb@candelatech.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com
Date: Sat, 10 Oct 2026 22:55:27 +0000
Message-ID: <179167292799.434549.17886083109176424564@kernel.org>
In-Reply-To: <20261009225142.47005-1-cenzhang@linux.microsoft.com>
References: <20261009225142.47005-1-cenzhang@linux.microsoft.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] fib6_walkers_skip_rt() (net/ipv6/ip6_fib.c:95-113) is
  documented as moving walkers that rest on @rt to the next route.
- [Medium] In the NLM_F_REPLACE branch of fib6_add_rt2node()
  (net/ipv6/ip6_fib.c:1338-1342) the new route rt takes over iter's slot…

Pre-existing issues:
- [Medium] When a dump resumes and the sernum has changed,
  fib6_dump_table() (net/ipv6/ip6_fib.c:632-638) writes w->state =…

--

ipv6: fix fib6 walker UAF on NLM_F_REPLACE

This patch moves the walker adjustment out of fib6_del_route() into a new
helper, fib6_walkers_skip_rt(). The helper is also called from the
NLM_F_REPLACE branch of fib6_add_rt2node() for the replaced route and for
each removed ECMP sibling. The goal is to keep an RTM_GETROUTE dump from
resuming on a freed fib6_info when the fn_sernum check is bypassed.

> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index 9ff761962b45c..a5699809fe049 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -89,6 +89,29 @@ static void fib6_walker_unlink(struct net *net, struct fib6_walker *w)

[ ... ]

> +/* Move the walkers resting on @rt to the next route, or up the tree if
> + * @rt is the last one.  Called with tb6_lock held.
> + */
> +static void fib6_walkers_skip_rt(struct net *net, struct fib6_info *rt)
> +{

[ ... ]

> +	read_lock(&net->ipv6.fib6_walker_lock);
> +	FOR_WALKERS(net, w) {
> +		if (w->state == FWS_C && w->leaf == rt) {
> +			pr_debug("walker %p adjusted by unlink of %p\n", w, rt);
> +			w->leaf = next;

[Severity: Medium]
Should w->skip_in_node be reset here too?

This moves the walker to a different route, but w->skip_in_node still
holds the number of entries already sent for the old route.
fib6_dump_node() keeps that count per w->leaf:

net/ipv6/ip6_fib.c:fib6_dump_node() {
    ...
		res = rt6_dump_route(rt, w->args, w->skip_in_node);
		if (res >= 0) {
			/* Frame is full, suspend walking */
			w->leaf = rt;
			...
			w->skip_in_node += res;
    ...
}

fib6_dump_table() clears it only on a sernum mismatch. When the sernum
matches, it does just this:

		} else
			w->skip = 0;

Suppose the dump paused partway through the exceptions of route R
(skip_in_node >= 1), and R is then removed through this helper. The
resumed dump calls rt6_dump_route() on R->fib6_next with the stale skip:

net/ipv6/route.c:rt6_dump_route() {
    ...
	if (filter->dump_routes) {
		if (skip) {
			skip--;
		} else {
			if (rt6_fill_node(net, arg->skb, rt, NULL, NULL, NULL,
    ...
}

That drops the next route's own RTM_NEWROUTE message, and the leftover
skip hides its first exceptions. In the FWS_U case, the first route of a
later node is dropped instead. NLM_F_DUMP_INTR is not set in either case.

With this patch, the same thing can happen for a replaced route and for
each removed ECMP sibling in fib6_add_rt2node(). That needs the resume to
go through the fn_sernum == -1 collision described in the commit message.

fib6_del() does not bump the root sernum, so the delete path behaved this
way on a normal resume even before the code was moved out of
fib6_del_route().

Would adding w->skip_in_node = 0 where w->leaf is reassigned make the
helper match its comment?

> +			if (!next)
> +				w->state = FWS_U;

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch, but can
this store race with the lockless walker reset in fib6_dump_table()?

When the sernum has changed, fib6_dump_table() resets the walker before it
takes tb6_lock. The walker is still linked on net->ipv6.fib6_walkers at
that point:

net/ipv6/ip6_fib.c:fib6_dump_table() {
    ...
		if (cb->args[5] != sernum) {
			/* Begin at the root if the tree changed */
			cb->args[5] = sernum;
			w->state = FWS_INIT;
			w->node = w->root;
			w->skip = w->count;
			w->skip_in_node = 0;
		} else
			w->skip = 0;

		spin_lock_bh(&table->tb6_lock);
    ...
}

At the same time, this helper holds only tb6_lock and
read_lock(fib6_walker_lock), and it can still see w->state == FWS_C and
w->leaf == rt.

If its FWS_U store lands after the FWS_INIT store, fib6_walk_continue()
starts at w->root in state FWS_U:

		case FWS_U:
			if (fn == w->root)
				return 0;

The rest of the table is then silently left out of the dump, with no
NLM_F_DUMP_INTR.

The same race already existed with fib6_del_route() as the writer. This
patch adds the replace paths in fib6_add_rt2node() as more writers. I don't
see a use-after-free here, because FWS_INIT and FWS_U do not dereference
w->leaf.

[ ... ]

> @@ -1315,6 +1338,7 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
>  		fib6_info_hold(rt);
>  		rcu_assign_pointer(rt->fib6_node, fn);
>  		rt->fib6_next = iter->fib6_next;
> +		fib6_walkers_skip_rt(info->nl_net, iter);
>  		rcu_assign_pointer(*ins, rt);

[Severity: Medium]
Can a resumed dump skip the replacement route rt here?

In this branch, rt takes over iter's slot in the leaf list. The helper
treats that as a deletion. It moves walkers on iter to iter->fib6_next,
which comes after rt, or sets FWS_U if iter was the last route in the
node.

fib6_dump_node() leaves w->leaf on the route it hadn't finished. In the
common case, the pause happened at rt6_fill_node() of iter itself with
skip_in_node == 0, so nothing from iter has been sent yet.

Suppose the dump then resumes on the sernum-match path (the
fn_sernum == -1 case from the commit message). fib6_dump_node() starts at
w->leaf and never visits rt. The dump then contains neither the old route
nor its replacement for that prefix and metric, and NLM_F_DUMP_INTR is not
set.

On the sernum-mismatch path, the node is walked again from fn->leaf and rt
is dumped, so the two resume paths give different results.

The ECMP sibling loop further down looks fine, since those routes really
are removed.

For the replaced slot itself, would pointing walkers on iter at rt (and
clearing skip_in_node) keep the replacement in the dump?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009225142.47005-1-cenzhang%40linux.microsoft.com
