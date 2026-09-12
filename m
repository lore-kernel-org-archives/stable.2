Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76536345EC1
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 14:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789222540; cv=pass; b=lTRCz5qJj1J0FOgoUm3kr4eqw93FcV4IybOJHzEp0TtMfPtO4PZg6CcxMrsodV3+P7JFpfrvAlzhHPYS+zkXnHbPxFbBSFNaO/X5c/u/PO7g36maP2BxNCKdW7qF3PoS6/t5Y9S2K0/AE1fs/2BJQ7NMq/D+1Lbq5mvfs6BV1Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789222540; c=relaxed/simple;
	bh=00BvdqvQ1V2d4tLgEbdL0drIAzCxvXbo6pv8pulp278=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2O59BLLjypF/tDqK3kHSOBHpWh9VyKQgWr2UHCVZZIC3ClDcN3JpKobcpASKogUc14hu8LRhlTDEY8xQGY7f/CJUfrK37jUktlMcz7gWGA2WSKuaUTosOMksy/yvAjB53ztKlU8NU1t0xEi/1YWHVk3GVbGB+h5VylD6b0JCbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q972KAbX; arc=pass smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q972KAbX"
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-78565b4db79so294502137.3
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 07:15:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789222534; cv=none;
        d=google.com; s=arc-20260327;
        b=AkPY+oNpM0UW3CqaHfs8AKW22DP5DiQy7y08lumdhK2YTyK50aZg5VX6EO5y0B9DQ4
         A7VlhKYt2e/uNTOIHBTYhf4OU8Zv/FcNp5ab++2i6/UQGTBF/uFjUvHUH5AHaCT31UbK
         hN2W+yUbuVS3TFhNcaC33KO9I1gEZnx4bHpmGuDs/vvybeKwRXbAuXZyeAQ3AwB5KDg5
         kW/+t5bJh+7D95PdfinDytuNq2hvUmbU1qAwkXet+ORjhSx0+hvTZL1kCK9aFXi5X6tt
         KOLV7VQ3Tm2evumGpBJgw/wxz48fafngUYKZUCXKxzNqptJM5sNd3gqXOrd0h3nLIpql
         9PUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z5ufyWucvww0cPxhLp4Y4P0qQXejm9pZojzLX9IgS9I=;
        fh=k7UVcr3D1vwhYS8CWV5gCulhXbs76MzamACidqxmolg=;
        b=jZeI7Nxh7PoEIT8cvuYySg82JF0phrffvzXuVUjctOJL5OihgMoPArJdIACdfPPnTu
         +LWlqnl3hrrpWSfkRO6EnQQVQDH4Qj11eLvjFXZ2lcveW7p5d0MFXl+ElXARfK3F/fRJ
         0W8hHaRGgant4BW5zuTCpBK7RP+2DqMW+yItaddE5o2fhCorgOCm203a7Z37uNmN58JS
         3AsBZCL/uMRpBhqN7Yg4cpuVhzzCFUBJJga8yetSTMqFm/SB6wkfK6P2H+ATHDsIu9s6
         7PJGtQVWaYPUQOlIQ58Ag+WW7//n0eNrn3BBqKrL2Jrkt6bggjxf4le1SselWbHavqqf
         X+uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789222534; x=1789827334; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z5ufyWucvww0cPxhLp4Y4P0qQXejm9pZojzLX9IgS9I=;
        b=q972KAbXqY97tjHs4u72UQyJcFgOKeq0yip7mDRwPJUnYqiHhrHq79q6oFJe4rEiAA
         r+QTnBPsJRdbbwIXIeNd+AAPx2NStlHFQsRXYZjGWq8elpvPusL4eGLQrJnpHSKU8uXU
         vY/9AviOxkphYlqazt3PJOKtVoMzBA9W0iRlqezR3m1ngqAsQyaVsAyu4ZHoo9cZTtO9
         Un+oEJ911FQ12cCe1o15puoexd7qprPcf1Lo13rn7oH0dBfMsP3YkIXLjqR/TlxzshjB
         K9KywcwEb0jM+NCbd3PI2igVW8WBuWyAQ1173jLg3287YzT1E31Ah91nelqGMRN6vkgO
         zw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789222534; x=1789827334;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z5ufyWucvww0cPxhLp4Y4P0qQXejm9pZojzLX9IgS9I=;
        b=qsA2f3mJBdfbWM+ICRlPNonqtI3DIA5fuQZ5ngR+17Qe9RdNj6MkCCjeZEPp0u1pCT
         TKBz4qvaF1iEMyaA9N0wMUzv1WXDgIZauxSYj+DLOVKcMrnX5VNBPgcIPgrcDZjlH9rN
         BJJSrGlBy7n8Yg39vlryrIrlruJTtFJSWHDfjt1yVinU4zr4O1OfccKWrDdtiJ+c+rqK
         GrMjtAl5m7iYuAO22NH6Jlc9fhVWBQwOLbT1NW2KIaHKk6v8PLGYeYAJr97Dk1QgT55o
         j7Ny+sHA+XaC+d9HElMIVAEXj39RafCVdkeOUatE6FMgSvqN787V689FpxDNrEXn/VsB
         ddew==
