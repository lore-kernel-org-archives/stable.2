Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C47F3B388D;
	Sun, 27 Sep 2026 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790534863; cv=none; b=OYu/b1zSb9OgvPd2Lntzjn3+IFtxZhfZojiVlqCk5Tf2h6BbTzMNlEDcyj1qDZZjaAcbl9UeSeiOWoU82bORPh0QQ+mkd6liS7ONjvaWOLed8/tH3VoBZU22uu4XAjqwEy0t5lwvmAYUpzVvfJaOxTjJoAJ3oyK99+g7JEzeh/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790534863; c=relaxed/simple;
	bh=3pJmv3/3umA7ZkP71xzHvblAqWKINyjEcVMStuRTR70=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/vuKr+JNm6Xr6c0XwXiBNYXuocmOURKATVe1Zq6V6wVfJqtwT7JOcyOW6Ub5FhRuMobkQPDekfUskaOxf8dgocvnFIMqq0vLwylyo+rOitREx+0rv02puW7CGfdjma0sgnhb8ynTDSDieoOt3XCbnV24JjBdLqcbN6+qBLSR+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiouCllz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiouCllz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C85C1F000FF;
	Sun, 27 Sep 2026 18:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790534861;
	bh=rTGkk6MKJYEzG3GcMmmmeg6WnVpHww0g7NA09ykyC/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XiouCllzQ8ykayo10Wtw+WZ9XUHvKJYxIdOip1YinuSyngXjM6haeQeLkKxhkYMWh
	 TEz97N/hVI+VL6sO9QCwcl0Hv2/P2G8FIsgYsoeBBCujZIwMrpMfkogK0OX77JosxG
	 872EwwComyyYJvmkAxQaDjK2Z1y/jNw6UYUXQltl7Kw4goXb+9PPH7XPg6diolzM8d
	 CtoHzhvC3dsG1UjptevwG1lfIp7eASokpg+hub9c1h1AawVUeGVtPBxxt8V3bWnZhT
	 tey8FMJLq52mxDjR4COhdZNzCbsQ94N4WYx4riJmDIgbe9ALxgAoiq9M8NPYxdgko7
	 h4J6/NSUw0vUA==
Date: Sun, 27 Sep 2026 19:47:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, <linux-iio@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 Cheick Traore <cheick.traore-ext@st.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: stm32: fix minimum sampling time values
Message-ID: <20260927194734.7bc017a2@jic23-hlaptop>
In-Reply-To: <20260924-adc-fix-sampling-v1-1-13814954d8d7@foss.st.com>
References: <20260924-adc-fix-sampling-v1-1-13814954d8d7@foss.st.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 11:53:56 +0200
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> From: Cheick Traore <cheick.traore-ext@st.com>
> 
> - On stm32mp15: vddcpu and vddq_ddr are not connected to internal
> channel, so their sampling time shouldn't be set.
> 
> - On stm32mp13: vddcpu and vddq_ddr are connected to internal channels
> and the value for vddcore was not correct. Values from the datasheet
> are 1us (e.g. 1000ns) for ts_vddcore, ts_vddcpu and ts_vddq_ddr.
> 
> Fixes: 7cb2303dd024 ("iio: adc: stm32: manage min sampling time on all internal channels")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cheick Traore <cheick.traore-ext@st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Hi Cheick, Fabrice

Given we are fairly late in the cycle and that we have Fabrice's
other series poking at this same driver I've queued this up on
the testing branch of iio.git rather than taking a (possibly) faster
path.  That means it will go upstream in the next merge window.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 90f0e257e6d1..b024326775ae 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -2734,7 +2734,7 @@ static const struct stm32_adc_cfg stm32h7_adc_cfg = {
>  	.set_ovs = stm32h7_adc_set_ovs,
>  };
>  
> -static const unsigned int stm32_adc_min_ts_mp1[] = { 100, 100, 100, 4300, 9800 };
> +static const unsigned int stm32_adc_min_ts_mp1[] = { 100, 0, 0, 4300, 9800 };
>  static_assert(ARRAY_SIZE(stm32_adc_min_ts_mp1) == STM32_ADC_INT_CH_NB);
>  
>  static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
> @@ -2756,7 +2756,7 @@ static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
>  	.set_ovs = stm32h7_adc_set_ovs,
>  };
>  
> -static const unsigned int stm32_adc_min_ts_mp13[] = { 100, 0, 0, 4300, 9800 };
> +static const unsigned int stm32_adc_min_ts_mp13[] = { 1000, 1000, 1000, 4300, 9800 };
>  static_assert(ARRAY_SIZE(stm32_adc_min_ts_mp13) == STM32_ADC_INT_CH_NB);
>  
>  static const struct stm32_adc_cfg stm32mp13_adc_cfg = {
> 
> ---
> base-commit: 182c47735554925da9605dc9dd90a8c15a1bbae5
> change-id: 20260924-adc-fix-sampling-526f0f26829b
> 
> Best regards,
> --  
> Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> 

