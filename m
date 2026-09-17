Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD39A19D8AC
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 10:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789640184; cv=none; b=aewY9qjSa+NhYrhxpSCHgt++IbdZLiUY8I6BB0xrjUoEVzUO8D5MRkVESTTirzyhHTUU8mmeCfC+vdNsMWaeQDBiGk7uv2N/OLWWHW2zT7pgV2V80QWZLRQDl/3sRaCc4aew8bHhob/FexbzDRrWQefiMrq2OSpIL5j2RIMs0KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789640184; c=relaxed/simple;
	bh=31gmwchEMMHb3+zxeX/OhZx9GShbrwHmAbikjh6enGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLwOC0eBneVFRd56hy69OLgNw1tZobTFnnDi3sdKx1MacgpYDgdcC1ZyngTLezMIJ73SvkIBfiEqqkIRzmM7OivoP37h/+NcPF6aowhmWyAPTXRjHtQYnvZpvASpTKr7exN1ycsPvfwGpeVS0nrWn5jvvNyV7x6zX8CWkk5Izyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=WAKe/QPZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ifXntS19; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="WAKe/QPZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ifXntS19"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4C5537A013B;
	Thu, 17 Sep 2026 06:16:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 17 Sep 2026 06:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789640174; x=1789726574; bh=HlzOyZnaQa
	75Fnv7REz7lUuobetqUe6Lm6PYJEa4800=; b=WAKe/QPZDM0M9TGzJ9fhsYKA7R
	ZKCKuGs4ce0v1IHVmuD20LiwHG41ExAlp7V2CFy3vPfLtlkrMoBDjLPnBONcBKlp
	ulx0NWvgFh+RhImarkLmP4TAVb1ZzYmZbzJapau+2TtOtACXVncAAglzZzJKmQXJ
	ooYDvCgDFr39dcX7tTqAOI46YTlOlVwQwuua6CTs4LyQD0CN8VAEJ6VVsxj7Kt05
	dx7GrFOMAKO6CxiTWuBgFHWtPLdY2YTcv/+7bA3pvDcHxnPJXDUaONP3uqI4S2+K
	Sb1rkTbCbdpOwqyb3uhIJ5vL88+tj5Wk8VAMUpRYzEwyCLb0LyPy5MoCcheA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789640174; x=1789726574; bh=HlzOyZnaQa75Fnv7REz7lUuobetqUe6Lm6P
	YJEa4800=; b=ifXntS19YtF0LqRjAb8XCpddbl1H6UK7LfbvlDyamtRvvfjf/Sy
	3RiVqv4jqIOaubZuB7CeOCPcRPiZrUVy1UgD/pXQrnZ16NJMJQOKKLSq2YahYi4e
	a4FRECzXoD4cztTK8AYIWN0nscBctb73YsnMt5Qjg7hZWVYtcAazTizPZ8SLkQHA
	UTFCmxeOntE2xy6QgHA7H/f6AxvuRPm8NnKqntHfLpaf9i9FLXYtu5WFFPuSd5na
	sGJjRT/ELQG5VzrSNcVY2gircvJLQFqDg0O9iUS8x+6wPoslTJ+9+ElxQd+p0fLS
	HT3A7/m7DdNVooQZplzDxJ3XM2JP2w90HQw==
X-ME-Sender: <xms:7r2raonWom3HlPb6QJmRRA-sRIViQb6zwW8-Pc1SSTJqOTdOp5nbeg>
    <xme:7r2ravY98uU7N1x0AOWk-wv3jYNSRaLfKdKpetxztKtw99Hfh8Kx6A-3EpPPRk8aH
    UreErZbhhPbyW1sJiplb07P06x-zJ7u9wxKStlB_5g9fQgQBybJ>
X-ME-Received: <xmr:7r2ramRwQhnGmun4ILWPc9Q50E7Sus3l1bpYtu6ZPW5o0ovde3jgNi-M79oW>
X-ME-Proxy-Cause: dmFkZTElf4d9n0/4S/7erGlusUKPYD2kcVG5VSpPnMvugy8VHPs94woHQ2rDfdtc1W9CwX
    86FQo3pMi+DM8URjsuP5zWzCro9JAStCkPeHMDE/0XdgZ93n4F1PyGbe3Ys/dT0yEiBfCI
    qCs2lW49Cm1MknQpsQrE1PDxUQFN7l4czIBZxB6hBWvSvFiUYYW2AdogLgRr+YIjbRBrbX
    ohX6aNml5uv0pjkLMgUL8xQurH6dnBRo6PJ1EkQ0wfcO5khEsZab6TRwXeYrBbT1O8nwLH
    9mGenjPgbYeFzd7aetRINFN0x0a282VDN4Hz5MJ/jdU86bzOLv4GWRMesmPHThnd+OfHdS
    7ZNG3ZxyhLYZrU5BuTouEBpnJsPyHWMKNyqutTQKUFG+oJDXFp2bXOwhYw2Xe4GTsP3Z5H
    e8ZuvTc/WyeTLJhPLxj5Glo6mhhc95ciANGJ1sSN38RA5m207zi9mts+vOwFn8YbRFvM3E
    xqVH6qI4fnF7wvjAZ7r8Ixev9tG3afHFI3kdE99gVlxa8GXKiT3lSi6ak5ut3SMARgYx6e
    gk/7irV0zj8wDvbus+wSpMhK72YhW2EcT/jbPIY68Ck15TxQ+ad1s5ZYD5di0Ni7gcZiQE
    yLzj/Asln1sDjXCMYaVQf9hGZOmj4CosRAAwOzQFIek+789i1EuyD+4BbmpQ
