Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793118889;
	b=DDbg88TCJq+LA20hBkkrxTeN30YT7XoeIcJ0tIBSJ6oPaG8mO8h6SY3YiVM3psWF1XQd
	 +vJMyGkDYe9hdtg+qJm25AuWZlaSxvtdLpkDlkiytFITiEZS6lfWQzym4Xq+2OcEC01Zx
	 i7rXOIGX6Vl04QCkkAvVN1bZY92j+mWctmlTMtC9qqRYB0kIkX+KkkbdJVYDhhOkTSTCq
	 bgykNmE4oJo9XElAunp3cDQD8EI7dWXzRl3Ja5znzvgyNWW+zNz8U//JL/XXxtYwWfnuG
	 QPFoJVl0P8ZCFI8T3BC7Zcb6cwfMg8wButfmj4YRSdfqbfLPnyN2mIEHBEGq9kBlsBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=JTCbAAzicyeiiqXynNzoLkl9gYn7zDPQJlAnzkNb7CY=;
	b=Ho7qPyVtj92XFzfOHt3hD7i5pPHw8qmB0j2CUJFVzfwchomtmLnqzfpkQeMBxTo1jNnN
	 KFQPEv4gyNWO5tHbLe7htDn391LdKLytYD8MDbdrjnqe1klJ9BTY56WyZ8KLoADGC+ESL
	 n7iH24dFkNbKUAdUYAw0XTgawC8RlBXnHvHADwlBXawW7VyVEDV4MwwomGAKv2Hbeltnh
	 w8cRYUmZbTRYEj56oZi+U4zmBY+Pp9yYrtQdtomEp3HI0vHtkQWs/QdGrtZaKYPSvOMTO
	 +XSw+/hSjYXBjlZeiSaYJC5QHYa+qe//GlVn1tnSCDCPdgEBBZDHKA5TZsm4D8WPGOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CGWSWKEN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A78606A31B
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 16:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14A78606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CGWSWKEN
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-676858d42f8so37513d50.2
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:34:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793118888; cv=none;
        d=google.com; s=arc-20260327;
        b=DStuVUGkHr2c1TiFVWgJFVjBJ6Rev6/wxU1wZG8vjwhSjqwozFKBgUoR9YfatZhrgy
         FRMC3FOg3VuqClbmZT4AIeGNRAws4rT6ssmjN00UoVkJ0hIU3sNt+m/nB3xLsMP/U2kP
         UyzcWIFr/yNw049BxfYlS27hmRwDfI51h/Sjj4pmP5+Rddm3PcyGmTfB1ZzRXNpQ5CFL
         R1NbxzLQwO2iscmKwTz5emRLA1B8QBiAap/4ShVlQzXethnW48aWHhemdyJQYPTPisxq
         YNe7EjKXI3S3PX5c4ceZJCLrQLKCgJ9TrinEK9BIbcrL7zzNE33pkHV1opJbqrCijM7F
         czEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JTCbAAzicyeiiqXynNzoLkl9gYn7zDPQJlAnzkNb7CY=;
        fh=Tmg/Rx8kTJ4v7/NoJFcOfdPWhvcoObSy2Q34ar7rHbc=;
        b=Ka1+OR5o41HaYPtGd7LMa35iplRVksF7qBF6lISWDnQPE5G24wIXA3Jf5E5/wChX8L
         97cxF6nuF/VTUeo1vT0ZagJHEVQIZ7sR0rvFx+6DYyn6/2+w+6BT8k5vRmVenFR2qy5p
         avXHf4v1kl7zR/q+137jTcTG+aiORBusYS70FQZwDX7iMYCRorvXSh9wIrlYfPdglg/B
         uJtmMDZWr4ezz1TEp+qg2lMEzDMYCZ9Tsc48J531an6Nh2oC/FkuQM/8LHG24S8Fs/VU
         RG+Eq/o8qNbw9kW2kwx6L2Z+MfnaKdarSAEqXy4ytaYUU/PqomkBknwVtmm9nwHIzqdW
         QwIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793118888; x=1793723688; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JTCbAAzicyeiiqXynNzoLkl9gYn7zDPQJlAnzkNb7CY=;
        b=CGWSWKENimpMCXj8PDWsi2VeR3x+WvLY96EsRCDrD1xbCGl67GkJJeb1A1OCZQ2ue+
         68PE7NUVO+oWpwFm0S15j6LMfcS3zXFzRMQqaqHka2ZLMTNlbaTFgZD1TVZ4K4YlMgQo
         vjBE6CEKxxtFeUSWPvC7IthVqLvsdorqZpNovx3sfR82GG05UUJNcf6emNxFQioKKe5J
         aQZjYUSiXClFvjcVtiI6ti9ztMDxpMN2mDYWmoc+2ne9CPGptT8vMlqy3mUPWtE8OTde
         VWf6En89Wdfftxm1CdFpbnlgNPk1QSTMWXcAB3Cs69AVfOOQqaiI0AYEcLeb3hc12mEB
         iSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793118888; x=1793723688;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JTCbAAzicyeiiqXynNzoLkl9gYn7zDPQJlAnzkNb7CY=;
        b=ZAQgM+93NpEIblnDxl8Jlg0Ect4jlSLxigcmWNVGZIV1UC/j6otlO5TFs5/F4iBfis
         WKptvLlqEdUUuBFEK1ce/3MshBG2WAPddxtTL1ll+20JtiiE+xj/efk05Uai1XvLSS0U
         gOcytzk4CX6Tp4Uh61fq6AIcZs/ykrkV4Tgg4L9bhoXhLSLW5+Ax/0aboZ9KX3pPUKF9
         rkDgtcozPEMT874s1cRupEbvFDP1+j9BTwGwMmF7gHcJhzqCJ2YBqJWgNxUUd18ApRBr
         ak70FprW8NsIseKEGQSAYFdLSKK+3EQPfS7cRHn9sXc0k3fIa7oElMsdc0sF1yNZCT6v
         d2Gw==
