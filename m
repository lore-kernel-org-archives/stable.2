Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7848F435A8A;
	Thu, 20 Aug 2026 11:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787225786; cv=none; b=EWiBiSwhZRxMH8BGM7/929alaj3mpsTAJMWyWk9en9uQHGPXy1bn4eV7HhkbPR3zIovL7kzKXG5IEMydMfxwD7zFoAh/0dytjab+Quk+d17v6UumK3ILvFPacDU7sbXhhqKRW1SEVUlsLZ1HZsJNP0ijekNVhGVG0QOKKxJH+xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787225786; c=relaxed/simple;
	bh=JbLeDyxV8Z5xEnhKVmiOaC1ZHEDFGC1idH7+qPFA3zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krlb4v0ZVrhl50Y85Ko4nJ2rpfRXP3yHsWswZyfjxKcH+PFeuTS7f9F19zfUx+yM2c5UScX77nQhfSexu21CwODEEDzPpHpZv/wUwGe8DNmEjpooe1YtrdsRUaOI+w8y2N/um492hoPRMEgc6fr2xLW5txF2aeu9hGg/fbhhiXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E13vlnAc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E13vlnAc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8831F000E9;
	Thu, 20 Aug 2026 11:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787225785;
	bh=kSspzC3eJb07Txa083uOdpSlPZ1nnjBBoE97um/znN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E13vlnAcddQr1K1uCkSYdo98NGRoTdFz65IsOIJ9IZ8YEfizhUOvcQbBTSjPPddXg
	 al9xPT3l3xWIDZe4GlaestdM7vVQPxX830jXPMwM613h5QZW2OsNlGZAiOo45j592u
	 zgr6iiZuFglWlY0b3dNeE8pHgVPrsxdRw1l7u5B4=
Date: Thu, 20 Aug 2026 13:21:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: stable@vger.kernel.org, kuba@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: 6.18.45 regression with bnxt_en due to uninitialized RX page size
Message-ID: <2026082001-plunging-coroner-7128@gregkh>
References: <CAKPOu+-x_QPgp7gvApKNxd=aAONgNUmQQMbiLKwQghWd6u7Y=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKPOu+-x_QPgp7gvApKNxd=aAONgNUmQQMbiLKwQghWd6u7Y=A@mail.gmail.com>

On Thu, Aug 20, 2026 at 09:44:06AM +0200, Max Kellermann wrote:
> Hi,
> 
> after updating our servers to 6.18.45, the bnxt_en NICs would fail to
> initialize:
> 
>  page_pool_create_percpu() gave up with errno -22
>  bnxt_en 0000:c4:00.0 eno12399np0: bnxt_alloc_mem err: ffffffea
> 
> The regression appears to have been introduced by the backport of
> ad9ffc61fafeb ("eth: bnxt: support qcfg provided rx page size"). It
> obtains rx_page_size from the per-queue configuration:
> 
>  rxr->rx_page_size = rxq->qcfg.rx_page_size;
> 
> The bnxt_en driver installs queue_mgmt_ops only when
> BNXT_SUPPORTS_QUEUE_API() is true. On some NICs (like ours),
> ndo_default_qcfg is never called and rxq->qcfg.rx_page_size remains
> zero, leading to bnxt_alloc_rx_page_pool() failure with -EINVAL.
> 
> This was fixed in master by:
> 
>  1410c7416dc3 ("eth: bnxt: always set the queue mgmt ops")
>  3cf48c04966e ("eth: bnxt: make sure we populate the qcfg defaults on
> old FW/HW")
> 
> After cherry-picking these two commits on top of 6.18.45, the error
> disappeared. I suggest backporting them.

Thanks for the info, I had seen that the last commit above was marked as
"fixing" the issue, but I had missed the previous one was required to
make it work.  Both now queued up.

greg k-h
