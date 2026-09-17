Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E1F4D8D9B
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644743; cv=none; b=nTgiOZaJTfVKjKl97AGO9VyjslL7Tow4PHHyayZ+NmcZ7dW//elb7Z7YAAs4A3s7TUDi3F4HNKWmiElaN1N7R58cagodzPSu/GPpVkF6pZN8UfVFySgPEk1UIlgHf9IsNRR7KmGNQMQKOqW6f9EYx/cYGJ7Kv+64mThDynOzlVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644743; c=relaxed/simple;
	bh=IyCIlfpBqcFVcqvncqkGmcYZjEwlPLPnFA/OcK511dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOm4pQjzqsgDOyMTtEzDCLZmb+elMSepc6anCl5k1CY3bSIp6lI+W3kRuM5eL7KcoUFB6MmPKGU4cb6KzddLCP0rMC6vu3OEeyh+AtHYw4FsKHb9uzIjH1LstaANxqfNO0IPfXpCFwax9wP/vNUyyP3DbWMrIzziU7Q4dtoT+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=W0dwIc9b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aCoJpG3T; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="W0dwIc9b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aCoJpG3T"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F08807A0084;
	Thu, 17 Sep 2026 07:32:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 17 Sep 2026 07:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789644740; x=1789731140; bh=U0ETmnhwds
	GPaS/UtDTV7ZaG4Ly9BgpTN0uTAhXlx4k=; b=W0dwIc9bcHVVQKxiIBkeW1w7F+
	EmNcQNvsdYt92b+9Ptfj6h1Wl+Zwe98yrIUszNKiA1ylootVL86a++DGN5QjK+Nc
	I7quxCdgqSDEwSFziLVK9RIQpxFwB8weW0oVXWQ/OX1U0wvhiRfyQoW6jMu8MeJI
	WjpbQgrVuQwxr7KLCx7ZWkfvt4afcpeEht+ePrUdmn4JpPVBpaWgbH3uK8oDuTGe
	hBQtAie8RpYqp5aJbzLp70EjTGCZm1NhzyAtor+uGk37kEwfq3tqP8BdkLlSjEsS
	5fVTWBvx7W9Pu0bOsUKFVhtoB/Bz2XPwjoQOhtD01JV3Q+skAxDTHot8GVUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789644740; x=1789731140; bh=U0ETmnhwdsGPaS/UtDTV7ZaG4Ly9BgpTN0u
	TAhXlx4k=; b=aCoJpG3TFS/SJ1eUOQLTAF97Ko/lFnPVYJBcKr8Fi+/D88KxuQj
	8JFLBWuvNImsdyQwNK8L5EKnenhG/dHpdjLbEqtPQ3ZiZ9Que0wfe+bq9u1X5Kwh
	Cb0x/ULbMlU+FWLbrNJhXw43yRXDQwLm5+lV9gR19TtXESezUmkIlcKSpP0yPTjA
	dbgoo/vNXhIN5VzY+d1cTRszPtb9p2Qm4fWgOKNyPciTA0rA2OU9mXXliZ01WEF2
	Yc0Wx2W/K7ZFMn9GHBS29oWF3gjCGNyOtLuQtPU3pG6C/ZbxPF+ZnK5YPduEETSu
	gpt4+orTiCUFesfCb5l7bvpbVqjtt2H3R+Q==
X-ME-Sender: <xms:xM-ralX1zLmyN-eOMOM0hv6g3VNbgae1VhvDLx92ZhMJIvPqmfY3dQ>
    <xme:xM-raqwai1HELpH3G_ykCXVsqnylHBASI09Ax3GtWujfQDR_3wXUt77P-usS5WmYd
    0R2TdIi4lpRpjQ2-dMC7SvDU8Z8DcmmEbnXFdFAqnEdhSHEJeE>
