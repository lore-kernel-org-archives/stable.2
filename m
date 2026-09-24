Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29DB3CB8FC
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260216; cv=pass; b=GaKbUDKIe8Jwq2FRVZMN+y11sLMIdszsGAimb7A/DZBObk/GkVGwgYuuDo9vi/Lh1i3v5GPLDfXDEpaNQXxCLHzFCkS9BEUiIurpuMxHSqWhR9kChfday+8QNX2Gy1Q70b7hYOgkjhsNvTs4mpCt08BeNdP6jOT71AUWKd/aIIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260216; c=relaxed/simple;
	bh=DEXzrGZJZ5pZsu6Nmf3KfFvACPsKM8vrFc+DWmGfen0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MRHUSzg5MExXtXI4dl8EaB9rrOyCavXV+F5XdxN8FrGxZxVwmy3+R/2S6Lt0PG9Br5cc+rhLOxRydASI5y/HtL4JHgWgUUmwWNf5D0+2Ex2P+dXfSYzD01YAmQjO7YobZmUjkyYLWkDoK8xMEt9orEM7rcqNSMnh48UFFbVGpoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AO4TcCJb; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AO4TcCJb"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-672ce86b21aso2502552d50.3
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 07:30:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790260213; cv=none;
        d=google.com; s=arc-20260327;
        b=Zp8wxWO1dZqtd61vM+ecVZmCRQeTUJV1mB8zTXV+wn9sWTS00Pu7Z3a99L8UYj1G2R
         ABHVQ9SX5gsrGFBgUf5LttW/b6BTBoayfWbO9p45bFrTD0SYsieCjU3wWlBweK1onP62
         +ULXnwaMz5WTIweOxtNmlt94ac+Om/YQhJAsGI9Z1pQkF9JqtnW7WBPaU6Y+cRCF7W65
         6DmtYa3DuPzYBDpXt32xaI8zmfjV8Ir2P47OPUtauu1cSwiEkJBF13L2yCckFrA0Narm
         4Jgxf91AiZG0uDHAC/S22o0Tn4ldfWWHOmRLDJmWOOn4fRs9IUR4CRAO/gZLbUf6rZJz
         Urbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2ReSij4eDlvfzvHmFOZbgb/VaJC2TPYANknXs7Tc10Y=;
        fh=gVF/gCae33NvO1E3tRsM2OSa7fPNZmVsl+fh2PjlHk0=;
        b=goOyWSdCmr6v7/GWD1k1bvvUn0GIknUvTUTbMCq8RAfg0PjbOtmXSR9T221CE9DPme
         f+vUzUus2rRi5McNXNhkYDEhy6rCIU9rIIT/VKpDfCmtsMbJLaGvX3ikcidSGQbJP4BC
         emWRAq6SSlKa9yF6baLkyAZoG1HJNWrXiyQvkm2mFKAI2tgnrf8/rqFAwAeyz6U/3dyN
         m2Q+LJY4TfyVFseSG6GtODQXd3ns+Wy9g4sfbE2yYxMRDFxNpA71+pzxOfIuEuPxF82s
         GXkK6ic+iL+E9mjI+prr7lZSaZF+AG9dmk2Xor1EVLeuMNzX6VYaLuvDwz+Z7Op5VIyA
         TCBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790260213; x=1790865013; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2ReSij4eDlvfzvHmFOZbgb/VaJC2TPYANknXs7Tc10Y=;
        b=AO4TcCJbZg8hMZNtETUCWwUWcvv7glRN9BicfzcgHkVUl0JWv4BOS0NDubJwnEJK1/
         qprLOvxxHqlyAEM/ku7aOunA/9Vblmk1dExTEc1iFIyE3VWQQVHxKtHiOVjPD5pZnLXK
         fd5hJLjLIGZH49q01/1m12meVNcskpkVSd+1ZHtWFvEP05FM+bL/22IsSpGzLS9x09Gc
         J5Tm6Adhhrsurly6YyC7TLoGp9HTKRtHnKGsKiRMRh3YMJv/PlhDwLwz4JQaPyWUeBT2
         27QxQGPg1JZVKyMpR9VYRwJxh5bqMXC2V8nLbPJBXENF6pIin7nAZYBtuS6Q7i7oK1dN
         KGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790260213; x=1790865013;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2ReSij4eDlvfzvHmFOZbgb/VaJC2TPYANknXs7Tc10Y=;
        b=vVMunFVMihwY5Gt/+PUXD0JKikdNMtw43HAbhUhfciAh3cYYKQ08etM/BZwQAZj9v3
         jqukNTdyvT9p0szRLiyO/USTBjq4PI3l8wlOSnZC0AtoNMHFg0VRJ26/YakCmmupEYtl
         xdl2vAcFNhPh2VGyIfgux2KQWhTwYMoYJviyePGC8xSi4xk3zvFuadOmsf2Bh4RjzIXk
         3Oh3qG7AJeFd03dHT0lWKHHivPFRHp+Tslmm+/kCY+RGXmUrtw5Dnjg4DE0s5JDDSCAI
         qxxiSHVw+rlvpNIFuVjmUl8hi8Z2mcDZF/1cVEcAdzwMHBd3XwdpYtlzr8wAbld4i5t8
         NIpg==
