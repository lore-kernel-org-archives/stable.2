Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793268918;
	b=oaSqcJIJblu1cwHV704/Xg7X8+XupBG/Pi/q2aR4Eg6NPtdrJTjZSNdKf9p0ffantqpy
	 qGHLHYAzKXhaSI3/4/veBjaMROVMS0V3yma4YlwseBuolZ8dsd/L3Mt7QPbVvSuxvJLsv
	 uy/BQO49I86c7ayA13IGRcg2s5+MTE0ItpaCLfRXJxKJxY3yJyk8rznmusSjEJ7bQp5jP
	 ztn6yK7vwhzFErIVaXr5u7yFTCl8QafpWbZizKvbO8GUM9rMFStLyE439c5cPPac2sYjE
	 zTlGTtekRKXjgzdnzDbdu0lYqNVRPUvIT7WKq4bbJSQ8fWAYwkuY8QGGyejGqjme3Dg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268918;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hZhJRYKRYnpA55dTVl2RVAnPezaQl7o2LFp27rGTjlc=;
	b=EEkghRo0y+0muyDU5NhUnrJrufm61lepR4BGH14RKw/m23DzOIuJkaDzD/RzPQsX8yrW
	 D1lFjrlMTlREiVVVFSBRtpa1AEaG1TAxCRZcr0KjI1p9FQuK+47kS7kz9O0DvaykIkgJd
	 T6cDDxcvWNq79AlX0AKF121C0kLsF+2iwInsMLfKaWnrG0nS/tkG8U+UgLupPT75M8VQG
	 bY5lUOeM0DyK6tWZV83GMurThq/SlH7HvRhJl5bLb7YDM9ZP7OKK909dRSs6c4jwJrONp
	 0giTZE9eLGnH8WMuMzjVf7wBulhEoU3rXkfAuj5NMsz6nxWPbuhUhC6votddV/cdzzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yYaDw9Qa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B504A606A325
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B504A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yYaDw9Qa
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so2980255eec.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:15:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793268917; cv=none;
        d=google.com; s=arc-20260327;
        b=V9OojtqFSEUfGsTV3T3yWCPYCgCayBH5pKoa8W9F+lIelNo97Ikmm2b8zjNGA6ddNe
         43g6PiKAE2UGRGIiLT8f8vMsbxvpP1SmD7oJjvi5J/5baU5kdDmE86AzSvaq7vxbo0zH
         BqFiAswWwDtpF7Pxfo4pMhd2ZKPywHbgDsZKsWu6au7d4Od7ayTSesK9RdC3w6R90jvN
         oYOI5NE9a9ON/CgiKrQ4xLKIHElpYk1P9SGXw13lrwnwJknQeIXEjUUWIUSwhD9/8X5J
         5fw4tq5p9flU1w3UhVVTJRiUJI9Jzc0XV4/AefQ9txGDfPxOsSXzyUMjMVtVZuiCiO73
         Y6wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hZhJRYKRYnpA55dTVl2RVAnPezaQl7o2LFp27rGTjlc=;
        fh=HTjCrAjysB/2xV2rURtfsq9DcKZynKApKdwIzVVuADk=;
        b=Z1+ztang3IU9DgFEJxaDDvNncs0tMY+oewmlJrfrynmDK9Be2k3/vxbGJ5MT7kxsAn
         U9r6v7QirC6qyz5FmXgbv4WVtzUSu9fZB1BN2ipEKnb/kQP1oHVW56jf4CwpyJW7Lntx
         lKF0T7z2/jRCcVgMsVOTB4XOmXLnb+GxbsTIexivmWIa9T5/XCQYewo81pujv86bxKzB
         HB5uSsB1pGNDUWArL/o3d+VyAmrH1FUjeed52EtPD703lJqQc0LtfmmzcYAbmMRsAWvM
         325O4VlxsXzagTw1PgDuUa02ZKcWuGEbHLEEBmKfiKRcFjOwO2TI7VasCZvAgZn7FwD6
         H+4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793268917; x=1793873717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hZhJRYKRYnpA55dTVl2RVAnPezaQl7o2LFp27rGTjlc=;
        b=yYaDw9QaXvy/ey4C72CgmAyNvMVNhiCEbTAs49OXnei/ZdR9HQ4ujPrhIh3QcHQSf7
         NDNxbOTB3YbR4C5RZkRF1VYNQP/S9u9CTY/EcbOtaFoOwTlwhStsSoAYDGToa1nmQtNO
         YzwjyQR+93YuejSkGmUY0kn2j9hcgkPiDJwI1AyQp59CWfrSnG03qEcX6cdeyJsEzFsw
         kCBMMLbhIyYKc0Cd6jkfxWdtQZ0o8y/ZdFG7wS24RfvUZMiGg+y1laVgz5IwvjdD1ZxB
         vlAGCgNtoUkDkkfWdDnkBwwJ8+30su/Nh5RoEMMkpkUI5HlQCyjPh5KDG/1XUj1VvTak
         iP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793268917; x=1793873717;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hZhJRYKRYnpA55dTVl2RVAnPezaQl7o2LFp27rGTjlc=;
        b=IDAL21ux063jsHolpJYx/ycbw26rVwiTG96/Arew0cHeNUJIvqQOrIOpW/79XnuHqa
         8NaDgzV45KVPmldYVT1vvfJAsyZplBTIzZT/0MXtAE0VAnoo3THdeCbDkJBv0/k+qDSq
         KzZkP6OjkeRXCoNbE+K10Hd5tFcTaql31qUhhaiApBdpcZA6AT9xASBQ+6lz9cGnYv5K
         LB4Y/eiSJnrEpyaLDbDUWb4CTkiDE4scck7+Vk06yAGBFWpqim/r5PXUjDS81bSXn9Z4
         eAuybDcPM+lLjDL+HvbdqhFngbq4bBKh/SZTRstYDDzRbCGIgbKzhNwikP5pxEwIOOKE
         fpgA==
