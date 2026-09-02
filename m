Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038FE4A5C22;
	Wed,  2 Sep 2026 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361440; cv=none; b=DMZ/sM+osuUOOnWip1Srour8WwLgeM6cQyPsByZu6PTLbc4JogU7Z9bwhiCNTIMY8j1TujTSncPuOgRXC20p9M4OOJl3lU49BTYEbiv06JyIEhRPSkgQ4e45U/OEGayB+H0vnxfRMSgZhF49C/FOAbS7Pad8zfI+lE1rXblLiJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361440; c=relaxed/simple;
	bh=Ws3Z5T4B5h/j/Ky5vE9ZeELQf9GKQhg1Hkap4tQrH1s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kNe0K7f+t/eO96Wi1Yyu/qwvDUJa4dGXqo7pjWxv9cCI/KyQL0X6eF1mV6IFwE8mgNDf+CDvjkNM0ZBQkikEGHLXElwUk/0fQ/7pu1I/cvcVhlqClxHrOx+dzJ2o6hQKn2DdYstorrgvxpiXdIga0wMpgHKywt7mVDM9fRqB1Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsKHoTIo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsKHoTIo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE1C1F000E9;
	Wed,  2 Sep 2026 15:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788361438;
	bh=K8+j06Fqip6iZWZjHjHOXpmDpD5M1F9ioEXxsNpOIsg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fsKHoTIoqikf/YmtYi1EdBCB2TyN+LZUJrxK2VeUiOQ/JVtk0shlqdIJJPXDvEO3K
	 QpS8cWpatzsRyZtwmeDPiaAFhJMrs0CIsEmQ9Kzw8n6wmOt/dLu73FnHvHiUzpJIXv
	 gov1KwXoXcPjNh0McqixU04OvRA5UjNbQD31pk4QTpglmcU031gLRHzJbPqJKVSKD6
	 w3Roiqhe7wINNwh76NT31jsQ9p/xC/wmF5nISvoUMyr3TiWd9gKYZTMVz0WWZjdYNj
	 eXUGDa18Mzyxj7XJNXkDB1L5QeiD1thcpLTnAYYuBfrpe4d89gQEfJ1YrX2/8Lt9iP
	 gzxlVdGJ3RtNQ==
Subject:
 Re: [net] vxlan: vnifilter: validate the VNI range in vni_filter_entry_policy
From: netdev-bot+sashiko@kernel.org
To: alishmery18@gmail.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 idosch@nvidia.com, razor@blackwall.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 02 Sep 2026 15:03:57 +0000
Message-ID: <178836143725.3394541.12588453860403453088@kernel.org>
In-Reply-To: <20260829030041.940594-1-alishmery18@gmail.com>
References: <20260829030041.940594-1-alishmery18@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 0 (2)

