Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D627D3002CF;
	Mon,  5 Oct 2026 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190663; cv=none; b=OtfYkhTMoWUlreF+QgjGIctdOEztprMl+87iQhtkd6NIp27yHfZfDpcyLun3mA48AkNL/sf/gI+p1hzTAlj8tmXiEbkqWQmJ5cn2vbmhct6+3motugrFRR3tEq4DXXFd2xWhckSCi7QjXjsk9cZY+JfHlLJs1yg9MeSbvJ9O9HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190663; c=relaxed/simple;
	bh=XjWcuUrd7k7lY5Kotix5/3ConqgPhYTTwxQ2qzQyRiE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o79IDgas62EtjWrq6q36Jk3zdH85OCiwhI68icDdkgT78SFGH/BQGV9yvebKNbMCwzaRf5TKdbxUdPU0ETEZ7m5uLaMROUrrPXSdvh0kkpkcmA/jIYFKBSqZsGg2BBiC3f0OJf4jNjChMCFa6GA/4Qs11v4rogxHJ2bJbsvC4Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RN4XdU6n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RN4XdU6n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339E91F000FF;
	Mon,  5 Oct 2026 08:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791190661;
	bh=Gyldysy9Dc9evEL89sNJq+ei2A+IB5431SJpx8esMJw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RN4XdU6nk1F5CyK9nrXaEZxmHtz3HG8rtOdXauYa3T4Q8AsVBrcqOYB3JkXA8s8m/
	 sX1MRHIqONWiSBM537qaZAIE7jSFpdy30vqv4IfX9gIxgHXfpFdvOxm+9tkW4Sn3pO
	 XBSfOHzMl1jhHmXlY6chPPMCQHmWkbQXuKdZ9lH++1srdgvuBff8N3hFaROcn0yXXp
	 xbPJxOf5s+VkFwxSyYua0T++5FHThgnifN926KBLpxC5mVP8nmn7T7BEnT6zfotr60
	 c2MBlYHg6VJ3ALaP8/w5DgKmhLIqCW+gEYqPSsLMlsAaTSaRXAYFwKgmTsTWvn/Lhz
	 97lsfPLANpyyw==
Subject: Re: [PATCH net] net/sched: cls_bpf: accept dev-bound programs on
 shared blocks
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, john.fastabend@gmail.com,
 sdf@fomichev.me, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, bpf@vger.kernel.org,
 victor@mojatatu.com, stable@vger.kernel.org, sashiko-bot@kernel.org
Date: Mon, 05 Oct 2026 08:57:39 +0000
Message-ID: <179119065973.434549.15208309588917304307@kernel.org>
In-Reply-To: <QDISC-PYC7.v1.20261003103747@mojatatu.com>
References: <QDISC-PYC7.v1.20261003103747@mojatatu.com>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch's 'every member must match' rule for dev-bound
  cls_bpf programs on shared blocks is checked only once.
- [Low] bpf: multi-line comment style violation in cls_bpf.c

--

net/sched: cls_bpf: accept dev-bound programs on shared blocks

This patch lets a device-bound cls_bpf program attach through a shared tc
block, as long as bpf_offload_dev_match() succeeds for every netdev in
block->ports. An empty shared block is rejected. Non-shared blocks are still
checked against the qdisc's device.

Link: https://lore.kernel.org/netdev/20260809094418.901607-1-jhs@mojatatu.com/

> diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
> index 188cf0f949dd4..6a54f8a7b8218 100644
> --- a/net/sched/cls_bpf.c
> +++ b/net/sched/cls_bpf.c
> @@ -392,9 +392,29 @@ static int cls_bpf_prog_from_efd(struct nlattr **tb, struct cls_bpf_prog *prog,
>  	if (bpf_prog_is_dev_bound(fp->aux)) {
>  		struct tcf_block *block = tp->chain->block;
>  		struct net_device *dev;
> -
> -		dev = block->q ? qdisc_dev(block->q) : NULL;
> -		if (!dev || !bpf_offload_dev_match(fp, dev)) {
> +		unsigned long ifindex;
> +		bool found = false;
> +		bool match = false;
> +
> +		/* A shared block has no qdisc (block->q == NULL) but may
> +		 * bind several netdevs; the program is offloaded to all of
> +		 * them, so it must match all of them.
> +		 */
> +		if (!tcf_block_shared(block)) {
> +			match = bpf_offload_dev_match(fp, qdisc_dev(tcf_block_q(block)));
> +		} else {
> +			xa_for_each(&block->ports, ifindex, dev) {
> +				found = true;
> +				if (!bpf_offload_dev_match(fp, dev)) {

[Severity: Low]
This is a minor style nit. The new block comment in
cls_bpf_prog_from_efd() starts its text on the same line as the
opening /*.

cls_bpf.c is a BPF-related path, and BPF code uses the multi-line
comment style with the opening /* on a line of its own. That applies
even where the surrounding code in the file uses the older form.

Could you move the text down so the comment reads like this?

		/*
		 * A shared block has no qdisc (block->q == NULL) but may
		 * bind several netdevs; the program is offloaded to all of
		 * them, so it must match all of them.
		 */

This has no functional impact. If the comment text changes because of
the block->ports concern above, it is worth fixing in the same respin.

[Severity: High]

This check runs only once, when the filter is added or replaced. It uses
whatever block->ports holds at that moment. What happens if a netdev from a
different bpf_offload_dev joins the shared block later?

For example:

  tc qdisc add dev B ingress_block 22 clsact
  tc filter add block 22 ingress bpf da object-pinned <pin> skip_sw
  tc qdisc add dev C ingress_block 22 clsact

On the third command, tcf_block_get_ext() finds the existing block and
replays its filters to C's callback. This happens before C is added to
block->ports:

net/sched/cls_api.c:tcf_block_get_ext() {
    ...
	err = tcf_block_offload_bind(block, q, ei, extack);
	if (err)
		goto err_block_offload_bind;

	if (tcf_block_tracks_dev(block, ei)) {
		err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
    ...
}

The call chain is tcf_block_offload_bind()->tcf_block_bind()->
tcf_block_playback_offloads()->cls_bpf_reoffload(). cls_bpf_reoffload()
passes prog->filter to the new callback without calling
bpf_offload_dev_match():

net/sched/cls_bpf.c:cls_bpf_reoffload() {
    ...
		cls_bpf.prog = add ? prog->filter : NULL;
    ...
		err = tc_setup_cb_reoffload(block, tp, add, cb, TC_SETUP_CLSBPF,
					    &cls_bpf, cb_priv, &prog->gen_flags,
					    &prog->in_hw_count);
    ...
}

netdevsim's nsim_bpf_setup_tc_block_cb() does not check the device either.
It only requires prog->aux->offload to be non-NULL before calling
nsim_bpf_offload(). That sets C's bpf_offloaded and marks the program as
loaded in state owned by B's nsim_dev.

Doesn't this build the mixed block that the commit message says the
all-members check prevents?

  "an any-member check would re-admit the wrong-device attach on a mixed
  block."

Before this patch, block->q is NULL on a shared block, so every dev-bound
program was rejected there. That kept dev-bound programs off this replay
path.

This looks like the problem that commit 120977e2c096 fixed. When B is
unregistered, __bpf_offload_dev_netdev_unregister() has no altdev, so it
calls __bpf_prog_offload_destroy():

kernel/bpf/offload.c:__bpf_prog_offload_destroy() {
    ...
	if (offload->dev_state)
		offload->offdev->ops->destroy(prog);

	list_del_init(&offload->offloads);
	kfree(offload);
	prog->aux->offload = NULL;
}

If is_loaded is still set, nsim_bpf_destroy_prog() can hit its WARN here.

The filter and block stay alive because C still holds them. Deleting the
filter or C's clsact later goes through
nsim_bpf_offload()->nsim_prog_set_loaded(). aux->offload_requested is still
true, so the bpf_prog_is_offloaded() check passes, and then:

drivers/net/netdevsim/bpf.c:nsim_prog_set_loaded() {
    ...
	state = prog->aux->offload->dev_priv;
	state->is_loaded = loaded;
}

Can this dereference a NULL prog->aux->offload?

The reproducer in the commit message only adds the second device before the
attach. Does the check also need to run on the bind/reoffload side? Or
should dev-bound programs stay rejected on shared blocks?

There is a smaller related gap. tcf_block_tracks_dev() only records clsact
ingress and egress binders in block->ports:

net/sched/cls_api.c:tcf_block_tracks_dev() {
	return tcf_block_shared(block) &&
	       (ei->binder_type == FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS ||
		ei->binder_type == FLOW_BLOCK_BINDER_TYPE_CLSACT_EGRESS);
}

Other shared-block binders, such as those set up by tcf_qevent_init(), also
register offload callbacks. They never appear in block->ports, so the new
xa_for_each() loop does not see them. Could a device bound this way receive
the program without being checked?

> +					match = false;
> +					break;
> +				}
> +				match = true;
> +			}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-PYC7.v1.20261003103747%40mojatatu.com
