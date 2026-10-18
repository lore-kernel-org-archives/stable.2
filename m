Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AD532B13E;
	Sun, 18 Oct 2026 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792311558; cv=none; b=WuwE5Ao1J1L5fzh4KzSmb3a2QWmTiXNxTXfOovMCJJRZStKCiWZPA4qqlZYq4eppWrQ/AAH7emn6t/YcHeA7D0OK06E+D9/+omPhuwjuqklJaCqkZcu204M/bI5ajZl0gZlgDYJfn2rif75GAU8HjE2c0PKMIMgnC+sE0ZksRMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792311558; c=relaxed/simple;
	bh=4QUD4emdW0rO2zG3qPgumkCr5bVggmy1qTIcZ2SptDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flX3W7OX6nbTqdls2yhFlqNAJYxS5iI3b5Aqlj5JhKnLh1eaYKbe7TV3EgDFbvqkXt2BrRpcHBc3P8irMayEuhWrM+CAYBtQUcGvLc4PXSH30sL2nN5tYcuLxWwbD3gmayOwwLfoE1R3ortx59PQiVc+iAwb/1Xh+4xUlJyXgHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wVCgTqDg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wVCgTqDg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9041F000C4;
	Sun, 18 Oct 2026 08:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792311556;
	bh=7+f+K98c1MlbjTLqXaEBYt49K9dOeXTOw7oluMlYA/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=wVCgTqDgjg42YIPB/LXOI/avaLk+R+y5Xnwr4Cz5lMUvVollPLcSXOumxSQhfv6VG
	 fQHDgV7n+Xv5KzMrxxmnoM4dnxAYrtj69B54cWcDLO6H8ESDAyhJ8ZjEoPmVbkinA4
	 vn/3eixzyISJ4/OeBPCxNSZjaaJaBENk5cGcsKL8=
Date: Sun, 18 Oct 2026 10:19:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Rafael Alejandro Diaz Cruz <rafad900@gmail.com>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+4a5c87a01894ca37f25c@syzkaller.appspotmail.com,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH usb-next v2] USB: gadget: Fix UAF on refcount inside
 gadgetfs_bind()
Message-ID: <2026101857-transform-hazelnut-4715@gregkh>
References: <20260905003607.1686172-1-rafad900@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905003607.1686172-1-rafad900@gmail.com>

On Fri, Sep 04, 2026 at 05:36:07PM -0700, Rafael Alejandro Diaz Cruz wrote:
> When usb_ep_alloc_request() fails, gadgetfs_bind() takes
> the following error path:
> 
> if (!dev->req)
>         goto enomem;
> // ...
> 
> enomem:
> 	gadgetfs_unbind (gadget);
> 	return -ENOMEM;
> 
> In normal case, get_dev() will be called to increment
> refcounter from gadget->dev->count but in error case,
> this increment is skipped and gadgetfs_unbind() will
> decrement it via put_dev().
> 
> Going down the error path leads to a refcount imbalance
> which will cause UAF in close()/umount() operations
> due to refcount dropping below 0.
> 
> Fix this by moving get_dev() above the error paths so
> that refcounter is incremented before the put_dev()
> call.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+4a5c87a01894ca37f25c@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=4a5c87a01894ca37f25c
> Signed-off-by: Rafael Alejandro Diaz Cruz <rafad900@gmail.com>
> Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
> ---
> Changes from v1:
>     Removed syzkaller reference in description
> 
>     Added Reviewed-by: tag. 
> 
>  drivers/usb/gadget/legacy/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
> index 3e2bce7543d4..181b19e7fc2f 100644
> --- a/drivers/usb/gadget/legacy/inode.c
> +++ b/drivers/usb/gadget/legacy/inode.c
> @@ -1679,6 +1679,7 @@ static int gadgetfs_bind(struct usb_gadget *gadget,
>  	}
>  
>  	set_gadget_data (gadget, dev);
> +	get_dev(dev);
>  	dev->gadget = gadget;
>  	gadget->ep0->driver_data = dev;
>  
> @@ -1696,7 +1697,6 @@ static int gadgetfs_bind(struct usb_gadget *gadget,
>  	spin_lock_irq(&dev->lock);
>  	dev->state = STATE_DEV_UNCONNECTED;
>  	spin_unlock_irq(&dev->lock);
> -	get_dev (dev);
>  	return 0;
>  
>  enomem:
> -- 
> 2.43.0
> 
> 

I think
https://lore.kernel.org/r/20260811060810.295666-1-khiemtranzo532001@gmail.com
was send before yours.

thanks,

greg k-h
