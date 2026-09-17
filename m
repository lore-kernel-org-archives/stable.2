Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29364BD7B0
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789640184; cv=none; b=eStvhxExQKj0CcR1v1u3agHJcWJHmhho14zQ42PcGQpkEF6kDLI3/12yCLEA1IOihVfbL676gsG0OSCyDxBx00RtekFBYtGidw1xwDBGqHLa0HxtGIsjIZ2qvw2yQFFmAsccvPiqdeq2KcHW5ud65eHOF2QH+k3nBYi1NPdw7bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789640184; c=relaxed/simple;
	bh=CMmkVxvYZX3mMsThqspEIH6KNvXJla1A0bcljxtoXvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0+yA1AQ5s14kpu5MzboP7/2VDX9oPyT87uiMxUazC62T4ykHW/tj9KIZRCFPt+hlKGJWnXYxGh5WjX27zOrriqFixFD7WjL/CtySHf+Y+bZXW7D41VQ62oU3NjqzFuLOZ4vsf4XBYVvjKFvN7AgeMWRNyP23SIHeZNY1l0uXl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=ZF1Nk6lf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v6QLyNZz; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ZF1Nk6lf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v6QLyNZz"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id C98A41D000E5;
	Thu, 17 Sep 2026 06:16:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 17 Sep 2026 06:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789640170; x=1789726570; bh=NjxAryLrna
	ikCmCVeZJ/y8JC58YWHLsHGj87dwR1Ipc=; b=ZF1Nk6lfJ9vuzycfJPUnZk0CYu
	hWK5HiOt3zLCvC9yq/d5zFWt5SKpw86EsOd9a0JbJ8f1oJl64A4cSCqrR2kQTgGc
	dQp/NQzJdgSdrB0S9uPVZV2wE6ooqYpS2roxFqeoYsKpGZZD9QYkW5YP9i1X7eQX
	h8ADVAaQcdR7jWzrz/KgB/kO77E14wdhk5Pdo4V5wGO71BbU6Qt0E2TGWqDWKvHa
	j7UErOaVY0WE/N6GylwYDGIHxeSFn+OLJZ2BTWh9l6CeY2Eg7+3u4jshyk4hZ1yB
	Hxwo9plboLkzV51+YKKvIbUNo8RexsR/SaT6D5HvOgT1A0Xt4sH9yXduxBPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789640170; x=1789726570; bh=NjxAryLrnaikCmCVeZJ/y8JC58YWHLsHGj8
	7dwR1Ipc=; b=v6QLyNZzH2wUdiY4kViHxXX8VdUEywsEDFNP+GE8EdtAd/RAhaC
	wx2ODpPhHbqN0r/hbFQiAsZVoLrThthRx9sDbj6DZJiCgJWNUooYhIXA2LCJGYmu
	Arw8IDp3lEmFEnvWeeIMKoRl8D+L4ZYgXsIH+HfcZceLA2+4VT889/CXLbZjfRoG
	VujIsKMkMcj1DrVLIC9N62frNzDzFUMOTxY/hc96wvWb8whDtOGPHrXXGBs1YhZw
	amtAbUxkyslDcsjImZvwNu0QV2/N0ttmDuS6HR/mcPqBlosSjmfCEpTocdYurbqA
	poMOGyRvyeLx1p0CkkVyI5fnmdjrUY8wSXg==
X-ME-Sender: <xms:6r2ratXBPUu_R28EolItqvYT51uwVdh4-k7aSrztnRVoAGyotGfnOQ>
    <xme:6r2rapikETWsZS_TmGujFEgpqbbE70BOqZ63K_eIsQIqkQ23Ne8H0GnBNlaSwS4aa
    bhLX6znh7uGP93b-rOQfGWTbZJGTLBOcIyOntQIdNNFYFrFJg>
X-ME-Received: <xmr:6r2ravhAZcGYUBi_LJJ2iCPAjlw3TxSoMAYiZng_k4c651TU_oP5vqMSiKPk>
X-ME-Proxy-Cause: dmFkZTG3AMH+euWnGViAB5kmCUBBNh6T++b7tyuiSS4JnwIoOTOPTGerrouw+E/rUv+0l/
    yTgoPND3P0UB25+hZXdQoQDshGByradhSuE1P05Nd8Om554138r5M1BSN9q6ecjnazifKy
    9XIviYc02dHucqcFbS7cvzCZPu7TSVKqPcJXNCPekzVMJoEiZ3xW6EPu55Lj7w2hZo9C6Q
    SHM4nE7Rldac9k2o/MhRPDD/9ijjiID48s55AQ1Cgstun2eh/APFTfw3IbdQHD28NZGlCq
    tk+rL9vZVVK+aKctoavGFGAGrpqiK5F9PDAqrIfo1gTwVv8gVs3zXdidxzkP9ohn3tgqHt
    LqZFHLZhJLMt9h7gKTqzIQHiSI4BsYL07OinV+IPnDbt/PJehPQ4DuVg+Rla+k5AyfQxis
    4K25YlaLNWLmgOQPks9L9Jq58PjGZEQyDwrsIghD7yBhW4Z90+s9jTqt36gtaRpK840KrX
    7o4QdQQI/Hcva8hYFCoI4jnKBDCFkCQe2OrYpN9iUm+josaP1IyrFOe3bzUioI307QS56p
    Rc+s4VdCoMGB4dJoYR8RHHNXpu+ru1VO/vr3NJOnq4XlGBLNzx1FDHjNzTNyuWE13nagWo
    wdOq21rO0P25s8MP0xAlhibKz/Be1u6MQLYmr/fnUFBv+IftyB/mfHrTU9tw
