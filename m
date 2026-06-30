Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE642BE63F
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 22:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782857039; cv=none; b=gxJpz0RAZ6DlspMV8wa2H9bWTM4w6tRWNMExjEmauVm1gAbU+bvk3+xudt6cjIKCFMRCXpxCnfr7b59bPp1r3rwTyBzWIOcC9OGlgWju5w4a6PrWQDyqi1YMwVfvmMyUkH3OZa7VQKa0p+4cBN+lGU7K0yP/Ko2Rar0aWLxGe3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782857039; c=relaxed/simple;
	bh=8ymipuRB9D5DQq6+y2O9ynj1qRZr8UbXvBj3NoQCjs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/nHnhAvlc3GKd/iSbnZiBSt9+FypP9w50oYrVFweRN2uqHVCOApPY/NwZnwAvfYwY+n5ITbRjFldpCXrrwb8hCfbihdMYMMBZm/kmM4F9tFlG1omIvP8JkVuOf+YlqYW9UKqjHLvae7bdLeddS3bre4mP0gYoJH1XJJneUcQ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HFHkydXl; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HFHkydXl"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493a54b80a5so43936655e9.2
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 15:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1782857037; x=1783461837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tw2gpsI3jiI4P6kujg/K3R9aQhlaG+bVbRj+g5z/Ff4=;
        b=HFHkydXl9qNzDuK2ivnsAQd2h53E0oIA57kLA0rrCp747uvtzYeaf9cjaQnc/F3glZ
         ta0KhSbJKwXq5FoisQqw05UFsVizPp5hTwbk1YBuU95WQOj1gAxp9khcgRDmzQMtTyXY
         1cUl7fD9mY9hSYmj1gQ7/YPYth8KxdNxaGf2GTHjXyTI9WOtyrgV/GZ46EQDBhrOh2E+
         NXc8WZLNAQm4ly8FIv8HZ/5hwl8UF+g7IsLc0ZKsDM51ghSL89fD+2aPqJblSDZ81c5O
         DmpugiOO12AHfavcKcH6nFCMC732wtx8SFZ8XVtiRPlpG57KBqgoWUqkfRn5VhChvdRw
         R/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782857037; x=1783461837;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tw2gpsI3jiI4P6kujg/K3R9aQhlaG+bVbRj+g5z/Ff4=;
        b=XejIvi2PqHoNfE8LBf1bHM8zXN0fmUzIJsCTBvRCkv7Uq5BsPcqbH/cS6Eqa6SVGe1
         ZOUOPdPMnN0ignCdVQz2/xIPbU9TmMebA8K1iH94Z6h3zeDFFHha3UN/futahUK5tS0S
         xI7ViWav7qNfXXOKyb0aPlX7wGZb+3L1C25AHrlk56Kb3VclEUim7qhBmUNitKbPsYO5
         TSIV1lYcn9R+aIgizTxu4DPY9qrf3sgnup0w30SsqEivpMrYrZD0+R4v/tqBYTbVrPhL
         4dXbn3DAdzryVi16cwRqleTt4m39YVPcD9FdUsbQ5wNysnNPZvvtl5UfUhfYja87NMBN
         drWw==
X-Forwarded-Encrypted: i=1; AFNElJ+xV4w6lTJJoXasVzQHPnQjDmDG7bEf/UavfPlncHBksPRO4hlq4iZgB1TYhBW1i63M6aI67Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLrqLP/pPuhd0tCV02+Vb8qA2MKDIinteiTurOpfrC79t9p8tn
	cYNoF1y7+oGBMlHEGuzZgM6KYxhabR4c9j/Bfp4ghe0S1z8PNAB0l9Zbw1mXMypmEq0=
X-Gm-Gg: AfdE7cnqK6aLIp6/1Q6KRrXKdjVoFCqNiaQ8cqxgGdccsIXTjsQwCmAMmnzcz3GmHeu
	c1gBuWfxQ2L21HJPZBen2HsjC0AnUDvyhPR2Xq7J8P/kWA4FrBImcTHGgvv1ebk9TMsM5cfOGFq
	UOVaDvpIxWElTZRHf9X2/W7YOPvrfLazXuI37aB8XdsyRH6L3oOV5rQ4wbtxHnrSg74/Y7+V2JD
	34bJ4mqgGsqEeAyaXn4Bu3P421oat42Zbiy9hjH/JO85iDPSIfaUej9aqtRjhAz8Up0J9iFDur6
	c/z144GvJX/NYqEoQTj6GePyl3r05iigvxum8SoDP6Iidrfje3OXmqukZqHHFSyvILDlYzlwqkY
	R052e3aP7UrC4LG7Opm8niuzYutBKO21sJy3NplbcUSCqMZcfl8w2gNZgh+nhhT/BvQrVWeoHuW
	1ZII22lnEEpJaiPwkO8Ma6+41ERw==
X-Received: by 2002:a05:600c:6290:b0:492:40f2:4d78 with SMTP id 5b1f17b1804b1-493b827ee28mr76178765e9.2.1782857036849;
        Tue, 30 Jun 2026 15:03:56 -0700 (PDT)
Received: from [192.168.0.101] ([109.76.103.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475643cd85dsm10663533f8f.15.2026.06.30.15.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 15:03:56 -0700 (PDT)
Message-ID: <9898d7cd-45fb-478d-affb-d3cf0e7df8b7@linaro.org>
Date: Tue, 30 Jun 2026 23:03:55 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] media: qcom: iris: use disable_irq() during power-off
To: Hungyu Lin <dennylin0707@gmail.com>, linux-media@vger.kernel.org
Cc: vikash.garodia@oss.qualcomm.com, abhinav.kumar@linux.dev,
 mchehab@kernel.org, konrad.dybcio@oss.qualcomm.com,
 dmitry.baryshkov@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <sum692CaNq_kIywmtjVJ3z0iG8qBK0eOdmOPYUaivwH3v6h9GxZZqm2_7vgbCrCOAZs-K0K9PejQsRXj1za4VA==@protonmail.internalid>
 <20260630152617.568-1-dennylin0707@gmail.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20260630152617.568-1-dennylin0707@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/06/2026 16:26, Hungyu Lin wrote:
> The IRQ is registered as a threaded IRQ.
> 
> Using disable_irq_nosync() in iris_vpu_power_off() does not wait
> for an already queued threaded IRQ handler to complete before
> returning.
> 
> As a result, a threaded IRQ handler may still run after the VPU has
> been powered down and access hardware registers after power-off.
> 
> Replace disable_irq_nosync() with disable_irq() so the power-off path
> waits for any in-flight threaded IRQ handler to complete before
> returning.
> 
> Fixes: bb8a95aa038e ("media: iris: implement power management")
> Cc: stable@vger.kernel.org
> Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>   drivers/media/platform/qcom/iris/iris_vpu_common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> index 69e6126dc4d9..538659284c7b 100644
> --- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
> +++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> @@ -236,7 +236,7 @@ void iris_vpu_power_off(struct iris_core *core)
>   	iris_unset_icc_bw(core);
> 
>   	if (!iris_vpu_watchdog(core, core->intr_status))
> -		disable_irq_nosync(core->irq);
> +		disable_irq(core->irq);
>   }
> 
>   int iris_vpu_power_on_controller(struct iris_core *core)
> --
> 2.34.1
> 
> 

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

---
bod
