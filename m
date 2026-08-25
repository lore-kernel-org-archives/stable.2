Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AC7333730
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787627668; cv=pass; b=CsEx0FjG6hwllQMVimnnSpuD2EXi5aYMG72Su+pJhzUe4WMBwAcTkmgK+8v/XiHcg9crTsRsWRImA10X+skve/W/KTi0hPosk24ma9g4FzfCMGxxdww+TcIfHLDQbD37Y2gCa7SItwzagEXdK4JvAJ5/Hg20r4dUYkE0atbY/5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787627668; c=relaxed/simple;
	bh=dRs+t2C5DM0FBnIBiCSm+EGEkYKjoAyRCd6uSWWyGYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKqQgxwEwPdbwONZojiIJZjlPkVHxQyqXbKyVZF3EKmk/eUz8jUddLXQHIFa9yJcv6GuzMsrb/zEj1XoefGr7tg+BhjM631ofZWj58uTspUNpj0xAcbB1T50zKNk4WKMyN7tr0j1UP0WzycvYP3hYcORtJzYjv0beT0+4a1ZQgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNnlL7Ou; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNnlL7Ou"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d560775ca2so34507875ad.1
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 20:14:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787627666; cv=none;
        d=google.com; s=arc-20260327;
        b=bfVII/fWrqqsr4C9LaBBYF9I7qx7mBgpn263uFttIZknYexciTPdLSHYKilJPEKbOg
         JKibDePMz77fkL9rKAEY283wYi5JGIPlysy3XLYxbPJKgjUJFOdTcSWcHBMixnAQua46
         AQ+OsJhDBznOoO4xxnRIN2KEkPNF9iLUcXNiizziqDwS+YVi1JwVn4Mw+JgXuRwW76Uq
         15J46nDnbGOo1xREE769m116iGSKwW7gViJ/U01GeA/e+d++341HEZQ6407tncWiWYUt
         qRFJtAswgbu0r0H/lhDf8IZfElAvVM5l82JtRUM7fDWR+INcmx2fn5TkGZXCNNIf9voG
         XvcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pZxO2sG1DQdNWx9TFCDx4er2A5vWGIT8+jMZybDf1LU=;
        fh=Xvq6kKzbqVNz2pmgDm4l9BvbclEEh4kFbm0zBotOrmM=;
        b=NtfO+a13rxMQj7E8xQ4EEr3bkGe2vLKHt6+b8yvbtg1BU+iglYuM4078nVBv3tz0Ft
         7sTpi348Z9EuR80YxqL41wqy1BV2BjnbJY090clNFEaULF375l2rY6jKxFBjryzv6ViV
         WNxR+4eYSd1M1biuHsVu2YR6RQxm44WL1KKn1XsiWmKklyJWa7pVN6VrQZ0gqNyC9YZW
         +tkOF0hNcNXkrVQqirJgSpCAaORQsc6hnNO2fWfI1qDY2V8C0eBkXpFyz4MDhmtgBix9
         hsla6VcJ6oY9VlT/D8eRvxPz954HW9NTIk+XAgTKQZaxY7LCOtTFSRtEPmSlcWtdXYsH
         CVsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787627666; x=1788232466; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pZxO2sG1DQdNWx9TFCDx4er2A5vWGIT8+jMZybDf1LU=;
        b=KNnlL7Ouu1DiXnnwxJ+1HRr6sKhAbNyYkQXQEYPQ1Cpc4Apuz4cVc6X2mLXL3t+6fa
         fP/JyJSNZREY2T18afSkHf2DzOEMO/NrwhKcisH7b8PBLG6PkTHN8WQv9fMuN6mGNirg
         r3NuYEJqKKJevi2hNXMPOMqtGi5K0DrjEZvkMSe6CWoHXDxsKDkcGckYSaendrM/kBwI
         WO1B3SYJYIjCq31ckTgIv/uhFB6e/ISiediw4pfpj6E5VUsCUBBNOEEF2g7DmtiKr1w7
         ZWS4dRuPkhoOmMZGzzdZFc477epNOP0gs+wGE+9l4voQy8QA9aKTllFkABDrkIRhF2Zv
         1vSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787627666; x=1788232466;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pZxO2sG1DQdNWx9TFCDx4er2A5vWGIT8+jMZybDf1LU=;
        b=WO2aDKE7GoEFmQLOGfEeZ7jTV/iXJwIVhKoX+HmWou982ip5+sEIMv9dSn1iSv0Gt1
         PBkigrql0xdtZaWQSqS6ZgnPY82LZqwe7mrwaV+/DJDQGlq8YthAUe+bNpne+Om0dxTR
         Mvr4oAiB9pnIDAshu9AV2Pq43g0so90lswFYQMvoEAeZyuFtXLJy6fRbwb3llKPvCnjx
         T5RUe+uiEyV1i6T85VfXQGsyBP4wWg0kbcYH9jS2NtLWz/hQ9asMcd+Xm99uphGSkLW5
         DLzh/oP9yIWVVGumiDCrI3UoJeqVx5T1A08kwTCgmEV2x1ZQbG5urrcUf6h36ifxqeej
         5vxg==
