Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570343C1983
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822607; cv=none; b=YtNjkwZC76hLPeKX8XWZYoZLFteQ85PvHGnnp2Y5mfDJVxy5C0b299QbnuS9VhdZ8Ms9JIrZQVZRmJseCITevpu2df20F7SmJCqzj6exZ9p6BrwyE0O+KhPdOkntPSDPr8KqeMPx+VNcHUoZ++BLT5iOTsBHVumvMwccMy5LkrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822607; c=relaxed/simple;
	bh=DlR/0IpkmuXUKEcXxlA1wBfFwhxr7MTPGoncrRQJbxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftt27COaWS7uE+A9VpvOo0qQSnv/BO5hra9ad79CFSNNvIM0yIj+oWsIq+mHMVT5rup/F3Wl6kcfp9I4umJQPyTyjyKhBQix2TnA0P7DU00bqv+dRwHHVk1+uPKmv89DRivGNRAFw+sDD0udagTByc1TEzUMLfuYXA0KYdVZg88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GM1+lzJZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GM1+lzJZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA1A1F000E9;
	Thu, 27 Aug 2026 09:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787822605;
	bh=RCiJscbUkeYVFVNeae9m621yEgBkpUgXuYL1seNqKv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GM1+lzJZgLc8QwNkYU0SkQMyQjwlX4PZV9l+4ALZpgbMVuGqpuUGL7MSwe/lFZx8n
	 rCnKMM5zqV2NiZwJ1VOU+NyIpnOyhLXyocw/1LOAaJzG1iMTnq1iv526ceYIXvpGzQ
	 3fsdwa/60oZ/pgg0QAbOOQTdLLDw8gBu1Omag4B4=
Date: Thu, 27 Aug 2026 11:23:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: hexlabsecurity@proton.me, paul@paul-moore.com, sashal@kernel.org,
	stable@vger.kernel.org, stephen.smalley.work@gmail.com
Subject: Re: [PATCH 6.18.47-rc1 01/10] Revert "selinux: require a class's
 permission values to cover its permission count"
Message-ID: <2026082735-footbath-absolute-3048@gregkh>
References: <2026082710-viral-doorstep-98c6@gregkh>
 <20260827090759.4047735-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827090759.4047735-1-guanwentao@uniontech.com>

On Thu, Aug 27, 2026 at 05:07:59PM +0800, Wentao Guan wrote:
> Sorry for prev email title is garbaged...
> 
> > Why?  And this is not a real git id in the linux-stable tree.
> in stable-rc git tree.
> 
> > 
> > Do you want me to just drop all of the selinux patches from the 6.18.y
> > queue right now before I do the release?  I'll be glad to do so, but I
> > need to know why.
> 
> fair,
> 
> What happened in my side is Github Copliot review point out the issue:
> "This validation runs after symtab_insert(), so the table already owns key
> and perdatum. On an out-of-range value, the bad path frees both while leaving
> dangling pointers in the hash table, and rc is still 0, so malformed policy
> data is accepted and later accesses can use freed memory.
> Validate the value before inserting it and return -EINVAL."

I have no idea what that means at all as I can't parse LLM output well.

> In continues review, there LLM point out the mainline don`t had the issuse,
> for correct sequence is that git log --oneline
> (v6.18.46-1) selinux: require a class's permission values to cover its permission count
> selinux: reject a class permission count below its inherited common
> selinux: reject a permission value exceeding the class permission count
> selinux: more strict policy parsing
> selinux: use u16 for security classes
> Revert "selinux: reject a class permission count below its inherited common"
> Revert "selinux: reject a permission value exceeding the class permission count"
> (tag: v6.18.46, stable-gh/linux-6.18.y) Linux 6.18.46
> 
> This instead of Sasha`s series:
> 2026-08-24 22:00 ` [PATCH 6.18.y 1/3] selinux: use u16 for security classes Sasha Levin
> 2026-08-24 22:00   ` [PATCH 6.18.y 2/3] selinux: more strict policy parsing Sasha Levin
> 2026-08-24 22:00   ` [PATCH 6.18.y 3/3] selinux: require a class's permission values to cover its permission count Sasha Levin

Ok, I'll drop these for now, and wait for your backports.

But note, I'll drop this for 6.18 and older, so I need backports for ALL
of those branches.

thanks,

greg k-h
