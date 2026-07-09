Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E9A3EDAA0;
	Thu,  9 Jul 2026 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585762; cv=none; b=oJRnKghvOjXn4tlPhBSatNaxjQyK5p0EMB4qZmQbMsP82C5YosyKFzNkvJvlhmvNIvrlP2FeRQgdeic9/VZDHHacIfyPhCQW78XNAzPfgLHo6kpYU2JoJ9ZZ6KWAg0YIEKSU0U6X6H0BhfgC3xzdBciap1eBi3M/OpfMisn/PC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585762; c=relaxed/simple;
	bh=WhtSeuqhSaf5jlQWVH/3YwXllhtJxBaIFEiwkRBWdz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isBzTP+hg2vEmqAVzAmVpr/YYCxfZHwIuZdnXnSfyngufwVoS2yoNKv+66nqtEB39sF0ryXUE6adKNBrbNy8kKHwrO/OrCRRQhdcrdydvnDGkPmxYmIJGQtf7FZDQZZ4OXxbvovSSk9uqLAlLWE03tP5hoFfrqNevygErumicJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=UJRZTj1r; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UJRZTj1r"
Received: from ideasonboard.com (net-93-65-100-155.cust.vodafonedsl.it [93.65.100.155])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7E3A14DC;
	Thu,  9 Jul 2026 10:28:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1783585707;
	bh=WhtSeuqhSaf5jlQWVH/3YwXllhtJxBaIFEiwkRBWdz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UJRZTj1rjPhLwtpsz/6KzalneGwW3/P2qXKIloBX9U9sad9VOcTteBazrRuoHUuzl
	 cUFvCXZwXXARetsO6rKFMwFFde9Hp9Fgi9s1afVMCr6xaYWTGOP24CEG6qHqPe6CzJ
	 UvnAcYX/56IU7yB8zLxC1BK/PX2sQYZ5CkpPXV3M=
Date: Thu, 9 Jul 2026 10:29:15 +0200
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: David CARLIER <devnexen@gmail.com>
Cc: Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
	David Laight <david.laight.linux@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	dan.scally@ideasonboard.com, mchehab@kernel.org, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: mali-c55: Fix unaligned access of AEC histogram
 zone weights
Message-ID: <ak9UGtj7-qOvjRmr@zed>
References: <20260702103453.348056-1-devnexen@gmail.com>
 <akd8E5jr722oTm49@zed>
 <20260703221651.41669d55@pumpkin>
 <aks7usxfDajS-W_5@zed>
 <20260706104652.GB66892@killaraus.ideasonboard.com>
 <20260706133956.39a11738@pumpkin>
 <aku6R_EI0kLUqD8e@zed>
 <CA+XhMqz2oTTy2kY_4uqvJRnoXb0am5h6hXnLFM4EPQ7Yb6N-pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+XhMqz2oTTy2kY_4uqvJRnoXb0am5h6hXnLFM4EPQ7Yb6N-pw@mail.gmail.com>

Hi David
   thanks for the investigation

On Thu, Jul 09, 2026 at 06:00:58AM +0100, David CARLIER wrote:
> > Does it ?
> [...]
> > seems to clarify this is a non-issue ?
>
> I think you're right that there's no runtime fault: arm64 has
> HAVE_EFFICIENT_UNALIGNED_ACCESS and runs with SCTLR.A off, so the
> unaligned load doesn't trap. It's really just a C-level thing - the
> (u32 *) cast is UB and -fsanitize=alignment would moan - rather than a

Out of curiosity: why is (u32 *) case a UB ?

> real bug, which is why v2 already dropped Fixes:/stable.
>
> > I still see zone_weights[] at offset 10 which is not 4 bytes aligned.
> > What have I missed ?
>
> I don't think you missed anything - the union isn't trying to move the
> array, offset 10 has to stay. The idea is just the __packed member: it

ack

> makes zone_weights_32[i] an alignment-1 read, so the compiler does the
> right thing (a plain LDR on arm64) with no cast, no get_unaligned() and
> no memcpy(). Same 240-byte layout, and it also avoids David's KASAN

So, I run this through goldbot
https://godbolt.org/z/xTf8jd884

And it seems to me the usage of __packed triggers the compiler to emit
an 'LDUR' instruction instead of an LDR.

I'm reading a bit around
https://stackoverflow.com/questions/52894765/ldur-and-stur-in-arm-v8
https://developer.arm.com/documentation/dui0802/b/A64-Data-Transfer-Instructions/LDR--immediate-
https://developer.arm.com/documentation/dui0802/b/A64-Data-Transfer-Instructions/LDUR
and it seems to me that while less efficient LDUR is meant to support
byte-indexed access while LDR requires the indexing to be a multiple
of 4 or 8 bytes depending on the destination register.

What are the implications of using LDUR vs LDR on "unaligned access"
is however not 100% clear to me.

> concern about memcpy().
>
> So if you'd like it cleaned up, in mali-c55-config.h:
>
>       union {
>               __u32 zone_weights_32[56] __attribute__((__packed__));
>               __u8  zone_weights[MALI_C55_MAX_ZONES];
>       };
>
> and index zone_weights_32[i] in the driver. And if you'd rather not
> carry the uapi churn for something that isn't a fault, I'm equally happy
> to just drop it - whichever you prefer.

I would be a bit hesitant in changing the uAPI if there is actually
nothing broken, but I'm happy to defer the call to anyone who knows
best here :)

>
> Cheers