X-Forwarded-Encrypted: i=1; AHgh+Rqv/IQyP/6GeJe1zdUnVRV8WOxCbukKuKPbU9aXTo8BtB1PVrPFSLrgWDR71144BZO6AE9/+ds=@vger.kernel.org
X-Gm-Message-State: AFuF++nJEaU8BFxzxRNFEGTuEp0vdQF7hKoWMOZebTAItLbV1w0RPXSw
	y7ND2XZXTzAguJIiVl1bEsUuDwbGhSAFb7FOCLWhomimxbR++FqiFuLhAm7aY98pkwpDs9WSC0r
	lzSC/GWvUA+Ud1RprHy5Ut3KY+a5M7Uo=
X-Gm-Gg: AR+sD10PSOvI7ZMFI1JkqqLftfBcxg0LJViTicJmVisq2fkF9L8Gq84tTjiJDXaT1cH
	GncymI2hfggw92YOTyhpDx/0RX9KQkulUucBtH/fOV7qNGLGcGRplXx1xv1hBzKlstVespKNT7a
	rjGo+b1/LsjwG5YSljvNB2XMHdZUND8f3KNVCAzJ/YhAxsdTtolMf6/Qr1QOavQPhQdVFx9ktAt
	loquP4bUJXdFS8JSTjpgIpL1MKD+Ivu/Dn7QavTITGFRwexwZYXKuja1NfdrWI7TzEehXWrRVA7
	h1pw6i23Zp7aBrGj+5lmIBJL3XT+P0sja5W7hyHB6lCX9qbKDc7y71owQPNh
X-Received: by 2002:a17:903:a90:b0:2c0:a555:80d6 with SMTP id
 d9443c01a7336-2d670b60ceemr444455745ad.2.1787627666097; Mon, 24 Aug 2026
 20:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820141034.1400439-1-xuziyougm@gmail.com> <20260824185043.2701718-1-kuba@kernel.org>
In-Reply-To: <20260824185043.2701718-1-kuba@kernel.org>
From: js node <xuziyougm@gmail.com>
Date: Tue, 25 Aug 2026 11:14:13 +0800
X-Gm-Features: AcwNN1VxbJzVE2V05L28ezCK6b_JXEDxc0VipP-5b32B7Wmg-aKUKM5V_yzkGqs
Message-ID: <CAF2gcSXK6H76A5Z6-k-D04VaCR4QXNiWLmbQmcCBpsW=L+Hwyw@mail.gmail.com>
Subject: Re: [PATCH net] net: phy: air_en8811h: restore LED GPIO output after
 MCU restart
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, ericwouds@gmail.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review.

I don't have AN8811HB hardware, so I can't confirm whether the MCU
restart clears AN8811HB_GPIO_OUTPUT in the same way.

Looking at the register layout, I agree it is very likely affected.
However, I'd prefer to keep this patch scoped to EN8811H where the
fix is verified, rather than extend it to AN8811HB based on
speculation.

If someone with AN8811HB hardware can confirm, a follow-up patch
adding the same restore to an8811hb_config_init() would make sense.


