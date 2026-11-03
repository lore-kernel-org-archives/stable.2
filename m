Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700154;
	b=bctUoCofJLfQxEmEAvZ+RBd9rQpTHI+0gTW+kaCpljNMHDK3y5lwjti31/cCO2GwWywn
	 /1GmCKHh6RU0SyM1nLOOlU/M53VY8Q8bq/VsVvhZCKgFxR4NxM4ALw4Ju1jl46G+/GE+G
	 06KUNDsUSrRWQWukRNv58zy4mWwzPgEwITCHRtzGX46ClwaOQ7jOGrd28X1U1p8jVyF75
	 DP/7hV2TaEmat+32B9c8JD0deA+LqKxN8MK4HZRH8b4gxr8SyfZqYgTEQAlboG2K/k+dP
	 vuichbgJ2bmAmexOo9Aca/Jzv5pWnyf/g0ot6g6uwgAwnYGDUkiI62JcdR1NHBdE6TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700154;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=uDv0xbuWJ4DV8Vi5nTfEB55YMlJbl6jXnOSrMjSiXiI=;
	b=s0/XzAqndR0pUXgprdPYyUApu8BMm96M5B6Qij1NgJ2ce/E1OaJAbvvnwfdb+y+3XGtN
	 9mZeDSm6YEAPZGa6nqKegon6saHXZl0hbRAqpHgmGok4LRiIPD1BfwL5ZRWnPiHnEQsuy
	 utlGx1UV//Uy+80kjt54sLj8vVJwGy0IfIO2foWqtQOCYT+y5O13U1W7yRI5vK5mWLIcm
	 fhP2BNxUtwkRvHTUbKNFuEDXyjgwrtZB8ziZLObY1t/joLr+9sEMoB6CjGiYdRFm2+Nqp
	 dMz5ylcL+8gH44AIac4+Sw/IZtFNv/h8sJzmNEU2u9I9iY0yycUnkm8X14eToItMr6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=itkQ3OWB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EEC606C529;
	Tue,  3 Nov 2026 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=itkQ3OWB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D868A1F000C1;
	Tue,  3 Nov 2026 10:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700153;
	bh=uDv0xbuWJ4DV8Vi5nTfEB55YMlJbl6jXnOSrMjSiXiI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=itkQ3OWBv/EYt7lZVTVWxovaLZhMPzXQ83JsuAT38WpBf8xQvTXH2mlxnB2x0EhSn
	 v7hu/diG/lp0rROZ6TM9DFfqpR2VpW+WRvkucip0IxBmCApDJ4FJDipYMlcGzBCKqn
	 zi/ugVEAyeK44+zTLDMpgZl/cclFkay9Uszmu150vNrRwYpxpNAfyX0xl67w0bUcqX
	 MNriePhZxv4RBXHzqPDSUtwipEnf0Zt4asGdL08oo7IO5oWXKyCmUO/7F4+EqUoy8p
	 iQ1zLYd1ZVb4jt77Jox6ylFzcAfQgFKGUuXwULpOtZRs5MFVkHo45yr/ix7qLUSHIj
	 LJCqQ9BRt5ijw==
Subject:
 Re: [PATCH net] mac802154: use pinned interface for beacon transmission
From: netdev-bot+sashiko@kernel.org
To: yfzhang23@stu.pku.edu.cn
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, alex.aring@gmail.com,
 stefan@datenfreihafen.org, miquel.raynal@bootlin.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 zihanx@nebusec.ai, stable@vger.kernel.org
Date: Tue, 03 Nov 2026 10:02:32 +0000
Message-ID: <179370015236.488856.9062135405491525675@kernel.org>
In-Reply-To: <179335297474.14852.9229658182764909973@stu.pku.edu.cn>
References: <179335297474.14852.9229658182764909973@stu.pku.edu.cn>
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

Critical: 0 · High: 1 (1) · Medium: 2 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] mac802154: warning and skb leak in mac802154_transmit_beacon()
  when iface down
- [Medium] After this patch, the race the commit message targets ends in
  WARN_ON_ONCE(!netif_running(sdata->dev)) in…
- [Medium] The beacon skb leaks whenever ieee802154_mlme_tx_locked()
  rejects the pinned interface.
- [Low] The commit body contains a raw mbox/format-patch header block:
  '>>From 1e3faf146431b4c28bdf0923fa54754c1f8d8902 Mon Sep 17 00:00:00…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but beacon_work
  can stay armed after mac_wq is destroyed and the PHY is freed.
- [Low] local->beacon is a per-PHY beacon template, and two paths access
  it with locksets that do not intersect.

--

mac802154: use pinned interface for beacon transmission

