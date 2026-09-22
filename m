Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9E84F3EDC;
	Tue, 22 Sep 2026 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089614; cv=none; b=rDJKQgerddcUFWlo9tOCF9xqrPPWOlymCb8ba+cSL1vUgtVpP5keztpmTbaPubMrN5gXR32SZ96v7GnC5E6vySFXwLX5ernNXSqNRHrT4Rbb1Lk6XWJqCQBqnyHr9MuMEAth2vD/ub1SRvNnVWdZG9iiCgG82lMHth41VXqbeno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089614; c=relaxed/simple;
	bh=FZIpbMYCzxpWSH/Jvwy8XzI4+0omcrELLpPJD7o7m0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rk7Lz4YaMPQArM2vLRxrqa87NH2cva2uNLS0ukELUf6MUDxZZ4BAJ3ED9qwIk7nMKU5qGagNtoLmgWEMHFFPdYM9L+iKt+2Ebmhba7Oa5Sl0NFeNBe2ml/EPDBxVXWbmm1obB4bFIi/MNRU7IAXFqUIpVP7k6rV3em/GKokD3m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOeOu3IT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOeOu3IT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7999B1F000FF;
	Tue, 22 Sep 2026 15:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790089606;
	bh=53fsJdkIfxgZlnOW/zvzbnoGCJx/tK46AeJD3nm9ZF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iOeOu3ITvHkaxWjsXya2tWPh/n7hEpsoWRHiZZGTNy+y0Z79VEqZLsDaHPcumOKPs
	 9dL721/bgFKtkqi98YaTLPEDK0qYAHf9pnKGesbOftSBpxLu6L9OwYZFhwqHMie/5c
	 sR3qmUaOkHKciHz9pLZCrI1CXLDp4H1DbjE1Zw/AWXFRcM8md8pQp8CQfttYxIxBCM
	 Tk9i7JNdcX4j90QJpMu0f8UxWWQhhgpcbcaPL9cKg0SKobmaigXu65Kg9W5gpUKkcR
	 dEWUUFkIsfzPvOWSxrdDsLc67K0n4xPpUTXp6H2aQe3TQmiJvZal+7UFwUMnjeaNm9
	 ilmlk+Y84eP/Q==
Date: Tue, 22 Sep 2026 16:06:42 +0100
From: Lee Jones <lee@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>,
	Mattias Wallin <mattias.wallin@stericsson.com>,
	Ludovic Barre <ludovic.barre@stericsson.com>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Julien Delacou <julien.delacou@stericsson.com>,
	linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mfd: ab8500: fix child device leaks on probe failure
Message-ID: <20260922150642.GH3277918@google.com>
References: <20260921110909.370945-1-lgs201920130244@gmail.com>
 <20260922074137.GG2348773@google.com>
 <CANUHTR9B84LoCjOtS5N5qGO0KXSXUbZkrKZ3_GFTwXmVoPQ0SA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANUHTR9B84LoCjOtS5N5qGO0KXSXUbZkrKZ3_GFTwXmVoPQ0SA@mail.gmail.com>

On Tue, 22 Sep 2026, Guangshuo Li wrote:

> Hi Lee,
> 
> Thanks.
> 
> On Tue, 22 Sept 2026 at 15:41, Lee Jones <lee@kernel.org> wrote:
> >
> > On Mon, 21 Sep 2026, Guangshuo Li wrote:
> >
> > > ab8500_probe() registers MFD child devices before completing the
> > > remaining device initialization.
> > >
> > > On AB8540, the main MFD device batch may be registered successfully
> > > before registration of the cut-specific batch fails. In that case,
> > > the probe returns without removing the child devices registered by
> > > the earlier mfd_add_devices() call.
> > >
> > > The same issue occurs when sysfs group creation fails after the MFD
> > > children have been registered. Since the probe returns an error, there
> > > is no later teardown path to unregister those devices.
> > >
> > > Call mfd_remove_devices() on these error paths so that MFD child
> > > devices successfully registered earlier in the probe are properly
> > > unregistered and released.
> > >
> > > The issue was identified by a static analysis tool I developed and
> > > confirmed by manual review.
> > >
> > > Fixes: cca69b67b3ba ("mfd: Export ab8500 chip id to sysfs")
> > > Fixes: 9c717cf3fa16 ("mfd: ab8500-core: Add device for new RTC version for AB8540 cut2")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > > ---
> > >  drivers/mfd/ab8500-core.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
> > > index f0bc0b5a6f4a..e675223b6023 100644
> > > --- a/drivers/mfd/ab8500-core.c
> > > +++ b/drivers/mfd/ab8500-core.c
> > > @@ -1220,8 +1220,10 @@ static int ab8500_probe(struct platform_device *pdev)
> > >               ret = mfd_add_devices(ab8500->dev, 0, ab8500_devs,
> > >                               ARRAY_SIZE(ab8500_devs), NULL,
> > >                               0, ab8500->domain);
> > > -     if (ret)
> > > +     if (ret) {
> > > +             mfd_remove_devices(ab8500->dev);
> >
> > What about switching to devm_*() a.k.a. managed resources?
> >
> > >               return ret;
> > > +     }
> > >
> > >       /* Add battery management devices */
> > >       ret = mfd_add_devices(ab8500->dev, 0, ab8500_bm_devs,
> > > @@ -1243,8 +1245,10 @@ static int ab8500_probe(struct platform_device *pdev)
> > >               ret = sysfs_create_group(&ab8500->dev->kobj,
> > >                                        &ab8505_attr_group);
> > >
> > > -     if (ret)
> > > +     if (ret) {
> > >               dev_err(ab8500->dev, "error creating sysfs entries\n");
> > > +             mfd_remove_devices(ab8500->dev);
> > > +     }
> > >
> > >       return ret;
> > >  }
> > > --
> > > 2.43.0
> > >
> >
> > --
> > Lee Jones
> 
> Do you mean converting the MFD registrations in ab8500_probe() to
> devm_mfd_add_devices(), so the children are cleaned up automatically on
> probe failure, e.g.:
> 
> -       ret = mfd_add_devices(ab8500->dev, 0, ab8540_devs,
> +       ret = devm_mfd_add_devices(ab8500->dev, 0, ab8540_devs,
>                               ARRAY_SIZE(ab8540_devs), NULL,
>                               0, ab8500->domain);
> 
>         ...
> 
> -       ret = mfd_add_devices(ab8500->dev, 0, ab8500_bm_devs,
> +       ret = devm_mfd_add_devices(ab8500->dev, 0, ab8500_bm_devs,
>                               ARRAY_SIZE(ab8500_bm_devs), NULL,
>                               0, ab8500->domain);
> 
> and likewise for the other MFD batches?
> 
> If so, I'll rework the patch that way for v2.

Yes.

-- 
Lee Jones
