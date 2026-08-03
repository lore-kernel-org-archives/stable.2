Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3C63D7A07;
	Mon,  3 Aug 2026 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748567; cv=none; b=DLlfaug8YMtz20vJU8f2vI81HfLHPspQAkWhCz0X/SlQ/TS4c11LDVpk4L948qBhrGlz2tzhLKn+6W4yFSTFC8ZHnQJy08mZVJ6taoY93SOwtvnYlDmzbSQyWrvu34zzcuNnID+w8oxhf2cG6Wgkizj5ThsW38Ml6Qfz9HRLnbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748567; c=relaxed/simple;
	bh=b+WfG+D9/aFWpcsel/SW8JgM6DSzvUaMeLAfpFYTF9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzymRoNfJXLYuo9M+t0B43ZGzKOFDzn9CyAREYnzom1HEjQIRXFQmEjKWY2YZmQZIlq+i2vsPdu5RvD2S0VbKDSZwg7HwYgNsVHoqXF4h+Hfin6bagX7vW6ahbd7yfBAenAanuABJeAhKS7nCqfGmTR2jLx0AWNekf7ELEOIW2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BmMtaJ9l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BmMtaJ9l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D131F000E9;
	Mon,  3 Aug 2026 09:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785748563;
	bh=Vm236Xn218GXH0KPXmcqLVndSX5H2on+SCGR0K4QSvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BmMtaJ9lqROF+j5Y61ambifPQuMaP3BGlyP/xNG1YYBnDlkM5JRVu3dd2+tZ+1Bux
	 283ArXUqlNMEHcLY16gmkgEwb3zyeBA5ryf+pLUmWEq91bhX1yedb0ON+eLgLkfqxD
	 qFVWJNtemVK1nOMS+b82kl7aRL6fzhlr/Z7YERUw=
Date: Mon, 3 Aug 2026 11:15:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-usb@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+6aa97991da41499aa852@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: fix device data management error in
 gadgetfs_bind()
Message-ID: <2026080336-roast-sudden-e02e@gregkh>
References: <20260803091258.85969-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803091258.85969-1-dmantipov@yandex.ru>

On Mon, Aug 03, 2026 at 12:12:58PM +0300, Dmitry Antipov wrote:
> In 'gadgetfs_bind()', 'get_dev()' on appropriate 'struct dev_data'
> instance should be performed immediately after the pointer is stored.
> Otherwise an attempt to handle -ENOMEM later will issue an unbalanced
> 'put_dev()' in 'gadgetfs_unbind()', thus leading to UAF errors.
> 
> Reported-by: syzbot+6aa97991da41499aa852@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=6aa97991da41499aa852
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/usb/gadget/legacy/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

What commit id does this fix?

thanks,

greg k-h
