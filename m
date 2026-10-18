Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34194C1502;
	Sun, 18 Oct 2026 13:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792330482; cv=none; b=uEv76RscjOIFh1+aldwssxoyIKZ9SKXdO6/ny2p8LZcrUxkG7LK01v6YD++xDbeegvReN6zh97khL5Q2LBkhyDlrSmBYbasCFAH+NHLekGxXJgqM3p9VYLQeVnJOlhBZK51y5lGfxyzcL91wMS+jJAWPZf3+JYTM7SCVNplOpN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792330482; c=relaxed/simple;
	bh=tWZpPr+y5iI7rQ2kRmtRPIa9JCkBecJCd0d4FvjnUOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0mbAsTEDf+JQ7frxW1s5VYUzDiBSk+E3hf1KuBbcmn9eZ7WCd04P6Su33KuLCh7jXkJBgD0bNYfrQRqtbyRDR5db6zDlD1YrPCIE6ZivEj9oq0McwmRJphFwl6i5PA0OTytmiSQ2BKLXHZdA7iT5Gk2pUvmvf7vAywZFnhQIZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mJFwDNic; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mJFwDNic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00901F000C4;
	Sun, 18 Oct 2026 13:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792330480;
	bh=O7yz2OKqhkZNNxyQ1ZO8vH9vpGVze5rHOehgXigtANg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mJFwDNicCn7icS3SLBBY1PkBFtbtuFDDto0K3wNZqQ8pQF1nDzaXzkqQ7e+c+i3WI
	 yBUjEbKBMEMdDDsxqOIfFR+vtk6iMaKdPoEerBRof+iVZRa5CaWYnZ8+AN338PBwdU
	 O5kSCKaQGMT4QPPIlb6t4EZ2KEuPK4AalOyqrVAc=
Date: Sun, 18 Oct 2026 15:34:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yu Zhang <yuz08559@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_mass_storage: take filesem in nofua store
 to fix backing-file UAF
Message-ID: <2026101833-harmonica-jackpot-14ca@gregkh>
References: <20261018130519.65850-1-yuz08559@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018130519.65850-1-yuz08559@gmail.com>

On Sun, Oct 18, 2026 at 11:05:19PM +1000, Yu Zhang wrote:
> fsg_store_nofua() syncs the LUN's backing file when switching from async
> to sync mode:
> 
> 	if (!nofua && curlun->nofua)
> 		fsg_lun_fsync_sub(curlun);
> 
> fsg_lun_fsync_sub() dereferences curlun->filp (vfs_fsync(filp)). Unlike
> every other store that touches the backing file -- fsg_store_ro() and
> fsg_store_cdrom() (down_read), fsg_store_file() (down_write) --
> fsg_store_nofua() holds no filesem while doing so.
> 
> A concurrent close of the backing file runs under down_write(filesem) and
> does fput(curlun->filp) in fsg_lun_close() (fsg_store_file() with an empty
> path, the SCSI START_STOP eject in do_start_stop(), or forced_eject), so
> it can free the file while fsg_store_nofua() is dereferencing it:
> 
> 	BUG: KASAN: slab-use-after-free in vfs_fsync+0x20/0xe0
> 	 vfs_fsync+0x20/0xe0
> 	 fsg_lun_fsync_sub+0xa0/0xd0
> 	 fsg_store_nofua+0x138/0x160
> 	 configfs_write_iter+0x1a7/0x250
> 	 vfs_write+0x5df/0x940
> 	Allocated by task 3459:
> 	 fsg_store_file+0x150/0x1f0
> 	 configfs_write_iter+0x1a7/0x250
> 	Freed by task 3459:
> 	 __fput+0x456/0x6c0
> 	 __fput_deferred+0x10d/0x330
> 	 fsg_store_file+0x9e/0x1f0
> 	 configfs_write_iter+0x1a7/0x250
> 
> Take filesem for read around the fsync in fsg_store_nofua(), as the sibling
> stores do, so the backing file cannot be closed underneath it.
> 
> Reproduced on a mass_storage gadget over dummy_hcd by writing lun.N/nofua
> (1 then 0) from one task while another task rewrites and clears lun.N/file.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Yu Zhang <yuz08559@gmail.com>
> ---
>  drivers/usb/gadget/function/f_mass_storage.c | 6 ++++--
>  drivers/usb/gadget/function/storage_common.c | 5 ++++-
>  drivers/usb/gadget/function/storage_common.h | 3 ++-
>  3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
> index 0000001..0000002 100644
> --- a/drivers/usb/gadget/function/f_mass_storage.c
> +++ b/drivers/usb/gadget/function/f_mass_storage.c
> @@ -2663,8 +2663,9 @@
>  			   const char *buf, size_t count)
>  {
>  	struct fsg_lun		*curlun = fsg_lun_from_dev(dev);
> +	struct rw_semaphore	*filesem = dev_get_drvdata(dev);
>  
> -	return fsg_store_nofua(curlun, buf, count);
> +	return fsg_store_nofua(curlun, filesem, buf, count);
>  }
>  
>  static ssize_t file_store(struct device *dev, struct device_attribute *attr,
> @@ -3239,7 +3240,10 @@
>  static ssize_t fsg_lun_opts_nofua_store(struct config_item *item,
>  				       const char *page, size_t len)
>  {
> -	return fsg_store_nofua(to_fsg_lun_opts(item)->lun, page, len);
> +	struct fsg_lun_opts *opts = to_fsg_lun_opts(item);
> +	struct fsg_opts *fsg_opts = to_fsg_opts(opts->group.cg_item.ci_parent);
> +
> +	return fsg_store_nofua(opts->lun, &fsg_opts->common->filesem, page, len);
>  }
>  
>  CONFIGFS_ATTR(fsg_lun_opts_, nofua);
> diff --git a/drivers/usb/gadget/function/storage_common.c b/drivers/usb/gadget/function/storage_common.c
> index 0000003..0000004 100644
> --- a/drivers/usb/gadget/function/storage_common.c
> +++ b/drivers/usb/gadget/function/storage_common.c
> @@ -415,7 +415,8 @@
>  }
>  EXPORT_SYMBOL_GPL(fsg_store_ro);
>  
> -ssize_t fsg_store_nofua(struct fsg_lun *curlun, const char *buf, size_t count)
> +ssize_t fsg_store_nofua(struct fsg_lun *curlun, struct rw_semaphore *filesem,
> +			const char *buf, size_t count)
>  {
>  	bool		nofua;
>  	int		ret;
> @@ -424,11 +425,13 @@
>  	if (ret)
>  		return ret;
>  
> +	down_read(filesem);

guard()?

That's what happens when you use a LLM for kernel work, it only knows
old-styles of what to do.

thanks,

greg k-h
