Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782164E0200
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774382; cv=none; b=A+34qz//BbyUSRq61QMJZOPrbACP5um8+viS6KoEzfmVROkgk/moCN2hDLl/M+6nunvIx301rIDdmGxiIbRVCGY+mvB3OmCz8NsyxrHx+CFUwGDmDhA/F142nDtrjeLZ18uThfsZ/s4wMIwF4QBkYdxwVaQmaxceyRP5OF2/JqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774382; c=relaxed/simple;
	bh=1VCfJux8iwv+GXPAEVEMuV+erBNomEyKmzqiWN1hovU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTZZOIZfgUEZz7Y6z/jjvQrtLKZxsRPxNOxzGrDrlCeabySwF7ingR8W0UdzZpC0N7pHt0gul8QieIeSwNQxCUowRDUj3G4tA2SnlEvpjg6zNx6rZzfgZ5WPJt1rabLGqEvgxkD3S9oKFKOnHDCWn4cfUkBoDhJc+pH6pmdprew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=OtScitsX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wDgQTa+d; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="OtScitsX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wDgQTa+d"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id BC4481D006D6;
	Wed, 30 Sep 2026 09:19:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 30 Sep 2026 09:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790774373; x=1790860773; bh=CuPZmZIsRl
	2A+A41A7fA7rEgl+YBrFbZsyw2kWWmA7M=; b=OtScitsXBWpKDg5dyfoFXWOC9I
	Mp91e1Pn06CEhzPAOBcfuGxQKtIeqb3Mz2/n1ntIgGy20o1Is9jH5VuSTeVZLbKE
	aF0kXv8m6Zgt8Qw4wpry1BP8y1Fb7W41K2Jbp4IIQn3lS9Ni722HW7Ta74yDNkRe
	LM9KBupyEtzzLjEPUf94DJawaV8Ue1ooM4WIVajXr0xFLNd8i9Qh1/IBtSy0qO2t
	7QeTOzUmd3WGbNOOzQkht+rf/ggTMIgayeWuXVwBVnlbXio6TN3mOvrOyslnSqa6
	K6fHNPUVjgVQ9uSXeiAuK9g0BS+fsue+m7sYyHTJQ3g+SoxX7ilUPa0qgStg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790774373; x=1790860773; bh=CuPZmZIsRl2A+A41A7fA7rEgl+YBrFbZsyw
	2kWWmA7M=; b=wDgQTa+dvie39SYa71NMUdRsvbvB3ehIQWLT1h2/rt2JhZMLeC0
	sVeewW7s5ipib38fj2qLS4SdRYWkWeYG8RCPsaldBJQc6RAI8MTEKsUslTJzqgSk
	AIS9Ayf5C4X3waSfzQs6Kol/0ry0QZN34vvGdlCO4dACACXpCoFMCwlVq9HuLOAm
	hzjbeLQ3B69oXuy9n69AlWBq6PzCUUUhOL1At8+WcUPVg4pIb0Ilw4qFYCPr93OK
	wK/OdHZCU7nHTG5tPL/ZFfjNcS5C9wro35OqdcqfpKM75pGXQ4QiV+LmGT+VwlYW
	mPus7Ues2XqShY2Hs0E8TT2WXH/m9o+Qzbw==
X-ME-Sender: <xms:ZQy9auEMJiSF_edcKD7v4JDLxGcmdUtLL0G_LR-lVF0TcqPyp4L1BQ>
    <xme:ZQy9aiajpsG38GrqCsgOKLvJB3LnuNLYONYxbDmdF-HTTV6jNiNgd5DnjAyKQdhMr
    VPex4bS7JybpWwKoWAgzPBSzAALpkmb3IyIeEczDYvCmw4fX9o>
X-ME-Received: <xmr:ZQy9aixzreHovnSEpMbmjugRp1nf2z4oFozPQa7QyJFD93eb9hLuP5PNufGstoZub0OK0aJ4ahSQeYF-TXleF7tU0zLZ2ZJIgzV91yq7fqI>
X-ME-Proxy-Cause: dmFkZTFJD+FE4CO3Ll2YoYd8qnAEMuTIug6/ugG1LiZvsR2pKliuPnD3RStk5FnfxlLFON
    fy0sDNKfMn41rFVuAMqvUkY6Y0eyA8v994EhPYZDPKDEZmzMFM+U+rQuG2HL5+vNO3GBRZ
    viFLpqngA1WuRnU0LNQMoxXTJms2ytBlzTQpv22uTUooALlLCG3S70pFsDhqx+d9vD8Zk3
    mYDTFMOYsM9tqbCX3uxnAYAH6Wa5TZTwYuXEYrPed/ftSgQ8ipLU3irPWfgsxgxadZYo25
    NHgjal+IbK5mUC5s3aThCh4P/sjzGR0EpHbHYWdMHJvjjqLfyvP2BYkYjlpHDfXUxuzWGE
    bWFkF/gyImquIJEtg0/qBVfLPu8tMv+qjwJiEnq3dSBbhZzrWPkNpLPewGDT9w/qHqFd3R
    8pOA5RHrZYNj/euVW9k96O8JQIo+3sBUJaGCHv+oK8srYbqMmnwYE4Rs7wPF3aLFBmto6n
    Uwt+9baJUKDV7+kfIw6w2f0aOXI5J/U0F8goSE34XOCevoRRX/CyNKUsrSjBSdl4/1CKNZ
    JkPzyGJEsPBlMwI7rljhBKqfAvtt1cKLZrZtntlN2OMjmET0jLvqzWP2OxRLyP3JHWxPX3
    ydD+rnQZY3SsxS6ig+cDEKZcaUHFHwoxlHWG2zWDuMJHtuM2RjpFwmfwemUg
