Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5677B31F9B4;
	Thu, 30 Jul 2026 00:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785371929; cv=none; b=YLh8d7A/NZmx6MiEacZ5pVP8COEIfkoaRBvXkxLIvy+gp5/tFwbAG4cw1EF71/03j/6zLs6EtZDvxoeHaIMU0SXTejuWpeMtP3ykocM4mHjfUE3yWdULZfU7LKDN9b/AMzF15ItvbvosFRv91aUUbjXJVkoeb8RYiLZ/EDtMjU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785371929; c=relaxed/simple;
	bh=gXldHQTkdDklhHvlVtE1VrA3/16585frIArf32rnBl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XduhyTjdVwnkRz+ckOMtQWp8Boq1AjlKDqguhNFKTkhPb0JpVYg/ELa6rX8LwdH7o2yPLqBlNpO2Ls+ZKygzTE4kT/OMeYIaazN7659evH28eP9bFu9khrZK49FOKi95ty4N+yA3EJkhwBextTTCedpyPn7ovzGoBlJDPGOAWHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRY3AgFu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRY3AgFu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746FF1F000E9;
	Thu, 30 Jul 2026 00:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785371927;
	bh=ZNTcxGXpnmUmvFAJvVveI6Jd6TkHR61LCnlfIMKYz/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gRY3AgFuhTQ/inksc++kXl5/KMNUsuyPSBCisiMMuYIZkrV8g5ycWGHtLuiVfBPGV
	 CcE+4Vk6Fe0Nf1CMCmeX62qoQNS+ZqZtIewOpunUHWniDcx/fAjNJtsF9Ca6eedt4b
	 w+u63V1USxNPxZONe+1h243UARf08MG+YwyUl5MqEWd6zjhENn3ehCDkKHAC/MCJKa
	 ZNLyOnhdKiCH/px+wowj22O1LyduoNiTtx6souZeeNIKGdsRTSWUx4ibn5S+CjQJKd
	 vUN8BhcMrkh1LkkvRSvirrEb7ugGRRqYk0zfBUp0FvYCaLtaEAVDbKf/QVj00gw/ur
	 17b7FOEq2LgIw==
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
Date: Wed, 29 Jul 2026 17:38:45 -0700
Message-ID: <20260730003845.4166255-1-kuba@kernel.org>
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
commit 186a5b6499e65039b5037906ec518baac2833b1d
Author: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>

    nexthop: account nexthop allocations to memcg
    
    The nexthop creation path allocates struct nexthop, struct nh_info,
    group storage, resilient bucket tables, transient notifier tables and
    per-group stats without memcg accounting. As a result, a task with
    CAP_NET_ADMIN can create nexthops and resilient groups whose kernel
    memory is not charged to the task's memory cgroup, so memory.max does
    not constrain this part of the workload.

> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> index 44fe75004cacb..c8685c5835794 100644
> --- a/net/ipv4/nexthop.c
> +++ b/net/ipv4/nexthop.c
[ ... ]
> @@ -2943,7 +2945,7 @@ static struct nexthop *nexthop_create(struct net *net, struct nh_config *cfg,
>  	if (!nh)
>  		return ERR_PTR(-ENOMEM);
>  
> -	nhi = kzalloc_obj(*nhi);
> +	nhi = kzalloc_obj(*nhi, GFP_KERNEL_ACCOUNT);

[Severity: High]
This is a pre-existing issue, but does this patch miss some per-CPU
allocations in the nexthop creation path?

When creating IPv4 and IPv6 nexthops, nh_create_ipv6() and fib_nh_init()
explicitly pass GFP_KERNEL without __GFP_ACCOUNT down to the initialization
functions:

net/ipv4/nexthop.c:nh_create_ipv6() {
    ...
    err = fib6_nh_init(net, fib6_nh, &fib6_cfg, GFP_KERNEL, extack);
    ...
}

This results in unaccounted per-CPU allocations:

net/ipv6/route.c:fib6_nh_init() {
    ...
    fib6_nh->rt6i_pcpu = alloc_percpu_gfp(struct rt6_info *, gfp_flags);
    ...
}

A similar missing accounting happens for IPv4 in fib_nh_common_init():

net/ipv4/fib_semantics.c:fib_nh_common_init() {
    ...
    nhc->nhc_pcpu_rth_output = alloc_percpu_gfp(struct rtable __rcu *,
                                                gfp_flags);
    ...
}

Could an unprivileged user with CAP_NET_ADMIN still bypass memcg limits by
exhausting memory through these per-CPU allocations?


[Severity: High]
This is a pre-existing issue, but do we also need to account for Lightweight
Tunnel (LWT) state allocations?

During nexthop creation with encapsulation attributes, fib_nh_common_init()
triggers LWT state allocation:

net/ipv4/fib_semantics.c:fib_nh_common_init() {
    ...
    err = lwtunnel_build_state(net, encap_type, encap,
                               nhc->nhc_family, cfg, &lwtstate,
                               extack);
    ...
}

The allocation unconditionally uses GFP_ATOMIC without __GFP_ACCOUNT:

net/core/lwtunnel.c:lwtunnel_state_alloc() {
    ...
    lws = kzalloc(sizeof(*lws) + encap_len, GFP_ATOMIC);
    ...
}

Could a task in a container bypass memory.max limits by creating many nexthops
with encapsulation attributes?

>  	if (!nhi) {
>  		kfree(nh);
>  		return ERR_PTR(-ENOMEM);
