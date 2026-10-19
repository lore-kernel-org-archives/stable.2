Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD0E29E116;
	Mon, 19 Oct 2026 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792410000; cv=none; b=sk+omE6tYwIawUUUSpMxsq0D97N1yQOUJQj3S3gG2VYiUZKv2sot1xR7Bd4oLEl7qJBfXUsWhF9n6uTKjRaqE5/La3oScDPpgABXHBC6pg3KWBYlO8SMMjcUllKnLxi3Be6wMvv0RUPrKNKCp4OH6qWNz2s7QmR1lHvOd3RPCoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792410000; c=relaxed/simple;
	bh=Qph89yOUtQgOqZVxZJ5kREPik3PNlaeu9jjROoX+uSc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hzmj/mPvlJ9zNy3j56jjM4OHEZBlA4ILP/Of8kTb/PVSUdkQUnPlmjbrbcX87yC/dmEto5IL8GOShxUqGJTV2iCFjiEJPyUbSQGyt3ODRd9CejNK3DB0M9rkWgX0Qrg45vFmKXUzJrICiF6TjHnGFemRM7Laof5CLYOJVgi6bSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Du+unxfm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Du+unxfm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138A41F000C4;
	Mon, 19 Oct 2026 11:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792409998;
	bh=ppgv3sde9BfUFCjlo6uNKGzLm2p48ZtfrYiLyAps7uQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Du+unxfmq0nGhNn/tfND8fmgO/xvQ1AdcOinanC6kOExG+TgrPGG2gV1uIwbh3bzN
	 gThmL4jymrw9R/PMehGSU71W8L8vs9Gm6eIEzP+hN1U5R01YkV5sIdhHX3JACoMklr
	 V786CgVZM5IYAWNrVGqqzkb8V4jlGEmZsEouORrV+gQCZ2EnfeiMa8G1DbrcC3eDsM
	 qP07OJ1Dz0BybW9t1vhonriIiv5OkIwkXlCOqcgQjeFvyt8dqhyRYGB8jOZtB9nkGe
	 elK0oG+PYJufyQoiY0Bn1MvDpIVc2oZnRF0ekA9VzvV0FZX45oVRgiGzhMrcAQzh0l
	 BFiv8KIWNDgpg==
Subject:
 Re: [PATCH net v2] net/sched: cls_api: unlink indr cb on a failed bind
From: netdev-bot+sashiko@kernel.org
To: q.h.hack.winter@gmail.com
Cc: jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, pablo@netfilter.org, stable@vger.kernel.org
Date: Mon, 19 Oct 2026 11:39:57 +0000
Message-ID: <179240999753.3135.11391134985623127399@kernel.org>
In-Reply-To: <20261018112955.61470-1-q.h.hack.winter@gmail.com>
References: <20261018112955.61470-1-q.h.hack.winter@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new flow_indr_block_cb_unlink() helper takes
  flow_indr_block_lock, and the v2 notes say this stops the race with a…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the same
  failed indirect bind leaves a second stale indirect-offload object,…

--

net/sched: cls_api: unlink indr cb on a failed bind

With this patch, the tcf_block_bind() error path removes an indirect
flow_block_cb from flow_block_indr_list before freeing it. It does this
through a new flow_indr_block_cb_unlink() helper that takes
flow_indr_block_lock. The patch also initialises indr.list in
flow_block_cb_alloc(), so the helper does nothing for direct callbacks.

> diff --git a/net/core/flow_offload.c b/net/core/flow_offload.c
> index 5071d7fe6ce2a..62bc2eb6e0da1 100644
> --- a/net/core/flow_offload.c
> +++ b/net/core/flow_offload.c

[ ... ]

> @@ -525,6 +527,13 @@ static void flow_block_indr_init(struct flow_block_cb *flow_block,
>  	flow_block->indr.cleanup = cleanup;
>  }
>  
> +void flow_indr_block_cb_unlink(struct flow_block_cb *block_cb)
> +{
> +	mutex_lock(&flow_indr_block_lock);
> +	list_del_init(&block_cb->indr.list);
> +	mutex_unlock(&flow_indr_block_lock);
> +}

[Severity: High]
Does taking flow_indr_block_lock here really serialize against a
concurrent flow_indr_dev_unregister()? The v2 notes say it does.

Unregister only holds the lock while it moves the matching callbacks onto
a private list on its stack:

net/core/flow_offload.c:flow_indr_dev_unregister() {
    ...
	__flow_block_indr_cleanup(release, cb_priv, &cleanup_list);
	mutex_unlock(&flow_indr_block_lock);

	tcf_action_reoffload_cb(cb, cb_priv, false);
	flow_block_indr_notify(&cleanup_list);
    ...
}

