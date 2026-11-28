Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795873134;
	b=QvQ1NSwheHFDqdNWBM7FwoAI6vMo8AsQ9EOZSymObjgxwohem2+nqAn7+VKNq7lT5OEO
	 5D7GttG1XrTfaH/W+Vw9Gf/cRcLcI/gO/Z7OiDiveBbM0ZcsFrm7VKgVBWIbCo6CFf3gc
	 PhelzgoE6klPc9TcumQBmQL//t8MvBtFSl/ucmeJ/fxiWuDHiPcRabQNLxk990rhw9Iwg
	 a1/bNdKa7+NC49QlCOyGfyMv6aBxWUQnSFIFSbn6GP+5pZKHGFJnese4dBiAazddNkmLs
	 uRU117D535S7A+zWzJ6px7mZbsxqoQ3pLZXVmQdWFrRqlgbnyrU76y2g6lTyzw73aIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795873134;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=dCmAGX2Omd/g9y7jDZCpeWTJ9I+W1z7gL0oCYL7gw10=;
	b=yUYmUBxY43GgdrmavVPBEsBr0Ri5OqHsnlHQyBAYR9yICCA4q7OzQqnfHbduCQx9KAQC
	 iS0PG7DUbAShAVhBqtr57O6sSksjqmfn2Q9PsvMqprEiOJeVwJANrrVxGqd8ZoL+vroO3
	 aSV4k4WKkMJSI8KKJLSdVSqYHFSMpb01gUwZO0Dxbivw1R04jcd50uQSmUReHfxjs4dV1
	 fySiJR5MszSAXGj3W3yB+OZA37Dqq0V06CK2HkpBXVyh5ZBeHCCLdDmBKmBojUHTCWfIr
	 ASTICgrXKSfVkuD4iky3/XQQuTzZv7rtX+H2eni4GNOAgXnH30f4YnYW2nBwt6F3AfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wTyeE1UY;
	arc=none smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F82606A321
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 13:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12F82606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wTyeE1UY
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5c10dc41270so9383835e87.2
        for <stable@vger.kernel.org>; Sat, 28 Nov 2026 05:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795873132; x=1796477932; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dCmAGX2Omd/g9y7jDZCpeWTJ9I+W1z7gL0oCYL7gw10=;
        b=wTyeE1UYXKFFlRlLAUJLkr9C9/Brmuh5IhKjiX+lPzzs+/9twKhj5S3a4LKPpGRO1R
         Z2KoeptxVlTXvErSql4Wy15JF/SLVpFMKE3Tj9EUe6EQhCTaBdAZKXYuA6NVcvs/TPa0
         Qonbh/BnIA+78Piovo5I7+tHAke7nbjedz8z0p8bN8hdosjDNMQR9HylVUq+qa6g9rxE
         hp2CX8u+SswX1VCZhDsVuBkYmC5Sh4ktO4nsAWbzXUuBQKmjxmqnJHPn5cEQB9AlR/ZP
         vDK9sEvN9TUdDS84TIyfSlMdsXwGKBS2IG8Jh7QSnZPqoFUCIk77zqz4WPa+L0yWaCgr
         0XBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795873132; x=1796477932;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dCmAGX2Omd/g9y7jDZCpeWTJ9I+W1z7gL0oCYL7gw10=;
        b=KbdEgbWn5GBXbhd+q2LR9GtbeJFPq4EdRJ4NsYYwlGgIjt+Byg4fFcAIzc1sDforz5
         oL4StjR5PDTqJ8g5uptCSN35PdIAdJIlxzv0jahDmhvgICJ8mkX0BeLdJTzlH9iACga4
         g/wuyX5wO0kML3fb+BYzbkjkOdqFGVWcIJpdu9lO7nH8mp4cTZXgYBfxNIMDnlGRn02y
         cBgY1Eh5YlTWkkQcwir4JhlehRlSJa/t28OHsDD71vsDiJHyAgCMItFh7M3/G0Dpl9QB
         w+hz90uqgCSU1ZYjtGlCJGblgYekBp+3CwnK3y8ZrOV7obidrXwsCxPuVLUYd5whVcKJ
         sTOw==
X-Gm-Message-State: APuU4Z9A57gB4DU48S2CHRewSHvyoZ+MAFkAZp1/Bd0llrvE/W9+Fbz5
	NwBOBQDVv547MyE0/owm9WLyNJVJYewjXMYtbwc9nOw8BMa4omKAhKnz
