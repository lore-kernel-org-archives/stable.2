Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5987549504C
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321914; cv=none; b=dUcOG6xkgJHcFMNekTm1j56X0T5VnCklk2Qc5RnUeW9oqKzZe/3AhB2aahllKdE1CQmtMZaAB+PIWKnsYZJAcVYzBoPvOEwgJFVHi/3/L1hO7PD6E9znCqJmEL/BbCeTX2xBxr77feVxkzLS/zTUtD6BklkA/te7UzQQJVXlikI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321914; c=relaxed/simple;
	bh=kuE5wHqmj6GOLWHIHEmKzZ7YSrFW5wJhRRCjG/7Zwa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqPVXAeNze7uzaEFskO1CMnD4ogzRO2eLn/Oa51vZRxiZDUyIaRv7N+YiK02rgtRG2wsfjcZPOE8gEhIdC+Qib3AkKd+F+wxbHVjMFdlzc3V3SIWzTDfMkIKHLpUMhoCltq/zycmx6Mv1lFpxt8QmkbJGzbtTv4z1iCmLejQjIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLR7P3NE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLR7P3NE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8609C1F00A3A;
	Fri, 21 Aug 2026 14:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787321913;
	bh=HG+w1DQEAVcs6RiLkfNA1By0YIoXNNBrKRdrWn3H1rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FLR7P3NE9e38Czh6gi34d1veREoMQmlBIPdtdouKQYQUx+WqafNraXXAIU7/BxNej
	 aKlnffpXnGnPFVhF5QR7o86ftpU2bO6uICVQH37f/uYNbWvz9EhEhNvIcjlVb3IIHf
	 syXEN7iesUYvFvrf2y/5zD5FwGIV3nkowLSJX5Pf4k+53efy+7G+JnxiwgTWf+JIth
	 wYS5a2ZTUQ+jjiyGb59uFd6+7VE7ZSId42+xCGVvezCHXjBv9ryzDS0c2Kuz0xrevt
	 A+mopIUl3nq3kFaLhRausf6RkYn5ea9Gez59iOpt8sqnPHE8uG5OTCvOBGbZUzl1mO
	 MTTeooBUlVA2w==
Date: Fri, 21 Aug 2026 08:18:31 -0600
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Rihyeon Kim <rihyeon8648@gmail.com>, justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com, paul.ely@broadcom.com,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	stable@vger.kernel.org,
	syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-fc: fix double free of fabrics options when
 nvme_add_ctrl() fails
Message-ID: <aoheN_L3iJNU3Ji6@kbusch-mbp>
References: <20260814143833.1953415-2-cassel@kernel.org>
 <20260817061815.154794-1-rihyeon8648@gmail.com>
 <aoMkX_davK7TWlaj@ryzen>
 <aoXLiFruG5s1nKch@kbusch-mbp>
 <aoX2wcyhpakryWHX@ryzen>
 <aocb3ogg34WWtRSB@kbusch-mbp>
 <aohQ9NcuMtSqWvvd@ryzen>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aohQ9NcuMtSqWvvd@ryzen>

On Fri, Aug 21, 2026 at 03:21:56PM +0200, Niklas Cassel wrote:
> On Thu, Aug 20, 2026 at 09:23:10AM -0600, Keith Busch wrote:
> > On Wed, Aug 19, 2026 at 08:32:33PM +0200, Niklas Cassel wrote:
> > > 
> > > I am not following.
> > > 
> > > The options is freed in two different places, depending on if the
> > > ops->create_ctrl(dev, opts) call in fabrics.c:nvmf_create_ctrl() was
> > > successful or not.
> > 
> > Oh, not that path. You mentioned previously that ctrl->ops is
> > dereferenced in other places. I thought this means we can successfully
> > add the controller, which means the attributes are visible, but then
> > fail something else later that causes the opts to free. Since the
> > attribute was visible, something can open it before the device exporting
> > is torn down, and access it after the opts were freed.
> 
> Sashiko flagged another NULL pointer defererence from the sysfs attributes:
> 
> "While the sysfs attributes are still fully accessible, an unprivileged user
> could concurrently read an attribute like hostnqn, causing a NULL pointer
> dereference.":
> https://sashiko.dev/#/patchset/20260811125310.165487-1-rihyeon8648%40gmail.com
> 
> This comment was on Rihyeon Kim's patch proposal.
> 
> I assume that this is because the fc.c driver (both before and after
> Rihyeon patch) force set ctrl->ops = NULL before nvme_free_ctrl() was
> called, so a user reading the sysfs attributes at the same time as the
> controller was tearing down, could most likely crash the kernel.
> (Note that neither rdma.c,tcp.c,loop.c does this, so this problem does
> not exist for them.)
> 
> sysfs_remove_link() is called before ctrl->ops->free_ctrl(ctrl);

When ops->create_ctrl() fails, the opts are freed from
nvmf_create_ctrl(). We can still fail ops->create_ctrl() after a
successful nvme_add_ctrl(), so the handle will be visible to user space
for a moment.

I think you're relying on nvme_fc_init_ctrl's nvme_put_ctrl() error case
to be the final reference, but it might not be if the character device
was created and someone opened it. If so then:

  out_put_ctrl:
     nvme_put_ctrl()   -> refcount 1, NOT zero

So now when nvme_free_ctrl is called sometime after nvmf_create_ctrl()
freed the opts, the ctrl is pointing to freed memory.
