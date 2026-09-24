Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27429349B19
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257980; cv=pass; b=ARNSaYudPVJI2ipICtsheXWY6fKWPKjzhLXQMj7tuE498Sf7rpIMbsd7ndeyW/Tr9VS25ENBsjF+8BcwgEzk7ILkJUstFZ5xW1nMqWdDSU0jwPRXY+2xudz0LGZ9kq9Jyn13DZgpPAD9M4bkejxl08mNL68MYU17HAaT7Y06k0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257980; c=relaxed/simple;
	bh=QoUAEYmTjcom/GYw9KMesKKHysm5dGsVufGYG8k4VHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHnpWkMHdJ2hxx/W5SCiUCFJsSkaZcZ7cCYVAPsTGVXYj/z71l77Aav2bk5KtCOeqxIQnLTXoeo6wV9Vy+RAGXlQR8zdGNhu0Md/3vWkzgAweF5e3bsTzJurGJ05EDKL7PmnMQHdRJe/4vh8u3fghTJysLby0jN3l12ntPxXK78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=okzYmvPA; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okzYmvPA"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-672f90fc533so464831d50.0
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 06:52:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790257977; cv=none;
        d=google.com; s=arc-20260327;
        b=KmQv+cNs5w3DhX/BLeiSLLy715QFs+tgRFXtLROS8Xi5BOvUDeY1UFqZDvxYHl3r5h
         lzouBo9M2nHmCFV3bb/k02W1IXHtI1ABNoy5+ZYBr/5pTXgjR/ZsLH9y2m3DyF/dAwXC
         oSTgDr68mkQ/YCt04pO4/Jyud+du9Qt+Pf78nYSGBKh8JBk8j5IPTwINeQd52YMNt66E
         SNLDhXNDk8dInwieBKHe1Sy+p/s6JxXUlwaKFGLE61OJ4WffcDI2i4F/bYjwQDRcfzWo
         5QEb19DYBoJCSAsitXh/KH7j7pDuOCRuSXT9eb7n4XKXXJt6BCfqYKVZI8141x+fbOAQ
         j0Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nWToiZ/0mvm/+JbzSK7npOR4gXzr5F7+OnypdaZRifc=;
        fh=4EtPwv1krfER1tLvSiY2wfnp7wTYq9SiW1RSMuhcLXc=;
        b=CzUG4jK3hpYLza7ly5yFUQV3trP8nKS2b2C7JQJf/NE4+f0bIzNe1AMmnKUEz5i9+4
         Yu9dWKF++nmzsicm62tNoocps1kLNVVeTrANtmVb4q9EGsinAqFyBrU7qUU27ubXT1Bo
         fhENveFDdRVbaEtGOF2Ca7+ZxCuRfDHjm8TFQ1CKEPe1zNdZWAEi9Pehx5dF8ML/Hcvi
         6QoqWTVw+qN5ACZ0EBRc6a4P66ZRLb1yt86nU21j2QOPTdy+/TKjgAIrQSrmHbrTVUXv
         Vw0Vfu4c/eesAXpwbHnZL9DoJegUj3iDYXLvtLLw3NaJhJObsO7NZD29SwqH71ro98lX
         fFBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790257977; x=1790862777; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nWToiZ/0mvm/+JbzSK7npOR4gXzr5F7+OnypdaZRifc=;
        b=okzYmvPAdFwte5RiXCjZPKI3wRK7XZ1K/axg1eTutifrX6fBR3oMBUqDvU8Die3E2C
         uc/dZv9pYWcz4Qcw1kDs1koxSQHhU5YCCMailImMaciVKjn1vGYh1ebbEcuFfrUfwEt+
         GLDwsOnMQWugbQqOk5B/o6wcRNflh4xaSlC86VzLycBdUEcixERGE4NW0+u4zODoebsg
         s/wAsoDSzLXvbbI/B48tsKZAnXFuhu4QLu1ubcAImBHL2XaS+ElbcyGPLaHsoTj8sENh
         bRjrF+ymlIIhACBSUBAUoaX7OHqy7ud03MGTrOQkJpy/g+lAqMT1+7VpgV3j0i+gDwZI
         dbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790257977; x=1790862777;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nWToiZ/0mvm/+JbzSK7npOR4gXzr5F7+OnypdaZRifc=;
        b=MAjXg6aowQP//bE8O3cFCEqhFMC/ylNRn2EOpTkAC3m8RSnYIeMZqxKzL1RKEFhD2j
         HArECNpq43gN+0EzLbbjbl6Eb1bfqifEf4AIpbvTt0lcxF3X0y7iyh2DuUdo1Fci0Fyy
         0nhu4SBwEmmEs5FMTSG3F9yCdpxnXPrLY3LAbKGcM01PogfFb4FtkqXxK1JC89PHJxxN
         3ayLphcHLTiRoLByAVlp94V3xiMCiTCMSJK8OIqm4O1HPrauCTttaUkHuBXKxr1qB73o
         iI7ZTJHXAGIbCuRhop1Oql1Evm305ezNxDfx0lLXHFLduex4X5Ssqubawf1i0MJubIRA
         NYlw==
