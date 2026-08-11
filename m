Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F561DB92C;
	Tue, 11 Aug 2026 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786459804; cv=none; b=Iuf1CwLSNVly7XGua4yhDeHNBnBlx3istW4sOuGhqj1xWWo80JhWHGwNo3PbiSzQxMZC8J4UVCHNEwstWlTsVOQBHYA9vFlr3L6DN4ezl9BzZLGvM9oabSqAhZ4eBTMyNnz9VMjRO9YdN9UrRnzdKECxJe5wKQoLKcYrTQ1yYT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786459804; c=relaxed/simple;
	bh=zRwE3xlnsm+jC7icMPSdXXnkc0ck3+TtXumWQ9paDYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8gF7APDoxq33x0oEomqfuuhOrLvfiU04qSSujWDR14ysEHPFxLMY0SpelZUIz0NUtHTa+CCh493pnpEULp2k37RVvXe1XO2uPhsrSLsr0rpo/YYGYSGbe6YZq4pFiBjLXrUuXqg3oW2Mt/uMH5YRvlzC4WveF9YkIpUt4e2cxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=if5MxDxH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="if5MxDxH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497FC1F000E9;
	Tue, 11 Aug 2026 14:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786459803;
	bh=+GV3pM78AH/wU7QdIrvRueXFbVGczAPa7x+8KVjGSzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=if5MxDxHil54txAn2+jeNYH/t9yh1CHjV4NqM7iaCZWG5zPYQRsvn4BxqIkyHb5Sp
	 zjM3+KdaQQIrVDlZzG8oWaNT1dXGmXrujNUUadqEKNFfdAM1p0B6ggVdoA7TBZ4LEq
	 bHha+twfG29cOjxuRz8C0FRAQWQPYJbC7PYTjx0OdaChqqL2GcoIEbNjo0rQfuqxxj
	 wy0OkkN83LOLGirr1LNHtT/Qdyt7LkAHBtB5n4ZvYuQgDeCVrPh0NUDyv66Ljni53c
	 hEg2ryFh1BWgHIBZexkJhOfJZLw+2XQ85684zy8CCgh4LEj51hWUnUJ67+BzoebRdx
	 UuokgaVt7WRYQ==
Date: Tue, 11 Aug 2026 16:49:57 +0200
From: Michael Grzeschik <mgr@kernel.org>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net/9p/usbg: fix descriptor cleanup use-after-free
Message-ID: <ansuE8ZWqWueu-fE@line.checkpat.ch>
References: <20260731150414.3135662-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731150414.3135662-1-nicoyip.dev@gmail.com>

On Fri, Jul 31, 2026 at 11:04:14PM +0800, Chengfeng Ye wrote:
> usb9pfs_free_func() frees the f_usb9pfs object before calling
> usb_free_all_descriptors().  The usb_function passed to the latter is
> embedded in the freed object, so removing the function from a gadget
> dereferences freed memory.
> 
> The failing teardown sequence is:
> 
>   configfs unlink
>     usb9pfs_free_func()
>       kfree(usb9pfs)
>       usb_free_all_descriptors(f)
>         dereference the embedded usb_function
> 
> KASAN reported:
> 
>   BUG: KASAN: slab-use-after-free in usb_free_all_descriptors+0x138/0x190
>   Read of size 8 at addr ffff888106a73088 by task poc/95
>   Call Trace:
>    usb_free_all_descriptors+0x138/0x190
>    config_usb_cfg_unlink+0x1f0/0x2f0
>    configfs_unlink+0x321/0x6f0
> 
> Free the descriptors before freeing their containing object.

Although this is a copy of https://lore.kernel.org/all/20260529081817.77898-1-zhaoyz24@mails.tsinghua.edu.cn/
which actually came earlier than your, I like the commit message here better.

Acked-by: Michael Grzeschik <mgr@kernel.org>

> Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
>  net/9p/trans_usbg.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
> index 419cda13a7b5..8c2f0d8592c8 100644
> --- a/net/9p/trans_usbg.c
> +++ b/net/9p/trans_usbg.c
> @@ -725,8 +725,6 @@ static void usb9pfs_free_func(struct usb_function *f)
>  	struct f_usb9pfs *usb9pfs = func_to_usb9pfs(f);
>  	struct f_usb9pfs_opts *opts;
>  
> -	kfree(usb9pfs);
> -
>  	opts = container_of(f->fi, struct f_usb9pfs_opts, func_inst);
>  
>  	mutex_lock(&opts->lock);
> @@ -734,6 +732,7 @@ static void usb9pfs_free_func(struct usb_function *f)
>  	mutex_unlock(&opts->lock);
>  
>  	usb_free_all_descriptors(f);
> +	kfree(usb9pfs);
>  }
>  
>  static int usb9pfs_set_alt(struct usb_function *f,
