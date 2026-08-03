Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59E3403B18;
	Mon,  3 Aug 2026 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764208; cv=none; b=BMqxaKwnOk9mUJrZOitU33vyIpwPH6RlpJA3Yjfv4AX+jK8tR8iiksDmyUMAuRjzOu6EiXN0fxWMhYk6H8gQl+9XVJYWGtKQtaGhRK7t9oCnjSYP9D+d3N5mGs0UrAUwaexEAJ1YADN6q8j416p1TjgRTxDbZG8Trr0HQpfEewE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764208; c=relaxed/simple;
	bh=jzhN7G0P3UnefiVD4LUv7U9d1aE9Q85KDpdAPzK8jbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtZ2iNdsvTMv34rOvFulf+o2fBAH1LeCv1Y64/FFeUgT+e12AN2/jUlJ2sYH6EZHKfb7SIw8t/964RTfI2iwWTcsswrq9VIAK6/a1o886a8/+Vny657ZYyOqKlJZ5REasb5QF8hR7koe56AiwwmbDTEEMnovh4U9zgEErvIwBMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FryuPAVC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FryuPAVC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DBB1F000E9;
	Mon,  3 Aug 2026 13:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785764207;
	bh=l2+fO51jOU/qPRXbOfCiUow7ZWf7vFU7nX1gkv5lXqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FryuPAVCP8nbwZIZ9/pG1FvMYigFLXVoQhC1DlPGutrRZjITtjbQGaYS234x2MSEz
	 qvPSsgNaimtQy+KxhozAwkZ2aUO7eedBY3feR+oEucVurKUxKFbv0AFnTfJxxRN4dF
	 i+5ng4xszaXieWGRQRa1kh28d3H8MhGQ8f1KVQI4=
Date: Mon, 3 Aug 2026 15:36:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-usb@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+6aa97991da41499aa852@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: fix device data management error in
 gadgetfs_bind()
Message-ID: <2026080356-maternal-tapioca-3dc5@gregkh>
References: <20260803091258.85969-1-dmantipov@yandex.ru>
 <2026080336-roast-sudden-e02e@gregkh>
 <ed1607b6-0ced-487a-a241-17f1efa27dfa@yandex.ru>
 <2026080307-glamour-reveal-a851@gregkh>
 <f18f3752-f5b2-4e38-934c-9f6afbc60575@yandex.ru>
 <2026080327-tightrope-relieve-0d40@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026080327-tightrope-relieve-0d40@gregkh>

On Mon, Aug 03, 2026 at 03:26:47PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Aug 03, 2026 at 04:13:05PM +0300, Dmitry Antipov wrote:
> > On 8/3/26 3:25 PM, Greg Kroah-Hartman wrote:
> > 
> > > I'd like to drop all the "legacy" USB gadget code
> > 
> > Hm. Then I would like to ask you to mark this code with Obsolete:
> > in MAINTAINERS and wait for some grace period at least.
> 
> Grace periods never work, I'll just go make a patch to delete them all
> now and see who says anything :)
> 

Ok, it looks like people do use the raw_gadget driver for testing, so
I'll see about leaving that for now, let's see how much we can trim-down
before getting there...

thanks,

greg k-h
