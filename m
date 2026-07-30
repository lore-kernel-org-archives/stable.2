Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A2C31E83B;
	Thu, 30 Jul 2026 00:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785371947; cv=none; b=BYp46wE8lsOFDVVwrMTc4CPXxjteuRyYFtLMLsTYX33qr7pNz+204SwH1aV0qX7/q3DJ03rhi721mznqZAm/0mvzB1x/xu9naarhnMrWNL7isUy4pc3k5LlALhG3XJ3r/d+AgLgIHyMh9xuY8krJQR89lsxR+DSK92rcluqhNOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785371947; c=relaxed/simple;
	bh=OWmCiBQ34dcbL7NTuo2KtMNbdMQcDk61hb0lZ/WuJYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdLgzrckmt8A+MiUbzT9doEb8UjT00QEzH9KWxhpCKfK9glYEZZPy11SAVgqiB7G6FqwFtieTdHx/9Z2Z5cBOQFCWZJZLvwLg02xt5Y+/E6z8I3HdQaUiTDMFLkreYc1kvp8eJqS2PSDeaBOOvT5aYJebxnbdyGIRg7widQA1pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJ3MQaxC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJ3MQaxC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C961F000E9;
	Thu, 30 Jul 2026 00:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785371945;
	bh=+H7o3F0O092mHDWa2mJNdqzLzql2ppPYRAaf0MVA5OQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MJ3MQaxCq5rjoCgUU5I2rS6N6yyTiAMwft83tN1084IHkmudRdkJTXmRVU0ljMggA
	 k3AldzTQpyl0T5B8KKCRR85dnsc6JBjWGMSUrX7VVfjY1XwWUjh2g5KRkvKDoM69j5
	 ntLsL6zFVRellboMfS92RyYfUcDOTk7/rV0KdJ1WXJ2Vq19/unNMR2sdmBTRwClPwi
	 PoDd4GmHnl0Htxe/KIij5gsg1wFGexpGthZCSRs9TTz7jA1jfeimuQH/Lv86i3jGjK
	 zZrZeeekwmBGkPg33zmPFq6r8qvpwxbF0AY2USPLdBKSP3KrYQyuJ/bSjIcAJbNEUQ
	 4xMWS/mI3lEtQ==
From: Jakub Kicinski <kuba@kernel.org>
To: zhaoyz24@mails.tsinghua.edu.cn
Cc: Jakub Kicinski <kuba@kernel.org>,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yangyx22@mails.tsinghua.edu.cn,
	wangao@seu.edu.cn,
	fengxw06@126.com,
	qli01@tsinghua.edu.cn,
	xuke@tsinghua.edu.cn,
	stable@vger.kernel.org
Subject: Re: [PATCH net] nexthop: account nexthop allocations to memcg
Date: Wed, 29 Jul 2026 17:39:02 -0700
Message-ID: <20260730003902.4166545-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728060112.30367-1-zhaoyz24@mails.tsinghua.edu.cn>
References: <20260728060112.30367-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
--- Patch [1]: [PATCH net] nexthop: account nexthop allocations to memcg ---
commit 1014ad1eb712722973916d53a1c5348624a80550
Author: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>

nexthop: account nexthop allocations to memcg

This adds GFP_KERNEL_ACCOUNT / __GFP_ACCOUNT to the nexthop creation path
allocations (struct nexthop, struct nh_info, group storage, resilient
bucket table, per-group stats) and to the transient resilient-table
notifier buffer in nh_notifier_res_table_info_init().  The stated goal is
to make memory.max constrain nexthop creation by a CAP_NET_ADMIN task in
a container.

A couple of questions below about the notifier-table hunk and about the
tags.

>  nexthop: account nexthop allocations to memcg
>
>  Fixes: ab84be7e54fc ("net: Initial nexthop code")
>  Fixes: f4676ea74b85 ("net: nexthop: Add nexthop group entry stats")
>  Cc: stable@vger.kernel.org

[Severity: Low]
Are the Fixes: tags and the stable Cc appropriate here?  Switching
allocations to GFP_KERNEL_ACCOUNT does not fix an incorrect result, it
changes the success/failure profile of an existing uAPI operation.

After a stable backport, RTM_NEWNEXTHOP can start returning -ENOMEM
inside a memory.max-constrained cgroup on kernels where it previously
succeeded, which looks like a functional change for routing daemons
running in containers.

The operation still requires CAP_NET_ADMIN in the netns owner's user
namespace, so no privilege boundary is being closed - only accounting
accuracy changes.  Would net-next without the Fixes:/Cc: stable tags be a
better target, with the transient notifier hunk split out?

>  The nexthop creation path allocates struct nexthop, struct nh_info,
>  group storage, resilient bucket tables, transient notifier tables and
>  per-group stats without memcg accounting.

