Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44574CEE67;
	Thu, 15 Oct 2026 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792092639; cv=none; b=coKd/dM1S5Ehp5uW/lU8Zqh7lunpeShQXHxEfHATWQ3O1gAjw1NJ/6EIAC+iI2vHQsFKi4AHJHOtxtQBfADx5jU+/C+yOCH4vw92Fs8vloFq0lCsoLemBnzKbejTS2JcCV9qqorhbJ7S7XBtv+Lzh99byV9sdLBX9MOdFQtqpS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792092639; c=relaxed/simple;
	bh=pKk/wXorJdH86zpht2s/ZUaqa4iwaQQoHEvFkj1kMuE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IacMChXoHZMbQxeAbjkRsZWAwSgADT5YbxpE6jm5mwkOiwS7qwlc+WTOtKYP2Te5EC9Vs9Rw97Fb4i37//ylcwzEytzi+pSCXAtvO/56NeQu2eQ8/CP7EtL0JXDl2iOAPnzslQt9SNY1qkfcxmg/MbyKQ1FK5Jb6y3BX5ixfeYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeNwwBnU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeNwwBnU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9653A1F000C4;
	Thu, 15 Oct 2026 19:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792092636;
	bh=kgI9ggIKqdumJSL9nrA13PauMuxnRdXRZbi4QKVS5ZA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jeNwwBnUAJxNZBJFTUuoD5N58037qydPZXXpPXc10kzbuohzoldTQsWNUrDRlyGmp
	 UO8DkzL1C8LdUi2VObotPykQBxFe3flecYlRNHjlmZGxqT2e2fgIlRwPBUkPFtSlt1
	 7hTaVOMe4FfQouIryB+AwkJB8vdZ3y76YQ86emlGElVkB7kcLXvbGCfipM97TZGPAv
	 1QQcoRB8DsjYFE72abPdfK/NgX1mnJPMwlimOchkWEkyR5z8myhUtHwdN4rhes/y7P
	 ZxAaCiweE7T9KUrJ3SzBj/Wnwl85ZnR0IgK96rqPxLv7qIeVpSPo6De72M+sf6mnDq
	 Kear0lRI4WG/g==
Subject: Re: [PATCH net] net/sched: cls_api: unlink indr cb on a failed bind
From: netdev-bot+sashiko@kernel.org
To: q.h.hack.winter@gmail.com
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, pablo@netfilter.org, stable@vger.kernel.org
Date: Thu, 15 Oct 2026 19:30:35 +0000
Message-ID: <179209263510.434549.8724854871414759928@kernel.org>
In-Reply-To: <20261013162949.25622-1-q.h.hack.winter@gmail.com>
References: <20261013162949.25622-1-q.h.hack.winter@gmail.com>
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

Critical: 0 · High: 2 (2) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix does not cover the other way an indirect bind fails.
- [High] The new `if (!list_empty(&block_cb->indr.list))
  list_del_init(&block_cb->indr.list);` in tcf_block_bind()'s err_unroll…

Pre-existing issues:
- [High] On every FLOW_BLOCK_BIND, flow_indr_dev_setup_offload() calls
  indir_dev_add(data, dev, sch, ...) unconditionally…
- [High] This problem wasn't introduced by this patch, but
  tcf_block_bind()'s err_unroll (the loop the patch edits)…

--

net/sched: cls_api: unlink indr cb on a failed bind

This patch changes the err_unroll path in tcf_block_bind() so that it
removes a block_cb from the global flow_block_indr_list before freeing
it. The goal is that a failed indirect bind no longer leaves a freed node
on that list. It also initializes indr.list in flow_block_cb_alloc(), so
that list_empty() can tell indirect callbacks apart from direct ones.

> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index a9f54988561f2..ffbb8353251b0 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -1665,6 +1665,9 @@ static int tcf_block_bind(struct tcf_block *block,
>  err_unroll:
>  	list_for_each_entry_safe(block_cb, next, &bo->cb_list, list) {
>  		list_del(&block_cb->driver_list);

[Severity: High]
This isn't a bug introduced by this patch, but can this list_del() oops
for callbacks that come from the sfc driver?

In drivers/net/ethernet/sfc/tc_bindings.c, efx_tc_setup_block() and
efx_tc_indr_setup_cb() allocate the callback with
flow_block_cb_alloc()/flow_indr_block_cb_alloc() and add it with
flow_block_cb_add(). Neither one links block_cb->driver_list anywhere.

flow_block_cb_alloc() uses a zeroed allocation, and this patch only
initializes indr.list. So driver_list.next and driver_list.prev are still
NULL when they reach this list_del().

A user can make playback fail on purpose. If a shared block has
offloaded filters and also a classifier without ->reoffload (basic, fw,
route, flow, cgroup), tcf_block_playback_offloads() returns -EOPNOTSUPP:

	} else if (add && offload_in_use) {
		err = -EOPNOTSUPP;
		...
		goto err_playback_remove;

With sfc TC offload up, the sfc callback is on bo->cb_list both for a
direct bind of an sfc port and for an indirect bind of a vxlan or dummy
device.

Would err_unroll then dereference NULL in
list_del(&block_cb->driver_list)?

The unconditional list_del() of driver_list was added by commit
da94a7781fc3 ("net/sched: cls_api: remove block_cb from driver_list
before freeing").

> +		/* linked only for an indirect bind */
> +		if (!list_empty(&block_cb->indr.list))
> +			list_del_init(&block_cb->indr.list);

[Severity: High]
Is it safe to change the global flow_block_indr_list here without holding
flow_indr_block_lock?

That mutex is static to net/core/flow_offload.c.
flow_indr_dev_setup_offload() has already dropped it by the time
tcf_block_setup()->tcf_block_bind() runs. Every other writer of
flow_block_indr_list holds it:

  flow_indr_block_cb_alloc():
	list_add(&block_cb->indr.list, &flow_block_indr_list);

  __flow_block_indr_cleanup():
	list_move(&this->indr.list, cleanup_list);

This path holds only RTNL and block->cb_lock. Neither lock excludes
nft_indr_block_offload_cmd() or the nf_flow_table indirect setup, which
both call flow_indr_dev_setup_offload() without RTNL.
flow_indr_dev_unregister() can't hold RTNL either, because
tc_block_indr_cleanup() takes rtnl_lock() itself.

Here is one possible interleaving with flow_indr_dev_unregister():

CPU1 (flow_indr_dev_unregister)
  __flow_block_indr_cleanup()   [ under mutex, moves the tc block_cb to
                                  its private cleanup_list ]
  mutex_unlock()
  flow_block_indr_notify()
    list_del(&this->indr.list)  [ leaves LIST_POISON ]
    tc_block_indr_cleanup()
      rtnl_lock()               [ blocks, CPU0 holds RTNL ]

CPU0 (tcf_block_bind() err_unroll, holding RTNL)
  !list_empty(&block_cb->indr.list)   [ true, next is LIST_POISON1 or
                                        points into CPU1's cleanup_list ]
  list_del_init(&block_cb->indr.list)
  flow_block_cb_free(block_cb)

Without CONFIG_DEBUG_LIST, wouldn't list_del_init() dereference the
poison pointer?

Once CPU0 drops RTNL, tc_block_indr_cleanup() goes on to run:

	list_del(&block_cb->driver_list);
	list_move(&block_cb->list, &bo.cb_list);
	tcf_block_unbind(block, &bo);

on the block_cb that CPU0 just freed.

A race with list_add() in flow_indr_block_cb_alloc() from an nftables
commit also looks like it could lose updates. The list could then keep a
pointer to the freed block_cb.

Would it be better to unwind with a FLOW_BLOCK_UNBIND through
flow_indr_dev_setup_offload()? Another option is a helper in
flow_offload.c that takes the lock and leaves exactly one owner
responsible for the free.

[Severity: High]
Does this cover the other way an indirect bind can fail in
tcf_block_get_ext()?

Suppose a device without ndo_setup_tc (vxlan, dummy, ...) binds to a
shared block that already has offloaded filters. tcf_block_bind() can
succeed and list_splice() the indirect block_cb onto
block->flow_block.cb_list.

On the indirect path, tcf_block_offload_cmd() then ignores the result:

	flow_indr_dev_setup_offload(dev, sch, TC_SETUP_BLOCK, block, &bo,
				    tc_block_indr_cleanup);
	tcf_block_setup(block, &bo);

	return -EOPNOTSUPP;

After that, tcf_block_offload_bind() fails because offload is in use:

no_offload_dev_inc:
	if (tcf_block_offload_in_use(block))
		goto err_unlock;

tcf_block_get_ext() then jumps to err_block_offload_bind, which skips
tcf_block_offload_unbind(). No FLOW_BLOCK_UNBIND reaches the driver, so
flow_indr_block_cb_remove() never runs. ingress_destroy() and
clsact_destroy() see a NULL block and return early.

The block_cb stays on both block->flow_block.cb_list and
flow_block_indr_list. Its indr.sch points at the qdisc that was freed,
and its indr.data points at the block.

Later, when the remaining direct owner unbinds, only its own cb is
removed, and tcf_block_destroy() kfree_rcu()s the block. A later
flow_indr_dev_unregister() of the indirect driver would then reach:

  flow_block_indr_notify()
    tc_block_indr_cleanup()
      down_write(&block->cb_lock);
      list_del(&block_cb->driver_list);
      list_move(&block_cb->list, &bo.cb_list);
      tcf_block_unbind(block, &bo);

on the freed block. Isn't this the failed-bind case the commit message
describes?

  -> err_block_offload_bind            [ no tcf_block_offload_unbind() ]

Would sending an UNBIND to unwind the indirect bind from the
tcf_block_offload_bind()/tcf_block_get_ext() failure path cover both
cases?

[Severity: High]
This is a pre-existing issue, but the new unlink only handles indr.list.
What happens to the flow_indir_dev_info entry created for the same bind?

flow_indr_dev_setup_offload() adds one on every FLOW_BLOCK_BIND, before
it is known whether the bind will succeed:

	if (bo) {
		if (bo->command == FLOW_BLOCK_BIND)
			indir_dev_add(data, dev, sch, type, cleanup, bo);

indir_dev_add() stores the qdisc, the net_device, the block and
&block->flow_block.cb_list without taking any references.

The only removal is indir_dev_remove() on FLOW_BLOCK_UNBIND. A failed
bind in tcf_block_get_ext() never sends one, either on the err_unroll
path or on the offload_in_use path.

For example, take a block whose existing owner is a direct ndo_setup_tc
device, so it has no info entry yet. A qdisc on a vxlan or dummy device
then fails to bind to it. The entry stays behind after that qdisc is
freed, and again after the block is freed. A later
flow_indr_dev_register() calls existing_qdiscs_register():

		cb(cur->dev, cur->sch, cb_priv, cur->type, &bo, cur->data, cur->cleanup);
		list_splice(&bo.cb_list, cur->cb_list);

Can this pass a freed dev/sch to the driver callback? For example,
efx_tc_indr_setup_cb() calls netif_is_ovs_master() on the net_device.
Can it also splice new block_cbs into a list head inside the freed
tcf_block?

find_indir_dev() matches only on the block. So a stale entry would also
make indir_dev_add() return -EEXIST for a later valid indirect bind to
the same block, and the real dev/sch of that bind would never be
recorded.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013162949.25622-1-q.h.hack.winter%40gmail.com
