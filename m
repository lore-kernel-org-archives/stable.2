Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4CA429822
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414190; cv=none; b=JQzGnKBaFfy6o35lm6oCno/l4EMg6OoVjK7CIkVJ63LV961HpTxco9Gb4ip2QPhyAmscz30MFHZPHKx/srQ4vN2o7Cxxr2bTvC3wz7spWnrlcMkgOx8A8g28JAAE7nfoYkAgtKiHTatWNuZueFpkEs3S+6BEIjSVzPy93bPJY6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414190; c=relaxed/simple;
	bh=e3War6f8bJRUUUF5BJjSJxtrt/9ASylxkqZ/Gbde7m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrvSxHlo6otkceDQ1SfcokG+rv+gU+yzzFfjPQOmd27FbBFfhwwV5WTQs2VtngqSuMK15WyxAoCHLNhtcHwZ2vt8EvflXySfW/Iaf2frQvpn9kEsDJLjWDocwCou65Rf7yBveE8841oXhLk78Uu5PQrrmvOwzByEUIT/fooBbsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=daeZ4Jyd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jxUVk0rA; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="daeZ4Jyd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jxUVk0rA"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F10C97A002E;
	Thu, 30 Jul 2026 08:23:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 30 Jul 2026 08:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785414186; x=1785500586; bh=Rxm+5YhJv4
	CdESaI4o1g9SD8cnd/akaak9VO7gWP4cA=; b=daeZ4JydMmUc2uE2kIAnJ9qVY8
	WlaY+0jla/kdGxkglO4BtEKIG8F5fgQLnyqfokdLEZJJXsx5d+2VkHgzGMhsWv6D
	8vGchJaFJyZ7GLtzapbt32JuOWd0IzvIfKmEs2rSvVzHmf0iMNxmTQQB38/Akq/J
	JhyHzYCul+1gDHMJr7t8wCwLO7xAKrfNOCpjhFeIZMRfBbQqLUqCnKdm3YAFCf2g
	ltP9bIRbt1KZ6IorbbbU47OLMNFwSf5SOVV3bX0+J4YPp6StZFZFK+W0k14HOpHy
	m8liwmPDErSMxhbT9mcNNy3bDwOMDKjJOU+ohWwSLBWxFVfyJx3quzBJhFUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785414186; x=1785500586; bh=Rxm+5YhJv4CdESaI4o1g9SD8cnd/akaak9V
	O7gWP4cA=; b=jxUVk0rA2KbvC8nBny/nvXvRNbyPr8Gzr1kD4T1AGor/xVJco8I
	EDq3oBz+owsCQlQZBAA0i7mUfSgNrM1Z0909DW/1hhiWR0rK0Mp8oT9DFJY6u8By
	c+VnRUXiPOhg8rtXQXnTjebfhQxvChDs0JuLUG8kkwVFReX+9h+3VNoAWIND6Lap
	7QgBAQR4fHAwXkWNsVJj7W6J0sCv7VvFrOqA5aTA3+igdcdAN4a9gA61RH7mQYsf
	i2C/f/wi6P0//B4Cx6oV0swuhf5BFwkf4I9UrveH7+0FkzQy1tPZ6YJmYIxKOarS
	k6WJcjJmBqd/MczNnvt4+9pxpkscYXBIrEw==
X-ME-Sender: <xms:KkJratgInRMIMFiNLGpqWpNG3tuJYIBc0FkNEYDKfiN_devH8mVAig>
    <xme:KkJralHVYxfXwbpYflnp9bsWuTB-J_e-1KBj2LTWRHa3j6mcIwCv2L7CljAZ0fBO-
    nKwHdEMu_TdQEKxoPAJ32qXTVQTXxsRgTVrOo6jEnH43SbefA>
