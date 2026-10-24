Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792809241;
	b=tuPQY4HRRVXP+e5sY6FOwGGNkr8dvSgbynyp+p4Exz9Q6JeeNMlS6jMgxSSveB4CcbI4
	 L+nbwyeANHIvTOffosSoR0+WyEvbmdp50ScPLEGsVDOP6zVY95MQjYcZY2BSMapT0SeHj
	 zG5A0rYPhjgVkvICjRxBj0+r1iFduTX2NSc2Z/uoNLHdnH+ivE3ShKYykBd3TI3/hfN4l
	 u8FApWrNNZwvFy77vmEwdiD+AaxEvsDWcGLy9tfU+bbuxWaDia3xo2CHFM17mAUuNZAfx
	 DBUkId/LKn4DhKE9E8FM79qMpgUQKuWXn6cY8Pa6Zo3oY/u9vKa258pF8+hVJkNsS9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792809241;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YOvydlCVwM5PXFqKpBEvvD6ro2jGwhMV+E2WExIceR0=;
	b=NeCBJbFruQbtA8fgCuTZy9X9Yj31f1kI4cvDQ4RvYHY4ma4/4cbOryLSUfUh/bWWQkbJ
	 rQnj+EHl+YNNes/bhEpjpIZjDEZN9U/+dDI9RQOi+lbdBn/oTffNIUS/GtkGN9UDrCgeM
	 R3vcnKTD9ergHn6RTXlU28W9SI7IZEa/omBMIOu6ySvhbZjqVaKvoAft52HajPmlpr34w
	 AqyjmY5/Ocb8QM68M7ONHJ3yAjVXYB9lz3pvXxJeHZnTHHLxpX0736+NHOtP8bvGnLQTP
	 jcCRezw7a7mZn2hGAlbjMjtJa45gHeqxW25aeE4j5D98qJ8RK9gzRWaPO2NMdXtuAMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZNWvplRj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47561606A31D
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 02:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47561606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZNWvplRj
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b1aa2848d2so2288710a12.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 19:34:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792809240; cv=none;
        d=google.com; s=arc-20260327;
        b=nFu5HbTCpX/xHRIl2oi8F+wX7SaGuUYOp4mhOhQGInrdJeCRBdSeqpffNPuOfhRYcd
         EVYTHQMPsvb4dFCGqIU1clDrfjl/sej1Fzm4OA6qVCJSvZlhTxbTHa/RFiCZSUF+0hs1
         sLxxeLwB17PkjytsnUzUpwU/7bDTrtPIHEGabaDGa6E26ci8QSb6UWy/RXjoeKP+/IgY
         vOL/U5INxNi84UW20CVvTfoEoSYb+G43ssI8HO0dBx/meZG98poOoUPahFPRepOjgdwt
         KTOmtMEhTCEjb98ylfyLNRjCEoBgHQHI6kB0HY7Ex4cvdOJy4yyFeUvWW9fDiFDAaLXB
         Vu/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YOvydlCVwM5PXFqKpBEvvD6ro2jGwhMV+E2WExIceR0=;
        fh=x008Gf9BX3ryb4+cX+VYOcDHHCAqIwo7gCiaubKHvCQ=;
        b=HO8UB8QCeXBvREXfJUVgsWJhMnaFQ7OKGGRViNFBwqq+pLa3CsMVnhOv61ReYjvioK
         2FMA8bL+Nfmsmohji/q4IQu0bf2hMvr3ja7Dn7cSUTlz7WsFvur+j6b01EjTEf8CjyYz
         1bgT1I7o4XAeoPBeeP1gCF+RuISGXWKFEqCtm/g+fIHh0RSQNchdbjQIHX72Wugg22L+
         mNHDc1nD0rLqdW6AH1HnDXm3wzasyVYK/cxbX5sVpyA1WHB8hZqGikSb8NuZASPl0hAF
         cA2EQvKWIXhf3VxxLVhnETPfMdXCCw0hEGDPERKGMX6+4bfBKYfGOj2jAlw4xlhuaGum
         pTdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792809240; x=1793414040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YOvydlCVwM5PXFqKpBEvvD6ro2jGwhMV+E2WExIceR0=;
        b=ZNWvplRjO+I1horpBlo8J9/L7pCEpW8hMtQMPU2a+8lZ7X5bNp9yChxqm96Bshw9Dg
         dkhaYKv3i9l7YjPCad/Jw6ERfjTUYxjj2YQqO9wxme4wu6YIRvXoZpdJQwdRuBuXDPp0
         9uEwpFDlzZvSs9XluYQZYAQz4+t+F8VROOpmmmPmYDe5ujIlriUsiCyQ2ihN1yaKKR32
         0knsUYy+dDxJdbiRNHxVg0IC1VCtOKkJWC1YulNBpanU4lgoESJHLOra/rAyZnDzQMJz
         YmCYdyLj6MIIGINi6YYvfiwtqm41sJjRz2BxfiIIsv1hVGFod6tJf6QmppsY8DZpm2C2
         jWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792809240; x=1793414040;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YOvydlCVwM5PXFqKpBEvvD6ro2jGwhMV+E2WExIceR0=;
        b=bNIbAvIHoHyv2zy6pFAKk1Z0DsmfpJjwGESkPayzSPcmcVG5OBreXTM9COgLM9MSTe
         ifhX15Rrg2LYeP4fdI0b7PioFj+GAiy6dpcHkaj4JdxLwi3J0Arr7RbKedwPO2Z08FQW
         2n7RNkOnB1m3FKH52VSI1uAOsABFUwHrX1jrjyGROfCT1jNAdN3wcdb95D2xxqArqJjw
         ftxuZ2IrREIYszLT80KZjjov+3kx18Fh6/Nv0iYcTLQopEH6cvl0G566Ki5FH2zClnQk
         bRpmGG4TzxfBJeuh5+5RAEwT3mnOT/J/48rCdYelXduM39DGlRDKXUs8mPmYxglXlgS7
         tCTA==
