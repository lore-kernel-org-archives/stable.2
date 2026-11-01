Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793571099;
	b=jPdzS0XdK5SUaihZhzKMjYyXANFosEROIgs147EJIbSjiLtYZgpMu6gEATwnx+TZrYYK
	 PoEg/GidzJV3G90DcovhAizVzYdqi/p4MrkwQ3oOCWAZ+1VILjB/scjaw0lv1Ha99yrLc
	 EMHe8ePzDQ4gdRvPKFSltpYSK9Zoq0zaAWhppxHywxTpfSducI3IcljjkrmQSJ1rzOATi
	 An1zPWVr9zuLsu0GXw82lSj+0gNI1bumZWaHZ418Skm54O2XTJW4AlF2DhrlWg2Ema0Il
	 h/Nh5GKG9lxsCcABWRHMd422BQagdMCiOz2wpSiIbla9g2bOYbrHOFKlEK5CgEfGSZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793571099;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=EeELGsUsivt06DPGnC0ws8tpaG03XAtRPCdFH6rP66c=;
	b=N+FPcBYCZxykNNCzTYVzIbLqDaHnnr4memsS1E+KeKSoY8OWldLIG1/rrw7D2Urz+7SH
	 GatQqyJtRtV/1ComI85my2LmWrxy9NnI0tYJXbHWEozZ50mXoJBQzjxv7ZAWtk2o2YbSg
	 8l2UHGMLzjxe46EeeruKcT+UkahfHmnHWnNLUi9TfveG68oHrFzcUbJcogtZQFBUmbtsp
	 k5MrxNoHQ8KG4tB45dkKRmc+tY4JETtfhKDDrpbDRII6vSeDmZW79K0PWG1CsvGqOwijC
	 o/XjjoZWGMb0DAExfRPD/yc+RrK13BqjoFNzr4qnaZpTtLURYLgfn0Iz7pp1HeaZ+MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kMzqfgEN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71E3606A324;
	Sun,  1 Nov 2026 22:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kMzqfgEN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626CA1F000C1;
	Sun,  1 Nov 2026 22:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571098;
	bh=EeELGsUsivt06DPGnC0ws8tpaG03XAtRPCdFH6rP66c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kMzqfgENqkxEDkRenHcMCHfzSxJ+h/BV5pG5eoCCDMXr0dE6L8vrQpU7cc4i42O1g
	 grRqHhqygW/hoQNzz9uPZQ6BIkoCQktJ7rdcbUKgHSc7vOXDMUn8UkYi3T2LQArwrB
	 XunqQgCWMfAo9GwDJDJPdW3ybv0nLie+e1iLoXw+3pWcuYctIx/ep6Dqsq1WsarqZZ
	 zy7W28ioMoYO4a2z0/nraVQ7MxRQawXHm+c1XYT/VnX/BH7BQc09Dso7cEimaNiDQg
	 Qgxpu4Q14RUTcG2+uK7LuxSpWVwgUc9qLiZeAqtmXLFImvyZSBm4kSYOwK2FJOtNni
	 TayeJFAf4n2Kg==
Subject:
 Re: [PATCH net] net: qualcomm: rmnet: avoid stale VND access on TX drop
From: netdev-bot+sashiko@kernel.org
To: Jeremy.Jean@oss.cyber.gouv.fr
Cc: subash.a.kasiviswanathan@oss.qualcomm.com,
 sean.tranchetti@oss.qualcomm.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Sun, 01 Nov 2026 22:11:37 +0000
Message-ID: <179357109791.3131.6434747837427266534@kernel.org>
In-Reply-To: <20261031221052.1642262-1-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261031221052.1642262-1-Jeremy.Jean@oss.cyber.gouv.fr>
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete: the stale port->rmnet_dev UAF described
  in the commit message can still be reached.

Pre-existing issues:
- [High] Teardown race: rmnet_port can be freed while its hrtimer is
  still armed.

--

net: qualcomm: rmnet: avoid stale VND access on TX drop

