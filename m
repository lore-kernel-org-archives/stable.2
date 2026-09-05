Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904043BB40;
	Sat,  5 Sep 2026 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788637013; cv=none; b=oyIsUg8j2+722Q85yIyB+DAUxJG6qAqqXuYkxD2/zwFDKrIaXEFZsBB9AQE7oiozHHrpMUCZeDOPNjfjc5+unOjCXzofaufYPgw7v1LV6sYyDbQbMGc5MnNyVw0ratifYM2G7/0lv6wCp31Nt2xBlc0GYJYOl+3GV4G0oHHkheE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788637013; c=relaxed/simple;
	bh=M2yKTvP7ENyCDZAyaDXgbDjJruQtDBz86p9V5ubdLmc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G8fRMMW5ezRuFURIueWVeO/FL6oyhzAZq98oaBQSJzSAitJhKMUN7Lz8AIARAFd5bKZF7c6YBKhBmcBKX4WaKBiDEKXFe/yaj9wFaKz/EtOYUL4uykRtXKp3YtUmefS2ElGIwDjNqWFOcx3HAxwu02HmMAdUmfodIXVFxM+luUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5e8aqj3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5e8aqj3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89BF1F00A3A;
	Sat,  5 Sep 2026 19:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788637012;
	bh=XpAbj95BR/+hBgihJ49UPIvDv6ikVG1x1iAZJsGRtO4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=g5e8aqj3jzdc7EBch7vcpHIW0JyQlY9yeOmMs1VAI0qrocBLwEaZ6SEn0C6O0Z9Ai
	 Uq8gcfNJdub4iU1fhUX2UwEgVKExw5GYO1JN0iCudp3BGz2jnS4fMIeXy8tHtbynSx
	 nmt5lVFcLK85F2JsbrPMVeaI2Pv5icsxUVeuIW1/mqqNsDWkj4Xfg7YXiAeLJMn7s2
	 eCIqJfur+g81l1syfHYumphixjX/mEzt0u1eXE9uFTAD4Wm/jvV9Xn5B2l8Yue39AJ
	 ANU1NWr21nZU1vvoIUpV8NRgsdUZl8y1dtlweTKRVuUOBtJ8P1250KPJ5FPVy29vbs
	 t4LHu5EBis8jQ==
Subject: Re: [PATCH net v2] vxlan: vnifilter: validate the VNI range in
 vni_filter_entry_policy
From: netdev-bot+sashiko@kernel.org
To: alishmery18@gmail.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 idosch@nvidia.com, razor@blackwall.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sat, 05 Sep 2026 19:36:51 +0000
Message-ID: <178863701124.219967.14305621519981687842@kernel.org>
In-Reply-To: <20260902154609.594009-1-alishmery18@gmail.com>
References: <20260902154609.594009-1-alishmery18@gmail.com>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] Incomplete fix relative to the impact its own changelog
  describes: after the range clamp to VXLAN_N_VID-1, a single…

--

vxlan: vnifilter: validate the VNI range in vni_filter_entry_policy

This adds an NLA_POLICY_FULL_RANGE constraint with .max = VXLAN_N_VID - 1
to VXLAN_VNIFILTER_ENTRY_START and VXLAN_VNIFILTER_ENTRY_END, matching
what vxlan_mdb.c already does for its VNI attributes.  The commit carries
Fixes: f9c4bb0b245c and Cc: stable@vger.kernel.org.

