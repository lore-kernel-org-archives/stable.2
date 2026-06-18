Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B313314DE
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 19:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781812252; cv=pass; b=OHkLbx3eny37GsogxVHUQm8jy/VSxmgmMQ/jDiHz+zibbCPZEaWvFnThnRj5qmEHVuIs5WZSFc8JJ2CkKjMD+chM/WfuDGiSeHrT7c3NZ0K5uO5aN4p9AA+BHXGVA/qKUx9NYT8kuN5b3Lo8xLxyEMYazjMfLOpkPupdKh5h7/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781812252; c=relaxed/simple;
	bh=P9K6WR14chQp/Ykaia/hOnkHUL4bXVc8ij7gFNX9Z9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B6Z07AvwkSP7oIWOzBxO28TUNdcwe53XwmTWPAMUTDftjeNd0gG31Tsoo807EfKJUcUlrek/+Lzz23HKsBnTuwe+6j7x9BaGIkGNrnCpckvGQHfVazOB41SkaR9U2xa1bJdUuv5Pi4rdSmBlK42fo63ZxRiJ2snyuYvVmhQdWt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLxsnCT+; arc=pass smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLxsnCT+"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-488b3fd8d0dso588815b6e.1
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 12:50:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781812250; cv=none;
        d=google.com; s=arc-20240605;
        b=gnjGbSuvJAU7mrF36dJGne7G4qphTX+UszLtdSEVtTi6iGU/I3JI2nSWirL8H9HBUy
         4BgcKOPEGCftHK6OduUqWj7kt7wQXhmKLccYOTCkSmCs5qIDCAo+VsREMUsJzoO5DDy+
         n4RY/i4xk964cYM+wtaK3iToz265j0LA6z+OQO0zFB1x9xUY7HSVQAP1c1/oX13XFsmm
         EAbq/PDIRxQn9zCYStkQ7lNHNo6jvmK6AiaA0STjz9gp0WwJ+7zZzGPqgnP0wh6vUj5d
         Zb3u5RHeiD9GOVpFEq2o9b6JQlwOekJPh0V5zhn0atZ4FFPWVbSDf0zC3hgBlsiWPm0T
         f3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=m8uk5CE0hl2VcGC6A9L2aPBCej9W50w25Jg10wWbW2o=;
        fh=W1TPaP6BOWsQfjatMKYXGmX2DuXbSVHiarRVogwR8Ko=;
        b=QW58UXOpBmUSJZlyUSXdJ3qQb1SIiYTMt5CdzqpcMLqRZF0ucR+zSzjFkvNUR7XHwZ
         HK7+X/s1lsnVtjNJ0NAjW0VwNNHtztccgbuUwCwwfK7E2uXbHIGuwv4lOzUBAtktEFgT
         Oj+nc5Zu0pkwa9O/T/j0G7CI1V7DXT0rpq8Bg5UVGE5mj3yDcJZJMqEMiYOYF84XHotH
         J7nqwJOZio8GHEsRgqavZQmuvm2/bWPOMnzjvZn07IXn10byo+B83DpVRIqlkUT4oLMs
         LVk3pooBXuBOn0OviKQKL8S+OH8vNVJzGph6nkarFkwEQkw0hS32Xq4p0CMl8z0/XOLw
         ySBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781812250; x=1782417050; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m8uk5CE0hl2VcGC6A9L2aPBCej9W50w25Jg10wWbW2o=;
        b=NLxsnCT+owKQf9pE1V+vntJwbRp9CQfRJMlTzKZ3tvOg/tbdIQKyvWgHsFPUeyrkN9
         QFBgeahcF1Wv3EGhN1PXruIg7YeKNamWDPEIeeGpUWERVc+0/pr6c14kY9aP7iS5kbpe
         QXk/+NuA9xknKbne7OgnUNaTpllJ0wAOAOLn0J1Za2upAKy417PbyOUQexSyMD2SszHE
         rMExqjNx4oF+KsmhSqHVuJ9zZvfQ2dsuZb3+Fz3m4+MlBa/wEmtN5cmYbsIS1lQabDp1
         oJNqYu1LZYwTAeJJ/WLGKf+ilxH9HqDC5Y/4/3TA+89WS1FYzL53dD+X/YLXrv1At8nr
         fl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781812250; x=1782417050;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8uk5CE0hl2VcGC6A9L2aPBCej9W50w25Jg10wWbW2o=;
        b=Pp0reN/EHBzCpFW37Z3XmVJGWkxrm1VDExpUMifHO2wp6tVqPRthAE2lhEkaCIDTC8
         Uow6UfWCIj5wsh8j71iabHIpuMjM3Z52O+zQw/1wwoqmZ0UqWMj0dnqQwaRkJVtcILtB
         MG7zKgh0DqPfispxp43vy1DMpcmn5DfVoJVTfPYjnQQSz4Kd331P9gxrmBShvtNpnovS
         93vpaK+oUFO9fPBa61pE4Ae86fXE/OaMBFFnrqnUZ8X5unuLB5C+5HLeyaPV5bDFfi9X
         Y+RYgV9/tIilSdCtEnd5wH+ERtcBmQLg22FrYW9q+NJa73Z1EfKp2Ur+/sXIEHkvW7+X
         ab3w==
