Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7831E36DA18
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780904371; cv=none; b=b99LYiWDh4glfvb5s06KbX4rp0+d54bf9F16YuRcfCd9DdRGwUEbzN/ZTBClniDRVaAkpXhFE0wG4GvvLTiDvpAaPZHnYYE6zYplmsw8x8zEiUQY71nHgppDJ1uCXfllLruj0BJRyENsy9kmh0ddGiy51oTWSwYtziK+Jk5jfeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780904371; c=relaxed/simple;
	bh=nFKxW/qtl7yhuPt+grGViKxl8VAxsXln0eHX2/n/BVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGcYnFTnvAEqU6nGMFQ8+3km5UPbnoSftMa0NF5GkIUsp2WINBEaSOdqYZNNa6cySQP1qn9PnJBg1iw6y19oKVADAPthz5n9B1jehDZnD8PRhpJdJTdM5gwykWRRtinrhrqcl0Kz+x3xItWBRwvBgSQNCuDEPpNXnbZcQgsLDyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGh7LVGJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGh7LVGJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284821F00893;
	Mon,  8 Jun 2026 07:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780904370;
	bh=NYh8KuqEUu0JK+R3KQ8Rhk6toVIwY1C2mbsdyr4CS/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oGh7LVGJYhPCfeTrhq2DtwlQMeqfAF3Kg9RP+bj6vG5Tl2425DZUhP4CAn1fhysFV
	 PCUWjenPmWexnmzBgC3X91uom8b41zIWdsz6r7qKyAEvO7xStw6cRdT8dOnAwDMR/7
	 VwF1uDFyBZMqV4kYIxeTH7m/QnjVlSVkfk8e5RdPSMbB/7uuE4ySPuVZWqZ+Uzf8+L
	 9oaQUAIPU3WumotCN6ZpvMdUTTpPkSjCbHCqbLshGHCe5oVu3ipY6Sm5jXWpQdF74f
	 w228wDrlJtMQJI8jvltCr8EBES2YNtcKZpY/9556eb1QEQciYq+xmhPTyteeewpU3e
	 c/Xz/5n0P1+qA==
Date: Mon, 8 Jun 2026 09:39:24 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH 1/2] xfs: pass back updated nb from
 xfs_growfs_compute_deltas
Message-ID: <aiZxJBlK4hmF7Owg@nidhogg.toxiclabs.cc>
References: <20260605083121.290326-1-hch@lst.de>
 <20260605083121.290326-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605083121.290326-2-hch@lst.de>

On Fri, Jun 05, 2026 at 10:31:11AM +0200, Christoph Hellwig wrote:
> xfs_growfs_compute_deltas can update nb for corner cases like a number
> of blocks that would create a less the minimal sized AG, or running
> past the max AG limit.  Pass back the calculated value to the caller,
> as it relies on to calculate the new numeber of perag structures.

'number' (will fix it at commit time).


> 
> Note that the grown file system size is not affected by this
> miscaculation as it uses the passed back delta value.
> 
> Fixes: a49b7ff63f98 ("xfs: Refactoring the nagcount and delta calculation")
> Cc: <stable@vger.kernel.org> # v7.0
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> ---

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>

>  fs/xfs/libxfs/xfs_ag.c | 10 +++++-----
>  fs/xfs/libxfs/xfs_ag.h |  2 +-
>  fs/xfs/xfs_fsops.c     |  2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_ag.c b/fs/xfs/libxfs/xfs_ag.c
> index dcd2f93b6a6c..0c5f0548021f 100644
> --- a/fs/xfs/libxfs/xfs_ag.c
> +++ b/fs/xfs/libxfs/xfs_ag.c
> @@ -866,7 +866,7 @@ xfs_ag_shrink_space(
>  void
>  xfs_growfs_compute_deltas(
>  	struct xfs_mount	*mp,
> -	xfs_rfsblock_t		nb,
> +	xfs_rfsblock_t		*nb,
>  	int64_t			*deltap,
>  	xfs_agnumber_t		*nagcountp)
>  {
> @@ -874,19 +874,19 @@ xfs_growfs_compute_deltas(
>  	int64_t		delta;
>  	xfs_agnumber_t	nagcount;
>  
> -	nb_div = nb;
> +	nb_div = *nb;
>  	nb_mod = do_div(nb_div, mp->m_sb.sb_agblocks);
>  	if (nb_mod && nb_mod >= XFS_MIN_AG_BLOCKS)
>  		nb_div++;
>  	else if (nb_mod)
> -		nb = nb_div * mp->m_sb.sb_agblocks;
> +		*nb = nb_div * mp->m_sb.sb_agblocks;
>  
>  	if (nb_div > XFS_MAX_AGNUMBER + 1) {
>  		nb_div = XFS_MAX_AGNUMBER + 1;
> -		nb = nb_div * mp->m_sb.sb_agblocks;
> +		*nb = nb_div * mp->m_sb.sb_agblocks;
>  	}
>  	nagcount = nb_div;
> -	delta = nb - mp->m_sb.sb_dblocks;
> +	delta = *nb - mp->m_sb.sb_dblocks;
>  	*deltap = delta;
>  	*nagcountp = nagcount;
>  }
> diff --git a/fs/xfs/libxfs/xfs_ag.h b/fs/xfs/libxfs/xfs_ag.h
> index 16a9b43a3c27..8aa4266c5571 100644
> --- a/fs/xfs/libxfs/xfs_ag.h
> +++ b/fs/xfs/libxfs/xfs_ag.h
> @@ -330,7 +330,7 @@ int xfs_ag_init_headers(struct xfs_mount *mp, struct aghdr_init_data *id);
>  int xfs_ag_shrink_space(struct xfs_perag *pag, struct xfs_trans **tpp,
>  			xfs_extlen_t delta);
>  void
> -xfs_growfs_compute_deltas(struct xfs_mount *mp, xfs_rfsblock_t nb,
> +xfs_growfs_compute_deltas(struct xfs_mount *mp, xfs_rfsblock_t *nb,
>  			int64_t *deltap, xfs_agnumber_t *nagcountp);
>  int xfs_ag_extend_space(struct xfs_perag *pag, struct xfs_trans *tp,
>  			xfs_extlen_t len);
> diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
> index 8d64d904d73c..436857356a0a 100644
> --- a/fs/xfs/xfs_fsops.c
> +++ b/fs/xfs/xfs_fsops.c
> @@ -124,7 +124,7 @@ xfs_growfs_data_private(
>  			mp->m_sb.sb_rextsize);
>  	if (error)
>  		return error;
> -	xfs_growfs_compute_deltas(mp, nb, &delta, &nagcount);
> +	xfs_growfs_compute_deltas(mp, &nb, &delta, &nagcount);
>  
>  	/*
>  	 * Reject filesystems with a single AG because they are not
> -- 
> 2.53.0
> 
