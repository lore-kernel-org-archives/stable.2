Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B1A1B85F8
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 00:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782953246; cv=pass; b=lSmCZ7+t3jK1NlJmJ73B6biD58fXnRBNwOMX05RADpBju3/tC5xhqQp6SlD09TA8sECxhhbFrx2qoSK3Q0MX9ZerXzdOTQ0ITVHeFIRKCe7l+aVQDjtXx1ZtZdyIrL9+5R2OCVkqz9d1gGMwsDPRT0xQIEfSwieRIRiK5qB8AwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782953246; c=relaxed/simple;
	bh=el5EsMRYWMvqhrLthyzhD5MTMKT3hUlrX8yq7m0op5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q75xnH1WmLALwSn6mIRMKzqy9ss3G8kYctYiX+jOd7U1fnhxHvDsnka6URi5a+293CADy+GgMlqG9KfVINrpvF9ZypJKKEdd6DDwZblXVnwWVShH48G9Ee85lLc3chjNPvwdQRM6ZfknjG6LrdELMK1ukeCvzSxmRpaHL2w/oAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBpZpMnr; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBpZpMnr"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-666275a685eso155067d50.2
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 17:47:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782953245; cv=none;
        d=google.com; s=arc-20260327;
        b=DUeo3BX8A4qu+yDvhHRTaWN/jLYvIk8BRlWixE7TkZnUh8XT6gj4I5SE596L+btRY3
         1RLn0Mix6w5smWDKlTlecR4Wuds+E2hKePoCnqtbvRQmwp6PAN5uAlvQoxZjvmyWQU11
         11QeBNQk6CgJ4i16xsm4Th/E7F2zKAJtQjZHNOE176ElXb5hfrWIf2Yj9R+tQlXsk6Js
         jinGdBzFBnE44DCrwPMaTPuJtvxpu157DrJK5fD9Z+NK4UnMvtpx8GDG4SkL28VW9MyT
         zbiRjxGZAxFJe3HnNLZqAaZtAG+SLM3ZNoEAaHPyCq6wGEzZZ8u+Uj1MslIf3qYcaeNm
         XUPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vCPFPx+PcZzcNHSg9tBDkwND2L6CeBxw+Ct/uPJnB/0=;
        fh=MlaT7B/b2znoc1US+n1em6aqZXUsjdPHuzqEHxS+1yc=;
        b=ogl33GQYNY36sUqDHj+kSGF/qOl4TA5rPt20fCAOzeqxyl7L7Nw5a4iT0kpMQ5B6jk
         eEmW87sHsbAEn1k3a3Ag86+A85BX+eZhKJlqDTfEUqJY8nAzBv3wjosyK4N2YSTl4i+5
         h8cIDG68YH0TzY/1G0PR/8qsRvW4rRvxkn2vbp+gS3cgAv3jCwTHvX35aLydhwRHvggT
         disuTBD6L5pOtI1PTLxq8Ta+UDVzeTAuPPRNT00S9QyTfO73kw/dM6zt4MyjeNERNxgx
         eU2cr3pxwW44+jKMPlmnC2MUGHytKDWhdbQ2mQxBuoPrlsZK5NnalRJPw+q/B5UdD+wJ
         CiTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782953245; x=1783558045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCPFPx+PcZzcNHSg9tBDkwND2L6CeBxw+Ct/uPJnB/0=;
        b=lBpZpMnr2Me2D7FRHCm2EGLx4h/AQfGnPdff+m/hei2R3O+F4Aamrb3zDw73cX+Ej7
         nloimyD3XFR0YoUozpdyAhKyMreTP0BsjNk4Bc+wDhGblMJiXunRseIm1/9+CiLHvc/t
         ajGhrmd+EA7WLRkLRjo9sR/sdUgpdx4MoDDVMIIWs7PlBmRPbGFUqCt5cZ11j3yvdfp7
         bnIc3BpJOEhZSTi7fFvl8caZdF9EgTrZ2zdcxe9NknmzQZJAM5fnAI26BusqVlaXy7kI
         OiscJog3CBPmkYY6jSQ7I54RMnq1AIVpWYFcz+W9AZMhhsFrQUiiKzQonqUMbsmchc2F
         PTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782953245; x=1783558045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vCPFPx+PcZzcNHSg9tBDkwND2L6CeBxw+Ct/uPJnB/0=;
        b=DTUUio5ixhlcBjfc6RKh6Gikh3sUGIsrYqMg6IAf6NTyWjv0V+MfRZhgwd9pfkhZSI
         W2gd8UnBWJ9HOl4pTPa/KDn8FEVscy5K3kngl5moy7iF1YxlwbYKrnSYTbHdn6EYQn2g
         E6/Wlj8QE7AbZB7ggF3rSj9KaraND2lkhbGahB0XF5il5WW+zG6kHEJf+adW5Zs8cOMT
         GWG6Phtd7V5eSmM9XLanZIJA85JfR9UMpcvix2pOUlZczl2xIbZWGS3SJK/O9X3FRwBf
         0XIlgJx0ov3D1w+4T/Gx0rEXIZO/lw2zKLrq0qyvPqa0tk0FG2A+ogHKoDFDocpEPCj6
         A5Rg==
