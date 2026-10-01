Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191CE29ACCD
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790847399; cv=none; b=IqG7sDyWF1l5tXMAQw904uhzlNR/2l05BMwsL2a7VpKUXQUqsr0ev55q5oJiFHzo8jf+v8BzXfu3WbBt6MZz67sIqlZc2oyWH275jPHAfp3JvoJtbRQ/bt6WIwrLCs+t7jgvFHZqwrD+stVwDJJKTd/U8BhCpaQIyVW3HuA47v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790847399; c=relaxed/simple;
	bh=nDsPrs6hnGx0JcUP1jewvJFplt1q3U/HxABhh4zREmU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EkoRVnjCbY0/tKQ4j5nBx4/fUmZT/ePjhN/qqBLDbpb74qTgGT8rb9t93Xnrpu4/4NLaSF9EVKWLEueDJESIDQPYdxblWA2JpnYD9l4lwpZkClRo/sbKRuF1iL52wuoFriWr7dLgi1r5eqdVpdjP7XVciCq9keH+kn7uXJSIWBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=oHDqxbGL; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="oHDqxbGL"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e79a408deso39607385e9.2
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 02:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790847395; x=1791452195; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DQz75FsX45fFNLdrpdOp/Fyp4l/FKa+g0Qu8HGi4Fv4=;
        b=oHDqxbGLSUaXFAVTykGDD+ISX63gQAxTVihQbowAtrZ81s2hlMxspqY0mwWQa/aHPo
         fRaY+supR8nOFw5tbFHUlglUjIFHb5CNSshs/5vXyV4yO5ZLIvA7RiVUzEAaln7DuEnt
         M06WOBi6CDUyb03rLelAJqWYzLJj6xwXXsd31mKP6q50WH8tGDUs2TBNNkxKxuRAIJNZ
         znowzwmrW4ywmg3v16KDV694kVJ47lawwVRs9SWjtpVLjWMnIwr+tDKeyyd3yP/5nfGA
         nmZHfJt/aNvolMMg/9q9pkAzzPxGLZpvjQ3tDWT/AsZ3I1pJTh7AnIa+LYrlzYrtv5bj
         4Vag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790847395; x=1791452195;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DQz75FsX45fFNLdrpdOp/Fyp4l/FKa+g0Qu8HGi4Fv4=;
        b=JvP0bEE/3vEu+/1T2qwtPKuQnKJXAmbZzECS/5o5mv11anFTcn+hkqpadP47cFIC0b
         IPmjBVrf79C8rfq9EX4MZhgpMhedkldSij7O/wYIOBJMu2eEFl11JicNoOFfuOUjQHYr
         VePJlMpLiYh9adsbWQ9pefnGItobNTqQngIfRKZnmTJLhra3jNg/QELWmE76W+zXETtF
         x6nyKF1sZ/KLdZbh/uJvTW8DeSljBHFkxhIfONlHa26oKhkPcKnEA04oIvuUBKQO9Nu+
         G2I4BJa1CBxMDKElMjcxOp/lO3rIvJhnOlUD0frdqnBN4cZ4a7ptnSPgwlKJ5lrPbrmQ
         t8ww==
X-Forwarded-Encrypted: i=1; AKwUvByrCsNw2nI1midJBKr/4LIagX3UPFPYttktRAxAf7tcnjSlSAhBz+yH1hCFopRmYyzo5ZWnfUc=@vger.kernel.org
X-Gm-Message-State: AFuF++mWBep4Hw8MKXCJL33VoU/XTS7n9sY9Rpg5osWcK7dEAITUcUza
	z8xf7bCXqiqCb5vE/xMRueFl9qFRjSPgEBhXz0x9s1xpQbEzDnwEBTWx/37rhBV1X3k=
X-Gm-Gg: AYBFou3awUYSZ/WK6saFsdJfti376uWegy2vcpwfTaDS9XwsRodlZal50uAbaNMdUL9
	MUnX2PQ0Qlv8Bd7XqTLQGLBcg3X0D+nQGMtUKbaqqVGikkyyiyn+S/8sg9gsQzidp1LjoUT0C1z
	zMTgCtbRM/mOCSAZajBvymExzjjXLz/awfK+vXChDwlVCBn6XUsIn3vrUoutETW+IEBKXh8eDaz
	oluow4PI+k5o4TczmVqVQiLcmEWDlMx6j/+Z87vjHxOyXufMjfM5TpGg9km1bweksc4ZaqtDc6L
	AOO2XqEn2pAF3i/CrSxtU2XOCo2lpas7grKwhjMvQrL16YKTbQrB27ml0cNaRE/EeuIkE2DhosA
	buMa9zzjjzQIJDXXDoSVq8brtIBKxtirpT8BF/Xsu9f3lhOKttZ9phuS3kbA94GEjtRqn7I72TB
	/vEM3OfBJFdzkPrzL1a491AAS9OqigiqXp9xAra47G0CbZIZgN9RHOURBlCtMEnb1GXkolU/FYC
	OCN5/cj/KVXszCI+6zpCy/QX8dA
X-Received: by 2002:a05:600c:3144:b0:4a0:1c0e:b2a8 with SMTP id 5b1f17b1804b1-4a01c0ecb6fmr59256415e9.28.1790847395168;
        Thu, 01 Oct 2026 02:36:35 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a020f7f220sm57243775e9.5.2026.10.01.02.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 02:36:34 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Jacky Huang
 <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet
 <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Steam Lin
 <STLin2@winbond.com>, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof
 Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, Miquel Raynal
 <miquel.raynal@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH v6 08/12] clk: nuvoton: ma35d1: Retrieve HXT/LXT from DT
