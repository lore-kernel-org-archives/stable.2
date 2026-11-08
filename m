Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794116095;
	b=hR0pR3FGIPCkUv7Qfa2MiSpVbDeSuy6fR6L0fAsSlRN5pMKp6vLGvZ5vFBq/Me3hItvN
	 DSRshUsomcDtH3sIj5VF7zNyUXjEEYzHatxsZvsv3HCSwoIlCw/Mk4Fb59tC6CTMye7hc
	 7Ot+zdDBEy1V0NtlyszNHouTvrMc+Z0KRjpFQDbt/Cmt3nNIVMZn1FdbaXNgP42Gf7r0O
	 OFIdMVfzgqYp5IErBE12xfyJhIxrpMGAU9/kszMZ2heRxb2VosnsxHA+/SbAq6tyat0yT
	 uCr0h487jJhFHBZZXfMXvESYcAZvJiCWIP3DyFOhGzIk011hpusdvRDxncdHGmHQ9gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794116095;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=z1M3/CpqdOMOX/NEW9qWjkfjYumx66+9OISoDjarBhs=;
	b=G/EQjg8PtTkZrzVWilJlQ+kBCMd30wh1aQs6PRuKmBOocgpL8ZTahXpAhbMVtnCfYSbK
	 L6PHNiQXUF8bIHW7sl4rcsNJExCqVRiZoWXgzqpx2YPmg4owMgLJeAqqP1p7u1DvlcT9w
	 oembX7kSo86sX3Ax2TKXfilg6DJJRplArAU9V9wQin00T11CUG/Y1DNtu7GWV2PztR2TC
	 RwKaqEvyOX7fjmG4TJaKARyE7Qm7tpXh+yTRi/WIPvqCOjeb5TQaHJK0U1ZAp00wh/aw3
	 iiVL8uKbwnuph5rFmoxrOKvAXC+X6MZxN+IYlnlaUqnhpyKSy2cjnyxgaFB+uO7Bxmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kpZXWfJh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA741606A31A;
	Sun,  8 Nov 2026 05:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kpZXWfJh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C93D1F0089F;
	Sun,  8 Nov 2026 05:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794116094;
	bh=z1M3/CpqdOMOX/NEW9qWjkfjYumx66+9OISoDjarBhs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kpZXWfJhCs0GpIw5akqX3nEtzBqQIrwxCZ4kbN8jUqq5tdYuxyX09OP1fYOHSCpEl
	 R144Lrs+jLtAE33LHjjRzrEvfUNqNKmO8qkDP3Lgm1ctapeXwZ+61Ak5Nx3XpCcQKZ
	 RPdEpHc6SxHqo1NEU/tfzw25ykVUkQwEypeH7epecKmzglRWzPy1NZkfegONAI6KPR
	 IuyDsY0FAgfkRURFicIL1Kyp22GfP6Nf77VAkrVgQh7Zt5je4Ys1i6RqigKZgz8T1s
	 TNilh1chtSAJVCSUkdqf+QF4QfdrGHCFT70K3AbrZnB/My6dwOYdRH5mWoYn+K8wiO
	 DrCWV0ePtuddA==
Subject: Re: [PATCH net] net/ncsi: disable the ncsi work before freeing
 channels and packages
From: netdev-bot+sashiko@kernel.org
To: hj351016@gmail.com
Cc: sam@mendozajonas.com, fercerpav@gmail.com, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sun, 08 Nov 2026 05:34:53 +0000
Message-ID: <179411609314.994134.4851699764532288566@kernel.org>
In-Reply-To: <20261107051825.3313019-1-hj351016@gmail.com>
References: <20261107051825.3313019-1-hj351016@gmail.com>
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

Critical: 0 · High: 1 (2) · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch only quiesces the workqueue entry point of the NC-SI
  state machine.
