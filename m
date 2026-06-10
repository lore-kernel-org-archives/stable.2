Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0805C3E44F8
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104078; cv=none; b=eweZ2EdaTSSYHfKusaZAvjUC03CwfLPQM9BzPbPE4ADf7iAExcFlJ4LKpKUBiWwQV3VoDskBGlJaSDNWCC+iT7x037t3RLPQBSY2tCGUwbWYpIw/lv1RpZpzGkM0NOTXEvV36KS9oQzMqXB5JTbnQbv61+a3N6JbRU8vJ/CNZcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104078; c=relaxed/simple;
	bh=58f25bTT4YoEtaY+ECpkwpOWUnLt7jdCAYoUReU5Q4E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MMK0Uc5kFRo+4SEU32wWAF4biqu/szty4KW3JAJ8m2lOgMb6i4r9SSyL8pe+LFkrGtntX2jYp7Juw3cnuboeNISpf9ngbC/7rQksUVHgrwS43TWfOR3gs1Z4oOTlcgK9WhoeVMTAj/4VwSLvu16PI8JE5sj8lcCZNFyXsMV+iUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=luwAhd02; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="luwAhd02"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso57782715e9.1
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 08:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781104073; x=1781708873; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FelCh2VDHUplvnJ8mnvXATyOKPI2L/eG8fwTa4ZA6GU=;
        b=luwAhd02DIShXYU+eJ4F+iPcw4Nr28LtCSo/v4r0mIftbgTZcz0CsXyNHBlb1j5X7v
         nSEfzwlAKKwZueWlmjRExEgGObsl6N9s2zzN3FynQZohJSYi2yS0ExoApMOSLFVwb8rB
         B4AKIPRcZ7T4B8hWrJzqhuEiEoI1LE/zwFf79ME5jhrSFCmFjnaEt7tYP1Lid3gXqSJ5
         8XiAPgDVLXJomHbWduh+WkWpQKMwqM8pzU/YfV9Sd5JFytF/OMB0z2dmCb64T2QMujb2
         MyHt4dMwaKA41MNLijyqyv9Gjw8leRNZy3sR50AWeI+hqLzh4a66FWSNaFIZ9GZDy93+
         L2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781104073; x=1781708873;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FelCh2VDHUplvnJ8mnvXATyOKPI2L/eG8fwTa4ZA6GU=;
        b=MRDMb3FHfuRNdAxSswq+qSfmMno/KQmidsS+/2ApaVCrwrrd5FK54kdkVM1pYm0jYP
         4vPiXecPVwW/LG4uRFJbYsKM0WG4SwWVCvv2yJRgy5GRyhRHXi07aZQpjHcUO3UuVoW3
         LddqbcQup8DAtkVN1ghxw/wut5WzlTcysf4lRJCL5mSgTNI9Ic9PK7p/XIwiYVIXpFkQ
         bagejt9MNOE2Sx6a8XxlLH3ReNjF2QBFfCYq9TqDwN26UWpYShzQi687Hfo28f7/yVN2
         ABVgmfLvWSp4PxQU2/owd3jYJQi+m7ssbt55ytd5S7BCG7Q9GwIdCZLcZbXQYoXn6c2V
         H2Bw==
X-Forwarded-Encrypted: i=1; AFNElJ9MJRTZyVQTuN03N6UbfjHHd//ac8r9HCXux2BFPD4MXqleB75TTPVlBTZkzOmK5gkYkfn22Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+IuRspDf3ukRdKRx13CfJmf6CxwKUfpxNGiKOUpTbvPMxOJeF
	q11TPVcz7EozpcCGWR8edcLSpYqvA3HbRtgPQCti6rBrcA5Wdl54YzjCQwP7S7ZQwZA=
X-Gm-Gg: Acq92OHXSgH9cbGMFq3Fx1nIuwWDUlrPhelbr4oLpLZ9VTySSNIbeUgEXjR0qqFbuCz
	Pqv0Pqa5o53GKROZ2BVxM+0zZdFYUKeSxq8MlHIx3Fj803wKfTG9uTpOLwqcE5/ZKQhW4Rjw0wD
	Y9y4ifP09+rARdwpjygAY4v20aamBRfKbkrQnM5njwKjve11AN4CXK7nmTELZi64HQLiSPH7uvp
	a0YxeIfk4j0K9NZtg9gelyEYbx19RVsu3rRossfKN6JucNRCKgGnrM1otoawkftVs/h6RWRQuNO
	xMDj1+Tk2BRym2JXfhcQbpPULJH+L5AwXeRsyr7XaYl1v4t368YZPHfrLqaGDXNNgJstOgJmTFN
	ShPQG2L+qQWo/JnVmuNJMa7NvwTJsae2jnWh8ZVTd/g0IvqEvxwtiDPmHry4LiqOp/E8Lj8eGpn
	EtsvYerFUE0FTdi0Mc4XvYQf/ZDKv0g7+QTC5CvoncnMFEZG9d0qrtlzP6CRiTtnprQuvT2I88s
	8Nh9m3SL721NQHpcq+5R0LK
