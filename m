Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BAA373C1A
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786299595; cv=none; b=OGXDpP+nLTVni14vMLA+mGQIjqfzrBrERGnEgdbfDCQb5KqB3ooB/9dharJZqgu/VmkZ2vnRt6MexEM50ttGYH1nWm0hgpRdI5RPfiLx6MA0M3UAnmHy2E9yDtdql27w50HvxX9vq8tThEGO61oFhrtlArn7QRcWZSAu1PSYWF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786299595; c=relaxed/simple;
	bh=XPYleT6u36zVzN3ziL5qg7OYg/+s77vpVH4YACvi1bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QInLBuPEsHzYqZUxU6UyWuyODLb2zep5IJ4zprgkWkqsQqTX+4mNWqccb8E0SUNTL0eczHHo+25TN675YgaDGpljreejYFX/Aee4VVNlsumNazIOv3kCEieZu7GoWvZcL4q3GkkvG/kdbhodrIbsoxupMCQBMtTZCjXxk26Rr1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pz7bObrO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pz7bObrO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175901F000E9;
	Sun,  9 Aug 2026 18:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786299592;
	bh=dm5qeFIK6aLD1PpTEC/tXaD2GpgtowSdnXfj8JaXVS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=pz7bObrOdh7In1lseA29/Jwa7A80eMWAXKXXAQrhN+jVH0raVK4AXmiakTCBWMlK3
	 khOKdK4nwlJh6aNqkiUXML+trK5ScCq1bBaid7D7s4Sz/6RPMXKwJma7xgisHF7rRU
	 7xLUXEQlb/zWJJiN0svVo266E+9xCioZjWsmmJFQ=
Date: Sun, 9 Aug 2026 20:18:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Viktor =?iso-8859-1?Q?J=E4gersk=FCpper?= <viktor_jaegerskuepper@freenet.de>
Cc: Sasha Levin <sashal@kernel.org>, Wayne Lin <wayne.lin@amd.com>,
	Ray Wu <ray.wu@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
	daniel.wheeler@amd.com, Alex Deucher <alexander.deucher@amd.com>,
	stable@vger.kernel.org
Subject: Re: Drop "drm/amd/display: Add AV mute wait frames to
 dce110_set_avmute" from stable queues
Message-ID: <2026080937-reason-unlucky-9839@gregkh>
References: <a464c560-8f7b-4609-8bbe-b7048f603d26@freenet.de>
 <2026080756-garage-series-d50e@gregkh>
 <608ed117-5fa2-43df-b10e-738cf3b5c2d2@freenet.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <608ed117-5fa2-43df-b10e-738cf3b5c2d2@freenet.de>

On Sun, Aug 09, 2026 at 06:33:56PM +0200, Viktor Jägersküpper wrote:
> On 8/7/26 15:13, Greg Kroah-Hartman wrote:
> > On Thu, Aug 06, 2026 at 10:10:00PM +0200, Viktor Jägersküpper wrote:
> >> Hi Greg and Sasha,
> >>
> >> I noticed that the following patch is in the queues for the 7.1, 6.18 and 6.12
> >> stable trees:
> >>
> >> >From 443290d70b01e9c35830c300e3247c06581b594c Mon Sep 17 00:00:00 2001
> >> From: Ray Wu <ray.wu@amd.com>
> >> Date: Mon, 13 Jul 2026 22:23:34 +0800
> >> Subject: drm/amd/display: Add AV mute wait frames to dce110_set_avmute
> >>
> >> From: Ray Wu <ray.wu@amd.com>
> >>
> >> commit 443290d70b01e9c35830c300e3247c06581b594c upstream.
> >>
> >> Port the three-frame wait logic from dcn30_set_avmute to
> >> dce110_set_avmute so that older DCN versions (1.0, 2.0) also
> >> wait for GCP packets to be sent out before proceeding.
> >>
> >> This ensures HDMI sinks properly process the mute state,
> >> preventing garbled display after link re-establishment.
> >>
> >> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5167
> >> Reviewed-by: Wayne Lin <wayne.lin@amd.com>
> >> Signed-off-by: Ray Wu <ray.wu@amd.com>
> >> Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
> >> Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> (cherry picked from commit 414da24137ace80d8c59fefd43ba3ec9f5f854ba)
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> ---
> 
> (...)
> 
> >> Please drop this patch because it leads to a regression which I reported for the
> >> mainline kernel here:
> >> https://gitlab.freedesktop.org/drm/amd/-/work_items/5557
> >>
> >> A fix for the regression is already available, but it hasn't landed in the
> >> mainline tree yet. Since the patch above fixes an annoying issue, I propose to
> >> postpone it until the mainline tree has the fix so that both patches can be
> >> applied to the stable trees in the same release. I will notify you when that
> >> can be done.
> > 
> > Now dropped from all queues, thanks.
> > 
> > greg k-h
> 
> The fix for the regression has landed in the mainline tree, so you can
> now backport
> 
> 443290d70b01e9c35830c300e3247c06581b594c
> drm/amd/display: Add AV mute wait frames to dce110_set_avmute
> 
> and
> 
> 3141e3d61469bba2624a91c5e2407f110b33b29e
> drm/amd/display: Check for tg ops in dce110_set_avmute
> 
> to the stable kernels (7.1, 6.18 and 6.12), both have 'Cc: stable'. Note
> that the 'Fixes' tag in the second commit refers to a commit on the
> drm-next branch and not the corresponding commit from the drm-fixes
> branch, which might be confusing.

It's more than "confusing", it's flat out wrong and breaks all of our
tooling, which guarantees that we miss fixes like this...

{sigh}

I'll consider queueing these up in a future release if we get the
chance.

thanks,

greg k-h
