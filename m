Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1329C496D5B
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257522; cv=pass; b=rLJNd+GVxw8PpD4+FFvLqBom0iSxZVGQ/eDMhw2bVESp6gT/oFRpm2m+vksH3qs6aiivMR1k7nhpvAF8xgnwjr8Hix3hUxoX5giiRymWAhiQCwoEuXwfws90r4GYT+LR1nN8lfs6bej1olLxiCOqJdWuKU7kjOsog/AQJUod8m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257522; c=relaxed/simple;
	bh=jZQJkk3KHNIcE56oWvAfHwi1YqZoDB4/A8UkPIGIqKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jpSISQ7StzEZXiDIBr9bpkj0uErpDRw268cgWxxacYtVAVyU2m+EUCGZAJIZlM2cVXlOJOJG6P9/JE7YxzkYiwG+9rWyT8BijWIV1qD1y1w6eu47kGoV0RZ+rPS9/5mK5ww1rK6B/g1a4Q+ob2MhfkblOpDfYU2nwSCJBMO4R8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkFm5kJP; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkFm5kJP"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4aa8d881so2190726d50.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 06:45:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790257515; cv=none;
        d=google.com; s=arc-20260327;
        b=jdlVnbLjJiZNSwZbJqIbOoi+J13juvt5HfpUOZ+hcpVC7EniXHu+SXCYXbhDIbIg3I
         eKhiCwaQq5NLAGNFZeFqEOJEW0okcN+Id5z9KusPKFzRrOiGxVY4t9L0+il3QytbrMyL
         BnoI7rQBqJcYqH945TtCRL0lgEJrn3Ojc63qinTB8uMUU+K7TYGRwzSRluEsAFeL6def
         wvySPAFLSvSVWN+/UwMbHPFP4kplhMT++CUYNDw82QtHtaICSR8AKBKfMwmOVsRDPMIs
         n9WIm5aRbS12yX3WsNGBGgDEgEfAN3YRJcReHDVQzQC76+AiWWoxqOMEC+usywlSpxf7
         8VHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FNNubV5ejx2bLbWQoB8ueW+/fkh0ACbiMkvSyTP+9DI=;
        fh=agakoqKwVTBWVGtsoAsMCx2V37PPbCb9EGYw6zrTLPk=;
        b=C5Btc9ltJsQq8JxxxbZsgmQdzMpSJlONISxo8TnOZHG96Dfyg16RUkZGRDSXyCuCu4
         mdc+zeUOH3igzf5h767BtlXzocLOFqee4+Jn1TeMkw47NbFueuOw2v9uMOTqp8Y8JU/6
         rLScV+2AwRcXFh+gdxDFkT4Ku5UQ6UymnxwZWTrMWqUuDbleZ2i654GvEPn6gVhqrV4X
         K+Z4zOMDa4pv/I5TPvFnwsi7t7wbi7epM603XbeNl/+Yu7+3QUpjH6wCMsVXVMzwYXrN
         zDg/jn4W4R8diSWZ/3Vje0gitz2oaDtseEYVrRo9wZUaEFrBMrUGALjZ9pVGGi4yxPH2
         Y9fA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790257515; x=1790862315; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FNNubV5ejx2bLbWQoB8ueW+/fkh0ACbiMkvSyTP+9DI=;
        b=AkFm5kJPBWhEpym/Od1w9XRnCnR2bocmI+klD0GK7b8Ymlb9HOoL+GMivc3IJ2AE6X
         yRt/DNeQika1XXDo/czBrYXzdZb6HDOgQR10fHCltgK+GmHC9QQFH/rkjoIPLSgTxcq2
         K9WCyA2S0TswE4QOnbm8M8Jd2gcFpzFgRPW5jxL27QWTt3m3ukGYrd0mlTzVimC0spcf
         zf/yxUrJSqwBwpTSfjKDSDqb8KSKNhGIxG/jjBNKJVfEdflNU1zW7taNbJxwXq1bVd5I
         M/DF7KvXoJu7JFf2Knd2ebcNlDeD8eIM8pcFVLnun4yvyE8Qu27ajYBQl4Nv6Vm7HwNB
         gYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790257515; x=1790862315;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FNNubV5ejx2bLbWQoB8ueW+/fkh0ACbiMkvSyTP+9DI=;
        b=Pvf/f6H8Ho/xeXWbZ1leyLstEkYwwA/dawUBG1zsXd0H/pH7Ez+XcWBZH76kQ0aK/S
         rH8IC+xxnCFOpivJW0XQ4oluP0DAYCLmL/tNTpZHapbfWcA24VzoaDK5J2q3n4a0cJ82
         L/nQ7rSFxqL9AUXbBG8o+LKXoRB2xST3d430MwCv8wFnUXq3wJ0bad5WdIrDnBaESczL
         iXu+e/kfjULrKYPoadv6wCQVhnuDJXoO+DW9fsFLZJsLmtjo6Z2nlGhBYMdHCR51GdrF
         eEmMbPpzzCw1AH8bJFkbV+vBTKOEWV1xSb3Y195OfF1/HtTlpT6q4mNGXm4U58iRR3fo
         ECCA==
X-Gm-Message-State: AFuF++nlJ3IZJISiYTtA5/qrDCzExBbHRagraQMNQmW77SPHcLU+S7E9
	D82efmtZPu8IcQNqeFU4cDpbcsFqo6Lb/Es8ZFrKFnCW8V2LNinrwBcA2Izkvs1g5NDWqgWIRpu
	H/uFS248DytbbV6HerqgoHmiCMycT4sw=
