Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DCB3C6A5C;
	Mon, 29 Jun 2026 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754813; cv=none; b=q73mQbCbUzXe3zpK+qIydXkB4IRzyEXI5cnpk150oSLeTqwshP9qE+TZwvc64sLOtOmIdecosRw1GiIVE/HiFaKC+5Aizd8viUUd1uZwcFfMbwL6MTxUZmYt/ya8Co4Yb8lqt8FsK8bI2vEFoFNf86FKt9oTCruGD2Dqpye0rJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754813; c=relaxed/simple;
	bh=suPZDoIjc7imHpWyaxyx0h9JyD2nnVd0qCwkq8i2i60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1+kQcf2MUOkEMkzE9ozd+DPi+IxyORVd8D8lk19/Vx9ySF1IeU7qg14CzbPnreTFU5wIqaRetyp45U12ImtON0gESq9rYUAOepiuq9TXrMhoZ0jHKDbFtaYlRuXYLxRgQiiVMA6vPjOEIuW9TPy4s0GoNUZ//eFRCpuIS2e94c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1weFd2-0005ih-00; Mon, 29 Jun 2026 19:18:40 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 407A1C0148; Mon, 29 Jun 2026 19:18:30 +0200 (CEST)
Date: Mon, 29 Jun 2026 19:18:30 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: raoxu <raoxu@uniontech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-mips@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: sgi: ioc3-eth: unregister netdev before freeing
 DMA rings
Message-ID: <akKo5i95wiQu6SLY@alpha.franken.de>
References: <40CD736C4911C181+20260629085053.964383-1-raoxu@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40CD736C4911C181+20260629085053.964383-1-raoxu@uniontech.com>

On Mon, Jun 29, 2026 at 04:50:53PM +0800, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> ioc3eth_remove() frees the coherent RX and TX descriptor rings before
> unregistering the netdev. If the interface is running,
> unregister_netdev() invokes ioc3_close() through ndo_stop.
> 
> ioc3_close() stops the device and then calls ioc3_free_rx_bufs() and
> ioc3_clean_tx_ring(). Both cleanup functions access descriptors in the
> rings, so the current ordering causes CPU accesses to freed coherent
> memory. Until ioc3_stop() disables RX and TX DMA, the device may also
> continue using the freed ring addresses.
> 
> Unregister the netdev before releasing the rings. This lets the core
> close a running interface and quiesce the device while the rings are
> still valid. Keep the explicit timer deletion because ndo_stop is not
> called when the interface is already down.
> 
> Fixes: c7b572747549 ("net: sgi: ioc3-eth: allocate space for desc rings only once")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
>  drivers/net/ethernet/sgi/ioc3-eth.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
> index 261f2d35d579..009f37105eaf 100644
> --- a/drivers/net/ethernet/sgi/ioc3-eth.c
> +++ b/drivers/net/ethernet/sgi/ioc3-eth.c
> @@ -967,11 +967,12 @@ static void ioc3eth_remove(struct platform_device *pdev)
>  	struct net_device *dev = platform_get_drvdata(pdev);
>  	struct ioc3_private *ip = netdev_priv(dev);
>  
> +	unregister_netdev(dev);
> +	timer_delete_sync(&ip->ioc3_timer);
> +
>  	dma_free_coherent(ip->dma_dev, RX_RING_SIZE, ip->rxr, ip->rxr_dma);
>  	dma_free_coherent(ip->dma_dev, TX_RING_SIZE + SZ_16K - 1, ip->tx_ring, ip->txr_dma);
>  
> -	unregister_netdev(dev);
> -	timer_delete_sync(&ip->ioc3_timer);
>  	free_netdev(dev);
>  }
>  
> -- 
> 2.50.1

Reviewed-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
