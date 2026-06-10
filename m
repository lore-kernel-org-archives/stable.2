Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FA03BA249
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781085368; cv=pass; b=ObS2FyKBXNXAN35WWaliSOctbdJ0JKAkDBGmtHxniLpPlyXRdQdUn1DgBEKQN9xTFxMcR1ps9coNF6NTghy64F6GiUsp0gxkV8ezDX7Ppot3ree0OrHKkCpKxs39ZJIxl2knY1dAPe76I0B6thCpyWy0eXuFna5+zM+YIhJz7eI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781085368; c=relaxed/simple;
	bh=hZNp1wzl7aMol0obQLeujStExhwYmp321tYBENr5gfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ngtFgSgJJSwo/8vTlaJVUySiRycKQoCR0ZLNFLVbV/PO2WnAmha2jOVJL53aY+LJc6ZpS7NNmxVdkyCd8GjO3ikUCqNwXMdsmAnThsQTEJmTu2y4MIaQgu5ec+ZEBHsdp+AMwQtTtlcnhJC06ZJ4NHoxVs7sDbfFE0rM7de8IfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LJyl9nYe; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LJyl9nYe"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-68d233bf083so9349554a12.1
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 02:56:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781085365; cv=none;
        d=google.com; s=arc-20240605;
        b=D2gHKTrLGtCyputWenTpGGbUlUwRb5j980s176g2+eR1d1nrOqZU1WedkWoBPamd47
         0FCe8J6lG+FW6Q4AJh+VxD4zgreXKJKTJoeky6j+1oTX+iNvgf8wHcmWOjz4hf2Eb/mS
         vXZR8BttrT9vNAL4abmDxHe+AzB0OSNakoDdoGehEk+VoI9aOX0K1fbjRr/Hf+Mnn13c
         SQCOPOJ2n2GoLEZDQ0Vo9A9H7co/mUcs9S6MLuUH3lGgKU9is/NDjhiI8G80NjhHuJ78
         NMX9GRn62Pzkghj0c0NYwWUQa6c8O76QWygsV44Di8Ltz5mZ5X15iwkLdVVVWGjzJMw4
         wblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CmlGB8tR+Cv/jqDrTQc1t9bnzwkfYB6t+ePs6hjw60w=;
        fh=Sbjaih/ws+KdgfpxA7OGzEQAtarDjwdHVO6Qq0c4H7s=;
        b=a/PeF0CAZkDn9U1WS965ZJINebotDU+ueRYttUwXGsDnc+9REZCoG4AILAptc3FC7Z
         Mj0YIoGFQbv2P5nG5jT2tiYOUB69/OzABh3G6Mc7B2PFAMO49i9kaEQu3pCmLlB5ZNc3
         kDp8GmVlGkxYi+3j+dm3nzBQkOrl7U9ypsj0SgHbCU7RE272yuJxygC0mfCIkzc5ljgF
         nqU14xevzI0EGfMcH9Qf94Ww7kbTJtRqLK3sZZVMI+pJNGCsGY+h3J70t5dlHueUd2oI
         l7ZD82cxKulconMV3KcrMtANuz+wRxWgCGeiqrLgUgxLZzS6N8Am1yS8afD0KyFJzDko
         /qOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781085365; x=1781690165; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CmlGB8tR+Cv/jqDrTQc1t9bnzwkfYB6t+ePs6hjw60w=;
        b=LJyl9nYekUQk8o5/09+acieQM8M72nvIR6T8Iy4gh+Q2qH3MQuqgJIXTS80vqnNYh7
         TBWLPZfdCxfHIwqGPf1dI5dDlIkNWLb7QTpkJSEtd3bFJmlSY3xb/TIZGB8sPQQm/Nhv
         iP/gvzutuRHm7N2/kIjbyFXFnzIEftqpQk2ySUVqQ2kyc9SBXy69jeRAi9xmjkLCSsvO
         7Ipdemze8b577dmaOXNj1GH1qoC2NMqAE0OnK2BXwppSR4I23dVCbbc+fPkkLceAXcW3
         sX8/G0oIfCnK3aQEBpNxVjt70CwwV+Mimu2tp/SGJ9Oqdvw9Ke9S0JN4gzMd0tBfpZXf
         nurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781085365; x=1781690165;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmlGB8tR+Cv/jqDrTQc1t9bnzwkfYB6t+ePs6hjw60w=;
        b=ILIJ1YF+mYs693veGDs4wmYDW+rUc1JbxDdP3b8rVaG7lB+Bp9Ot+19TpU16C7qHls
         C8QhvWzAXVyCZ5/ysKae1pxWxHUGq5890UcrqV61cYovt6D6Pbn4DLgy1JCcXQExcE8m
         IAdIamzEs1jZVuy2G6u5q8HJdY0VEsFKtJd5x+rQnJf7VpyK1T2jXafGz0CFfMcr8FQc
         gMNJk1BcZgLHTmzzYdcIiCtoW5yCSbaFVBnttEz1t9UcEmqHk2Z7r6PGXIh8TuQ25ulc
         YQLV+yxBMx5ffYAXNPzYQ4uwtqzCcixFBeOlVNrZW/lnr0670rPNgnNCzBtm4H3ONzl6
         IXCw==
X-Forwarded-Encrypted: i=1; AFNElJ+YvU+s8WwT3v+Q6U3nIgDV/j/+1b45UlONunQ/ndXHs/zp43NQjzEU423sAoTLOqzM/ggHdxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnSOn6Q6r56FJgCSFBMKMgs8XPyVAuWM9rho7Xq4pqJNvSxMom
	kDhmU38o31ujOCoDLvoDAZ/sox3Ieot/6eZkGLAo8mZcaMZ7Y83y8ekYIRnxuUIG2RCBc6RetiJ
	yYufEkGl3byvfHNjFWm8n6gjrxX6pheUE0DyTq+jFuxFPajRBS+/0WJw=
