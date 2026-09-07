Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF39244998E;
	Mon,  7 Sep 2026 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770603; cv=none; b=IgpeGD9AGKTkEZwh1gYxuLN4S/FWMOV6juJOREx5dd+xqjZoRtnKZYBl4OU1s7/pubVCcgo2R9UBKvnA+d0RWUM7vYk/X7b6AsYuYUyRTrFxNQOPvdQYDPvpoE2WlGnjtiNGvcsJta1vHkaiQ2eq0ufdv+a2tHgZQ8ocr8Jiycs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770603; c=relaxed/simple;
	bh=jDZRY+Lx5bEFpVHpCIz1x9CSgZ17ilNf6ybGRTwCLp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=luESk6wuPVWR3+fhA6qJEwY3+e60p6I40kCYAfSC4b8Q1KArdFM9YSqM1zXARozpm+uXANlG94L+6EKRjxZh17WvlSnNW2htxDry+p5Sa2Nv8+BVxV/Erp39mYArKu1GJxzuBR2oASCMWeVKdSHiAcK0adL7zvtWc+Mvqtn+LCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UMoYdUxs; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UMoYdUxs"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FCFC1477;
	Mon,  7 Sep 2026 01:43:17 -0700 (PDT)
Received: from [10.57.7.146] (unknown [10.57.7.146])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F5CB3F7D8;
	Mon,  7 Sep 2026 01:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788770601; bh=jDZRY+Lx5bEFpVHpCIz1x9CSgZ17ilNf6ybGRTwCLp4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UMoYdUxsWdugSNSpYCTIWpIWDXM2xQXWaGjgMikS3nTyyylqDtfV7Np8zfLyAeobj
	 U9OzJZITthZTTIDifX5GjyPibwFKxuzAPHdKURQXto7G07aWEpjGb6BVl0UKgQqVaa
	 hM5eMBd9y35CVWUJxzipqNLa9QtAPHpcJ9l2wpa0=
Message-ID: <b7b1b199-08a6-4685-9def-d4d6eb396cdc@arm.com>
Date: Mon, 7 Sep 2026 09:43:35 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] memory: exynos5422-dmc: handle clock enable failures
To: Jiawen Liu <1298662399@qq.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>, linux-pm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Alim Akhtar <alim.akhtar@samsung.com>, stable@vger.kernel.org
References: <tencent_B0189529F550458590E3BA614EAB800FBF08@qq.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <tencent_B0189529F550458590E3BA614EAB800FBF08@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/4/26 11:01, Jiawen Liu wrote:
> Check the return values of clk_prepare_enable() for fout_bpll and
> mout_bpll.
> 
> If enabling fout_bpll fails, propagate the error. If enabling mout_bpll
> fails, disable fout_bpll before returning. This keeps the clock enable
> count balanced on probe error paths.
> 
> Fixes: 6e7674c3c6df ("memory: Add DMC driver for Exynos5422")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiawen Liu <1298662399@qq.com>
> ---
> Changes in v2:
> - Use the full author name in From and Signed-off-by.
> - Add Fixes and Cc stable tags.
> - Generate the submission with git format-patch.
> 
>   drivers/memory/samsung/exynos5422-dmc.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
> index 788d49c688b1..98c319552583 100644
> --- a/drivers/memory/samsung/exynos5422-dmc.c
> +++ b/drivers/memory/samsung/exynos5422-dmc.c
> @@ -1297,8 +1297,15 @@ static int exynos5_dmc_init_clks(struct exynos5_dmc *dmc)
>   	if (ret)
>   		return ret;
>   
> -	clk_prepare_enable(dmc->fout_bpll);
> -	clk_prepare_enable(dmc->mout_bpll);
> +	ret = clk_prepare_enable(dmc->fout_bpll);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(dmc->mout_bpll);
> +	if (ret) {
> +		clk_disable_unprepare(dmc->fout_bpll);
> +		return ret;
> +	}
>   
>   	/*
>   	 * Some bootloaders do not set clock routes correctly.

This one looks good.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