[Severity: Low]
The changelog says "transient notifier tables" in the plural, but only
one of the five transient notifier allocations in net/ipv4/nexthop.c is
converted.  These remain on plain GFP_KERNEL:

  nh_notifier_single_info_init()
	info->nh = kzalloc_obj(*info->nh);

  nh_notifier_mpath_info_init()
	info->nh_grp = kzalloc_flex(*info->nh_grp, nh_entries, num_nh);

  nh_notifier_res_bucket_info_init()
	info->nh_res_bucket = kzalloc_obj(*info->nh_res_bucket);

  nh_notifier_grp_hw_stats_init()
	info->nh_grp_hw_stats = kzalloc_flex(*info->nh_grp_hw_stats, stats,
					     nhg->num_nh);

Since nh_notifier_grp_info_init() dispatches to
nh_notifier_mpath_info_init() for hash_threshold (MPATH) groups, a group
created through the exact path described in the changelog gets no
notifier-table accounting at all, and call_nexthop_res_table_notifiers()
also builds an unaccounted num_nh-sized mpath table during resilient
group replace.

Could the policy be made all-or-nothing here, and the changelog adjusted
to match what the code does?

> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> index 44fe75004cac..c8685c583579 100644
> --- a/net/ipv4/nexthop.c
> +++ b/net/ipv4/nexthop.c
> @@ -169,7 +169,7 @@ static int nh_notifier_res_table_info_init(struct nh_notifier_info *info,
>  	info->type = NH_NOTIFIER_INFO_TYPE_RES_TABLE;
>  	size = struct_size(info->nh_res_table, nhs, num_nh_buckets);
>  	info->nh_res_table = __vmalloc(size, GFP_KERNEL | __GFP_ZERO |
> -				       __GFP_NOWARN);
> +				       __GFP_NOWARN | __GFP_ACCOUNT);
>  	if (!info->nh_res_table)
>  		return -ENOMEM;

[Severity: Medium]
Should this particular allocation be accounted at all?  It is not on the
nexthop creation path the changelog describes.  The buffer only exists to
hand resilient-group state to notifier listeners and is released before
the notifier call returns:

net/ipv4/nexthop.c:nh_notifier_grp_info_fini() {
	if (nhg->hash_threshold)
		kfree(info->nh_grp);
	else if (nhg->resilient)
		vfree(info->nh_res_table);
}

So it cannot accumulate, and charging it does not add containment.  Two
side effects come with it though.

First, whose memcg gets charged?  The notifier paths run in the context
of whoever triggers the notification, not the creator of the nexthop:

  remove_nexthop() -> call_nexthop_notifiers(NEXTHOP_EVENT_DEL)
	(also reached via nh_netdev_event -> nexthop_flush_dev)
  replace_nexthop_single() err_notify -> call_nexthop_notifiers(REPLACE)
  remove_nh_grp_entry() -> call_nexthop_notifiers(REPLACE)
  register_nexthop_notifier() / __unregister_nexthop_notifier()
	-> nexthops_dump() -> nh_notifier_info_init() for every
	   existing nexthop

Can a cgroup end up charged here for nexthops belonging to other
cgroups, for example when a driver module registers a nexthop notifier
and the replay loop walks every resilient nexthop in the netns?

Second, does this make notifier delivery fail on demand?  __GFP_ACCOUNT
is honoured for vmalloc pages, so with a memcg at memory.max this
__vmalloc() can now fail while the system is globally healthy, and
__GFP_NOWARN keeps it quiet.  The failure happens before the chain is
called:

net/ipv4/nexthop.c:call_nexthop_notifiers() {
	err = nh_notifier_info_init(&info, nh);
	if (err) {
		NL_SET_ERR_MSG(extack, "Failed to initialize nexthop notifier info");
		return err;
	}

and the callers do not stop on that error:

net/ipv4/nexthop.c:remove_nexthop() {
	call_nexthop_notifiers(net, NEXTHOP_EVENT_DEL, nh, NULL);

	/* remove from the tree */
	rb_erase(&nh->rb_node, &net->nexthop.rb_root);

The return value is discarded and the nexthop is erased and freed
anyway.  replace_nexthop_single()'s err_notify path also discards it,
remove_nh_grp_entry() only pr_err()s, and __unregister_nexthop_notifier()
ignores nexthops_dump()'s status while nexthops_dump() breaks out at the
first error, skipping DEL for all remaining nexthops.

The fail-silent error handling in those callers is pre-existing and not
introduced by this patch, but does this change turn it into something a
task can trigger at will from inside a constrained cgroup?  With an
offload listener such as mlxsw or netdevsim registered, that would leave
driver state for nexthops the kernel has already freed, and would let
register_nexthop_notifier() be made to fail for the whole netns.

Would keeping nh_notifier_res_table_info_init() on plain GFP_KERNEL and
accounting only the persistent objects (struct nexthop, struct nh_info,
struct nh_group, res_table, per-group stats) avoid all of this?

[ ... ]
-- 
pw-bot: cr