X-ME-Received: <xmr:KkJrantx8ue0ZZRtW7c7s4SBYFQ6YC0swYbUSW9XUx-MbwVEUIPMAqeeVBlSyPfpDgFlA6Vtsn9taFr2PtCw0bRg4n5GOMjcPjHpOj_V-1o>
X-ME-Proxy-Cause: dmFkZTFSr/Ii0IbhOaFbI70eaD1gCpkPY08rBbvlZQUCDyeKRL1tKiithINw+EG+qPftBy
    1bC+taJdw58xV7I8zMokXydbyMeZQvpLGU063/LZ8YtImVPgfq0pCwJqvMaGfoKkwdwDle
    SCRDeNGDviR+QvNCcsc5GY5YIxS3MkpVWuaht/coIOgkAgVsIPKNpkRFmE/E0uprAKFM6M
    jr513YQGR+TBtUudbwCYuywZP+GzThulvyX+rDPPCSXIA0//J6deSwalC/0CkeINhYDsUp
    4zpsu2vk7fsDnvkxL6YzSraL6cznhgGx1cn7ZzXzqFk5lC3+EGS7WUVxaL8UdlBz2Hbeko
    O+VQiyBzA7tupb46jpls+iTYpQTS/dubtI6Hb2A27VQuX3TJXDUfbK9N+bEUko+Rh91Uyw
    IR89aF85XDSHfJ/WdUdKvXTdmaxSEnKmWRvRSuUJVfJDgUuXI9ImA0nR6EQFUHWyQYryqn
    ArjRghbS3wgyk2SS9cporvt51VUB60GwTwADc/EsRiU+nxPk7nrdt0RlfXL/IO8UgkaDXB
    OLZWCKCTeWbfEIE3JVGxK274L61xQeEPuWtjTU4ezUG7jXGZNfEKDLQyy+1ZypYRFt8hgO
    MeKHCHtjzlFTpEug+iapfR4nRNxdAFurW+QiRz/e8PR7SsUTLoUCeTm6+D2Q
X-ME-Proxy: <xmx:KkJraudKlbSFUemb2XvzY6iUVv0BF1miFoAAsU4Lz5EPGfeUDsmoNQ>
    <xmx:KkJralnXkPfXez2tfvZ6EhS7dAwGJ7eYLemOtngM8ksAiNMEAzHvyA>
    <xmx:KkJrapC3owB8hsEbf8KhHYZoYZTwMQNmSjGDNvfeiNL8iqxYjswkXQ>
    <xmx:KkJranNK2_5EFfcxgWeiHwbOwDobmyPXnfNay6JzrvZFn0zkga8gZg>
    <xmx:KkJraorXZYEAjkb5YuOJ2IwcTYyjlJuJ65HJBpQ_uVOdJXE3ej9sf07K>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 08:23:06 -0400 (EDT)
Date: Thu, 30 Jul 2026 14:22:53 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.18.y 2/2] net: mana: Sync page pool RX frags for CPU
Message-ID: <2026073048-curled-prison-0ebe@gregkh>
References: <2026072020-cathedral-preoccupy-0b9c@gregkh>
 <20260728121110.3702926-1-sashal@kernel.org>
 <20260728121110.3702926-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728121110.3702926-2-sashal@kernel.org>

