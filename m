Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7049E30ACFB
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 21:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783113417; cv=none; b=Zfypn8AtaGWctuNsAacjazMOs0bLP9UmGlIS+5ZCkGgRM41hZmTw1H7+j5q3hr3OphwoJfeURbrMSAGMFX9FIgmykCFnrTn+8lXOxLfESKVdyiUXnWAZew6+qZSU4cpN9Ug0yMcRyTQXSFiR1xmNI9yvrEA6ikh/fOyRvAHRt6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783113417; c=relaxed/simple;
	bh=cCkQjCePSHb28HQ2XyzUAFDSIIkdoakr3w3MVImbm6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ODEgNwe7ThxSEoA2YP7HIz3D8QvzicrjeQ4q+4UG6dVk4yTh1S1+zlm0yNbl9mILGFkyV2ZKmzy50cp+qrPis3qHahNlFoKTJz4gw7q/LYfzh9MlhoOGX2NhOcCsy7VVS/324KplFLYlRGPxcC1M1X//Sp9NBW91gD/k9IbBY9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8LjiFqh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8LjiFqh"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493bc8fda98so10231075e9.0
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 14:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783113414; x=1783718214; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C4eCszeuptfMVD03Bd+mf3Rmau3oAhlB5q7FtJvbpYM=;
        b=i8LjiFqh5EoZSxBpxrDqKOAkMrdQ0gNVu+qanDBXhMGCg01oHwb+vlCzvyptN/LuOF
         tmPwvalqmdDZkCnKTlpZGeueW42uxpOKho2EwKztdf8N3Fboj4Hz8kaQ6e4Urll/FuXu
         tKLrrJN9wLtC5Ko1KfteBrY5ftuHbrYNPBYt3XpZzZA2J79IcBYlfg4/C7aQdaPZeHTQ
         lTQHkydxOuHsrhMn3lDYMFaf6Xdze1MBRhY5ahjLH+qHK6Yevl0wglMobKPPFBUxBZSR
         dtj9HrSbGUM8Z8pfjD3LrkM13v0LjUcc9OXZpdR2SvHwM1TNStNDMA8SUYTya63kntps
         kEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783113414; x=1783718214;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C4eCszeuptfMVD03Bd+mf3Rmau3oAhlB5q7FtJvbpYM=;
        b=FDx5ZnH+XrdysOcvz32dMMTTXYpjlXzVTXexlkf1a8btLRK243qebd+zUC5Yahpgfi
         66syjRWXwjKFKaoHQMGa0oXDbJ5zxVIup4aEesWdnH3KWOOFvT+9CoDdqYT2n939+cax
         a5U0rCJvt+mDnj0z60/Q61BpoQuZGBLpwUjkzPsytvfxiQ17+uBLhS+HiVp0EWAc+uRy
         tNCLBfxWwJRh7j0CsasTJFhw+XMJmsdEo3kkHeD6A3m74byAn/KNWQqMg2Q2ceiuarRW
         5Ltjdm4gujDL4ziIPsrVv+WQ3eGdzjHCoKASaRkIlqch2zC+MIOqWZkZbO6OOCq/F7fv
         Q3fw==
X-Forwarded-Encrypted: i=1; AFNElJ8LPY59MyfgCYjo2yC0IJjEdK/NKQiUNadBADid3tv2HCWaf+OcAXjD1IDLk3QgOfvp1UJ9Kwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF/doeZPYldM7NcLiFtc6+VbWqV75Wuhub+rzYnJXeGLtBqS7M
	9x3FBy8p9r6cL+AsMMTwNiBiFs5FNDESK847BlrEfnG6bWjh2+MT3W9Z
X-Gm-Gg: AfdE7cnjbSXiE4wGd3MJwG+0cU7h4QkqNkGw0F8/JS+GHoGk7erXi+HgLMgTkrLMt5p
	F8DBr5fJdy0vFbMQXRS3Mo+OZdFxkiyQKa3Y1880aICRC6lipdr2/5R7W+vOrYRxDme2GXApcH2
	lu3BIAqIVjAWL1vuV0svvRxiPqvoKlwRoIP310wUiJNDhPv+AxwVeUB3OaRfs3Aer2a35hK0MyD
	A/+cm8vwhsMtcv3WBXD+ui5sbMbGJ0Vp/RtvYAMv3EaG3isTDMmABze0SNg+mlbFWHeN0K6VYWl
	7R3Cag/2zv0Zx6bwfX36qnWP+LUiltTblSrMG6sOLajPQgj1C+vRl7J0tv0Jz4hqPIr/uktMpO1
	gMQAMRd0Vp4BYQ6RLoGX5q0VE9+MKxSLw8sjgyMNHFSMaiHAM2hQjYu0j05OG3InS5pdG2wqDe2
	1b+RK6YfiVIv7Xo+Y50N/As7zn2nVGVYH3yTfey9T0OTCHtSfJMy+vkeCP
X-Received: by 2002:a05:600c:c1c8:10b0:492:1e36:1fe9 with SMTP id 5b1f17b1804b1-493d11fafa3mr6498625e9.37.1783113413568;
        Fri, 03 Jul 2026 14:16:53 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63ba971sm247973145e9.13.2026.07.03.14.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 14:16:53 -0700 (PDT)
Date: Fri, 3 Jul 2026 22:16:51 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: David Carlier <devnexen@gmail.com>, dan.scally@ideasonboard.com,
 mchehab@kernel.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: mali-c55: Fix unaligned access of AEC histogram
 zone weights
