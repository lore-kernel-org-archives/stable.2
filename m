Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6C0483BC5
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790063999; cv=pass; b=T0c1L+42pcQlJ/hPtJSaN/ZKq0Pf+tWp9XAE+joc2JeWR5tlyJqHox6K2Pnux3KnGw+1NUQlihxiqc2BNlL5PbQvOInZaqJZm18B4funAl1AfvC3oUUPcG4qH0tKXb30PGLDoJrPfCCtZlP3pz9H1DNe4cdSyzII4+O/QdrwqNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790063999; c=relaxed/simple;
	bh=LV/LVjKM3hxN9GZjkxURfw1FVzLRvHD743trx/7Cv6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qz57Mps3XZlPv9k6pmFM2yASDZenhCAQavmnfNgkx/PXokm3pDMpaEXrqkHHatTScv4bQgS4cUsPniaZxFXVDCQ4wwpR2DDFfDX5dulz7eEkJF0yF0b5kNcIJEEmd58poEmIYu2U1qRCD6KIhl7X2yU1UrXlguo5jF0DnwiJuYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZkY8H6j; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZkY8H6j"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab1ef11so3378072d50.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 00:59:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790063987; cv=none;
        d=google.com; s=arc-20260327;
        b=OaojteuJ4hEZ8fpH9FMOFiSsMbLCcm7ndITD+gEz+bI2TXy9p4IHSHrFcEcNHJLGFT
         iMo9WDB+mRJiu9aAQV97Dd4UodE+gBW6rncAWF6sTcCm26db+lgelAdlAReXZuTSFGXO
         fP0HnZgSmz0Mdcj88ZzkayShcZ/5dsC4wo9pjJ0ioebSM5VhkLnvibehmm4voGdmbH1h
         j5MxyS4Ae3ZLT4t9dRX4sKeDtMEdeZ5+WvtsJhTgs12PHyOfBaahtM9tI2ZsXcB5Hjfv
         BUNZ4tF3ei4GbCUykYGqhcguvgnpNL2+LV67+v1PhmgTpXJUlMUzDpnFQtIRqLTJ6469
         jE5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dP1zCMCErPeK9F1TnlfMVGvOu9U8paGR+gGJEZKdb/E=;
        fh=wwfeMJGXhlh7zOoh77vkPy6Ao7LCSY9cTkx/ggPVq3Y=;
        b=fesIV427qHprSk5/MICvWCWkHSOO3/jpsd86zYvvynG4g3ob4S3NK5H8O4FfEWjtvu
         MYecMFTXWBVXtSaAMn/RUH2Otqj2Y7ZsJCXWKgGbEpXVcmzezIcYWN+70zumv+bpG+qC
         l3LSVfg/q40D5Y57JP+Oygjy3n2JLTYK8YAGiN9SH6QGwM6VR94Zfy3dJQw3ztLQl2Fi
         41zPClK+/YMCDKiO9v4lfetF9vEZxRf4iw9Cd9nvTi11Um6zbNvPK5fDWrMOBLQABYqN
         Viaif3dm+GsNzxxT+dsRCbi00IaGuV/HZQKQWVAf6JZCGqwGazznHUybEQ3OaRFGcWoQ
         82Gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790063987; x=1790668787; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dP1zCMCErPeK9F1TnlfMVGvOu9U8paGR+gGJEZKdb/E=;
        b=SZkY8H6jCSOKxUld1lPUqCarseFPTbpgFZFptxqmOhXs4o+ZGI27H01tFdDrPYNCnn
         6j8WrNge4AFgRFH+TdEz4ms1+d+x/OHrXTjGPtQSDVT24CwGkjqBaTJEgfR090QWtjkJ
         CFc618ixfQ/nqOU/5tcXncV3lZqe2e7qgVAceYybwGj7kkrJzR54F+mQyUTcdDUIxlUx
         Dg73EUcmssPrraZm/MXWqmvxnGKuXNMKmOFH55fuciNuIpwc1ftd/gldPokebCViJjBZ
         zYzam0eiXw8sIa1mQ4jKEJnLJafKd4vUiy6xd/D+0grobkMbTo/ycsGzeIS2vJzluAMf
         pX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790063987; x=1790668787;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dP1zCMCErPeK9F1TnlfMVGvOu9U8paGR+gGJEZKdb/E=;
        b=bucIG7NLIDyNYWxvLBHFTsMbf6DsiZnTFPLMmMMI7RmiqnRuRIPn7oSNmj2Epuuz0c
         ompz1KtgpWpurxZfe1I6/mkzM57SIFTKaEFm9HA2SjXJv62COuOjPbtpw8apoijmku3t
         WU2fpx6HLDgVe6KIR+j01m58QmJWqrGoUDqBjP9GXL3pALp6h+XUeZjITVNoQqfZuyr2
         1ZwrARCuTQpZyFEiFiXomsno/8WMFu4MrGJLpnXoRG0zSwD8w7fl3nhbTtGlWEVrRiAU
         u9adkwcDk3CeOgtEpHiydlTFqOmajFvG4PMHsElioMQTaGg/c5j5shdTkcOqzXPFs2qM
         xMiw==
