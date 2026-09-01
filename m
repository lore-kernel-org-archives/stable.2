Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5939B357D17;
	Tue,  1 Sep 2026 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788257712; cv=none; b=C3Hu2fLTTviliTY98U0MWSRVeE7+xuGJu7OWYgqiFY7R5pA5i2fbe8mOf2uzPGf35ANh2C+pl7zePUuaDzHbjH6+LlgZkm9GKE73RkPxMKZiUuPnELT8UYfqZxrzDdxNIZE996sSArFSi2U6Y7gnd9y19npwjSTxf2cPf7Dep8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788257712; c=relaxed/simple;
	bh=ulY4BgkvHNB0zbc+jpZL/vSRL6fHXJqlcCC6mqCUMPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UimaeMoS1eHvQ5Z7wCquJdGmpUP/FrjYo9H2AkwTlQWCl1jbZN3xIOk8/3To8+SuWKZyFxmpQLpHWFV6ooTb7xdKq6wEahDmwUY5jKt6OFEhNXFwDsF+4oJ9G1DpzOpLeYpaEsJ75j1yMrKrAfPqwp5BHgDVYZMyIQXd89C065I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D5/hSDpY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D5/hSDpY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB151F000E9;
	Tue,  1 Sep 2026 10:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788257710;
	bh=omjNlM7AaIJXcpz/D/+/7yBgQTKNq3z8ieKvrlC9UJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D5/hSDpYG/TAV4tU5QT256PUjB+f4TI6Xro3Eb0Gc9fh2dmSblgNj9/I3QOK3NUkv
	 qwScVfREhh7isATmX8MuMFUONhv2Bn569GL0DAMCHdPATdH5I0PLmRdhQFIq1IWxpN
	 L9S5OQKBex7SCjAa7gOQIC2niWkSWz/iAIpzjxjA=
Date: Tue, 1 Sep 2026 12:15:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] staging: sm750fb: fix mono image source stride
 mismatch in lynxfb_ops_imageblit()
Message-ID: <2026090151-nutrient-clay-c53e@gregkh>
References: <20260728131050.37032-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728131050.37032-1-meatuni001@gmail.com>

On Tue, Jul 28, 2026 at 06:10:50PM +0500, Muhammad Bilal wrote:
> sm750_hw_imageblit() advances its monochrome source pointer by
> src_delta per scanline, and computes the correct rounded-up stride
> internally as:
> 
>         bytes_per_scan = (width + start_bit + 7) / 8;
> 
> Its only caller, lynxfb_ops_imageblit(), instead passed src_delta as
> image->width >> 3. For widths not a multiple of 8 this under-counted
> the stride, so the source pointer fell further behind the real
> per-scanline layout on every line, corrupting the rendered image.
> 
> Rather than just fixing the caller's calculation, remove src_delta
> as a parameter entirely and have sm750_hw_imageblit() advance by the
> bytes_per_scan it already computes for itself. There has only ever
> been one caller, and that caller was passing an out-of-sync
> derivative of the same width/start_bit values sm750_hw_imageblit()
> already has, so keeping stride as a separate parameter served no
> purpose beyond letting the two calculations drift apart, which is
> exactly what happened here.
> 
> Rounding up, rather than down, is the direction consistent with the
> rest of the fbdev core: struct fb_image mono bitmap data (the same
> image->data this driver receives) is walked elsewhere with byte
> strides derived from a ceiling division of width by 8. The generic
> mono bit iterator in drivers/video/fbdev/core/fb_imageblit.h advances
> scanlines with "iter->data += BITS_TO_BYTES(iter->width)", and
> BITS_TO_BYTES() (include/linux/bitops.h) is a ceiling division.
> sm750_hw_imageblit()'s own "(width + start_bit + 7) / 8" is that same
> ceiling division with an added start_bit offset, so the caller's
> ">> 3" (floor) was the one calculation out of step with how this data
> layout is handled everywhere else.
> 
> Found by code review of sm750_hw_imageblit()'s internal stride
> calculation against what its only caller was passing in, and
> confirmed with a clean -Werror build. I do not have this hardware,
> so this has not been exercised at runtime on real sm750 silicon.
> 
> Fixes: 81dee67e215b2 ("staging: sm750fb: add sm750 to staging")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
> v3: Added the version notes below, which Dan pointed out were
>     missing from v2. Added Cc: stable@vger.kernel.org, flagged by
>     Greg's patch-bot since the Fixes: tag targets an old (2015)
>     commit. Added the rounding-direction justification Dan asked
>     about, citing fb_imageblit.h's BITS_TO_BYTES() as the existing
>     kernel-wide convention for this same struct fb_image layout.
>     Moved the "no hardware" disclosure from an email reply into the
>     commit message itself, per Dan's request.
> v2: Added a Fixes tag. Moved the src_delta calculation into
>     sm750_hw_imageblit() itself and dropped it as a parameter, per
>     Dan Carpenter's review.
> 
>  drivers/staging/sm750fb/sm750.c       | 2 +-
>  drivers/staging/sm750fb/sm750.h       | 2 +-
>  drivers/staging/sm750fb/sm750_accel.c | 6 ++----
>  drivers/staging/sm750fb/sm750_accel.h | 4 +---
>  4 files changed, 5 insertions(+), 9 deletions(-)
> 

Does not apply to 7.3-rc1 :(

Can you please rebase and resend?

thanks,
greg k-h
