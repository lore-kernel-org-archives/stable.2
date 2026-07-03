Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF76037F734
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 06:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060056; cv=none; b=kty1osESHpCqpLdK0DpLogTF0mTWjDLjTiG54lcFD0Sm3kkBc4ySCntM/3GnWVqfEwZHpQ3bXxpLy0Y/vi3fvcRpGFuJ5zyncjJpMt64Dlwn2RiQ7wyrkZWjK8/5ZaYB+n7x2ANxVaF3Ew2CC1iD7Bu939MXIIiEaKPvl+hxD7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060056; c=relaxed/simple;
	bh=EWc1b5nXZoq0OiHRf8WoqYanyHC84gIAhCmWZlWUj4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9S/2FlFz/bAWdVSb2jWB9BmEzhMm4EY0S8EL5PiCXZLPWi3lidjgkwWnKbYVVAcPSVLzuqFxh3dapf+u8bVtGQV9L2E43tVF6qn4BO10IjeXXfO2WSwR6P2QiXHdkm+8LYuBnToGPWoG0bhTmV4kmzx8e7pxxl+hQ0xxUixfHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iAxtkaHi; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iAxtkaHi"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-380cda7f00cso215029a91.0
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 23:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783060051; x=1783664851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aQ7ByzFqI/4JyRD3MlNQLQW2E98MhssCvFL4d65wbGM=;
        b=iAxtkaHi+DThfFTEqJ2a/XedULzsnKnAe7PSflJK3NoPPqNWuPHdmWBGR/uGEfmGMT
         JehvUqV6xWgbUP1rVkgP/WBYMasOa/3qk6tYg2AXx0SHT8JJk+3+JCsRLRn3plriw2jP
         eOwT/epTkMM3iy5RKJR0N8mFss2BtBS85X7VOd1tbyIFy7rSsCn40RrMA/ltZhwQFCmr
         dAY3YGh66TURjHWo4Hh0XUP78Uzr25MWtKmTiV7BJb0Vs2L1uXfq0dJn3+T5n6kC87Ko
         v17NK13If6a6aggWePfmpfa839KjYMtoVJhtMgYmudXvLKycNkapoHKJcRFF/Fj/juBt
         NbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783060051; x=1783664851;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aQ7ByzFqI/4JyRD3MlNQLQW2E98MhssCvFL4d65wbGM=;
        b=hS7yRA9DfrsUFvW9f/yh3cD4cQOhAWNjAf17xK8Hu/kfW11FLWzM7KuUW6lrrY7nw5
         Q+c5o0NTtflhqXRS1aYvCxb7eupizhAEREAagH8Y7YD43xzQwz7+Uu19oRA7b94ebjfu
         BMET3Eft/e+CIfeoalb/3f6xXF1hZlzCRQKij0RATCPmjMfdfmYU7bHlKGRAIwRxz4Dv
         wngu2u0Cr4QJXJ5E4Z9NHPA1w2VBjy9yMWYS4Ikc0ORf1EqCOvCT4wmy080DXNsOT5th
         dN1I7Xm0VTxwc8nkrA+Od1azFVQr0HCy+gECBTvZJqrv3UCx7yKni7qrbeJ6L/TRx02+
         6EIQ==
X-Forwarded-Encrypted: i=1; AHgh+Rppmn0J9dM4GeTxv5wDVg9zaRU37DxAwz9gTjFOtxKk8x3NDiqysAMxe0ikPnHrhmy583vy+cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqhNEOxokeZ5Jrmpj4i3vNmtqkOGeDHZ9GZPh5W7QKzIQY431W
	f05nwh3a9mjYGhq9gZJnASwXIE6lVidayCRxWYts/6Z3btWYKMUNcCu3PqiKkyVmisw=
X-Gm-Gg: AfdE7cliKWNPIUTSRIHnQBmzk3WLjMX0aMaaMADVDaRWRKdSx5iHFDX9BdqCw2wwY+5
	DcP8ih4ZIYk/c179Lb+9y9cx8AH/UL6+nKJQltb9kU0IbebV9PXhoJpbvxIrZh8fmQYLdBwGBhx
	Q2BX2ICcJYfPb2jQ2clCm2iwoYpuLP2yqV0oe5tWY06Ajdtfpgf+6hXr+Gcx9IO6IqSHdQb4iKr
	nFcYv0jrXXcSMqhg6DneLvnKUfYabwWVHRyZP6toYpCBYK0zIr5ljrBQHgngTq3giTAavtjZEnh
	3uA9kD9PPtoGOTRRrdeIAf4TkUDFsJnWpSox4WLMNjhUYI7ZkkypzVxjh5bzcd73CBijICRaz5N
	zqcKWqDegLeLoOCcRt6WLM5QTgDc8Nr3J4L7t+yAFrBJbrjdF0mkN07oXzYi+txNyLPMx/39n+D
	ZI8L2wQfn7hJld
X-Received: by 2002:a17:90b:3943:b0:37f:b447:def8 with SMTP id 98e67ed59e1d1-380baa8eaf9mr8701638a91.25.1783060050885;
        Thu, 02 Jul 2026 23:27:30 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm15733594eec.8.2026.07.02.23.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 23:27:29 -0700 (PDT)
Date: Fri, 3 Jul 2026 11:57:27 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: sven@kernel.org, j@jannau.net, neal@gompa.dev, rafael@kernel.org, 
	marcan@marcan.st, maz@kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3] cpufreq: apple-soc: Fix OPP table cleanup
Message-ID: <ng7qv3vtfyhzklpbsghkiqezkq2foklddd6huusb5bfsd2xksd@u5hgcjtwnac4>
References: <20260703062049.1459175-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703062049.1459175-1-haoxiang_li2024@163.com>

On 03-07-26, 14:20, Haoxiang Li wrote:
> apple_soc_cpufreq_init() adds OPP tables from firmware, but
> some failure paths do not remove them. The driver also uses
> dev_pm_opp_remove_all_dynamic(), which is not the right cleanup
> helper for OPP tables loaded from firmware.
> 
> Use the cpumask OPP helper after the policy CPU mask has been
> populated. Pair it with the matching cpumask remove helper on
> failure paths and in apple_soc_cpufreq_exit(). This also removes
> the separate dev_pm_opp_set_sharing_cpus() call, as the cpumask
> helper loads the DT OPP tables for all CPUs in the policy.
> 
> Fixes: 6286bbb40576 ("cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
> Changes in v2:
>  - Remove unnecessary cleanup calls.
>  - Remove OPP table from apple_soc_cpufreq_exit(). Thanks, Viresh!
> Changes in v3:
>  - Add Fixes and Cc stable tags.
>  - Use cpumask OPP helpers.
>  - Reorder init and failure cleanup. Thanks, Viresh!
> ---
>  drivers/cpufreq/apple-soc-cpufreq.c | 36 +++++++++++------------------
>  1 file changed, 14 insertions(+), 22 deletions(-)

Applied. Thanks.

-- 
viresh
