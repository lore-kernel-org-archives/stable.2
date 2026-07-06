Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACAA3D9548;
	Mon,  6 Jul 2026 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783334818; cv=none; b=irdSYGifi/q+RdejPoH1rWqTFRLT2uJqXVPXDZqBEyVpUVtQGvTkYCPrkp9Krr6iKnnWO6RLWARUIfW6z6otx9pEaxqjIcXLS2cehL6k8LBrJPHyPs/AhI7wm+PL4otI+vj08XrrLdmqwtI+ttMCe6AaUcv+lgE+lBj/BOLY8tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783334818; c=relaxed/simple;
	bh=1PMYIF4mGnrHFr2p9GLiw80vTQEb9ubvU3AeF2nO7Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkWcHXH/rVAPIF4CnELA36sNa89+FrpsInmSw0qccJuxfbq7LlbTKO05O0udKgnJF0/fH+aRqPpJ51kv3E/pOgPZi7GPi5XHP0STKsdEMfNVTcH5AgMc/m9/JQfccMJInskwqe8+MuDWXSYpnH+wZr/p58iRpVp356yJoVTg8ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=e9qq3t/n; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="e9qq3t/n"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C46D5ABF;
	Mon,  6 Jul 2026 12:46:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1783334766;
	bh=1PMYIF4mGnrHFr2p9GLiw80vTQEb9ubvU3AeF2nO7Wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e9qq3t/nAaUSvGd2veY38lvSKx5QJGgNDR56zaoxJDugofmwxgIMza1bUdr/YRPB3
	 2cjCae4rc4ovQp83C5ExqYeyoyuXYGm3QQMXEQxE50Wg8YeYS/ocvSO6t1xvwlNKhI
	 +Ub4K6KHMx1myiE1MoF8x8A5pHbgLFqhQHTJ5nY8=
Date: Mon, 6 Jul 2026 13:46:52 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: David Laight <david.laight.linux@gmail.com>,
	David Carlier <devnexen@gmail.com>, dan.scally@ideasonboard.com,
	mchehab@kernel.org, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: mali-c55: Fix unaligned access of AEC histogram
 zone weights
Message-ID: <20260706104652.GB66892@killaraus.ideasonboard.com>
References: <20260702103453.348056-1-devnexen@gmail.com>
 <akd8E5jr722oTm49@zed>
 <20260703221651.41669d55@pumpkin>
 <aks7usxfDajS-W_5@zed>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aks7usxfDajS-W_5@zed>

