Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C78D368291;
	Mon, 21 Sep 2026 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.215.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984738; cv=none; b=pWnIv4Tm8QG5mn8DOPtzH0qGE7l1ojYjptplnbVpQ10MCfKbxFOTp9ng+C+b/mOh+7j4wpsWpnx9IY3GQF2YY6iQjcb4g2hh6UD5GncNLKeGDdpLUAm5OlA3ydraIegGoxCiRvNjKAoRfsvi2RCN9OiwGJtwvuzAm4d/AEoefkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984738; c=relaxed/simple;
	bh=QuK95/JbafJy3CjmT3UxrGnjkUHW975hSkFBCYS+wHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNxeGqPlZPcay8OxcLimkvwUI0wc8nr6jIk3ASROBiM1SgTKFOsee1CMSe9QNslA5WLr7IO4vkTfhiGK0Nr6jXNcHhU+Ni7apSMEXvhsGHKAeseQvqwCAPGzJwpRZgoAKhfyqVv5JjZ7idp5dMoRvt9QZ3GKclP8IWYFQhXejk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenproject.org; spf=pass smtp.mailfrom=xenproject.org; dkim=pass (1024-bit key) header.d=xenproject.org header.i=@xenproject.org header.b=UBWawS4T; arc=none smtp.client-ip=104.130.215.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenproject.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xenproject.org header.i=@xenproject.org header.b="UBWawS4T"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=xenproject.org; s=20200302mail; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date;
	bh=EzYlQ1oqZU6GvVE+84SeCPxWxElZBzucNgw2Qhmh2Lg=; b=UBWawS4To53/6rURwNJLFQp9nw
	5rTraV0kDPxHAH91XCUw51qaZii5Pdn2b7KgBi4Olfj/V6yOpXuzmKjQcCY7+teP6Wx3rQ/QQW0ID
	K0+c27Hqcg8dtn71ojFKeBy2Ko66ZXhLNstmyA5OKu5M3tLcEJDb6sHYKv77i2Gj6gkc=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.96)
	(envelope-from <roger@xenproject.org>)
	id 1x8aTm-008sVj-1X;
	Mon, 21 Sep 2026 09:38:30 +0000
Received: from 224.pool85-54-217.dynamic.orange.es ([85.54.217.224] helo=localhost)
	by xenbits.xenproject.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <roger@xenproject.org>)
	id 1x8aTm-006IIf-2z;
	Mon, 21 Sep 2026 09:38:30 +0000
Date: Mon, 21 Sep 2026 11:38:28 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger@xenproject.org>
To: Yuchao Zhang <ndaugoing@gmail.com>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] xen-blkfront: unbind irq before tearing down ring
 and shadow requests
Message-ID: <arD7FHmbqJlLHmyE@macbook.local>
References: <20260918114354.3660102-1-ndaugoing@gmail.com>
 <20260918114354.3660102-2-ndaugoing@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260918114354.3660102-2-ndaugoing@gmail.com>

On Fri, Sep 18, 2026 at 07:43:54PM +0800, Yuchao Zhang wrote:
> In blkif_free_ring(), the driver tears down the ring's persistent grants,
> shadow request arrays, and shared ring structure (xenbus_teardown_ring),
> and only calls unbind_from_irqhandler() at the very end.
> 
> While blkif_free_ring() is freeing persistent grants and clearing the
> shadow array, the event channel interrupt (blkif_interrupt) is still
> registered and active.  If an interrupt arrives from the backend during
> this teardown window, blkif_interrupt() reads rinfo->ring.sring and,
> via blkif_completion(), accesses rinfo->shadow[id].grants_used and
> rinfo->shadow[id].sg.  blkif_free_ring() tears these structures down
> without holding rinfo->ring_lock, and the handler only checks
> info->connected at entry, so this is a real race resulting in a
> use-after-free or NULL pointer dereference.
> 
> Fix this by moving unbind_from_irqhandler() to the beginning of
> blkif_free_ring().  Calling unbind_from_irqhandler() first frees the
> IRQ and synchronizes with any in-flight interrupt handlers on other CPUs
> before ring memory and shadow request structures are deallocated,
> matching the teardown order in drivers/net/xen-netfront.c.
> 
> Fixes: 907c3eb18e0b ("xen-blkfront: convert to blk-mq APIs")

Are you sure this is the commit that introduced the issue?  I think
it's:

11659569f720 xen/blkfront: split per device io_lock

The commit that split the lock and removed the usage of
rinfo->ring_lock in the interrupt handler.

> Cc: stable@vger.kernel.org
> Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
> ---
>  drivers/block/xen-blkfront.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index 8dad7bf5f664..e70b78ca4df2 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -1210,6 +1210,10 @@ static void blkif_free_ring(struct blkfront_ring_info *rinfo)
>  	struct blkfront_info *info = rinfo->dev_info;
>  	int i, j, segs;
>  
> +	if (rinfo->irq)
> +		unbind_from_irqhandler(rinfo->irq, rinfo);
> +	rinfo->evtchn = rinfo->irq = 0;

Please add a comment that interrupt teardown must be done ahead of
freeing of queue related data, otherwise the interrupt handler can
race with the cleanup.

Thanks, Roger.
