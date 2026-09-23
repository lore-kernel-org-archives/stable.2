Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0007A450409
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 09:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154882; cv=none; b=k5q2pbY7I8wFxhftOcm8PSb00NasufJ/gWDBFwzGtRl29EHP3adIpkgyEVHH1GNToYBi4Of+KQ0+kVMPLkTMP4gXlJzOL/y/p8gNa/DJFenxG2zLG4ATfKfpIAgXXmWVi/eb4eA2M7bObcjp6sTaUQAkppF9wpvM4ONCf3bfQ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154882; c=relaxed/simple;
	bh=yBkBQV7B/1BCN5qJwQ1nqQL6d3IVjqWVlCE17QpM3kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnTEQWBBPcYcQt0TSu7MCX9DJY7Lz8S2X54aT4pYtswIxM7QE5dchhqmoI8pyIAk8z4Bpo54Q51qcS1gJuE6yVLY1l53ePuQRf2yvNb0hWvtiAUzb/cA6Pdam283H/ROG/6KydTOrcSmTJnxMmyscVVkyHLPMejddaw7NbXVq8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=kvAfeGRX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PABxA+rx; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="kvAfeGRX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PABxA+rx"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D76161D000A8;
	Wed, 23 Sep 2026 05:14:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 23 Sep 2026 05:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790154879; x=1790241279; bh=GedQwnSZyq
	szjaseA0LcniV58A79JVlaaoVeHOy86FI=; b=kvAfeGRXQZh0FcxJ0aQuvA2pI0
	xKIcTFuCB3xI/9mz6LwnS0xLEQ7S5jb2O9poW0QlCYC5ypSPngEoyNObyGdFBLCu
	MnmTcBTLa5PoXFiCKsip7NOR9DpBqkO71SkQzjpBVBsF5ed7JKbDCRjbg0O8OY7r
	QRoN3hPP9t+q+sBatdsFMWmdcs1+iJB3Gz5h/UULdoYr0nBJewTIXhSLgHG5BE25
	6zqfk6sJGzMvDwV6lX07SAzZVAB4bOOdVYA1QFqCWpAbPvvWZ6k8o3jfZMdh8NUr
	dCGkIXJq0RJNo+fhHTJGuBuI5eRQixyc+acHOaL+rzvqgTqHdDIrnPVxCXyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790154879; x=1790241279; bh=GedQwnSZyqszjaseA0LcniV58A79JVlaaoV
	eHOy86FI=; b=PABxA+rxhZhx+vGikpT4ZSCTOsQ/YvaSsegTB9vzZgrpP+XD6wP
	g3bNX89Q9bpEC9S5IkNu+doJwNZMHHZMkaNWDNySV4f2D6jMEES4QfybNCamK6cj
	/4lpMXP2skWjL/XUgjuEDC8afpn7JtKvQvcq89NQ6E4pfjFav6YdrX30wHjonJ3a
	mHI8WEvHpvt4RcKcF2+7ZbdKB80h6I0s6kUclL5nAixG/SCOgn666tco4k6NrPPy
	0Okz7M4c/DBOnmShrJ65IZ9WzpTyMfZhpNN0MPwp/P3aK/j6o+fVc0LpxWy2/cKb
	6T1Ta/+shy5x1tgmKHWT8Pk8EJyxAkALHeA==
X-ME-Sender: <xms:f5izat_x39dOwe4K-N8iG5jGdwyVuPLpkLb1WsC3hMjynxSvzcu0vw>
    <xme:f5izakxXsananotMbGAvU9_jWstNcq7AhxZF_DP4W5KIZqzYIzpiiujjMeZfZvkzh
    FuxFcYJYIzoNvZ5VS4RomjY4-WAdtgKHwh7sjySkrkjl-FOGJg>
X-ME-Received: <xmr:f5izalpLHlMJ7bRmHQu7pj6mPRVQM7ap_F8WBG55lGMRrj98UV9zH6KmwlAh>
X-ME-Proxy-Cause: dmFkZTG0Fr2gtcoi53eSnX332zTyx8nes1qWZ3sTNrrRLbN8FTTztiNdKL6qrf3exGtA7Q
    Am6NuXztUFP3N9p+XAEjXX+L9ItyLwIqh9co1s5d4PGy0LaT8cauiWFT745zOL7y/ybcYL
    KikADraFJDEjtBF2dihjUMsS6DF955EZrk+NB/zq2o2Gx6IgVSnPWNYuY1av+uhcT7UiH1
    9sUlQfDrMFncttKjXKtCBopYs3Ya93tW4sMSMMErrOCgLFxg5t8ugcIanFfruU5hx9p8gi
    qM0XcnEQXb66wS1kWQl0hX0ZLbHWeRHGdrfX1rxW5CpllR8QekMMWJ/OL+Wo4MFtOHYMCT
    5knhUvHJSEr6s1D438lKaViAcG7RHhnwFmY1kslV3dOKGCaJQqRu8PwVx6kNqbtxYjftgE
    kTgsz5a24E5JVu9errKNvFzSzGZsdiU9czannbET4H+NlrqTmjInFNmE7NTtC9lX2z3R38
    RzTK8Y8E/2SpRN3E8saIrf//XcSqQeqLGjtknEgNWLSrrkb2hlII+FedDX+0g5Ze/5u1Lz
    HxISuva1woTkLUhcTJorHoq25bpGTtzGZEvrRwQl49ZY7vVQhEO8EdEbeNHyQ8Yx8i8IXW
    6awc+79f+q2seB/0oQqZf59oXfqwth/488dQ9h/O2N05mtyrjwL+g/X+Kydw
