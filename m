Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E423451DA
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792248838; cv=none; b=Jx1RmbivZHDkyI2POSzTRDVOJr23dBcRca6RW/Qqri8dpP0Lnm9bv59wT8dMlIlS9+Js4Da/RnOt6+ABenxbTw1mWAj/xuk0ZTjKYjFq+KDJTcyjZQK1q1kJP4Gfct0ueeKgKiFE4AfnZGiCNcvnZPhmosNfprzz4qgRo3ia61A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792248838; c=relaxed/simple;
	bh=14/hMLHV/tYtznG0hyhpzTapCNH3vt/FqyYM36Xqhsw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=a1Uk0mj/q7R6mil9akzhdPXUbPyN7+KTOlB5VLA6sFeV0eLKcxm2saCiqVLhgj5pOXM5EmNqyvptJxb8IkvU4lxqogCNrHFOXQgvU4yU/PvJSAazhI7ZEfHuNFsrp6RogZPzJFuvaoMkvrFIDcjA8KDo2i+61U/5JpVcfoxGNXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=f3syT2qo; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="f3syT2qo"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a16bc2278aso6600725e9.1
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 07:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1792248835; x=1792853635; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p9zss0HBxC2hnh3BG5QDi7k5785zMX75I0uTXgjx5mI=;
        b=f3syT2qo/3TFp/8ROffPWWw8I70qB+tcFyHNSM/8TcaxkUqaCtjZkZdvj2JSMSGUHf
         +9EWZ6d5K4gpne9RQSqgpxmyj8d++dihDaKIXdwlHKxWMEo6qqpydzJZ5/IdLHOlFXj3
         2ERg2toU39IhvS9qZkSV1uE0khD614YZPcOdk3rj1x8ws7whhpY6j26Wh1oOPzRsyW8i
         hEOhRx3UJXymlCJ9gJZRLwYQx7jmjEvCnx9flExfrwkRfLbT5Tco+8JIq99R6D6tEAGA
         fp57RxU75lJXfPYWqzGx9yJ2UJtS4kbKZyEb9bOFrPrHh3sqmV33bdKiYOD7KWgzIE0E
         457g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792248835; x=1792853635;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p9zss0HBxC2hnh3BG5QDi7k5785zMX75I0uTXgjx5mI=;
        b=Wv30ynWbr6vdfbsHAddSZnE0ExpO3Cfdrl0Ea3mgSze49thqdlyKIPv9ocOvjyY4+m
         WoPKHE8PS/JThFAJjgtZORYdcDFEUAglvFO3QGPOM5l30qeIhTbnhvxoFrELH/G/7BJP
         5pP8RuLtalFxs+tuWIv/UQsYFHXXhX7RFQQV7MJNKzPeBMAJB9YnEQSGDhDh7fwurXeF
         JbElVQHmp/Aii414EgC50LHqdk2mI3TQ0Rrw1R9/c8AKIDqPfEbk1GUOMzPAR8q9wOq6
         rJCqeIZbaN/re7QuoVYW5MwBmMropRmmfp2U770mioZ9Pqgv0X19f6F2pQX12BHoCAwT
         /IwQ==
X-Forwarded-Encrypted: i=1; AKwUvBw29wsJGURzxJg25KO6l+vxxgS76z0evpgPkLNGu1LnBLc1L7FdLrBNSOcTIIeDvjTrSKGlquo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlWM+xKdx94tQiZeDuqaGN3E31mhR07xoQGCEWJ8boGkQwFnbF
	9LU2EcuqRD0iBIcj7on3Ufu+5sSXM3Lo7B0w9bPtTVyUsDRl/yFRYss58WlF09NIM6k=
X-Gm-Gg: AYBFou3B37n2j4iI5KZ3RQAzLn9PDRpyTIDDWvG167yQxIEhSsRFwR6MxxGsFFa2Ccc
	LKxAxLQrhwuppO189vshlb0h/zzyU7yUFSdvPEduEc0lNajRxJtETLilTi+QiJQROYJrIj3cPFN
	GTEu+LkIXmwsgRob6BvdQSrY5zRIAEJP6BBmB8Ab7JltPI0bm9pKfXATPePav/T+sUVcHreTuZ7
	CEmB3ntH7nRJ3oA5a61dp9V7a5AncSk6PCiq/Sh8HdkoiTxTJUmTR21SDfs4FkwCpi/wqgOsUVK
	9AXiN6jEkuMMP3wBM2LXqyS/SOesOYTf9fNzP+BvzEx8lPt8QANp4mHoqYx+3wgn2ouFvMCNDUH
	BsCkIIR3ua36L6JvTudufeoyOoU5X8mbtZCHvHO65VQaS6wlGe0gLYpzwpwcq/7q76YXHb+YqIG
	VF6+a5gUjj5hKyUNatkUWuE/QLeX8icavOIiyIlQdip1ZJbwopEyXUqaLFPDbr9EWvii6uakQT3
	2NVNe2fJ1aK8CSBsw==
X-Received: by 2002:a05:600c:19ca:b0:4a1:ac66:5ffe with SMTP id 5b1f17b1804b1-4a1d75fce82mr60259805e9.15.1792248835113;
        Sat, 17 Oct 2026 07:53:55 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd503862sm11663833f8f.46.2026.10.17.07.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 07:53:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v10 03/10] clk: nuvoton: ma35d1: Retrieve HXT/LXT from
 DT when possible
From: Jerome Brunet <jbrunet@baylibre.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
 Arnd Bergmann <arnd@arndb.de>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 openbmc@lists.ozlabs.org, stable@vger.kernel.org