X-ME-Received: <xmr:xM-rakxrK5DiaeHDeBuWH6VV7J7g76RAWL-Un1kArU_Zg-o0sxbyxrCAOjCG>
X-ME-Proxy-Cause: dmFkZTF4jFiT15z3EbwAIVeQmog/+LzdR3rdSS4kef5wRAKtv+TIqGirGhPlI3lt/OE9Ra
    npdRV3UYI/cduvupjyyRcBubDqBc0ek2p2+XQVV0pu5xb/wJAqsaf0TJXY6vhcpcl+VATZ
    ihGgF8MuZmnCTRI0LLIriieSbLkIEN6I/pn5+VyLyh8SYwpqaqNfn++pf7xtdOvIUPl7L1
    LHCZH8DKL2rLuT3Y58i3fUC5XGhl4Q1z344hzQ7uzkuHpZXdtyUYioqZUtwYmejY3InanH
    dJd/PaQ+byZU600eiJjfHAx0MA1WXA0yiivqoBpPjKCsHJ/kRFAYlYH1nYpMxYc8asiUR1
    TQAdNwYKjrK05kEhd2D77B9t0DsN1WEUVz8NLtoPYfiJwRN0WjnDoXv5gMmAZ9zn8tu8dB
    sAcL3Phsb+zNocyBMn6ZdqIKLLODJ4OzqQBCbmnwjDViTjlTMZaaFVAMro5ygTrqyQKjwB
    HJ0jdi/v1sE9yuGEmZLS6alzNz0+Hv8oVeUYHRe/JmeTGfyt2BX5NnIp96w8BzaNa0sDq7
    2cvvVDpsbNYnqezQgGXnzRrnjqlbh1CL6s4rRpvwjyww6hFxq5hYGBSPhKRmBXduuiSVgo
    d46YJxBlrOCiKKxp7OgAkcipFi6SstQfQGSNLyU3XRnwel6J3SrjOqNXuiEA
X-ME-Proxy: <xmx:xM-ran02EdUi8GHKlteNzETaK4qjW8vpmOxCkWFeT2DBPVvoDES2ww>
    <xmx:xM-raqoUALOvZiHXjI9tppHWwgi7tckoNj8_YqE1WDf4DfGVb-7ycw>
    <xmx:xM-ralAIMgNVcno1gtbmAh0jcp3B4mQ27gocX44h9fzG2fb8AO2rfA>
    <xmx:xM-rajr7QJzwmtqvV8qo00n4mfkzLARBRfMRF8Aw0so9ZmL6FDnobg>
    <xmx:xM-rapIdtaPRtG70MtPoDkTX51FPgSqJlZNZs0Dfion2M_J9nSc18_hQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Sep 2026 07:32:19 -0400 (EDT)
Date: Thu, 17 Sep 2026 12:27:21 +0100
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Frank Sorenson <sorenson@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>
Subject: Re: [PATCH 6.12.y 2/2] cifs: add cifs_resize_file_locked() to guard
 fscache_resize_cookie() under i_rwsem
Message-ID: <2026091718-mowing-tactful-b271@gregkh>
References: <2026090359-ahoy-outage-a083@gregkh>
 <20260907010313.1949936-1-sashal@kernel.org>
 <20260907010313.1949936-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907010313.1949936-2-sashal@kernel.org>

