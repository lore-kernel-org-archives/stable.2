Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8F22BD00C;
	Thu, 27 Aug 2026 05:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787806991; cv=none; b=c0X1pyNBGBTTSTLOAXJF/5EJsyKpYQs5DFbzjruTfaR4PEKOuN7yO4gdd6ZDVfkDZbHI6QSAU6HjX6KDXsKLVQ4reptnk4aZucZELAzPrOto2CjHSlCr2n3DiQTZwzGoEv49HfwdYsruzfosN4A8kBx5pBgwGYMZfnGykpQokIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787806991; c=relaxed/simple;
	bh=+qARVZ3Vn+bsJZVhP/UquKzhmNyNprXMkZymPd3mNyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtnMAPvpMqEkJ+EuIUXGk+LoZwh7xz0b8khHEDUT95QXWEkWrecT0HpZ3/rQ8IkRT8llS7Kc0ppKBDFN6H0ZfXWhIc5x9X68BJx4pF+FSY5Gz8Sdquq3orwvgEsISEPK08NWfdVLLYY4qgqzctsSicqsz1vhpLJqLS6lDtZwSrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WBXIqTCB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WBXIqTCB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55E61F000E9;
	Thu, 27 Aug 2026 05:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787806990;
	bh=CkOiFqyPeNWAL1IU6w4pHRdEzxW6E2h2tS/Qf1gbZBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WBXIqTCB7zZMoB816mnWlxYNCo+Q0vWrji+WlGQgkyuRh1HzojIHGzGCHTgkSxjgC
	 TD2ByP8IAh1ywdDQ75RG1s6AwHZ4U3oUzM/7toI1OSKmfkm22QdpcY8FHAgCUna0o8
	 CTnX2jUN7IaL/TooiMAuN9fFF6yWWP0AErAKGbx0=
Date: Thu, 27 Aug 2026 07:03:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeffin Philip <jeffinphilip14@gmail.com>
Cc: balbi@ti.com, bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, stable@vger.kernel.org,
	syzbot+fd6ef980cf1c722be639@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: gadget: fix null pointer dereference in
 usb_put_function_instance()
Message-ID: <2026082739-shudder-stylist-86ac@gregkh>
References: <20260816061712.15547-1-jeffinphilip14@gmail.com>
 <20260827043746.13087-1-jeffinphilip14@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827043746.13087-1-jeffinphilip14@gmail.com>

On Thu, Aug 27, 2026 at 10:07:46AM +0530, Jeffin Philip wrote:
> On Sun, 16 Aug 2026 11:47:12 +0530, Jeffin Philip wrote:
> 
> >usb_put_function_instance() attempts to dereference fd inside fi struct
> >to get mod in uvc_alloc_inst() error path. However, fd is not allocated
> >until later in try_get_usb_function_instance() after allocating fi in
> >uvc_alloc_inst() and thus guranteed to be null in error path. Fix this
> >by adding a null check for fi->fd that returns if fd is null.
> 
> Friendly ping, let me know if you want me to fix anything.

It's the middle of the merge window, we can't do anything until after
-rc1 is out.

In the meantime, please help review other patches on the list so that
yours rises to the top.

thanks,

greg k-h