X-Gm-Gg: AZFdTZdPdBPcW6a8jEKNJYON9yKFDqDq33EBKicJ7V80hsoXRAp4CUekfCCkhFux3lk
	l9GCF/i+gagswJTOpRNmLvK8RU0as6RI1W3KeTiJRIo4HPanR54LXul7o65oq/Zorh1+BdHRS65
	yCswkSB0TGV2OqRbfCB4Pj/KrIbt2Itw1M+NnZpWKusYzwXhFjxJRZzwTK2UGnnEcbKlTYSsMVI
	ZLxaKxQsHG2dbrgozc90oyLXnmMZHxhqeM9d8zAoxo8896ZOjjJRPKhzh3L4ShgTpxdD97jKOu5
	pBZElV6yyU5CzeeK0Lmj3Q6ZqVXmQDadeVFQfAGf8ITAaEH2lM9HanB6ScF4YpiHof3ZJV9Sns+
	OrMrsnfLH0ExVrZDkK9VKq2ZHuirWgYf3hwiI5ijILr3YsBzrXQbG8XsaTSzeDY9oVAPOFdPrSd
	By8UI0z4PkhmgUxhcv/Y/nWVR6C2zP5MCiGx55bom4aMpwtOwP+oGkuDtgjwAEssG5QopF7HDNg
	boVyJUvgpwAN/XJ/jJIneYesGyxK9LnIU8id18bomxX9v1FFrOJ0t0ivCNWyljuiA1+KXFHcdfE
	FlQde1PO/GzJDFSuNq1z8mZcaEmirWhUUrbxQQDhH93I
X-Received: by 2002:a05:6512:3b89:b0:5c3:3dfd:c4e8 with SMTP id 2adb3069b0e04-5c33dfdc807mr1617419e87.2.1795873131953;
        Sat, 28 Nov 2026 05:38:51 -0800 (PST)
Received: from [10.127.127.83] ([5.195.0.145])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bcff8b82sm6968991e87.16.2026.11.28.05.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Nov 2026 05:38:50 -0800 (PST)
Message-ID: <2528005e-67b5-4e23-a357-fbf853c2ff38@gmail.com>
Date: Sat, 28 Nov 2026 17:38:44 +0400
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] clk: samsung: exynos8895: Terminate PLL rate tables
 with sentinels
To: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 Danilo Krummrich <dakr@kernel.org>, linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20261127180416.3277544-1-lee@kernel.org>
 <20261127180416.3277544-11-lee@kernel.org>
Content-Language: en-US
From: ivaylo ivanov <ivo.ivanov.ivanov1@gmail.com>
In-Reply-To: <20261127180416.3277544-11-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/26 22:03, Lee Jones wrote:
> _samsung_clk_register_pll() sizes each PLL rate table by scanning until
> it encounters an entry with .rate == 0, then copies the counted entries
> into pll->rate_table.  However, pll_shared0_rate_table,
> pll_shared1_rate_table, pll_shared2_rate_table, pll_shared3_rate_table,
> and pll_shared4_rate_table all omit a terminating zero sentinel, causing
> out-of-bounds reads into adjacent read-only data and populating
> pll->rate_table with bogus entries.
>
> Append a sentinel entry to each of the 5 PLL rate tables.
>
> Fixes: 9174fac3b302 ("clk: samsung: Introduce Exynos8895 clock driver")

Looks good to me. Thanks, nice catch!

Reviewed-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>

> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>   drivers/clk/samsung/clk-exynos8895.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/clk/samsung/clk-exynos8895.c b/drivers/clk/samsung/clk-exynos8895.c
> index 259481c4276e..daf337f47e4f 100644
> --- a/drivers/clk/samsung/clk-exynos8895.c
> +++ b/drivers/clk/samsung/clk-exynos8895.c
> @@ -478,22 +478,27 @@ static const unsigned long top_clk_regs[] __initconst = {
>   
>   static const struct samsung_pll_rate_table pll_shared0_rate_table[] __initconst = {
>   	PLL_35XX_RATE(26 * MHZ, 2132000000U, 328, 4, 0),
> +	{ /* sentinel */ }
>   };
>   

...

Best regards,
Ivaylo
