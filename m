Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51283E0224
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275627; cv=none; b=TNOT3lro4RZ9kJNBDxvK2FhW5pL2cDkk8d+abaqYq3z7sRHsV5ue35hEx2Ew8Ko97xVxGNoYc4pI0i+n3y5w6SgvTtESCFVZcSyQDbLwDLyqHgjzuTrafEwPRF1kdRyzhw6RBYGMn96Ep0yKJReFrMcV9Hig8/toikugq/5npkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275627; c=relaxed/simple;
	bh=t79G/LYMwsAfhRbBxWdx/4uZ2p2LpvRja3Ft/eWpBlw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M+5oww6P5OnltZPhJq4wLEHDTfL4ZGUJp6o3rt1TfWezDk3t7KoJpbKLL6Jl+161f4wH2Bp9QyQjuH16iYFfAFWJQEcNsvadqeDKm5yU2krLpNkRPLzyO41097q8X7nJIs+IxwwdhLzOUBaifcJVG7+OxDU9aqHfqie5/xcxqYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5cr6cRz; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5cr6cRz"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4953ddae026so17896685e9.3
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 01:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784275614; x=1784880414; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hku7lsn7Y8coCKFT6sYY6u36fZf6kr/SG26MYxf+TCk=;
        b=e5cr6cRzz5e4GI/zlKWasQxmrWohH2YvDzAhuA7NCIZt+i2LmOKMF/0ke42iLicACl
         rY6nOO2dF2K9IVDe/9tHytKkPP+J8H+35Dqtc8xQD/9CE0sQZQL2V/W/dTAlnr6mrw87
         dRhK3wzu8mIma4SUoZPzgmDBGrixOfgV/pZPAOokH5ZcmwETbshOodnuggtKhaSIjuLV
         rW0+SliaExGfe+PVkFAvtt+y6Tj897ef1BvymqyR8PSsMtaUUR9CQgNKZIXFvlTFKIAJ
         WZnCe7ToWbXQz3++ueYZIBBgkLC5xSkhmbfGCWuteFGIdKDStVqjOfkthJTf2Aox7Vd9
         i7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784275614; x=1784880414;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hku7lsn7Y8coCKFT6sYY6u36fZf6kr/SG26MYxf+TCk=;
        b=mgSC2nlWaAiQzmSdf4L7DQ25jn6AAuCAs8KfgF67vb6Jgl0T7aCFPSL1WQN7yBOBdH
         TA5Z7cHZB2yQsSV8SpGm7khECq4yNVkuQwdvKO+AlUyOXbpDQr5D2HPrycH5AF25Uezm
         jfDLsat+KhO+Mhqrz0D0iJwruzazsPW5JlDr/yriA/9FTx0GYlm76qNLb/bphwoRidkF
         W6U7hWJ4cMRwlQKeNSp450DH9gweo5wTMS8kuC8DgG7f3/xjUqTSklV1cD1dEHwWD5JW
         z6H9/7GyooBZWQXw5/Kp+UKxuHAqUI35HM9ebD5HSxWE09AaXbyaMjnLHz4G3wFk3y2b
         waKA==
X-Forwarded-Encrypted: i=1; AHgh+Rp46yirCR9V8XCMPywnk5GiHXke3LETVXAkr2I6oOj6N+VzFccpiH0g7r6Gq1XEW/ICjZXtlKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO47mVcx6S8sBzlspkCSC0bXB0H4FEsj9asVfROZRJlxE7gcc2
	wiHyxRN36/cw/UkGDCOO6yTlgUAXHxoVWD1KsJRFPrUx517WW3jaHlV1
X-Gm-Gg: AfdE7ckkII6Md0RfjVaH1272wzgKYxGLDs98kaF3XW/tQ7G6XVMs8jWQL8eBG5jxwg/
	hmm//1mwYjMN0IXL50VA+PA5Wm3auhGDYuIncLRSP/d4pao0s6mePM2HTaL3JUDUqF2NPnkOmSi
	0w84ROoRnyq1JC3sqUX7r8MDTy1nKevir9OeMPGMZ0ryclpQhxXGvxLb8kzwX1YXNZ5lcDXOUqe
	NIYp9XqCDdDYxdP0ffrbS9Rp0KIsPgqd/UGIgu5OnJbilUmzTdOi4S8x+XziKQ5vE/ofyWfsd63
	6Mn6geo+697Ep+VamcHsm3wNPCfEO0sd790xUC25oXRLeiFQEw237yfM/xAGoji+PRz8kv8SKRx
	3GQRrwWlMOhgDvzCuvGU12B5TzLlh3ks8uEMHOTz8By3CinXHsJ9nqCnAxWblbY0THZjqomMgtK
	GGzDgsaGdf+CEchD3WpMESmsOJaBiqe7FLMlBcRXI=
X-Received: by 2002:a05:600c:4753:b0:493:bc4b:b8c with SMTP id 5b1f17b1804b1-4954a413024mr16451125e9.38.1784275613708;
        Fri, 17 Jul 2026 01:06:53 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549a47e64sm38939555e9.8.2026.07.17.01.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 01:06:53 -0700 (PDT)
Date: Fri, 17 Jul 2026 09:06:52 +0100
From: David Laight <david.laight.linux@gmail.com>
To: wangdich9700@163.com
Cc: tiwai@suse.de, broonie@kernel.org, wangdicheng@kylinos.cn,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 4/4] ASoC: tlv320aic32x4: Use div64_ul for division by
 unsigned long
Message-ID: <20260717090652.6fccc633@pumpkin>
In-Reply-To: <20260717070252.525545-5-wangdich9700@163.com>
References: <20260717070252.525545-1-wangdich9700@163.com>
	<20260717070252.525545-5-wangdich9700@163.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 15:02:52 +0800
wangdich9700@163.com wrote:

> From: wangdicheng <wangdicheng@kylinos.cn>
> 
> Fix a compiler warning about do_div() truncating an unsigned long divisor:
> 
> sound/soc/codecs/tlv320aic32x4-clk.c:169:1-7: WARNING: do_div() does a 64-by-32 division, please consider using div64_ul instead.
> 
> do_div() truncates the divisor to 32 bits, but parent_rate is unsigned
> long which is 64-bit on 64-bit platforms. Use div64_ul() to correctly
> handle the unsigned long divisor across all architectures.

And the code has to process the same values on 32bit.
So the value must fit in 32bits and do_div() is fine.
Doesn't 'fix' anything.

	David

> 
> Fixes: 514b044cba66 ("ASoC: tlv320aic32x4: Model PLL in CCF")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
> ---
>  sound/soc/codecs/tlv320aic32x4-clk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/tlv320aic32x4-clk.c b/sound/soc/codecs/tlv320aic32x4-clk.c
> index 5c0a76a4a106..9359492051ad 100644
> --- a/sound/soc/codecs/tlv320aic32x4-clk.c
> +++ b/sound/soc/codecs/tlv320aic32x4-clk.c
> @@ -166,7 +166,7 @@ static int clk_aic32x4_pll_calc_muldiv(struct clk_aic32x4_pll_muldiv *settings,
>  	 * math in the kernel.
>  	 */
>  	multiplier = (u64) rate * settings->p * 10000;
> -	do_div(multiplier, parent_rate);
> +	multiplier = div64_ul(multiplier, parent_rate);
>  
>  	/*
>  	 * J can't be over 64, so R can scale this.

