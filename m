Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794759855;
	b=4CI6j5LPxXXgSjRKe4yuUO/ZIY2+uKxzexrhZIGGocHLCsFQ+nWBbDCujDDf+kbG1Cc8
	 uuLMqgGu4K85seeeWB+I8XWfL6P8WNZLz6s0mzPot1OfbGkgehDMy0LU1Qrj5zzlKClFp
	 OBnsD4YlLSoC3tDXyl5AWaxXu9VfQeKwE7o0Nl5M6aPXigGFpm9sgjr+65vEEwy1+xd9J
	 /9VO6qU3pXbf+gAoG2zJVOHzGh6vISyDVMbfwX/rM7nCYDQ3GOO/7eMKuFCsUUjA64NcX
	 3jU7lK4tYHAlbOB5U1KFsL8EIGasEXaAmfu7XWuwkKs5Mb4dwk/WDqCZf5sDbuRFPUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794759855;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZSdx5f19liyf4Ud8gvv6YQ5/soOY5YSVXqUrvett9F4=;
	b=mBBMTy+jVrlIREj0ULXGMeEXqbvOIl5V9dQ1Ot80aZ9nOLpOBwCC+vrc7SO7qUqNbu0h
	 2SXLg19sJHr9j6OQvLdbtqQgTRgczOjyU6tl1ATIj385MINlHccAe6aqKI7dM6Q2mvGY1
	 cG6y9ZsFn9PDoQ29Lj6jJpekPPxCx/T3dEzPKcFybesOWXKIbjr9BAC3aX+uqJcGKvrJA
	 H/pC7ZlqmGb0EeOC99IogJbzHhS41cHAwFDI8qwafgij/+vtSEFth1THT5KUKvb7QtCKz
	 83/xVVt1Tz50hn6POrjbjxajFoU8N4xNLsc+PFzSCGU0Y83vI03y27TdKT7DM3qX84A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6ROHLvd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A086606A31A;
	Sun, 15 Nov 2026 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6ROHLvd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5698C1F000C4;
	Sun, 15 Nov 2026 16:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794759855;
	bh=ZSdx5f19liyf4Ud8gvv6YQ5/soOY5YSVXqUrvett9F4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=n6ROHLvdrpBs3K6OqWq45kAvQxnlqCn5AxnNnUX7BmbpbpPEr9oHqIqxd0KysehcP
	 DoWxfwETb5ur0TdXZzJY7cRsQaR6isB3nMdQLEQYVT/rVQjwB6sEuJdY7qSD4lApFE
	 TykGMqZEZ36Qbg/iiAvRy0gXUp4fEaRRnlRomcKxDRmM2Y9ac5zikUjKPudpTLwquH
	 cf79g6rddAbd5v5tPCovL93I8sulQX2DInqaLk02Frl11oHk19dYsPyozRqqlUv1Qp
	 4VQV72XaNDm7TFmNm4la5oD+5i70lN56nX4CBf7CqQXPo3SerLhVBXtUxmY8tbBgkg
	 ScK+iHll5Jsyw==
Subject:
 Re: [PATCH] net/ncsi: use kfree_rcu_mightsleep for RCU-protected list entries
From: netdev-bot+sashiko@kernel.org
To: tristmd@gmail.com
Cc: sam@mendozajonas.com, fercerpav@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 tristan@talencesecurity.com
Date: Sun, 15 Nov 2026 16:24:13 +0000
Message-ID: <179475985387.2199510.17235857253316810745@kernel.org>
In-Reply-To: <20261111160649.677910-1-tristmd@gmail.com>
References: <20261111160649.677910-1-tristmd@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 3 (2) · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix depends on a premise the code does not support, so the
  use-after-free it targets is still reachable.
- [High] ncsi_unregister_dev() removes every package and channel (now via
  kfree_rcu_mightsleep) before it calls disable_work_sync(&ndp->work) at…
- [High] ncsi_remove_channel() still frees nc->mac_filter.addrs and
  nc->vlan_filter.vids right away with kfree() (ncsi-manage.c:253-254).
- [Low] net/ncsi: invalid commit SHA and subject in Fixes trailer

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  ncsi_unregister_dev() never cancels the per-request timers in…
- [High] This problem wasn't introduced by this patch, but
  ftgmac100_remove() calls ncsi_unregister_dev(priv->ndev)…

--

net/ncsi: use kfree_rcu_mightsleep for RCU-protected list entries

This commit changes kfree() to kfree_rcu_mightsleep() in
ncsi_remove_channel(), ncsi_remove_package() and ncsi_unregister_dev().
The channel, package and device structures are then freed only after an
RCU grace period, once list_del_rcu() has removed them from their lists.

> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index 1d63958c4429b..460fc024c1126 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c
> @@ -263,7 +263,7 @@ static void ncsi_remove_channel(struct ncsi_channel *nc)
>  	np->channel_num--;
>  	spin_unlock_irqrestore(&np->lock, flags);
>  
> -	kfree(nc);
> +	kfree_rcu_mightsleep(nc);

[Severity: Low]
The Fixes: tag doesn't look right. I can't find any commit that
2d283bdd5b20 resolves to. The subject "net/ncsi: Package and channel
management" belongs to a different commit, e6f44ed6d04d.

This commit introduced ncsi_remove_channel(), ncsi_remove_package()
and ncsi_unregister_dev(), along with the list_del_rcu() plus kfree()
sequences changed here:

  2d283bdd079c ("net/ncsi: Resource management")

The patch carries Cc: stable, so the stable tooling depends on this
trailer to pick the trees that need the backport. A SHA that doesn't
resolve, paired with the subject of another commit, will at best be
ignored and at worst point the backport at the wrong base.

Could you check which commit you meant and fix the trailer? Going by
the code being modified, it looks like it should be:

  Fixes: 2d283bdd079c ("net/ncsi: Resource management")

[Severity: High]
Does this grace period actually wait for any reader of these lists?

NCSI_FOR_EACH_DEV, NCSI_FOR_EACH_PACKAGE and NCSI_FOR_EACH_CHANNEL wrap
list_for_each_entry_rcu(). As far as I can tell, the only rcu_read_lock()
in net/ncsi/ is in set_one_vid(), and it covers ndp->vlan_vids. That is
why the VLAN fix mentioned in the commit message worked.

The readers of the package, channel and device lists run in process
context without an RCU read-side section. These include ncsi_find_dev(),
the genetlink handlers (ncsi_pkg_info_nl(), ncsi_pkg_info_all_nl(),
ncsi_set_interface_nl(), ncsi_clear_interface_nl(),
ncsi_set_channel_mask_nl()) and ndp->work helpers such as
ncsi_choose_active_channel() and ncsi_reset_dev().

For example, ndp_from_ifindex() returns ndp without holding a reference:

net/ncsi/ncsi-netlink.c:ndp_from_ifindex() {
    ...
	nd = ncsi_find_dev(dev);
	ndp = nd ? TO_NCSI_DEV_PRIV(nd) : NULL;

	dev_put(dev);
	return ndp;
}

ncsi_pkg_info_nl() then sleeps before it walks ndp->packages:

	skb = genlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
	...
	rc = ncsi_write_package_info(skb, ndp, package_id);

NCSI_CMD_PKG_INFO does not need CAP_NET_ADMIN. ftgmac100_remove() calls
ncsi_unregister_dev() before unregister_netdev(), so dev_get_by_index()
and ncsi_find_dev() still succeed while packages and channels are being
removed.

The readers that do run under RCU are the packet_type RX handlers
(ncsi_rcv_rsp() and the AEN path). ncsi_unregister_dev() already drains
them with dev_remove_pack()->synchronize_net() before anything is freed,
and ncsi_remove_package() has no other caller.

So is the grace period only added where the RCU readers are already gone?
The concurrent accessors the commit message describes could then still
reach freed nc, np and ndp.

Since the patch carries Fixes: and Cc: stable, would a fix need
rcu_read_lock() on the reader side plus references for pointers used
after it? Another option would be a teardown that quiesces the netlink
and work users before freeing.

[Severity: High]
Should the channel's sub-allocations be deferred as well? Earlier in
ncsi_remove_channel(), while nc is still linked on np->channels, the
filter buffers are freed right away and the pointers are kept:

	spin_lock_irqsave(&nc->lock, flags);

	/* Release filters */
	kfree(nc->mac_filter.addrs);
	kfree(nc->vlan_filter.vids);

list_del_rcu(&nc->node) only runs after ncsi_stop_channel_monitor().
ncf->vids, ncf->n_vids and ncf->bitmap are never cleared.

Any reader that finds the channel can still follow these pointers, even
one holding rcu_read_lock(). NCSI_CMD_PKG_INFO is one such reader, and it
has .flags = 0 in ncsi_ops:

ncsi_pkg_info_nl()
  ncsi_write_package_info()
    ncsi_write_channel_info()

	while ((i = find_next_bit((void *)&ncf->bitmap, ncf->n_vids,
				  i + 1)) < ncf->n_vids) {
		if (ncf->vids[i])
			nla_put_u16(skb, NCSI_CHANNEL_ATTR_VLAN_ID,
				    ncf->vids[i]);
	}

