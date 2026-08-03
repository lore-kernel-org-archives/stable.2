Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A76A40A940;
	Mon,  3 Aug 2026 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763627; cv=none; b=pNqFuajzLb4RNjPxIQyR/yeyqctbTzTX4RCdSD7NICbyESVCLptleerc0yEHhPTZzuBPYEgZc5qyO74kYkPpEYQRM8OGYwrc+o+3+5XD0hQ6VgJ+gmQdwaytjq0VxLNQ7timjrOR1OMokiJH1qRc1I3aQBAC30iFOYwmyI/qeo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763627; c=relaxed/simple;
	bh=ZAs1UJTnc5myktNT9d7ssqtaWfnqDjbdx+EXdy+DlzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWRFIchfXEAmmVJXPDQoHTByYLRrX994ZiyhKfwEohJRwhY44ovstNdnY0XGwKQ5eZ9FCH4yKXl42EZS8k8khfThGJ03IAAlrF2YQT9V6fWHWHAl2SYoIzZoA2AJPIu8jg/vuzOrw7tMl6bgHM5LU8JSPtxVzhjs6RyFsVaVfJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OWkRFGSj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OWkRFGSj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DD01F000E9;
	Mon,  3 Aug 2026 13:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785763623;
	bh=HyDasUl5xJAi8s7xwyQZZPeZ+YeItyDCVXgGzPgumaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OWkRFGSjWIYCFzT+QaS4+Cm0Gn3hwkqXd8O3b5JwuqWmbylgNjogQhRJ1bLOWFajz
	 TJoL/rsWE92hJKXlZzK+rIyzT3KlvQNZMnjDvfKJOKbtplV7TpjWvriPfD5MjYQXwt
	 aF7Ti0tw0ExeSu5GH9JLTUEyqLn+aL51rZfv1sSs=
Date: Mon, 3 Aug 2026 15:26:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-usb@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+6aa97991da41499aa852@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: fix device data management error in
 gadgetfs_bind()
Message-ID: <2026080327-tightrope-relieve-0d40@gregkh>
References: <20260803091258.85969-1-dmantipov@yandex.ru>
 <2026080336-roast-sudden-e02e@gregkh>
 <ed1607b6-0ced-487a-a241-17f1efa27dfa@yandex.ru>
 <2026080307-glamour-reveal-a851@gregkh>
 <f18f3752-f5b2-4e38-934c-9f6afbc60575@yandex.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f18f3752-f5b2-4e38-934c-9f6afbc60575@yandex.ru>

On Mon, Aug 03, 2026 at 04:13:05PM +0300, Dmitry Antipov wrote:
> On 8/3/26 3:25 PM, Greg Kroah-Hartman wrote:
> 
> > I'd like to drop all the "legacy" USB gadget code
> 
> Hm. Then I would like to ask you to mark this code with Obsolete:
> in MAINTAINERS and wait for some grace period at least.

Grace periods never work, I'll just go make a patch to delete them all
now and see who says anything :)

thanks,

greg k-h