X-Received: by 2002:a05:600c:8b0c:b0:490:44eb:c1ea with SMTP id 5b1f17b1804b1-490d722a0e9mr93925085e9.24.1781104073271;
        Wed, 10 Jun 2026 08:07:53 -0700 (PDT)
Received: from localhost ([94.4.195.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490be1f69bcsm610037105e9.8.2026.06.10.08.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 08:07:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 16:07:51 +0100
Message-Id: <DJ5GP6VQJDHL.2V30K56ME95DO@linaro.org>
Cc: "Krzysztof Kozlowski" <krzk@kernel.org>, "Alim Akhtar"
 <alim.akhtar@samsung.com>, "Sam Protsenko" <semen.protsenko@linaro.org>,
 <linux-samsung-soc@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>
Subject: Re: [PATCH 3/3] soc: samsung: exynos-pmu: fix error paths in
 cpuhotplug/idle states setup
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Peter Griffin" <peter.griffin@linaro.org>, "Alexey Klimov"
 <alexey.klimov@linaro.org>
X-Mailer: aerc 0.21.0
References: <20260605-exynos-pmu-cpuhp-idle-fixes-v1-0-0cd05c81a82d@linaro.org> <20260605-exynos-pmu-cpuhp-idle-fixes-v1-3-0cd05c81a82d@linaro.org> <CADrjBPq4fou5KWh4T=oNkUVPz5Jk-821OVe3j5sWrKnCtHYM6w@mail.gmail.com>
In-Reply-To: <CADrjBPq4fou5KWh4T=oNkUVPz5Jk-821OVe3j5sWrKnCtHYM6w@mail.gmail.com>

On Wed Jun 10, 2026 at 2:34 PM BST, Peter Griffin wrote:
> Hi Alexey,

Hi Peter,

> Thanks for your patch!
>
> On Fri, 5 Jun 2026 at 21:19, Alexey Klimov <alexey.klimov@linaro.org> wro=
te:
>>
>> The setup_cpuhp_and_cpuidle() initialisation sequence currently ignores
>> the return values of cpuhp_setup_state(), cpu_pm_register_notifier(), an=
d
>> register_reboot_notifier(). If any of these registrations fail during
>> probe() routine, the driver returns 0, leaving the driver partially
>> configured.
>
> I originally made the failure non-fatal because the system still boots
> without the notifiers registered (and all other Arm64 Exynos SoCs
> upstream don't register notifiers and AFAICT have broken cpu hotplug
> and cpu idle).
>
> In hindsight, that seems like a mistake. I think your patch to fully
> unwind everything in case of failure makes more sense.  See small
> comment below about destroy_cpuhp_and_cpuidle()

Wait, setup_cpuhp_and_cpuidle() should be non-fatal and shouldn't
return any errors?
Why do we need to have notifiers (say cpu_pm_register_notifier())
registered if, for instance, cpuhp_setup_state() fails?

The other thing I didn't get is that this doesn't deal with handling
errors/return values of cpuhp_setup_state() in probe() and there
are still a lot of errors returned from setup_cpuhp_and_cpuidle().


>> Furthermore, if anything after setup_cpuhp_and_cpuidle() fails in probe(=
)
>> routine, for instance devm_mfd_add_devices(), the probe() lacks an error
>> path and leaves notifiers and cpu hotplug states registered.
>>
>> Introduce variables for the cpu hotplug state IDs in exynos_pmu_context
>> struct, that should be initialised to CPUHP_INVALID by default. Check al=
l
>> return codes in setup_cpuhp_and_cpuidle(), and add an error path to remo=
ve
>> registered states on failure. Finally, add destroy_cpuhp_and_cpuidle()
>> helper to safely tear down notifiers and cpu hotplug states.
>>
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Closes: https://sashiko.dev/#/patchset/20260513-exynos850-cpuhotplug-v4-=
0-54fec5f65362@linaro.org?part=3D3
>> Fixes: 78b72897a5c8 ("soc: samsung: exynos-pmu: Enable CPU Idle for gs10=
1")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
>> ---
>>  drivers/soc/samsung/exynos-pmu.c | 57 +++++++++++++++++++++++++++++++++=
+------
>>  1 file changed, 49 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exyn=
os-pmu.c
>> index 9636287f6794..846313a28e9a 100644
>> --- a/drivers/soc/samsung/exynos-pmu.c
>> +++ b/drivers/soc/samsung/exynos-pmu.c
>> @@ -38,6 +38,8 @@ struct exynos_pmu_context {
>>         unsigned long *in_cpuhp;
>>         bool sys_insuspend;
>>         bool sys_inreboot;
>> +       int cpuhp_prepare_state;
>> +       int cpuhp_online_state;
>>  };
>>
>>  void __iomem *pmu_base_addr;
>> @@ -404,6 +406,17 @@ static struct notifier_block exynos_cpupm_reboot_nb=
 =3D {
>>         .notifier_call =3D exynos_cpupm_reboot_notifier,
>>  };
>>
>> +static void destroy_cpuhp_and_cpuidle(void)
>> +{
>> +       cpu_pm_unregister_notifier(&gs101_cpu_pm_notifier);
>> +       unregister_reboot_notifier(&exynos_cpupm_reboot_nb);
>> +
>> +       if (pmu_context->cpuhp_prepare_state !=3D CPUHP_INVALID)
>> +               cpuhp_remove_state(pmu_context->cpuhp_prepare_state);
>> +       if (pmu_context->cpuhp_online_state !=3D CPUHP_INVALID)
>> +               cpuhp_remove_state(pmu_context->cpuhp_online_state);
>> +}
>> +
>>  static int setup_cpuhp_and_cpuidle(struct device *dev)
>>  {
>>         struct device_node *intr_gen_node;
>> @@ -465,16 +478,42 @@ static int setup_cpuhp_and_cpuidle(struct device *=
dev)
>>                 gs101_cpuhp_pmu_online(cpu);
>>
>>         /* register CPU hotplug callbacks */
>> -       cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "soc/exynos-pmu:prepare"=
,
>> -                         gs101_cpuhp_pmu_online, NULL);
>> +       pmu_context->cpuhp_prepare_state =3D CPUHP_INVALID;
>> +       pmu_context->cpuhp_online_state =3D CPUHP_INVALID;
>>
>> -       cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "soc/exynos-pmu:online",
>> -                         NULL, gs101_cpuhp_pmu_offline);
>> +       ret =3D cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "soc/exynos-pmu:=
prepare",
>> +                               gs101_cpuhp_pmu_online, NULL);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       pmu_context->cpuhp_prepare_state =3D ret;
>> +
>> +       ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "soc/exynos-pmu:o=
nline",
>> +                               NULL, gs101_cpuhp_pmu_offline);
>> +       if (ret < 0)
>> +               goto clean_cpuhp_states;
>> +
>> +       pmu_context->cpuhp_online_state =3D ret;
>>
>>         /* register CPU PM notifiers for cpuidle */
>> -       cpu_pm_register_notifier(&gs101_cpu_pm_notifier);
>> -       register_reboot_notifier(&exynos_cpupm_reboot_nb);
>> -       return 0;
>> +       ret =3D cpu_pm_register_notifier(&gs101_cpu_pm_notifier);
>> +       if (ret)
>> +               goto clean_cpuhp_states;
>> +
>> +       ret =3D register_reboot_notifier(&exynos_cpupm_reboot_nb);
>> +       if (!ret)
>> +               /* Success */
>> +               return ret;
>> +
>> +       cpu_pm_unregister_notifier(&gs101_cpu_pm_notifier);
>> +
>> +clean_cpuhp_states:
>> +       if (pmu_context->cpuhp_prepare_state !=3D CPUHP_INVALID)
>> +               cpuhp_remove_state(pmu_context->cpuhp_prepare_state);
>> +       if (pmu_context->cpuhp_online_state !=3D CPUHP_INVALID)
>> +               cpuhp_remove_state(pmu_context->cpuhp_online_state);
>> +
>> +       return ret;
>>  }
>>
>>  static int exynos_pmu_probe(struct platform_device *pdev)
>> @@ -548,8 +587,10 @@ static int exynos_pmu_probe(struct platform_device =
*pdev)
>>
>>         ret =3D devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, exynos_pm=
u_devs,
>>                                    ARRAY_SIZE(exynos_pmu_devs), NULL, 0,=
 NULL);
>> -       if (ret)
>> +       if (ret) {
>> +               destroy_cpuhp_and_cpuidle();
>
> You only want to do this if pmu_cpuhp =3D=3D true, as currently only gs10=
1
> registers the notifiers.

Thanks! That's good catch.

Best regards,
Alexey
