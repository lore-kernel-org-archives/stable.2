Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C709F3A872B;
	Tue, 29 Sep 2026 08:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669625; cv=none; b=ky8a9HrBVg8JN1l6m+cK6mL/571IBpyNrPXLyr+8eE+iO5Uo+DDHIXW9LT9UBR95fVNji3dMuOmAZZw9FHUyb1B3Dpxoh5jXX2YEDgr2QSVR5J/9vF3lw/TSEPizkTV2jp+UpvPwpmBFfQFzEq4XEInIQ5+QXmAv84awFN5zBjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669625; c=relaxed/simple;
	bh=v/nHFs/75IUEDrki8kcMSxnDxL5MYC6GW1ChmsUVrbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgwgEVdYHX/iwpmef3t7+Vl+JOj70HTQA2oLW87c8RdbLrApcr3XYrSn8L3V05CrvUvdq7NiqgkiDHPTv9apfZx66rdC6MVmTU4XJHN0T7V2iRkT/euxeZ442HPpEVPY7O6xBTN2g+69tFGH40HtXzJ9sfkcyYwXUW8Om5L+9Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkHnyFUE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkHnyFUE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B651F000FF;
	Tue, 29 Sep 2026 08:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790669623;
	bh=gJgN2aCUebHNrfp1rXFkI9BUjVxqZZzFmU9NtItoJRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DkHnyFUEckZtoTPuKkwyqiKviy3UzIRYDJtzN3DRP/5VXDL2bSj/oJ9mkvEu25cj3
	 swviCcQ72Jgh1bUQSLiuTl3+3UU0/vO/CPeZ95qXJdx4+UY+HWJZv8sqYJV6l72tlS
	 YoLYJ0xWXKdm29oBsGIAVjvNRo3eqA7Ad4w4Hl17w84QlnTmr2gwSghjX8Pll0LfTb
	 tbc4qBwnlRYYCX7gw+f4+UmEeeLriOT9MowrjdGzX1fxKACIomvoKAVr6Ky11Rptz5
	 ENpCBujm4a2B0yUUx4HwzTRLJrPFm2qkIjE3F2jR2oB1cGozSovyrVSrc0vtw2IQBv
	 qpq/46VJenM+Q==
Date: Tue, 29 Sep 2026 10:13:40 +0200
From: Antoine Tenart <atenart@kernel.org>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net] net-sysfs: release the TX queue tracker before
 allowing reuse
Message-ID: <arty-oqohbGiefgS@kwain>
References: <20260926173315.2452612-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926173315.2452612-1-nicoyip.dev@gmail.com>

On Sun, Sep 27, 2026 at 01:33:15AM +0800, Chengfeng Ye wrote:
> An interrupted sysfs_rtnl_lock() can drop the last kobject reference to a
> removed TX queue without holding RTNL. netdev_queue_release() clears the
> kobject before releasing queue->dev_tracker, allowing the queue to be
> re-added while the old release still needs the shared tracker slot:
> 
>   CPU 0                               CPU 1
>   netdev_queue_release()
>     memset(kobj, 0, sizeof(*kobj))
>                                       netdev_queue_add_kobject()
>                                         state_initialized is clear
>                                         netdev_hold() installs new tracker
>     netdev_put() releases the new tracker
> 
> With CONFIG_NET_DEV_REFCNT_TRACKER enabled, the old tracker is leaked and
> the new lifetime's tracker is released prematurely. A later queue release
> then reports a double release. The numeric device references remain
> balanced.
> 
> The kernel reported:
> 
>   ref_tracker: reference already released.
>   ref_tracker: allocated in:
>    netdev_queue_update_kobjects+0x23d/0x5c0
>    netif_set_real_num_tx_queues+0x111/0x820
>    veth_set_channels+0x327/0x930
>    ethtool_set_channels+0x3ee/0x490
>   ref_tracker: freed in:
>    netdev_queue_release+0xbd/0x130
>    kobject_put+0x1f9/0x280
>    sysfs_rtnl_lock+0x18b/0x1f0
>    xps_rxqs_show+0xad/0x250
>   WARNING: lib/ref_tracker.c:322 at ref_tracker_free+0x49e/0x6d0
>   Call Trace:
>    netdev_queue_release+0xbd/0x130
>    kobject_put+0x1f9/0x280
>    netdev_queue_update_kobjects+0x3f9/0x5c0
>    netif_set_real_num_tx_queues+0x111/0x820
>    veth_set_channels+0x327/0x930
>    ethtool_set_channels+0x3ee/0x490
> 
> Release the tracker before clearing the kobject. Use a full memory barrier
> to order the tracker access before clearing state_initialized, paired with
> the control dependency from that check to the new tracker allocation.
> Keep the device reference until after the reset so that the queue storage
> remains alive throughout the callback's accesses.
> 
> Fixes: b0b6fcfa6ad8 ("net-sysfs: remove rtnl_trylock from queue attributes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
>  net/core/net-sysfs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 352173df7578..b9aadc4c000c 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -1906,8 +1906,11 @@ static void netdev_queue_release(struct kobject *kobj)
>  {
>  	struct netdev_queue *queue = to_netdev_queue(kobj);
>  
> +	netdev_tracker_free(queue->dev, &queue->dev_tracker);
> +	/* Finish using the tracker before allowing the queue to be re-added. */
> +	smp_mb();

Can't you use smp_wmb() instead as it's used to order two stores?

>  	memset(kobj, 0, sizeof(*kobj));
> -	netdev_put(queue->dev, &queue->dev_tracker);
> +	__dev_put(queue->dev);
>  }
>  
>  static const struct ns_common *netdev_queue_namespace(const struct kobject *kobj)
> -- 
> 2.43.0
> 
