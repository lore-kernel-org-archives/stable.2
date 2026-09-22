Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFAF40A945
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065786; cv=pass; b=ouQLEm5RnYOJvdsgXjJmTjBOG0GC/qNJAAsvUnoPT0Qe50GhCWe2w64+wTD8AlxN96pNX8pmBr0Hydu+3N817Xq8vFuhaw/BkF0VIuJP76hmDNZ782lEDSWYNiwSyH95VO05FjM6wFxBp46Exo720XLqC99BXX0QL/5T5nVeKv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065786; c=relaxed/simple;
	bh=Q4t+g3vnDy2gIUVRjJal60TyzupspjgjVhkD7spJfro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDsmmtIUCYrktoQ8YfCarbYNvFnvKX2riSzHAa9+7OkbAvK+6buzqUZh/npx6b/Ui5wqMSL9ozt/Hey8hF59m2+1vCyqzSVmn4a2tvZLWHnysMGzgmKsZuz55FQW9ToJaQeDnJgPWQIhCGMeeO5qTVsG2uPZJNTqMfti9l0QD6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqTXdCWn; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqTXdCWn"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-8659af7454eso39233197b3.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 01:29:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790065784; cv=none;
        d=google.com; s=arc-20260327;
        b=G4xWidyzLReblEo93zCm8rBjCcbUDMo+Ia2gEypKhyXGX78hr4/2yYGvV5FMR8G8Fl
         FvO275jRu1iEPqiGrF3hhR9eWFBVfMb6/YCy+GZ+GHgMICNUwYWgNtcCfkZSsmH5ErPO
         guH3o6fQB2rzTJSpjp8EHVs8znVOQ3NwEre8gcrWcdL8apzBjTXZZ9ltULSO4TzswNSk
         PdNv29t1KvieCpbcwMb9+ECNgRuMJy7XabBmh/dzPctmvIbDVWullKjDzJdgJc8aNa8a
         kddlVnO+hABYbq23L0xQoDyR1avTIFCO09i2XSKlwfj2u/97efcI/vSIyiFWTWN/6FqX
         CXGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nK6JLqXHLE++uLnREJ1y7gZWvzKk3Twpjsn+brZ9AMg=;
        fh=eAusGSbTOcEK+xJdf1L9cn6XonqU/23K0aZkSRFAao8=;
        b=nsJ66cbLJDJfKyfJDAOMLTBQgmJ6z9ARU71i40qVCaNaQtOxnRVtgEpdFgH469NcO1
         Qo8FKIXJ8FV5A8wIR8ZRHh1hLB3EjweQS5MTSztXm5FyOpj/CocGxK4O9Hui/A3uMl+b
         NjbAQjq5WbXHK/ZRVCUYS9JzD2GCl0oTJy0jOHtaR6Sx7lheA6zt4woCBGqJuPjuBZ5z
         n7GbLDdwLtg5ZzB1+cODZxzvUzRsBz1D9FSKXHGnLSuMqdCnr9KZsbFkI6YtqR5j23MQ
         pRlhPPzjRjLD64iEJGXOHAUkn4kwnyRc0nhIkoOXGZ/NCLgNktDIue1fRKcL6B0NN32T
         cWaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790065784; x=1790670584; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nK6JLqXHLE++uLnREJ1y7gZWvzKk3Twpjsn+brZ9AMg=;
        b=WqTXdCWnPNIBF6gwYr0lCUuodtb2dP9g1xg8FZf3cDHcewVejddMJzcRof+P4stUe2
         saUPNFn2vmGghp8LGSpRs/oNHJQZLGILmFRBU9Mmta8deOqO/tTnycynUisR7in2zAQo
         SivNA69tD/quH6B/On9rejx4AFwCfuzl1Nw5bZCm4vKfKZ+J+dzaQ6go6tYQnsFsVcjQ
         ljMElG071W8Q3f75QkIeh3nHLcjXWCulFTXZwvhUwCIIRPM/AeT9IQpGx6Pm3+Gc0jv1
         yXzopX+yfLXo6yPIGG7PcG3ti7Xo37qABUvfmyJfwFrEJwAXSs7gsFpYRpJLReKxW2z+
         M07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790065784; x=1790670584;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nK6JLqXHLE++uLnREJ1y7gZWvzKk3Twpjsn+brZ9AMg=;
        b=ZfcbyjjNNjx2MH2caF7AkW7F3OunbBZWJZlYyoqtJ1qV8FuRiV+lK31DWT8xJBmnpS
         4dvB1cMgUMikCMj6U18l0gra9dU/QnPpwhk9dEAeXZhZMWuAIaWLS4CWhihTazNUJ3MZ
         5UrmH4gj6uYwgJKErFjWOs4og4t4VljNUG0E/gw/76fo3mwrD/WBwQYc+FikGe0P6opA
         1KExClJQAVpZUs/dR/d91R30w+4ySZMfnr8uWHTgS3MX2z5NQQex7heO5UBGFUoIH153
         I4dzahNeRJfyFiMnc/YkH2eqKF7ZXDl8i+5aPAJ5KqvfYk9ToPiVmN3sWILUTDqHSlC1
         BGpA==
X-Forwarded-Encrypted: i=1; AKwUvBzD8Qopb/Mq5c5uHKTlvn1D2nz3+x3+TMm2NYWLMQ92XISSiH0wKISitkzbzy7oliodRdPIxes=@vger.kernel.org
X-Gm-Message-State: AFuF++lFwIWQCNFhefEcmZj6tqPLOMYNyN2X0PW/wvb6ar42/HdRirf3
	O9cPM4xHK1mEnq5eBZVhmLNaOG+rxrPrEHKCmhTW+Ev1WAl66i7KlhBXsDI/Z+7byKYib/LJT9C
	tFaxQuFs0bN5w1CSX14/CBRAgmNpCpmWF6u/AFcLM/NBL
