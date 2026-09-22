Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A63418340
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065053; cv=pass; b=hJizT7eYtwhhU1CacRON8MRddfc3r7qIl5A/z5NVCXk17Ea29ijWdfG/Gpouk+EZ8B0jpyC+r4T0R0600Bd1xSPHen+wZUk/vLqwcTgsvGSj1DGYmgSTx2YPFC9Ax4WmF0QZ+fvfAJjozQQylYupPVG/Q5omyLgdJTuEj6K4/iQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065053; c=relaxed/simple;
	bh=j8oOfovRmLewVX/ZIXchvTplxAiNODpkmMBMcI+S5WQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ec05CFiveYZNxuDYCfHHBbE4Dn3cfutyrutmQe+wkVHvt+8XOTygvm9sBERN80tiZ60bHspChA+giQW+Ep5kw2Vb6SYq4z6VMhreOEfpEoeEvLsR/NnQNjcKpGpxAENyBE28fFw7yRdRE9x5dxBcqA/TDuxooqRC6RAAD206xMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlTbhVxO; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlTbhVxO"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab19125so3835200d50.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 01:17:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790065051; cv=none;
        d=google.com; s=arc-20260327;
        b=gJQTXzi2dshFamLgHwWC0i+w99rKf6pK+mU3hwH3GNHyV1wFtcLnjHjSQtFasq+fQO
         +JeW/20ROGBEmbR30NXDEIch0zXQQ4ikaE8QmQWntlrKq7V2jP6d4s69Y9Sr5Rg8MSw1
         7ltiKqLqFMzy4/2YuQSlWHnihsOoe11qt8uq6moXmMcNZiiGDfkP5qvoQxQC4RVScSOD
         VHO3KcgwqHu6A8YsZjGzgzX1S7LK75M5ht8d57+JilRnWNqItSrIxwxbXdS7VVL7zvwx
         lSQDaDo5Jb49yyplG8HWFsMflnjjc21Anj1GxHbr+9wX9UByy+GsN7Zb64KYv4xUy57x
         9oSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vBfgPYH3xqS4b5IB6dzOxOSHigmrLH/EHKKr5wvFYwc=;
        fh=agakoqKwVTBWVGtsoAsMCx2V37PPbCb9EGYw6zrTLPk=;
        b=ArlmdFB4RLHB/D8HYrAkrm+nZEEa8aihrAHgt1CgtOK6YoA6eZBuTEvy80JqLOmQwK
         Ti2A7LKbmRfWywz7sO+Lxp9ltqVuubfhaiLswn0e3fG/MvgYp4UIOijcEe8vtrkopaxP
         e614qmp+jzX+Or7a8STJYLMTqCP2TPptszuDlVG7RI37D2i6Z4QP34MXooeYPTnvCTeS
         5c8ov5L8KX9qaogeKv8Rpx3Sdks5QED2dPOtaIzpTKPGxG8eUVYkjGEfmuVNxFTlX8it
         L6DJfYvqF6u+CK6e9ZJJItDBlpKjf8hj9uRsTfCZlao5CCAe6cKs5WZQWfmXans8WNQC
         2+bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790065051; x=1790669851; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vBfgPYH3xqS4b5IB6dzOxOSHigmrLH/EHKKr5wvFYwc=;
        b=GlTbhVxO2A6vPW+hwN87bN12BcwLVeelMIFP2m2Xg7uLsR5l+i3M09HKoai/m5vc+y
         hHkm58Me2TK6RpmpdTc8M5BSIMz1NqkqFaBojHpA0J26sLZsomrQ4Y5bcWTr8nwu28wA
         QyU2AjKjVgvwqU/Yic5cq/VfEN98FWHZCFyo3JvUxF1fYIIstXHnBEn+WGq4jhW2Lshl
         tDmA8zGbFQM8RmmduyT75awLNgzIYbKjJGVcHVdz9Ss0Tyjue/smRa0WuoW6HUEVn2CA
         1BOi1eGGZKpjv+FneCH4r0+d6ec9LF93UwRP600heNMVVmASSs7zOs/dh3Pc1eJZ6DWU
         o9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790065051; x=1790669851;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vBfgPYH3xqS4b5IB6dzOxOSHigmrLH/EHKKr5wvFYwc=;
        b=beviyEH16EWByNy/5heBmsKqJ8zZCyz1rPQgx/HVe5nQeIFffL36JQbdVymcF+ztls
         hQqsoPEoP/bSlQxmPxR0RbN4HNyds1QKoilPJ1oUsSDOU/zPyw9+qAEmmHQTLxaBoFbt
         /pdJObrpOvAhvzP9QdHXI+OCHbM8fo+KcSEpIBZQlnRN2vCJsnrfTvwANyWQ1nV9wiY7
         590MfSM9x3rmTlp4FnNK28dYOBDF8b899rsnZNxFN1S/bYIsewvKLj0/K565cetV0wqb
         6Q9n3wtYuy57ajDK/u7U/Zqg+MWBx1ukqaicB1mUhSlO1pcUojalyW0K3403t4npLtnj
         sl5w==
