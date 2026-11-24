Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795564612;
	b=YYPBPceHPcbkwObctCuq03Cvz+YZLICi0Da7Wt43A4YS8g6m9Yrvy4OVRKoSa2AuzqqL
	 2FrIt5byWqAHG32hDfCghaQOHQSoibFRhctZV88L+0+O7UuseeMohMGcsVy7f1RDeiSym
	 trlSCj3e03s1F5l5QFjWz7zJSqRmaOCi/zYxlJG0TEBZ2RmiGhanE1gR+NpBAMZ8t7Y3O
	 +MLfjlXcOdtQH2XPYKZAlMDjD/Shiup6yg9vnGBf3rNKhCZgeCHFz0I+foBMBltxBekPw
	 Sl2qvD5ei6hWoy1fiBCxbgStx3Q7V2IrBLvOp6IW4yeDazXrwNQas84Bv9ilED8nPcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795564612;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oHOP4f+e+Ls+4yz59pWvC5JEieX9HCnKABpFUDWkvQQ=;
	b=h8PvPv/kVuLnjqyqECGzZEPbMI5WtRvP4l+zPLcGgqcQDuny0cmOOQl/kgzVoQ5iTk9p
	 j5VFe9adPL+cgj29oUq+C2C8LiMY7zAUdflIYcBOHjpD+7Ltuaw4685l2q6GBv0LPHdUz
	 j+PORx7CfsYOfLNyVxSmLbxTyKjOi3ewvMBjln0Vqd02AIEN8NXBP5ANlrXaC5OPyNQB7
	 sGrOAKcl0r2CYnnD07ZFRtVjUJ/MKp69B9Je3CyND8ABaoZVL6sjOY5EIaXF3mvcDn39i
	 kteN0MbzQkBehcbwIYuz/3hRm7N4lngJvAF3bgf2OBsfLx7GG7e7sN/SdsWalfqBOYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0ylex+P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B13E606A680;
	Tue, 24 Nov 2026 23:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0ylex+P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E79B1F000C6;
	Tue, 24 Nov 2026 23:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795564611;
	bh=oHOP4f+e+Ls+4yz59pWvC5JEieX9HCnKABpFUDWkvQQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=S0ylex+PqbWAJ6R2lTB2vZ7M9jxqh2HqcexJ/05+NCXtFg77fcSSbA1qVMZ16lNEx
	 KGDLOMEGcHBmfSaIIq/w7u7t/4cBZl/trf10m3OpyxRYKuNUnVx0LbX6d4AQRZXXdQ
	 Bb6t0PK0gTh6pFywxynqSffFhI5lrLxQhl4LuCON8lo3C8sjDQI2BBWckl3pxuh97b
	 x7cmIy+6ukegHkEp3N/8r0AtWKAJLrHxnZ36m8mD3bfpqSD9F5JYj0rDV6q3bfi5s4
	 ZubltWDUerww3qKiMBwcRF5h1sQtHMpqcwMVAPxCxm5yZZ2OA9PzS824osexWCVhtk
	 JNTg0+3JCWB8g==
Subject: Re: [PATCH v2 net 2/2] net/ncsi: defer free of removed list entries
 to an RCU grace period