flow_block_indr_notify() then walks cleanup_list without the lock. For
each entry it poisons the list node and calls the cleanup callback:

	list_for_each_entry_safe(this, next, cleanup_list, indr.list) {
		list_del(&this->indr.list);
		this->indr.cleanup(this);
	}

For tc, the cleanup callback is tc_block_indr_cleanup(). It blocks in
rtnl_lock() and down_write(&block->cb_lock).

The binder holds both of those locks for the whole of
tcf_block_offload_bind(), and that includes the err_unroll path in
tcf_block_bind().

So this sequence looks possible:

CPU A (driver teardown)
flow_indr_dev_unregister()
  __flow_block_indr_cleanup()      /* moves X to cleanup_list */
  mutex_unlock(&flow_indr_block_lock)
  flow_block_indr_notify()
    list_del(&X->indr.list)        /* X poisoned */
    tc_block_indr_cleanup(X)
      rtnl_lock()                  /* blocks */

CPU B (tc qdisc add, holding rtnl and cb_lock)
tcf_block_bind()
  err_unroll:
    flow_indr_block_cb_unlink(X)   /* list_del_init() on poison */
    flow_block_cb_free(X)

If the walker has already called list_del() on X, does list_del_init()
in this helper then run on LIST_POISON1/LIST_POISON2? Before this patch
the error path never touched indr.list, so that crash point looks new.

X could instead be the walker's saved next pointer, while the cleanup of
an earlier entry is blocked on rtnl. In that case the helper unlinks X
from CPU A's private cleanup_list and frees it. Would the walker then
step into freed memory?

Either way, once CPU A gets rtnl and cb_lock, tc_block_indr_cleanup()
runs:

	list_del(&block_cb->driver_list);
	list_move(&block_cb->list, &bo.cb_list);
	tcf_block_unbind(block, &bo);

Does this write into the already freed X? tcf_block_unbind() would then
call flow_block_cb_free(X) a second time, which runs the driver's
->release() on cb_priv twice.

The error path seems to need a way to tell, under flow_indr_block_lock,
that unregister has already claimed the entry, and skip the free in that
case. The other option is to make the notify/cleanup side handle it.

> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index a9f54988561f2..9e4ea37154191 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -1665,6 +1665,7 @@ static int tcf_block_bind(struct tcf_block *block,
>  err_unroll:
>  	list_for_each_entry_safe(block_cb, next, &bo->cb_list, list) {
>  		list_del(&block_cb->driver_list);
> +		flow_indr_block_cb_unlink(block_cb);
>  		if (i-- > 0) {
>  			list_del(&block_cb->list);
>  			tcf_block_playback_offloads(block, block_cb->cb,

[Severity: High]
This is a pre-existing issue, but a failed indirect bind also leaves a
stale flow_indir_dev_info entry on flow_indir_dev_list. Could that entry
cause a use-after-free later?

flow_indr_dev_setup_offload() records the bind before it knows whether
the bind succeeds. It holds no references on dev, sch or the block:

	if (bo) {
		if (bo->command == FLOW_BLOCK_BIND)
			indir_dev_add(data, dev, sch, type, cleanup, bo);

On the indirect path, tcf_block_offload_cmd() ignores the result of
tcf_block_setup() and always returns -EOPNOTSUPP:

	flow_indr_dev_setup_offload(dev, sch, TC_SETUP_BLOCK, block, &bo,
				    tc_block_indr_cleanup);
	tcf_block_setup(block, &bo);

	return -EOPNOTSUPP;

tcf_block_offload_bind() then fails whenever the block already has
offloaded filters:

no_offload_dev_inc:
	if (tcf_block_offload_in_use(block))
		goto err_unlock;

The err_block_offload_bind path in tcf_block_get_ext() never sends
FLOW_BLOCK_UNBIND, so indir_dev_remove(block) is never called. Once the
qdisc, the device or the shared block is freed, info->sch, info->dev and
info->cb_list point to freed memory.

The next flow_indr_dev_register() then calls existing_qdiscs_register(),
which does:

	cb(cur->dev, cur->sch, cb_priv, cur->type, &bo, cur->data, cur->cleanup);
	list_splice(&bo.cb_list, cur->cb_list);

Would that pass freed dev and sch pointers to the driver? For example,
mlx5e_rep_indr_setup_block() dereferences netdev right away. Would it
also splice into the flow_block.cb_list of a freed block?

Triggering this does not need tcf_block_bind() to fail. It is enough to
bind a device without ndo_setup_tc to a shared block that already has
offloaded filters, even when no indirect driver is registered. Any later
driver load or reload that calls flow_indr_dev_register() then uses the
stale entry.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018112955.61470-1-q.h.hack.winter%40gmail.com
