Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849BA171BB;
	Fri, 28 Aug 2026 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787914059; cv=none; b=iqo2kog3/JzAk6dvOpG9iiC5tLSz4RcUXYHZcd8ce3BTfRyHur9/OTQe3awII53RGe7cyFmdeuzzVJSisRJnHhrQrjWy6TtBW1bqB8cp79CyTUujZFFcXUPLInLYHDTL0y+bM76qW9QTMtb1oUGAdKP9ZL784znfRz4HleVZokQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787914059; c=relaxed/simple;
	bh=1XMPfq9s8/peSYJriBfBiTolffjXu4Tw3FpoQQuODwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiMI5oNwn0+SwzsR94zssZ6vIEghLub2Rlc4aRR0gmId2XoDm+0eArB0EBzawPJez/99lMdLdl6bGoEfNiT8FyIxvKLyZwJwAcEAbaSYl9jUgMsgiGKI8eHoQfLXsVDx4kfouXxdJxT9/XWUWEyLGaeJYd7KnFQXxRi1dOaJx0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e/jrlwum; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e/jrlwum"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCE31F000E9;
	Fri, 28 Aug 2026 10:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787914058;
	bh=GK5Qn1KL0/91qocJRehEoISCM/yaKGtSM84iG8SFsO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e/jrlwum8K2QjvE7IYshKYUVKMfoM5gwtwhNy5xulfcpkQiCuhfQBYSbvEUezAzYZ
	 UKXkIIdTNZNFpCy4RAZnjXeRodjIWVBdp6g9VZfQZ3UWyY9+3xhhVBlbber+Q/TwKj
	 6yDdPf/0TXCxn3Fgyg0XXyvGo7yka3C+j8KzmHDk=
Date: Fri, 28 Aug 2026 12:45:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shengzhuo Wei <me@cherr.cc>
Cc: Sebastian Reichel <sre@kernel.org>,
	Kai Vehmanen <kai.vehmanen@nokia.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Joni Lapilainen <joni.lapilainen@gmail.com>,
	Carlos Chinea <carlos.chinea@nokia.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] HSI: cmt_speech: Fix crash on device removal with open
 file descriptor
Message-ID: <2026082802-plod-scroll-3acb@gregkh>
References: <20260828-cmt-speech-uaf-v1-1-1fed740dd225@cherr.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828-cmt-speech-uaf-v1-1-1fed740dd225@cherr.cc>

On Fri, Aug 28, 2026 at 04:09:27PM +0800, Shengzhuo Wei wrote:
> misc_deregister() does not drain file descriptors that are already
> open, so after cs_hsi_client_remove() clears and frees
> cs_char_data.hi, the ioctl and write paths still dereference it
> without any lock or NULL check:
> 
>   open("/dev/cmt_speech")                          [userspace]
>   rmmod cmt_speech                                 [removal]
>   ioctl(fd, CS_GET_STATE, 0)                       [userspace]
> 
> Fix it by reading cs_char_data.hi under cs_char_data.lock and
> rejecting calls with -ENODEV once the interface is gone;
> cs_char_release() now steals the pointer under the lock like
> cs_hsi_client_remove() does, so the interface is stopped exactly
> once between them.
> 
> Fixes: 7f62fe8a5851 ("HSI: cmt_speech: Add cmt-speech driver")
> Cc: stable@vger.kernel.org
> 
> Assisted-by: GLM:5.3
> Signed-off-by: Shengzhuo Wei <me@cherr.cc>

No blank line above the assisted-by line.


> ---
> Verified on a KASAN kernel with a software HSI controller: opening the
> character device, unbinding the client and issuing the ioctl gives

why are you unbinding?  You do know that will taint the kernel in the
future, and this is not a "normal" operation that a user could do,
right?

> 
>   KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
>   RIP: 0010:cs_char_ioctl+0x29e/0x340
> 
> and with the patch applied the same sequence returns -ENODEV.
> ---
>  drivers/hsi/clients/cmt_speech.c | 47 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 40 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hsi/clients/cmt_speech.c b/drivers/hsi/clients/cmt_speech.c
> index 7226677ebde7..4325152a5a62 100644
> --- a/drivers/hsi/clients/cmt_speech.c
> +++ b/drivers/hsi/clients/cmt_speech.c
> @@ -732,6 +732,17 @@ static int cs_hsi_write_on_data(struct cs_hsi_iface *hi, unsigned int slot)
>  	return ret;
>  }
>  
> +static struct cs_hsi_iface *cs_char_hsi_get(struct cs_char *csdata)
> +{
> +	struct cs_hsi_iface *hi;
> +
> +	spin_lock_bh(&csdata->lock);
> +	hi = csdata->hi;
> +	spin_unlock_bh(&csdata->lock);

That is not a normal "get" type operation.

Why are you not using the proper reference counting structures that you
already have here?

thanks,

greg k-h
