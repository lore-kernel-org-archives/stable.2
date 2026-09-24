Received: from mail-ej2-f15.google.com (mail-ej2-f15.google.com [74.125.228.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53074ACC6A
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286263; cv=pass; b=qdcx+faGX55qrG9r/q45fC1baMiDCiFuptQNCBjR9xDvhWf0K+czjfrxHwDaIeShQKYvpWtBzOkWF0xXf8IKxh4xlN6UhR/ohCubYCD0V50tMBiiKCvzOyGsNffGrd6Vv5tWPUHL+vlunmHqBQ+IVK0/7zpTbrCtbw8bpTKp1gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286263; c=relaxed/simple;
	bh=Wgru4OjuVg3jCDnGRQ58mHB/1Zm4b8OJkeS6vEJYfo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pex6TeYWkQ2YtJ851eFQ7WuX9srmgGKjx5OSBliwVlqubujW0TX6G30gdk9Ze89jJ4w4ocjRc4szsB5GOmllrcm1B9uesTUXUx7iibskgHWDkv4wYbw/FHJI40MnCNcaawVopZTy0lh0QL2NPk+fQiMqE78Uk2dQ7Bjx6lN8R2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAFivdSO; arc=pass smtp.client-ip=74.125.228.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAFivdSO"
Received: by mail-ej2-f15.google.com with SMTP id a640c23a62f3a-c254f9f7dbfso27139466b.2
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 14:44:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790286260; cv=none;
        d=google.com; s=arc-20260327;
        b=Jnfjbaa3s1La03WSvzk/k/Exm1FH5GrXjRm8apYmM2N7s68rSKxMT8dTplB4lsDppX
         6BdSLp9dSrOkAPpTCmcxtGBGsJOHGYpRg50QZ3y+MDxgMgHKWRWi+iEf2+bFNtBk49NX
         g6ZtM/PnOCCJVQQjhtZOV67rCK1JPVwopowXYGN0iKFt3t9dsjyBB6fX6Fk9Q2PTx1hk
         u/00hvNaHlBvvBC3AkSQh5ucb+Q5Ss/G0JlPAmUAfUtBi464kqvyL1cTXLw74pAqrryj
         gpZDNPchAVFx30OWeW0egdSBYCOeXLNdzf+wR2djVEuprCOMcsG41POw1qwdtatd1xan
         ju7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8Hd9E5QifhtpgtcPM7YVUZkrW6k2XVu/g81y+pYANv8=;
        fh=atax8ltjHUrC/oLbP/JOKQjpiMumjgSE/OCaMI0NJ9Y=;
        b=KysZ1dHnhDHjYfhrvrfA4y7Z1DwYtGrvoRsebQgtNZisYcpH8DWVX3QU03Bp3qg++X
         lOxHp5FEUTO64hs6dFGf0CLeTYBgEgkHSmbWcz5A2RHahP9x2qcDSAGaq/u9/9qUOpmx
         fJGzkPWvwAa3YXMfFhtlRxjquVeUtOtKlez7u/J/Y2HSBfsifhKnCygrlHUAbF4k26kZ
         VsB1vXTBxuGBwkTHeNN0gyeDiUAKLmNoBuhOYt0XDigG5wn60eDvyn5sMDzdjd5mhnX1
         hPw5zlYpPjVZuvxrItu0XEhkXJPYeysDQa7hPoOkc/2hOGyLxi4h3i6pyf4wls5mkpSP
         5xJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790286260; x=1790891060; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8Hd9E5QifhtpgtcPM7YVUZkrW6k2XVu/g81y+pYANv8=;
        b=XAFivdSOKjXL+7nAPoMuFVquY8Lou20uQBDrDdNDuHjmU2iiqFjzpWFRBatDFk6a+x
         W8U56MV6xHSTrf1mrh0MfvY8nFkZ8g2yoRPlyrPKaaGeYJhma7IEgfN6jaoWOqjDdaIF
         COoNTOSmZjTZXMcHKvHHOTM+VXX+Hqowhs6eO7TLnT3DentisECxHP69pCTVUhB2Cpau
         3JgXyPyGHAFff/4k2/4WlFRO1KBI34R9NiuSTBesLdalq/7Or1aOE3+e5dzkWWabROxT
         ud77JoG9543uA/xpm65kVcrz6pJq2zwF7E/FjKzbEl6hdLaZ3ifGEZ/T8jLxI2H4Maap
         Y29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790286260; x=1790891060;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Hd9E5QifhtpgtcPM7YVUZkrW6k2XVu/g81y+pYANv8=;
        b=pDFImKiHO5R61SEDD4TUjow5F4Uwli5RfP4ZkP6H3BPk/NyOJmscLMyRLkCueCzDoT
         AlpQG6eb7WuPtc4TzKZqXCZYOD9TKt9G8LpCaU/Dc+uLOkYSc58XgCa5ghQMLkEGVc81
         KD8KtD5KmCZFXygK9J/t/7mHnMyNtawmLO0yA9ufcLamhTDmeWJ32UTeaM4ihUuBluA0
         Pw1mEv8eKi6iv+7bT6Nz6iSjyhyAWTmfGR8f6ZmpqluVmgvvtlT1+k8oUCCEcn1u1D3X
         lkp/i7HwAR07SvU6pOBZQPZLZ6Uk6umT0AxjLetZYxC9XzXqsqizajTAm3hOd6ehrxcA
         HoUQ==
X-Forwarded-Encrypted: i=1; AKwUvBymwfIgOFUKOx4seOc/V7obq1drJkkZNgYePBJMtLo0ukdpuQVv2NcmEyFfAtV0LXhDWvxjFRQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lLPUVypbKDOc6c9MzzCHmANl+V6C23q1zeTTA1CZRaBiCKdoot
	EWrsmcoJ/vZnAcI7VDfSmRqy9xZ6Ig34lwK/ecODv/w62FvaAAo5TJDVO4bW4q29XiaYges8+cU
	ig9TEVSQNq55N3T0BH0HTV0rwqh150g==
X-Gm-Gg: AYBFou2LZCoZvtISqH0KZQLUTABAnxtmK0mFkatR5n2NRsDK11nTZ+48XMO64873WlV
	vep4zSXP9ylv13RqcblIZKqVoNt6xP5bTGKQ4fk6dFVj6VNVZnlR0Ysg4iPYwqwM1/DyJgoJzjG
	APQtmBhHG7kzt8KJ9FiT9zi/SLewMpse0omqyZZ0otKelS1af5W1Qs/TaNIkRpq/3FdNuSgUSYe
	0ZVfith2Dh64RqFu7NWsA8Em8U3yvLoXT3IXVHAfV5dtTG2BC4gBLv5bMBXKNQpGS6tIKbO7gk3
	rpFdov6+fj0XfJ4P+E0CDKudcBPc6JsiEZdu3FjtCLkE/PWTYjg8EQA412gJTHX2TyE72t8mEss
	xliHPscOjwhD7f9+LIs0oGpiSGi9E5KyMcBO5BqNSefyft+xMKOH44zQoNP2/7sdgl9zE
X-Received: by 2002:a17:907:d789:b0:c29:5172:6151 with SMTP id
 a640c23a62f3a-c2ac263bc06mr316219466b.45.1790286259718; Thu, 24 Sep 2026
 14:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923022033.957777-1-mhun512@gmail.com> <f1c55b79-4487-40db-b2fc-342b2dc33c1f@linuxfoundation.org>
In-Reply-To: <f1c55b79-4487-40db-b2fc-342b2dc33c1f@linuxfoundation.org>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Thu, 24 Sep 2026 17:44:07 -0400
X-Gm-Features: AclHuK82jDvsEJh3-yxSL0CblB52txRSE9rfFHLJvMufpWcIZEhKrFhkUYovzkw
Message-ID: <CAGEsz8E7TT0SqSPxpJS7QbAvAwXF8n6_ra4VPvN=q0SHdavm0A@mail.gmail.com>
Subject: Re: [PATCH v2] usbip: vudc: Prevent transfer timer rearm during teardown
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Valentina Manea <valentina.manea.m@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Hongren Zheng <i@zenithal.me>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Ijae Kim <ae878000@gmail.com>, Michael Bommarito <michael.bommarito@gmail.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

__must_hold records the existing locking requirement for
v_start_timer() and v_kick_timer(). The old comment was inaccurate
because v_stop_timer() runs without the lock. timer_shutdown_sync() is
the actual fix.

The QEMU harness sends CMD_SUBMIT packets while repeatedly unbinding
and rebinding vudc. It reproduced the bug before the fix and ran 4,000
iterations without a report afterward. I=E2=80=99ll add this to the v3 comm=
it
message.

I have not tested with physical devices and a remote client.

Thanks,
Myeonghun

2026=EB=85=84 9=EC=9B=94 23=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 5:11, S=
huah Khan <skhan@linuxfoundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 9/22/26 20:20, Myeonghun Pak wrote:
> > Commit d96209626a29 ("usbip: vudc: Fix use after free bug in
> > vudc_remove due to race condition") deletes the transfer timer before
> > vudc_remove() frees the vudc, but the receive thread keeps running
> > until usb_del_gadget_udc().  v_kick_timer() calls mod_timer() for
> > CMD_SUBMIT and CMD_UNLINK even in VUDC_TR_STOPPED, so a packet after
> > timer_delete_sync() rearms the timer and v_timer() uses the freed
> > vudc.
> >
> > Use timer_shutdown_sync(), which ignores later arming.  The transfer
> > state is freed with the timer.  Annotate v_start_timer() and
> > v_kick_timer() with __must_hold(&udc->lock).
>
> Can you explain why __must_hold(&udc->lock) necessary?
>
> >
> > A KASAN and DEBUG_OBJECTS x86_64 QEMU guest reproduced the free-active
> > timer warning and the use-after-free in v_timer().  The same harness
> > completed 4000 iterations with this change.__must_hold(&udc->lock)
>
> What does the harness do? You mentioned it in a response, but I would
> like to see this in the change log.
>
> >
> > Fixes: d96209626a29 ("usbip: vudc: Fix use after free bug in vudc_remov=
e due to race condition")
> > Link: https://lore.kernel.org/all/20230316180940.1601515-1-zyytlz.wz@16=
3.com/
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> > Changes in v2:
> > - Drop the lock-held comment and mark v_start_timer() and
> >    v_kick_timer() with __must_hold(&udc->lock), on the prototypes and
> >    the definitions (Greg Kroah-Hartman).
> >
> >   drivers/usb/usbip/vudc.h          | 6 ++++--
> >   drivers/usb/usbip/vudc_transfer.c | 8 +++-----
> >   2 files changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/usb/usbip/vudc.h b/drivers/usb/usbip/vudc.h
> > index 5ef0e7d9b23a..c129f4c56e8a 100644
> > --- a/drivers/usb/usbip/vudc.h
> > +++ b/drivers/usb/usbip/vudc.h
> > @@ -157,8 +157,10 @@ int v_rx_loop(void *data);
> >   /* vudc_transfer.c */
> >
> >   void v_init_timer(struct vudc *udc);
> > -void v_start_timer(struct vudc *udc);
> > -void v_kick_timer(struct vudc *udc, unsigned long time);
> > +void v_start_timer(struct vudc *udc)
> > +     __must_hold(&udc->lock);
> > +void v_kick_timer(struct vudc *udc, unsigned long time)
> > +     __must_hold(&udc->lock);
> >   void v_stop_timer(struct vudc *udc);
> >
> >   /* vudc_dev.c */
> > diff --git a/drivers/usb/usbip/vudc_transfer.c b/drivers/usb/usbip/vudc=
_transfer.c
> > index d4ce85c4c6a2..ba625622975e 100644
> > --- a/drivers/usb/usbip/vudc_transfer.c
> > +++ b/drivers/usb/usbip/vudc_transfer.c
> > @@ -441,8 +441,6 @@ static void v_timer(struct timer_list *t)
> >       spin_unlock_irqrestore(&udc->lock, flags);
> >   }
> >
> > -/* All timer functions are run with udc->lock held */
> > -
> >   void v_init_timer(struct vudc *udc)
> >   {
> >       struct transfer_timer *t =3D &udc->tr_timer;
> > @@ -452,6 +450,7 @@ void v_init_timer(struct vudc *udc)
> >   }
> >
> >   void v_start_timer(struct vudc *udc)
> > +     __must_hold(&udc->lock)
> >   {
> >       struct transfer_timer *t =3D &udc->tr_timer;
> >
> > @@ -470,6 +469,7 @@ void v_start_timer(struct vudc *udc)
> >   }
> >
> >   void v_kick_timer(struct vudc *udc, unsigned long time)
> > +     __must_hold(&udc->lock)
> >   {
> >       struct transfer_timer *t =3D &udc->tr_timer;
> >
> > @@ -490,8 +490,6 @@ void v_stop_timer(struct vudc *udc)
> >   {
> >       struct transfer_timer *t =3D &udc->tr_timer;
> >
> > -     /* Delete the timer synchronously before teardown frees udc. */
> >       dev_dbg(&udc->pdev->dev, "timer stop");
> > -     timer_delete_sync(&t->timer);
> > -     t->state =3D VUDC_TR_STOPPED;
> > +     timer_shutdown_sync(&t->timer);
> >   }
> >
> > base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
>
> Have you tested this with real devices bound to a host and exported
> to a client?
>
> thanks,
> -- Shuah
>
