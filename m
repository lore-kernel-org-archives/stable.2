Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB67A4BE439
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774228; cv=none; b=P4GT9qJiPlWMShwPehEIkDuq1E27GbTfwFARkmWeWfqwvwPXmBrB9b0k/wSry35kaktXzJjjCGOMSLF1Zihklwe3N0kiIZfkSgnKr4Dv0qhOmpIyq6OF01AcflKGruEcVvhbYYVcnU8202yoeGD29T8l86lAZ+3QhsdTpzKC5iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774228; c=relaxed/simple;
	bh=8AFj4gSPOuh46Ky0B48w1WWGuKNktXQkTbdq0FYBbWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4D9SLl2UNl80e/WnoSL3clGQSKV1qSfpEG5OT0g1A+iAJjw9RDeu3bteMu3mpdvS+/Va2zcL9XnS+lFPR+S1G2AQAfK53WyBC+wFgXrok6YWOCAafWDfM2HTb5lvjPUreVxjnB1DIGSZy3ekqd6LX3iCM92Ot6WcXX0uPE5C8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=E3qbh1u/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VpjFtbza; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="E3qbh1u/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VpjFtbza"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 4DC821D006D8;
	Wed, 30 Sep 2026 09:17:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 30 Sep 2026 09:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790774221; x=1790860621; bh=n/cIMHPN4v
	rjCXYOOOnBvC+LIQK/eFC5R6ro+Ql+muA=; b=E3qbh1u/R8uFm0+HugIio9GvjX
	UWimxgftNnkNGs82fdG3NytVKhb4sQ/PfcDb1H2/vXhv8UK9c61L9z71CGQQhpfQ
	E9rnWXiE8J1mC4elrbKpaFBu1ujvzQjY2DEv/WVqa9Z4Yl7rUNzVHCBnVCB1iAiF
	Zg9QcBCjtdnGFkDBSIQwoCfRLvQH5b8bUB4YnQ2l/Z7XcVnRG5MdhjzOeb/8W772
	3auCvku94UEPYv8/Z95Duq429OA5Q4xst/afkV35gLjVeEMFaMAJREgolm5u9qD9
	o0pRIeGnLgtILOWnj+7tQyJ374JpFKQKhU3LjDsi+4tB8nuo5QXoGnc8IvhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790774221; x=1790860621; bh=n/cIMHPN4vrjCXYOOOnBvC+LIQK/eFC5R6r
	o+Ql+muA=; b=VpjFtbzaA6BbbNuq/A99lEq0bHvGkEhnOPdfXb9MVgpmnEchenI
	ElF7apKyGjgfaFBA1cQhZtwQDXoF7XsZ8F4o8NwCAc5I9IoemwjionFBFqA0z29C
	w4x452YGzHN/EaZ6lc1WJUFvgenSeByr1LVYTOL/zuJT8J0fiJmM01RjbE5KF5pG
	zkHRnRPDIx/j0isDHyoLX0MIhKD5nXVpownT2yNCe8He1CRmlNZrdYUebDRF1V8r
	eohBTspdXNgFWObwP0a0SH6Blg4I1labPcqyqt9S/s3UyZ9xO8Zsah29QSQTGlkR
	fmPuTViEv+8CdWxTIKq7A5OpLRGIJ2I0vjQ==
X-ME-Sender: <xms:zAu9aq_ZlMtF0NnMYafTnr3hWwPxq4I6IAcVn_SACWjs9eKNYEuoaA>
    <xme:zAu9amqojCKIxmmoFlhWqwOTil7vwSeN2JTupjPMQMYxeUjHptakSm9A2q158eA6v
    ea8HIqS1N4dkXbYNuCjtiyhAQO2nA4UUDTYQcwyTqeGMwy5sgo7>