X-Forwarded-Encrypted: i=1; AKwUvBxxdL386PWQkcL6vYZAXPi/dIVk0ZkME4TzZTogHiWq+RZd40OKnNs26wpYpTMF2MxFKUxfyYQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nEyqhNKeI8kLz1S9QmDv7vvep58VvMNs7tKgi1M76jxTYIXv3N
	9uobruC1T01q+QxxdMuj+BG7Q2mViZgNqPedc0LtKpCvfCrURY9cy7kTLD7K2NQwsy6yeQK2rrv
	dvN13OFqEQKs5BrpkE0UsLO41vk/oV6s=
X-Gm-Gg: AYBFou3BuerSvUTHZ6tq6IFL6nB0lhw+/TxXfjWQ4OfHG/m55nSdicclLoANxYSaQ8w
	oi4F6W+C9LzA+Y84WBKCzFTee8lWc9n2pvHKnIv4Rvy2tCwX/0PZ1IKXsIKbnD4Zu+0mtlcC/j2
	y9PZwGrYoeUFzce+n+NrUxtF4xvaQ5RGg1k4UZ+nrmJqTGVhCyS9r5n0pvgtjdSAGbkq42BPQL3
	OZaZOiKTc0frqv9uE3uSke9+bHAj4/NB79wXiNfJNW88qE1m3d+WtpXXRCpE2J5hn6T6+1uyY3p
	qcCZtQ/2SMPkLPskPub7xvUnyR4IovnAN7QFIMRuaKRyfKuV5qdlUZXWUDsVFV9S3sIU2g==
X-Received: by 2002:a05:690e:c45:b0:66f:d093:c206 with SMTP id
 956f58d0204a3-672ed204704mr1327519d50.17.1790260212896; Thu, 24 Sep 2026
 07:30:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921110909.370945-1-lgs201920130244@gmail.com>
 <20260922074137.GG2348773@google.com> <CANUHTR9B84LoCjOtS5N5qGO0KXSXUbZkrKZ3_GFTwXmVoPQ0SA@mail.gmail.com>
 <20260922150642.GH3277918@google.com>
In-Reply-To: <20260922150642.GH3277918@google.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 24 Sep 2026 22:30:02 +0800
X-Gm-Features: AclHuK860EhogXR6CM7Mg1y8PIyfTwBtwpDGRzp_GvIpNMBtaMogNwOv8vHFZoQ
Message-ID: <CANUHTR-iuuGMTWT4_C5TMjtTBE4sYAWcD_N8Jwf8WnJs84b43g@mail.gmail.com>
Subject: Re: [PATCH] mfd: ab8500: fix child device leaks on probe failure
To: Lee Jones <lee@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, 
	Mattias Wallin <mattias.wallin@stericsson.com>, 
	Ludovic Barre <ludovic.barre@stericsson.com>, Alexandre Torgue <alexandre.torgue@st.com>, 
	Julien Delacou <julien.delacou@stericsson.com>, linux-arm-kernel@lists.infradead.org, 
	mfd@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks, Lee.

