Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED0A424651
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 12:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783339725; cv=none; b=TD/k7vAbQPxnQkbXhuW2Lfijvm+yRAg3COXkZ1tfDxksvQM4OeCYVEJstNb9N03Y9n/2hBUq/3S9XWpLheoyEc+qE4aRhRENpmtaIeHdtUTeX0rU6Vit4MKNlHi9S3o9XOOlC+t7nSYA6TZ1uXMdS2hZgS3RTPv4WQHKylCJwHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783339725; c=relaxed/simple;
	bh=r0nMsLopU+3PUG9TIOs6IDKdoiGhf+Ksmh7NWcQxvDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N13GatNgbZhVt6lhX5K6GszrGZE2hO6/+wWyzC9SG+XIBcrMGXddvWSUIn6cvhkCo6FTQzXb4RmMB6ZnzzDVOqTiYfaudrN2BIdfBcqszPggDfq8oz90YVy/m6PPP+kJ7CfZqukOjAYTCqqkyrcNB59ZiYDtVWzh6P+MVGbfwcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aajUuWD0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aajUuWD0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA9D1F00A3A;
	Mon,  6 Jul 2026 12:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783339724;
	bh=bR9pG++rdjE091/GA3ZPkBFjn6j18xXvtzj7/DVEyK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aajUuWD0Uja9NyAUFuuAsNodZeWPUIfx8YVP1xhO9VBsiu91zNd5Grvrx17fOO9+z
	 TeXeDAAdtkMscY6X9bMulSYWcnyrTmWIUHOTCLwJ2NuIHjHMf38FKNVFSGTAI+/m7m
	 u9OufD0rcCK3USgVFA+GwOwqNQlUxCG7ujTuadhQ=
Date: Mon, 6 Jul 2026 14:08:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc: stable@vger.kernel.org
Subject: Re: f2fs: fix UAF issue in f2fs_merge_page_bio()
Message-ID: <2026070631-vaporizer-viability-d57f@gregkh>
References: <e6003504-96f1-4dc8-9e6b-e17c8f809d75@amlogic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6003504-96f1-4dc8-9e6b-e17c8f809d75@amlogic.com>

On Mon, Jul 06, 2026 at 04:52:12PM +0800, Jiucheng Xu wrote:
> Dear maintainers,
> 
> A f2fs patch should be backported from upstream mainline to the stable
> 5.15.y branches. The patch's information is shown as below:
> 
> [Subject]
> f2fs: fix UAF issue in f2fs_merge_page_bio()
> 
> [Upstream commit ID]
> edf7e9040fc52c922db947f9c6c36f07377c52ea
> 
> [Kernel version]
> 5.15.y
> 
> [Why]
> We encountered the same issue on the 5.15 kernel version. After referring to
> the modifications in the upstream, the issue was solved.

Great, please provide a working backport that you have tested for this
branch, and all of the newer stable branches, and we will be glad to
apply it.  As-is, it does not apply at all.

thanks,

greg k-h