X-Forwarded-Encrypted: i=1; AKwUvBzVZqDqlvZholNd/8AexJDnh9aSSqSGOReTChPA7kl7kFFyDRXwwTijOvu1wYDZ8FomIHX+0wA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxAbUKTOcL+DVjZJ9nIBqy5oW/KOdjpho11MpeypoqGD0OiK8V
	oBDKVPF+RpNP0moGSHj2qyr3Csm6+1GuNzeRoMujQ1M57+YBGiZysD4YAuegEhgGjeYslRy6BVF
	Ct/AEjbIEbM1N/fkA2D8xyh+wyYBjbg==
X-Gm-Gg: AYBFou0DwNs3JKf4c5uOGf8g1m2eWy3OFcmz5V/SQIX2A3GmMSjPNGXaOq1jw9Y+iZ3
	XxQxbKsCG8gtgiimoKjDtRD9sFlKmD6+svzYstcpfPyEVnZwFNzQWVHnORiPTsf9VbS+b86xApv
	PTHpf17QkDPSr0X9kY5plqhZmlfnskIvLAo/O2xQepXZVAORcu8EZEKRpEYBIf9TiXay9gdRevZ
	UMccLYr6/nnbiWf/0BKt2XgftIQ04ZE76m9QGOWMooQImLO6glmVraPhCPeeJrZcKhc/y/tUR7I
	lQ89E2qp20iJtAP5l+0gq69bvA6Zwe716q4j3ax/IVPXl8eUlzNUGoyKPhPFvU+RL8Rt5i+KIPj
	/iMYnJm8vnp0Pa9u6OuJdFqiXYy1JYyzM6GvHaQ1j1CQjXk38QBXZvE0Qn5qiEJWTd5q81IKzt3
	GrQQdNU9tzleewq8VwWoLYey/bDdj2X0tFbCncL9D9e3ipzwuGgw==
X-Received: by 2002:a05:6402:2491:b0:6ac:934e:a9ca with SMTP id
 4fb4d7f45d1cf-6b4429ff463mr1127240a12.0.1792809239498; Fri, 23 Oct 2026
 19:33:59 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260925191653.3144006-1-mhun512@gmail.com> <20261001175502.4045853-1-mhun512@gmail.com>
 <IUKxO70u7tuzfobwy7veeNHbvyK5WtlYFOliAToGsdPncgmwXfbd95-SoyBBUj0AUENfcYLnsh4qaFj4AEkeKA==@protonmail.internalid>
 <20261001175502.4045853-3-mhun512@gmail.com> <74c10fee-bfb1-4225-af5b-fc2b3ce664a9@kernel.org>
In-Reply-To: <74c10fee-bfb1-4225-af5b-fc2b3ce664a9@kernel.org>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Fri, 23 Oct 2026 22:33:47 -0400
X-Gm-Features: AclHuK_Cs1i4iiemFtAKcWSfw5YUpemoD4SHO0r3M9ta6g3IG7c7Sepq9ogxnl8
Message-ID: <CAGEsz8GZ9QR=L9skNierVog8_=o-vBObqin=+dJZTDcpOa1TYA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] media: venus: disable recovery work before HFI teardown
To: "Bryan O'Donoghue" <bod@kernel.org>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org, 
	Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bryan,

