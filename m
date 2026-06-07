Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4141A2E6CC0;
	Sun,  7 Jun 2026 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780819371; cv=none; b=aM9f5zf2lSSMeTDVbNBm7ByoRri5zk8l7ukjK5nsl2rvNTtqQ0A0M/L3lARVoIkeUOMdGC9W9u7n+ettAmN6qy15WXQ3wEAeQau1W3vsFSk+ME0E5fqGP5qOaQ8vqkogP9FJgNenjztq8m5uPbwuRmKnqW3ozs3ch7qqvAJiFmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780819371; c=relaxed/simple;
	bh=fK33aw+FsNr4Lb4q2rl/jIj5PcYXk9p91/x81Ou+R/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yfe9wYALfRbA1BMOzCD9aKRD/+pgaYd1iMXfZ/QsNMUuomMV7MG3K30w5D+PkHorXhIMXiiFABTtXFJ1ezIbskJ0b4WFa285ecicE2xh/xkjRckjXx5Hpmd8tVWTgOBQTj15v1pIDakS5FiYWrCDDIyFuu5Cs2gaXAIjvdyGp+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aE1SY8r9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aE1SY8r9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A9B1F00893;
	Sun,  7 Jun 2026 08:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780819369;
	bh=743mquA8eUU6nXfjkJF2bDmypYOyMCpDQhfZo28zoc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aE1SY8r9jkNr36mu/YYJAsW8bfiM7zw1BjgwI5hH9xzAqeIuvpxF5a5xHVcykvRhE
	 5rv4zb7l0fL/AVhPq95kRC309GpG2LYn9Tk0LfK0EftcbiMuP0mz7jwTgGkVUiskib
	 FsdBfriQjkjAOSaoOuF08eSIjgEI606M97YlP4uHMmQ2uHpzNScMRGEPVja8VRAJvY
	 PNxXin2R+XTuVfb00frIhDpIHsfV00jTfMFLAAGOUorTUFWPoAM25MVttHHa4l78o7
	 2BvhsE3Q4tELG3Xi5Wreq/lCyzxgWM6T3E3A4pyK+yA89GXQXm4j8JddNoJQxLgi0i
	 ymCQKza5mtMTA==
Date: Sun, 7 Jun 2026 11:02:44 +0300
From: Leon Romanovsky <leon@kernel.org>
To: David Hu <xuehaohu@google.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	jmoroni@google.com, praan@google.com, stable@vger.kernel.org
Subject: Re: [PATCH v5] dma-buf: Fix silent overflow for phys vec to sgt
Message-ID: <20260607080244.GA327369@unreal>
References: <20260601200012.3872274-1-xuehaohu@google.com>
 <20260604094344.GB245424@unreal>
 <CAPd9Lg_JkRdtNa=n+HE9SP+NFCSB+X_97eiPBqiONVLwV0pHwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPd9Lg_JkRdtNa=n+HE9SP+NFCSB+X_97eiPBqiONVLwV0pHwQ@mail.gmail.com>

On Thu, Jun 04, 2026 at 03:36:48PM -0400, David Hu wrote:
> On Thu, Jun 4, 2026 at 5:43 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Mon, Jun 01, 2026 at 08:00:12PM +0000, David Hu wrote:
> > > @@ -36,7 +36,7 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
> > >                                 struct phys_vec *phys_vec, size_t nr_ranges,
> > >                                 size_t size)
> > >  {
> > > -     unsigned int nents = 0;
> > > +     size_t nents = 0;
> > >       size_t i;
> > >
> > >       if (!state || !dma_use_iova(state)) {
> > > @@ -51,6 +51,9 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
> > >               nents = DIV_ROUND_UP(size, UINT_MAX);
> > >       }
> > >
> > > +     if (nents > UINT_MAX)
> >
> > I would suggest to use check_add_overflow() while calculating nents
> > instead of this check.
> 
> Hi Leon,
> 
> Thank you for the review. Using `check_add_overflow()` is a great
> suggestion and definitely
> cleaner for the accumulation loop. I'll update this for v6.
> 
> > > @@ -133,6 +137,11 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
> > >       }
> > >
> > >       nents = calc_sg_nents(dma->state, phys_vec, nr_ranges, size);
> > > +     if (!nents) {
> > > +             ret = -EINVAL;
> > > +             goto err_free_state;
> > > +     }
> >
> > Technically, this hunk is not necessary, since sg_alloc_table() will
> > return -EINVAL when nents == 0. At least, that is the behavior I relied on.
> 
> I originally added this explicit check in v5 to address Jason's
> feedback, and to make the
> failure explicit rather than relying on `sg_alloc_table()` failing
> silently on `nents=0`.

I prefer explicit checks, but I am not in favor of duplicating them.
Since sg_alloc_table() already validates this condition, we do not need
to repeat the same check in dma-buf. A comment should be sufficient to
inform future reviewers that nents == 0 is already handled.

Thanks

> 
> Jason, do you have a strong preference here? I am happy to drop the
> hunk and rely on
> `sg_alloc_table()` returning `-EINVAL` if you are both comfortable with that.
> 
> Thanks,
> David
