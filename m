Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E7A259498
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785685209; cv=none; b=Xlcau2pOSz2ubUaRkC87iHC0SL9l9DLOg0vl8B8BghG0iGzqKoMOABx2n1i5pQHxRyZXxzhhV+BkakTeRH67USlBauf/77QpaoG2Lpz8fkdpy0UzaLZKKRG/qop4mq4exsPq7+HTf5H3qLFBYrfvpNLB/LDfQIepCX6YnVPotU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785685209; c=relaxed/simple;
	bh=S9GF3h7gmhd8ieK4IJPj1yC65IXD+OHH4Bv/vHTquF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+AMGCsE4ZZ1ErRAH0zf1pV+huuHFbUmgj57jHyjPTdVrPwhxV9hqZ6GxMKgF4q9M9C2lMylwDLuFnaxC88pBT614lsOEfYAaplehewuErFKq83/a8CsNOXJnflqZG5RE6Fltjh3DkzmcRKW10GpVQVebbKYaLhl6JjRt1ds2/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=hI2A/CTj; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="hI2A/CTj"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e9ecd7216cso1359462a34.3
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 08:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785685206; x=1786290006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TVSsAwcRy1uonwMzmFb3HAht5GF4K+y7gUHhjcWsEHU=;
        b=hI2A/CTjEkMXgJuj5cAnHWxRFd4+XTwu1ZEfP1eLxxBHdeaKZYdLlR9hs07NMEdmGC
         tfrZ05xtkCuK9TG29rctFXeeZCrqlO0J3NDLfArbu98xg4GvWiBfND5tYCLx3t8zzebt
         WslO8vrqGQJVnJFZaV7s0AyevyyKNe+Dxvb/x43lwmk8El/xA9J8SZNb0J9WnfZdqHCc
         Qjsy/wNhts3S0H2bRSPv82r1VMv9cA7R7TC4q/PDadgS+X160Us3OxwQex99sT0ihte1
         auVxgG/xJBchRonruMQc+tHYV2meubjvllEysDXxX6+WT3h6GJbJer7BArHFVawTgBEN
         wZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785685206; x=1786290006;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TVSsAwcRy1uonwMzmFb3HAht5GF4K+y7gUHhjcWsEHU=;
        b=qLUeLY7V+8tRlfBfd9YE2qfW4/X6jPcNQ99M9mDPGfEhOOGYZxyLf2gxxjZU1lI8nL
         NPCvYVav9w2dWNtVobwJVd3pkPmx8dvqxEruxM4uOSfGEGib7p0TK2TnpFlnyG554Xc1
         m++tHyz7LYWlahxLfNNW3aJ/0CYgHy62O6CIbw1D/eq7081dfNVfKr6rtjnsoI5tk+cw
         GlwOzCDAs6ILQmRXtH0bBMNLDSUc+WtgPWEFondIfj6rEAwf37mJEqFKJA9peI3XIJRw
         GgzzyGA74DE5/2pm+Q0y2d4GfK85HKJbWHW8QFkviCwdAr9y7Ay79pFddlysn3AgukHQ
         /U1g==
X-Forwarded-Encrypted: i=1; AHgh+RoKyAEWQWma4uoNYFcYTbP1LU42wuIbh98bI8wDmQxxJAisvzT6rMslQa+unIozw/EsIxCQLns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDnNhIp5mfvHKF1ubmLbX9GeQCYao0R0ewLDBqKbFpV0RLkVnE
	8uwlKdK3NRsy/1JslnW0YaMeWFf5v0uCdmSEYbE03aIPyTzpa4iA3hqM1HHSJLkGI5o=