With this patch, mac802154_transmit_beacon() takes sdata from the wpan_dev
that mac802154_beacon_worker() already selected and pinned with
netdev_hold(). It no longer re-reads local->beacon_req under RCU. The goal
is to avoid a use-after-free when beacon_req switches to another interface
and that interface is removed before ieee802154_mlme_tx_locked() runs.

> mac802154: use pinned interface for beacon transmission
>
> >>From 1e3faf146431b4c28bdf0923fa54754c1f8d8902 Mon Sep 17 00:00:00 2001
> From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
> Date: Wed, 28 Oct 2026 17:18:59 +0800
> Subject: [PATCH net] mac802154: use pinned interface for beacon transmission

[Severity: Low]
This isn't a bug, but these format-patch header lines ended up in the
commit body. Because of the leading ">>From" line, git mailinfo won't
treat them as in-body headers.

If the patch is applied as is, the changelog keeps:

- a second copy of the subject, with the "[PATCH net]" prefix
- a format-patch SHA that matches no commit in the tree
- a Date that doesn't match the author date

Could the patch be resent with git send-email, or could these lines be
stripped when it is applied?

> diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
> index d393b1f4e74e4..9f0e45bf4bcb5 100644
> --- a/net/mac802154/scan.c
> +++ b/net/mac802154/scan.c

[ ... ]