No Link: tags in the commit header; the v1 posting is referenced in the
patch notes as
https://lore.kernel.org/netdev/20260829030041.940594-1-alishmery18@gmail.com/

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
> +
>  static const struct nla_policy vni_filter_entry_policy[VXLAN_VNIFILTER_ENTRY_MAX + 1] = {
> -	[VXLAN_VNIFILTER_ENTRY_START] = { .type = NLA_U32 },
> -	[VXLAN_VNIFILTER_ENTRY_END] = { .type = NLA_U32 },
> +	[VXLAN_VNIFILTER_ENTRY_START] = NLA_POLICY_FULL_RANGE(NLA_U32,
> +							      &vni_filter_vni_range),
> +	[VXLAN_VNIFILTER_ENTRY_END] = NLA_POLICY_FULL_RANGE(NLA_U32,
> +							    &vni_filter_vni_range),

[Severity: High]
Does this clamp close the problem the changelog describes, or only the
U32_MAX endpoint?

With the new .max, a single PF_BRIDGE RTM_NEWTUNNEL message carrying only
VXLAN_VNIFILTER_ENTRY_END = 0xFFFFFF still passes validation, because
vni_start defaults to 0 in vxlan_process_vni_filter():

	u32 vni_start = 0, vni_end = 0;
	...
	if (vattrs[VXLAN_VNIFILTER_ENTRY_START]) {
		vni_start = nla_get_u32(vattrs[VXLAN_VNIFILTER_ENTRY_START]);
		vni_end = vni_start;
	}

	if (vattrs[VXLAN_VNIFILTER_ENTRY_END])
		vni_end = nla_get_u32(vattrs[VXLAN_VNIFILTER_ENTRY_END]);

	if (!vni_start && !vni_end) {
		NL_SET_ERR_MSG_ATTR(extack, nlvnifilter,
				    "vni start nor end found in vni entry");
		return -EINVAL;
	}

vni_end is non-zero so the guard does not fire, and vxlan_vni_add_del() is
entered with the full 0..0xFFFFFF span.

Each of those 2^24 iterations goes through vxlan_vni_add() ->
vxlan_vni_alloc(), which allocates a node plus a full per-CPU stats block:

	vninode = kzalloc_obj(*vninode);
	if (!vninode)
		return NULL;
	vninode->stats = netdev_alloc_pcpu_stats(struct vxlan_vni_stats_pcpu);

followed by an rhashtable insert, a sorted list insert and a
vxlan_vnifilter_notify().  Neither allocation uses __GFP_ACCOUNT, so the
memory is charged globally rather than to the requesting cgroup.

There is also no cond_resched() in vxlan_vni_add_del() (grep finds none in
the file), no per-request work cap and no ceiling on vg->num_vnis, and
vxlan_vnifilter_rtnl_msg_handlers registers the handler without
RTNL_FLAG_DOIT_UNLOCKED, so the whole span runs under the global rtnl_lock.

Given that, is the Fixes: plus Cc: stable framing accurate?  The changelog
states:

	It runs under rtnl_lock, which is global rather than per-netns, so
	every network configuration operation on the host blocks for as long
	as it runs, in every namespace.

	The interface is reachable without privilege: creating the device and
	adding VNIs only requires CAP_NET_ADMIN in the network namespace's
	user namespace

and then:

	A request spanning the full in-range space, START=0 END=0xFFFFFF,
	still exhausts memory on that guest both before and after, as
	described above.

Would a backporter reading the first part conclude that the rtnl_lock
starvation and unprivileged memory exhaustion are closed, when the second
part says they are not?

Separately, is this description of the U32_MAX case right?

	With end_vni == U32_MAX the loop cannot terminate through its own
	condition: v reaches U32_MAX, wraps to 0, and 0 <= U32_MAX is true
	again, so the request never returns.

The test result in the same changelog says that request "drives a global OOM
with the allocating task in vxlan_vnifilter_process()".  Doesn't the loop
actually leave early once vxlan_vni_alloc() fails?

	err = vxlan_vni_add(vxlan, vg, v, group, extack);
	...
	if (err)
		goto out;

so the observed exit is -ENOMEM rather than a loop that never returns.

One more question on the partial-failure path: when vxlan_vni_add() fails
part way through a range, nothing unwinds the VNIs already added, and they
stay in vg->vni_hash and vg->vni_list until vxlan_vnigroup_uninit().  Is a
partially applied range the intended behaviour here?

Would it make sense to bound the per-request work in the same change, for
example capping the number of VNIs one message may span, adding a reschedule
point to the vxlan_vni_add_del() loop, and using __GFP_ACCOUNT for the node
and stats allocations, so that the tags match what the patch removes?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902154609.594009-1-alishmery18%40gmail.com