X-ME-Proxy: <xmx:7r2rahUSJ3rL-mB12mOtIiDbFAP41oy_nh1ikN8lR_Dzy_FV-RO0FQ>
    <xmx:7r2ratYYjxIjgF1UDXccohphfG8Rr9eSo4W7dgdY-tiGwAxAmWW06w>
    <xmx:7r2rai4VDNDzONKrGj_8cDay8vdM-pQKNiec3ga52RAn_Th_8xlK5g>
    <xmx:7r2ramx0kFCK3cmpO5uTArIPh76iIptwBHxXWQ8lsdOOSCub_dW_EQ>
    <xmx:7r2rarbujxcLHFQuO1kpgle0BX-UXBdZwvH-7aVbAgsASf7AHKC8AeLX>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Sep 2026 06:16:13 -0400 (EDT)
Date: Thu, 17 Sep 2026 11:12:09 +0100
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>
Subject: Re: [PATCH 6.18.y 2/2] smb: client: fix WSL reparse point uid/gid
 override
Message-ID: <2026091705-rhyme-from-94da@gregkh>
References: <2026091651-rehydrate-vexingly-f239@gregkh>
 <20260917041703.4190978-1-sashal@kernel.org>
 <20260917041703.4190978-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917041703.4190978-2-sashal@kernel.org>

On Thu, Sep 17, 2026 at 12:17:03AM -0400, Sasha Levin wrote:
> From: Paulo Alcantara <pc@manguebit.org>
> 
> [ Upstream commit cd2b2b57921d4caa7875e83198bb2aa71254328b ]
> 
> wsl_to_fattr() unconditionally overwrites cf_uid/cf_gid with values
> from WSL extended attributes ($LXUID/$LXGID), ignoring the forceuid
> and forcegid mount options.
> 
> Fix this by initializing cf_uid/cf_gid to the mount defaults and
> gating the $LXUID/$LXGID EA parsing on forceuid/forcegid.
> 
> Closes: https://sashiko.dev/#/patchset/20260906190803.667489-1-pc%40manguebit.org
> Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
> Signed-off-by: Paulo Alcantara <pc@manguebit.org>
> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> Cc: Shyam Prasad N <sprasad@microsoft.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: Bharath SM <bharathsm@microsoft.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/smb/client/reparse.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
> index 58bd67f32377f..383eb9bd45793 100644
> --- a/fs/smb/client/reparse.c
> +++ b/fs/smb/client/reparse.c
> @@ -1108,10 +1108,14 @@ static bool wsl_to_fattr(struct cifs_open_info_data *data,
>  			 struct cifs_sb_info *cifs_sb,
>  			 u32 tag, struct cifs_fattr *fattr)
>  {
> +	unsigned int sbflags = cifs_sb_flags(cifs_sb);
>  	struct smb2_file_full_ea_info *ea;
>  	bool have_xattr_dev = false;
>  	u32 next = 0;
>  
> +	fattr->cf_uid = cifs_sb->ctx->linux_uid;
> +	fattr->cf_gid = cifs_sb->ctx->linux_gid;
> +
>  	switch (tag) {
>  	case IO_REPARSE_TAG_LX_SYMLINK:
>  		fattr->cf_mode |= S_IFLNK;
> @@ -1148,11 +1152,13 @@ static bool wsl_to_fattr(struct cifs_open_info_data *data,
>  		nlen = ea->ea_name_length;
>  		v = (void *)((u8 *)ea->ea_data + ea->ea_name_length + 1);
>  
> -		if (!strncmp(name, SMB2_WSL_XATTR_UID, nlen))
> -			fattr->cf_uid = wsl_make_kuid(cifs_sb, v);
> -		else if (!strncmp(name, SMB2_WSL_XATTR_GID, nlen))
> -			fattr->cf_gid = wsl_make_kgid(cifs_sb, v);
> -		else if (!strncmp(name, SMB2_WSL_XATTR_MODE, nlen)) {
> +		if (!strncmp(name, SMB2_WSL_XATTR_UID, nlen)) {
> +			if (!(sbflags & CIFS_MOUNT_OVERR_UID))
> +				fattr->cf_uid = wsl_make_kuid(cifs_sb, v);
> +		} else if (!strncmp(name, SMB2_WSL_XATTR_GID, nlen)) {
> +			if (!(sbflags & CIFS_MOUNT_OVERR_GID))
> +				fattr->cf_gid = wsl_make_kgid(cifs_sb, v);
> +		} else if (!strncmp(name, SMB2_WSL_XATTR_MODE, nlen)) {
>  			/* File type in reparse point tag and in xattr mode must match. */
>  			if (S_DT(fattr->cf_mode) != S_DT(le32_to_cpu(*(__le32 *)v)))
>  				return false;
> -- 
> 2.53.0
> 
> 

Does not apply :(