X-Gm-Message-State: AFuF++k58GuV3mvV0ZnDwSMXXVDmEs6QRwdmk0lWKZcumZaHf/E1DpZm
	Ls0BPpeSA0wgPBPZi2fEvyDWQLtNWXRoUa+EI1UfdclX52f8HCjrfhLWMbclQptiJhSwTwsIS8L
	VRjq0qEfTHyijf2Zitu3KdZzBK+GaPUQ=
X-Gm-Gg: AYBFou0C5bCS/G8ah1Ryy7f8mLNS0Kvj96xod1PC7uucPQ8YNENR//GKlIgpOOvvCVH
	cMLNuMxoQPEQ1XrHuJfMl6fpGj481YKCQPEgxmLiOskNYXUjZuMGRQpc8eR5kOQ0ia1r65tVXsM
	bJHkKuve2EDOUjuPUP+urTSDFxqeugUye6o3s5AY+s2Ibxb6j1ShhwQLRl56+/K7i94zKMDJ/hn
	817+JHhhJQ+y+gEwHWFDFdejzo6c6TZSN3vxzNlthjpLem7lKBN+hR/y9xHXQ0A148yabYjkyma
	o2jIaNFKD89deL1FBsmDKFegmyEnFS4odGW/13Kj7VCxUUbJw821QYb+vLAsHqaklweF+zQfyM/
	L7sA=
X-Received: by 2002:a05:690e:1181:b0:671:70d2:527b with SMTP id
 956f58d0204a3-6717fd6a661mr4552451d50.62.1790065051220; Tue, 22 Sep 2026
 01:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921073847.63505-1-lgs201920130244@gmail.com> <dd60ce64-4af1-479e-99d3-1787a06da882@intel.com>
In-Reply-To: <dd60ce64-4af1-479e-99d3-1787a06da882@intel.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 22 Sep 2026 16:17:18 +0800
X-Gm-Features: AcwNN1VVB2-e-7AnvOjQHk0rNG0E7RaHB9itWJcRpS2P7W5iTDsETsT01Vfbeag
Message-ID: <CANUHTR9F+D1C49MLiiy5z1snyKtbBtdU1cnuhsgr0cysp+yOcQ@mail.gmail.com>
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

Thanks for the review.

