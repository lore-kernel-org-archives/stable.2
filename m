Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F00E322B9F;
	Mon,  3 Aug 2026 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767041; cv=none; b=WgDLBHZ9DIbZuKM6ZQEhudewffQrL6mTBmSu0gp7dD/ayoS9ulVyn+mPd90dm8RfaI8N2mvREMcBTVrcFE65kYr01fIX9DSiZrSRdA1Kdvp6svhzExjoxZp5WTofovcbp7oSoKe5VtMx087hcQmaQvzRF8H0uuxIw5nPAH8cEg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767041; c=relaxed/simple;
	bh=aSekKbAftWbGCC96Q0i3xwL75IN4A/WXdREuPsrTVlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Otlah8cAG1HJMkEQOVum+amL7tMv/a3VWnDc7EHEj8+cmj6EjGgI3FBTAWplwJaAhxkKJhPHnqkVZjVLpOth+eCUuOcc/Io4OfmXpZ4qao4hwbLHcDI66a0niiEBIuMtdi/8Ek1WnmGLHakWcSUo2ouKBWF3pNnPOOf9TOym7l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ynhFyK3h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ynhFyK3h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810C41F000E9;
	Mon,  3 Aug 2026 14:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785767039;
	bh=600GTFUWOniAJH7aQouTYU7ymNT1JPd4GLgkTOvNqNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ynhFyK3htU6gJdYg/T9qRJEcHMDByJrZ6z+BydpN7QBXgUeDgtXXqMsWt/G9FyN+J
	 a6rTO7W2dpNaxQ20C02frA6XPj4dP7LV6MtLqeRo5M2hFITbelZ2w3YTGJ1UF7uUSo
	 ro+mAyi9pfdmTyA9/RKRCfyrePBHOFPplwX0bl6c=
Date: Mon, 3 Aug 2026 16:23:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] tty: vt: fix memory leak in vc_allocate()
Message-ID: <2026080339-proofing-catsup-bee9@gregkh>
References: <20260731024550.158801-1-25181214217@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731024550.158801-1-25181214217@stu.xidian.edu.cn>

On Fri, Jul 31, 2026 at 10:45:50AM +0800, Mingyu Wang wrote:
> If the screen buffer allocation fails in vc_allocate(), the error handling
> path jumps to `err_free`. However, this path fails to release the unicode
> screen map attached to `vc->uni_pagedict_loc`.
> 
> During the early stages of vc_allocate(), the unicode screen map is either
> newly allocated via con_set_default_unimap() or shares the default unicode
> map from a previously initialized console (which increments its refcount).
> If the subsequent kzalloc() for the screen buffer fails, the err_free path
> frees the vc structure but leaves the attached uni_pagedict with an
> elevated refcount. This results in an unreferenced object memory leak, as
> the reference to the dictionary is lost and its refcount can never reach
> zero.
> 
> This issue was discovered by DevGen (an automated virtual device modeling
> fuzzer based on Syzkaller). During fuzzing with kernel fault injection
> (failslab) enabled, the fuzzer forcefully failed the kzalloc() for the
> screen buffer, exposing this error-handling path leak.
> 
> Fix this by calling con_free_unimap(vc) in the err_free path before
> kfree(vc). This safely decrements the refcount and releases the dictionary
> memory if this was the last reference.
> 
> Fixes: 34902b7f2754 ("tty: vt, get rid of weird source code flow")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> ---
> Changes in v2:
> - Added documentation in the commit message detailing the fuzzing
>   environment (DevGen/Syzkaller) and the fault injection (failslab)
>   mechanism used to discover the bug, as requested by Greg KH.
> 
>  drivers/tty/vt/vt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 8f467b22b799..4bac89ea968a 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -1134,6 +1134,7 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
>  	return 0;
>  err_free:
>  	visual_deinit(vc);
> +	con_free_unimap(vc);

Shouldn't you be checking vc->uni_pagedict_loc before calling this
function?

Right now we have callers sometimes checking this, and sometimes not,
while the function doesn't seem to care, but we should be consistant,
right?  This will only need to be cleaned up if the previous check in
this function was correct.

thanks,

greg k-h
