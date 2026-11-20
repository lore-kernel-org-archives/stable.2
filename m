Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170080;
	b=DigbYoutxWxIpvkWrSUYGbvCOn3FkrjC24D5HttnKVK9WOsD2jP0/k+8BCw/GYeGhEj3
	 raVbwtRleBuxIlFJcoV7RbvcFvanqzkPJrxDtEwuJ3CU9FZPL5WZ3Tc2pBhsiMqVLafPA
	 VStP0sgQAyO5DWnzlGCFq8F0cPVjx444/6pMkXlxkP2KfXcwNM+WCK8hfLAe5UiJ/TQBL
	 S7LiaKtzSrlZXf3td7p9KWMSy+sHVPhssFxXnPvbpmZBwWynMQvPgJTQ7LW6fvn82dc01
	 JIPj08J8U5Ce1pMA+qb2waACuNSLzWvDl6TgeElb8UtnHVJsBy/wwYXCkWq5zwliWlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170080;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tR68UGrga9DfbISA5eF+lNh9CYygJW0ofBlaya8s2rg=;
	b=F9dubozn8aOaUIpVK3QGtiRXcTTCF/zZovmLvDOk+q5yP6YfOwwmrDMjjxHnBiNSDOh5
	 A+OmvsWGgl/fhR8d0Tlc0UDO2PHcKO/kK9ktMXMf2XzaksPcawtnNoh7R6JLGhrcmIJRl
	 mY/e/uV3IIb2SyWyeAP/lCnWDqE0Xm+KBthQcFWdn9zLa9xaJu4EmzJOMBIMNXwOkNL/a
	 PGVeyFn5o4I10SAHowi7tqI0Y5RxnXLrmJXz+hTrmWgkRE/xiiQwgUpzclnKg8dN2Ccy0
	 TRahQZGWpPRZkGjWUxQ2lsIlAhbmgwjiNlwXgt98PtJAAs5nI9b379QSXJk/EgLUg+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="nCLqldn/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CEA606A339;
	Fri, 20 Nov 2026 10:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=nCLqldn/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B93F1F000CF;
	Fri, 20 Nov 2026 10:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795170079;
	bh=tR68UGrga9DfbISA5eF+lNh9CYygJW0ofBlaya8s2rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nCLqldn/XV+gsofNblJhzmQ9suugNfiHDraE7IoXTouDAKBSvAo22Kqa/QUQRczEx
	 ArdCquCItyZGv8ndD3gJWjTofw4iPiMiRZsqhT5Fo+BL9ZTcqg6V2VQnvrYLPGHLYN
	 VH2mNexGuuuGQf48G94T7WoAOLdcS6nEyV9sCmpY=
Date: Fri, 20 Nov 2026 11:21:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: viro@zeniv.linux.org.uk, r.baldyga@samsung.com, balbi@ti.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_fs: fix use-after-free in ffs_func_unbind
Message-ID: <2026112053-skating-swimsuit-9c33@gregkh>
References: <20260815013818.39466-1-shuangpeng.kernel@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815013818.39466-1-shuangpeng.kernel@gmail.com>

On Fri, Aug 14, 2026 at 09:38:18PM -0400, Shuangpeng Bai wrote:
> ffs_func_unbind() continues to access ffs after calling
> functionfs_unbind(), including taking ffs->eps_lock for endpoint cleanup.
> However, functionfs_unbind() drops the binding reference to ffs.
> 
> A concurrent FunctionFS unmount can drop the independent superblock
> reference. Either put can then release the final reference and free ffs
> before ffs_func_unbind() finishes its endpoint cleanup.
> 
> Take a temporary ffs reference for the duration of ffs_func_unbind() and
> drop it only after all post-unbind cleanup is complete.
> 
> Fixes: a3058a5d82e2 ("usb: gadget: f_fs: remove redundant ffs_data_get()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> ---
>  drivers/usb/gadget/function/f_fs.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index 44218be1e676..8acad4564b6c 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -4089,6 +4089,9 @@ static void ffs_func_unbind(struct usb_configuration *c,
>  	unsigned count = ffs->eps_count;
>  	unsigned long flags;
>  
> +	/* Keep ffs alive until all post-unbind cleanup is complete. */
> +	ffs_data_get(ffs);

Are you sure this is ok?  This means you now have a double reference.

thanks,

greg k-h