From: netdev-bot+sashiko@kernel.org
To: tristmd@gmail.com
Cc: sam@mendozajonas.com, fercerpav@gmail.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 tristan@talencesecurity.com
Date: Tue, 24 Nov 2026 23:56:50 +0000
Message-ID: <179556461079.3135.5271324345718401969@kernel.org>
In-Reply-To: <20261120235407.1911365-3-tristmd@gmail.com>
References: <20261120235407.1911365-3-tristmd@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 2 (2) · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [High] ncsi_remove_channel() unlinks only nc->node from np->channels
  before call_rcu(&nc->rcu, ncsi_channel_free_rcu) (ncsi-…

Pre-existing issues:
- [High] ncsi_unregister_dev() never cancels the per-request timeout
  timers in ndp->requests[] before it frees ndp with…
- [High] ncsi_remove_channel() relies on the flag-gated
  ncsi_stop_channel_monitor() to quiesce nc->monitor.timer before the…
- [Medium] This problem wasn't introduced by this patch, but
  ncsi_unregister_dev() frees ndp without walking and freeing…

--

net/ncsi: defer free of removed list entries to an RCU grace period

This patch changes the channel, package and ncsi_dev_priv frees in the
NCSI removal paths to RCU-deferred frees: call_rcu() for channels and
kfree_rcu_mightsleep() for packages and ndp. It also moves the channel
filter buffer frees into the RCU callback. In ncsi_unregister_dev() it
moves disable_work_sync() ahead of the package removal loop.

> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index ec7c0d8cf3d9f..d872351d40245 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c
> @@ -242,28 +242,33 @@ struct ncsi_channel *ncsi_add_channel(struct ncsi_package *np, unsigned char id)

[ ... ]

>  static void ncsi_remove_channel(struct ncsi_channel *nc)
>  {
>  	struct ncsi_package *np = nc->package;
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&nc->lock, flags);
> -
> -	/* Release filters */
> -	kfree(nc->mac_filter.addrs);
> -	kfree(nc->vlan_filter.vids);
> +	ncsi_stop_channel_monitor(nc);

[Severity: High]
This is a pre-existing issue, but can this conditional stop guarantee
that nc->monitor.timer is idle before the channel is passed to
call_rcu()?

ncsi_start_channel_monitor() arms the timer after it drops nc->lock:

	spin_lock_irqsave(&nc->lock, flags);
	WARN_ON_ONCE(nc->monitor.enabled);
	nc->monitor.enabled = true;
	nc->monitor.state = NCSI_CHANNEL_MONITOR_START;
	spin_unlock_irqrestore(&nc->lock, flags);

	mod_timer(&nc->monitor.timer, jiffies + HZ);

Suppose an AEN handler such as ncsi_aen_handler_cr() runs
ncsi_stop_channel_monitor() on another CPU inside that window:

CPU1 (config done, work)          CPU2 (AEN, softirq)
ncsi_start_channel_monitor()
  enabled = true
  spin_unlock_irqrestore()
                                  ncsi_stop_channel_monitor()
                                    enabled = false
                                    timer_delete_sync() /* not pending */
  mod_timer()

The timer is now pending while enabled is false. If ncsi_unregister_dev()
runs within the next second, the stop call here takes the early return:

	if (!nc->monitor.enabled) {
		spin_unlock_irqrestore(&nc->lock, flags);
		return;
	}

That skips timer_delete_sync(). ncsi_channel_free_rcu() then frees the
channel while its timer_list is still queued. When the timer fires,
ncsi_channel_monitor() takes nc->lock in freed memory.

Would an unconditional timer_shutdown_sync(&nc->monitor.timer) in
ncsi_remove_channel() be more robust than relying on the
monitor.enabled flag?

>  
> +	spin_lock_irqsave(&nc->lock, flags);
>  	nc->state = NCSI_CHANNEL_INACTIVE;
>  	spin_unlock_irqrestore(&nc->lock, flags);
> -	ncsi_stop_channel_monitor(nc);
>  
> -	/* Remove and free channel */
> +	/* Remove from list and defer free until after RCU grace period */
>  	spin_lock_irqsave(&np->lock, flags);
>  	list_del_rcu(&nc->node);
>  	np->channel_num--;
>  	spin_unlock_irqrestore(&np->lock, flags);
>  
> -	kfree(nc);
> +	call_rcu(&nc->rcu, ncsi_channel_free_rcu);

[Severity: High]
Can the channel still be reached through ndp->channel_queue when it is
passed to call_rcu() here?

Only nc->node is removed from np->channels. The channel can also be
linked through nc->link on ndp->channel_queue, and that list is walked
as an RCU list. For example, ncsi_channel_is_tx() does:

	list_for_each_entry_rcu(channel, &ndp->channel_queue, link) {

and ncsi_process_next_channel() pops entries with:

	nc = list_first_or_null_rcu(&ndp->channel_queue,
				    struct ncsi_channel, link);
	...
	list_del_init(&nc->link);

ncsi_reset_dev() is the only place that drains channel_queue.
ncsi_unregister_dev() does not drain it before ncsi_remove_package().
disable_work_sync() stops the work item but leaves the queued entries in
place.

A channel can still be queued at teardown, for example during a
multi-channel configuration round or after an AEN or VLAN kick. After
the grace period, these channel_queue users could then write through the
freed channel:

- the monitor timeout branch of a channel the removal loop has not
  reached yet. It does list_add_tail_rcu(&nc->link, &ndp->channel_queue)
  and then calls ncsi_process_next_channel().
- ncsi_vlan_rx_add_vid()->ncsi_kick_channels()->ncsi_process_next_channel()
  under RTNL.
- the ncsi_reset_dev() drain, reached from the netlink handlers.

ndp->active_channel, ndp->hot_channel and np->preferred_channel are also
left pointing at the freed channel.

Should nc->link be removed from channel_queue, and those pointers
cleared, before call_rcu()?

>  }
>  
>  struct ncsi_package *ncsi_find_package(struct ncsi_dev_priv *ndp,

[ ... ]

> @@ -1964,6 +1969,7 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
>  	unsigned long flags;
>  
>  	dev_remove_pack(&ndp->ptype);
> +	disable_work_sync(&ndp->work);
>  
>  	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
>  		ncsi_remove_package(np);
> @@ -1972,8 +1978,6 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
>  	list_del_rcu(&ndp->node);
>  	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
>  
> -	disable_work_sync(&ndp->work);
> -
> -	kfree(ndp);
> +	kfree_rcu_mightsleep(ndp);

[Severity: High]
Does the deferred free actually close the NCSI_CMD_PKG_INFO path named in
the commit message?

The grace period only protects readers that stay in a single RCU
read-side section from lookup to last use. ncsi_find_dev() leaves its
RCU section before it returns:

	rcu_read_lock();
	NCSI_FOR_EACH_DEV(ndp) {
		if (ndp->ndev.dev == dev) {
			nd = &ndp->ndev;
			break;
		}
	}
	rcu_read_unlock();

	return nd;

ndp_from_ifindex() then returns ndp without taking a reference. The
unprivileged path looks like this:

ncsi_pkg_info_nl()
  ndp_from_ifindex()
    ncsi_find_dev()                          /* RCU section ends */
  genlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL) /* may sleep */
  ncsi_write_package_info()
    if (id > ndp->package_num - 1)           /* no RCU held */
    rcu_read_lock();
    NCSI_FOR_EACH_PACKAGE(ndp, np)

ncsi_unregister_dev() holds neither genl_mutex nor RTNL. ndp also stays
on ncsi_dev_list until every package has been torn down.
ftgmac100_remove() calls ncsi_unregister_dev() before unregister_netdev():

	if (priv->ndev)
		ncsi_unregister_dev(priv->ndev);
	unregister_netdev(netdev);

As a result, ifindex lookups keep succeeding during teardown.

If the grace period for kfree_rcu_mightsleep(ndp) ends while
ncsi_pkg_info_nl() is sleeping in genlmsg_new(), wouldn't
ndp->package_num be read from freed memory?

The admin handlers ncsi_set_interface_nl(), ncsi_clear_interface_nl()
and ncsi_set_channel_mask_nl() look similar. They walk ndp->packages and
np->channels with NCSI_FOR_EACH_PACKAGE() and NCSI_FOR_EACH_CHANNEL().
Both are list_for_each_entry_rcu(), yet none of these handlers takes
rcu_read_lock(). They then do things like:

	spin_lock_irqsave(&package->lock, flags);
	...
	package->preferred_channel = channel;

and call ncsi_reset_dev(), which walks the same lists.

Could these handlers lock and write a package or channel that
kfree_rcu_mightsleep() or the new call_rcu() callback has already freed?
With CONFIG_PROVE_RCU_LIST, these walks should also trigger RCU-list
lockdep warnings.

ftgmac100_stop() also calls ncsi_stop_dev(priv->ndev) later in the
removal path, which would use ndp after it has been freed. RCU does not
cover that use either.

Would it work better to hold RCU from lookup through last use, take a
reference on ndp, or serialize the genl handlers against
ncsi_unregister_dev()? The last option would also mean removing ndp
from ncsi_dev_list before the packages are torn down.

[Severity: High]
This is a pre-existing issue, but could the request timers in
ndp->requests[] still be armed when ndp is freed here?

ncsi_xmit_cmd() arms a one second timer that is embedded in ndp:

	nr->enabled = true;
	mod_timer(&nr->timer, jiffies + 1 * HZ);

Only the response path (ncsi_rcv_rsp()->ncsi_free_request()) or the
timer itself disarms it. dev_remove_pack() runs first, so outstanding
requests can no longer get a response. The work item and the channel
monitor timers can keep sending commands until they are stopped.

ncsi_unregister_dev() never walks ndp->requests[] to call
timer_delete_sync() or ncsi_free_request(). An RCU grace period
normally ends well before the one second timeout. When the timer then
fires, ncsi_request_timeout() would run on freed memory:

	struct ncsi_dev_priv *ndp = nr->ndp;
	...
	spin_lock_irqsave(&ndp->lock, flags);

The nr->cmd skbs of those requests also appear to be leaked.

[Severity: Medium]
This isn't a bug introduced by this patch, but are the vlan_vid entries
on ndp->vlan_vids leaked here?

ncsi_vlan_rx_add_vid() allocates them and links them with
list_add_rcu(&vlan->list, &ndp->vlan_vids). They are only freed in
ncsi_vlan_rx_kill_vid(), which returns early once ndp has been removed
from ncsi_dev_list:

	nd = ncsi_find_dev(dev);
	if (!nd) {
		netdev_warn(dev, "NCSI: no net_device?\n");
		return 0;
	}

On ftgmac100, unregister_netdev() runs after ncsi_unregister_dev(). Any
VID still registered at unregister time would therefore never be freed.

>  }
>  EXPORT_SYMBOL_GPL(ncsi_unregister_dev);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261120235407.1911365-1-tristmd%40gmail.com
