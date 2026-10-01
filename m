Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F9D490BE4;
	Thu,  1 Oct 2026 08:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790842092; cv=none; b=pSmClmowd9EFAoNXatTqvyDaEoZbkUFYT6wlZo79y9e1oH6wyRYrX9Ts3q9oJKu67G5Snb22/8sTOBqDia7T6v4F6FLbJpGL5Dspw3dQEngy9IInlgeSDGbrM/QP22O59TieI6WXTGWrJi/pfVioIq4jT6wwDalAtixD+XH+AT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790842092; c=relaxed/simple;
	bh=1p4hh2wys8aLmlmvGFq0WQvmf6umLU1/EvYRjaLfDRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V39uupIIl79tgxC8CxjTYFoC2r+5P2BuyNw588tQ8NV77Mqt/KzcME/AtQ95C+bLscULhT1kW7Ff/LMRxt4CN0+NLih6PfdcOy+ate1mGq+0iQwXbDOrNQT27omXggfida+Nod5y+cpQnEEalYRJJXiG8Arozlg14KiTkfNISBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Md+FUUgK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Md+FUUgK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2881F000FF;
	Thu,  1 Oct 2026 08:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790842090;
	bh=CnzLFuNsJpCYaPAL/RTULf3am+9DUJ/7Ga09mY32xIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Md+FUUgK66AWhKilsZ5zU4rlF7Is0vi12OJeyNZ01o+vjzXxxUBEMIzYTxfkq9MNJ
	 Etu/v15fRakdnqSR0BYfMfZJkuvjMXmmjF48hMmjnjGmMmXeyy6Fr75eg5uTmdzbPr
	 ddoe1ELOj+VVkB/ZGo6uk/1Cq0DzRIS8osYpLY0Iu1XWpGd9YA/GHDtB4IkLDP9e2K
	 Q6hXK639qTqmj1gntIgwEq3IfuvDP+4AA5iAAYFjK8x3GD8bF4/81Tr2rsShY/XB1W
	 QvKADL6/6QHV6n+Oyq35kltNdF329LAK3L8KMXbiedR9aAiHdp+aIzsYlN2RoSq9TD
	 YLTVt9RZqabSw==
Date: Thu, 1 Oct 2026 10:08:07 +0200
From: Antoine Tenart <atenart@kernel.org>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net-sysfs: release queue trackers before allowing
 reuse
Message-ID: <ar4U2G25PLXPCnOS@kwain>
References: <20260930181106.271547-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930181106.271547-1-nicoyip.dev@gmail.com>

On Thu, Oct 01, 2026 at 02:11:06AM +0800, Chengfeng Ye wrote:
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
> RX queues have the same ordering. Their removal and re-addition are
> normally serialized by RTNL, but CONFIG_DEBUG_KOBJECT_RELEASE can defer the
> release callback to workqueue context and expose the same reuse window.
> 
> Release each tracker before clearing its kobject. Pair full memory barriers
> on the release and add sides so that an add which observes
> state_initialized clear cannot install a new tracker before the old release
> has finished accessing the shared tracker slot. Keep the numeric device
> reference until after the reset so that the queue storage remains alive
> throughout the callback's accesses.
> 
> Fixes: b0b6fcfa6ad8 ("net-sysfs: remove rtnl_trylock from queue attributes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>

Reviewed-by: Antoine Tenart <atenart@kernel.org>

> ---
> Changes in v2:
> - Add an explicit full memory barrier in the TX add path, paired with the
>   release-side barrier.
> - Apply the same tracker ordering and barrier pair to RX queues, whose
>   release callback may be delayed with CONFIG_DEBUG_KOBJECT_RELEASE.
> - Clarify the paired barrier comments.
> 
> Link: https://lore.kernel.org/r/20260926173315.2452612-1-nicoyip.dev@gmail.com/ [v1]
> 
>  net/core/net-sysfs.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 352173df7578..2af972f5d3c3 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -1156,8 +1156,11 @@ static void rx_queue_release(struct kobject *kobj)
>  		kvfree_rcu_mightsleep(rps_tag_to_table(tag_ptr));
>  #endif
>  
> +	netdev_tracker_free(queue->dev, &queue->dev_tracker);
> +	/* Pairs with the smp_mb() in rx_queue_add_kobject(). */
> +	smp_mb();
>  	memset(kobj, 0, sizeof(*kobj));
> -	netdev_put(queue->dev, &queue->dev_tracker);
> +	__dev_put(queue->dev);
>  }
>  
>  static const struct ns_common *rx_queue_namespace(const struct kobject *kobj)
> @@ -1230,6 +1233,9 @@ static int rx_queue_add_kobject(struct net_device *dev, int index)
>  		return -EAGAIN;
>  	}
>  
> +	/* Pairs with the smp_mb() in rx_queue_release(). */
> +	smp_mb();
> +
>  	/* Kobject_put later will trigger rx_queue_release call which
>  	 * decreases dev refcount: Take that reference here
>  	 */
> @@ -1906,8 +1912,11 @@ static void netdev_queue_release(struct kobject *kobj)
>  {
>  	struct netdev_queue *queue = to_netdev_queue(kobj);
>  
> +	netdev_tracker_free(queue->dev, &queue->dev_tracker);
> +	/* Pairs with the smp_mb() in netdev_queue_add_kobject(). */
> +	smp_mb();
>  	memset(kobj, 0, sizeof(*kobj));
> -	netdev_put(queue->dev, &queue->dev_tracker);
> +	__dev_put(queue->dev);
>  }
>  
>  static const struct ns_common *netdev_queue_namespace(const struct kobject *kobj)
> @@ -1967,6 +1976,9 @@ static int netdev_queue_add_kobject(struct net_device *dev, int index)
>  		return -EAGAIN;
>  	}
>  
> +	/* Pairs with the smp_mb() in netdev_queue_release(). */
> +	smp_mb();
> +
>  	/* Kobject_put later will trigger netdev_queue_release call
>  	 * which decreases dev refcount: Take that reference here
>  	 */
> -- 
> 2.43.0