X-Forwarded-Encrypted: i=1; AKwUvBwzArORMjRexu6YFntrwJQVETM4eU3hsw9Um9JE9EzHqisEpDkIoawUnLIbrsbgC8etoblySxc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLVVntPCJUXyhiMXhTln8i5ZCQgydKZNGIxpapbTe5xRpC9t0ex
	65jy4BWaXNM+2EyRtNh4SOqzP14DSxFUO1yVMdH98KpXWLNlRx/lCkHWvTtA5wUJWxq9T/4Z9ev
	mSgFa7n25UoLpcIG+69ypVzmYiRS9gc8=
X-Gm-Gg: AYBFou1UG0M3Lm5bkc5vnLz8C/HEMbxv3gy8yqLfgUweiRd0Ev+LKpO716jJYYvUbEd
	3LuBFnluxnpFL57+x5NlSgQIVtJdSNrXDzgkzwQCOSEE4d/nm/upElGr41SD4oJkeB43PUzfERk
	4/kwLjDC5tfjfyK74Obj1J+FNnj8xPSA6VSwXDB7zvvO+9c459r3Ohf2jVFaIgXFIIsVEbi/5cX
	RcUi41kehZuKn6GdHVyGHHrvmWRudIRdbU+7H0Zun62RCZFLkFbg1JhxHxl41qxUJBr93J+DZEX
	Qb4Fqpi1Hzd4R5sl5SGn7pcdi3rLG2C/+UiXLe/ssf2wOVhL5Oj7kDqgnuAkIDC9KJE45rXC1/K
	8Na5YPMr0nRt/2e6WVYv4Wgwn1Ya5XfidVLOzzsXemlBEjaNzA53nYIjKJ2KQUoKEKjr2fkbXWn
	6Ctvqj0BlZImtXobQ=
X-Received: by 2002:a05:693c:69c9:b0:36a:279:c93f with SMTP id
 5a478bee46e88-36a203e2a52mr6817742eec.33.1793268916731; Thu, 29 Oct 2026
 03:15:16 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-upstream-speedo-t114-v1-0-81457cc9d94c@tsv-stahl-riesa.de>
 <20261029-upstream-speedo-t114-v1-3-81457cc9d94c@tsv-stahl-riesa.de>
