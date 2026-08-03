Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DA53750D7;
	Mon,  3 Aug 2026 12:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759914; cv=none; b=hVxi7A4YsgzZ7XOCj5/99eJdrW1aP5gY9RfJvxS7WzTgtWnREEE8/XQGxceIlYGZaXAEmFnz9Ksgb2hcJ2520zRa5nBzLbLEyFIDDHZz0kfP0xTukV1HdNiGTPl/ctrgMUkeZYiRvm6S2QqZG8eV7JM9xHXeUAroNKkiGsVhKT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759914; c=relaxed/simple;
	bh=6AnzZuHIry/G2Vy+XSomctH4QdWeS7mCWuxp4vgSbFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2vHpOYSyFFztc8k4QKnIMH0MEBneydeRvxiVFsNJyw+0OniskxrDtgQlS7UdjmrYLBK3jK/uqSV0Q2YBcw0aVdn1uwtSweuAJuu4Hu4sMVp4LMhb+hEgYW1b5dzeASU2LMT3p3WYPlCh9TggjAfi57GC1eyGc9xMJxmATrgLXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LJcDjcQ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LJcDjcQ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB801F000E9;
	Mon,  3 Aug 2026 12:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785759912;
	bh=RY5VYHcleCFtl/JsvDXjJIgn1pRCBlEBktKzt+ezWNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LJcDjcQ72VCjJvuGpGjfRUPMuTOCG9OvVACwsItUdlpEyXLriazw1Cs8jqgJyAWML
	 aNIHLMFg7jrDV/wW8LgQgIGY+zidcoaAKMGmjILK7iSyidoZBVNRN8t0sOsbdG/kEu
	 /suyLgqXqlT4SzuIn7R/4VvXcdxP96PwWtp+OhdA=
Date: Mon, 3 Aug 2026 14:24:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-usb@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+6aa97991da41499aa852@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: fix device data management error in
 gadgetfs_bind()
Message-ID: <2026080337-ovary-grappling-8541@gregkh>
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

So this is not anything a normal user could ever hit, given the age?
It's only something that fault-injection causes?

thanks,

greg k-h