On Mon, 21 Sept 2026 at 17:31, Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
>
> On 9/21/2026 9:38 AM, Guangshuo Li wrote:
> > sst_acpi_probe() registers platform devices for the SST platform and
> > machine drivers using platform_device_register_data(), but does not
> > unregister them when later probe steps fail.
>
> s/machine drivers/machine board/
>
> The above paragraph alone is sufficient, please drop everything else in
> the commit message.  There is no need to write wall-of-text for a fix
> addressing a missing error path.  In case this wall was provided by an
> agent, relevant Assisted-by: tag is needed in the tag area.
>
> You can keep the very last sentence if you want to.
>
> > If machine device registration fails, the already registered SST platform
> > device is left registered. The same leak happens when
> > sst_platform_get_resources() or sst_context_init() fails after both
> > platform devices have been successfully registered.
> >
> > A registered platform device owns resources allocated by the platform
> > device core and must be released with platform_device_unregister() so
> > that the device reference is dropped and platform_device_release() can
> > free the backing platform_object.
> >
> > Unregister the created platform devices on all failure paths to restore
> > the missing cleanup.
> >
> > The issue was identified by a static analysis tool I developed and
> > confirmed by manual review.
> >
> > Fixes: caf94ed8629a ("ASoC: Intel: bytcr_rt5640: fixup DAI codec_name with HID")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>
> For the commit title: please update to:
>         ASoC: Intel: atom: Fix (...)
>
> Provided both the commit title and message are updated, feel free to add:
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
>
> > ---
> >  sound/soc/intel/atom/sst/sst_acpi.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
> > index 73624e1b138a..a1f16083bd3d 100644
> > --- a/sound/soc/intel/atom/sst/sst_acpi.c
> > +++ b/sound/soc/intel/atom/sst/sst_acpi.c
> > @@ -352,7 +352,8 @@ static int sst_acpi_probe(struct platform_device *pdev)
> >       if (IS_ERR(mdev)) {
> >               dev_err(dev, "Failed to create machine device: %s\n",
> >                       mach->drv_name);
> > -             return PTR_ERR(mdev);
> > +             ret = PTR_ERR(mdev);
> > +             goto err_unregister_plat_dev;
> >       }
> >
> >       /* Fill sst platform data */
> > @@ -361,15 +362,21 @@ static int sst_acpi_probe(struct platform_device *pdev)
> >
> >       ret = sst_platform_get_resources(ctx);
> >       if (ret)
> > -             return ret;
> > +             goto err_unregister_mdev;
> >
> >       ret = sst_context_init(ctx);
> >       if (ret < 0)
> > -             return ret;
> > +             goto err_unregister_mdev;
> >
> >       sst_configure_runtime_pm(ctx);
> >       platform_set_drvdata(pdev, ctx);
> >       return ret;
> > +
> > +err_unregister_mdev:
> > +     platform_device_unregister(mdev);
> > +err_unregister_plat_dev:
> > +     platform_device_unregister(plat_dev);
> > +     return ret;
> >  }
>
> Looks like sst_acpi_remove() does not unregister the devices either.
> That could be fixed by enlisting devm_add_action_or_reset() in
> sst_acpi_probe() without altering sst_acpi_remove() at all.
>
> Would you mind sending a separate patch updating the function so both
> the error path and the driver-unload clean up the device objects?
>
>
> Kind regards,
> Czarek

I'll update the title to:

ASoC: Intel: atom: Fix platform device leak on probe failure

and trim the commit message as suggested, including the
s/machine drivers/machine board/ change. I'll also add your Reviewed-by.

For the separate cleanup patch, do you mean something like this?

+static void sst_unregister_platform_device(void *data)
+{
+        platform_device_unregister(data);
+}
+
        plat_dev = platform_device_register_data(...);
        if (IS_ERR(plat_dev))
                return PTR_ERR(plat_dev);
+
+       ret = devm_add_action_or_reset(dev, sst_unregister_platform_device,
+                                      plat_dev);
+       if (ret)
+               return ret;

        ...

        mdev = platform_device_register_data(...);
        if (IS_ERR(mdev))
                return PTR_ERR(mdev);
+
+       ret = devm_add_action_or_reset(dev, sst_unregister_platform_device,
+                                      mdev);
+       if (ret)
+               return ret;

This would let devres clean up both devices on later probe failure and on
driver unload, so the explicit unregister error paths from the first patch
would no longer be needed after this patch.

Would this be what you had in mind? If so, I'll follow Krzysztof's
suggestion, organize the related changes into a proper patch series,
and send a two-patch v2.

Thanks,
Guangshuo