X-ME-Proxy: <xmx:6r2ramtSwWeiM11AqxcZ20fO8zzRVWVLFJxQVvA0ndoJCnHDbdC3XQ>
    <xmx:6r2ralvsv66i-LDnI9RmDcbdYR86q1XpQr__HekKlKKWcLuaLRdMaw>
    <xmx:6r2ranMAHkEHl9VW-pmdbD9YI7b-NnmbHSISNcltHR6_GtM3D1tJUQ>
    <xmx:6r2ranei0BxJJlWY6r5oKXQa10OLMyTcY_Tw-tGeDSBI-YF-FKx2jw>
    <xmx:6r2ragDZVqOP1gw6oZVe8zeJqPlTQ1khMxwGoh7-sTz16QzRzpdL5pN_>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Sep 2026 06:16:09 -0400 (EDT)
Date: Thu, 17 Sep 2026 11:11:58 +0100
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Paulo Alcantara <pc@manguebit.org>,
	Arthur Lesuisse <arthur.lesuisse@ulb.be>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>
Subject: Re: [PATCH 6.18.y 2/2] smb: client: fix uid/gid override in getattr
 with posix extensions
Message-ID: <2026091754-fading-earmuff-40c4@gregkh>
References: <2026091633-nearby-gravel-9004@gregkh>
 <20260917042021.6589-1-sashal@kernel.org>
 <20260917042021.6589-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917042021.6589-2-sashal@kernel.org>

On Thu, Sep 17, 2026 at 12:20:21AM -0400, Sasha Levin wrote:
> From: Paulo Alcantara <pc@manguebit.org>
> 
> [ Upstream commit cf4d35896621b7298eef51b7a465e5c0cb22f670 ]
> 
> When mounting with 'multiuser,posix' options, cifs_getattr() overrides
> the server-provided uid/gid with the current process's fsuid/fsgid.
> This is because the condition only checks for unix extensions
> (tcon->unix_ext) but not posix extensions (tcon->posix_extensions).
> 
> With SMB3 POSIX extensions, the server provides real uid/gid values
> just like with unix extensions, so they should be preserved rather
> than replaced with the caller's credentials.
> 
> Add a tcon->posix_extensions check to the condition so that uid/gid
> from the server are properly reported in stat results.
> 
> Reported-by: Arthur Lesuisse <arthur.lesuisse@ulb.be>
> Closes: https://lore.kernel.org/r/DB9P190MB2012266F6B8DECBE5D26A1798DB52@DB9P190MB2012.EURP190.PROD.OUTLOOK.COM
> Suggested-by: Arthur Lesuisse <arthur.lesuisse@ulb.be>
> Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
> Signed-off-by: Paulo Alcantara <pc@manguebit.org>
> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> Cc: Shyam Prasad N <sprasad@microsoft.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: Bharath SM <bharathsm@microsoft.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/smb/client/inode.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
> index e3858ab001695..b547466b1de90 100644
> --- a/fs/smb/client/inode.c
> +++ b/fs/smb/client/inode.c
> @@ -2972,14 +2972,14 @@ int cifs_getattr(struct mnt_idmap *idmap, const struct path *path,
>  		stat->attributes |= STATX_ATTR_ENCRYPTED;
>  
>  	/*
> -	 * If on a multiuser mount without unix extensions or cifsacl being
> -	 * enabled, and the admin hasn't overridden them, set the ownership
> -	 * to the fsuid/fsgid of the current process.
> +	 * If on a multiuser mount without unix extensions, posix extensions
> +	 * or cifsacl being enabled, and the admin hasn't overridden them,
> +	 * set the ownership to the fsuid/fsgid of the current process.
>  	 */
>  	sbflags = cifs_sb_flags(cifs_sb);
>  	if ((sbflags & CIFS_MOUNT_MULTIUSER) &&
>  	    !(sbflags & CIFS_MOUNT_CIFS_ACL) &&
> -	    !tcon->unix_ext) {
> +	    !tcon->unix_ext && !tcon->posix_extensions) {
>  		if (!(sbflags & CIFS_MOUNT_OVERR_UID))
>  			stat->uid = current_fsuid();
>  		if (!(sbflags & CIFS_MOUNT_OVERR_GID))
> -- 
> 2.53.0
> 
> 

Does not apply :(
