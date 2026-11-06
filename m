Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793927288;
	b=GigBX+/1ua1jKDVQznor5nqTEnqKep6JggUZbYF66n8Hv75FhEHp9fFYTQeYQfbK1b4I
	 587qojOEUHefpF3IDvAFVasX/SwLtRXagNgoOudxk/5wLQCcubtaTCa6b/SGTwDBDN1aR
	 Wrgj2bYreEy5UdV6MCrwB4fYGoZ4/mEkR18JEihHcg005jKpLgDee5WI10yolpIkvobNI
	 vV+S7ZnN3Npy0IWGMjcdl6sbF1RoTIjnMshDe5UguCxssrGm8y8XoEKsh176kcY4HUOPT
	 vWkHMgSDtjEs64NqO64mTOnKmGQ8i1zGRArR89AfyfaMfBygY2JUpPlI/Kmkjn1T9zA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793927288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fJkGz5CpoFWJRGd5AF5Qs6l5/HtOobvMGiH1ORmFADg=;
	b=ZRxMcyYQTiVPddD9tjEGbjFsfkUqFXT6bveBR82yU6QRWaDQV/YyZQFVcx/BcJB9kzWG
	 qGlkgdVj0IA6oihG0fyhhkg8jWxW9IodNm06Kr//TfPK1rjemXGRMElNs0DHCV1kIrGXY
	 xzZSStcKWLz1hhsoE0Ou33pgRc6rDDG3RYBu0LF9swGPxtMM9edqi8YCtyhtRj13Nssbw
	 lNkrT2INFqiCUPZjnwtOz1G8R20CUI1dYaKXjr3FdXWdmmbe5wvRVnFhA3XJ8D4FXx6sn
	 Oq9obZgJBR42HivCscko5x5mDGEd3xl+uOF3Biu9XsD8JApi0erkloiYyXm3zf4v0Kg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mxfw4T5t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.171
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0447C606A31B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 01:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0447C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mxfw4T5t
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3ab27e45e7cso478001fa.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 17:08:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793927286; cv=none;
        d=google.com; s=arc-20260327;
        b=lJs9NnQWAWbD3LT2U4ZhyHo/Ph1/snqNHwaYR8aczGT5kMw3B2IPf7jzgynLiYZCV2
         PHrMQ+8CfnsoGAKUvwfRfCPzAoZRfPQKKf/krUa6YbEDfB/5IU1rW/QIIC0c6tPMlhSm
         x4Rh2cnTjop0hddp/Hq/bGIedsCZaBe5Yo+8LUzriAHm2m3KJQ3gLrJjyS2T4HnDjRG3
         mfFIS1+jkwTWLGamEIT/aRVWTtt0+xP7jHYUq5vNn7vXJrWbvMwoNxkSiqUymFrRsdxD
         OeKZCVLyg8lg95gSUdHm2u7kziWKA0uT6q1KEbw2/fGRFmLSLkyB9L2EuwBAOvBt+7k6
         obcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fJkGz5CpoFWJRGd5AF5Qs6l5/HtOobvMGiH1ORmFADg=;
        fh=Ce89fu9IpI/xJsnkNVODREIOs//fWW7unL28AJTDG1U=;
        b=sk03DDXCcidCmst9U2yaxuR/sro+VRQTdjT3st6TVh5hb5pZBpVZczW1qGW8ATXiuQ
         UIUCzWT6lI+4IXcKrTihDc83s7lhfjirAboz6LA36iRnX9BCXlZvPdgo8SOJfuKobh8u
         ivvix8s1FapF0j5R6vXTo0tqWKuApwyCuP7Gfi4TSD8CAwdhySsi3lbtzPKHqI3LPrdQ
         7Xn8oY4ib8Cl1CrLzhLse8mqAgHsNo58AkI2vAYBdSxs4inzEKdCtm5pd4iiDiSVkhso
         aJPZt+QGcH9JK0JSRYcaKSLpySdJ3kSn/+17lCgoYjof+fa5E5GTnYXVclkVVS1I0ceb
         iODw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793927286; x=1794532086; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fJkGz5CpoFWJRGd5AF5Qs6l5/HtOobvMGiH1ORmFADg=;
        b=Mxfw4T5tUufe87vDam0XgzvAbn83pyWk6QvSJE5ic30mOrJRb0aQ/mUuC6oqPJiSty
         VZNyOvDCv6JqTvqXqKkMd0alCaqvsVd1HyPioR11hT5VRtb6oN7spV/F+OXFEruEM9h9
         4yzlD2DUbJkCwioK/FDxF2oQF/hM2518Dyd+if4nji/cGPcQhizWGSBB/8kluO502+bL
         0jX3tTT2LpRM8NnL2S0Fxk9st+vGpAoFzfvo5sLYVqa04XndUaUhvbFEDWWwHVI9z0EP
         9Wp50CG6j5LWcFLucKB3/tTjk5W83Rwnz9JEModvplA9A35Aiz5ERAVclQ1FNnZI3S7z
         evOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793927286; x=1794532086;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fJkGz5CpoFWJRGd5AF5Qs6l5/HtOobvMGiH1ORmFADg=;
        b=Kp8YF+XpfDX8yWfxEt03vuLTYIvHcl1/gxXxeMtSnJyPnRsPOrpdya5mfeNhCl8E2o
         trQuzi+2VwzuyQGQ9iF4l4M10jHd/wlAJZcVmgVUuKzvsBPYad1kV6J5V3cI29BVg3sf
         uWaYK4CatvMwF24B2vsmnUzdDZtB3FwV03xqhkmOOGaALIsX/1gpQv329D3WFFGU/iwQ
         3LKo0O3RuWm0pZxLWv4iz0ZgNISuI499BMaATY6CVft6U9Sn9o8uOKaMUXzCzcN0g+Wr
         Gxya5hRB95EZfOKPA0Qjg4J54gXGGi8r+e1KM6VwmZXTY5Wdwxg0+2hv6b5BGN2Z1O4q
         ZJUQ==