This commit changes rmnet_send_skb() so that a TX drop after a failed
__skb_linearize() is counted on the lower device with
dev_core_stats_tx_dropped_inc(). Before, the drop was counted through
port->rmnet_dev, which can still point at a VND that has been deleted.

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> index 39d6d084e73f0..bd68d60b50d35 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> @@ -543,10 +543,7 @@ static void rmnet_send_skb(struct rmnet_port *port, struct sk_buff *skb)
>  {
>  	if (skb_needs_linearize(skb, port->dev->features)) {
>  		if (unlikely(__skb_linearize(skb))) {
> -			struct rmnet_priv *priv;
> -
> -			priv = netdev_priv(port->rmnet_dev);
> -			this_cpu_inc(priv->pcpu_stats->stats.tx_drops);

[Severity: High]
This removes one reader of the stale port->rmnet_dev. Can the stale
pointer still be reached another way?

rmnet_newlink() is the only function that writes port->rmnet_dev.
rmnet_dellink() does not clear or reassign it when the VND it points to
is deleted. rmnet_unregister_bridge() still uses it on the real-device
branch:

drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c:rmnet_unregister_bridge() {
    ...
	rmnet_dev = port->rmnet_dev;
	if (!port->nr_rmnet_devs) {
    ...
	} else {
		/* real device */
		bridge_dev = port->bridge_ep;
    ...
	}

	netdev_upper_dev_unlink(bridge_dev, rmnet_dev);
    ...
}

This sequence seems to reach it without any race:

1. Create VNDs A and B on real device R, so port->rmnet_dev = B.

2. Delete B. nr_rmnet_devs drops to 1 and B is unregistered and freed
   (needs_free_netdev), but port->rmnet_dev still points at B.

3. Run "ip link set S master A". rmnet_add_bridge() only rejects
   nr_rmnet_devs > 1, so the call succeeds. It puts R's port into
   bridge mode but does not update R's port->rmnet_dev.

4. Unregister R:

   rmnet_config_notify_cb(NETDEV_UNREGISTER)
     rmnet_force_unassociate_device(R)
       rmnet_unregister_bridge(port)
         netdev_upper_dev_unlink(S, B)   <- B already freed
           __netdev_upper_dev_unlink()

__netdev_upper_dev_unlink() passes B to the PRECHANGEUPPER and
CHANGEUPPER notifiers. It then calls __netdev_update_lower_level(B),
which writes to B, and __netdev_walk_all_upper_dev(B), which walks B's
adjacency lists.

The real S->A adjacency is also never removed. Does that leak the
reference on A, so that unregistering A later hangs in
netdev_wait_allrefs()?

Should port->rmnet_dev be kept valid in rmnet_dellink() instead? The
other option is to stop using it in rmnet_unregister_bridge() as well,
for example by using the slave port's rmnet_dev or
netdev_master_upper_dev_get(bridge_ep).

> +			dev_core_stats_tx_dropped_inc(port->dev);

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. Can
rmnet_send_skb() run on an rmnet_port that has already been freed? If
so, both port->dev->features and the new
dev_core_stats_tx_dropped_inc(port->dev) read freed memory.

When the last VND is deleted, rmnet_dellink() tears down the port before
it unregisters the VND:

	netdev_upper_dev_unlink(real_dev, dev);
	rmnet_unregister_real_device(real_dev);
	unregister_netdevice_queue(dev, head);

rmnet_unregister_real_device() then does:

	rmnet_map_tx_aggregate_exit(port);

	netdev_rx_handler_unregister(real_dev);

	kfree(port);

Nothing marks the port as shutting down. With TX aggregation enabled
(egress_agg_params.count > 1, set through ethtool coalesce), a transmit
on another CPU at the same time could go like this:

CPU1
rmnet_vnd_start_xmit()
  rmnet_egress_handler()
    port = rmnet_get_port_rcu(skb->dev);   <- before rx_handler is NULL
    rmnet_map_egress_handler()
      rmnet_map_tx_aggregate()
        spin_lock_bh(&port->agg_lock);     <- waits for CPU2

CPU2
rmnet_unregister_real_device()
  rmnet_map_tx_aggregate_exit()
    hrtimer_cancel(&port->hrtimer);
    cancel_work_sync(&port->agg_wq);
    spin_lock_bh(&port->agg_lock);
    ... frees skbagg_head ...
    spin_unlock_bh(&port->agg_lock);

CPU1 then takes agg_lock, sets port->skbagg_head with skb_copy_expand()
and re-arms the timer:

	hrtimer_start(&port->hrtimer,
		      ns_to_ktime(port->egress_agg_params.time_nsec),
		      HRTIMER_MODE_REL);

CPU2 continues:

  netdev_rx_handler_unregister()   <- synchronize_net() waits for CPU1
  kfree(port);                     <- hrtimer still queued

When the timer fires, rmnet_map_flush_tx_packet_queue() calls
schedule_work(&port->agg_wq) on the freed port. The work then reaches
rmnet_send_skb() through rmnet_map_flush_tx_packet_work(). The
aggregated skb also seems to leak.

synchronize_net() waits for the reader to finish, but nothing cancels
the timer that the reader armed. Would a shutdown flag checked under
agg_lock work here, or a second cancel after
netdev_rx_handler_unregister()?

This looks like it comes from the TX aggregation code added by the
commit in the Fixes: tag.

>  			dev_kfree_skb_any(skb);
>  			return;
>  		}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261031221052.1642262-1-Jeremy.Jean%40oss.cyber.gouv.fr