On Tue, 22 Sept 2026 at 23:06, Lee Jones <lee@kernel.org> wrote:
>
> On Tue, 22 Sep 2026, Guangshuo Li wrote:
>
> > Hi Lee,
> >
> > Thanks.
> >
> > On Tue, 22 Sept 2026 at 15:41, Lee Jones <lee@kernel.org> wrote:
> > >
> > > On Mon, 21 Sep 2026, Guangshuo Li wrote:
> > >
> > > > ab8500_probe() registers MFD child devices before completing the
> > > > remaining device initialization.
> > > >
> > > > On AB8540, the main MFD device batch may be registered successfully
> > > > before registration of the cut-specific batch fails. In that case,
> > > > the probe returns without removing the child devices registered by
> > > > the earlier mfd_add_devices() call.
> > > >
> > > > The same issue occurs when sysfs group creation fails after the MFD
> > > > children have been registered. Since the probe returns an error, there
> > > > is no later teardown path to unregister those devices.
> > > >
> > > > Call mfd_remove_devices() on these error paths so that MFD child
> > > > devices successfully registered earlier in the probe are properly
> > > > unregistered and released.
> > > >
> > > > The issue was identified by a static analysis tool I developed and
> > > > confirmed by manual review.
> > > >
> > > > Fixes: cca69b67b3ba ("mfd: Export ab8500 chip id to sysfs")
> > > > Fixes: 9c717cf3fa16 ("mfd: ab8500-core: Add device for new RTC version for AB8540 cut2")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > > > ---
> > > >  drivers/mfd/ab8500-core.c | 8 ++++++--
> > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
> > > > index f0bc0b5a6f4a..e675223b6023 100644
> > > > --- a/drivers/mfd/ab8500-core.c
> > > > +++ b/drivers/mfd/ab8500-core.c
> > > > @@ -1220,8 +1220,10 @@ static int ab8500_probe(struct platform_device *pdev)
> > > >               ret = mfd_add_devices(ab8500->dev, 0, ab8500_devs,
> > > >                               ARRAY_SIZE(ab8500_devs), NULL,
> > > >                               0, ab8500->domain);
> > > > -     if (ret)
> > > > +     if (ret) {
> > > > +             mfd_remove_devices(ab8500->dev);
> > >
> > > What about switching to devm_*() a.k.a. managed resources?
> > >
> > > >               return ret;
> > > > +     }
> > > >
> > > >       /* Add battery management devices */
> > > >       ret = mfd_add_devices(ab8500->dev, 0, ab8500_bm_devs,
> > > > @@ -1243,8 +1245,10 @@ static int ab8500_probe(struct platform_device *pdev)
> > > >               ret = sysfs_create_group(&ab8500->dev->kobj,
> > > >                                        &ab8505_attr_group);
> > > >
> > > > -     if (ret)
> > > > +     if (ret) {
> > > >               dev_err(ab8500->dev, "error creating sysfs entries\n");
> > > > +             mfd_remove_devices(ab8500->dev);
> > > > +     }
> > > >
> > > >       return ret;
> > > >  }
> > > > --
> > > > 2.43.0
> > > >
> > >
> > > --
> > > Lee Jones
> >
> > Do you mean converting the MFD registrations in ab8500_probe() to
> > devm_mfd_add_devices(), so the children are cleaned up automatically on
> > probe failure, e.g.:
> >
> > -       ret = mfd_add_devices(ab8500->dev, 0, ab8540_devs,
> > +       ret = devm_mfd_add_devices(ab8500->dev, 0, ab8540_devs,
> >                               ARRAY_SIZE(ab8540_devs), NULL,
> >                               0, ab8500->domain);
> >
> >         ...
> >
> > -       ret = mfd_add_devices(ab8500->dev, 0, ab8500_bm_devs,
> > +       ret = devm_mfd_add_devices(ab8500->dev, 0, ab8500_bm_devs,
> >                               ARRAY_SIZE(ab8500_bm_devs), NULL,
> >                               0, ab8500->domain);
> >
> > and likewise for the other MFD batches?
> >
> > If so, I'll rework the patch that way for v2.
>
> Yes.
>
> --
> Lee Jones

I'll convert all the MFD registrations to devm_mfd_add_devices() and
send a v2.

Thanks,
Guangshuo