In-Reply-To: <20261029-upstream-speedo-t114-v1-3-81457cc9d94c@tsv-stahl-riesa.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 29 Oct 2026 12:15:04 +0200
X-Gm-Features: AclHuK_nKjJOvqTdHrlTm0y6eXLR-uFJwQRZTvfrnf6NnzkRQXlz5soPbSPOmYM
Message-ID: <CAPVz0n13YHVAGNoEYZaef7HL1HkQK9w+mLUV-h4AGC0mr3bkpQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] clk: tegra: dfll: Get the voltage step of range-based regulators
To: admin@tsv-stahl-riesa.de
Cc: Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, linux-clk@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 29 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 11:3=
3 Patrick Fischer via B4 Relay
<devnull+admin.tsv-stahl-riesa.de@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> From: Patrick Fischer <admin@tsv-stahl-riesa.de>
>
> get_alignment_from_regulator() takes the voltage step from
> regulator_get_linear_step(), which returns desc->uV_step. Regulators
> described by linear ranges, such as the SMPS of the TI Palmas PMIC,
> leave uV_step at 0.
>
> With a step of 0, round_cvb_voltage() returns 0 for every OPP, which is
> then clamped to min_millivolts, so all CPU OPPs get the same voltage.
> The I2C LUT is broken as well: find_vdd_map_entry_exact() and
> find_vdd_map_entry_min() divide by the step, and on ARMv7 with hardware
> division the result is 0, so selector 0 matches every voltage. The LUT
> ends up with a single entry and the DFLL never changes vdd_cpu.
>
> This affects boards that run the DFLL in I2C mode with a Palmas SMPS as
> vdd_cpu. In mainline these are the Xiaomi Mi Pad (Tegra124, since v6.19)
> and the Asus Transformer Pad TF701T (Tegra114, DFLL enabled for v7.4).
> The AS3722 and MAX77621 used by the other DFLL boards report a linear
> step, and the PWM mode does not use the regulator.
>
> On a Tegra Note 7 (Tegra114, TPS65913) all 16 CPU OPPs are at 1000 mV
> and vdd_cpu stays at the 1.10 V left by the bootloader. The CPU runs at
> about 1.34 GHz whatever cpufreq requests. With this patch the OPPs range
> from 1000 mV to 1270 mV, the LUT holds the 1000 mV to 1270 mV selectors
> and the DFLL follows cpufreq up to 1708.5 MHz.
>
> If the regulator reports no linear step, use the smallest step between
> the voltages that are usable on the board. Fail the probe if there is
> none instead of running with a step of 0.
>
> Fixes: b3cf8d069505 ("clk: tegra: dfll: CVB calculation alignment with th=
e regulator")
> Cc: stable@vger.kernel.org
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
> ---
>  drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 26 ++++++++++++++++++++++++=
++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/teg=
ra/clk-tegra124-dfll-fcpu.c
> index 457a77c5bb62..5bdea4775076 100644
> --- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> +++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> @@ -642,6 +642,7 @@ static int get_alignment_from_regulator(struct device=
 *dev,
>                                          struct rail_alignment *align)
>  {
>         struct regulator *reg =3D regulator_get(dev, "vdd-cpu");
> +       int i, n_voltages, uv, prev_uv =3D 0;
>
>         if (IS_ERR(reg))
>                 return PTR_ERR(reg);
> @@ -649,8 +650,33 @@ static int get_alignment_from_regulator(struct devic=
e *dev,
>         align->offset_uv =3D regulator_list_voltage(reg, 0);
>         align->step_uv =3D regulator_get_linear_step(reg);
>
> +       /*
> +        * Regulators described by linear ranges (e.g. the Palmas SMPS) d=
on't
> +        * report a linear step. Use the smallest step between the voltag=
es
> +        * that are usable on this board instead.
> +        */
> +       if (!align->step_uv) {
> +               n_voltages =3D regulator_count_voltages(reg);
> +               for (i =3D 0; i < n_voltages; i++) {
> +                       uv =3D regulator_list_voltage(reg, i);
> +                       if (uv <=3D 0)
> +                               continue;
> +
> +                       if (prev_uv && uv > prev_uv &&
> +                           (!align->step_uv || uv - prev_uv < align->ste=
p_uv))
> +                               align->step_uv =3D uv - prev_uv;
> +
> +                       prev_uv =3D uv;
> +               }
> +       }
> +
>         regulator_put(reg);
>
> +       if (!align->step_uv) {
> +               dev_err(dev, "failed to get vdd-cpu voltage step\n");
> +               return -EINVAL;
> +       }
> +
>         return 0;
>  }
>
>
> --
> 2.56.0
>

I can confirm capping CPU opps at 1000mV and this patch fixes this. I
have tested on Tegra Note 7, ASUS Transformer Pad TF701T and Xiaomi Mi
Pad which are all affected.

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
