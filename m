Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795503688;
	b=nJV1M0ZgM+bn8DAwAVnsV2VUJfrS6VlivF7fZP2IeRFM1Ph9SUEFc9J6LZEiXZctZzQx
	 xGMg1CfDrlA7nMK/CEHACroE+G6uHJ5GHIIs1NqxcGvEWCUcYRGBIBSox9ZFj5HDVgdG5
	 Mfn/DN3NtTy11p9tHFUs7YJM1sqad3LOgsgEpbYPVvxEr3i6o2JB2OZTU2hyBw/Pue4xj
	 t9vK5iac7DDOcYVKwIMjEdXo/APwxC6UotBeOw8E6ckyObNyTLNSq/9PHkmuRv9iQKGkf
	 QpV/+/xGpt9yWWaDXNrB767yi+zQL9Gc7l1kGTjROXncTBhY318KkMuZOUea++5lTeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795503688;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=E/+uN0FVh/Zngjaw7BuQLway1eJuoVshOm3+K4xRT+Q=;
	b=DMzM/CyuwuaZ30umTdUqDjwZGFYpfqSGv31xgWsCtX8CgFNfq5ktac4GqmZyPSYdk+LE
	 OYCbRzJYE3ZfIKespTMRsCBZZflJntw+bnm8oVmwuBT7XF1jJtSgyOTg2BZp0AUVkY9Q/
	 tPVuL8Z3TaStOSU6AwUhnctjpJSasRhiFI+eWj3HRyoj0hCtW4+73KdVUiS/OO0nqlpB4
	 US+MxpYjztO3y9cjnk8NR+DR/j1cAunNEe/1NYBWxUeeXA8W281J4IlUnnWbQCDOeQ3Y9
	 nHF+sLiUuOVKsTNgsw8UWZwudus36oEM69/v1ND1VSjOGJLYZ0jBKDUiP4hjVcHpCsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYT2e97e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF25606A31E;
	Tue, 24 Nov 2026 07:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYT2e97e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663EE1F000C0;
	Tue, 24 Nov 2026 07:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795503688;
	bh=E/+uN0FVh/Zngjaw7BuQLway1eJuoVshOm3+K4xRT+Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BYT2e97e1KNX30veFsfEvAzH+X6iZtaCu//FRhvw+HkZsrY7C2ED4SqQ/AOvM30Lz
	 1/HaGs5lCYUZhddDPiC6x2QpAt0ZivzaNE7YPI7lDOzgJUAT2/gjJDu2ppxOibjEyu
	 r2rT3jJ+FdNpVrys6cJLlEzxO6hrWwYBht7p/xnJIaHvwZQAADgoJna/FsD/JtCl0E
	 szzIWaejrluhjAJbAqpyN/Y+napP30AVfxY7j6Z0yl0IP7uIA/ZxOfcwGEWg9bCM95
	 lug86nGQgk71Y3VG/uWRnWNf1kg2LfQ1kXKtnGC4tANwCUjncU69+G3kZ41+cwsJwv
	 u+SOZm0VTQLBA==
Subject:
 Re: [PATCH net] ipv6: route: fix use-after-free in ip6_confirm_neigh()
From: netdev-bot+sashiko@kernel.org
To: n0ps1edzz@gmail.com
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, hangbin.liu@linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Tue, 24 Nov 2026 07:01:26 +0000
Message-ID: <179550368695.3135.12579094604954175182@kernel.org>
In-Reply-To: <20261123133000.1.n0ps1edzz@gmail.com>
References: <20261123133000.1.n0ps1edzz@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (2) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The RCU protection this patch adds to ip6_confirm_neigh() does
  not cover the uncached-route flush, which is one of the two teardown…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the IPv4
  sibling callback ipv4_confirm_neigh() (net/ipv4/route.c:441-457) has…
- [High] This problem wasn't introduced by this patch, but
  ip6_dst_neigh_lookup(), the IPv6 dst_ops->neigh_lookup callback in the…

--

ipv6: route: fix use-after-free in ip6_confirm_neigh()

This commit takes rcu_read_lock() in ip6_confirm_neigh(), loads the device
with dst_dev_rcu() and holds the section through the dev->flags test and
__ipv6_confirm_neigh(). It is meant to stop a use-after-free when route
teardown swaps dst->dev to blackhole_netdev and the old net_device is freed.
That race is reached from rawv6_sendmsg() and udpv6_sendmsg() with
MSG_CONFIRM|MSG_PROBE.

> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 1b2dcc066e198..6bdd4423ce784 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -257,16 +257,21 @@ static struct neighbour *ip6_dst_neigh_lookup(const struct dst_entry *dst,
>  static void ip6_confirm_neigh(const struct dst_entry *dst, const void *daddr)
>  {
>  	const struct rt6_info *rt = dst_rt6_info(dst);
> -	struct net_device *dev = dst_dev(dst);
> +	struct net_device *dev;
> +
> +	rcu_read_lock();
> +	dev = dst_dev_rcu(dst);

[Severity: High]
Does this RCU section cover the uncached-route flush that the commit
message names as one of the two teardown paths?

Since commit f12d2907992db7 ("ipv6: Batch rt6_uncached_list_flush_dev() in
netdev_run_todo()."), rt6_uncached_list_flush_dev(dev) returns early when
dev->dismantle is set. During unregister, the pointer swap now happens
from netdev_run_todo(), after that function's only rcu_barrier():

net/core/dev.c:netdev_run_todo() {
    ...
	if (!list_empty(&list))
		rcu_barrier();
    ...
	if (!list_empty(&list)) {
		rt_flush_dev(NULL);
		rt6_uncached_list_flush_dev(NULL);
	}

	cnt = 0;
	while (!list_empty(&list)) {
		...
		dev = netdev_wait_allrefs_any(&list);
		...
		kobject_put(&dev->dev.kobj);
    ...
}

rt6_uncached_list_flush_dev(NULL) does:

	rcu_assign_pointer(rt->dst.dev_rcu, blackhole_netdev);
	netdev_ref_replace(rt_dev, blackhole_netdev,
			   &rt->dst.dev_tracker,
			   GFP_ATOMIC);

netdev_wait_allrefs_any() returns as soon as netdev_refcnt_read(dev) == 1.
kobject_put() then reaches netdev_release(), which frees the device right
away:

	/* no need to wait for rcu grace period:
	 * device is dead and about to be freed.
	 */
	kfree(rcu_access_pointer(dev->ifalias));
	kvfree(dev);

free_netdev() only reaches synchronize_net() through netdev_napi_exit()
when the device has NAPI instances. Dummy devices have none.

As far as I can tell, nothing between the swap and the free waits for
current RCU readers. Can a task that loaded the old device here with
dst_dev_rcu() just before the swap still read dev->flags, or dev_net(dev)
in __ipv6_neigh_lookup_noref(), after the device has been freed?

User space can get such a dst. rawv6_sendmsg() sets FLOWI_FLAG_KNOWN_NH for
hdrincl sockets, and ip6_pol_route() then puts the route on
rt6_uncached_list. MSG_CONFIRM|MSG_PROBE then reaches dst_confirm_neigh().
This is the same rawv6_sendmsg() path as in the KASAN report.

The dst_dev_put() path looks covered, because the NETDEV_UNREGISTER
notifiers are followed by synchronize_net() in
unregister_netdevice_many_notify().

Would netdev_run_todo() need a synchronize_net() or synchronize_rcu() after
the rt_flush_dev(NULL)/rt6_uncached_list_flush_dev(NULL) batch, before the
device can be freed, to close the uncached-flush case?

>  
>  	daddr = choose_neigh_daddr(rt6_nexthop(rt, &in6addr_any), NULL, daddr);
>  	if (!daddr)
> -		return;
> +		goto out;
>  	if (dev->flags & (IFF_NOARP | IFF_LOOPBACK))
> -		return;
> +		goto out;
>  	if (ipv6_addr_is_multicast((const struct in6_addr *)daddr))
> -		return;
> +		goto out;
>  	__ipv6_confirm_neigh(dev, daddr);
> +out:
> +	rcu_read_unlock();
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does the IPv4 callback
ipv4_confirm_neigh() in net/ipv4/route.c have the same use-after-free?

net/ipv4/route.c:ipv4_confirm_neigh() {
	const struct rtable *rt = container_of(dst, struct rtable, dst);
	struct net_device *dev = dst_dev(dst);
	...
	} else if (IS_ENABLED(CONFIG_IPV6) && rt->rt_gw_family == AF_INET6) {
		return __ipv6_confirm_neigh(dev, &rt->rt_gw6);
	...
	__ipv4_confirm_neigh(dev, *(__force u32 *)pkey);
}

The device is loaded with a plain dst_dev() outside RCU.
__ipv4_confirm_neigh() and __ipv6_confirm_neigh() only take
rcu_read_lock() after that load. They then dereference the pointer:
dev_net(dev) and dev->flags in __ipv4_neigh_lookup_noref(), or
dev_net(dev) in __ipv6_neigh_lookup_noref().

IPv4 teardown drops the dst's device reference in the same way.
rt_flush_dev() does rcu_assign_pointer(rt->dst.dev_rcu, blackhole_netdev)
and then netdev_ref_replace(). During unregister this runs from
netdev_run_todo() through rt_flush_dev(NULL).

udp_sendmsg(), raw_sendmsg() and ping_v4_sendmsg() all reach
dst_confirm_neigh() with MSG_CONFIRM|MSG_PROBE. None of them holds RCU or a
device reference, and the UDP path needs no privilege.

The neighbouring ipv4_dst_neigh_lookup() already uses rcu_read_lock() with
dst_dev_rcu(). Should ipv4_confirm_neigh() be converted the same way? It
would also depend on the missing grace period in netdev_run_todo()
described above.

[Severity: High]
This is a pre-existing issue, but ip6_dst_neigh_lookup(), just above this
hunk, still uses the unpinned load that this patch removes from
ip6_confirm_neigh():

net/ipv6/route.c:ip6_dst_neigh_lookup() {
	const struct rt6_info *rt = dst_rt6_info(dst);

	return __ip6_dst_neigh_lookup(rt6_nexthop(rt, &in6addr_any),
				      dst_dev(dst), skb, daddr);
}

__ip6_dst_neigh_lookup() calls __ipv6_neigh_lookup(dev, daddr), which only
takes rcu_read_lock() after the pointer was loaded. On a cache miss it
calls ipv6_neigh_create(dev, daddr), which leads to ___neigh_create():

net/core/neighbour.c:___neigh_create() {
    ...
	n->dev = dev;
	netdev_hold(dev, &n->dev_tracker, GFP_ATOMIC);
    ...
}

After that it calls dev->netdev_ops->ndo_neigh_construct.

Suppose dst_dev_put() or the uncached-route flush moves the dst to
blackhole_netdev, and the old device is freed between the load and these
uses. Could netdev_hold() then increment a refcount in a freed net_device?

Some callers get here holding only a dst reference. For example,
irdma_addr_resolve_neigh_ipv6() in drivers/infiniband/hw/irdma/cm.c calls
dst_neigh_lookup() after ip6_route_output() without rcu_read_lock().

The IPv4 counterpart ipv4_dst_neigh_lookup() already holds rcu_read_lock()
around dst_dev_rcu() and the lookup/create.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123133000.1.n0ps1edzz%40gmail.com