X-ME-Proxy: <xmx:ZQy9akQJ5hk7ruxeSmoSJpaFsW2uNqg7H3zNufFqbfY_hwo-wjy85g>
    <xmx:ZQy9avJytcmVi4Ke_Z7hvRmEUDyryz_NmBwnSsUfp0xPKo4_DpvPKQ>
    <xmx:ZQy9arVtEX2AaFNT8T85Wtu2kJBnLeLlzvH6KFywmaWi3w9SgeSfEw>
    <xmx:ZQy9ajQWU4ule4HIr89Hy6W2QhMz8s-2WSmcKHgAFHLz9sTXHdMuIw>
    <xmx:ZQy9aje7SYQz82d8hZP7OY7LxNmM22MX3-9hISE5G9mh3ZG3YQNPsqOY>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 09:19:32 -0400 (EDT)
Date: Wed, 30 Sep 2026 15:19:27 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Carlos Maiolino <cem@kernel.org>
Subject: Re: [PATCH 6.12.y 2/2] xfs: don't stash removename operations with
 unknown ftype
Message-ID: <2026093023-retaining-stowaway-0969@gregkh>
References: <2026091654-contented-triceps-9bbc@gregkh>
 <20260917183939.1201122-1-sashal@kernel.org>
 <20260917183939.1201122-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917183939.1201122-2-sashal@kernel.org>

On Thu, Sep 17, 2026 at 02:39:38PM -0400, Sasha Levin wrote:
> From: "Darrick J. Wong" <djwong@kernel.org>
> 
> [ Upstream commit 865b751e75039fc07838b3200f9740256653da9a ]
> 
> LOLLM notices that the behavior of xrep_dir_replay_update changes based
> on the ftype recorded in the stashed removename information.  It also
> notices that the unlink iops sometimes set that ftype to FT_UNKNOWN
> because the regular directory tree update code paths don't need to know
> the ftype of the child.
> 
> Unfortunately, this results in incorrect link counts, which eventually
> trips link count errors in later phases of xfs_scrub, or in xfs_repair.
> Fix this by creating a second xfs_name with the type set correctly.
> 
> Cc: stable@vger.kernel.org # v6.10
> Fixes: 8559b21a64d983 ("xfs: implement live updates for directory repairs")
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> Assisted-by: LOLLM # finding obvious bugs
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Carlos Maiolino <cem@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/xfs/scrub/dir_repair.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/scrub/dir_repair.c b/fs/xfs/scrub/dir_repair.c
> index 0cdd763250cc3..5d594085a6c1b 100644
> --- a/fs/xfs/scrub/dir_repair.c
> +++ b/fs/xfs/scrub/dir_repair.c
> @@ -1373,9 +1373,24 @@ xrep_dir_live_update(
>  		if (p->delta > 0)
>  			error = xrep_dir_stash_createname(rd, p->name,
>  					I_INO(p->ip));
> -		else
> -			error = xrep_dir_stash_removename(rd, p->name,
> +		else {
> +			/*
> +			 * xfs_dentry_to_name in unlink or rename-exchange can
> +			 * pass us names with ftype FT_UNKNOWN, but we really
> +			 * must know the ftype of the child that is being
> +			 * removed so that we can do nlink updates correctly
> +			 * without holding inode references.
> +			 */
> +			struct xfs_name	name = {
> +				.name	= p->name->name,
> +				.len	= p->name->len,
> +				.type	= xfs_mode_to_ftype(
> +						VFS_IC(p->ip)->i_mode),
> +			};
> +
> +			error = xrep_dir_stash_removename(rd, &name,
>  					I_INO(p->ip));
> +		}
>  		mutex_unlock(&rd->pscan.lock);
>  		if (error)
>  			goto out_abort;
> -- 
> 2.53.0
> 
> 

did not apply
