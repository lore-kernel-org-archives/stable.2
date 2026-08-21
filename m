Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F5042668B
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324175; cv=none; b=pGZuKhDL1fUYm7QhAJL+PVBTbNbtNj6eI5TXXlEqdH5YgT3/WEsF/QEkK6bSGQ93rs7OcGOam5+/dqK7j3OvckhrAvSh8sv4pQQ8+SnlHX78MvPz+nWToHO0tfNztibf4yDAK6Hcw+TOJnY4uozpmnzZQcbElj8fdNeIzM7Ba58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324175; c=relaxed/simple;
	bh=WoI3+0MYrsmkofpBQ8BACEAARxTBIas6F3cSLUKb2DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFKRU+blh/hO3r40GETW5qoz0R3j9Esrd9ehVrb7Vz9HSGUByYRQGtKTpga1HAFNrbL63L7MoKQCxjJpe+2CQ57aAwAddJDE5QB6ZyK0OJGwFSQxmFL2TqBbIaHEFjrvkLPzacbSdF0GhcoVyKEald5lA/qHxHSOHAWXAU4NsWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0uRC0P4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0uRC0P4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1501F000E9;
	Fri, 21 Aug 2026 14:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787324172;
	bh=RhTaW9/NmoyAYVT4VQizYgX9sdot2itK/I65qUFWNe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f0uRC0P4hdkLNc5TrBsqs/fvsbuUWmJuB3QpL7ZiTg3vcpTe/EkeLVL9DotfJpgsq
	 K9ApCLvcXaA8vJgSdgeKMLzaSALfEOd5qxi7kNWX7ypCR3Al0w9jmiUhjhSHNn6ePo
	 2v/xqr/tlIj0c3N4fY+yR3YXVuuZRNh9q41pTTRZmbWSm8goQ0J5e5EPV4ElahTRUz
	 xDDKh6DD+XO4pDSpgSqhMM53Wia4Jy0H00gvii2bRln78Prvggwk7h69Keuw2x+yrM
	 kxjSvmGa3fEw8z7fKu+BnMO74Wxqg5HBoHl59SqZ6wvTnArO+yODYKYi2q2C8IxvjP
	 LK845Lv7b+kRQ==
Date: Fri, 21 Aug 2026 16:56:07 +0200
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
Message-ID: <aohnB2sC2nspmqmH@ryzen>
References: <20260814143833.1953415-2-cassel@kernel.org>
 <20260817061815.154794-1-rihyeon8648@gmail.com>
 <aoMkX_davK7TWlaj@ryzen>
 <aoXLiFruG5s1nKch@kbusch-mbp>
 <aoX2wcyhpakryWHX@ryzen>
 <aocb3ogg34WWtRSB@kbusch-mbp>
 <aohQ9NcuMtSqWvvd@ryzen>
 <aoheN_L3iJNU3Ji6@kbusch-mbp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoheN_L3iJNU3Ji6@kbusch-mbp>

On Fri, Aug 21, 2026 at 08:18:31AM -0600, Keith Busch wrote:
> On Fri, Aug 21, 2026 at 03:21:56PM +0200, Niklas Cassel wrote:
> > On Thu, Aug 20, 2026 at 09:23:10AM -0600, Keith Busch wrote:
> > > On Wed, Aug 19, 2026 at 08:32:33PM +0200, Niklas Cassel wrote:
> > > > 
> > > > I am not following.
> > > > 
> > > > The options is freed in two different places, depending on if the
> > > > ops->create_ctrl(dev, opts) call in fabrics.c:nvmf_create_ctrl() was
> > > > successful or not.
> > > 
> > > Oh, not that path. You mentioned previously that ctrl->ops is
> > > dereferenced in other places. I thought this means we can successfully
> > > add the controller, which means the attributes are visible, but then
> > > fail something else later that causes the opts to free. Since the
> > > attribute was visible, something can open it before the device exporting
> > > is torn down, and access it after the opts were freed.
> > 
> > Sashiko flagged another NULL pointer defererence from the sysfs attributes:
> > 
> > "While the sysfs attributes are still fully accessible, an unprivileged user
> > could concurrently read an attribute like hostnqn, causing a NULL pointer
> > dereference.":
> > https://sashiko.dev/#/patchset/20260811125310.165487-1-rihyeon8648%40gmail.com
> > 
> > This comment was on Rihyeon Kim's patch proposal.
> > 
> > I assume that this is because the fc.c driver (both before and after
> > Rihyeon patch) force set ctrl->ops = NULL before nvme_free_ctrl() was
> > called, so a user reading the sysfs attributes at the same time as the
> > controller was tearing down, could most likely crash the kernel.
> > (Note that neither rdma.c,tcp.c,loop.c does this, so this problem does
> > not exist for them.)
> > 
> > sysfs_remove_link() is called before ctrl->ops->free_ctrl(ctrl);
> 
> When ops->create_ctrl() fails, the opts are freed from
> nvmf_create_ctrl(). We can still fail ops->create_ctrl() after a
> successful nvme_add_ctrl(), so the handle will be visible to user space
> for a moment.
> 
> I think you're relying on nvme_fc_init_ctrl's nvme_put_ctrl() error case
> to be the final reference, but it might not be if the character device
> was created and someone opened it. If so then:
> 
>   out_put_ctrl:
>      nvme_put_ctrl()   -> refcount 1, NOT zero
> 
> So now when nvme_free_ctrl is called sometime after nvmf_create_ctrl()
> freed the opts, the ctrl is pointing to freed memory.

Yes, if someone called open() without calling close() for a long time,
then I agree that refcount will be 1 in at this label, and that
nvme_free_ctrl() will run after nvmf_create_ctrl() freed the opts.

I guess that is how whoever designed nvmf_create_ctrl() implemented things...

AFAICT, this problem is there for rdma.c,tcp.c,loop.c, so it is not a fc.c
specific problem.

The unconditional NULL pointer dereference in nvme_auth_free() was specific
to fc.c, and was solved by this patch.

So while the patch does solve an unconditional fc.c specific NULL pointer
dereference in nvme_auth_free() (if DHCAP is used), it does not solve a
potential NULL pointer dereference that can happen to: rdma.c,tcp.c,loop.c
(+fc.c after my patch) if someone is very quick to grab a reference in the
short window between creation and a failure during creation.

fc.c was not affected by this bug, because of the force setting of ctrl->ops
to NULL.

I still think this patch makes sense, since it brings the fc.c driver in
line with the other fabrics drivers, and avoids the dereference in
nvme_auth_free().

But yes, someone should probably do a follow up series that cleans up the
options handling for all fabrics drivers to solve the problem you just
described. At least the options handling will be uniform after this patch,
so hopefully that cleanup will be easier to implement because of this.


Kind regards,
Niklas
