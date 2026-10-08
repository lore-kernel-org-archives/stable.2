Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAD0489FA3
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453052; cv=none; b=Mg5WsQo/ypioVOiaKo1gKgo/wo7ALOuoF9brSkSufBW+HfEJs0PCgBJG/EAvUK0AsdVs9XKlMrgGyzGYzmSMSeSzv1zuNlY5z6TyueYaBqGLdgmh3KR9kmDfI+Jz3FcIFYB1vaKUE8XbEwq6+2ph63HcZsq+8XrTX29MZKjsaQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453052; c=relaxed/simple;
	bh=dph8nydlcGrIQKoDia1sOqYgMx4hrQl+mUMU4Id2UAo=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c43AAj0FtSq3j/x9Z7xXPlID7sWDDOU57ai15FR0jA9UTm4IpVesZRDVHLvukO5xeI4eAOoZFE1vXKvrnMMS0jDOHyEyK0drFfOFblXscdWIyZfGH/RzLNNN3D8TW+axYOc3yCuljWEx55KCThLh9D5hqEtP6+PmeXxabDguqlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grbWV59s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grbWV59s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DF81F0089D
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 09:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791453051;
	bh=zzjDvXnnH2r3MYJsw1QiaFGNtlAkTXt/3p2V95i9its=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=grbWV59sTws6M6kDa7QNwVfFBDGgS/1LdOIkSkMGzWz83L1NyY7hdUiA5pfIUmIUd
	 frYXdxbhamyvIjQ53RN0Pr2iMOGsWmHwSjqcXcGRjZTfGqzmS0muLK7I4V6zZ1YMlV
	 sK9BrpqU02Re7e59gLLWjf5Jwfzvvp+8daSOaVSQQ1rIsuxqclcetE7Y0ABkNhRh0F
	 pMTdcesHctKG5ogVnyWgQXGVzgbxse3CRUAEciNEfuuWmUSTL1I9j4kC2/Cx6yt6bi
	 9uJHaAVOUl4YkvTIlm7eRb3xOgN+p8IL4HXRThtJTch73fqPhDXpWuKhxbjIdfvEkO
	 pNVwBFjtX1TPQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3a65ed9c7cfso21330951fa.3
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 02:50:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByqN3E6m1i+WisHx7NhJhNNaPPSuT/Qzp6lnI++GZn+Zc8TyZT1eHgzSBmy2HkgkGsKI+7r2H4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKWq5kLftdX8cMiHPW9al3hUoNgQwIaz2zQ4qm2g6tpoGQRT68q
	LxtftQUXtR59GmcKG5XDNMy+AL5z2XYnWYaaoC8h4vJCfIQuLj4STPJK4mWcLP3tswdX67Ycejr
	aiggvEOzYNlu7z8GeRINEg6FLiTjyOKV2nrP/t9p2sw==
X-Received: by 2002:a05:651c:2110:b0:3a9:8167:62a with SMTP id
 38308e7fff4ca-3a9a2d5ef3fmr11294911fa.28.1791453049795; Thu, 08 Oct 2026
 02:50:49 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Oct 2026 09:50:48 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Oct 2026 09:50:48 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20261008-bam-dma-free-irq-v27-1-660e70223e3c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008-bam-dma-free-irq-v27-1-660e70223e3c@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 09:50:48 +0000
X-Gmail-Original-Message-ID: <CAMRc=MdOLnUgY7CHD1mdB7x=S-LBuHBHvsx8V95DiVjR=zCePA@mail.gmail.com>
X-Gm-Features: AclHuK8gCrOH-8lbrvxPcOsgTJbpgR03xMfb8jAIWyOn4Lr2qiQuvScWu5tAuqE
Message-ID: <CAMRc=MdOLnUgY7CHD1mdB7x=S-LBuHBHvsx8V95DiVjR=zCePA@mail.gmail.com>
Subject: Re: [PATCH v27] dmaengine: qcom: bam_dma: free interrupt before the
 clock in error path
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, brgl@kernel.org, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Andy Gross <agross@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Oct 2026 11:30:56 +0200, Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> said:
> The BAM interrupt is requested with a devres helper and so on error it's
> freed after probe() returns. We disable the clock before freeing or
> masking it so it may still fire and we may end up reading BAM registers
> with clock disabled.
>
> Stop using devres for interrupts as we free it in remove() manually
> anyway. Add an appropriate label and free the interrupt before disabling
> the clock in error path and in remove().
>
> Cc: stable@vger.kernel.org
> Fixes: e7c0fe2a5c84 ("dmaengine: add Qualcomm BAM dma driver")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260427-qcom-qce-cmd-descr-v16-0-945fd1cafbbc%40oss.qualcomm.com?part=2
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
> This used to be part of the larger BAM DMA pipe locking series and never
> got picked up despite months on the list. I'm resending it separately.
> ---
> Changes in v27:
> - Rabase on top of current dma/next
> - Link to v26: https://patch.msgid.link/20261006-bam-dma-free-irq-v26-1-eef5c713d831@oss.qualcomm.com
>
> Changes in v26:
> - Rebased on top of current linux-next to address conflicts
> - Link to v25: https://patch.msgid.link/20261002-bam-dma-free-irq-v25-1-f39e01d19910@oss.qualcomm.com
>
> Changes in v25:
> - Don't touch remove(), it's not wrong in its current version
> - Link to v24: https://patch.msgid.link/20260723-qcom-qce-cmd-descr-v24-0-4f87bb4d9938@oss.qualcomm.com
> ---
>  drivers/dma/qcom/bam_dma.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 94cb957d4b187704e207361d629fde00e3e090bf..a626746b5c93496e5c5e885b35a856d38c284448 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -1332,8 +1332,8 @@ static int bam_dma_probe(struct platform_device *pdev)
>  	for (i = 0; i < bdev->num_channels; i++)
>  		bam_channel_init(bdev, &bdev->channels[i], i);
>
> -	ret = devm_request_irq(bdev->dev, bdev->irq, bam_dma_irq,
> -			IRQF_TRIGGER_NONE, "bam_dma", bdev);
> +	ret = request_irq(bdev->irq, bam_dma_irq, IRQF_TRIGGER_HIGH,
> +			  "bam_dma", bdev);

Please disregard it version, this should have remained IRQF_TRIGGER_NONE.

Bart