- [Low] The comment added in ncsi_unregister_dev() mostly narrates
  history ('Commit a0ffa68c70b3 added this disable only ahead of…

Pre-existing issues:
- [High] ncsi_unregister_dev() never cancels the per-request timers
  ndp->requests[i].timer, and never releases in-flight requests, before…
- [High] Packages, channels and ndp are freed with a bare kfree() right
  after list_del_rcu().

--

net/ncsi: disable the ncsi work before freeing channels and packages

This patch moves disable_work_sync(&ndp->work) in ncsi_unregister_dev()
ahead of the ncsi_remove_package() loop. The state-machine work is then
quiesced before channels and packages are freed. It changes the ordering
added by commit a0ffa68c70b3, which disabled the work only right before
kfree(ndp).

> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index 1d63958c4429b..1c2dadfc0a2ad 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c
> @@ -1960,6 +1960,15 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
>  
>  	dev_remove_pack(&ndp->ptype);
>  
> +	/*
> +	 * Quiesce the state-machine work before freeing any channel or
> +	 * package it may still be dereferencing (via the channel_queue /
> +	 * package lists).  Commit a0ffa68c70b3 added this disable only
> +	 * ahead of kfree(ndp), i.e. after the channels and packages had
> +	 * already been freed below, leaving that use-after-free window.
> +	 */

[Severity: Low]

This isn't a bug, but most of this comment is history ("Commit
a0ffa68c70b3 added this disable only ahead of kfree(ndp) ..."). The
changelog and the Fixes: tag already cover that. Could the comment
describe the current invariant instead?

Also, "before freeing any channel or package it may still be
dereferencing" claims more than disable_work_sync() covers. See the
question below about ncsi_channel_monitor().

> +	disable_work_sync(&ndp->work);

[Severity: High]

Does disabling ndp->work here stop the whole state machine?

ncsi_channel_monitor() also runs the state machine, directly from timer
context. The monitor timers of channels the removal loop hasn't reached
yet are still armed.

ftgmac100_remove() calls ncsi_unregister_dev() before unregister_netdev(),
so ncsi_stop_dev() has not run:

drivers/net/ethernet/faraday/ftgmac100.c:ftgmac100_remove() {
    ...
	if (priv->ndev)
		ncsi_unregister_dev(priv->ndev);
	unregister_netdev(netdev);
    ...
}

After dev_remove_pack(), no GLS responses can arrive. The monitors
therefore move toward the timeout branch:

net/ncsi/ncsi-manage.c:ncsi_channel_monitor() {
    ...
	default:
		...
		ncsi_report_link(ndp, true);
		...
		spin_lock_irqsave(&ndp->lock, flags);
		nc->state = NCSI_CHANNEL_ACTIVE;
		list_add_tail_rcu(&nc->link, &ndp->channel_queue);
		spin_unlock_irqrestore(&ndp->lock, flags);
		ncsi_process_next_channel(ndp);
		return;
    ...
}

ncsi_report_link() walks the package and channel lists.
ncsi_process_next_channel() then does the following with the first
channel on channel_queue:

  - pops it with list_first_or_null_rcu() and list_del_init()
  - takes nc->lock and writes nc->state
  - reads nc->package
  - calls ncsi_configure_channel() or ncsi_suspend_channel()

ncsi_remove_channel() unlinks only nc->node. It never removes nc->link
from ndp->channel_queue.

In multi-package or multi-channel mode, ncsi_choose_active_channel() can
queue several channels, and the work normally drains that queue. If the
work is disabled in the middle of configuration, can freed channels stay
on channel_queue?

If so, a later monitor timeout could write into a freed nc->link through
list_add_tail_rcu(). ncsi_process_next_channel() would then dereference
the freed channel.

There is a related race on the channel being removed. The timeout branch
clears nc->monitor.enabled under nc->lock and keeps using nc after that.
ncsi_stop_channel_monitor() skips timer_delete_sync() when enabled is
already false:

net/ncsi/ncsi-manage.c:ncsi_stop_channel_monitor() {
	spin_lock_irqsave(&nc->lock, flags);
	if (!nc->monitor.enabled) {
		spin_unlock_irqrestore(&nc->lock, flags);
		return;
	}
    ...
}

Could ncsi_remove_channel() then kfree(nc) while that channel's own
monitor callback is still running on another CPU?

A possible fix is to stop every monitor timer unconditionally, using
timer_shutdown_sync() without the enabled early return. Then drain or
unlink ndp->channel_queue under ndp->lock before freeing any channel.

> +
>  	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
>  		ncsi_remove_package(np);

[Severity: High]

This isn't a bug introduced by this patch, but the commit message names
the bare kfree() right after list_del_rcu() in ncsi_remove_channel() and
ncsi_remove_package() as part of the problem, and that part is not
fixed. Can the generic netlink handlers still read freed packages and
channels here?

ndp stays on ncsi_dev_list until this loop has freed every package and
channel. ndp itself is then freed with no grace period after
list_del_rcu(&ndp->node).

The netlink side looks up ndp without taking a reference or the RCU read
lock:

net/ncsi/ncsi-netlink.c:ndp_from_ifindex() {
    ...
	nd = ncsi_find_dev(dev);
	ndp = nd ? TO_NCSI_DEV_PRIV(nd) : NULL;

	dev_put(dev);
	return ndp;
}

ncsi_write_package_info() then walks NCSI_FOR_EACH_PACKAGE() and
NCSI_FOR_EACH_CHANNEL() without rcu_read_lock().

ftgmac100_remove() calls ncsi_unregister_dev() before unregister_netdev(),
so the ifindex still resolves during teardown.

NCSI_CMD_PKG_INFO is registered with .flags = 0, so an unprivileged
caller can race a driver unbind. Could ncsi_pkg_info_nl() or
ncsi_pkg_info_all_nl() copy freed memory into the netlink reply? Examples
are nc->version.fw_name, nc->modes and nc->vlan_filter.vids, which
ncsi_remove_channel() frees even earlier.

The admin-only commands could also write through the same freed
pointers: set_interface, set_package_mask, set_channel_mask and
send_cmd.

>  
> @@ -1967,8 +1976,6 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
>  	list_del_rcu(&ndp->node);
>  	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
>  
> -	disable_work_sync(&ndp->work);
> -
>  	kfree(ndp);

[Severity: High]

This is a pre-existing issue, but what happens here to in-flight
requests in ndp->requests[]?

ncsi_xmit_cmd() arms a one second timer for each request:

net/ncsi/ncsi-cmd.c:ncsi_xmit_cmd() {
    ...
	nr->enabled = true;
	mod_timer(&nr->timer, jiffies + 1 * HZ);
    ...
}

ncsi_free_request() is the only place that deletes this timer, on a
response or a timeout. After dev_remove_pack() no response can arrive,
so an outstanding request can only finish through
ncsi_request_timeout().

Requests can be outstanding when ncsi_unregister_dev() is called. New
ones can also be sent during the removal loop:

  - by the monitors of channels not yet removed (GLS in START/RETRY)
  - by netlink, since ndp is still on ncsi_dev_list

Suppose the timer fires during the loop for a request flagged
NCSI_REQ_FLAG_NETLINK_DRIVEN. ncsi_request_timeout() then calls
ncsi_find_package_and_channel() on lists that are being freed.

If it fires after kfree(ndp), it reads nr->ndp and takes ndp->lock from
freed memory:

net/ncsi/ncsi-manage.c:ncsi_request_timeout() {
    ...
	spin_lock_irqsave(&ndp->lock, flags);
	nr->enabled = false;
	if (nr->rsp || !nr->cmd) {
    ...
}

Is the timer_list in requests[] also left queued on the timer wheel
while it sits in freed slab memory? If the timers never fire, the
nr->cmd and nr->rsp skbs would leak.

Also, with the work disabled, the schedule_work() call in
ncsi_free_request() now silently does nothing on this path.

Should the unregister path call timer_shutdown_sync() on each request
timer and release the in-flight requests before freeing ndp?

>  }
>  EXPORT_SYMBOL_GPL(ncsi_unregister_dev);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107051825.3313019-1-hj351016%40gmail.com
