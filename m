Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795676964;
	b=FNVAtJpqhURwlmOy//ZUWnd3coyg10CvNbxreG+JbDTPvkRwl7Y6ZRust235efhjjR+b
	 5xlCorgS0T15SM1IIQkH4Hb+xwgm1pezohkUgEYx8qZ7JaQRMELMgcRcZEz5B9EOkzQU/
	 Lq5zmv49+33zJYMUuaRg/L6WjgFZ2Qo3HDNyPRr67hG03kH8l1SaMcl0bDGPUV/DQhUXj
	 fzHJumDbo7DDor+ZJYcHL+Rp34Apmwoiqm5G0oMe/LVoYnZjMcKADro3VppnoGHyXm561
	 5XfD1l4OLfJ+7B+9NZxbOKxYN2Q8wMARLEou7zSImZtpOAH1wGA9mr6x9+UC5BkuRjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795676964;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer;
	bh=jwb5N7uyT2WDq4mt94dsR2bTDs02PiJrxSo0w40YZbI=;
	b=ZkEYgwBLWWjE6H89cznJVlIxld8g4WfZ8LhOcDJrH2sAveVTCWoduDl9ul0SZs91SVDe
	 UIZb8sj7OXuVHPWuNzCdbQe7VWxwTlmzedQJTk+kw0LA0gPkEWckb0G0YSl3GcgBtvZkK
	 O6jqow/T9xGQ1r6ESj+sbh25EPGvqQ3+Avy01uaBL+yGdfWLBuRcCioFPu3hcPHn+e77U
	 bxTOzTLlorwU8WWGKYQ1ZVPSh8s5coyvr9LxQmOoMJi4YKLlf+/OGvTgMVn7MVxqHSRbi
	 HZK+sjNk4S5lbHMY1dOTbkRqWWA9dLe2F/yIw/keyG4BHSq0TSQzg0xapMVxDf7fbxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mCwJGwIW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE123606A31C;
	Thu, 26 Nov 2026 07:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mCwJGwIW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5EC1F000C0;
	Thu, 26 Nov 2026 07:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795676964;
	bh=jwb5N7uyT2WDq4mt94dsR2bTDs02PiJrxSo0w40YZbI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=mCwJGwIWKvzK5Z8LSs1t9rcO+i7vyCTE2UxjxEobI+80N9ZySQU06hNNVBR9amkph
	 OufZrL59lQtB8JPQoCIwOSZrpK4kOX9JZ2Sl5g1jVk3C3nK7/wq6RXAy0+5aOa4/De
	 XsW7wvdjh8auzT6rnFQNNWP+92RNGkNHQec0Wqi8DRKsKKqf+8SnutKR+AiZWoov8Y
	 fzCaW2UeR3nxd3KXKuz7nmaYwQEKxcfWZQF620tL0fpXwfrEdnYh5lSIWNOtgnKS9i
	 ETdBDVXSQnbzBqOaOBY1ZDKeLP44/1t1sRjXqioEf2mbMZqCOzftLSS0Jl4ZeMQhio
	 a7jyskB4454wA==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 07/10] clk: samsung: exynos5420: Terminate PLL rate
 tables with sentinels
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Thomas Abraham <thomas.ab@samsung.com>, 
 Chander Kashyap <k.chander@samsung.com>, 
 Amit Daniel Kachhap <amit.daniel@samsung.com>, 
 Tomasz Figa <t.figa@samsung.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Marian Mihailescu <mihailescu2m@gmail.com>, 
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261123164834.3330320-8-lee@kernel.org>
References: <20261123164834.3330320-1-lee@kernel.org>
 <20261123164834.3330320-8-lee@kernel.org>
Date: Thu, 26 Nov 2026 08:09:21 +0100
Message-Id: <179567696129.9086.5750343229179878451.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-23 16:47 +0000, Lee Jones wrote:
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
>  drivers/clk/samsung/clk-exynos5420.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

-- 
Krzysztof Kozlowski <krzk@kernel.org>