X-Forwarded-Encrypted: i=1; AKwUvBwoIhccfx2N1X3uxwoPe1cqUnNivZF/eSOchPrC+IZg1Vvqo2lJUZ+EoM1Y29fjFcFOPvRJ/6A=@vger.kernel.org
X-Gm-Message-State: AFuF++mSSoz4BCavYxb2EMq5SzMf7cD5PWF95zzxv0jMXLi4PKNqSrSx
	6ysLNQv1FrBFGILtujRAS7parPN8wZpR10HuLIUXevQ/+N51aHLhiqpk7az7i0G7Om62BAJFRM5
	xOrDdTVKqY65fKP2doIKjzBCSScUhTCE=
X-Gm-Gg: AYBFou2r3TpuHFM7EpdJW/6LS7WkFYBhezHUA6UGiHMND9jXw8/ZaV8+Dwmf4ehz31I
	AledPtzzX4mB3XeQ80yk20s2KFq0x+rwY9yY+8E9RqjwO0BgHyFPh7bOAUiCs2KNTeDwlJv3g8U
	FuxH8jghfQbDIHvDd/suyuYsgf79SdZFTDU70iRg+v2trgXukHfpnO6EdV2jDyaenNeI7tVU5AZ
	A2Ec/WWWhgXogI5rwRlnEtkAp6/SAUFF3+ABFvqB+p3Gvj1mYwOggFUwsfsMq7YZf8GLSN1kkHb
	5+qIAu69IonqlO0mnWsxl1h3tWwFXNch2zYevD0HuTY5lgtJC4o3W6Q2KHtsLmhKCBXD
X-Received: by 2002:a05:690e:1186:b0:672:9f72:7c04 with SMTP id
 956f58d0204a3-672ed4db57cmr1036006d50.102.1790257977028; Thu, 24 Sep 2026
 06:52:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921081542.210151-1-lgs201920130244@gmail.com> <c03262f2-419d-45c8-9b29-f3bfe6680744@kernel.org>
In-Reply-To: <c03262f2-419d-45c8-9b29-f3bfe6680744@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 24 Sep 2026 21:52:47 +0800
X-Gm-Features: AclHuK_HbB37PieMjxtn1FtalUB9H4Cp6DfldwgllWBkEcccv9StBhgni5Up5C4
Message-ID: <CANUHTR8xJ9DGMyadCuhGo1Hw30+VSn0Ko4O3uyR=ofC4OfW2+g@mail.gmail.com>
Subject: Re: [PATCH] media: rtl28xxu: fix SDR platform device leak
To: Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Antti Palosaari <crope@iki.fi>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Hans,

On Wed, 23 Sept 2026 at 16:49, Hans Verkuil <hverkuil+cisco@kernel.org> wrote:
>
> On 21/09/2026 10:15, Guangshuo Li wrote:
> > rtl2832u_tuner_attach() registers an rtl2832_sdr platform device, but
> > if registration succeeds without a bound driver, it breaks out without
> > unregistering the device.
> >
> > dev->platform_device_sdr is assigned only after a driver is bound, so
> > rtl28xxu_tuner_detach() cannot unregister the unbound device later.
> > This leaves the registered platform device and its associated resources
> > allocated.
> >
> > Split the registration failure and driver binding checks. Unregister
> > the successfully registered platform device when no driver is bound
> > before leaving the switch.
> >
> > The issue was identified by a static analysis tool I developed and
> > confirmed by manual review.
> >
> > Fixes: a2f7f220df5e ("[media] rtl28xxu: switch SDR module to platform driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/media/usb/dvb-usb-v2/rtl28xxu.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/usb/dvb-usb-v2/rtl28xxu.c b/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
> > index 487c6ab784ab..3603d0cf638b 100644
> > --- a/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
> > +++ b/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
> > @@ -1391,8 +1391,12 @@ static int rtl2832u_tuner_attach(struct dvb_usb_adapter *adap)
> >                                                    "rtl2832_sdr",
> >                                                    PLATFORM_DEVID_AUTO,
> >                                                    &pdata, sizeof(pdata));
> > -             if (IS_ERR(pdev) || pdev->dev.driver == NULL)
> > +             if (IS_ERR(pdev))
> >                       break;
> > +             if (!pdev->dev.driver) {
> > +                     platform_device_unregister(pdev);
> > +                     break;
> > +             }
>
> Looking at other drivers, I think this is incomplete.
>
> drivers/media/usb/dvb-usb-v2/zd1301.c, line 142, does it correct. Note the
> try_module_get() call that is missing in rtl28xxu.c.
>
> Regards,
>
>         Hans
>
> >               dev->platform_device_sdr = pdev;
> >               break;
> >       default:
>

Thanks for pointing that out. I'll follow the zd1301.c pattern, add the
missing try_module_get()/module_put() pair, and include it in v2.

Thanks,
Guangshuo