X-Forwarded-Encrypted: i=1; AKwUvByZDjJXjZ+8k6LlB/9+flN9H8mgArSqyDj1xvvlmCTsyxEJt0KtpkQ4tm6O1ml4R7UNZiAf/WU=@vger.kernel.org
X-Gm-Message-State: AFuF++lc5voPMySjjQucenbRoC0fivGnnlIPll9rVXYrO8GtiX7Sd7BG
	R4WPvp2GDsWNQ3ZLoHUhMly6U9jFjOQwZ5KpJTxv9l0eIq4BTxeod6E9uDNfD2OTSqcxpE4jquF
	3rfV97BM9P/WM9XMpVBtHHP4PRQmWCWs=
X-Gm-Gg: AYBFou3cG9QmQly4wp5wCdSQRmHsVYSnX9MtyP81fRyuUWz4fhF9VSew/AjH3exfvMx
	DtxB50IEJZYaeJWkWUM3NluAnz8bGaWfPAO3lmSViMzyvy5HsYQV0xBMrIUpOfrR6Xn4A56MpA5
	JaK2dLyHhLjtIY2fxjwqRbzGSROKDMxUt4tver+ZPFzm67ikIdCVMwfpbLBBaSI5hmOGs37L3kH
	NO3pEZPgLwBOEUQG04NTYqdoFUOaSKBAbDkt6fm6lM8tPbAPuCsq2aDaK2rXhOAEFfsNfYBBSHH
	Y5BZepaEqmNSQB2zncvQn7LvNuKakgw9e4/wl04ebCcQ3q9kagWa7PjQ4DQgKTImskFI2KmFrqc
	SnRYga+1cJdb0S1z3hCqYEcaOX8S3kMjB0oazj2e/fYo=
X-Received: by 2002:a05:6102:6a92:b0:77c:6bdc:824f with SMTP id
 ada2fe7eead31-795a6c82b95mr2453657137.1.1789222534389; Sat, 12 Sep 2026
 07:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911211559.207990-1-ehbello@gmail.com> <577c2a79-25f9-409d-be46-275821e3a2f7@rock-chips.com>
