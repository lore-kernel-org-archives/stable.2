Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F6748CD54
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 13:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787318531; cv=none; b=lLnvlsfJskvCviTZyRUPmly1aqiNzBeDY68KGgi5sBar3LhL2wjTS9SorlkPkPFhlH9B0c0u0EzOq5Mw8z6qF7aZjoP0IWJ7OnrtkDeZrkeQfApUQSRpbyLQiGk2o15ydTMBqmvJyvqKi63smZ/EP0+uTeVZjvkeoCOoHEOFE0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787318531; c=relaxed/simple;
	bh=EvClbgTnvs8sWY2KlA6L4typMqzEiX5/tBFZBYYvbSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrwEDc4WdWih6hRxpGNzvSYs+85DAyWOXMZleFNkHIojGenPb3mewqGhJMXVMSS0I+Bu5a1dZF84ht5XZ9JOytVhYQ/e9gpNP0XqrEPm6E7dKeADTbrIjstIJPa2WB7DnH+x4TpR6VJQ6M6cYyxfI1XXbRXkw3ieBqzApu6x/GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RY619KRc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RY619KRc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4539E1F000E9;
	Fri, 21 Aug 2026 13:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787318522;
	bh=0GDzKsrHgVhSxZzd+pFpFNj20qNgk+pfXZJaooIhNe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RY619KRcLC6fpCuc6d72jrD8/WBTmvGmXXJwKWnv79acxt+7w85JLwyv/rU6xFcNT
	 Y2w8qQS8fqDS0XleD6h+XqyO+Kk8XffY0AUzEFcTiNhDC1/DA55rJa8enmPJsWl7sG
	 1einMkdT1EfpTld8bW1zq37CPhEnQkmAC4CjRcOWST15F+Vemzk7Hu4JFskCRWq/2R
	 U16J5ws/D4GqYwmSzz+kgQfjQM/r4XAZ1q+MTCeque86a+1PI6DGKs0321tCvzQMHI
	 7mEAB4q3C6CSoR+MFWsdEfEXyQmhxSWwAQC5zAng5TcqAyfjW6cMpx/y4oGdu+zcPu
	 H/sSt0t9VY1Hw==
Date: Fri, 21 Aug 2026 15:21:56 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Rihyeon Kim <rihyeon8648@gmail.com>, justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com, paul.ely@broadcom.com,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	stable@vger.kernel.org,
	syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-fc: fix double free of fabrics options when
 nvme_add_ctrl() fails
Message-ID: <aohQ9NcuMtSqWvvd@ryzen>
References: <20260814143833.1953415-2-cassel@kernel.org>
 <20260817061815.154794-1-rihyeon8648@gmail.com>
 <aoMkX_davK7TWlaj@ryzen>
 <aoXLiFruG5s1nKch@kbusch-mbp>
 <aoX2wcyhpakryWHX@ryzen>
 <aocb3ogg34WWtRSB@kbusch-mbp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aocb3ogg34WWtRSB@kbusch-mbp>

On Thu, Aug 20, 2026 at 09:23:10AM -0600, Keith Busch wrote:
> On Wed, Aug 19, 2026 at 08:32:33PM +0200, Niklas Cassel wrote:
> > 
> > I am not following.
> > 
> > The options is freed in two different places, depending on if the
> > ops->create_ctrl(dev, opts) call in fabrics.c:nvmf_create_ctrl() was
> > successful or not.
> 
> Oh, not that path. You mentioned previously that ctrl->ops is
> dereferenced in other places. I thought this means we can successfully
> add the controller, which means the attributes are visible, but then
> fail something else later that causes the opts to free. Since the
> attribute was visible, something can open it before the device exporting
> is torn down, and access it after the opts were freed.

Sashiko flagged another NULL pointer defererence from the sysfs attributes:

"While the sysfs attributes are still fully accessible, an unprivileged user
could concurrently read an attribute like hostnqn, causing a NULL pointer
dereference.":
https://sashiko.dev/#/patchset/20260811125310.165487-1-rihyeon8648%40gmail.com

This comment was on Rihyeon Kim's patch proposal.

I assume that this is because the fc.c driver (both before and after
Rihyeon patch) force set ctrl->ops = NULL before nvme_free_ctrl() was
called, so a user reading the sysfs attributes at the same time as the
controller was tearing down, could most likely crash the kernel.
(Note that neither rdma.c,tcp.c,loop.c does this, so this problem does
not exist for them.)

sysfs_remove_link() is called before ctrl->ops->free_ctrl(ctrl);


My proposal removes the "force set ctrl->ops = NULL", i.e. makes fc.c
look more like rdma.c,tcp.c,loop.c, so AFAICT these NULL pointer
dereferences in the sysfs accessors are no longer possible.

I assume that the sysfs accessors can be accessed until
sysfs_remove_link() has been called, and that they can be accessed
as long as the ctrl object has been created (i.e. the sysfs attributes
do not care if the ctrl object is on the linked list or not).

In both the success case and the failure case, the options are always
freed after sysfs_remove_link().

I hope that explains why we are not accessing freed memory.

Removing the ugly force setting of "ctrl->ops = NULL" that existed in fc.c
(and fc.c only) was a big motivation why I wrote this patch in the first
place.


Kind regards,
Niklas
