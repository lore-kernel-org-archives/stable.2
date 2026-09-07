Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0AE1B4223;
	Mon,  7 Sep 2026 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788775764; cv=none; b=YPq7KC5xmGmlVIR0eLSS8Nm/Rv13ocx62BTEAFnCifn/ApEihGE6DkFaioY76q48N3T00hlaYFIMS753SMd1iSbt7sdZk3WKDuu5YZ3NoDXzznYfNzB6updh6tBpseRwlRR8GBg+lHFdd/EE2BegbBMKaFWoSuiJeEPqHb6ARIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788775764; c=relaxed/simple;
	bh=XXCsDfSpHfp2qMLmaVff7IRwmidp86hpL8OQLEAnHtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qs2xHjQb5a8GRl062oB2Yans0itoLYmBHZLwaLR6JgHcmS2mX33/RyDDyxtvXmafFKTgkTwGUK6sSO4/eiIjD24wytVPqGsVlsCl56rPHcdCyaGTumzMVMZDTjvLNfc7XuJGAlmkWfvZlWu0HhJaDrSNWBV3ibAC2Stqwh1JKL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLlRFpeY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLlRFpeY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B704C1F00A3A;
	Mon,  7 Sep 2026 10:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788775763;
	bh=qhJA8Or/+/T3bGys3Jk97Qnf5oxFzx7dGhBzGbr1Nzo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fLlRFpeYX2dNBGvqN+Cx+8/sp1e1AevQOV0E7KiiiH+LcYx/j1TWmElRrEVw2KSfI
	 0ME8WT8hu4uTvC7vuP1FzAF91rnK7s0dFyGy+FvxVOzV4vAk4z0ndTO1/66i7n6Que
	 8Tv3Mz1/SK1WKt9A7whK7lLQ3fDP11O/V4QXWggTTIIQtni1XF4n0jV8Q8MWBGXw44
	 l6LloQ72Z5l67vA3SrC2C3jURzi9txN1BwR8iC1RVJnjDssanOk0OVkqbH6eHQFh4+
	 dnibRCMbkQhkdGN8isTVxXFOgDdGtGEjUtoiCdr276K5kTf2mz8dMrSq9qJaa5qHqk
	 71vK+6+SD3MSg==
Message-ID: <dbdfebba-aa6b-4ea9-b4d6-5e0ef63d8716@kernel.org>
Date: Mon, 7 Sep 2026 12:09:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] soc: samsung: exynos-pmu: fix error paths in
 cpuhotplug/idle states setup
To: Alexey Klimov <alexey.klimov@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>
References: <20260828-exynos-pmu-cpuhp-idle-fixes-v2-0-06bce6107bd6@linaro.org>
 <20260828-exynos-pmu-cpuhp-idle-fixes-v2-2-06bce6107bd6@linaro.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260828-exynos-pmu-cpuhp-idle-fixes-v2-2-06bce6107bd6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/08/2026 07:36, Alexey Klimov wrote:
>  void __iomem *pmu_base_addr;
> @@ -407,6 +409,17 @@ static struct notifier_block exynos_cpupm_reboot_nb = {
>  	.notifier_call = exynos_cpupm_reboot_notifier,
>  };
>  
> +static void destroy_cpuhp_and_cpuidle(void)
> +{
> +	cpu_pm_unregister_notifier(&gs101_cpu_pm_notifier);
> +	unregister_reboot_notifier(&exynos_cpupm_reboot_nb);
> +
> +	if (pmu_context->cpuhp_prepare_state != CPUHP_INVALID)
> +		cpuhp_remove_state(pmu_context->cpuhp_prepare_state);
> +	if (pmu_context->cpuhp_online_state != CPUHP_INVALID)
> +		cpuhp_remove_state(pmu_context->cpuhp_online_state);
> +}

cleanup follows the setup usually, so this function should be after
setup_cpuhp_and_cpuidle().

> +
>  static int setup_cpuhp_and_cpuidle(struct device *dev)
>  {
>  	struct device_node *intr_gen_node __free(device_node) =
> @@ -458,16 +471,46 @@ static int setup_cpuhp_and_cpuidle(struct device *dev)
>  		gs101_cpuhp_pmu_online(cpu);
>  
>  	/* register CPU hotplug callbacks */
> -	cpuhp_setup_state(CPUHP_BP_PREPARE_DYN,	"soc/exynos-pmu:prepare",
> -			  gs101_cpuhp_pmu_online, NULL);
> +	pmu_context->cpuhp_prepare_state = CPUHP_INVALID;
> +	pmu_context->cpuhp_online_state = CPUHP_INVALID;
> +
> +	ret = cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "soc/exynos-pmu:prepare",
> +				gs101_cpuhp_pmu_online, NULL);
> +	if (ret < 0)
> +		return ret;
> +
> +	pmu_context->cpuhp_prepare_state = ret;
> +
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "soc/exynos-pmu:online",
> +				NULL, gs101_cpuhp_pmu_offline);
> +	if (ret < 0)
> +		goto clean_cpuhp_states;

You have only one state to clean here, no? Error paths must be specific
- clean only what's needed, not a catch-all with if-checks.

>  
> -	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "soc/exynos-pmu:online",
> -			  NULL, gs101_cpuhp_pmu_offline);
> +	pmu_context->cpuhp_online_state = ret;
>  
>  	/* register CPU PM notifiers for cpuidle */
> -	cpu_pm_register_notifier(&gs101_cpu_pm_notifier);
> -	register_reboot_notifier(&exynos_cpupm_reboot_nb);
> -	return 0;
> +	ret = cpu_pm_register_notifier(&gs101_cpu_pm_notifier);
> +	if (ret)
> +		goto clean_cpuhp_states;
> +
> +	ret = register_reboot_notifier(&exynos_cpupm_reboot_nb);
> +	if (!ret)
> +		/* Success */
> +		return ret;
> +
> +	cpu_pm_unregister_notifier(&gs101_cpu_pm_notifier);
> +
> +clean_cpuhp_states:
> +	if (pmu_context->cpuhp_prepare_state != CPUHP_INVALID) {
> +		cpuhp_remove_state(pmu_context->cpuhp_prepare_state);
> +		pmu_context->cpuhp_prepare_state = CPUHP_INVALID;
> +	}
> +	if (pmu_context->cpuhp_online_state != CPUHP_INVALID) {
> +		cpuhp_remove_state(pmu_context->cpuhp_online_state);
> +		pmu_context->cpuhp_online_state = CPUHP_INVALID;
> +	}
> +
> +	return ret;
>  }
>  
>  static int exynos_pmu_probe(struct platform_device *pdev)
> @@ -541,8 +584,12 @@ static int exynos_pmu_probe(struct platform_device *pdev)
>  
>  	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, exynos_pmu_devs,
>  				   ARRAY_SIZE(exynos_pmu_devs), NULL, 0, NULL);
> -	if (ret)
> +	if (ret) {
> +		if (pmu_context->pmu_data && pmu_context->pmu_data->pmu_cpuhp)
> +			destroy_cpuhp_and_cpuidle();
> +
>  		return ret;
> +	}
>  
>  	if (devm_of_platform_populate(dev))
>  		dev_err(dev, "Error populating children, reboot and poweroff might not work properly\n");
> 


Best regards,
Krzysztof