In-Reply-To: <577c2a79-25f9-409d-be46-275821e3a2f7@rock-chips.com>
From: =?UTF-8?Q?Enrique_Hern=C3=A1ndez_Bello?= <ehbello@gmail.com>
Date: Sat, 12 Sep 2026 15:14:56 +0100
X-Gm-Features: AcwNN1VzAakD72HPxt6ZZOZcKA7ZrU2_muAgwy6Cvd7dGeC7JC5VEdDo9kbd0hk
Message-ID: <CAN10OtB0VVeb_OPUzPPF3Q5oAsoK+5jsxRXp7byShJ+qDnKz+A@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: rockchip: Skip the Tpvperl wait when power is
 already valid
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: robh@kernel.org, heiko@sntech.de, dlemoal@kernel.org, 
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	bhelgaas@google.com, mani@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 12 Sept 2026 at 02:21, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> =E5=9C=A8 2026/09/12 =E6=98=9F=E6=9C=9F=E5=85=AD 5:15, Enrique Hern=C3=A1=
ndez Bello =E5=86=99=E9=81=93:
> > Since commit c47f90be4c89 ("PCI: rockchip-host: Fix
> > rockchip_pcie_host_init_port() PERST# handling"), a JMicron JMB585
> > behind an rk3399 root port almost never becomes usable: the link trains
> > normally, but the endpoint's configuration space never answers, so the
> > device is not enumerated. On this controller a configuration read that
> > gets no usable completion is reported as an external abort rather than
> > as an all-ones response, which on arm64 brings the machine down.
> >
> > The change added an unconditional 100 ms sleep so that PERST# stays
> > asserted for at least Tpvperl after power becomes valid. The wait is
> > performed while PERST# is asserted, so it also extends the reset by
> > 100 ms, and this endpoint does not tolerate the longer assertion.
> >
> > Tpvperl is counted from the supplies becoming valid (PCIe CEM r5.1,
> > sec 2.9.2). On boards whose PCIe supplies are always-on -- vcc3v3_pcie
> > on ROCK Pi 4 is regulator-always-on and regulator-boot-on -- power has
> > been valid since boot, seconds before the driver probes, so the
> > requirement is already met and the sleep only lengthens the reset.
> >
> > Record whether the supplies were already enabled before the driver
> > enabled them, and skip the wait in that case. A supply that is already
> > on at probe was brought up either by the bootloader or by the regulator
> > core at boot, both of which precede a PCIe probe by far more than
> > Tpvperl. When the driver really does bring the rails up the full wait
> > still happens, as it does if regulator_is_enabled() cannot tell.
> >
> > The same check is repeated on resume rather than assuming that power
> > was cycled: suspend calls regulator_disable() on the 0.9V supply, which
> > only drops a reference, so on a board where that rail is always-on or
> > shared with another consumer the power stays valid across the cycle.
> >
> > Skipping the wait only when every supply is already on is strictly more
> > conservative than what this driver did for years: until the change cite=
d
> > above there was no Tpvperl wait at all, and PERST# stayed asserted only
> > for as long as the register writes in between took.
> >
> > Measured on a ROCK Pi 4C with a Radxa Penta SATA HAT (JMB585) by
> > booting repeatedly and counting how often the endpoint enumerated:
> >
> >    unmodified ....................................  0 out of 84 boots
> >    with this patch ...............................  3 out of 3 boots
> >    other ways of dropping the same wait ..........  16 out of 16 boots
> >
> > Fisher's exact test, pooling the last two rows against the first, gives
> > p =3D 4.1e-21. With the patch the endpoint enumerated on every boot and=
 all
> > four disks behind it came up.
> >
> > Each of the three PERST#-related changes that landed together in
> > v6.11-rc1 was also reverted individually; only removing this wait made
> > any difference. Moving the wait to before link training is enabled,
> > rather than removing it, did not help (0 out of 15 boots), which is
> > what identified the length of the PERST# assertion rather than any
> > interaction with link training as the cause.
> >
> > The measurements were taken on 6.18, but the code in question is
> > unchanged between v6.11 and v7.2.
> >
> > Fixes: c47f90be4c89 ("PCI: rockchip-host: Fix rockchip_pcie_host_init_p=
ort() PERST# handling")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Enrique Hern=C3=A1ndez Bello <ehbello@gmail.com>
> > ---
> > ---
> > v2:
> >   - Re-evaluate the supplies in rockchip_pcie_resume_noirq() instead of
> >     assuming that the 0.9V rail was really turned off. On a board where
> >     that rail is always-on or shared, regulator_disable() leaves it on,
> >     and forcing the wait there would reintroduce on resume exactly the
> >     failure this patch fixes. Spotted by an automated review of v1.
> >   - Factor the test into rockchip_pcie_supplies_enabled() now that it
> >     has two callers.
> >
> > v1: https://lore.kernel.org/all/20260911104952.4190994-1-ehbello@gmail.=
com/
> >
> > --- a/drivers/pci/controller/pcie-rockchip.h
> > +++ b/drivers/pci/controller/pcie-rockchip.h
> > @@ -318,6 +318,7 @@
> >       struct  regulator *vpcie1v8; /* 1.8V power supply */
> >       struct  regulator *vpcie0v9; /* 0.9V power supply */
> >       struct  gpio_desc *perst_gpio;
> > +     bool    supplies_pre_enabled;
> >       u32     lanes;
> >       u8      lanes_map;
> >       int     link_gen;
> > --- a/drivers/pci/controller/pcie-rockchip-host.c
> > +++ b/drivers/pci/controller/pcie-rockchip-host.c
> > @@ -314,7 +314,9 @@
> >       rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
> >                           PCIE_CLIENT_CONFIG);
> >
> > -     msleep(PCIE_T_PVPERL_MS);
> > +     if (!rockchip->supplies_pre_enabled)
> > +             msleep(PCIE_T_PVPERL_MS);
> > +
> >       gpiod_set_value_cansleep(rockchip->perst_gpio, 1);
> >
> >       msleep(PCIE_RESET_CONFIG_WAIT_MS);
> > @@ -609,11 +611,33 @@
> >       return 0;
> >   }
> >
> > +/*
> > + * Tpvperl is counted from the supplies becoming valid, and the driver=
 waits
> > + * for it with PERST# asserted, so the wait also lengthens the reset p=
ulse.
> > + * Supplies that are already enabled before this driver enables them w=
ere
> > + * brought up by the bootloader or by the regulator core at boot, both=
 of
> > + * which precede this point by far more than Tpvperl, so the requireme=
nt is
> > + * already met. Treat an error from regulator_is_enabled() as "not kno=
wn to
> > + * be on" so that the caller waits.
> > + */
> > +static bool rockchip_pcie_supplies_enabled(struct rockchip_pcie *rockc=
hip)
> > +{
> > +     return (IS_ERR(rockchip->vpcie12v) ||
> > +             regulator_is_enabled(rockchip->vpcie12v) > 0) &&
> > +            (IS_ERR(rockchip->vpcie3v3) ||
> > +             regulator_is_enabled(rockchip->vpcie3v3) > 0) &&
> > +            regulator_is_enabled(rockchip->vpcie1v8) > 0 &&
> > +            regulator_is_enabled(rockchip->vpcie0v9) > 0;
> > +}
> > +
> >   static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
> >   {
> >       struct device *dev =3D rockchip->dev;
> >       int err;
> >
> > +     rockchip->supplies_pre_enabled =3D
> > +             rockchip_pcie_supplies_enabled(rockchip);
> > +
>
> If it's pre-enabled, should we still need to enable this regulator just
> for adding a refcount for it?
>

Yes, I think the regulator_enable() calls have to stay, and the patch
deliberately leaves them untouched: the new flag only records what the
Tpvperl requirement already is, it does not take over the supply's
lifetime management.

Two reasons.

1) Without a reference the regulator core can switch the rail off
   underneath us. regulator_late_cleanup() disables, at late_initcall,
   every regulator that is not always_on, whose status it is allowed to
   change, and whose use_count is zero:

        if (c && c->always_on)
                return 0;
        if (!regulator_ops_is_valid(rdev, REGULATOR_CHANGE_STATUS))
                return 0;
        regulator_lock(rdev);
        if (rdev->use_count)
                goto unlock;
        /* If reading the status failed, assume that it's off. */
        if (_regulator_is_enabled(rdev) <=3D 0)
                goto unlock;
        if (have_full_constraints()) {
                rdev_info(rdev, "disabling\n");
                ret =3D _regulator_do_disable(rdev);

   have_full_constraints() is true for any populated device tree, so
   this is the normal path here. A supply that the bootloader merely
   left on -- as opposed to one marked regulator-always-on, which is
   what ROCK Pi 4 happens to use -- would be turned off shortly after
   probe if this driver had not taken a reference on it.

2) The disables would become unbalanced. rockchip_pcie_suspend_noirq()
   and the probe error paths call regulator_disable(), and with no
   matching enable _regulator_disable() trips

        WARN(regulator->enable_count =3D=3D 0,
             "unbalanced disables for %s\n", rdev_get_name(rdev))

   and returns -EIO.

So the enables are about owning the supply, which is orthogonal to how
long PERST# is held. Keeping them is also what makes the change minimal:
the only behavioural difference is whether a 100 ms sleep happens inside
the PERST# assertion.

If you think it would help the next reader, I am happy to send a v3 that
notes in the comment that the enables are kept for the reference count
and are independent of the Tpvperl question.

Thanks for taking a look.

> >       if (!IS_ERR(rockchip->vpcie12v)) {
> >               err =3D regulator_enable(rockchip->vpcie12v);
> >               if (err) {
> > @@ -890,6 +914,13 @@
> >       struct rockchip_pcie *rockchip =3D dev_get_drvdata(dev);
> >       int err;
> >
> > +     /*
> > +      * Suspend calls regulator_disable() on the 0.9V supply, but on b=
oards
> > +      * where it is always-on or shared the rail does not actually dro=
p, so
> > +      * re-evaluate instead of assuming that power was cycled.
> > +      */
> > +     rockchip->supplies_pre_enabled =3D rockchip_pcie_supplies_enabled=
(rockchip);
> > +
> >       err =3D regulator_enable(rockchip->vpcie0v9);
> >       if (err) {
> >               dev_err(dev, "fail to enable vpcie0v9 regulator\n");
> >
> >
>
