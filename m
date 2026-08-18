Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3796F384CD5
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 23:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787095086; cv=none; b=K3rNHIea8U1i/ScACohFmd8TKsA6YBmWezVGm/BygqdvEEsBJIFAw9rtRzp6sAbm9lCkEU7cnd6BPigvR+gyx3xlwBW2fK5WSvCZconHhEJBTpNIBCSrIwvLA3HyUDUVpKapfgRsrzgFdqC7SB1c9liMU3GDFB+2zcQwmZlJWI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787095086; c=relaxed/simple;
	bh=a8IOTYHpzARDBkDXw7Oai/tzL+r3gsDh+8SANcfGXjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZfUrZJMsOnHgxPB31luhfuepPVI3LXdHvXPF7pWOoWGecrfWpibg2r3/dwPniiieSJbWcMSNHNNG0sNuVZaexuSn8brhqMb3CNgVfqjGCRVjL2Y8xLA8yboBkEFMQtOqbBzsZoJbm5aaRiIxzHz4G5FHdiGJWn09eIOcuHD7EIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CGNmYkqK; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CGNmYkqK"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b2a73d5fc3so40884e87.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 16:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787095082; x=1787699882; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=azicBGUhuLKBlVAXIqSFD4EKWplTYg8gpsiCO/t2g/Q=;
        b=CGNmYkqKQWoKGH41Id2BAn7W9SO5PFWE/QIFxaclbUx3fZJiZSciMddLrVApf7/nYo
         EZZV7oqBqEUhXu2Y/lL5n3uqw8ByTxjAmT19Hs9+6+glt7zKHN2BbJxjywX+YcsrXLBr
         csA+Xt5xDYlCM8I6U0FpLBmLaE6PC/xj+9ZuFGVT9YQNE5MQsYioFvS44VoVoQIadBox
         ME0IslyHnd1Uv46o0LGmFerfwZSJ805gDaKuwfvITN4Gj37z8kLNs5Ba6hBDEuu3AtzG
         lhHFNi/eaZZ7RzpPGlAz0UXgPsGgPz6wgL+eJR4ioLfFbsjoiv2frOAlq0czNsrgsNBd
         /inA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787095082; x=1787699882;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=azicBGUhuLKBlVAXIqSFD4EKWplTYg8gpsiCO/t2g/Q=;
        b=UFVBk/2bPyxyKNfCuCnqzRY2FpNhJk4QsihkeaQvvjTMd92I+evxnlM/KU4TFQZDd1
         Z7Z69OCeJ/lNKfgJcDNN0w3sRGBzSs45/EjiObUYeu1BU5ReXWLL/jnzIw7zsihuCi4M
         Lg+y8pyH1Ulp5h9rb66SwBqqAj0iZ8hRZjt3wcyNcHO0rmuoHtt10N62vzz6KUrsb7ID
         x0MzEgFEDEncwBiesPikkOLFrIhKrUhj6VS1B9lMMfP1ajuQvj+YHRd6yu5FsJ7eDge9
         8KhBfg6HYcQzTX+KteCMUNElF3l2P6z+v+ZX/aKvapPsn8rG2sJOIKGUkLi5+e1ipPn0
         14NA==
X-Forwarded-Encrypted: i=1; AHgh+RqnLQYm/6BnZRbIvA6kegsRRtBgzmWU9ceFvjkEDT0JzoqFA/qs00mHYSu5l7vVwP6lEA3mDOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw62d8wSLqcKwADwadrYmUGPnqy7ZFfvgDOpffNREPrec8VWsNI
	4Nza+yEnQGw3Yrv/stFzmG0H2MiyGhA5ZoqflaQgMVety/eR1SCn2JnbOLxx8l3SiqU=
X-Gm-Gg: AR+sD13Z/uwBvY8Ri5O+1BAjeTo2MOG6Uq6FxUnpJRe3gGGcPILpm5qOYPg/c6nFXZN
	/UmxGQ+P8erXX/wkdTYf0NtgnjNiNTmZfibo7gzQBEkZANySI21vsTyGy5mCkCBg59jpoZWzeay
	Kkp+0bhHhhY7X4zh5G73KhINlrdSikKr7A9tnegft3rlAuLlgTEWdQO04navZFjv2pbqx+i1Ifp
	65wbhOBWw8sDSSL0Az+JvLCyRX3IEbpke6DHTAgl0mQ8DcZS0YLrnQGq4NipuYBvT4TLq2iVIEO
	2pinIlqzTXJ6fwXDcFRJZ3T0Km6M03I7ZdnIp6r1qiSrPrP3rMGAe0sJ8820vuC7+rDs6WjpppO
	PZb53T5emBmv6KL1V7rKdfbRhT6jBFnC1SI4BNkydQramoGixbb1NplGTya5TrrR/gwIaE3B3ds
	lo9hkLZESqVcNxLbsNU8DtoRoNvkEJMvVMGI7gd9HwBGxFn+2KK+7l/ifhO4WbO+NqgZcIaDZFX
	O1QaeFzTLHrb9lbSTUdWvkA7aytl+PJW/vM1Esq2Q==