Can this copy freed slab contents to an unprivileged netlink caller
during driver unbind?

set_one_vid() also reads ncf->vids under nc->lock. That lock gives no
protection once the remove path has dropped it.

>  }
>  
>  struct ncsi_package *ncsi_find_package(struct ncsi_dev_priv *ndp,

[ ... ]

> @@ -1969,6 +1969,6 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
>  
>  	disable_work_sync(&ndp->work);

[Severity: High]
Is ndp->work disabled too late? The removal loop in ncsi_unregister_dev()
runs before it:

	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
		ncsi_remove_package(np);
	...
	disable_work_sync(&ndp->work);

ncsi_dev_work() and the channel monitor timer reach channels through raw
pointers and ndp->channel_queue (nc->link), not inside RCU read-side
sections. The deferred free does not wait for them.

While the loop runs, ncsi_configure_channel() can still do this:

	ndp->hot_channel = hot_nc;
	...
	ncsi_start_channel_monitor(nc);

That re-arms nc->monitor.timer after ncsi_remove_channel() has stopped
it, so could ncsi_channel_monitor() later run on freed nc, np or ndp?

ncsi_process_next_channel() can also take a channel off
ndp->channel_queue and cache it:

	ndp->active_channel = nc;
	ndp->active_package = nc->package;

ncsi_remove_channel() only calls list_del_rcu(&nc->node). It does not
unlink nc->link from channel_queue. It also does not clear
ndp->active_channel, ndp->hot_channel or np->preferred_channel, so a
freed channel can stay reachable.

ncsi_stop_channel_monitor() also returns early, without
timer_delete_sync(), when monitor.enabled is already false:

	if (!nc->monitor.enabled) {
		spin_unlock_irqrestore(&nc->lock, flags);
		return;
	}

ncsi_channel_monitor() clears that flag itself on its timeout branch. It
then calls list_add_tail_rcu(&nc->link, &ndp->channel_queue) and
ncsi_process_next_channel().

Can a concurrent ncsi_remove_channel() skip waiting for that callback and
leave a dangling channel_queue entry?

Would it work better to quiesce the work and monitor timers, and unlink
nc->link, before removing the packages and channels?

>  
> -	kfree(ndp);
> +	kfree_rcu_mightsleep(ndp);

[Severity: High]
This isn't a bug introduced by this patch, but are the per-request timers
in ndp->requests[] ever shut down before ndp is freed?

ncsi_xmit_cmd() arms each request:

	nr->enabled = true;
	mod_timer(&nr->timer, jiffies + 1 * HZ);

Normally ncsi_rcv_rsp()->ncsi_free_request() cancels this timer. After
dev_remove_pack(), no response can arrive. A request still in flight at
unregister time keeps its timer pending, and its nr->cmd skb is never
released. Examples are a GLS sent by ncsi_channel_monitor() or an
NCSI_CMD_SEND_CMD request.

The kfree_rcu_mightsleep() grace period is unrelated to this 1 second
timer. When the timer fires, ncsi_request_timeout() takes ndp->lock and
may walk the freed package list through
ncsi_find_package_and_channel(). It then calls ncsi_free_request(), which
does schedule_work(&ndp->work) and consume_skb().

Can this leave a queued timer_list inside freed ndp memory? Nothing in
ncsi_unregister_dev() walks requests[] to call timer_shutdown_sync() or
ncsi_free_request().

[Severity: High]
This is also a pre-existing issue, but does ftgmac100 still use the NCSI
device after this free?

drivers/net/ethernet/faraday/ftgmac100.c:ftgmac100_remove() {
    ...
	if (priv->ndev)
		ncsi_unregister_dev(priv->ndev);
	unregister_netdev(netdev);
    ...
}

priv->ndev and priv->use_ncsi are not cleared. If the interface is up,
unregister_netdev() closes it and ftgmac100_stop() calls:

	if (priv->use_ncsi)
		ncsi_stop_dev(priv->ndev);

ncsi_stop_dev() walks NCSI_FOR_EACH_PACKAGE(ndp, np). It then calls
ncsi_report_link(ndp, true), which calls nd->handler(nd). None of this
is inside an RCU read-side section.

Before this patch, this was an immediate use-after-free. With
kfree_rcu_mightsleep(), the grace period can still expire before the
device is closed, because unregister_netdev() takes rtnl and can block.

Doesn't this only change the timing window instead of fixing the bug?

>  }
>  EXPORT_SYMBOL_GPL(ncsi_unregister_dev);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111160649.677910-1-tristmd%40gmail.com