X-Forwarded-Encrypted: i=1; AKwUvBzXS5RFIrHmUrcoCpv7eanCe8Ph1D6GAU96hQWDVHA3momFjhhHTXf58v+93FyCmEZhDIRo2Oo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLLQrG/mzEKClErbEtOCxOzwhUN79vvzZZMmnP6oaXCeTSUPpM2
	+rgl3ncgq+L7w8K4RPqqXIMsBUE0XtyzH7DyMPItaAsL0UmzIzkoVd7rtg6oLA2jkzIfkhL5FMO
	yhMuI+Oy4s/Kl7/6xv+tnO5N2QcLyGiE=
X-Gm-Gg: AYBFou3nY8WmerQX2XnG9smQ0Ys4MxsezNQIQGif8Dm7rOioAs7kyxPB7/tnZ+w1DIs
	9ZRvrgGkn2HCn3SKFMEaRxV1BWjTv0w212YZLFLgkYcayWA/amKbWAPi76q/xSen7pyEwU3wYhB
	XvsraBIQBZn3bbtaa/fmLxihTLKTR5wuKoUUozK0ItYtgKgGcRaEEdcc2vMmjyfxLpbqRu6JWe2
	BWmROR9WpDzyNUzQLjUbIXKPJO5H/ak//qMts24zwzx3s0E41SO6I58mmMIWN2woO+xADO6L4zc
	Sv79xhzlfpC92dq8qOEO7S0vCBMsr+v/soR1LZaw+wNxfy4VPA/guSv7cbcOuLXLGw6P9+xnyd5
	vHW5+DM0N06BsZfwJY9lJkr/2g3wYs+kC9eTU
X-Received: by 2002:a53:d707:0:b0:677:cb43:4b3a with SMTP id
 956f58d0204a3-67a7bd688afmr23659d50.156.1793118888025; Tue, 27 Oct 2026
 09:34:48 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027024609.117371-1-lgs201920130244@gmail.com> <20261027162457.GJ2195460@google.com>
In-Reply-To: <20261027162457.GJ2195460@google.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 28 Oct 2026 00:34:37 +0800
X-Gm-Features: AclHuK9F4Xh0ot3RGPhOyFM6lJKMyY_HosbzQTq8lFgxlR4gfFrqEYjNzCwXBj8
Message-ID: <CANUHTR-3nyHpBgEBA0wyPwMejK0WM-4yveENGZwV8wvkJbBwCg@mail.gmail.com>
Subject: Re: [PATCH] mfd: hi655x-pmic: fix IRQ action memory leak on removal
To: Lee Jones <lee@kernel.org>
Cc: John Stultz <john.stultz@linaro.org>, mfd@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Lee,

Thank you for your suggestion.

On Wed, 28 Oct 2026 at 00:25, Lee Jones <lee@kernel.org> wrote:
>
> On Tue, 27 Oct 2026, Guangshuo Li wrote:
>
> > hi655x_pmic_remove() currently removes the regmap IRQ chip before
> > removing the MFD child devices. regmap_del_irq_chip() disposes the
> > child IRQ mappings and removes their IRQ descriptors.
> >
> > The hi65xx-powerkey child registers interrupt handlers using
> > devm_request_any_context_irq(). During child device removal, the
> > device-managed cleanup calls free_irq(), but the corresponding IRQ
> > descriptors are no longer available. As a result, the allocated
> > struct irqaction objects referenced by irq_desc->action are not
> > freed, causing a memory leak.
> >
> > Remove the MFD child devices first, allowing their device-managed
> > IRQ handlers to be released while the IRQ mappings are still valid.
> > Then remove the regmap IRQ chip and its IRQ domain.
> >
> > This issue was found by our static analysis tool under development.
> >
> > Fixes: eb10245fb37e ("mfd: hi655x-pmic: Add powerkey device to hi655x PMIC driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/mfd/hi655x-pmic.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mfd/hi655x-pmic.c b/drivers/mfd/hi655x-pmic.c
> > index 5cb392892c19..3a7ccc9d30b7 100644
> > --- a/drivers/mfd/hi655x-pmic.c
> > +++ b/drivers/mfd/hi655x-pmic.c
> > @@ -147,8 +147,8 @@ static void hi655x_pmic_remove(struct platform_device *pdev)
> >  {
> >       struct hi655x_pmic *pmic = platform_get_drvdata(pdev);
> >
> > -     regmap_del_irq_chip(gpiod_to_irq(pmic->gpio), pmic->irq_data);
> >       mfd_remove_devices(&pdev->dev);
> > +     regmap_del_irq_chip(gpiod_to_irq(pmic->gpio), pmic->irq_data);
>
> What about devm_regmap_add_irq_chip() and devm_mfd_*()?
>
> >  }
> >
> >  static const struct of_device_id hi655x_pmic_match[] = {
> > --
> > 2.43.0
> >
>
> --
> Lee Jones

I agree that using devm_regmap_add_irq_chip() and
devm_mfd_add_devices() would be a cleaner and more appropriate
approach, as it would allow the resource cleanup order to be managed
automatically.

I'll look into this approach and update the patch accordingly.

Thanks again for your guidance.

Best regards,
Guangshuo Li