On Mon, Jul 06, 2026 at 07:38:58AM +0200, Jacopo Mondi wrote:
> On Fri, Jul 03, 2026 at 10:16:51PM +0100, David Laight wrote:
> > On Fri, 3 Jul 2026 11:44:31 +0200 Jacopo Mondi wrote:
> > > On Thu, Jul 02, 2026 at 11:34:53AM +0100, David Carlier wrote:
> > > > mali_c55_params_aexp_hist_weights() packs the 225 per-zone u8 weights
> > > > into the ISP registers four at a time by casting the zone_weights array
> > > > to u32 and dereferencing it. The array sits at offset 10 within the
> > > > parameter block, so it is only 2-byte aligned: the u32 access is
> > > > unaligned, which is undefined behaviour and can fault on strict-align
> > > > configurations or once the loop is auto-vectorised.
> > >
> > > well, I don't there is a risk of undefined behaviour on ARMv8, it's
> > > just less efficient
> > >
> > > > The cast also reads the four weights in host byte order before they are
> > > > written to the little-endian register, so on big-endian hosts the four
> > > > weights packed into each register end up in the wrong byte lanes.
> > >
> > > Also we don't have any endianess issue as the IP is only found on
> > > little endian systems
> > >
> > > > Read the weights with get_unaligned_le32() instead, which is both
> > > > alignment-safe and fixes the byte order regardless of host endianness.
> > >
> > > mmm, I read in Documentation/core-api/unaligned-memory-access.rst
> > > that:
> > >
> > > ------------------------------------------------------------------------------
> > > 	u32 value = get_unaligned((u32 *) data);
> > >
> > > These macros work for memory accesses of any length (not just 32 bits as
> > > in the examples above). Be aware that when compared to standard access of
> > > aligned memory, using these macros to access unaligned memory can be costly in
> > > terms of performance.
> > >
> > > If use of such macros is not convenient, another option is to use memcpy(),
> > > where the source or destination (or both) are of type u8* or unsigned char*.
> > > Due to the byte-wise nature of this operation, unaligned accesses are avoided.
> > > ------------------------------------------------------------------------------
> > >
> > > Which seems to suggest, if the issue here is performances, we should
> > > aim for something different ? (honest question here, any kind of
> > > guidance is appreciated)
> > >
> > > > Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
> > > > Cc: stable@vger.kernel.org
> > >
> > > If it's only about performances, does this qualifies as a fix ?
> > >
> > > > Signed-off-by: David Carlier <devnexen@gmail.com>
> > > > ---
> > > >  drivers/media/platform/arm/mali-c55/mali-c55-params.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-params.c b/drivers/media/platform/arm/mali-c55/mali-c55-params.c
> > > > index de0e9d898..1aaf64dde 100644
> > > > --- a/drivers/media/platform/arm/mali-c55/mali-c55-params.c
> > > > +++ b/drivers/media/platform/arm/mali-c55/mali-c55-params.c
> > > > @@ -6,6 +6,7 @@
> > > >   */
> > > >  #include <linux/media/arm/mali-c55-config.h>
> > > >  #include <linux/pm_runtime.h>
> > > > +#include <linux/unaligned.h>
> > > >
> > > >  #include <media/media-entity.h>
> > > >  #include <media/v4l2-dev.h>
> > > > @@ -203,7 +204,7 @@ mali_c55_params_aexp_hist_weights(struct mali_c55 *mali_c55,
> > > >  	 * of overwriting other registers.
> > > >  	 */
> > > >  	for (unsigned int i = 0; i < 56; i++) {
> > > > -		val = ((u32 *)params->zone_weights)[i]
> > > > +		val = get_unaligned_le32(&params->zone_weights[i * 4])
> > > >  			    & MALI_C55_AEXP_HIST_ZONE_WEIGHT_MASK;
> >
> > On LE with HAVE_EFFICIENT_UNALIGNED_ACCESS the latter generates what you
> > expect the former to generate.
> > But gcc can unroll loops and use (IIRC) 'rdp' to read two registers at once.
> > That will crash and burn.
> >
> > The best thing would be to have a union of the two arrays with the
> > member marked __packed to remove the padding before it.
> 
> I'm not sure I got what are the "two arrays" you mentioned here.
> 
> params->zone_weights[] is uABI, it's hard to change its definition
> without really good motivations.
> 
> > > We could do:
> > >
> > >         memcpy(&val, &params->zone_weights[4 * i], 4);
> >
> > Some of the KASAN (etc) builds might make a mess of that.
> > Without compiler optimisations of memcpy() it is horrid.
> >
> > >         addr = base + MALI_C55_AEXP_HIST_ZONE_WEIGHTS_OFFSET + (4 * i);
> > >
> > >         mali_c55_ctx_write(mali_c55, addr,
> > >                            val & MALI_C55_AEXP_HIST_ZONE_WEIGHT_MASK);
> > >
> > > Or this could be an alternative:
> > >
> > >         const u8 *w = &params->zone_weights[4 * i];
> > >
> > >         val = w[0] | w[1] << 8 | w[2] << 16 | w[3] << 24;
> >
> > That is a possible implementation of get_unaligned_le32() no point
> > doing it explicitly.
> >
> > A late enough gcc will convert that to a 32bit memory read (with any
> > byteswap in the read or after) if unaligned accesses are supported.
> > Otherwise you get byte loads, shifts and ors.
> 
> To sum it up: since we can't change uABI easily, the best thing here
> is not change anything and drop this patch ?

Doesn't the patch fix a real problem ?

Fixing the uABI would be best, but as you mentioned that's more
difficult (the faulty structure got merged recently in v6.19 and we
most likely control userspace, but still).

> > >         addr = base + MALI_C55_AEXP_HIST_ZONE_WEIGHTS_OFFSET + (4 * i);
> > >
> > >         mali_c55_ctx_write(mali_c55, addr,
> > >                            val & MALI_C55_AEXP_HIST_ZONE_WEIGHT_MASK);
> > >
> > > What do you think ?
> > >
> > > >  		addr = base + MALI_C55_AEXP_HIST_ZONE_WEIGHTS_OFFSET + (4 * i);
> > > >

-- 
Regards,

Laurent Pinchart