Message-ID: <20260703221651.41669d55@pumpkin>
In-Reply-To: <akd8E5jr722oTm49@zed>
References: <20260702103453.348056-1-devnexen@gmail.com>
	<akd8E5jr722oTm49@zed>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 Jul 2026 11:44:31 +0200
Jacopo Mondi <jacopo.mondi@ideasonboard.com> wrote:

> Hi David,
>    thanks for sending a patch to address this issue
> 
> On Thu, Jul 02, 2026 at 11:34:53AM +0100, David Carlier wrote:
> > mali_c55_params_aexp_hist_weights() packs the 225 per-zone u8 weights
> > into the ISP registers four at a time by casting the zone_weights array
> > to u32 and dereferencing it. The array sits at offset 10 within the
> > parameter block, so it is only 2-byte aligned: the u32 access is
> > unaligned, which is undefined behaviour and can fault on strict-align
> > configurations or once the loop is auto-vectorised.  
> 
> well, I don't there is a risk of undefined behaviour on ARMv8, it's
> just less efficient
> 
> >
> > The cast also reads the four weights in host byte order before they are
> > written to the little-endian register, so on big-endian hosts the four
> > weights packed into each register end up in the wrong byte lanes.  
> 
> Also we don't have any endianess issue as the IP is only found on
> little endian systems
> 
> >
> > Read the weights with get_unaligned_le32() instead, which is both
> > alignment-safe and fixes the byte order regardless of host endianness.
> >  
> 
> mmm, I read in Documentation/core-api/unaligned-memory-access.rst
> that:
> 
> ------------------------------------------------------------------------------
> 	u32 value = get_unaligned((u32 *) data);
> 
> These macros work for memory accesses of any length (not just 32 bits as
> in the examples above). Be aware that when compared to standard access of
> aligned memory, using these macros to access unaligned memory can be costly in
> terms of performance.
> 
> If use of such macros is not convenient, another option is to use memcpy(),
> where the source or destination (or both) are of type u8* or unsigned char*.
> Due to the byte-wise nature of this operation, unaligned accesses are avoided.
> ------------------------------------------------------------------------------
> 
> Which seems to suggest, if the issue here is performances, we should
> aim for something different ? (honest question here, any kind of
> guidance is appreciated)
> 
> > Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
> > Cc: stable@vger.kernel.org  
> 
> If it's only about performances, does this qualifies as a fix ?
> 
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
> >  drivers/media/platform/arm/mali-c55/mali-c55-params.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-params.c b/drivers/media/platform/arm/mali-c55/mali-c55-params.c
> > index de0e9d898..1aaf64dde 100644
> > --- a/drivers/media/platform/arm/mali-c55/mali-c55-params.c
> > +++ b/drivers/media/platform/arm/mali-c55/mali-c55-params.c
> > @@ -6,6 +6,7 @@
> >   */
> >  #include <linux/media/arm/mali-c55-config.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/unaligned.h>
> >
> >  #include <media/media-entity.h>
> >  #include <media/v4l2-dev.h>
> > @@ -203,7 +204,7 @@ mali_c55_params_aexp_hist_weights(struct mali_c55 *mali_c55,
> >  	 * of overwriting other registers.
> >  	 */
> >  	for (unsigned int i = 0; i < 56; i++) {
> > -		val = ((u32 *)params->zone_weights)[i]
> > +		val = get_unaligned_le32(&params->zone_weights[i * 4])
> >  			    & MALI_C55_AEXP_HIST_ZONE_WEIGHT_MASK;  

On LE with HAVE_EFFICIENT_UNALIGNED_ACCESS the latter generates what you
expect the former to generate.
But gcc can unroll loops and use (IIRC) 'rdp' to read two registers at once.
That will crash and burn.

The best thing would be to have a union of the two arrays with the
member marked __packed to remove the padding before it.

> 
> 
> We could do:
> 
>         memcpy(&val, &params->zone_weights[4 * i], 4);

Some of the KASAN (etc) builds might make a mess of that.
Without compiler optimisations of memcpy() it is horrid.

>         addr = base + MALI_C55_AEXP_HIST_ZONE_WEIGHTS_OFFSET + (4 * i);
> 
>         mali_c55_ctx_write(mali_c55, addr,
>                            val & MALI_C55_AEXP_HIST_ZONE_WEIGHT_MASK);
> 
> Or this could be an alternative:
> 
>         const u8 *w = &params->zone_weights[4 * i];
> 
>         val = w[0] | w[1] << 8 | w[2] << 16 | w[3] << 24;

That is a possible implementation of get_unaligned_le32() no point
doing it explicitly.

A late enough gcc will convert that to a 32bit memory read (with any
byteswap in the read or after) if unaligned accesses are supported.
Otherwise you get byte loads, shifts and ors.

	David

>         addr = base + MALI_C55_AEXP_HIST_ZONE_WEIGHTS_OFFSET + (4 * i);
> 
>         mali_c55_ctx_write(mali_c55, addr,
>                            val & MALI_C55_AEXP_HIST_ZONE_WEIGHT_MASK);
> 
> What do you think ?
> 
> >  		addr = base + MALI_C55_AEXP_HIST_ZONE_WEIGHTS_OFFSET + (4 * i);
> >
> > --
> > 2.53.0
> >
> >  
> 