X-Forwarded-Encrypted: i=1; AKwUvBwn7sSfyXmi/J7p2Dxd85KtJSOtYAUYrLiLbEjgLMWP+9y162eFcvDHnFD4PGYed+e8K1D5Oss=@vger.kernel.org
X-Gm-Message-State: APuU4Z9oua8KKQ1zMp6CdYaPrp97qUP+jT39GG5vQZUBtmhsLD2WX4Wp
	qhHEndgD2LpG/K0FCrwSTEKCMn0o/Hf/9jDuHWwR9mxSOI03V8qZNLpBx9VIpfzM4gU+NhVg5gU
	SSAZLybun3RWp1vRmoI4T63i/VOXvUN60QPTj
X-Gm-Gg: AYBFou1VYil8pSSjeD+ZUn2CjhLvwzJxyZY0MMLRMQD9NJ4L1WGSHvbvQMIFLxO50DI
	f5dmNcx0AYhA+0lUXANb+Vqgv4G29rwb2fnUulSgdbnr9OKqVfZpPmDzVcAYZRdXRGZmzMaFCxs
	U6CQljagI7jicEkXfKamDsFq7O+I7IMpVEGyc+PuHVkH2dTtguT784jXG8QK9S0X5rtPYKASSHY
	woHO1hUeU6CteF8GsdsprPV6a2kx6bDIiBolZO1VglX+hUyxl4RuC1UCgLh4SSbWNCCai5a3asC
	6xKsoitQHBoJVXPaL/wWDwNYfoO3meLbZ26f0VOndZ3n51+FHvBNCI1qtOobL4C3fdWfg+5DWi2
	XsW/qSW3XMEMoh1159gLupNhPARH7kLleE8uhPu8Jv/Sw2Wex5/gdkg1Q88+/n0OE/ecuMKw=