X-Gm-Gg: AYBFou0nwpyRqy0KHWzolSSUoa9lHNsxLAUZl4+t5CZwAhwKKr8mBCdqto5thVtNuAQ
	2g8Ki8a8e1e+Zg9Q/JhrrkISGry1XB4gjE/8+l8ZUDFVC3ctscU5lHoLpm7PCzGAQe7SEikSsfA
	bCoBmvfT1WVst4PXZeLbInjoMzjmsyJiuzac86zRCV7tb3vnDq1KbQ4oQ2BYcjfzXZV1UIEsBDg
	1zGk2kxgnFAFGmQFO/Ip1Y7J/oU/vzYwESdrgOUZU2q6okGCOHWk/H5hHsB1ZM3QTHBb77cxk7O
	gu8RfGnjSqy++HKhitzMDdiSQsLoDNKQN28K7m2UgSot91fmKyYwRiCdNQ==
X-Received: by 2002:a05:690e:118e:b0:672:d609:6bfe with SMTP id
 956f58d0204a3-672ed32167bmr1527450d50.39.1790257515508; Thu, 24 Sep 2026
 06:45:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921073847.63505-1-lgs201920130244@gmail.com>
 <dd60ce64-4af1-479e-99d3-1787a06da882@intel.com> <CANUHTR9F+D1C49MLiiy5z1snyKtbBtdU1cnuhsgr0cysp+yOcQ@mail.gmail.com>
 <af20eb97-2fca-4ab9-9759-90b210b34802@intel.com>
In-Reply-To: <af20eb97-2fca-4ab9-9759-90b210b34802@intel.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 24 Sep 2026 21:45:05 +0800
X-Gm-Features: AclHuK-k2HlTZ7P5DTUJL2j0cqyTUAaIHPGi3MajOMUrhuB7BSfKPVp4d38KpIc
Message-ID: <CANUHTR99pQfVVjNiQbVFQ9y9EAgTgxu6WbdSAcMxpWHJJuTJJg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: Intel: SST: fix platform device leak on probe failure
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: stable@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, 
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, 
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Thorsten Blum <thorsten.blum@linux.dev>, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Czarek,

Thanks for the clarification.

On Wed, 23 Sept 2026 at 16:15, Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
>
> On 9/22/2026 10:17 AM, Guangshuo Li wrote:
> > Hi Czarek,
> >
> > Thanks for the review.
>
> >>> @@ -361,15 +362,21 @@ static int sst_acpi_probe(struct platform_device *pdev)
> >>>
> >>>       ret = sst_platform_get_resources(ctx);
> >>>       if (ret)
> >>> -             return ret;
> >>> +             goto err_unregister_mdev;
> >>>
> >>>       ret = sst_context_init(ctx);
> >>>       if (ret < 0)
> >>> -             return ret;
> >>> +             goto err_unregister_mdev;
> >>>
> >>>       sst_configure_runtime_pm(ctx);
> >>>       platform_set_drvdata(pdev, ctx);
> >>>       return ret;
> >>> +
> >>> +err_unregister_mdev:
> >>> +     platform_device_unregister(mdev);
> >>> +err_unregister_plat_dev:
> >>> +     platform_device_unregister(plat_dev);
> >>> +     return ret;
> >>>  }
> >>
> >> Looks like sst_acpi_remove() does not unregister the devices either.
> >> That could be fixed by enlisting devm_add_action_or_reset() in
> >> sst_acpi_probe() without altering sst_acpi_remove() at all.
> >>
> >> Would you mind sending a separate patch updating the function so both
> >> the error path and the driver-unload clean up the device objects?
> >>
> >>
> >> Kind regards,
> >> Czarek
> >
> > I'll update the title to:
> >
> > ASoC: Intel: atom: Fix platform device leak on probe failure
> >
> > and trim the commit message as suggested, including the
> > s/machine drivers/machine board/ change. I'll also add your Reviewed-by.
> >
> > For the separate cleanup patch, do you mean something like this?
> >
> > +static void sst_unregister_platform_device(void *data)
> > +{
> > +        platform_device_unregister(data);
> > +}
> > +
> >         plat_dev = platform_device_register_data(...);
> >         if (IS_ERR(plat_dev))
> >                 return PTR_ERR(plat_dev);
> > +
> > +       ret = devm_add_action_or_reset(dev, sst_unregister_platform_device,
> > +                                      plat_dev);
> > +       if (ret)
> > +               return ret;
> >
> >         ...
> >
> >         mdev = platform_device_register_data(...);
> >         if (IS_ERR(mdev))
> >                 return PTR_ERR(mdev);
> > +
> > +       ret = devm_add_action_or_reset(dev, sst_unregister_platform_device,
> > +                                      mdev);
> > +       if (ret)
> > +               return ret;
> >
> > This would let devres clean up both devices on later probe failure and on
> > driver unload, so the explicit unregister error paths from the first patch
> > would no longer be needed after this patch.
> >
> > Would this be what you had in mind? If so, I'll follow Krzysztof's
> > suggestion, organize the related changes into a proper patch series,
> > and send a two-patch v2.
>
> I do not mind either approach. There are two problems here:
>         1) leak on probe() failure
>         2) leak on driver remove()
>
> So, two patches-approach IMHO is perfectly fine. And yes, enlisting
> devm_add_action_or_reset() closes both 1) and 2) in one go.
>
> Kind regards,
> Czarek

I'll use devm_add_action_or_reset() to handle both the probe failure and
driver removal cases, and send the updated change in v2.

Thanks,
Guangshuo