In-Reply-To: <20261015-perso-ma35d1-upstream-clk-v10-3-47c97b54a809@bootlin.com>
References: <20261015-perso-ma35d1-upstream-clk-v10-0-47c97b54a809@bootlin.com>
 <20261015-perso-ma35d1-upstream-clk-v10-3-47c97b54a809@bootlin.com>
Date: Sat, 17 Oct 2026 16:53:42 +0200
Message-Id: <179224882241.859276.15035084302735586039.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4123; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=14/hMLHV/tYtznG0hyhpzTapCNH3vt/FqyYM36Xqhsw=;
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDFmXexhiw+4KLE5n8ZwffqTXfGbaLNNtyasLfJ8e/iCm3
 CLy7tCfjlIWBjEuBlkxRZYa7mrxd5JaX2ZN17kNM4eVCWQIAxenAEzErpWR4Sdf0fTfq1xm7zgu
 fv93xOVbXPPn+r/I3S6oeFzkuOUXhThGhgMHEnaejKt438ISlZTPdOvAkmXKVzS2fls294zl9io
 tcx4A
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

> HXT and LXT are crystal oscillator inputs of the clock controller. As
> such, they are external clock sources which should not be registered by
> this driver.
> 
> HXT is already described in the DT, but is not named. In order to point
> to this parent from its direct child which is HXT_GATE, we must provide
> a fw_name (when it is named, new DTs) and a .name (for when it's not
> named, but the fixed clock node name is used).
> 
> LXT is missing in old DTs, so we must create that clock and register it
> for backward compatibility reasons. It should however be described and
> pointed at in updated DTs.
> 
> Both HXT and LXT are exposed by this driver only in the backward
> compatibility case. Otherwise, both clocks are expected to be retrieved
> from the DT.
> 
> Fixes: 691521a367cf ("clk: nuvoton: Add clock driver for ma35d1 clock controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/clk/nuvoton/clk-ma35d1.c | 44 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 37 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-ma35d1.c
> index 00d635cdb604..33b397d7b7c5 100644
> --- a/drivers/clk/nuvoton/clk-ma35d1.c
> +++ b/drivers/clk/nuvoton/clk-ma35d1.c
> @@ -65,6 +65,14 @@ static DEFINE_SPINLOCK(ma35d1_lock);
>  
>  #define MA35D1_MUX_MAX_PARENTS	10
>  
> +static const struct clk_parent_data hxtg_parent_data[] = {
> +	{ .fw_name = "hxt", .name = "clk_hxt" },
> +};
> +
> +static const struct clk_parent_data lxtg_parent_data[] = {
> +	{ .fw_name = "lxt", .name = "lxt" },
> +};
> +
>  /* Mux parent selection, by index into the controller's clock table */
>  static const int ca35clk_parent_idx[] = { HXT, CAPLL, DDRPLL };
>  static const int sysclk0_parent_idx[] = { EPLL_DIV2, SYSPLL };
> @@ -191,6 +199,15 @@ static struct clk_hw *ma35d1_clk_gate(struct device *dev, const char *name, cons
>  				    reg, shift, 0, &ma35d1_lock);
>  }
>  
> +static struct clk_hw *ma35d1_clk_gate_parent_data(struct device *dev, const char *name,
> +						  const struct clk_parent_data *parent_data,
> +						  void __iomem *reg, u8 shift)
> +{
> +	return devm_clk_hw_register_gate_parent_data(dev, name, parent_data,
> +						     CLK_SET_RATE_PARENT,
> +						     reg, shift, 0, &ma35d1_lock);
> +}
> +
>  static int ma35d1_get_pll_setting(struct device_node *clk_node, u32 *pllmode)
>  {
>  	const char *of_str;
> @@ -219,7 +236,7 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
>  	static struct clk_hw **hws;
>  	static struct clk_hw_onecell_data *ma35d1_hw_data;
>  	u32 pllmode[PLL_MAX_NUM];
> -	int ret;
> +	int ret, num_clks;
>  
>  	ma35d1_hw_data = devm_kzalloc(dev,
>  				      struct_size(ma35d1_hw_data, hws, MA35D1_CLK_COUNT),
> @@ -240,12 +257,25 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	hws[HXT] = ma35d1_clk_fixed("hxt", 24000000);
> -	hws[HXT_GATE] = ma35d1_clk_gate(dev, "hxt_gate", "hxt",
> -					clk_base + REG_CLK_PWRCTL, 0);
> -	hws[LXT] = ma35d1_clk_fixed("lxt", 32768);
> -	hws[LXT_GATE] = ma35d1_clk_gate(dev, "lxt_gate", "lxt",
> -					clk_base + REG_CLK_PWRCTL, 1);
> +	num_clks = of_clk_get_parent_count(clk_node);
> +	if (num_clks < 1 || num_clks > 2)
> +		return -EINVAL;
> +
> +	/*
> +	 * Old DTs do not describe the low-speed crystal. They may also expect
> +	 * an HXT output from this driver. In practice, nobody should use these
> +	 * clocks directly, but they must be kept for backward compatility
> +	 * purposes.
> +	 */
> +	if (num_clks == 1) {
> +		hws[HXT] = ma35d1_clk_fixed("hxt", 24000000);
> +		hws[LXT] = ma35d1_clk_fixed("lxt", 32768);
> +	}

The above is fine but the problem is those IDs still exist and something like
<&clk HXT> is still valid in DT but now does not provide a clock anymore.

This is why I asked if you about removing the ID. At the very least a comment is
needed next to the IDs saying those are obsolete and should not be used.

-- 
Jerome

