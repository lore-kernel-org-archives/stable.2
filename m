Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795640360;
	b=n5tzH9YaYgrjivQAlNLEiUe2Omc5ND4fCectBVYyzygoSBEgIh3eOvkCHSbqu35x1Cvt
	 HEr0Z+t4dNi5/kpIPmVg7XtsgpyW7NJK3PmJ6lPlnisBvY7iEHW94nVANaU6uZtQHwECC
	 kX4W2qVXtWw20Fs1a56IH/pmhXpgqdNk29uPEfIOFVxST1+jdXNdQ/5J8uCbETy8g2Oqd
	 tBBLw1hza8Oxgm458FnrGUB8pOLbrCuJE78+JO1zmL0uGbQ0e5uLe2Sry3I6DWCctzWjw
	 J37iDn8/zMYbH8kteSe/93vx30mWAxzjeFNDT/mJVNV5o6ZZYwFlMP04LEdyIKzF9oA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=PXBgJMIY+nvFjiJk/u8SJDhKaneIc4smuRh4J/SjTx8=;
	b=PjbmYoIIzIctQzcbrkkVF7/FmJPpNJGWdY++GxzsbuvbtI/WV/lOq1jAOlK1Nmf914Ww
	 cwAg2d1mMu3M/e/tclwMu8uwPFE8yIglXx5/iwiasgjaosZdazLJ7x4JJjHycb0+AdNMv
	 aEM4JYNSgaMHAcvR1PCDm+hdOAC1qPDWUjJk5tDAR6+sxRwnu/pLwLlbHe0WLtQmwD/et
	 gczXbN/w97Z89kjXLKNqI/0Ref2rMFRRchjX9RO3exoV36KzgyEOo1zHEHgzR/WBh7OWC
	 TVe54iDOF06nUg1Mh+NzXRS0ScjOn9eG8AP6tOpLAFrJtedFQs1yn/zZHLLba8mB/tQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XX+oVSvl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B06606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6B06606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XX+oVSvl
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6bab377105dso4914631a12.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:59:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795640358; cv=none;
        d=google.com; s=arc-20260327;
        b=kyDPeFsLdST6PYiuaYPuYqdwJniQxsrQUcVc0sDq1/xtCVT6JCah3yIR/uTWUwD0Cd
         E0eUWLP/4p+uYLzfkxnBqNzuKDqVasmFF0hdmmYK99uPTdn8b6cB8lUlIzE/GvfTVulr
         QEPTneb5WKtn+ATCHlhhtU0CJhmfG9dA/yPK557gw29CteUvJIIa5H57gTlVfSG5uCTo
         03Y6xGNtwrmJ2I3K9oY3ZTfVwfYB7R7CKnuguhJPgg353mQ9Ne7jOAbP4y2lKC183MXv
         b57xApB7B9U2NyGdFFEOa7QovXZ1EkpDhzLlC5LLC67DGfwsjUGxe7H/O67qD+eGNVDC
         /wQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PXBgJMIY+nvFjiJk/u8SJDhKaneIc4smuRh4J/SjTx8=;
        fh=Z1LPyeI3/eghuXF4CbPORvDV7MjhTj3MaBj8DpTrmcg=;
        b=Rjgia3E+o72IUuG/9YybD1SLQrmvRg2UedLYsO89y4DCP0fstGAVXtsZW3CSvTvfBk
         S79BUOmmJ8OTvGbcgXa2tJyGeISqGRhsvqOzbjtbbmp7+ZpD0LpoWMUI+TiX4T928oBu
         Dn8Juy7GSumU6wvDvMdQb8ZrK79cQEoRWs83blvsNMwCXo/TWHNXuMOB4gl1oV3bqmnB
         hg3IFgDPp/yLnesOqhXo9D8U4nUDVQGJ+cimplG0tEW+fSdBXUcvvUUFju4e2dqNHfUS
         GWU3SGVDisuGws3Tvp1mms8YexJciHXDl2O1nM9jhKMgvh5cOqW1vY9rR47dYBiFBypN
         rGng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795640358; x=1796245158; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PXBgJMIY+nvFjiJk/u8SJDhKaneIc4smuRh4J/SjTx8=;
        b=XX+oVSvlwbkZJl/q7Fv5V3x1hehf+uCE6xb9HMTUuDbF0ZguAJu6UzBvMyjr+3Fj+3
         Nvvze0tQocy6EAVfwsaasTedqzOkcNCy/4uKy4ga9ffBNEU7meDWoVRIhaMd/gGGMdI7
         lq5DNc74gydvwyL0KrWQjZceHBDyui3QPZeJfkBAj+1uk1bV6V6TfjBr0CGUgjMNGPgc
         30FyNBH/PxEbZNh5NMMvBcC6d1IEiDTbCGmTdLvEdJHnoUn9P1A4ajQO/glmLAXbn1d/
         mfEWoGHROTKpQHjsOwdD0NEQ3Fr4qoUCiHkHuoHNdnRzqEcdcHzI4Nnw4O/QDAzqRJsK
         rQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795640358; x=1796245158;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PXBgJMIY+nvFjiJk/u8SJDhKaneIc4smuRh4J/SjTx8=;
        b=biPSxRWjHJXhKazeeg2qIfWV7wAooLIoCH9isKmmg2pEyKI/PYON7SEUVBVzwE7583
         U14U9fHVAIm7dnlzgnyncpRRFckLWlacNw5CuOdwYrzmUFgAVEkW+CayzPjUoLIHQ7or
         1vnH/9/cWX4GqJ6luVtzoB997byp5mHiGWdccVLUjdPDGPbi1MfU8XZQG8jK0aj9GjkH
         AgyG8xSULTZ8K9EsCY9is3a91i1hbwRfdWRGdIpxo6GDeGHTBmaPmE9TwEsp+rzJyQYd
         NRj+LiEdirxMH29quxneJruELlR6rroOQ4V/XLZPrHXMGob57jqoSfMbnW8TpMENDRxe
         5ZVg==
