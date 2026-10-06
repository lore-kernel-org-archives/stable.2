Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22A943F4A1;
	Tue,  6 Oct 2026 15:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.215.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791300469; cv=none; b=bwDtNPVuaKaDVBHxIkx2yw68DppjfX34mZrmMgII9Tni+Wkt8nx7m8lWfE2fj/9e6zwL4vkAzPwTT2k80ZP8F1AUZrirHoo1DYH6lxoV8olWfkynwBoJMkI6tKtROETptF72GeEtLMXLP8pJWAUsvQoDNguIDvCt5XcHVSy5USM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791300469; c=relaxed/simple;
	bh=DT9PJRUUX2jzV3o99jrs1Sy65/Sy5nT4AjrlADZ+8tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KljYdMhW9oDhzp7AL17jLaTeKY9QgBd34bj/g/LdzqGB85c2JaXJ9ipbJyNaLf8I9MsOg55QDA07wjPqQHYUHclGh+s2V9w7RdfvlYPD1reoUdJENlQjK1BfkrJvFPDPxpfcypjpttip4Jb5PbpTm1YKhKSNPWSW7UHNW0+M6LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenproject.org; spf=pass smtp.mailfrom=xenproject.org; dkim=pass (1024-bit key) header.d=xenproject.org header.i=@xenproject.org header.b=JUXUDo85; arc=none smtp.client-ip=104.130.215.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenproject.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xenproject.org header.i=@xenproject.org header.b="JUXUDo85"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=xenproject.org; s=20200302mail; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
	bh=Ie2ZuA+zUDzrYyXAVifosA8UkUH/9FbQDmI/rKOzWQw=; b=JUXUDo85sKoG9EOuxY58dn7QFs
	+MByEMV6ya3WTWlJcYGXidN5QDhX/scp1sFF929ojdTAzP9L3TTx3Bhl4gm5PhJdjqSO4lPaEXyr5
	oDYQ2aWrGKlLL7zv7a0fC1Yrrj/zaICChmsVt8c2y90cn9XvRBDTrUD8ECu8y/TVIkyk=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.96)
	(envelope-from <roger@xenproject.org>)
	id 1xE74x-0005nl-0N;
	Tue, 06 Oct 2026 15:27:43 +0000
Received: from 224.pool85-54-217.dynamic.orange.es ([85.54.217.224] helo=localhost)
	by xenbits.xenproject.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <roger@xenproject.org>)
	id 1xE74v-00DM6h-34;
	Tue, 06 Oct 2026 15:27:42 +0000
Date: Tue, 6 Oct 2026 17:27:39 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger@xenproject.org>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org
Subject: Re: [PATCH] xen-blkfront: Fix IO race during unplug
Message-ID: <asUTa3lIC0gkNAJB@Mac.lan>
References: <20261006135807.2571779-1-ross.lagerwall@citrix.com>
 <asUCYtIJkFchdbNH@Mac.lan>
 <cf503bba-9f46-4cf6-9c42-710d0ffe4120@citrix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf503bba-9f46-4cf6-9c42-710d0ffe4120@citrix.com>

On Tue, Oct 06, 2026 at 03:43:44PM +0100, Ross Lagerwall wrote:
> On 10/6/26 3:14 PM, Roger Pau Monné wrote:
> > On Tue, Oct 06, 2026 at 02:58:06PM +0100, Ross Lagerwall wrote:
> > > During unplug, blkfront stops the hw queues and marks the disk as dead,
> > > then later during removal calls del_gendisk(). However, IO issued after
> > > the hw queues are stopped but before the call to del_gendisk() will be
> > > queued but never handled. This causes del_gendisk() to hang forever
> > > waiting for the queue refcount to drop to zero.
> > > 
> > > This can be reproduced by issuing IO during an artificial delay after
> > > stopping the hw queues.
> > 
> > So the window is between the blk_mq_stop_hw_queues() and
> > blk_mark_disk_dead() calls where requests would be queued and never
> > processed?
> 
> Yes.
> 
> > 
> > > Fix this by simply not stopping the hw queues directly. Marking the disk
> > > as dead also freezes the queue which prevents new requests being added
> > > and it synchronously runs the hw queues to clear anything pending.
> > 
> > I think this likely needs expanding a bit: the disk is already marked
> > as dead with the current logic, and in the same place in the code.
> > 
> > > Fixes: 8e141f9eb803 ("block: drain file system I/O on del_gendisk")
> > > Cc: stable@vger.kernel.org
> > > Assisted-by: LLM
> > > Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> > > ---
> > > 
> > > I'm not sure about the Fixes tag. It's the most likely looking candidate
> > > to me but I didn't confirm whether it actually introduced the
> > > regression.
> > 
> > I was wondering the same, and even then someone might argue this was a
> > latent bug in blkfront itself, and the reference commit just exposed
> > it.  I don't have a strong opinion.
> 
> Good point, I might be inclined to drop it then.
> 
> > 
> > > 
> > >   drivers/block/xen-blkfront.c | 4 +---
> > >   1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> > > index 8dad7bf5f664..69a2315a1b20 100644
> > > --- a/drivers/block/xen-blkfront.c
> > > +++ b/drivers/block/xen-blkfront.c
> > > @@ -2138,10 +2138,8 @@ static void blkfront_closing(struct blkfront_info *info)
> > >   		return;
> > >   	/* No more blkif_request(). */
> > > -	if (info->rq && info->gd) {
> > > -		blk_mq_stop_hw_queues(info->rq);
> > > +	if (info->gd)
> > >   		blk_mark_disk_dead(info->gd);
> > 
> > So blk_mark_disk_dead() behaves differently when called with the
> > queues still active?
> 
> Yes. In both cases, the queues are frozen and the hw queues synchronously run,
> but the latter is a no-op when the hw queues are in the stopped state,
> therefore it could leave requests unprocessed.
> 
> How about this for the final paragraph of the commit message?
> 
> """
> Fix this by simply not stopping the hw queues directly. Marking the disk
> as dead already freezes the queue which prevents new requests being added
> and it synchronously runs the hw queues to clear anything pending. If the hw
> queues are stopped when calling blk_mark_disk_dead(), running the hw queues
> is a no-op and can leave queued requests unprocessed.
> """

LGTM.

I think it might be best if you send v2 with that adjustment and the
Fixes tag possibly dropped.

Thanks, Roger.
