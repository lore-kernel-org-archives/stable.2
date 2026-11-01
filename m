Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793573967;
	b=GkFLj7LSME2Js7QYkn1CogM9NKA2kt+2hZr/Q5CXJBgag+RFHSUFRsxDzbYKE3aD5SuG
	 5nClRVSxn+R2tjJGIZI99SrjO1AmlCvNi5U6nLXIAMMFD2jHw+m+MASh+pBu+0b67ZlnZ
	 +QTn3Dsukv+nK6yhz0EG4I1Rpag1nrwhpl+g/wqmAipOt3ZfYaMGBsU+Umsg1NaYCTCYC
	 oM5PccGMWg3tMFT4G4WP7PB5LsHxLNcFyVw4DWmAzIokbQUJ27NlpR6ScUeW10V/if4Yq
	 iWTtNy4eRgCPsLkzKO94B1LD5uwpROr+ZC2zgODJTY1DeQ6cKhszAM94t8xGy5bodBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793573967;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Message-ID:X-Sender:
	 Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=UfWjHWL7Sf5149fxouKPsSV+//DCptgJPgsPxN+aK+8=;
	b=soY8m/2LAuWCnzH9nR4N/3o5mOxxWIWyTGvl+gwmew1rxbRhdLlpvjYkhfUjnUynxBEB
	 R+i1PLB1YW6yCZm2zL+g4YUVFBKrHsjZqrUVQgJMVTrHQCXEVMb8hF1AhxuHxQ0mQHgvk
	 dbSMj2lnnO0QA0vpSAWbQAVrGZAkpO6yY6bOE8USWVPnohGNz7MIks5TM5W3pybcFjHYR
	 gdpjwssLxHoxtN7gsX1+XlBtPiBJkQ8TQ6HWm9etzxfjUkWIoVarnaMnnHMWg7lEJLQl0
	 UPfqHQCEPiA5Z2FDC0ix5T2UbKyYfJTa8VugxkvleNdKKSXQ7MRk4+y5SsO6QAVOhhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=qXhfjLJN;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB55606A324;
	Sun,  1 Nov 2026 22:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFB55606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=qXhfjLJN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=UfWjHWL7Sf5149fxouKPsSV+//DCptgJPgsPxN+aK+8=; b=qXhfjLJNCxZ7lDoPzewLDwt/vV
	hhU5dXu5QoUtnf3Oh1oVSOBawYsEOyP7NKdY7xYn2mamekYL7Z4ag/twYP5Uo8KQF8EsUw9VWTIzL
	juz/jlH/ApyZwXyVJLbPajYtYZf5bU96+vkDdcpV+ojDuU/4OJgMuoixTzYi0LKPSYpTNKFXfZUCR
	SWHfXHS8pw4aWiODKX90iOJSN5Owum09q6Va+NoZ75d9rbGd7fncN9m37mobYAkneDapBx8U7c1ak
	R5exQOnAeAMPQunNcWtz7WtvfrgHZ7oq7QabrR1f/qBhwWfQKaiiZNDNfWXveluosAb9AOrdQX6xc
	6ZFVATtw==;
Received: from [::1] (port=58476 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xNeWF-00000004BUd-1dDV;
	Sun, 01 Nov 2026 23:59:19 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sun, 01 Nov 2026 23:59:19 +0100
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: netdev-bot+sashiko@kernel.org
Cc: subash.a.kasiviswanathan@oss.qualcomm.com,
 sean.tranchetti@oss.qualcomm.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH net] net: qualcomm: rmnet: avoid stale VND access on TX
 drop
In-Reply-To: <179357109791.3131.6434747837427266534@kernel.org>
References: <20261031221052.1642262-1-Jeremy.Jean@oss.cyber.gouv.fr>
 <179357109791.3131.6434747837427266534@kernel.org>