X-Gm-Gg: AR+sD13CR1t4qc5wlCnuM+11umkng/LtE8TAoeJZVtGkERh+Ad0Hp0L1bXgunkOCvKc
	8Dpuuz1qV5qKLkuMKy8sOu9OgAbVyYIByTMGcTQoloDAMjOiuIc0p3CCbFDBcqJH8zGAQDclPt+
	B/aqjpTeWXmi90dqpeZgQgbNQvXgzTuB8XgljEBWSXPRMNADpcC0yFnSNnaYKDvJmJyU+U3oMiO
	kDgFXE7YrzYDo9Ca/oEE6DUC2WEFdrZ4M6gP5iAPKey+GbiEUts21fbUH9fwtdzocXByWCYxey4
	Yckird37cw0Mowlw+cTt6WqiGT8y5fJKrXnanPL1I5fXbYhT0jFxS0rGURQsNgATIYnjzcPT2JV
	TwjeJ2J7vSCqIeteM7pd+GskR+U26paKNoEC4jNedURYypOzU0yp+3wtCAcQgAA+F3qyoJ2esDZ
	X9wF/auF+wPGiT6HO/WgzuN354aslcqpAHkSqGbgZuUCkdAjr/82pT3VxJcCP1dXPZmIp9GkyaA
	aUc5zaMA80oZdIiw1apB3rLcMbVb72HjZdQoqA=
X-Received: by 2002:a05:6830:700c:b0:7df:5fc:3fd5 with SMTP id 46e09a7af769-7f196b97f19mr12557105a34.1.1785685200962;
        Sun, 02 Aug 2026 08:40:00 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:5487:2b6e:1057:d3d3? ([2600:8803:e7e4:500:5487:2b6e:1057:d3d3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18ed3c81fsm5342440a34.5.2026.08.02.08.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 08:39:59 -0700 (PDT)
Message-ID: <750f615a-c00f-4e98-9bcf-8fa8704acfba@baylibre.com>
Date: Sun, 2 Aug 2026 10:39:58 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: xilinx-xadc: free IRQ before cancelling the
 unmask worker on unbind
To: Fan Wu <fanwu01@zju.edu.cn>, jic23@kernel.org
Cc: nuno.sa@analog.com, michal.simek@amd.com, bgolaszewski@baylibre.com,
 DileepKumar.Nagavarapu@amd.com, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260802082851.433476-1-fanwu01@zju.edu.cn>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260802082851.433476-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/2/26 3:28 AM, Fan Wu wrote:
> The ZYNQ XADC interrupt handler xadc_zynq_interrupt_handler() arms the
> zynq_unmask_work delayed work via schedule_delayed_work() every time an
> alarm condition is observed, and that worker re-arms itself for as long
> as the alarm stays asserted.
> 
> In xadc_probe() the IRQ is requested with devm_request_irq() before the
> devm_add_action_or_reset() that registers xadc_cancel_delayed_work().
> Because devres release runs in LIFO order, on unbind the delayed work is
> cancelled before the IRQ is freed. The IRQ is still live at that point,
> so a pending alarm can make the handler run once more and re-arm
> zynq_unmask_work after it has been cancelled; that instance then runs
> after the xadc structure that embeds zynq_unmask_work has been freed, a
> use-after-free in xadc_zynq_unmask_worker().
> 
> Register the cancel-work devm action before requesting the IRQ so devres
> LIFO teardown frees (and synchronizes) the IRQ first, then cancels the
> delayed work. After free_irq() the handler can no longer re-arm the
> work, and the subsequent cancel_delayed_work_sync() drains any instance
> armed just before the IRQ was torn down.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: 2a9685d1a3b7 ("iio: adc: xilinx: use more devres helpers and remove remove()")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
> 
>  drivers/iio/adc/xilinx-xadc-core.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -1395,13 +1395,16 @@ static int xadc_probe(struct platform_device *pdev)
>  	}
> 
>  	if (irq > 0) {
> -		ret = devm_request_irq(dev, irq, xadc->ops->interrupt_handler,
> -				       0, dev_name(dev), indio_dev);
> +		/* devm LIFO: register the cancel-work action before the IRQ,
> +		 * so unbind frees the IRQ first, then drains the work.
> +		 */
> +		ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
> +					       &xadc->zynq_unmask_work);
>  		if (ret)
>  			return ret;
> 
> -		ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
> -					       &xadc->zynq_unmask_work);
> +		ret = devm_request_irq(dev, irq, xadc->ops->interrupt_handler,
> +				       0, dev_name(dev), indio_dev);
>  		if (ret)
>  			return ret;
>  	}
> --
> 2.43.0
> 

Makes sense.

Reviewed-by: David Lechner <dlechner@baylibre.com>