X-Forwarded-Encrypted: i=1; AHgh+Rp74zqaBTz8gHKahhT/JTIGC/W0EFcBbaGInSwjPwrz3CgaBFexrz3+Y9EwBz1DIP/jvcl6AGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeB1tPb0QC3s6ZchIU66+fFxWhfUo+qLCKZQxIzb8FJyiV4dNb
	94uDED8sut12LRG+HY/T/59J5qlASN7cVoVFylOgWeGgr/maN8ioqwjxlqC0Rn/btpBsqm6K+Av
	XXSzeTkLDeFYmCNjBIKRHgJkSM2NammE=
X-Gm-Gg: AfdE7clzKzViBf5OiHbtxXbd0zk0RupFnGEI89LzdOlOSUgnkgPzbZtISZLLSRmV1+M
	1aybC10C4Vd3SIKCusyBnUA1entuZfHc2JyWWF3l5PZH97DLa0r4AU7ujNpocs/UFy/zWZgmeFe
	T8BtBn0xqJNU3t5GYMyiA8gducz2OkvPupkPPaUVR8etQH0RyalGe4Xf9CT6F2a6ec5GW/pIMC0
	YPxwkzuFyNHss+tAR+Zajq0cBKJ1BXZjLL/ezdMua4RLBHdaNkcOlVQntK/s74PezsGmgWZjrha
	jlBNInC+ubG1Zhd5sv2J4KRPs3GJxrUzUEPSghz4X87ng3kqCjsjma4nOkA=
X-Received: by 2002:a05:690e:1685:b0:664:e8ac:21cd with SMTP id
 956f58d0204a3-66521a9939fmr3721690d50.25.1782953244651; Wed, 01 Jul 2026
 17:47:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701122246.2451-1-mhun512@gmail.com>
In-Reply-To: <20260701122246.2451-1-mhun512@gmail.com>
From: Alex Henrie <alexhenrie24@gmail.com>
Date: Wed, 1 Jul 2026 18:46:00 -0600
X-Gm-Features: AVVi8CdfCP7TKSk1Ku8iKCpyX5RUTT9yUb-rTvsI1071-8rips69S_lX9CQHxt4
Message-ID: <CAMMLpeRLti0iD+sT3WDd8VG7-Na132ZdfzVEAeM0LcbBbNmD4g@mail.gmail.com>
Subject: Re: [PATCH] USB: misc: uss720: unregister parport on probe failure
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Oliver Neukum <oneukum@suse.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 6:23=E2=80=AFAM Myeonghun Pak <mhun512@gmail.com> wr=
ote:
>
> uss720_probe() registers a parport before reading the 1284 register used
> to detect unsupported Belkin F5U002 adapters. If get_1284_register()
> fails, the error path drops the driver private data and the USB device
> reference, but leaves the parport device registered.

>  probe_abort:
> +       if (pp) {
> +               priv->pp =3D NULL;
> +               parport_del_port(pp);
> +       }
>         kill_all_async_requests_priv(priv);
>         kref_put(&priv->ref_count, destroy_priv);
>         return -ENODEV;

I think it would make more sense to set priv->pp to NULL and call
parport_del_port(pp) right before the second `goto probe_abort`
instead of calling parport_del_port in probe_abort. That would avoid
the need for checking whether pp is null before cleaning it up.

Is this just a memory leak, or is there some visible negative
consequence to not cleaning up the struct parport on failure?

-Alex
