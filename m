Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85292F5A36
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046718; cv=none; b=mkHLiK8S2RXUG1jVfDXReM2hsQDPLau4PG8nKU9kGo/j87s2PjxiaFlZ11TWklWkpynWv75bO/MFdlUZpQocCaNU8uJtHzIKtY+F1TAPtudLttDWUBWUUoiZxFf703HUjh1JhunbpcfxsJOSdAl7AM9cn/dNGV+8jWjwenZgNos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046718; c=relaxed/simple;
	bh=ocYkrzscP5wYcdcfpvHBvpnFAaMdcJzEPDLOkuBC1nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpUN0F6syjadnplLchdKLovf1KPdcf0OYQO9/+twUHcG1Rx480RHLo0Em97OmQxSC5nxvOCXQs3J15k4ACEECdU8aPDfgaoqTqnLG0gV2PEBOydw2pasTnhTpgcdhqRwB+kQolJr9uEnd1dAPsR8UChA8coWA0WxaBbkd4xv3Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TOsMXpU9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOsMXpU9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787046715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d7kaX65vemzEaqdaxJ8qgE4Z8totafAQ1xtXw/YqCQU=;
	b=TOsMXpU9ghQOvKsR6dekARJbY8r7aHsyPWQGhrPLePhKx7iX/vH6XSvGgdeLedr6/Dmc37
	X9+Uve3fSUQvXo2cy9kq2bPypcn7spJRQZ9alcsvRqSAX47laE7cV8K8T/OtckcyU34/Vj
	yiJKtnXP8Mn31lc5cdwSn0zRet+v5Mk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-NCTRcMjkObGScZ4FgKA5Qw-1; Tue,
 18 Aug 2026 05:51:41 -0400
X-MC-Unique: NCTRcMjkObGScZ4FgKA5Qw-1
X-Mimecast-MFC-AGG-ID: NCTRcMjkObGScZ4FgKA5Qw_1787046699
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8B6B195608E;
	Tue, 18 Aug 2026 09:51:38 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.207])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 17D903000239;
	Tue, 18 Aug 2026 09:51:34 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: jedrzej.jagielski@intel.com
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	kuba@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	edumazet@google.com,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org,
	aleksandr.loktionov@intel.com
Subject: Re: [PATCH net v2 1/3] net/sched: cls_u32: feed u32_replace_hw_knode() with correct set of flags
Date: Tue, 18 Aug 2026 11:51:30 +0200
Message-ID: <20260818095130.103933-1-pabeni@redhat.com>
In-Reply-To: <20260813122242.1690024-2-jedrzej.jagielski@intel.com>
References: <20260813122242.1690024-2-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net/sched: cls_u32: feed u32_replace_hw_knode() with correct set of flags

The patch changes the two u32_replace_hw_knode() calls in u32_change() to
pass userflags (the TCA_CLS_FLAGS_* set parsed from TCA_U32_FLAGS) instead
of flags (the TCA_ACT_FLAGS_* set passed in as a function parameter), so
that tc_skip_sw() inside the helper looks at the bits userspace actually
set.

Two questions below about what becomes reachable once those flags are
correct.

> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index c297d7dbcf916..1374da97836eb 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -935,7 +935,7 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
>  
>  		u32_bind_filter(tp, new, base, tb);
>  
> -		err = u32_replace_hw_knode(tp, new, flags, extack);
> +		err = u32_replace_hw_knode(tp, new, userflags, extack);
>  		if (err) {
>  			u32_unbind_filter(tp, new, tb);
>  

[Severity: High]

Does this make the error path of the replace branch reachable from
userspace for the first time, and can it leave the old knode installed
while its hardware rule is gone?

Before the change, flags only carried TCA_ACT_FLAGS_* bits, so
tc_skip_sw(flags) in u32_replace_hw_knode() was false, tc_setup_cb_add()
ran with err_stop == false and could not return an error, and the
skip_sw && !IN_HW -EINVAL check in the helper was dead code.

With userflags, skip_sw is true for a skip_sw filter, tc_setup_cb_add()
propagates the first driver error, and u32_replace_hw_knode() takes:

net/sched/cls_u32.c:u32_replace_hw_knode() {
	err = tc_setup_cb_add(block, tp, TC_SETUP_CLSU32, &cls_u32, skip_sw,
			      &n->flags, &n->in_hw_count, true);
	if (err) {
		u32_remove_hw_knode(tp, n, NULL);
		return err;
	}
}

Here n is the replacement node, and u32_init_knode() copied the handle
from the old one:

	new->handle = n->handle;

so the TC_CLSU32_DELETE_KNODE emitted by u32_remove_hw_knode() names the
handle of the knode that is still linked in ht->ht[]. u32_change() then
only unbinds and frees new and returns the error, so the old knode stays
in the software list with TCA_CLS_FLAGS_SKIP_SW set, and u32_classify()
skips SKIP_SW knodes. Would that filter then match neither in software
nor in hardware, while userspace was told the command failed?

There also looks like accounting fallout on the same path.
u32_init_knode() copies the flags too:

	new->flags = n->flags;

so new->flags can carry TCA_CLS_FLAGS_IN_HW while new->in_hw_count is
still 0. The teardown then reaches
tc_setup_cb_destroy() -> tc_cls_offload_cnt_reset(), which decrements
purely on the inherited bit:

net/sched/cls_api.c:tc_cls_offload_cnt_reset() {
	spin_lock(&tp->lock);
	tcf_block_offload_dec(block, flags);
	*cnt = 0;
	spin_unlock(&tp->lock);
}

Can this decrement block->offloadcnt for a node that never incremented
it, and then have the old knode (whose flags still carry IN_HW)
decrement it a second time when it is eventually deleted, leaving
tcf_block_offload_in_use() permanently true and later binds of
non-offload-capable devices to the block failing with -EOPNOTSUPP?

For comparison, cls_flower builds fnew->flags only from the netlink
attributes rather than inheriting them from fold, so it does not have
the accounting half of this.

The later patches in this range only adjust ht_down refcounting, so this
error path is unchanged by them.

> @@ -1168,7 +1168,7 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
>  		struct tc_u_knode __rcu **ins;
>  		struct tc_u_knode *pins;
>  
> -		err = u32_replace_hw_knode(tp, n, flags, extack);
> +		err = u32_replace_hw_knode(tp, n, userflags, extack);
>  		if (err)
>  			goto errunbind;
>  

[Severity: High]

This isn't a bug introduced by this patch, but now that the real
TCA_CLS_FLAGS_* set reaches these call sites, the TCA_CLS_FLAGS_SKIP_HW
bit is visible here and still nothing acts on it. Should these calls be
gated on tc_skip_hw()?

Neither helper looks at it. u32_replace_hw_knode() and
u32_replace_hw_hnode() only derive:

	bool skip_sw = tc_skip_sw(flags);

and the core does not filter on the classifier's behalf either.
tc_setup_cb_add() only checks the block state before dispatching:

net/sched/cls_api.c:tc_setup_cb_add() {
	/* Make sure all netdevs sharing this block are offload-capable. */
	if (block->nooffloaddevcnt && err_stop) {
		ok_count = -EOPNOTSUPP;
		goto err_unlock;
	}

	ok_count = __tc_setup_cb_call(block, type, type_data, err_stop);
}

The peer classifiers gate the call themselves, for example cls_flower:

	if (!tc_skip_hw(fnew->flags))
		err = fl_hw_replace_filter(tp, fnew, rtnl_held, extack);

and cls_matchall:

	if (!tc_skip_hw(new->flags))
		err = mall_replace_hw_filter(tp, new, cookie, extack);

Does a "tc filter add ... u32 skip_hw ..." command therefore still get
pushed to TC_SETUP_CLSU32 drivers and pick up TCA_CLS_FLAGS_IN_HW plus
in_hw_count / block->offloadcnt increments, contradicting the documented
meaning of the flag in include/uapi/linux/pkt_cls.h?

The two consumers of the same flags field also disagree. On block
unbind, tcf_block_playback_offloads() -> u32_reoffload(add=false) does
honour the bit:

net/sched/cls_u32.c:u32_reoffload() {
			if (tc_skip_hw(n->flags))
				continue;
}

so a knode that was offloaded by the add path is skipped here, and its
IN_HW bit, in_hw_count and block->offloadcnt contribution are never
released. Can that leave tcf_block_offload_in_use() true forever and
reject later binds of non-offload-capable devices to that shared block
with -EOPNOTSUPP?

The same missing guard applies to the u32_replace_hw_hnode() call in the
TCA_U32_DIVISOR branch of u32_change(), which is likewise given
userflags with no skip_hw check.
-- 
This is an AI-generated review.