- [High] Incomplete fix: the added netlink range validation bounds only
  the individual VXLAN_VNIFILTER_ENTRY_START/END values (to…

Pre-existing issues:
- [Low] The newly added vni_filter_vni_range leaves .min unset (0), so
  the policy formally advertises VNI 0 as a valid…
- [Low] vxlan_vni_alloc() allocates the vxlan_vni_node with kzalloc_obj()
  (plain GFP_KERNEL, no __GFP_ACCOUNT) at…

--

vxlan: vnifilter: validate the VNI range in vni_filter_entry_policy

This adds netlink range validation to VXLAN_VNIFILTER_ENTRY_START and
VXLAN_VNIFILTER_ENTRY_END so each value is capped at VXLAN_N_VID - 1,
matching the constraint already used by the MDB code in the same driver.
The stated goal is to stop an unprivileged netlink request from driving an
unbounded allocation loop in vxlan_vni_add_del().

> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
> index dd94085e0886..9e86ac39cf9d 100644
> --- a/drivers/net/vxlan/vxlan_vnifilter.c
> +++ b/drivers/net/vxlan/vxlan_vnifilter.c
> @@ -459,9 +459,15 @@ static int vxlan_vnifilter_dump(struct sk_buff *skb, struct netlink_callback *cb
>  	return err;
>  }
>  
> +static const struct netlink_range_validation vni_filter_vni_range = {
> +	.max = VXLAN_N_VID - 1,
> +};

[Severity: High]
This bounds each endpoint but not the distance between them.  Does that
still leave the scenario described in the changelog reachable?

A single RTM_NEWTUNNEL with START=0 and END=0xFFFFFF passes the new
policy, and vxlan_process_vni_filter() forwards both values unchanged:

	if (vattrs[VXLAN_VNIFILTER_ENTRY_START]) {
		vni_start = nla_get_u32(vattrs[VXLAN_VNIFILTER_ENTRY_START]);
		vni_end = vni_start;
	}

	if (vattrs[VXLAN_VNIFILTER_ENTRY_END])
		vni_end = nla_get_u32(vattrs[VXLAN_VNIFILTER_ENTRY_END]);
	...
	err = vxlan_vni_add_del(vxlan, vni_start, vni_end, &group, cmd,
				extack);

which then runs 2^24 iterations in vxlan_vni_add_del():

	for (v = start_vni; v <= end_vni; v++) {
		switch (cmd) {
		case RTM_NEWTUNNEL:
			err = vxlan_vni_add(vxlan, vg, v, group, extack);

Each iteration reaches vxlan_vni_alloc(), which does one slab allocation
plus one per-CPU stats block:

	vninode = kzalloc_obj(*vninode);
	if (!vninode)
		return NULL;
	vninode->stats = netdev_alloc_pcpu_stats(struct vxlan_vni_stats_pcpu);

struct vxlan_vni_stats_pcpu is 64 bytes per CPU, so on a 4-CPU host that
is roughly 2^24 * (192 + 4 * 64), several gigabytes from one message.
There is still no __GFP_ACCOUNT on either allocation, and no
cond_resched() in the loop.

The RTM_NEWTUNNEL handler is also still registered with flags 0:

	{THIS_MODULE, PF_BRIDGE, RTM_NEWTUNNEL, vxlan_vnifilter_process, NULL, 0},

so the whole loop still executes under the host-global rtnl_lock, which is
the stall the changelog describes.  Nothing else caps growth either:
vg->num_vnis is only adjusted in __vxlan_vni_add_list() and
__vxlan_vni_del_list() and is never compared against a limit.

The one case this patch does remove is end_vni == U32_MAX, where v wraps
and the loop condition never becomes false.  Would it make sense to say
that explicitly in the changelog, and additionally bound the number of
VNIs created per request, add a reschedule point in the loop, or account
the memory, before claiming the OOM and rtnl stall are closed?

[Severity: Low]
This is a pre-existing inconsistency rather than something introduced
here, but the new range leaves .min at 0, so the policy now formally
advertises VNI 0 as a valid START/END value, while
vxlan_process_vni_filter() treats 0 as "attribute absent":

	if (!vni_start && !vni_end) {
		NL_SET_ERR_MSG_ATTR(extack, nlvnifilter,
				    "vni start nor end found in vni entry");
		return -EINVAL;
	}

A request carrying only START=0 passes the new validation and is then
rejected with an extack saying neither start nor end was found, while
START=0 with END=10 installs VNI 0 without complaint.  Is it worth
setting .min explicitly, or reworking the sentinel so the extack matches
the actual reason?

>  static const struct nla_policy vni_filter_entry_policy[VXLAN_VNIFILTER_ENTRY_MAX + 1] = {
> -	[VXLAN_VNIFILTER_ENTRY_START] = { .type = NLA_U32 },
> -	[VXLAN_VNIFILTER_ENTRY_END] = { .type = NLA_U32 },
> +	[VXLAN_VNIFILTER_ENTRY_START] = NLA_POLICY_FULL_RANGE(NLA_U32,
> +							      &vni_filter_vni_range),
> +	[VXLAN_VNIFILTER_ENTRY_END] = NLA_POLICY_FULL_RANGE(NLA_U32,
> +							    &vni_filter_vni_range),

[Severity: Low]
This isn't a bug introduced by this patch, but the changelog calls out the
missing memcg accounting as part of the problem, and vxlan_vni_alloc() is
unchanged:

	vninode = kzalloc_obj(*vninode);
	if (!vninode)
		return NULL;
	vninode->stats = netdev_alloc_pcpu_stats(struct vxlan_vni_stats_pcpu);

kzalloc_obj() uses plain GFP_KERNEL and netdev_alloc_pcpu_stats() ends up
at alloc_percpu_gfp(..., GFP_KERNEL), so neither carries __GFP_ACCOUNT and
neither is charged to the requesting task's cgroup.  A caller inside a
user plus net namespace can still ask for the full legitimate 24-bit range
and get one node plus one per-CPU block per VNI, scaled by nr_cpus,
outside its memcg limit.  Should the changelog stop listing the accounting
gap among the things being addressed, or should the allocations gain
__GFP_ACCOUNT as part of this change?

>  	[VXLAN_VNIFILTER_ENTRY_GROUP]	= NLA_POLICY_EXACT_LEN(sizeof_field(struct iphdr, daddr)),
>  	[VXLAN_VNIFILTER_ENTRY_GROUP6]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
>  };

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260829030041.940594-1-alishmery18%40gmail.com
