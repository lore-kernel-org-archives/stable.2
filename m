Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235123B9600
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 10:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604334; cv=none; b=Zx+1zS0wE7C8Znovvhj/yfgXuVsh3QAUn3xbQsmsBV3lPbP9ubBFSKXja2VfK8STYz2xNHnmFxG9R+tFavyG5tZp53K2+q5NiIeP2trSz/iprOrIMPzpiUVrJswXwe1kaq8CewPwC4e8K9H7GutERu3t0G4pq0rxfGyIWeK9b9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604334; c=relaxed/simple;
	bh=EE4/3PqhRvGpR6rd3FO4Ft9v4Z2G+ZlVJ1k9PqBKwQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPADCKQ6CIMpdX0WYjj/krPLkMHN+X7S84NufXOfErLkHgJnVBhm580RGyHcDM7xByb9eDfHJN2KO69J7BMSjh82+BNO4Z1XCQRYIEaOfZrttbq1gEq3ci3L0lfNsXNXitAHETejv6HMdsfGSdsjFiTk5zL+2skUsdN2WG3X9a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ArH7H4wg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ArH7H4wg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1ACD1F000E9;
	Tue, 16 Jun 2026 10:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781604332;
	bh=IIHozKWyf1uQpSS5ZkawfF/SiTQFASoB6pE5GZb1o6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ArH7H4wgWmBCfz3QqZqM106OB9IQRy5jniAzlE9QBRm7kGn7Uw12zbedwggH5i5Zt
	 fYskpN7n7QGvCPS2QeWwPRJf+DrU49U6feDYiuTmatJo60CbXTDz5FY2jQObJawNNW
	 DSIxIfN1WbkFkB3C3nhoiPgFcmo5d8pGBGx2Jalg=
Date: Tue, 16 Jun 2026 15:34:27 +0530
From: Greg KH <gregkh@linuxfoundation.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: stable@vger.kernel.org, catalin.marinas@arm.com, lee@kernel.org,
	sdonthineni@nvidia.com, will@kernel.org
Subject: Re: [PATCH 6.18.y 0/5] arm64: errata: Mitigate TLBI errata on
 various Arm CPUs
Message-ID: <2026061658-landowner-dangling-5d07@gregkh>
References: <20260616051329.111597-1-mark.rutland@arm.com>
 <2026061655-veggie-rerun-83e6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026061655-veggie-rerun-83e6@gregkh>

On Tue, Jun 16, 2026 at 03:31:11PM +0530, Greg KH wrote:
> On Tue, Jun 16, 2026 at 06:13:24AM +0100, Mark Rutland wrote:
> > This is a v6.18-only backport of a workaround for a TLB invalidation
> > issue affecting several CPUs. The final patches landed in mainline
> > yesterday:
> > 
> >   https://lore.kernel.org/linux-arm-kernel/178157002783.358810.8206806281627742561.pr-tracker-bot@kernel.org/
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=80476f22b8b7e193b26f285a7c9f9e4b63abca16
> > 
> > This issue has been assigned CVE ID CVE-2025-10263, and Arm have
> > published a security bulletin:
> > 
> >   https://developer.arm.com/documentation/112137/latest/
> > 
> > I've pushed a copy of this backport to my kernel.org repo:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=stable-6.18/arm-4118414/backport
> 
> Should I cherry-pick these to 7.1.y and 7.0.y as well?

Ok, cherry-picking didn't work well, I gave up on patch 3...

Can you send backports for those branches too?

thanks,

greg k-h