X-Forwarded-Encrypted: i=1; AL+hErFZE+6PcikTlGe4iJ+rFpmdDff1Uqt9YnJAmN1sTcdhTYgH/augp43kLNzmk5tZupoecO2stqo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9QiGki7CCetv4yfD/C4aN5jrKtJDK2cecJgxpXrUqEY3NF7hhH
	z8T6jaIxnSyJAHpPJcniz435sQ/A0Q23vriTfqpC0r0qj1P4pFNHQad5ootyDdqHvkARj5+qOF9
	fSgM0sPEZpnMP/icJq/p5T265NuIyLIqdVf/Il8PiJg==
X-Gm-Gg: AZFdTZcEWzJcz1LitQ81e/jNsj+ZNkH3ugC796XNTxSL8DJ+1cOGD6FWUHTBHCFohph
	/7xll2qyDbvjZuw632XvRS0GYl8yN8y+aMcUqsC+JfvnuM0lLBsb+GzLpombj3kOKQD0zVTaiPQ
	Frfc1VkgXrNPEen9yjk6omIRw/Nf7SKIxRnsiyL5BRIxuI3Zgx4YgwJRwfTVT5BGrvSRgbh+XeB
	3DVHjsO+L3QnTn0UUZjwivQTA3/cqjAHwAAegb6hoCTDClsBqx7vi0GYihdhxgqS7ovJM36mlfC
	SJm1haXjpysM/kdJz1EQwzxGC+Ww/rLkmv7UHqcUqX+zD+UwyRHqLR3YC/k+uHPGUNIYr5WWc2z
	ffxecqlRTnpupJbIhIqotmz9UAY5rtRoq4rKyKt6bkHb1j7f0K8GTSWt50HmKz66/NkMNhJI=
X-Received: by 2002:aa7:cf85:0:b0:6b1:a509:875 with SMTP id
 4fb4d7f45d1cf-6ba37e66febmr9344235a12.20.1795640358409; Wed, 25 Nov 2026
 12:59:18 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123164834.3330320-1-lee@kernel.org> <20261123164834.3330320-8-lee@kernel.org>