Thanks for the review.

In v5, I removed the disable_delayed_work_sync() call from
venus_hfi_destroy() and kept it only at the start of venus_remove().
The work is now disabled exactly once during removal.

Thanks,
Myeonghun

2026=EB=85=84 10=EC=9B=94 1=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 4:10, B=
ryan O'Donoghue <bod@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

>
> On 01/10/2026 18:55, Myeonghun Pak wrote:
> > venus_remove() cancels core->work before the IRQ is disabled. An IRQ
> > thread can queue the work again after cancellation. The work can then
> > access HFI state after venus_hfi_destroy() frees it. The work also
> > requeues itself when recovery fails, so cancelling an already running
> > instance alone does not close the race.
> >
> > Disable and drain the work at the start of remove, before other resourc=
es
> > are dismantled. Do the same in venus_hfi_destroy() for paths that bypas=
s
> > remove, including probe unwind. Disabling the work prevents both IRQ
> > handlers and the work itself from requeuing it. Drain the work before
> > disabling the IRQ so an active recovery can finish any IRQ based
> > completion waits. Then synchronize the IRQ before freeing HFI state.
> >
> > Fixes: af2c3834c8ca ("[media] media: venus: adding core part and helper=
 functions")
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Link: https://lore.kernel.org/all/20260730153912.BAC5E1F00A3D@smtp.kern=
el.org/
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> >   drivers/media/platform/qcom/venus/core.c      | 2 +-
> >   drivers/media/platform/qcom/venus/hfi_venus.c | 1 +
> >   2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/p=
latform/qcom/venus/core.c
> > index 7087af32060f..6e495bc04691 100644
> > --- a/drivers/media/platform/qcom/venus/core.c
> > +++ b/drivers/media/platform/qcom/venus/core.c
> > @@ -596,7 +596,7 @@ static void venus_remove(struct platform_device *pd=
ev)
> >       struct device *dev =3D core->dev;
> >       int ret;
> >
> > -     cancel_delayed_work_sync(&core->work);
> > +     disable_delayed_work_sync(&core->work);
> >       ret =3D pm_runtime_get_sync(dev);
> >       WARN_ON(ret < 0);
> >
> > diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/me=
dia/platform/qcom/venus/hfi_venus.c
> > index e7e4e78a186a..20b8ba1e62f1 100644
> > --- a/drivers/media/platform/qcom/venus/hfi_venus.c
> > +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
> > @@ -1689,6 +1689,7 @@ void venus_hfi_destroy(struct venus_core *core)
> >   {
> >       struct venus_hfi_device *hdev =3D to_hfi_priv(core);
> >
> > +     disable_delayed_work_sync(&core->work);
> >       disable_irq(core->irq);
> >       core->priv =3D NULL;
> >       venus_interface_queues_release(hdev);
> > --
> > 2.53.0
> >
>
> You shouldn't have to disable the work queue twice.
>
> Does a path actually exist where hfi_destroy() runs but venus_remove()
> does not ?
>
> The commit text is vague about that - sure hfi_destroy() may be callable
> from the error path of probe() but is any work scheduled in that case ?
>
> I mean lets just look at venus_hfi_destroy()
>
>
> static void venus_remove(struct platform_device *pdev)
> {
>          struct venus_core *core =3D platform_get_drvdata(pdev);
>          const struct venus_pm_ops *pm_ops =3D core->pm_ops;
>          struct device *dev =3D core->dev;
>          int ret;
>
>          cancel_delayed_work_sync(&core->work);
>          ret =3D pm_runtime_get_sync(dev);
>          WARN_ON(ret < 0);
>
>          ret =3D hfi_core_deinit(core, true);
>          WARN_ON(ret);
>
>          venus_shutdown(core);
>          of_platform_depopulate(dev);
>
>          venus_firmware_deinit(core);
>
>          venus_remove_dynamic_nodes(core);
>
>          pm_runtime_put_sync(dev);
>          pm_runtime_disable(dev);
>
>          if (pm_ops->core_put)
>                  pm_ops->core_put(core);
>
>          v4l2_device_unregister(&core->v4l2_dev);
>
>          hfi_destroy(core);
>
>          mutex_destroy(&core->pm_lock);
>          mutex_destroy(&core->lock);
>          venus_dbgfs_deinit(core);
> }
>
> Your patch will call disable_delayed_work_sync() twice on this path once
> in venus_remove() per your patch and then again in hfi_destroy()...
>
> NAK - can't be right.
>
> ---
> bod