X-ME-Received: <xmr:zAu9amKNzAWklm8R_o65nd3VploxnkUzgQKYYt9TZ6hafG7z23YycusLsQpM7qS4gY56zsxizjdqycbvHhldqtbzmj1h_fvEKVzCZM33nWA>
X-ME-Proxy-Cause: dmFkZTGVLvmo9OizJ6qYCotd5TwjEamjuQakMErd1yHvOfBQZi6FLo9JM4sikGXdYVHTON
    fG+ZfZGn0l1PZNe8p2ukhX1tstW2cl7ql8MBpVkLUSNODzkJkWG8yB5ox65BJKU5Yb8IJq
    ad6TGnCClsqd9qvc4V2XL+JGHpZyVBUzpgSwg6mGLIZHU9uhkA2NzXLbmfbkUxCgpMObft
    m+o/7WTNO2Je4tsjKW4i4MnSZwnvdV3PVr5HvHspwnSXtK/0FdvenUwcsK3WYj59WQjml3
    1I+l7zg9qbqKzHt5U1p0dx7zo2GOpkn5e+Hbb3Ln9nPxVW/VqXgJ08alflImZv00Az/9na
    8OF3Ito3IX9kApoHpdSn9qwTuOxySpDPcUYsoW1yEZm6zkAR0wRwWMylSW1zlffnqrXyFs
    CuJv788Ylq43ec06A4p+bJM9cl8C27Ayb/+lcg/PjbE99zUo4FtKGwqQa7j4XFpK6tGiOF
    /Stc5T76JJRkl0B1RUnRn6d9p+4jiX8uzAcK8DlHoEpDuFidYN2I3WbSQdLhQ9KvxiDRIw
    k26hst8+h+76WdM+V5JTJ9YC6tICLglY54Yi+BNOtX7MZ6OSJ8vJcX7LtMFGPaQamQe+/3
    AQnzipLADiOM74t4Evlwu7va9a6zHEsB6GMAH7qlEjOVQ0tXcewjY8o1dsXQ
X-ME-Proxy: <xmx:zAu9ao0XHLQV6K2u9oUP53DUawVLA7RFZlfVBQHmAGvQkqp-NGyf_w>
    <xmx:zAu9atVn2vVoGiqMgdUh_Pnxx5zYC_TJbQUO6OthxX87cRog-E0_wg>
    <xmx:zAu9amUvzPLWupojhrYImY3AXQAMz9hA5kXiZdE6N70TAQQsC83Urg>
    <xmx:zAu9aoELQGVxytZ5I19zH1ZznxIo7R5b_6gyF-PRDHCw9r9QcE9-Xg>
    <xmx:zQu9asQI87sri6cFNG-IzQ0yH8qI3Lonobf4yuur5dZh8WM7vTqomOgl>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 09:17:00 -0400 (EDT)
Date: Wed, 30 Sep 2026 15:16:55 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	David Howells <dhowells@redhat.com>, Tom Talpey <tom@talpey.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Bharath SM <bharathsm@microsoft.com>
Subject: Re: [PATCH 6.12.y 2/2] smb: client: fix fattr leaking on
 wsl_to_fattr() failure
Message-ID: <2026093050-siamese-studied-97a7@gregkh>
References: <2026092250-exploring-whoever-83c0@gregkh>
 <20260922212506.765193-1-sashal@kernel.org>
 <20260922212506.765193-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922212506.765193-2-sashal@kernel.org>