> @@ -365,19 +364,9 @@ static int mac802154_transmit_beacon(struct ieee802154_local *local,
>  	if (!skb)
>  		return -ENOBUFS;
>  
> -	rcu_read_lock();
> -	beacon_req = rcu_dereference(local->beacon_req);
> -	if (unlikely(!beacon_req)) {
> -		rcu_read_unlock();
> -		kfree_skb(skb);
> -		return -EINVAL;
> -	}
> -
> -	sdata = IEEE802154_WPAN_DEV_TO_SUB_IF(beacon_req->wpan_dev);
> +	sdata = IEEE802154_WPAN_DEV_TO_SUB_IF(wpan_dev);

[Severity: High]
Can this turn the race from the commit message into a WARN_ON_ONCE()
and an skb leak?

mac802154_beacon_worker() pins sdata->dev with netdev_hold() and checks
ieee802154_sdata_running() under rcu_read_lock(). Nothing is held
between rcu_read_unlock() and the rtnl_lock() taken inside
ieee802154_mlme_tx(), so the pinned interface can be closed in that
window.

The removed re-read of local->beacon_req used to catch this. If
mac802154_slave_close() had stopped beaconing through
mac802154_stop_beacons_locked(), the skb was freed and -EINVAL
returned. If the request had moved, the new interface was used. Now
the pinned wpan_dev is used unconditionally.

For beacon_req to move to another interface, as the commit message
describes, the old interface must already be down.
ieee802154_check_concurrent_iface() does not let two coordinator
interfaces run on one PHY, and NL802154_CMD_SEND_BEACONS requires
NL802154_FLAG_CHECK_NETDEV_UP. In that scenario the worker always
reaches ieee802154_mlme_tx_locked() with !netif_running(sdata->dev)
and local->open_count > 0:

net/mac802154/tx.c:ieee802154_mlme_tx_locked() {
    ...
	if (!local->open_count)
		return -ENETDOWN;

	if (WARN_ON_ONCE(!netif_running(sdata->dev)))
		return -ENETDOWN;
    ...
}

The same state occurs when the coordinator is closed while a monitor
interface on the same PHY stays open. With panic_on_warn set, this
takes the machine down.

Both -ENETDOWN returns also exit before the skb reaches
ieee802154_tx(), and nothing frees it. Callers of ieee802154_mlme_tx()
don't free the skb on error, because ieee802154_tx() consumes it on
its own paths. mac802154_transmit_beacon() just returns the error.
So the beacon skb leaks on either path, including when no other
interface is open.

Should mac802154_transmit_beacon() re-check under RTNL that
local->beacon_req still points at wpan_dev and that the interface is
still running, and free the skb otherwise? Or should the -ENETDOWN
returns in ieee802154_mlme_tx_locked() free the skb themselves?

[Severity: Medium]
Can the race described in the commit message now end in the
WARN_ON_ONCE() in ieee802154_mlme_tx_locked()?

mac802154_beacon_worker() checks ieee802154_sdata_running() under RCU
only. It then allocates and builds the beacon, and takes RTNL only inside
ieee802154_mlme_tx().

mac802154_stop_beacons_locked() uses the non-sync cancel_delayed_work(),
so a worker that is already running keeps going.

For beacon_req to move from interface A to interface B, B has to be a
coordinator that is up. nl802154_send_beacons() requires
NL802154_IFTYPE_COORD and NL802154_FLAG_CHECK_NETDEV_UP.

ieee802154_check_concurrent_iface() and ieee802154_check_mac_settings()
allow only one such interface to run per PHY. So A must be down by then.

Before this patch, mac802154_transmit_beacon() re-read beacon_req and
transmitted on B. With this change, the pinned and downed A is always
passed in. If B, or any other interface on the PHY, is still open when the
worker gets RTNL, local->open_count is non-zero and this fires:

net/mac802154/tx.c:ieee802154_mlme_tx_locked() {
    ...
	if (WARN_ON_ONCE(!netif_running(sdata->dev)))
		return -ENETDOWN;
    ...
}

The same applies if A is closed and another interface is opened before
the worker wins rtnl_lock().

The commit message calls the removed lookup redundant. Wasn't it the only
place where the worker noticed that beaconing had moved?

Would it make sense to re-check after rtnl_lock() that
rcu_dereference_rtnl(local->beacon_req) is non-NULL, that its ->wpan_dev
still equals wpan_dev, and that ieee802154_sdata_running(sdata) still
holds, and otherwise free the skb and return?

[Severity: Medium]
Does this path now leak the beacon skb whenever
ieee802154_mlme_tx_locked() rejects the pinned interface?

Both -ENETDOWN returns in ieee802154_mlme_tx_locked() exit without passing
the skb to ieee802154_tx() and without freeing it:

	if (!local->open_count)
		return -ENETDOWN;

	if (WARN_ON_ONCE(!netif_running(sdata->dev)))
		return -ENETDOWN;

mac802154_transmit_beacon() passes that error straight back from
ieee802154_mlme_tx() and never calls kfree_skb().

The removed beacon_req check used to free the skb and return -EINVAL when
beaconing had stopped.

mac802154_slave_close() stops beacons with the non-sync cancel and then
decrements local->open_count. If A is closed this way before the worker
takes RTNL, the race from the commit message now always ends on one of
these -ENETDOWN paths. That happens whether or not the new interface has
already been removed.

Should the skb be freed on the -ENETDOWN paths? Alternatively, the beacon
path could re-check under RTNL and free the skb when the check fails.

>  	skb->dev = sdata->dev;
>  
> -	rcu_read_unlock();
> -
>  	ret = ieee802154_beacon_push(skb, &local->beacon);

[Severity: Low]
This is a pre-existing issue, but local->beacon is accessed here with no
lock in common with mac802154_send_beacons_locked().

mac802154_transmit_beacon() writes local->beacon.mhr.seq and serializes
the whole template in ieee802154_beacon_push() before ieee802154_mlme_tx()
takes RTNL. Meanwhile, mac802154_send_beacons_locked() rebuilds the
template under RTNL:

	memset(&local->beacon, 0, sizeof(local->beacon));
	local->beacon.mhr.fc.type = IEEE802154_FC_TYPE_BEACON;
	...

Because mac802154_stop_beacons_locked() uses cancel_delayed_work(), a
running worker can serialize a template that is only partly rebuilt.

After this patch, skb->dev and the BSN come from the pinned interface,
while the template may describe the new request's wpan_dev. Such a frame
is only sent if the pinned interface was re-opened. Otherwise
ieee802154_mlme_tx_locked() rejects it.

Should this data race be handled too?

>  	if (ret) {
>  		kfree_skb(skb);

[Severity: High]
This isn't a bug introduced by this patch, but can beacon_work still be
armed after mac_wq is destroyed and the PHY is freed?

mac802154_stop_beacons_locked() only calls cancel_delayed_work(). A worker
that already passed its beacon_req check keeps running. At the end of
mac802154_beacon_worker(), it re-arms from its stale snapshot before
dropping the netdev reference:

	if (interval < IEEE802154_ACTIVE_SCAN_DURATION)
		queue_delayed_work(local->mac_wq, &local->beacon_work,
				   local->beacon_interval);
	netdev_put(sdata->dev, &dev_tracker);

In ieee802154_unregister_hw(), ieee802154_remove_interfaces() runs under
RTNL. The worker therefore blocks in ieee802154_mlme_tx(), and
unregistration waits for the worker's netdev_put(), which comes after the
re-arm. Then:

ieee802154_unregister_hw()
    destroy_workqueue(local->mac_wq);

runs while the beacon_work timer is still pending. The destroy_workqueue()
comment says all delayed_work must be cancelled before calling it.
net/mac802154 has no cancel_delayed_work_sync() for beacon_work.

ieee802154_free_hw() then frees the wpan_phy that holds ieee802154_local
and the embedded timer. When the timer fires, delayed_work_timer_fn()
would touch freed memory and queue work onto a destroyed workqueue.

This could be hit while a coordinator is beaconing, by deleting a hwsim
radio, by rmmod, or by unplugging a USB transceiver.

Would it help to stop the producers and call cancel_delayed_work_sync()
on beacon_work (and scan_work) before destroy_workqueue(local->mac_wq)?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179335297474.14852.9229658182764909973%40stu.pku.edu.cn