In-Reply-To: <20260930-perso-ma35d1-upstream-clk-v6-8-48937ee6c9bb@bootlin.com>
References: <20260930-perso-ma35d1-upstream-clk-v6-0-48937ee6c9bb@bootlin.com>
 <20260930-perso-ma35d1-upstream-clk-v6-8-48937ee6c9bb@bootlin.com>
Date: Thu, 01 Oct 2026 11:36:33 +0200
Message-ID: <1j7bk13gpq.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On mer. 30 sept. 2026 at 19:24, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> HXT and LXT are crystal oscillator inputs of the clock controller, they
> are described in the DT, so retrieve them, in order, and store them in
> their respective HXT/LXT hw table entries.
>
> Since old DTs reference the HXT fixed-clock without naming it and do not
> describe LXT at all, we assume that HXT must be present, and fallback to
> creating a fixed clock for LXT if it is not described (for backward
> compatibility purposes).
>
> The downstream gate clocks can directly use the hw clocks as parents,
> instead of relying on string matching.
>
> Fixes: 691521a367cf ("clk: nuvoton: Add clock driver for ma35d1 clock controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/clk/nuvoton/clk-ma35d1.c | 43 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 35 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-ma35d1.c
> index ceebcbd8c18b..d955d79abdd2 100644
> --- a/drivers/clk/nuvoton/clk-ma35d1.c
> +++ b/drivers/clk/nuvoton/clk-ma35d1.c
> @@ -4,6 +4,7 @@
>   * Author: Chi-Fang Li <cfli0@nuvoton.com>
>   */
>  
> +#include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
> @@ -191,6 +192,15 @@ static struct clk_hw *ma35d1_clk_gate(struct device *dev, const char *name, cons
>  				    reg, shift, 0, &ma35d1_lock);
>  }
>  
> +static struct clk_hw *ma35d1_clk_gate_parent(struct device *dev, const char *name,
> +					     struct clk_hw *parent,
> +					     void __iomem *reg, u8 shift)
> +{
> +	return devm_clk_hw_register_gate_parent_hw(dev, name, parent,
> +						   CLK_SET_RATE_PARENT,
> +						   reg, shift, 0, &ma35d1_lock);
> +}
> +
>  static int ma35d1_get_pll_setting(struct device_node *clk_node, u32 *pllmode)
>  {
>  	const char *of_str;
> @@ -215,10 +225,12 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct device_node *clk_node = pdev->dev.of_node;
> +	struct clk_bulk_data *clks;
>  	void __iomem *clk_base;
>  	static struct clk_hw **hws;
>  	static struct clk_hw_onecell_data *ma35d1_hw_data;
>  	u32 pllmode[PLL_MAX_NUM];
> +	int num_clks;
>  	int ret;
>  
>  	ma35d1_hw_data = devm_kzalloc(dev,
> @@ -240,12 +252,27 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	hws[HXT] = ma35d1_clk_fixed("hxt", 24000000);
> -	hws[HXT_GATE] = ma35d1_clk_gate(dev, "hxt_gate", "hxt",
> -					clk_base + REG_CLK_PWRCTL, 0);
> -	hws[LXT] = ma35d1_clk_fixed("lxt", 32768);
> -	hws[LXT_GATE] = ma35d1_clk_gate(dev, "lxt_gate", "lxt",
> -					clk_base + REG_CLK_PWRCTL, 1);
> +	num_clks = devm_clk_bulk_get_all(dev, &clks);
> +	if (num_clks < 0)
> +		return num_clks;
> +
> +	if (!num_clks) {
> +		dev_err(dev, "missing crystal input clocks\n");
> +		return -ENODEV;
> +	}
> +
> +	hws[HXT] = __clk_get_hw(clks[0].clk);

Don't open code it. use .fw_name

> +
> +	if (num_clks > 1)
> +		hws[LXT] = __clk_get_hw(clks[1].clk);
> +	else
> +		/* Old DTs do not describe the low-speed crystal */
> +		hws[LXT] = ma35d1_clk_fixed("lxt", 32768);

I'd give it another name so you can clearly see the difference between the
DT one and the manually registered one.

> +

Don't need to open code this either.
provide both .fw_name and .name - CCF will fallback to the name.

When you want to conditionally register the fixed is up to you.

> +	hws[HXT_GATE] = ma35d1_clk_gate_parent(dev, "hxt_gate", hws[HXT],
> +					       clk_base + REG_CLK_PWRCTL, 0);
> +	hws[LXT_GATE] = ma35d1_clk_gate_parent(dev, "lxt_gate", hws[LXT],
> +					       clk_base + REG_CLK_PWRCTL, 1);
>  	hws[HIRC] = ma35d1_clk_fixed("hirc", 12000000);
>  	hws[HIRC_GATE] = ma35d1_clk_gate(dev, "hirc_gate", "hirc",
>  					 clk_base + REG_CLK_PWRCTL, 2);
> @@ -632,8 +659,8 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
>  	hws[UART16_GATE] = ma35d1_clk_gate(dev, "uart16_gate", "uart16_div",
>  					   clk_base + REG_CLK_APBCLK0, 28);
>  
> -	hws[RTC_GATE] = ma35d1_clk_gate(dev, "rtc_gate", "lxt",
> -					clk_base + REG_CLK_APBCLK0, 29);
> +	hws[RTC_GATE] = ma35d1_clk_gate_parent(dev, "rtc_gate", hws[LXT],
> +					       clk_base + REG_CLK_APBCLK0, 29);
>  	hws[DDR_GATE] = ma35d1_clk_gate(dev, "ddr_gate", "ddrpll",
>  					clk_base + REG_CLK_APBCLK0, 30);
>  
>
> -- 
> 2.55.0
>

-- 
Jerome
