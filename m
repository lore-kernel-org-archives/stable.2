Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FF433A9DA
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 05:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789364806; cv=none; b=A2+oV8KBWgdjsHzcoyj6gKn7rJph4hBTWWeNW/xz/G7FrQ6U79QNHZkg8ACj4manGnKWAPkczGTt3K0vV+VN2XItc3a9dISV+AFgEyMXThKI9QOik++Zx8QMLK3Z0GzgsC0iXLztK11885etaVAF2oTvySJOpo2CvZgKR37kAnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789364806; c=relaxed/simple;
	bh=k/jLuXN0egJkl+RuDIoVDRcHVwABb4ahl7sxOPoZDY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5q8/oqjUBNx9lk5mKjLK0n+KOY3/MD6TW6A6XDjrNyii5tHiDAljKfRfgEQMLEQVNNB7ZvHa9xUTUKM9GBhFr1wGEzOl/WPjnFUJLxMXEXgjzyUNajqR8bMIX+N/6lh1stO0jwka2RPbum/7lkmVjth0z25l8zVS1W6Dy/PRio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=GX5YH3eo; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="GX5YH3eo"
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id 5nYhxqdZMusRS5zWexF3RP; Mon, 14 Sep 2026 05:46:44 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id 5zWdxYKGHadLA5zWexEG2t; Mon, 14 Sep 2026 05:46:44 +0000
X-Authority-Analysis: v=2.4 cv=Aqzu3P9P c=1 sm=1 tr=0 ts=6aa78a44
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=Zo5euW2OAAAA:8 a=Eac8uTGAbMeodF28N9oA:9 a=QEXdDO2ut3YA:10
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=FKmISGsBCPqJ53Kvp3Q4p2bWngpj+u3FfgcCqvkQWbo=; b=GX5YH3eoc5y/
	cIesr7qjeO2tIfaqFjj6d1sF0xR44ShbNkFI8PDImBXqgziH08CaPo+M8fnTYBQvv+fzeZa4oBGZ9
	FPD8S5jZ4V3CXuM0XwDScfFj0G2P/xMMs8nsr/yNRmphZRVUR3ZNSdVUROlU9OQRwCKZ03Oi2aiWH
	w3frKEQRDd2iyIchvu1TtsmcwYmYTDQHGIWglhq1Yt7OvaLLo+Z5KohHEGP3WYi4KZyLWOf7ez/dd
	W0GAebSuhYsTu1kPJ/n9nxxt540C91zhp7mxHS6ofEkQ51VgDM/sOZ/fc3brDZRl2k/qCiezDRm44
	YLyOKTdjDfmjB9wxyE0ixg==;
Received: from flh4-125-195-69-90.tky.mesh.ad.jp ([125.195.69.90]:40280 helo=[10.203.100.11])
	by gator4166.hostgator.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100)
	(envelope-from <gustavo@embeddedor.com>)
	id 1x5zWd-00000003pDO-1F9C;
	Mon, 14 Sep 2026 00:46:43 -0500
Message-ID: <0ed541fe-5583-4cd2-a794-6890478ad7de@embeddedor.com>
Date: Mon, 14 Sep 2026 14:46:39 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtc: ac100: Assign .num before accessing .hws
To: Aamir Ahmed <elb12345@hotmail.co.uk>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chen-Yu Tsai <wens@kernel.org>, linux-sunxi@lists.linux.dev,
 Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
 stable@vger.kernel.org
References: <AS8P251MB00013E724A77A355668B6CCEC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <AS8P251MB00013E724A77A355668B6CCEC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 125.195.69.90
X-Source-L: No
X-Exim-ID: 1x5zWd-00000003pDO-1F9C
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: flh4-125-195-69-90.tky.mesh.ad.jp ([10.203.100.11]) [125.195.69.90]:40280
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 18
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPupwrWu3iEzuLqh0Se8Qi6tcSAZ8NMooesXSddxvyINg5XTbwuDRBByOriaV4CL1OMexpIU27bP34zQrzD2lAI7pwOlnz2moTh4YSZk4GIt6pjg8bXZ
 QLRee64ebkD+Gpah3QvT5eGtrBxp+ql7kVa0Lo20j5cj5lKRS3HmEll/jHQfgLYqZr6njyRGzc2DF56ILlvGtU6yWktbfeK41x4=



On 9/6/26 03:38, Aamir Ahmed wrote:
> Commit f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with
> __counted_by") annotated the hws member of 'struct clk_hw_onecell_data'
> with __counted_by, which informs the bounds sanitizer (UBSAN_BOUNDS)
> about the number of elements in .hws[], so that it can warn when .hws[]
> is accessed out of bounds. As noted in that change, the __counted_by
> member must be initialized with the number of elements before the first
> array access happens, otherwise there will be a warning from each access
> prior to the initialization because the number of elements is zero.
> This occurs in ac100_rtc_register_clks() due to .num being assigned only
> after every clkout clock has been stored in .hws[]. With
> CONFIG_UBSAN_BOUNDS and a compiler that implements __counted_by (GCC
> 15.1+ or Clang 20.1+), this triggers an array-index-out-of-bounds report
> during probe, and with CONFIG_UBSAN_TRAP the first store traps.
> 
> Initialize .num with AC100_CLKOUT_NUM, the number of elements .hws[] was
> allocated with, right after the allocation. That is the value the loop
> counter ends up at on the success path anyway, so the provider's
> behaviour is unchanged.
> 
> Cc: stable@vger.kernel.org
> Fixes: f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with __counted_by")
> Assisted-by: LLM
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-Gustavo

> ---
> Found while auditing the remaining clk_hw_onecell_data users that assign
> .num only after touching .hws[], following the fixes already merged for
> clk-s2mps11 (3e14c7207a97), exynos-clkout (cf33f0b7df13) and
> clk-raspberrypi (6dc445c19050). The audit, the fix and this changelog
> were drafted with an LLM assistant and reviewed by hand.
> 
> Compile-tested only (W=1, no warnings) on x86_64 with GCC 13.3, with
> CONFIG_RTC_DRV_AC100=m forced on the make command line because the
> driver has no COMPILE_TEST option. GCC 13.3 does not implement
> __counted_by (CC_HAS_COUNTED_BY needs GCC 15.1+ or Clang 20.1+), so the
> build only confirms that the change compiles; the sanitizer path was not
> exercised. I do not have the hardware, so this is not runtime-tested and
> no UBSAN report was captured.
> 
> Based on v7.3-rc1.
> 
>   drivers/rtc/rtc-ac100.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-ac100.c b/drivers/rtc/rtc-ac100.c
> index bba7115ff3a..a2f465438fd 100644
> --- a/drivers/rtc/rtc-ac100.c
> +++ b/drivers/rtc/rtc-ac100.c
> @@ -317,6 +317,8 @@ static int ac100_rtc_register_clks(struct ac100_rtc_dev *chip)
>   	if (!chip->clk_data)
>   		return -ENOMEM;
>   
> +	chip->clk_data->num = AC100_CLKOUT_NUM;
> +
>   	chip->rtc_32k_clk = clk_hw_register_fixed_rate(chip->dev,
>   						       AC100_RTC_32K_NAME,
>   						       NULL, 0,
> @@ -360,7 +362,6 @@ static int ac100_rtc_register_clks(struct ac100_rtc_dev *chip)
>   		chip->clk_data->hws[i] = &clk->hw;
>   	}
>   
> -	chip->clk_data->num = i;
>   	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, chip->clk_data);
>   	if (ret)
>   		goto err_unregister_rtc_32k;
> 
> base-commit: 654ae5d73c05bd2943d65636ce6cd0aa46e62f18