Jakub Kicinski <kuba@kernel.org> =E4=BA=8E2026=E5=B9=B48=E6=9C=8825=E6=97=
=A5=E5=91=A8=E4=BA=8C 02:50=E5=86=99=E9=81=93=EF=BC=9A
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> Verified. Report follows.
>
> commit 90353ad40d9c49a8f67a9cf009916549d394f63d
> Author: Ziyou Xu <xuziyougm@gmail.com>
>
> net: phy: air_en8811h: restore LED GPIO output after MCU restart
>
> The LED GPIO3/4/5 output-enable write is moved out of en8811h_probe() and
> into en8811h_config_init(), just before air_leds_init(), so the pads are
> re-enabled after every MD32 restart.
>
> > diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811=
h.c
> > index edd49c193e476..fbd87fc712bfb 100644
> > --- a/drivers/net/phy/air_en8811h.c
> > +++ b/drivers/net/phy/air_en8811h.c
>
> [ ... ]
>
> > @@ -1317,6 +1310,16 @@ static int en8811h_config_init(struct phy_device=
 *phydev)
> >       if (ret < 0)
> >               return ret;
> >
> > +     /*
> > +      * Restarting MD32 clears the GPIO3/4/5 output enable bits. Resto=
re
> > +      * them after every restart, before enabling the corresponding LE=
Ds.
> > +      */
> > +     ret =3D air_phy_buckpbus_reg_modify(phydev, EN8811H_GPIO_OUTPUT,
> > +                                       EN8811H_GPIO_OUTPUT_345,
> > +                                       EN8811H_GPIO_OUTPUT_345);
> > +     if (ret < 0)
> > +             return ret;
> > +
>
> [Severity: Medium]
> This isn't a bug introduced by this patch, but should the sibling AN8811H=
B
> path in the same file get the same treatment?
>
> AN8811HB_GPIO_OUTPUT_345 is written in exactly one place, an8811hb_probe(=
):
>
>         /* Configure led gpio pins as output */
>         ret =3D air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
>                                           AN8811HB_GPIO_OUTPUT_345,
>                                           AN8811HB_GPIO_OUTPUT_345);
>
> an8811hb_config_init() then restarts the MCU on every call after the firs=
t
> and goes straight to the LEDs without touching that register:
>
>         if (priv->mcu_needs_restart) {
>                 ret =3D en8811h_restart_mcu(phydev);
>                 ...
>         }
>         ret =3D an8811hb_config_serdes_polarity(phydev);
>         ...
>         ret =3D air_leds_init(phydev, EN8811H_LED_COUNT, AIR_PHY_LED_DUR,
>                             AIR_LED_MODE_USER_DEFINE);
>
> For AN8811HB, en8811h_restart_mcu() does a superset of the EN8811H
> sequence:
>
>         if (phy_id_compare_model(phydev->phy_id, AN8811HB_PHY_ID)) {
>                 ret =3D an8811hb_mcu_assert(phydev);
>                 ...
>                 ret =3D an8811hb_mcu_deassert(phydev);
>                 ...
>         }
>         ret =3D air_phy_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
>                                          EN8811H_FW_CTRL_1_START);
>
> If the premise stated in the new comment ("Restarting MD32 clears the
> GPIO3/4/5 output enable bits") holds for this device family, do the
> AN8811HB LEDs also go dark on the second and later .config_init() call
> (ifdown/ifup, or a repeated phy_init_hw())?
>
> After this patch the two peer paths in the file disagree: en8811h_config_=
init()
> restores the pad output-enable bits on every restart, while
> an8811hb_config_init() still assumes they survive it.
>
> Would it make sense to place the restore in the shared en8811h_restart_mc=
u()
> or air_leds_init() path so both models are covered, or duplicate it in
> an8811hb_config_init()? If AN8811HB is genuinely unaffected, could the co=
mmit
> message say why?
>
> Note this concern is based on the register definitions rather than measur=
ed
> hardware behaviour: AN8811HB_GPIO_OUTPUT is the same 0xcf8b8 offset withi=
n
> the AN8811HB PBUS window with an identical BIT(3) | BIT(4) | BIT(5) mask,=
 and
> commit 6b9c9def95cb ("net: phy: air_en8811h: Introduce resume/suspend and
> clk_restore_context...") notes that PHY reinitialisation reverts chip-con=
fig
> registers such as CKO to their initial values.
>
> >       ret =3D air_leds_init(phydev, EN8811H_LED_COUNT, AIR_PHY_LED_DUR,
> >                           AIR_LED_MODE_USER_DEFINE);
> >       if (ret < 0) {
> --
> pw-bot: cr