X-Forwarded-Encrypted: i=1; AKwUvBx+zAgDGDHFAUitfdqJYHnKry+u66dR80xou6ASHPh7GSgD8V6kFSV1HfXZKeTQNNxlayy20fA=@vger.kernel.org
X-Gm-Message-State: AFuF++lUFRMrmYct9l1Na2isXwenSbUP1/Rv3DL0DMlvYLBlWTBgwyZ8
	dhVNLV66/XiM34/mTsmvosaxTeMr9DmXZV8daUgZhOSLdgGk1bNK4xVQyBnIaz3dJ4SO2hXaWyV
	tZ+cN3UL+e6ZEvLiOV5qG2mk9YKD4iCw=
X-Gm-Gg: AYBFou07mauqcHjsgs5kGx5E/BovwYTGE6kBn1U/UQDXq35AAqwiJY+h0w2FEuFaqqM
	Zh23Ohomz6TICWLfpKgnKQMcCk5co0pSvf40K5VrWsSUyU/Ng9L6lg6hhr8za1Bbk75iZ2tYJNc
	VagThVx404YKMWfBzOCLZQTe9yaj2DOWwq9nIPrirlr85H5afiQDP7DRjZtFeRAnKboc5eK0WN+
	o/SmTTkqvmpm5ToaVcyTNMD1dOnct4WL90orBduwL8F6/kF+bLFrMMJvZ56GphtoNs84H9TVE4K
	gu6r6D0BDW5tEx5wgQcgHMyIp9ZL4hkDwcGdnYlRAElOSekLJkNf4REeJw==
X-Received: by 2002:a05:690e:4105:b0:66f:c2c7:3a4f with SMTP id
 956f58d0204a3-6717fca0d13mr4306035d50.19.1790063987418; Tue, 22 Sep 2026
 00:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921104058.353748-1-lgs201920130244@gmail.com> <20260921110512.GS106095@black.igk.intel.com>
In-Reply-To: <20260921110512.GS106095@black.igk.intel.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 22 Sep 2026 15:59:32 +0800
X-Gm-Features: AcwNN1XxyQQU5x2vBD_1jw2pjdvTRbzVQZFCGqidJ6ftnuC_3eRhT9BLr4HUSn0
Message-ID: <CANUHTR9gA-mKn8Y496Pty4_Fhu3BSSyhXWrmiod1WvuVdQjkag@mail.gmail.com>
Subject: Re: [PATCH] mfd: intel-lpss: fix iDMA device leak on probe failure
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lee Jones <lee@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	mfd@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Mika,

Thanks for the suggestion.

On Mon, 21 Sept 2026 at 19:05, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Mon, Sep 21, 2026 at 06:40:58PM +0800, Guangshuo Li wrote:
> > intel_lpss_probe() may register an iDMA MFD child before registering
> > the main controller cell. If the iDMA child is registered successfully
> > but the subsequent mfd_add_devices() call for the main cell fails, the
> > probe error path returns without removing the already registered iDMA
> > device.
> >
> > Since the normal remove callback is not called after a failed probe,
> > the iDMA platform device remains registered and is never released.
> >
> > Call mfd_remove_devices() on the probe error path to remove any MFD
> > children that were successfully registered before the main cell
> > registration failed.
>
> I think this could use devm_mfd_add_devices() instead.
>
> > The issue was identified by a static analysis tool I developed and
> > confirmed by manual review.
> >
> > Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/mfd/intel-lpss.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
> > index 63d6694f7145..657b1e3fb896 100644
> > --- a/drivers/mfd/intel-lpss.c
> > +++ b/drivers/mfd/intel-lpss.c
> > @@ -455,6 +455,7 @@ int intel_lpss_probe(struct device *dev,
> >       return 0;
> >
> >  err_remove_ltr:
> > +     mfd_remove_devices(dev);
> >       intel_lpss_debugfs_remove(lpss);
> >       intel_lpss_ltr_hide(lpss);
> >       intel_lpss_unregister_clock(lpss);
> > --
> > 2.43.0

Do you mean converting both MFD registrations to devm_mfd_add_devices()
and dropping the explicit mfd_remove_devices() from the remove path, like
this?

        if (intel_lpss_has_idma(lpss)) {
-               ret = mfd_add_devices(dev, lpss->devid, &intel_lpss_idma64_cell,
-                                     1, info->mem, info->irq, NULL);
+               ret = devm_mfd_add_devices(dev, lpss->devid,
+                                          &intel_lpss_idma64_cell, 1,
+                                          info->mem, info->irq, NULL);
                if (ret)
                        dev_warn(dev, "Failed to add %s, fallback to PIO\n",
                                 LPSS_IDMA64_DRIVER_NAME);
        }

-       ret = mfd_add_devices(dev, lpss->devid, lpss->cell,
-                             1, info->mem, info->irq, NULL);
+       ret = devm_mfd_add_devices(dev, lpss->devid, lpss->cell,
+                                  1, info->mem, info->irq, NULL);
        if (ret)
                goto err_remove_ltr;

...

 void intel_lpss_remove(struct device *dev)
 {
        struct intel_lpss *lpss = dev_get_drvdata(dev);

-       mfd_remove_devices(dev);
        intel_lpss_debugfs_remove(lpss);
        intel_lpss_ltr_hide(lpss);
        intel_lpss_unregister_clock(lpss);
        ida_free(&intel_lpss_devid_ida, lpss->devid);
 }

Would this be the preferred change?

Thanks,
Guangshuo
