Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A6640B383
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781098481; cv=pass; b=XUPCljiyrZr1AE9WC6ViiFnoVEv9c49U41rnZfuVt7Wc4KtskObaaOBp9zAHPcqyblEneFijFauIUAwyPvcdqc+G/2KFEhyvPp8I6XckxMb9TE/jJFDG5wHyLtPDobFZ/ajznbSOXhVytCyUIc3Ix48v8pHQAstOQ2FkrREjl3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781098481; c=relaxed/simple;
	bh=JAR4sei5juO8181/3mmsMW50Yqk1AXNa41CYDKywtHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxsr1xCGNgRjCY+5f88m9P1MHc5LNDnnRTxGz2RFZQ66xbl29TuqBrBzPoLivyk11ibpwKPboPTJNXb5hK+ik3R93+UMI5DZTDv4m4qc5lcnO8AGuP0IP45ug+P563NRo3NYZqQ7lxdxJ60M9WSWb0FU8xRX7TAdnd9xGc6PsJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r65yP2o4; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r65yP2o4"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-68c76fb8009so8912988a12.0
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 06:34:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781098473; cv=none;
        d=google.com; s=arc-20240605;
        b=UsG5HgA5CZAuiGQHx7ZDJinOh8LR/Pt4sBR3XtyowROFfn+hgOwk6jpUPMSG0hCQgS
         Dd4HrBSLlOqv+6F3AYRKdIIX55sFLHTSWb8cPKPh4r9cqR9NlbpUHtc3kV052TFyq0Pw
         Mt4tXFyDTr6kdq47fnmqIND7DEXfumrupVvd35Pjhq8xeKP51lf5E9BvwAe8fPPK1J1D
         2zM615I5puBTq9iqVFWtDNLAirE6AzuG3eLJ37gb4g7IJF3eogSFwTNq4zFVBSTa+j+a
         dTTcR/2N7WE1pJ8t52Hy04e2hVl+ksmgdVTcxMF2BGFzr9RTUrfY4GzyH7y6E/xrBx61
         qKLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wusSRoPz5XHuYf/hgRAbVTth3meUxSSzw6AAFjCcAZ8=;
        fh=pYZ/3hErvW3I9OL3ZngbA2pq/Vd7bU7PjjDYEO5Klz4=;
        b=k260XXy0dClkGyoDQ24+avA9Oq/Xjz/o8dPHHJsd71wmrM/+crjL107QaMOZHf2G98
         MvjmvVbHUfiU+8VT/9oj8N59sL81QQwKRlda67ZrO4HJtOjnoVKG9Ci6HOdoq7NuNkKG
         vljVHx1pXPT0Cvc2Z+sxe8nisZ/I423/CW0mvl+abG4JOhwLYapBWG3tWuawxuIOOtwL
         od0mj50hyIB4IJ8AM7NYVWWYZluY4dS+r6CWXEPgjE3qg38G6zKS8cV6e7YiAhZbYCTI
         MSN6fcMcrN9IzuvG5eIreCKa2oId2ZkjYDwDzKNl0hKggB/bWgqVku/BR6Ciko2WxwI7
         7r/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781098473; x=1781703273; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wusSRoPz5XHuYf/hgRAbVTth3meUxSSzw6AAFjCcAZ8=;
        b=r65yP2o4m6EbvApoz6B9olIJyccqqM+nsr9La+vvKTORiM9dhjL+w8m31GYAsnJr+m
         DpZRmHfMImMwwa5BsihxuKsmVYxTcP25BVyyMB9Q9k/wertyodkhP5KFNb6umUoG+XgW
         5Bnnx/FkW/oii78eVtgvjthXKAy6Qo1GjtU78Ypix94oqFc8srX5iI11fZsAWTJk5XTz
         mV1d3D2GJPHp16g74gjP/ZxSS6p9wt2E0LqBHCGkwTmoBrIp3ez0mY5WGnzor+0QH0B9
         dOFFuS7gty6/1yUkWPgxbOuvFThtifc0bA/154DG/Y0PIuDIK1kPK6eUIwUCsrIcHas6
         lM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781098473; x=1781703273;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wusSRoPz5XHuYf/hgRAbVTth3meUxSSzw6AAFjCcAZ8=;
        b=VsSrQWmc4Nnve1XtjbzRgg30gwSBQzoP/NnOTE6hKaAFEj/4BowAn3SPM8nMHW5+N2
         3u5evNlvqmnuAEhVrOCSpGigHm3IayVhmeMTZKvqWoca/pa8Lzh9bgQEv7PqQb4f4SOm
         4FooalNQM+zS2ym/baCS9jdeEURamPfcKLDpZPJJUOea2uOt9AgJRThA/vqUAFmh2W5/
         DTnsLZ0ESqVxXy1xEfEGhBoGrrzuKg4sxdmPhdyvJoS6LG0anVuIEo/vuAPcYEKm1X9R
         2qyzHa2hSifItvDpn1GhETOscc1SlN1PV6ldhTArkvhNNjAolqERc7pqK2M5ArB1Ibq4
         4COQ==
