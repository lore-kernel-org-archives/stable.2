Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B75B36213E
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784448613; cv=pass; b=ZzejnZ07pEykVnS/XsCE6rnsrWM60rerOFMzFu4fcXxbOv4g8zs7pBLFKBZWRK4oHagQ+jnV9G/wf+PURyKfNo8WKZLEMPglKFYx/liFt92E4TbJyzNNbJzSom5WX80uMwyR143gtItKPRaXtRMr/PIr8oK/IGvr10ea1Z5GRnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784448613; c=relaxed/simple;
	bh=NQlVyKKuCMEWDczCmuWWArwUKeVWKFmwao9aHBZhoPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uGnpeWv7O71cQcQ7JEO9+7OuBBOwu11O9QxxBBdALFECrJ/OuTdQ72dLhw/PbYRKwsnW95lt9KerdlJnlEN/CO8HWBnF6GThZvnkkzXGI8anV1BhkCjA30+dYLrTHvcgg8rjkWuIVwpCUcbsIVrdHoZ3bitunysGrr2vpjSbXc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asr3+b4u; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asr3+b4u"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39ca300db70so67420451fa.2
        for <stable@vger.kernel.org>; Sun, 19 Jul 2026 01:10:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784448610; cv=none;
        d=google.com; s=arc-20260327;
        b=hH4oxPzoVPc/E6KPSESD4LnShZ2ttR/Ftw/XnSWaHStTJJdimXEa7KaFVb39HQLIyD
         5xGmjj+xZ6+ZxVqQawHXIvNtiNvFctsD9QR33FAhm1yQUph57qZHYySXL+c20J5DGOG+
         61bZq4rdUGRbHmAyNd4Axg8jfbp78zGzlR2jBpO+JMQu0gGlAmxxwEMkR7AyRMrEUeOg
         AmG3WHnnkKyG0WUkZ0hZ7OKJDKp43luGnBUodxQzYr+kPLbQsOJaK8E/NDXup5eLKMWO
         Z9NJayRD+qXQgkwXkgXT9a7ev0yebiM0Vnlfxrn4nFTNi0/EMIN7Lbv3DNv141jYXUWS
         0mxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2yGqeoNEIqEFNeHuvCDFYuyM7eD27XEYEaaaCDQIKCE=;
        fh=Nd6zoBo+tUl2ViQPImxTgR/6Tku79GE07hhCscnOcpw=;
        b=LLHiHU64bj9WpXctVtxv/tFPK9cNm38wemG4eHRnHMKfzRBDKyDkaZDzR5YKpN2a1a
         dsM8cKmwRjUbjEqtejda0QZuuzvSXqr7qIfwFBbLCTpQQ0dURkKppR8wXdPmO3V0ndd1
         NhT2X57rFz1Mg4rdO0V6uOrCQ9jwSu7vlVQ8bAJoHRcK+cD/1yLNbnAZSYfrxyL7NvhH
         jKDpcDxnUs6ouulFv3Rw+dgmWSVmRamHqlgLo7dWKwVRo1bNnGog0dPy40wAFLm/LmCX
         eCsmY47Y8A+uWLiAe4UnQoO6aR7PXooNXbkxyUn0P5fVSl6hRnorUVh2fC2rFpSaDNsA
         nCEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784448610; x=1785053410; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2yGqeoNEIqEFNeHuvCDFYuyM7eD27XEYEaaaCDQIKCE=;
        b=asr3+b4uy2J6nodEgmh1jHFVySp5vfKXTVGaQqWM39klUdWSznaxvCvObNl/rek0MS
         HnmH+0PCgOvbxQVDJGVxIaYcQGHwKPIf/8o0TefBbSgWclEMRBZFqayCB3PnBaITWEhI
         sT2oyRFil9jtWHDAKK7P6Hu/3qkp1dYLh7Hatc1PPMrfn4VodI5Bs6kvS991GIQX9T9X
         Nc9cNEPZiTEmoBN3VlEVBNOFJzBbl4kbgiBJetZjP8gDyaF7zn4i/UhyxHdf6sTz3HE/
         QjLQvuCeCdeVGikmu+HuQeXGHVOM2JpKPcB7XVPPMK1Sl2X5sJMr84UP/SPVRukEfMgT
         fLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784448610; x=1785053410;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2yGqeoNEIqEFNeHuvCDFYuyM7eD27XEYEaaaCDQIKCE=;
        b=nGD6cWeSuY06kKHvUP/O6QxSnEY02rNXrEHN+lobq5sTKvbocokFrYsrl951reVwov
         +HYhzuBA6Jef74lFM4h8BtrsTzQDjKOdUsHYTdd+V03MyvDuXS37RInqaSqCHJ/4HNVT
         dBqJ33+q49rLLudv8aEvkmske67u2wwlysEDfTyqCh2GInOMm5KLuhW/3PfXfDqxK+bY
         w4UJLkDJoqcZ+Y8A7/LaJLGl6y+5MOvvR5PpHfWNmjunnKlKMdbBQZDLqusN7Oepx1Bg
         KF+5VPSPjp8v/TDkKUawzTSlUL5ypEVmkQfCp6AyyDotutapM0PkeyFZOxezbio1hEIz
         QFDQ==