On Tue, Sep 22, 2026 at 05:25:06PM -0400, Sasha Levin wrote:
> From: Paulo Alcantara <pc@manguebit.org>
> 
> [ Upstream commit e1253a82bb4c0fed6706a5839fc8b6e01be1abe2 ]
> 
> wsl_to_fattr() mutates fattr fields as it parses each WSL EA.  If
> validation later fails, the function returns false with partially
> mutated fattr fields that callers do not reset.
> 
> Fix this by parsing into local variables and only committing them to
> fattr on success.
> 
> Closes: https://sashiko.dev/#/patchset/20260906200517.725015-1-pc%40manguebit.org
> Fixes: 78e26bec4d6d ("smb: client: parse uid, gid, mode and dev from WSL reparse points")
> Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
> Signed-off-by: Paulo Alcantara <pc@manguebit.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: Shyam Prasad N <sprasad@microsoft.com>
> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> Cc: Bharath SM <bharathsm@microsoft.com>
> Cc: Namjae Jeon <linkinjeon@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/smb/client/reparse.c | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
> index bb2caf01cd895..7a7189f547efd 100644
> --- a/fs/smb/client/reparse.c
> +++ b/fs/smb/client/reparse.c
> @@ -680,29 +680,30 @@ static bool wsl_to_fattr(struct cifs_open_info_data *data,
>  			 u32 tag, struct cifs_fattr *fattr)
>  {
>  	unsigned int sbflags = cifs_sb_flags(cifs_sb);
> +	kuid_t uid = cifs_sb->ctx->linux_uid;
> +	kgid_t gid = cifs_sb->ctx->linux_gid;
>  	struct smb2_file_full_ea_info *ea;
>  	bool have_xattr_dev = false;
> +	dev_t rdev = 0;
> +	umode_t mode;
>  	u32 next = 0;
>  
> -	fattr->cf_uid = cifs_sb->ctx->linux_uid;
> -	fattr->cf_gid = cifs_sb->ctx->linux_gid;
> -
> -	fattr->cf_mode &= ~S_IFMT;
> +	mode = fattr->cf_mode & ~S_IFMT;
>  	switch (tag) {
>  	case IO_REPARSE_TAG_LX_SYMLINK:
> -		fattr->cf_mode |= S_IFLNK;
> +		mode |= S_IFLNK;
>  		break;
>  	case IO_REPARSE_TAG_LX_FIFO:
> -		fattr->cf_mode |= S_IFIFO;
> +		mode |= S_IFIFO;
>  		break;
>  	case IO_REPARSE_TAG_AF_UNIX:
> -		fattr->cf_mode |= S_IFSOCK;
> +		mode |= S_IFSOCK;
>  		break;
>  	case IO_REPARSE_TAG_LX_CHR:
> -		fattr->cf_mode |= S_IFCHR;
> +		mode |= S_IFCHR;
>  		break;
>  	case IO_REPARSE_TAG_LX_BLK:
> -		fattr->cf_mode |= S_IFBLK;
> +		mode |= S_IFBLK;
>  		break;
>  	}
>  
> @@ -726,26 +727,29 @@ static bool wsl_to_fattr(struct cifs_open_info_data *data,
>  
>  		if (!strncmp(name, SMB2_WSL_XATTR_UID, nlen)) {
>  			if (!(sbflags & CIFS_MOUNT_OVERR_UID))
> -				fattr->cf_uid = wsl_make_kuid(cifs_sb, v);
> +				uid = wsl_make_kuid(cifs_sb, v);
>  		} else if (!strncmp(name, SMB2_WSL_XATTR_GID, nlen)) {
>  			if (!(sbflags & CIFS_MOUNT_OVERR_GID))
> -				fattr->cf_gid = wsl_make_kgid(cifs_sb, v);
> +				gid = wsl_make_kgid(cifs_sb, v);
>  		} else if (!strncmp(name, SMB2_WSL_XATTR_MODE, nlen)) {
>  			/* File type in reparse point tag and in xattr mode must match. */
> -			if (S_DT(fattr->cf_mode) != S_DT(get_unaligned_le32(v)))
> +			if (S_DT(mode) != S_DT(get_unaligned_le32(v)))
>  				return false;
> -			fattr->cf_mode = (umode_t)get_unaligned_le32(v);
> +			mode = get_unaligned_le32(v);
>  		} else if (!strncmp(name, SMB2_WSL_XATTR_DEV, nlen)) {
> -			fattr->cf_rdev = reparse_mkdev(v);
> +			rdev = reparse_mkdev(v);
>  			have_xattr_dev = true;
>  		}
>  	} while (next);
>  out:
> -
>  	/* Major and minor numbers for char and block devices are mandatory. */
>  	if (!have_xattr_dev && (tag == IO_REPARSE_TAG_LX_CHR || tag == IO_REPARSE_TAG_LX_BLK))
>  		return false;
>  
> +	fattr->cf_uid = uid;
> +	fattr->cf_gid = gid;
> +	fattr->cf_mode = mode;
> +	fattr->cf_rdev = rdev;
>  	return true;
>  }
>  
> -- 
> 2.53.0
> 
> 

Did not apply