X-Forwarded-Encrypted: i=1; AFNElJ+MLbET9lNGFwSqTYXRzM33YtuK7JJre9RF1neaRYTPNo28NFZl7/E/eNV2hB7tQ6KoCdGAoh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWYCWs7iuPT/QcTILOJrF8dwDpYjLBz4A01uo/iqG0XAjm8FF2
	jaBGFf9uZ+A/U5kpP5yxcbJPKqGOnpOgJp39kbyyJhoX8Uu26iZUyDOC9Fr3rf3GmoIO+sAS1zR
	uw492qSj6oIN95byqYslIybZ8TZ6g2FiapWbPDMwo1w==
X-Gm-Gg: Acq92OFTVMluwyMTKwSRDNo68x2f8Q2ICCGEVaXbfjpmM0NbcEzrFxIsUQPepODT6Tn
	AwAfa/JA4QFcSr1F82j8OchL7HbXYuOn3lfbHhA7T/Yj/Sqlcxs6qRONTW0LvWxrTMeTXRb0PNn
	sRxfpwZgUqJa7uMDgScZoB7rkkan0yWk2f07ma3Ff8unG+Iq3euJcxyTbkhvceXOKiGniYVN5Nl
	9rdZMAAvsHzGCCPQPHK4W9NEK54wcx4sejS82C+GaaVDanuEAtmM3Wogiz5Hq33ytSo+X+P/AYf
	4fB56sENDKXLns7sQQmhKfXY1+wOVUOS609Xo3LjeKNNni8CFury
X-Received: by 2002:a05:6402:3905:b0:68b:f026:f381 with SMTP id
 4fb4d7f45d1cf-68fa4e3140bmr11010010a12.8.1781098473183; Wed, 10 Jun 2026
 06:34:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605-exynos-pmu-cpuhp-idle-fixes-v1-0-0cd05c81a82d@linaro.org>
 <20260605-exynos-pmu-cpuhp-idle-fixes-v1-3-0cd05c81a82d@linaro.org>
In-Reply-To: <20260605-exynos-pmu-cpuhp-idle-fixes-v1-3-0cd05c81a82d@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 10 Jun 2026 14:34:21 +0100
X-Gm-Features: AVVi8CdudhNuk1JulHq85Six9g2TTnXsPBjPVrWOLueCdeIJGpUeMcdSZ2qVZRE
Message-ID: <CADrjBPq4fou5KWh4T=oNkUVPz5Jk-821OVe3j5sWrKnCtHYM6w@mail.gmail.com>
Subject: Re: [PATCH 3/3] soc: samsung: exynos-pmu: fix error paths in
 cpuhotplug/idle states setup
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Sam Protsenko <semen.protsenko@linaro.org>, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Alexey,

Thanks for your patch!

On Fri, 5 Jun 2026 at 21:19, Alexey Klimov <alexey.klimov@linaro.org> wrote:
>
> The setup_cpuhp_and_cpuidle() initialisation sequence currently ignores
> the return values of cpuhp_setup_state(), cpu_pm_register_notifier(), and
> register_reboot_notifier(). If any of these registrations fail during
> probe() routine, the driver returns 0, leaving the driver partially
> configured.

I originally made the failure non-fatal because the system still boots
without the notifiers registered (and all other Arm64 Exynos SoCs
upstream don't register notifiers and AFAICT have broken cpu hotplug
and cpu idle).

In hindsight, that seems like a mistake. I think your patch to fully
unwind everything in case of failure makes more sense.  See small
comment below about destroy_cpuhp_and_cpuidle()