On Sun, Sep 06, 2026 at 09:03:13PM -0400, Sasha Levin wrote:
> From: Frank Sorenson <sorenson@redhat.com>
> 
> [ Upstream commit 32a7af68df7361fe7cf153cf36124d04b94aec00 ]
> 
> cifs_setsize() calls fscache_resize_cookie() without holding i_rwsem.
> When the fscache cookie is active (FSCACHE_COOKIE_IS_CACHING is set),
> fscache_resize_cookie() performs a real resize that requires i_rwsem
> held exclusively.  If another file descriptor has the same inode open,
> fscache_use_cookie() was already called from that cifs_open(), making
> the cookie active.  In that case, calling cifs_setsize() from
> cifs_do_truncate() (invoked from cifs_open() without i_rwsem) races
> against concurrent fscache I/O.
> 
> Strip fscache_resize_cookie() from cifs_setsize(), making it a pure
> size/page-cache helper.  Add cifs_resize_file_locked() for callers
> that already hold i_rwsem: it calls netfs_resize_file() and
> cifs_setsize(), then temporarily activates the cookie with
> fscache_use_cookie() to perform the resize under the lock, then
> deactivates it with cifs_fscache_unuse_inode_cookie().  Using
> fscache_use_cookie() before the resize ensures correctness whether or
> not another fd already holds the cookie active.
> 
> Switch cifs_file_set_size(), smb2_duplicate_extents(), and both size-
> extension branches of smb3_simple_falloc() to the new wrapper; those
> paths already hold i_rwsem via VFS setattr, lock_two_nondirectories(),
> or cifs_fallocate() respectively.  cifs_do_truncate() continues to
> call cifs_setsize() followed by cifs_invalidate_cache(), since it runs
> without i_rwsem.
> 
> Fixes: fa724e235cfd ("cifs: add fscache_resize_cookie() to cifs_setsize()")
> Cc: stable@vger.kernel.org
> Cc: David Howells <dhowells@redhat.com>
> Cc: Paulo Alcantara <pc@manguebit.com>
> Signed-off-by: Frank Sorenson <sorenson@redhat.com>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> Signed-off-by: Paulo Alcantara <pc@manguebit.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/smb/client/cifsfs.h  |  1 +
>  fs/smb/client/inode.c   | 24 +++++++++++++++++++-----
>  fs/smb/client/smb2ops.c |  9 +++------
>  3 files changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
> index 0935d2168fa65..9f90f2cab55a4 100644
> --- a/fs/smb/client/cifsfs.h
> +++ b/fs/smb/client/cifsfs.h
> @@ -136,6 +136,7 @@ extern ssize_t cifs_file_copychunk_range(unsigned int xid,
>  
>  long cifs_ioctl(struct file *filep, unsigned int command, unsigned long arg);
>  void cifs_setsize(struct inode *inode, loff_t offset);
> +void cifs_resize_file_locked(struct inode *inode, loff_t offset);
>  
>  struct smb3_fs_context;
>  extern struct dentry *cifs_smb3_do_mount(struct file_system_type *fs_type,
> diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
> index a37abb0311253..96e0534c244bf 100644
> --- a/fs/smb/client/inode.c
> +++ b/fs/smb/client/inode.c
> @@ -2965,7 +2965,23 @@ void cifs_setsize(struct inode *inode, loff_t offset)
>  	cifs_i->time = 0;
>  	truncate_pagecache(inode, offset);
>  	netfs_wait_for_outstanding_io(inode);
> -	fscache_resize_cookie(cifs_inode_cookie(inode), offset);
> +}
> +
> +void cifs_resize_file_locked(struct inode *inode, loff_t offset)
> +{
> +	struct fscache_cookie *cookie = cifs_inode_cookie(inode);
> +
> +	lockdep_assert_held_write(&inode->i_rwsem);
> +
> +	netfs_resize_file(netfs_inode(inode), offset, true);
> +	cifs_setsize(inode, offset);
> +
> +	if (!cookie)
> +		return;
> +
> +	fscache_use_cookie(cookie, true);
> +	fscache_resize_cookie(cookie, offset);
> +	cifs_fscache_unuse_inode_cookie(inode, true);
>  }
>  
>  static int
> @@ -3031,10 +3047,8 @@ cifs_set_file_size(struct inode *inode, struct iattr *attrs,
>  		cifs_put_tlink(tlink);
>  
>  set_size_out:
> -	if (rc == 0) {
> -		netfs_resize_file(&cifsInode->netfs, size, true);
> -		cifs_setsize(inode, size);
> -	}
> +	if (rc == 0)
> +		cifs_resize_file_locked(inode, size);
>  
>  	if (rc == 0) {
>  		/*
> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> index f933dfb74fd9e..cec9e7444e015 100644
> --- a/fs/smb/client/smb2ops.c
> +++ b/fs/smb/client/smb2ops.c
> @@ -2114,8 +2114,7 @@ smb2_duplicate_extents(const unsigned int xid,
>  		rc = smb2_set_file_size(xid, tcon, trgtfile, dest_off + len, false);
>  		if (rc)
>  			goto duplicate_extents_out;
> -		netfs_resize_file(netfs_inode(inode), dest_off + len, true);
> -		cifs_setsize(inode, dest_off + len);
> +		cifs_resize_file_locked(inode, dest_off + len);
>  	}
>  	rc = SMB2_ioctl(xid, tcon, trgtfile->fid.persistent_fid,
>  			trgtfile->fid.volatile_fid,
> @@ -3624,8 +3623,7 @@ static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
>  			}
>  
>  			new_eof = off + len;
> -			netfs_resize_file(&cifsi->netfs, new_eof, true);
> -			cifs_setsize(inode, new_eof);
> +			cifs_resize_file_locked(inode, new_eof);
>  
>  			qrc = SMB2_query_info(xid, tcon,
>  					      cfile->fid.persistent_fid,
> @@ -3650,8 +3648,7 @@ static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
>  		if (rc)
>  			goto out;
>  
> -		netfs_resize_file(&cifsi->netfs, new_eof, true);
> -		cifs_setsize(inode, new_eof);
> +		cifs_resize_file_locked(inode, new_eof);
>  
>  		qrc = SMB2_query_info(xid, tcon,
>  				      cfile->fid.persistent_fid,
> -- 
> 2.53.0
> 
> 

Does not apply