On Tue, Jul 28, 2026 at 08:11:10AM -0400, Sasha Levin wrote:
> From: Dexuan Cui <decui@microsoft.com>
> 
> [ Upstream commit c72a0f09c57f92113df69f9b902d11c9e4b132f5 ]
> 
> MANA allocates RX buffers from page pool fragments when frag_count is
> greater than 1. In that case the buffers remain DMA mapped by page pool
> and the RX completion path does not call dma_unmap_single(). As a result,
> the implicit sync-for-CPU normally performed by dma_unmap_single() is
> missing before the packet data is passed to the networking stack.
> 
> This breaks RX on configurations which require explicit DMA syncing, for
> example when booted with swiotlb=force.
> 
> Fix this by recording the page pool page and DMA sync offset when the RX
> buffer is allocated, and syncing the received packet range for CPU access
> before handing the RX buffer to the stack.
> 
> Fixes: 730ff06d3f5c ("net: mana: Use page pool fragments for RX buffers instead of full pages to improve memory efficiency.")
> Cc: stable@vger.kernel.org
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Link: https://patch.msgid.link/20260702041237.617719-3-decui@microsoft.com
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 40 +++++++++++++++----
>  include/net/mana/mana.h                       |  8 ++++
>  2 files changed, 41 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index cbeb04ee727275..effee6c56c919d 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -2036,12 +2036,16 @@ static void mana_rx_skb(void *buf_va, bool from_pool,
>  }
>  
>  static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
> -			     dma_addr_t *da, bool *from_pool)
> +			     dma_addr_t *da, bool *from_pool,
> +			     struct page **pp_page, u32 *dma_sync_offset)
>  {
>  	struct page *page;
>  	u32 offset;
>  	void *va;
> +
>  	*from_pool = false;
> +	*pp_page = NULL;
> +	*dma_sync_offset = 0;
>  
>  	/* Don't use fragments for jumbo frames or XDP where it's 1 fragment
>  	 * per page.
> @@ -2079,31 +2083,47 @@ static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
>  	va  = page_to_virt(page) + offset;
>  	*da = page_pool_get_dma_addr(page) + offset + rxq->headroom;
>  	*from_pool = true;
> +	*pp_page = page;
> +	*dma_sync_offset = offset + rxq->headroom;
>  
>  	return va;
>  }
>  
>  /* Allocate frag for rx buffer, and save the old buf */
>  static void mana_refill_rx_oob(struct device *dev, struct mana_rxq *rxq,
> -			       struct mana_recv_buf_oob *rxoob, void **old_buf,
> -			       bool *old_fp)
> +			       struct mana_recv_buf_oob *rxoob, u32 pktlen,
> +			       void **old_buf, bool *old_fp)
>  {
> +	struct page *pp_page;
> +	u32 dma_sync_offset;
>  	bool from_pool;
>  	dma_addr_t da;
>  	void *va;
>  
> -	va = mana_get_rxfrag(rxq, dev, &da, &from_pool);
> +	va = mana_get_rxfrag(rxq, dev, &da, &from_pool, &pp_page,
> +			     &dma_sync_offset);
>  	if (!va)
>  		return;
> -	if (!rxoob->from_pool || rxq->frag_count == 1)
> +	if (!rxoob->from_pool || rxq->frag_count == 1) {
>  		dma_unmap_single(dev, rxoob->sgl[0].address, rxq->datasize,
>  				 DMA_FROM_DEVICE);
> +	} else {
> +		/* The page pool maps the whole page and only syncs for device
> +		 * automatically (PP_FLAG_DMA_SYNC_DEV). Sync the received bytes
> +		 * for the CPU before they are read: this is required if DMA
> +		 * is incoherent or bounce buffers are used.
> +		 */
> +		page_pool_dma_sync_for_cpu(rxq->page_pool, rxoob->pp_page,
> +					   rxoob->dma_sync_offset, pktlen);
> +	}
>  	*old_buf = rxoob->buf_va;
>  	*old_fp = rxoob->from_pool;
>  
>  	rxoob->buf_va = va;
>  	rxoob->sgl[0].address = da;
>  	rxoob->from_pool = from_pool;
> +	rxoob->pp_page = pp_page;
> +	rxoob->dma_sync_offset = dma_sync_offset;
>  }
>  
>  static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
> @@ -2172,7 +2192,8 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
>  		/* Reuse the RX buffer since rxbuf_oob is unchanged. */
>  	} else {
>  
> -		mana_refill_rx_oob(dev, rxq, rxbuf_oob, &old_buf, &old_fp);
> +		mana_refill_rx_oob(dev, rxq, rxbuf_oob, pktlen,
> +				   &old_buf, &old_fp);
>  
>  		/* Unsuccessful refill will have old_buf == NULL.
>  		 * In this case, mana_rx_skb() will drop the packet.
> @@ -2548,6 +2569,8 @@ static int mana_fill_rx_oob(struct mana_recv_buf_oob *rx_oob, u32 mem_key,
>  			    struct mana_rxq *rxq, struct device *dev)
>  {
>  	struct mana_port_context *mpc = netdev_priv(rxq->ndev);
> +	struct page *pp_page = NULL;
> +	u32 dma_sync_offset = 0;
>  	bool from_pool = false;
>  	dma_addr_t da;
>  	void *va;
> @@ -2555,13 +2578,16 @@ static int mana_fill_rx_oob(struct mana_recv_buf_oob *rx_oob, u32 mem_key,
>  	if (mpc->rxbufs_pre)
>  		va = mana_get_rxbuf_pre(rxq, &da);
>  	else
> -		va = mana_get_rxfrag(rxq, dev, &da, &from_pool);
> +		va = mana_get_rxfrag(rxq, dev, &da, &from_pool, &pp_page,
> +				     &dma_sync_offset);
>  
>  	if (!va)
>  		return -ENOMEM;
>  
>  	rx_oob->buf_va = va;
>  	rx_oob->from_pool = from_pool;
> +	rx_oob->pp_page = pp_page;
> +	rx_oob->dma_sync_offset = dma_sync_offset;
>  
>  	rx_oob->sgl[0].address = da;
>  	rx_oob->sgl[0].size = rxq->datasize;
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index e199f1d44c8e30..a134b123527971 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -302,6 +302,14 @@ struct mana_recv_buf_oob {
>  
>  	void *buf_va;
>  	bool from_pool; /* allocated from a page pool */
> +	/* head page of the page_pool fragment; valid only when
> +	 * from_pool && frag_count > 1.
> +	 */
> +	struct page *pp_page;
> +	/* Fragment offset plus rxq->headroom, passed to
> +	 * page_pool_dma_sync_for_cpu().
> +	 */
> +	u32 dma_sync_offset;
>  
>  	/* SGL of the buffer going to be sent as part of the work request. */
>  	u32 num_sge;
> -- 
> 2.53.0
> 
> 

Does not apply :(