X-Gm-Gg: AYBFou3XI4MH/5kqvrUvgu4G2/yiWIH38KuyzNgAV8eDYirRX9RxMndUUN4+IW29Wj2
	drOyUSs45ZsZ4mXrqrbTx4P3MmlL+E8JcT5iBYIKtvcUYVng8Ct+ZRd5cSSkXl4hTN5/aSXwi6k
	8rvM1THPSzrKSwEi3KcQq7O3KvxvlFdFZ6TGYqONhtxVf2BifaN2xDmBAGvdmz80exPoMxF6bIH
	T3Arn5A7fcAN+UyJQ4+kHFoaEcovyCREgTQDsqNMQgwud/hJ/uYv/aRbnuQzKUMLjIDXVbuKTu9
	IMH42joVuN73NpESlJ8ccw75rgCKsERx5svdDgrFrNccuTZhnSOIjSASrA==
X-Received: by 2002:a05:690e:12c7:b0:671:45a4:b282 with SMTP id
 956f58d0204a3-672c5517fddmr641742d50.99.1790065783701; Tue, 22 Sep 2026
 01:29:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921110909.370945-1-lgs201920130244@gmail.com> <20260922074137.GG2348773@google.com>
In-Reply-To: <20260922074137.GG2348773@google.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 22 Sep 2026 16:29:30 +0800
X-Gm-Features: AcwNN1Vv9ooUXHTfX-8aKzoQsfCH4263yxneaXbrNlAHKNAqe0WY7gylNd9nMJc
Message-ID: <CANUHTR9B84LoCjOtS5N5qGO0KXSXUbZkrKZ3_GFTwXmVoPQ0SA@mail.gmail.com>
Subject: Re: [PATCH] mfd: ab8500: fix child device leaks on probe failure
To: Lee Jones <lee@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, 
	Mattias Wallin <mattias.wallin@stericsson.com>, 
	Ludovic Barre <ludovic.barre@stericsson.com>, Alexandre Torgue <alexandre.torgue@st.com>, 
	Julien Delacou <julien.delacou@stericsson.com>, linux-arm-kernel@lists.infradead.org, 
	mfd@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Lee,

Thanks.

On Tue, 22 Sept 2026 at 15:41, Lee Jones <lee@kernel.org> wrote:
>
> On Mon, 21 Sep 2026, Guangshuo Li wrote:
>
> > ab8500_probe() registers MFD child devices before completing the
> > remaining device initialization.
> >
> > On AB8540, the main MFD device batch may be registered successfully
> > before registration of the cut-specific batch fails. In that case,
> > the probe returns without removing the child devices registered by
> > the earlier mfd_add_devices() call.
> >
> > The same issue occurs when sysfs group creation fails after the MFD
> > children have been registered. Since the probe returns an error, there
> > is no later teardown path to unregister those devices.
> >
> > Call mfd_remove_devices() on these error paths so that MFD child
> > devices successfully registered earlier in the probe are properly
> > unregistered and released.
> >
> > The issue was identified by a static analysis tool I developed and
> > confirmed by manual review.
> >
> > Fixes: cca69b67b3ba ("mfd: Export ab8500 chip id to sysfs")
> > Fixes: 9c717cf3fa16 ("mfd: ab8500-core: Add device for new RTC version for AB8540 cut2")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/mfd/ab8500-core.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
> > index f0bc0b5a6f4a..e675223b6023 100644
> > --- a/drivers/mfd/ab8500-core.c
> > +++ b/drivers/mfd/ab8500-core.c
> > @@ -1220,8 +1220,10 @@ static int ab8500_probe(struct platform_device *pdev)
> >               ret = mfd_add_devices(ab8500->dev, 0, ab8500_devs,
> >                               ARRAY_SIZE(ab8500_devs), NULL,
> >                               0, ab8500->domain);
> > -     if (ret)
> > +     if (ret) {
> > +             mfd_remove_devices(ab8500->dev);
>
> What about switching to devm_*() a.k.a. managed resources?
>
> >               return ret;
> > +     }
> >
> >       /* Add battery management devices */
> >       ret = mfd_add_devices(ab8500->dev, 0, ab8500_bm_devs,
> > @@ -1243,8 +1245,10 @@ static int ab8500_probe(struct platform_device *pdev)
> >               ret = sysfs_create_group(&ab8500->dev->kobj,
> >                                        &ab8505_attr_group);
> >
> > -     if (ret)
> > +     if (ret) {
> >               dev_err(ab8500->dev, "error creating sysfs entries\n");
> > +             mfd_remove_devices(ab8500->dev);
> > +     }
> >
> >       return ret;
> >  }
> > --
> > 2.43.0
> >
>
> --
> Lee Jones

Do you mean converting the MFD registrations in ab8500_probe() to
devm_mfd_add_devices(), so the children are cleaned up automatically on
probe failure, e.g.:

-       ret = mfd_add_devices(ab8500->dev, 0, ab8540_devs,
+       ret = devm_mfd_add_devices(ab8500->dev, 0, ab8540_devs,
                              ARRAY_SIZE(ab8540_devs), NULL,
                              0, ab8500->domain);

        ...

-       ret = mfd_add_devices(ab8500->dev, 0, ab8500_bm_devs,
+       ret = devm_mfd_add_devices(ab8500->dev, 0, ab8500_bm_devs,
                              ARRAY_SIZE(ab8500_bm_devs), NULL,
                              0, ab8500->domain);

and likewise for the other MFD batches?

If so, I'll rework the patch that way for v2.

Thanks,
Guangshuo
