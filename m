Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4088134F24A;
	Tue, 22 Sep 2026 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.215.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066132; cv=none; b=AmcVBBnupFJ9r9KwnH0h0JoJfxpQY7RBqKm/5kP/Pz0QHvHiETw/pNVYOteMaA8+Tok8s1PvZeg4wA+bEuFhQknI1qzEw6tb8w9p0KvAsF2bJhyyahjRDFtGVMyI2NzyWcGq/nIGvX8FlwG5uFoGeGrudth52o+2RAmtRSeWldI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066132; c=relaxed/simple;
	bh=M95JSYeEcGEbDHbbNJsPV1xAi5baJR/6qeM/ywKJyyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJeMwcxs7wuKgQkKoSiKqeCLv5KJ9hfsTnyG/MaBCtIdF0jrmdUr5q/T4xm9GbfcOT5N2A7EMIdZHTxeM4lh7Eq6RtYA0jXwBwpO6pf5WNH30psm9TkNWvz45vreER2GmY1kk8yMBIsEIH/+xRL92jdQ3LfwcGeQ4WVN/b3T1lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenproject.org; spf=pass smtp.mailfrom=xenproject.org; dkim=pass (1024-bit key) header.d=xenproject.org header.i=@xenproject.org header.b=dc3dEUSs; arc=none smtp.client-ip=104.130.215.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenproject.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xenproject.org header.i=@xenproject.org header.b="dc3dEUSs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=xenproject.org; s=20200302mail; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
	bh=in5miQYTc3LbtSaYzXdTxL0Fg8Xm0nJOMms6+76vWBc=; b=dc3dEUSsMAiLyhZ8Hulk5Iludw
	a1IqcerfvlF8rbrGAMO1ZHwlkGEc8HTyQ9PMLEeJZGYxPQEoVNSzaczEQqV/2T0N9mBwIWO5oMboL
	ne5HW3VXVPbSBhMOOT6abD4yoSCDsZvM5Wj46NvfDSW3owHMAO2xylkUtiW89XR3nK5c=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.96)
	(envelope-from <roger@xenproject.org>)
	id 1x8vyJ-00AiKl-0a;
	Tue, 22 Sep 2026 08:35:27 +0000
Received: from 224.pool85-54-217.dynamic.orange.es ([85.54.217.224] helo=localhost)
	by xenbits.xenproject.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <roger@xenproject.org>)
	id 1x8vyJ-005P5n-1y;
	Tue, 22 Sep 2026 08:35:27 +0000
Date: Tue, 22 Sep 2026 10:35:25 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger@xenproject.org>
To: Yuchao Zhang <ndaugoing@gmail.com>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] xen-blkfront: unbind irq before tearing down ring and
 shadow requests
Message-ID: <arI9zQrvacVVR_Sm@macbook.local>
References: <arD7FHmbqJlLHmyE@macbook.local>
 <20260922072155.34625-1-ndaugoing@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260922072155.34625-1-ndaugoing@gmail.com>

On Tue, Sep 22, 2026 at 03:21:55PM +0800, Yuchao Zhang wrote:
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
> Fixes: 11659569f720 ("xen/blkfront: split per device io_lock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>

Acked-by: Roger Pau Monné <roger@xenproject.org>

Thanks, Roger.