X-Forwarded-Encrypted: i=1; AFNElJ/hvkSnmOfCI2vkmmBU8oHQz+nA4u8BI/0ZNsxR9eFVXakKr39lubNcvHiRt2WKKbIrR3/K1qU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNVNCd812C4KdixuUCSwP7+LTRwtASdOTuP3mJI9N+2hShGejk
	RKhJHul2aGLm1HiZsBd5Se0Ah1TcVWmz+RdYadF3R2btPbqgP/Zr+U0zvrlxy1CxWEgLEjIKhIt
	10dzhy8m/M2MHJVZgBNfR+WVOfE4jjV4=
X-Gm-Gg: AfdE7cmnq//368YHsnJl58aw3UDl1Tk+fCXsdh/ocfMFWv5wXK9XP5+IXNOw/NZ6lyd
	cmwkO/cumOdx4eAhd22um8QNWhnKz7lxooXITCdFZyRR3EU2Op5Kq0Nf2OIXrYq/tGIQSzzM5XM
	b4J9oaKqlz1p03XW8Qbdhk2ZSpGOnW7fIJ6OIJRUdFjmCrhJ+Ee+0YeNYhYihmfDiNMA0mASw3/
	iFDxa+sKtIHGlYTk3aVTuw1LWJsTYyG/Y9xQXaQg53Ee+gC64UGyJuKf7ypq0l9Kh97yz7BeuWv
	R8MejkH89i6h00DdDWJdYsSVyuo=
X-Received: by 2002:a05:6809:184:10b0:489:6f90:2f2d with SMTP id
 5614622812f47-4896f9030c5mr155901b6e.20.1781812249493; Thu, 18 Jun 2026
 12:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610215649.98274-1-devnexen@gmail.com> <5663f0e9-cde5-4943-9e77-267cd92f8742@ideasonboard.com>
In-Reply-To: <5663f0e9-cde5-4943-9e77-267cd92f8742@ideasonboard.com>
From: David CARLIER <devnexen@gmail.com>
Date: Thu, 18 Jun 2026 20:50:38 +0100
X-Gm-Features: AVVi8Cc0IYNE825PggY2ZAv2H0gQHi_P04Y0cM-7LkS7GzGPut8mV1A8QGwa_sg
Message-ID: <CA+XhMqwEJxtqBxTAF4XSJxkXW_FGYgEzU1E89bydVvJofnnLRg@mail.gmail.com>
Subject: Re: [PATCH] media: mali-c55: Fix scaler factor overflow for large
 crop sizes
To: Dan Scally <dan.scally@ideasonboard.com>
Cc: Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dan,

On Thu, 18 Jun 2026 at 20:35, Dan Scally <dan.scally@ideasonboard.com> wrote:
>
> Hi David, sorry this one slipped through the cracks
>
> On 10/06/2026 22:56, David Carlier wrote:
> > The horizontal and vertical scaling factors multiply the crop dimensions
> > by MALI_C55_RSZ_SCALER_FACTOR, a Q4.20 factor of (1 << 20). Both operands
> > are 32-bit, so the multiplication wraps before the result is stored in
> > the u64 scale variables. For any crop dimension of 4096 or more (the
> > maximum is 8192) the value overflows; an 8192 to 4096 downscale yields a
> > TINC of zero, so the scaler never advances and the output is corrupted.
> >
> > Cast the crop dimensions to u64 before the multiplication.
> >
> > Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
> >   drivers/media/platform/arm/mali-c55/mali-c55-resizer.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-resizer.c b/drivers/media/platform/arm/mali-c55/mali-c55-resizer.c
> > index c4f46651d..0713e7d43 100644
> > --- a/drivers/media/platform/arm/mali-c55/mali-c55-resizer.c
> > +++ b/drivers/media/platform/arm/mali-c55/mali-c55-resizer.c
> > @@ -422,8 +422,8 @@ static int mali_c55_rsz_program_resizer(struct mali_c55_resizer *rsz,
> >       mali_c55_resizer_program_coefficients(rsz);
> >
> >       /* Program the V/H scaling factor in Q4.20 format. */
> > -     h_scale = crop->width * MALI_C55_RSZ_SCALER_FACTOR;
> > -     v_scale = crop->height * MALI_C55_RSZ_SCALER_FACTOR;
> > +     h_scale = (u64)crop->width * MALI_C55_RSZ_SCALER_FACTOR;
> > +     v_scale = (u64)crop->height * MALI_C55_RSZ_SCALER_FACTOR;
>
> Might be nicer to define the macro with ULL instead of a cast, what do you think?

even better, using BIT_ULL here ;) cheers.
>
> Thanks
> Dan
>
> >
> >       do_div(h_scale, scale->width);
> >       do_div(v_scale, scale->height);
>
