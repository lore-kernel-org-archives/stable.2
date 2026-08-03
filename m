Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E661C2F90C9;
	Mon,  3 Aug 2026 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759968; cv=none; b=JIQMrNYb9X8PXPXrlDm7QGGsAIPXrkZM+fSGbeD85IslWEIljF68x/D3Fesjf0LIpKtTqVygbHfUeb5j2HIdn52Vz9FWwn5aQliWlQ9xr14aIz4dyax7c9YcfJt1GN6dUmledbMiwI8DR8ezS28YgfigNCCbBF5/x0QhZhpq5K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759968; c=relaxed/simple;
	bh=xvaOws1UOZ/+BujwRDg4TXZU45FFRgbCg7dzPC7/i8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXvk+iXlr7WH0rGgXTmHjHDpC1Fvz+YkuFn468Qc1PA4S5Co4KJpyzsev07HDS9pbZHrI9hXrdkDjx9gfEOxg646U5WHk07UkKF3QL0fSKNWwl3loopPx/Xw6p4GBHt/m0W6+1qwvKZRIaHWm6iNxTDyNXWAD/eb/2PAJIF3lts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZISC7ieh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZISC7ieh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3AAE1F000E9;
	Mon,  3 Aug 2026 12:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785759967;
	bh=PXkHEzr7RZJvxPZpsGmY6xtIqRv+eofIrIJIMUmCey8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZISC7ieh/7YQt4em9FlW8Rr8PYQc1QPu0U20jtTWR1Hkl8HP4RhFJx0RcbPMHiFQv
	 HS57Wawz+FaBM+WZ0N0EfwMcN8MANXDSwGR/wLMMxKT08G6/e7be4IFgfQ1n5jPYNR
	 QwM2rhKG5BC3ViFfho3f9Lzro02WNvwFLow2rz+s=
Date: Mon, 3 Aug 2026 14:25:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-usb@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+6aa97991da41499aa852@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: fix device data management error in
 gadgetfs_bind()
Message-ID: <2026080307-glamour-reveal-a851@gregkh>
References: <20260803091258.85969-1-dmantipov@yandex.ru>
 <2026080336-roast-sudden-e02e@gregkh>
 <ed1607b6-0ced-487a-a241-17f1efa27dfa@yandex.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed1607b6-0ced-487a-a241-17f1efa27dfa@yandex.ru>

On Mon, Aug 03, 2026 at 01:33:08PM +0300, Dmitry Antipov wrote:
> On 8/3/26 12:15 PM, Greg Kroah-Hartman wrote:
> 
> > What commit id does this fix?
> 
> IIUC this code is really ancient and 1da177e4c3f4 ("Linux-2.6.12-rc2")
> looks the only match.

Also, do you actually use this code?  I'd like to drop all the "legacy"
USB gadget code, given that syzbot has suddenly just woken up and is
finding lots of issues that no one has ever reported, as I don't think
anyone actually uses this at all.  But it would be good to be sure.

thanks,

greg k-h