>
> Furthermore, if anything after setup_cpuhp_and_cpuidle() fails in probe()
> routine, for instance devm_mfd_add_devices(), the probe() lacks an error
> path and leaves notifiers and cpu hotplug states registered.
>
> Introduce variables for the cpu hotplug state IDs in exynos_pmu_context
> struct, that should be initialised to CPUHP_INVALID by default. Check all
> return codes in setup_cpuhp_and_cpuidle(), and add an error path to remove
> registered states on failure. Finally, add destroy_cpuhp_and_cpuidle()
> helper to safely tear down notifiers and cpu hotplug states.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260513-exynos850-cpuhotplug-v4-0-54fec5f65362@linaro.org?part=3
> Fixes: 78b72897a5c8 ("soc: samsung: exynos-pmu: Enable CPU Idle for gs101")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>  drivers/soc/samsung/exynos-pmu.c | 57 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 49 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
> index 9636287f6794..846313a28e9a 100644
> --- a/drivers/soc/samsung/exynos-pmu.c
> +++ b/drivers/soc/samsung/exynos-pmu.c
> @@ -38,6 +38,8 @@ struct exynos_pmu_context {
>         unsigned long *in_cpuhp;
>         bool sys_insuspend;
>         bool sys_inreboot;
> +       int cpuhp_prepare_state;
> +       int cpuhp_online_state;
>  };
>
>  void __iomem *pmu_base_addr;
> @@ -404,6 +406,17 @@ static struct notifier_block exynos_cpupm_reboot_nb = {
>         .notifier_call = exynos_cpupm_reboot_notifier,
>  };
>
> +static void destroy_cpuhp_and_cpuidle(void)
> +{
> +       cpu_pm_unregister_notifier(&gs101_cpu_pm_notifier);
> +       unregister_reboot_notifier(&exynos_cpupm_reboot_nb);
> +
> +       if (pmu_context->cpuhp_prepare_state != CPUHP_INVALID)
> +               cpuhp_remove_state(pmu_context->cpuhp_prepare_state);
> +       if (pmu_context->cpuhp_online_state != CPUHP_INVALID)
> +               cpuhp_remove_state(pmu_context->cpuhp_online_state);
> +}
> +
>  static int setup_cpuhp_and_cpuidle(struct device *dev)
>  {
>         struct device_node *intr_gen_node;
> @@ -465,16 +478,42 @@ static int setup_cpuhp_and_cpuidle(struct device *dev)
>                 gs101_cpuhp_pmu_online(cpu);
>
>         /* register CPU hotplug callbacks */
> -       cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "soc/exynos-pmu:prepare",
> -                         gs101_cpuhp_pmu_online, NULL);
> +       pmu_context->cpuhp_prepare_state = CPUHP_INVALID;
> +       pmu_context->cpuhp_online_state = CPUHP_INVALID;
>
> -       cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "soc/exynos-pmu:online",
> -                         NULL, gs101_cpuhp_pmu_offline);
> +       ret = cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "soc/exynos-pmu:prepare",
> +                               gs101_cpuhp_pmu_online, NULL);
> +       if (ret < 0)
> +               return ret;
> +
> +       pmu_context->cpuhp_prepare_state = ret;
> +
> +       ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "soc/exynos-pmu:online",
> +                               NULL, gs101_cpuhp_pmu_offline);
> +       if (ret < 0)
> +               goto clean_cpuhp_states;
> +
> +       pmu_context->cpuhp_online_state = ret;
>
>         /* register CPU PM notifiers for cpuidle */
> -       cpu_pm_register_notifier(&gs101_cpu_pm_notifier);
> -       register_reboot_notifier(&exynos_cpupm_reboot_nb);
> -       return 0;
> +       ret = cpu_pm_register_notifier(&gs101_cpu_pm_notifier);
> +       if (ret)
> +               goto clean_cpuhp_states;
> +
> +       ret = register_reboot_notifier(&exynos_cpupm_reboot_nb);
> +       if (!ret)
> +               /* Success */
> +               return ret;
> +
> +       cpu_pm_unregister_notifier(&gs101_cpu_pm_notifier);
> +
> +clean_cpuhp_states:
> +       if (pmu_context->cpuhp_prepare_state != CPUHP_INVALID)
> +               cpuhp_remove_state(pmu_context->cpuhp_prepare_state);
> +       if (pmu_context->cpuhp_online_state != CPUHP_INVALID)
> +               cpuhp_remove_state(pmu_context->cpuhp_online_state);
> +
> +       return ret;
>  }
>
>  static int exynos_pmu_probe(struct platform_device *pdev)
> @@ -548,8 +587,10 @@ static int exynos_pmu_probe(struct platform_device *pdev)
>
>         ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, exynos_pmu_devs,
>                                    ARRAY_SIZE(exynos_pmu_devs), NULL, 0, NULL);
> -       if (ret)
> +       if (ret) {
> +               destroy_cpuhp_and_cpuidle();

You only want to do this if pmu_cpuhp == true, as currently only gs101
registers the notifiers.

Thanks,

Peter
