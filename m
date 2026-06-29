Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE7C374E63;
	Mon, 29 Jun 2026 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754792; cv=none; b=Mq+5VJQkfXqTc0Z6TFXRb6VsTLm2X4wyEXQA79iFmddbT1iNQM5oKNnc1eCvxdwaujO6cdmxhUlnaMbJ0+GPHHXIC2B5CcW2Aryj78QD9xcjOnPlibdDhyG30QrOxumbv5ppr+KpVQFLl201MRgcaAmriAmBeOK3mRkSIh7qZ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754792; c=relaxed/simple;
	bh=Ej3rdP+msPj7ZdoJHeG5VaheOUmHRQHs9VfwmJSIK/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mb0fuyFZDEjv49AU1MM8na9oIPQrfmOKtohhmQ7zMPTLvbH6U2b0jyV+vd2S07E0+DsKE50P6Hw9ZjABF4KpBDugz7l6fMVyEg4+CoTTZRkJa2Se84Uoul3eGbzr2dyeakaw2QzdcYtt/GGOXtbWniiNehQGeQSBk1CWeYjmDUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1weFd2-0005id-00; Mon, 29 Jun 2026 19:18:40 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 94EDFC013E; Mon, 29 Jun 2026 19:16:51 +0200 (CEST)
Date: Mon, 29 Jun 2026 19:16:51 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: raoxu <raoxu@uniontech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-mips@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: sgi: ioc3-eth: fix split TX DMA mapping lengths
Message-ID: <akKog7-ppsYUs7z0@alpha.franken.de>
References: <4E1486BC4536407E+20260629080623.908426-1-raoxu@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E1486BC4536407E+20260629080623.908426-1-raoxu@uniontech.com>

On Mon, Jun 29, 2026 at 04:06:23PM +0800, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> When a linear skb crosses a 16 KiB boundary, ioc3_start_xmit()
> splits it into two buffers of lengths s1 and s2.  The descriptor
> advertises those lengths through B1CNT and B2CNT.
> 
> The first buffer is mapped with s1, but the second buffer is also
> mapped with s1 even though the device is told to fetch s2 bytes from
> it.  When the lengths differ, the DMA mapping does not cover the same
> region as the second descriptor buffer, which can result in incorrect
> cache maintenance or a DMA fault on implementations that enforce the
> mapped range.
> 
> There is a separate mismatch in the error path.  If mapping the second
> buffer fails, only d1 needs to be unmapped.  d1 was mapped for s1 bytes,
> but the driver unmaps it using the full packet length.  Streaming DMA
> mappings must be unmapped with the same size used for the corresponding
> map operation.
> 
> Map the second buffer with s2 and unmap the first buffer with s1 when
> the second mapping fails.
> 
> Fixes: ed870f6a7aa2 ("net: sgi: ioc3-eth: use dma-direct for dma allocations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
>  drivers/net/ethernet/sgi/ioc3-eth.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
> index 3973106..261f2d3 100644
> --- a/drivers/net/ethernet/sgi/ioc3-eth.c
> +++ b/drivers/net/ethernet/sgi/ioc3-eth.c
> @@ -1061,9 +1061,9 @@ static netdev_tx_t ioc3_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  		d1 = dma_map_single(ip->dma_dev, skb->data, s1, DMA_TO_DEVICE);
>  		if (dma_mapping_error(ip->dma_dev, d1))
>  			goto drop_packet;
> -		d2 = dma_map_single(ip->dma_dev, (void *)b2, s1, DMA_TO_DEVICE);
> +		d2 = dma_map_single(ip->dma_dev, (void *)b2, s2, DMA_TO_DEVICE);
>  		if (dma_mapping_error(ip->dma_dev, d2)) {
> -			dma_unmap_single(ip->dma_dev, d1, len, DMA_TO_DEVICE);
> +			dma_unmap_single(ip->dma_dev, d1, s1, DMA_TO_DEVICE);
>  			goto drop_packet;
>  		}
>  		desc->p1     = cpu_to_be64(ioc3_map(d1, PCI64_ATTR_PREF));
> -- 
> 2.47.3

Reviewed-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