X-Gm-Gg: Acq92OHOXmoZjVx3E5hP6Gt5uu9eaSsljjcq1MuOGCURvT3idFP7A8zUrP3BHUzqbdX
	hAcvspZXEmdL3rM1ZuZVOpKlewwDqoVDp9FfZ+MWou3o2VanQOH6SUsTdzPO8aGwVG4Y4hgjrDd
	gfM0fjUoALSkG6hv1Idt04iyltLhQ0p4KA5Kg3MSV8EbKsXdHGYcwkpjtgrRzY+iZL/Xkmd5SiK
	95CmLs+cOH7ivWCOdpkZ1wQdC5ZN4ySXorcIMFqwrqoKqQPtcsUTYqORWkIVE4E2qZDQX8iwsOA
	qbpw54lDQbgtZjhVJMAdKDV2kXbS8ZZwTQoCA3WWX+dwmOGXyN35
X-Received: by 2002:a05:6402:26ca:b0:68e:66da:c39c with SMTP id
 4fb4d7f45d1cf-68fa52595a9mr11429014a12.24.1781085364631; Wed, 10 Jun 2026
 02:56:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605-exynos-pmu-cpuhp-idle-fixes-v1-0-0cd05c81a82d@linaro.org>
 <20260605-exynos-pmu-cpuhp-idle-fixes-v1-1-0cd05c81a82d@linaro.org>
In-Reply-To: <20260605-exynos-pmu-cpuhp-idle-fixes-v1-1-0cd05c81a82d@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 10 Jun 2026 10:55:51 +0100
X-Gm-Features: AVVi8Cefu1n2MWDEUi6aR9N7alNw0lKukQb9HTmuDkQk8K2PjK6RnQfXSI6M9T4
Message-ID: <CADrjBPoDC68jyEY2HZtoh1SLfVwFPpzKea7T6QLyfY99MsNVcQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] soc: samsung: exynos-pmu: use target cpu ID in
 hotplug callbacks
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Sam Protsenko <semen.protsenko@linaro.org>, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Alexey,

Thanks for your patch.

On Fri, 5 Jun 2026 at 21:19, Alexey Klimov <alexey.klimov@linaro.org> wrote:
>
> The CPU hotplug state callbacks __gs101_cpu_pmu_online() and
> __gs101_cpu_pmu_offline() currently partially use smp_processor_id() to
> determine the target register offset for the CPU inform hints. This may
> be fine for cpuidle flow but broken for cpu hotplug where the target
> cpu is passed as an argument and could be different from cpu where
> that is executing (e.g. CPU 0 offlining CPU 1), meaning that
> smp_processor_id() returns the id of local CPU but hotplug flow
> deals with another CPU core undergoing the transition.

This was intentional. The powermode hint is always programmed based on
the currently executing CPU core in the gs101 downstream code (for
both CPU Idle and CPU hotplug paths). See
https://android.googlesource.com/kernel/google-modules/raviole-device/+/refs/heads/android-gs-raviole-mainline/drivers/soc/google/cal-if/pmucal_powermode.c#15
and the pmu_intr_gen is done based on the actual CPU being
enabled/disabled.

It's possible Exynos850 requires something different. I suggest
checking the equivalent function in the e850 downstream kernel.

>
> This causes the pmu driver to write power down and power on configuration
> hints to the wrong hardware registers, messing up the power state of active
> cores and failing to configure the target core. Fix this by removing the
> cpuhint variable entirely and utilizing the target 'cpu' argument passed
> to the callbacks by the hotplug core infrastructure.

Unfortunately I think you're introducing the bug you describe with this patch.

regards,

Peter

>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260513-exynos850-cpuhotplug-v4-0-54fec5f65362@linaro.org?part=3
> Fixes: 598995027b91 ("soc: samsung: exynos-pmu: enable CPU hotplug support for gs101")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>  drivers/soc/samsung/exynos-pmu.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
> index d58376c38179..6e635872247a 100644
> --- a/drivers/soc/samsung/exynos-pmu.c
> +++ b/drivers/soc/samsung/exynos-pmu.c
> @@ -235,11 +235,10 @@ EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap_by_phandle);
>  static int __gs101_cpu_pmu_online(unsigned int cpu)
>         __must_hold(&pmu_context->cpupm_lock)
>  {
> -       unsigned int cpuhint = smp_processor_id();
>         u32 reg, mask;
>
>         /* clear cpu inform hint */
> -       regmap_write(pmu_context->pmureg, GS101_CPU_INFORM(cpuhint),
> +       regmap_write(pmu_context->pmureg, GS101_CPU_INFORM(cpu),
>                      CPU_INFORM_CLEAR);
>
>         mask = BIT(cpu);
> @@ -296,12 +295,10 @@ static int gs101_cpuhp_pmu_online(unsigned int cpu)
>  static int __gs101_cpu_pmu_offline(unsigned int cpu)
>         __must_hold(&pmu_context->cpupm_lock)
>  {
> -       unsigned int cpuhint = smp_processor_id();
>         u32 reg, mask;
>
>         /* set cpu inform hint */
> -       regmap_write(pmu_context->pmureg, GS101_CPU_INFORM(cpuhint),
> -                    CPU_INFORM_C2);
> +       regmap_write(pmu_context->pmureg, GS101_CPU_INFORM(cpu), CPU_INFORM_C2);
>
>         mask = BIT(cpu);
>         regmap_update_bits(pmu_context->pmuintrgen, GS101_GRP2_INTR_BID_ENABLE,
>
> --
> 2.51.0
>