X-Received: by 2002:a05:6512:6d3:b0:5bf:b249:375c with SMTP id
 2adb3069b0e04-5c003ac2cd3mr230843e87.13.1793927286155; Thu, 05 Nov 2026
 17:08:06 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027032332.1945140-1-liuc63@xiaopeng.com> <CA+fCnZfgi_UUsMg4p2iRePACOAR8StQRYhgC9fHETE8Q5n0z5w@mail.gmail.com>
In-Reply-To: <CA+fCnZfgi_UUsMg4p2iRePACOAR8StQRYhgC9fHETE8Q5n0z5w@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 6 Nov 2026 02:07:52 +0100
X-Gm-Features: AclHuK_GOq5XW9qGIOfiza9qDe3tNSjEThoOLcatbbltrIx8xUgFUsgaRXZuPqI
Message-ID: <CA+fCnZcH1dZ3=Raeh3GkQt7vfqdhKtTq+VcyhJ7Ks2ZRcV_dgw@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: raw_gadget: fix dangling ep->desc on enable failure
To: Liu Chao <liuc63@xiaopeng.com>
Cc: gregkh@linuxfoundation.org, krishnagopi487@gmail.com, kees@kernel.org, 
	balbi@kernel.org, zhugl3@xiaopeng.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 1:43=E2=80=AFAM Andrey Konovalov <andreyknvl@gmail.c=
om> wrote:
>
> On Tue, Oct 27, 2026 at 4:23=E2=80=AFAM Liu Chao <liuc63@xiaopeng.com> wr=
ote:
> >
> > raw_ioctl_ep_enable() assigns the user-supplied endpoint descriptor
> > to ep->ep->desc before calling usb_ep_enable(). If usb_ep_enable()
> > fails, or if the subsequent usb_ep_alloc_request() fails, the error
> > path frees desc via out_free but leaves ep->ep->desc pointing at the
> > freed memory.
> >
> > The UDC driver may have captured the stale descriptor pointer during
> > the partial enable sequence and may dereference it in subsequent
> > operations, resulting in a use-after-free.
> >
> > Clear ep->ep->desc before jumping to out_free on both failure paths
> > so the pointer never outlives the descriptor it references.
> >
> > Fixes: 97df5e5758f7 ("usb: raw-gadget: fix gadget endpoint selection")
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> > Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
> > ---
> >  drivers/usb/gadget/legacy/raw_gadget.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadge=
t/legacy/raw_gadget.c
> > index 46f343ba4..b52ab3ce7 100644
> > --- a/drivers/usb/gadget/legacy/raw_gadget.c
> > +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> > @@ -886,6 +886,7 @@ static int raw_ioctl_ep_enable(struct raw_dev *dev,=
 unsigned long value)
> >                 if (ret < 0) {
> >                         dev_err(&dev->gadget->dev,
> >                                 "fail, usb_ep_enable returned %d\n", re=
t);
> > +                       ep->ep->desc =3D NULL;
> >                         goto out_free;
> >                 }
> >                 ep->req =3D usb_ep_alloc_request(ep->ep, GFP_ATOMIC);
> > @@ -893,6 +894,7 @@ static int raw_ioctl_ep_enable(struct raw_dev *dev,=
 unsigned long value)
> >                         dev_err(&dev->gadget->dev,
> >                                 "fail, usb_ep_alloc_request failed\n");
> >                         usb_ep_disable(ep->ep);
> > +                       ep->ep->desc =3D NULL;
> >                         ret =3D -ENOMEM;
> >                         goto out_free;
> >                 }
> > --
> > 2.50.1
> >
>
> Commit message should ideally mention that the use-after-free is not
> actually reachable.
>
> But the clean-up makes sense:
>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Hm, looking at this more, it seems that the UDC drivers that care
about the value of ep->desc for disabled endpoints, NULL it out during
usb_ep_disable() themselves. And other gadget drivers also don't seem
to be NULLing out ep->desc explicitly. So I'm not sure if this
clean-up makes sense anymore. At least, until we get an actual
reproducer for a crash.
