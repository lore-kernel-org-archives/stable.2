Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF7930BF70;
	Mon,  3 Aug 2026 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766824; cv=none; b=NIzNEZOLeiqSGO+84tVhFE+uJtE3KOHwg7Ch2aSGzVovnC776F2R3T7bD1+JxB2g2SEVmI/SVzdjKRLXXyt4M9bz2teggaSlTXZO6o0evdZgNgyaMmRPU5oJj1/v5qwOZDh3gCBMcqS2e3I5RegjJTgKPTupvDOyLcTEKcrc2zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766824; c=relaxed/simple;
	bh=+ITnGC2SGFQFQmDlRWD6DEllwoxlwui18ukDWD7dLKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIpvEtzIJKwP7dE/GylFCGU0vhYofzWOSwT6IiE91D95or6jD4/VNQxIPPwgpPeTWVnzScqo3MMpY4DJqBWdetka3guvIG7sdd/V2UiqNMAg6skbzFog5lAK3tr1VtE61PSyaztvox5WuRJWPNnz93XUrk7u8FILFvzjltkpnT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TBjtKehz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TBjtKehz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1A91F00A3A;
	Mon,  3 Aug 2026 14:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785766823;
	bh=O4zj1sirtqDoKUOGkm0Y0huVxRSwEb5ynx7DdfSvQW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TBjtKehzv5iVJzdOa2dMmVW657QuvQgBh5btSirFUHdJYkpeNTftiWjcpae8lPCad
	 jf+dTJTl5iBLWN/rbEQnhJCkIEB/RazyKmZWJqkVegtmPQwdMSwok0KNnSGFYwoycc
	 xbPxKTqMZNG8J+QR+h/5xYndcfOjBsf9ilxRDdIc=
Date: Mon, 3 Aug 2026 16:20:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Richard Watts <rrw@kynesim.co.uk>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tty: serialize device registration and removal
Message-ID: <2026080347-marsupial-clothing-b083@gregkh>
References: <20260731142220.3000214-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731142220.3000214-1-nicoyip.dev@gmail.com>

On Fri, Jul 31, 2026 at 10:22:20PM +0800, Chengfeng Ye wrote:
> tty_cdev_add() stores a newly allocated cdev in driver->cdevs[index]
> before initializing and registering it. tty_unregister_device() reads and
> deletes the same pointer without serialization.
> 
> The race can proceed as follows:
> 
>   registration                     removal
>   ------------                     -------
>   driver->cdevs[index] = cdev
>                                    cdev_del(driver->cdevs[index])
>                                    kobject_put() frees cdev
>   driver->cdevs[index]->ops = &tty_fops
> 
> The final write accesses freed memory. Concurrent registration can also
> replace the slot while another caller is still using its cdev.
> 
> KASAN reported:
> 
>   BUG: KASAN: slab-use-after-free in tty_cdev_add+0x5c7/0x670
>   Write of size 8 at addr ffff88810b298c48
> 
>   Call Trace:
>    tty_cdev_add+0x5c7/0x670
>    tty_register_device_attr+0x458/0x810
>    gsm_activate_mux+0x105/0x2e0
>    gsmld_ioctl+0x92f/0x14d0

Hah, that's funny :)

Look in the mailing list archives for why we don't touch n_gsm issues,
ESPECIALLY by changing core tty code to work around the known
bugs/problems in that code base.

Your LLM should know not to run this code, please tell it to never do
so.

Also, you forgot to add an Assisted-by: tag :(

thanks,

greg k-h