X-ME-Proxy: <xmx:f5izatpok_crY8fsF4FTfSUz1uwfFLBE-ExjOW-Y9EW3bXcnAKbAcQ>
    <xmx:f5izatDpryINYKoLdYG5_V-esKp_pzqEdLqTtzu4t-yTfniqM5zEEw>
    <xmx:f5izajt-KX8PKH4fLKZ7Bjs8fGOXQcEBYuTzucJ2FF7hnKlmFRHnhg>
    <xmx:f5izakKD8n1jwZKHNgVLwOf8Y-ZxH6Nrp2G_C8C6ekBDLBsQKpg_AA>
    <xmx:f5izajMe5ge7Zkl-yExjeoiHkjulXzT2TcLS4EpInHxoD07V2iQ7tRk_>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 05:14:38 -0400 (EDT)
Date: Wed, 23 Sep 2026 10:02:19 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Long Li <leo.lilong@huawei.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>
Subject: Re: [PATCH 6.18.y 1/9] xfs: factor out xfs_attr3_leaf_init
Message-ID: <2026092314-paparazzi-lethargic-486c@gregkh>
References: <2026091651-freedom-anger-bd4d@gregkh>
 <20260917151724.693663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917151724.693663-1-sashal@kernel.org>

On Thu, Sep 17, 2026 at 11:17:15AM -0400, Sasha Levin wrote:
> From: Long Li <leo.lilong@huawei.com>
> 
> [ Upstream commit e65bb55d7f8c2041c8fdb73cd29b0b4cad4ed847 ]
> 
> Factor out wrapper xfs_attr3_leaf_init function, which exported for
> external use.
> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Long Li <leo.lilong@huawei.com>
> Signed-off-by: Carlos Maiolino <cem@kernel.org>
> Stable-dep-of: 865b751e7503 ("xfs: don't stash removename operations with unknown ftype")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_attr_leaf.c | 22 ++++++++++++++++++++++
>  fs/xfs/libxfs/xfs_attr_leaf.h |  3 +++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
> index 14dddee4f8fa6..dd3923fdcb205 100644
> --- a/fs/xfs/libxfs/xfs_attr_leaf.c
> +++ b/fs/xfs/libxfs/xfs_attr_leaf.c
> @@ -1330,6 +1330,28 @@ xfs_attr3_leaf_create(
>  	return 0;
>  }
>  
> +/*
> + * Reinitialize an existing attr fork block as an empty leaf, and attach
> + * the buffer to tp.
> + */
> +int
> +xfs_attr3_leaf_init(
> +	struct xfs_trans	*tp,
> +	struct xfs_inode	*dp,
> +	xfs_dablk_t		blkno)
> +{
> +	struct xfs_buf		*bp = NULL;
> +	struct xfs_da_args	args = {
> +		.trans		= tp,
> +		.dp		= dp,
> +		.owner		= dp->i_ino,
> +		.geo		= dp->i_mount->m_attr_geo,
> +	};
> +
> +	ASSERT(tp != NULL);
> +
> +	return xfs_attr3_leaf_create(&args, blkno, &bp);
> +}
>  /*
>   * Split the leaf node, rebalance, then add the new entry.
>   *
> diff --git a/fs/xfs/libxfs/xfs_attr_leaf.h b/fs/xfs/libxfs/xfs_attr_leaf.h
> index 589f810eedc0d..deb62b544ac54 100644
> --- a/fs/xfs/libxfs/xfs_attr_leaf.h
> +++ b/fs/xfs/libxfs/xfs_attr_leaf.h
> @@ -86,6 +86,9 @@ int	xfs_attr3_leaf_list_int(struct xfs_buf *bp,
>  /*
>   * Routines used for shrinking the Btree.
>   */
> +
> +int	xfs_attr3_leaf_init(struct xfs_trans *tp, struct xfs_inode *dp,
> +				xfs_dablk_t blkno);
>  int	xfs_attr3_leaf_toosmall(struct xfs_da_state *state, int *retval);
>  void	xfs_attr3_leaf_unbalance(struct xfs_da_state *state,
>  				       struct xfs_da_state_blk *drop_blk,
> -- 
> 2.53.0
> 
> 

Series does not apply :(