User-Agent: Roundcube Webmail/1.6.20
Message-ID: <1916da9d261bf0094fb5295f10ec6db3@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-11-01 23:11, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let 
> patchwork
> know by including "pw-bot: cr" as a separate line at the end of your 
> reply
> (one such reply per series is enough).
> 
> - [High] The fix is incomplete: the stale port->rmnet_dev UAF described
>   in the commit message can still be reached.
> 
> Pre-existing issues:
> - [High] Teardown race: rmnet_port can be freed while its hrtimer is
>   still armed.
> 
> --
> 
> net: qualcomm: rmnet: avoid stale VND access on TX drop
> 
> This commit changes rmnet_send_skb() so that a TX drop after a failed
> __skb_linearize() is counted on the lower device with
> dev_core_stats_tx_dropped_inc(). Before, the drop was counted through
> port->rmnet_dev, which can still point at a VND that has been deleted.
> 
>> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c 
>> b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
>> index 39d6d084e73f0..bd68d60b50d35 100644
>> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
>> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
>> @@ -543,10 +543,7 @@ static void rmnet_send_skb(struct rmnet_port 
>> *port, struct sk_buff *skb)
>>  {
>>  	if (skb_needs_linearize(skb, port->dev->features)) {
>>  		if (unlikely(__skb_linearize(skb))) {
>> -			struct rmnet_priv *priv;
>> -
>> -			priv = netdev_priv(port->rmnet_dev);
>> -			this_cpu_inc(priv->pcpu_stats->stats.tx_drops);
> 
> [Severity: High]
> This removes one reader of the stale port->rmnet_dev. Can the stale
> pointer still be reached another way?
> 
> rmnet_newlink() is the only function that writes port->rmnet_dev.
> rmnet_dellink() does not clear or reassign it when the VND it points to
> is deleted. rmnet_unregister_bridge() still uses it on the real-device
> branch:
> 
> drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c:rmnet_unregister_bridge() 
> {
>     ...
> 	rmnet_dev = port->rmnet_dev;
> 	if (!port->nr_rmnet_devs) {
>     ...
> 	} else {
> 		/* real device */
> 		bridge_dev = port->bridge_ep;
>     ...
> 	}
> 
> 	netdev_upper_dev_unlink(bridge_dev, rmnet_dev);
>     ...
> }
> 
> This sequence seems to reach it without any race:
> 
> 1. Create VNDs A and B on real device R, so port->rmnet_dev = B.
> 
> 2. Delete B. nr_rmnet_devs drops to 1 and B is unregistered and freed
>    (needs_free_netdev), but port->rmnet_dev still points at B.
> 
> 3. Run "ip link set S master A". rmnet_add_bridge() only rejects
>    nr_rmnet_devs > 1, so the call succeeds. It puts R's port into
>    bridge mode but does not update R's port->rmnet_dev.
> 
> 4. Unregister R:
> 
>    rmnet_config_notify_cb(NETDEV_UNREGISTER)
>      rmnet_force_unassociate_device(R)
>        rmnet_unregister_bridge(port)
>          netdev_upper_dev_unlink(S, B)   <- B already freed
>            __netdev_upper_dev_unlink()
> 
> __netdev_upper_dev_unlink() passes B to the PRECHANGEUPPER and
> CHANGEUPPER notifiers. It then calls __netdev_update_lower_level(B),
> which writes to B, and __netdev_walk_all_upper_dev(B), which walks B's
> adjacency lists.
> 
> The real S->A adjacency is also never removed. Does that leak the
> reference on A, so that unregistering A later hangs in
> netdev_wait_allrefs()?
> 
> Should port->rmnet_dev be kept valid in rmnet_dellink() instead? The
> other option is to stop using it in rmnet_unregister_bridge() as well,
> for example by using the slave port's rmnet_dev or
> netdev_master_upper_dev_get(bridge_ep).
> 
>> +			dev_core_stats_tx_dropped_inc(port->dev);
> 
> [Severity: High]
> This is a pre-existing issue and was not introduced by this patch. Can
> rmnet_send_skb() run on an rmnet_port that has already been freed? If
> so, both port->dev->features and the new
> dev_core_stats_tx_dropped_inc(port->dev) read freed memory.
> 
> When the last VND is deleted, rmnet_dellink() tears down the port 
> before
> it unregisters the VND:
> 
> 	netdev_upper_dev_unlink(real_dev, dev);
> 	rmnet_unregister_real_device(real_dev);
> 	unregister_netdevice_queue(dev, head);
> 
> rmnet_unregister_real_device() then does:
> 
> 	rmnet_map_tx_aggregate_exit(port);
> 
> 	netdev_rx_handler_unregister(real_dev);
> 
> 	kfree(port);
> 
> Nothing marks the port as shutting down. With TX aggregation enabled
> (egress_agg_params.count > 1, set through ethtool coalesce), a transmit
> on another CPU at the same time could go like this:
> 
> CPU1
> rmnet_vnd_start_xmit()
>   rmnet_egress_handler()
>     port = rmnet_get_port_rcu(skb->dev);   <- before rx_handler is NULL
>     rmnet_map_egress_handler()
>       rmnet_map_tx_aggregate()
>         spin_lock_bh(&port->agg_lock);     <- waits for CPU2
> 
> CPU2
> rmnet_unregister_real_device()
>   rmnet_map_tx_aggregate_exit()
>     hrtimer_cancel(&port->hrtimer);
>     cancel_work_sync(&port->agg_wq);
>     spin_lock_bh(&port->agg_lock);
>     ... frees skbagg_head ...
>     spin_unlock_bh(&port->agg_lock);
> 
> CPU1 then takes agg_lock, sets port->skbagg_head with skb_copy_expand()
> and re-arms the timer:
> 
> 	hrtimer_start(&port->hrtimer,
> 		      ns_to_ktime(port->egress_agg_params.time_nsec),
> 		      HRTIMER_MODE_REL);
> 
> CPU2 continues:
> 
>   netdev_rx_handler_unregister()   <- synchronize_net() waits for CPU1
>   kfree(port);                     <- hrtimer still queued
> 
> When the timer fires, rmnet_map_flush_tx_packet_queue() calls
> schedule_work(&port->agg_wq) on the freed port. The work then reaches
> rmnet_send_skb() through rmnet_map_flush_tx_packet_work(). The
> aggregated skb also seems to leak.
> 
> synchronize_net() waits for the reader to finish, but nothing cancels
> the timer that the reader armed. Would a shutdown flag checked under
> agg_lock work here, or a second cancel after
> netdev_rx_handler_unregister()?
> 
> This looks like it comes from the TX aggregation code added by the
> commit in the Fixes: tag.
> 
>>  			dev_kfree_skb_any(skb);
>>  			return;
>>  		}

Both comments from Sashiko seem valid, thanks.
I will make a v2 for the first one, and create a dedicated patch for
the second one.

Jérémy

pw-bot: cr