In-Reply-To: <20261123164834.3330320-8-lee@kernel.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 25 Nov 2026 20:59:06 +0000
X-Gm-Features: Aa3M54qBKC7-tr-B2jw-93nT_AW_sr-oGI0v4yuTHgh0h7sm-7QQngWZhmScpnM
Message-ID: <CADrjBPq2OmgLjzs8qYybQSKRDBC5QK5DTrO8Wy4gbUoo0Ydu6g@mail.gmail.com>
Subject: Re: [PATCH 07/10] clk: samsung: exynos5420: Terminate PLL rate tables
 with sentinels
To: Lee Jones <lee@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Thomas Abraham <thomas.ab@samsung.com>, 
	Chander Kashyap <k.chander@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, 
	Tomasz Figa <t.figa@samsung.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Marian Mihailescu <mihailescu2m@gmail.com>, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Nov 2026 at 16:49, Lee Jones <lee@kernel.org> wrote:
>
> _samsung_clk_register_pll() sizes each PLL rate table by scanning until
> it encounters an entry with .rate == 0, then copies the counted entries
> into pll->rate_table.  However, exynos5420_pll2550x_24mhz_tbl,
> exynos5422_bpll_rate_table, exynos5420_epll_24mhz_tbl, and
> exynos5420_vpll_24mhz_tbl all omit a terminating zero sentinel, causing
> out-of-bounds reads into adjacent read-only data and populating
> pll->rate_table with bogus entries.
>
> Append a sentinel entry to each of the four PLL rate tables.
>
> Fixes: ca5b40293822 ("clk: samsung: register exynos5420 apll/kpll configuration data")
> Fixes: 9842452acd3d ("clk: samsung: exynos542x: Add EPLL rate table")
> Fixes: 8b4a7acf7b30 ("clk: samsung: add BPLL rate table for Exynos 5422 SoC")
> Fixes: b92981de92cb ("clk: samsung: exynos5420: Add VPLL rate table")
> Closes: https://sashiko.dev/#/bug/linux-553831f9-0a7b-4e94-be60-222de60ca8c3
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

>  drivers/clk/samsung/clk-exynos5420.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 400a5c59815c..35baeabf3ccb 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -1419,6 +1419,7 @@ static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __ini
>         PLL_35XX_RATE(24 * MHZ, 400000000,  200, 3, 2),
>         PLL_35XX_RATE(24 * MHZ, 300000000,  200, 2, 3),
>         PLL_35XX_RATE(24 * MHZ, 200000000,  200, 3, 3),
> +       { /* sentinel */ }
>  };
>
>  static const struct samsung_pll_rate_table exynos5422_bpll_rate_table[] = {
> @@ -1430,6 +1431,7 @@ static const struct samsung_pll_rate_table exynos5422_bpll_rate_table[] = {
>         PLL_35XX_RATE(24 * MHZ, 275000000, 275, 3, 3),
>         PLL_35XX_RATE(24 * MHZ, 206000000, 206, 3, 3),
>         PLL_35XX_RATE(24 * MHZ, 165000000, 110, 2, 3),
> +       { /* sentinel */ }
>  };
>
>  static const struct samsung_pll_rate_table exynos5420_epll_24mhz_tbl[] = {
> @@ -1448,6 +1450,7 @@ static const struct samsung_pll_rate_table exynos5420_epll_24mhz_tbl[] = {
>         PLL_36XX_RATE(24 * MHZ,  49152000U, 197, 3, 5, -25690),
>         PLL_36XX_RATE(24 * MHZ,  45158401U, 90, 3, 4, 20762),
>         PLL_36XX_RATE(24 * MHZ,  32768001U, 131, 3, 5, 4719),
> +       { /* sentinel */ }
>  };
>
>  static const struct samsung_pll_rate_table exynos5420_vpll_24mhz_tbl[] = {
> @@ -1459,6 +1462,7 @@ static const struct samsung_pll_rate_table exynos5420_vpll_24mhz_tbl[] = {
>         PLL_35XX_RATE(24 * MHZ, 266000000U,  266, 3, 3),
>         PLL_35XX_RATE(24 * MHZ, 177000000U,  118, 2, 3),
>         PLL_35XX_RATE(24 * MHZ, 100000000U,  200, 3, 4),
> +       { /* sentinel */ }
>  };
>
>  static struct samsung_pll_clock exynos5x_plls[nr_plls] __initdata = {
> --
> 2.56.1.750.gf70dc682cf-goog
>
