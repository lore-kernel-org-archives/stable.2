Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37583DCDA3;
	Sun, 18 Oct 2026 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341623; cv=none; b=uHWX+V29Gk8gEb23isYsG7DI+WVy3Mj+TzOCGDDdh95jjMrlbsvL4XoTjq/AfV70znZ5bAbrnejq0e9g0giHkPyFBdSRhiFjQhB5ze7n2Zc8HAERydQOiuVzj2COvcfkkKX4DxnQ8uPPOg7BRR16rK3qooyAUdy8UEV22fsACAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341623; c=relaxed/simple;
	bh=FWWx4ZDDiefNjXUI40xB48tjNw6eYDDMGUG7UkGpCvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEbHYHyxpfFyGDXBp6R7fvQ8I8ggZgQASKO1GoKEY9Z+GWidcSjX+hUjId4m4JcOgy3JfxvILZ3AKwbitmJwkGDkbNwfrtoB1U9OQfMvuqGhDDhfZFPly+G3WfED6YEPYYDiMtSn5ugXLyHZQmZEqCK26vzEmwp7ycBUL/Lb1c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vd68iNZi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vd68iNZi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE551F000C4;
	Sun, 18 Oct 2026 16:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792341620;
	bh=oqQrhlRf8+x6VkzRmu9l8lO/YsPfcMgj53KVL4Drs3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vd68iNZij3CfVWSXBbbAj08PC725nSk5NIW90FA3PFGtaSQz28KaxR5DCWMfSSMdc
	 YJLxJV7BUepHrPYeGxt6m1Rkj+cMaYat9upaFWCiqv+gVQwsPHvFjp0jcfogyf+0fd
	 +Z1diFWo7Q5IufixqWZoNc/RD39EHB839rIxLPSk=
Date: Sun, 18 Oct 2026 18:38:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Eklavya Singh <eklavyasingh2106@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+1459655b2bf1e798f9d0@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadgetfs: fix use-after-free after a failed bind
Message-ID: <2026101825-glacial-slapstick-a133@gregkh>
References: <20261018163434.129569-1-eklavyasingh2106@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018163434.129569-1-eklavyasingh2106@gmail.com>

On Sun, Oct 18, 2026 at 04:34:34PM +0000, Eklavya Singh wrote:
> gadgetfs_bind() takes its reference on dev_data only right before it
> returns success, but its error path calls gadgetfs_unbind(), which
> always calls put_dev(). So when bind fails it drops a reference it
> never took.
> 
> With ep0 open the count is 2, one for the superblock and one for the
> open file. A failed bind takes it to 1, closing ep0 frees dev_data,
> and the superblock still points at it. The next open of ep0 then takes
> dev->lock on freed memory:
> 
>   BUG: KASAN: slab-use-after-free in _raw_spin_lock_irq+0x3d/0x50
>    gadget_dev_open+0x4b/0x1b0 drivers/usb/gadget/legacy/inode.c:1919
> 
> syzbot gets there by making an allocation in bind fail, which is the
> "failed to start USB Gadget filesystem: -12" message right before the
> report.
> 
> Take the reference before anything in bind can fail, so that
> gadgetfs_unbind() always has one to drop.
> 
> I tested this on dummy_hcd by writing a config to ep0 with fail-nth
> set and then closing and reopening ep0, for every fail-nth value the
> write goes through. Without the patch KASAN reports the use-after-free
> right after the first failed bind. With it, 122 failed binds give no
> reports and the last bind works.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+1459655b2bf1e798f9d0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1459655b2bf1e798f9d0
> Cc: stable@vger.kernel.org
> Signed-off-by: Eklavya Singh <eklavyasingh2106@gmail.com>
> ---
>  drivers/usb/gadget/legacy/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
> index 67c6ffaf4..f5b97dcd4 100644
> --- a/drivers/usb/gadget/legacy/inode.c
> +++ b/drivers/usb/gadget/legacy/inode.c
> @@ -1688,6 +1688,7 @@ static int gadgetfs_bind(struct usb_gadget *gadget,
>  		return -ENODEV;
>  	}
>  
> +	get_dev(dev);
>  	set_gadget_data (gadget, dev);
>  	dev->gadget = gadget;
>  	gadget->ep0->driver_data = dev;
> @@ -1706,7 +1707,6 @@ static int gadgetfs_bind(struct usb_gadget *gadget,
>  	spin_lock_irq(&dev->lock);
>  	dev->state = STATE_DEV_UNCONNECTED;
>  	spin_unlock_irq(&dev->lock);
> -	get_dev (dev);
>  	return 0;
>  
>  enomem:
> -- 
> 2.55.0
> 

Isn't this already fixed in the usb-next tree?

thanks,

greg k-h