X-Forwarded-Encrypted: i=1; AHgh+RpFtoPJL9wlLl7KHqAZ8K95IsIpL/OqaRpGkdjTyGgmbHUVNZP/jQsGfHwqr0b+4WcHPK7J1dA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbpOyTDLJ6pAbsNDgMGJQjMw7SPbNYSVsWeVr3Y/BBgsMquOLR
	GOc99CRglFwxPNCZqFLOwo1iSo+XICNnGFwChVvhUXb1BzF11AJm8033pW3vcD4AXo9plM9YLOA
	NvAg5yvZX0ykjLV1ZWUywBFIalqK1Z1Y=
X-Gm-Gg: AfdE7clD9a9CDNqSEL9d0RoosEG0mCQlYnVhcQ/x+JfJFViG8Wp0I9PSEsptrlfrykm
	Cue5jb9R7e7CwXqeTHZgyPza2Q860sULLBlMoEYNTpcP9h8YMueKo0sGSB0rlBMO/WjttOarJAL
	nKzOcVn99dVyGVHPj5uXKR9givyzlodHgQQaj+bIXsFZQdTBVN8zwUIvAEG+HFDLbCM6GnPBoVG
	bdYF1CJLuaQAXiHDApbRFZWCb/c4jdHpcBqegmpiLJvuWRz+dtQ9wEz0Ak6kDBd7Jc3zJ2tp2nV
	Lio8Uyb3q48KyUmp/68mBJ4EaLQAi4Zh9fps1AKpGrWE00etZgEmk7HA6LVMiUjGnTeie2tXxQz
	baq71EgIJBlZhU1kiAHD28w4rHz5N7bvUshBWME8faCoqoEU=
X-Received: by 2002:a05:651c:2215:b0:39a:fbc9:6851 with SMTP id
 38308e7fff4ca-39eb28bca2dmr18006481fa.38.1784448609915; Sun, 19 Jul 2026
 01:10:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718213738.2470294-1-bennib@mailbox.org>
In-Reply-To: <20260718213738.2470294-1-bennib@mailbox.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 19 Jul 2026 11:09:33 +0300
X-Gm-Features: AUfX_mxDd9uSfBrZMvhN0l_7Iq0ehwVReLq3x1hrVL1Jr61JXW6i21RsnFL2LCE
Message-ID: <CAHp75VeC4frN1TenWQY2Uh+z4qjaMjsLj8FeC9SgqWduQeZ3MQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: microchip-sgpio: add missing select REGMAP_MMIO
To: Benjamin Boortz <bennib@mailbox.org>
Cc: linusw@kernel.org, lee@kernel.org, vladimir.oltean@nxp.com, 
	colin.foster@in-advantage.com, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 19, 2026 at 12:38=E2=80=AFAM Benjamin Boortz <bennib@mailbox.or=
g> wrote:
>
> The driver calls ocelot_regmap_from_resource() via <linux/mfd/ocelot.h>,
> which internally uses devm_regmap_init_mmio() and requires REGMAP_MMIO.
> The Kconfig entry does not select REGMAP_MMIO, causing a build failure
> when no other driver in the config happens to pull in REGMAP_MMIO:

>   include/linux/mfd/ocelot.h:19:51: warning: 'struct regmap_config'
>     declared inside parameter list will not be visible outside of this
>     definition or declaration
>   include/linux/mfd/ocelot.h:34:24: error: implicit declaration of
>     function 'devm_regmap_init_mmio'
>   drivers/pinctrl/pinctrl-microchip-sgpio.c:910:16: error: variable
>     'regmap_config' has initializer but incomplete type
>   drivers/pinctrl/pinctrl-microchip-sgpio.c:911:18: error: 'struct
>     regmap_config' has no member named 'reg_bits'

Reduce this to one most significant line.

  include/linux/mfd/ocelot.h:34:24: error: implicit declaration of
function 'devm_regmap_init_mmio'

And make it a single line as it is in the real output.

> Found by randconfig testing on arm64; tinyconfig reproducer below.
>
> Fixes: 68c873363a78 ("pinctrl: microchip-sgpio: add ability to be used in=
 a non-mmio configuration")

Wrong. Needs to be
2afbbab45c26 ("pinctrl: microchip-sgpio: update to support regmap")

...

With these being addressed, feel free to add
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
