Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C7A3D3CEA
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 11:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782215764; cv=none; b=AMbAZisokCxgSki6TsrCqGst56Fm/xdJRxkj+oDFMnGTQD24/Hw9MbaGLa+ng7VSA7hzixwyyP+VYwXnY7bl6Xx5bC5ESQJbubOAYz+8LcgitPaz1NafAlKqCnV3V+wCSZH+fKV6tywvdMdZYkM/YrhYgUzO234q7O5UvThHFCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782215764; c=relaxed/simple;
	bh=/5xsWwS2xUnGFCsaWljXVmVzriLYZcgoN6mZ8ww728Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJks1y6mWxvi+N6NZYcTT40FtGRIJ6GcBX/xJLsVwRhgI89Fg9J82vlCuYrwUHF3z1o5UI5POjNdaO6KLc2tK/j/Hl/D/OQTP2Doq21dnmDiR7oTenCyMrNs4rgX2SEALv410OQvQI+UrTuwsAWAJrptOwFAGRU8yHFmcFEMvKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fW3nk/C9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fW3nk/C9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192401F000E9;
	Tue, 23 Jun 2026 11:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782215762;
	bh=YKaY+oipGDQj+pG1rp59NfmK2RnFUAUjoiQxt5RGKfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fW3nk/C93mwqa5jrg0k+b+buCB1TjKEDPnOSWo67Hqzpzzj0Vv966V8FRDuB1Iwd9
	 zxdR0JLIYhb198syd3CkcRGGWgJxvhdtSMooU7CIpQfdHUjSAWHYw3Z3gLvZwmMlUW
	 6e7D19Z2zqyRcwLMj7qwea6NxiLpxA6aqEHc1qUk=
Date: Tue, 23 Jun 2026 13:54:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michael Pratte <slatoncomputers@gmail.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] s2io: only arm hardware LSO for GSO skbs
Message-ID: <2026062345-kilobyte-tubby-4425@gregkh>
References: <20260623112131.752148-1-slatoncomputers@gmail.com>
 <2026062327-unengaged-apostle-5728@gregkh>
 <CAButv0efpYUSmOaqksOs0C6To6n+DQQ7vdQFq-pQWwK6Dfau+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAButv0efpYUSmOaqksOs0C6To6n+DQQ7vdQFq-pQWwK6Dfau+g@mail.gmail.com>

On Tue, Jun 23, 2026 at 06:48:18AM -0500, Michael Pratte wrote:
> On Mon, Jun 23, 2026, Greg Kroah-Hartman wrote:
> > Why not just remove the driver in older kernels as well if it is not
> > being used?
> 
> It is being used - Xframe-II (17d5:5832) in a Supermicro X5DA8 on 6.6.
> Please keep it in stable.
> 
> > And if it's not being used, why is this patch needed at all?
> 
> It's used and broken: since v4.2 (51466a7545b7) s2io arms LSO with
> MSS=0 on every non-GSO TCP frame, so the card aborts all TCP TX - links
> fine, UDP/ICMP ok, but no TCP at all. The one-liner restores it.

So what happens when 6.6.y goes end-of-life?  Why is this driver removed
if people are actually using it and willing to fix bugs in it?

I really don't want to take non-upstream patches for obvious reasons.
And for code that has been removed already, that goes doubly so.

thanks,

greg k-h