X-Received: by 2002:a05:6512:31cf:b0:5ae:cfd3:4753 with SMTP id 2adb3069b0e04-5b478bdf314mr34845e87.3.1787095082233;
        Tue, 18 Aug 2026 16:18:02 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b47885ac3esm59601e87.28.2026.08.18.16.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 16:18:01 -0700 (PDT)
Message-ID: <db94c578-2bfb-4297-9955-fba690ecfe39@linaro.org>
Date: Wed, 19 Aug 2026 02:18:00 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: qcom-cci: fix device_node refcount leak in
 cci_probe()/cci_remove()
To: Liu Zhenlong <dragonliu2018@gmail.com>, linux-i2c@vger.kernel.org
Cc: konrad.dybcio@oss.qualcomm.com, stable@vger.kernel.org,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Wolfram Sang <wsa@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260815140931.53297-1-dragonliu2018@gmail.com>
 <20260818175750.4205-1-dragonliu2018@gmail.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260818175750.4205-1-dragonliu2018@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Liu.

On 8/18/26 20:57, Liu Zhenlong wrote:
> The of_node_put() matching of_node_get() runs after i2c_del_adapter(),
> whose trailing memset() zeroes adap->dev and thus adap->dev.of_node,
> making the put a no-op and leaking the node on every adapter removal
> and error cleanup.
> 
> Use a devm action: the pointer is captured at registration, out of
> reach of that memset(), and devres runs the put once on probe failure
> and detach, replacing the three manual of_node_put() calls.  The
> setup loop uses the scoped iterator form so the child node is released
> automatically if devm_add_action_or_reset() fails mid-loop.
> 
> Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Fixes: 02a4a69667a2 ("i2c: qcom-cci: don't put a device tree node before i2c_add_adapter()")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Liu Zhenlong <dragonliu2018@gmail.com>
> ---
> Changes in v2:
> - Rework the fix to use a devm action (cci_put_of_node) instead of
>    caching the pointer before i2c_del_adapter(), per Konrad Dybcio.
>    The pointer is captured at registration, out of reach of the
>    memset() in i2c_del_adapter(); the three manual of_node_put() calls
>    are removed.
> - Use for_each_available_child_of_node_scoped() so the child
>    reference is released if devm_add_action_or_reset() fails mid-loop.
> 
>   drivers/i2c/busses/i2c-qcom-cci.c | 20 +++++++++++---------
>   1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
> index bdeda3979c48..d3528c7d15bd 100644
> --- a/drivers/i2c/busses/i2c-qcom-cci.c
> +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> @@ -497,10 +497,14 @@ static const struct dev_pm_ops qcom_cci_pm = {
>   	SET_RUNTIME_PM_OPS(cci_suspend_runtime, cci_resume_runtime, NULL)
>   };
>   
> +static void cci_put_of_node(void *data)
> +{
> +	of_node_put(data);
> +}
> +
>   static int cci_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> -	struct device_node *child;
>   	struct resource *r;
>   	struct cci *cci;
>   	int ret, i;
> @@ -516,7 +520,7 @@ static int cci_probe(struct platform_device *pdev)
>   	if (!cci->data)
>   		return -ENOENT;
>   
> -	for_each_available_child_of_node(dev->of_node, child) {
> +	for_each_available_child_of_node_scoped(dev->of_node, child) {
>   		struct cci_master *master;
>   		u32 idx;
>   
> @@ -537,6 +541,9 @@ static int cci_probe(struct platform_device *pdev)
>   		master->adap.algo = &cci_algo;
>   		master->adap.dev.parent = dev;
>   		master->adap.dev.of_node = of_node_get(child);
> +		ret = devm_add_action_or_reset(dev, cci_put_of_node, child);

I believe the new cci_put_of_node() and the original of_node_put() functions
are type compatible, therefore a function type cast could be sufficient here:

    (void (*)(void *))of_node_put

In any case the change seems to correct, thank you for the fix!

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir
