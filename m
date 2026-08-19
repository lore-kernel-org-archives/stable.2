Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07703CB57B;
	Wed, 19 Aug 2026 07:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787123912; cv=none; b=BBmURr+OQg+7il2T4pMzq2bR3ngGdRMqTRDqac+Q6RKR5jQhjoOpwblzRyCENPIsWU0KVrLDlMAPItubzNK16NqbPmv1RUFeaR1wV3hQSjETF7uEG6BANk7ypfdBeRr9frjymZZ6XMjztI2SCxbV5TgYpYTdlM53TZx+1WAlDwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787123912; c=relaxed/simple;
	bh=pcwvfb3ivhOkWSLegrsz8kIIRMTLR8cdrzbnOc3npuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUmPsnpSk6Cwj/XtiIon1Mx0koaSIczzW8+LM8lxVAjnr2UdgxeiwaFiqXpd4ivjqQYD3F9vRAHxXIokOVj84fyQfbFZ9o82w+UhWaAuF1tSMHtr9rVtRrWN+zKky9qy55B5aV1f3hNsV/GwluQ704MJg1xHM3azO5FQ1fqtY3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8NZFKH+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8NZFKH+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985CB1F000E9;
	Wed, 19 Aug 2026 07:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787123910;
	bh=oaLIuywnH4SyCV/RCpoCYLZAD29H5M8DUZxH9KYY0dE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R8NZFKH+UtAN7P2cvw8Sll3E1ipc7xtNQloWNieuC8n5gQRnhDvPV5Zu3HKpQpfzj
	 cK2lOUs3bfRe39Iem64Uj7z1kOXGejKSeUZAySRWnSZOmnGwLEnhpeeHyTPM00XwvY
	 kibr/sfSMEMjKUkuiG6uG+uRCE7Kn04hjmsnX3IjGd+evuSPBMj1UtKlUbZqIi1Whx
	 mAEvGzPcJYGR52DwHyiYg1/GJTNZoHt2oE5a1OrwXQpvzamEomJ8XNZacZTRgkQeMM
	 NWjSi1iu6GW1Va2/dorVXOJLhNIb9Yjmo6FbGhLwDsxAgJQ7r9j55x0mtnoScHDqrr
	 Q0y/dAEXbhGyQ==
Date: Wed, 19 Aug 2026 09:18:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Bryan O'Donoghue <bod@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, Stefan Schmidt <stefan.schmidt@linaro.org>, 
	Hans Verkuil <hverkuil+cisco@kernel.org>, Mansur Alisha Shaik <mansur@codeaurora.org>, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, stable@vger.kernel.org, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v2 4/5] media: iris: Fix power-off ordering to disable
 power domain after clocks
Message-ID: <20260819-truthful-porcupine-from-eldorado-bbf912@quoll>
References: <20260818-iris-fixes-dma-pseq-fint-v2-0-8dc8c4b3880e@oss.qualcomm.com>
 <20260818-iris-fixes-dma-pseq-fint-v2-4-8dc8c4b3880e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260818-iris-fixes-dma-pseq-fint-v2-4-8dc8c4b3880e@oss.qualcomm.com>

On Tue, Aug 18, 2026 at 09:24:17PM +0530, Vishnu Reddy wrote:
> In iris_vpu_power_off_hw(), iris_disable_power_domains() was called
> before the associated clocks (IRIS_BSE_HW_CLK, IRIS_HW_AHB_CLK,
> IRIS_HW_CLK) were disabled and unprepared. This reverses the correct
> power-down sequence: with the power domain already removed, the
> subsequent clk_disable_unprepare() calls end up operating on
> clock-controller hardware that is no longer powered, which can hang
> or behave unpredictably.
> 
> Reorder the calls so iris_disable_power_domains() runs after all
> three clocks are disabled, ensuring clocks are always turned off
> while their power domain is still active, and mirroring the reverse
> of the power-on sequence.
> 
> Fixes: bb8a95aa038e ("media: iris: implement power management")
> Cc: stable@vger.kernel.org
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_vpu_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> index e4847c107709..3cd493b06d84 100644
> --- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
> +++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> @@ -223,10 +223,10 @@ int iris_vpu_power_off_controller(struct iris_core *core)
>  void iris_vpu_power_off_hw(struct iris_core *core)
>  {
>  	dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN], false);
> -	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
>  	iris_disable_unprepare_clock(core, IRIS_BSE_HW_CLK);
>  	iris_disable_unprepare_clock(core, IRIS_HW_AHB_CLK);
>  	iris_disable_unprepare_clock(core, IRIS_HW_CLK);
> +	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);

Really, how is this depending on dma-coherent DTS patch?

Best regards,
Krzysztof

