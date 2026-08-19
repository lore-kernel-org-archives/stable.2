Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA4E3D669D;
	Wed, 19 Aug 2026 07:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787123741; cv=none; b=ePfaTdaHSYUNi4pjcuDcd7p49WlxdIc9Qb6YI7cHSrOVwA4QDbvJMLFmgBcLIe/P6pZaUeCkUzpS+eb7UTCcjUgXe8KaaYeLS/HjgUo5qASEDoQp4qCcWjYqqo/ix9rsITNNxjT/l96rJK3h6UENmTtawhyG6PyDmGBQexoNTMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787123741; c=relaxed/simple;
	bh=Tfg9uoPwNYl2AlcPWXqS35BH8PG/QCck7rk9eK+/C/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKbdE86rCXD56uTugHuGpH/rimAKqlxv+c7OyPFz5LMkvXE0WGL/24l7wepOV6GKRii16OZ9oC5N46ZI9K4wI4osiOcHF7sB+DoVrXXT92VnKSgq7etGGmB+6UkLY/fjlgv97kZmBuESRb03a+2zMlk93qqm9eaA2LDRFsYK7oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nw80rRbr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nw80rRbr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907621F000E9;
	Wed, 19 Aug 2026 07:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787123738;
	bh=Q6dVWa7FdVyeCQqTLcjGqFMgyWYOU4s3/Ghyjt/ebag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Nw80rRbr22Zloezf4KbcOCv3nLtNFSrcKYpGKzSmmd/BnkZ74Ctm8EcJCc6XsX84y
	 FSzfmnpcJdPSQ1s4Xiee3VrCXQzLHJl+e0xO+5RU9bUCq+jTxPbNoXrqJFweoueEpm
	 rJHko/7M7iioqDy3/LwA/wVx5IX5Yz2MATCLwl2PgDvf7oCaL211Kiz4tSd8x7Vy3P
	 IjeKA9YpNuoA9xqw7RJiZ31DNDHlgY/Y944qz99GBPtm0fR9WWIkKEfBTfppsL34+H
	 X1ybb1LVcIdkWFIb+KORTJJ2wYP4e7QEcPF0Jp27dzPSo3dfExZm0Jl1LQrELXkd6V
	 3+t8UWDBIgJqg==
Date: Wed, 19 Aug 2026 09:15:34 +0200
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
Subject: Re: [PATCH v2 2/5] dt-bindings: media: qcom,sc7280-venus: Add
 dma-coherent property
Message-ID: <20260819-neat-prudent-chamois-aa65f2@quoll>
References: <20260818-iris-fixes-dma-pseq-fint-v2-0-8dc8c4b3880e@oss.qualcomm.com>
 <20260818-iris-fixes-dma-pseq-fint-v2-2-8dc8c4b3880e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260818-iris-fixes-dma-pseq-fint-v2-2-8dc8c4b3880e@oss.qualcomm.com>

On Tue, Aug 18, 2026 at 09:24:15PM +0530, Vishnu Reddy wrote:
> The venus video hardware on SC7280 is IO-coherent hardware: even though
> the driver does dma_sync*() calls for the input and output buffers, the

No, the driver does not.

Anyway, explain the hardware.

> venus node still needs to declare dma-coherent so that the DMA mapping
> layer relies on this hardware level snooping to keep the CPU cache and
> the DMA buffers in sync. This avoids the unnecessary cache clean or
> invalidate operations performed by the dma_sync*() calls, which are not
> required once hardware level snooping is enabled via dma-coherent.
> 
> Add the dma-coherent property to the venus node to describe this
> hardware capability.
> 
> Fixes: 37613aee2179 ("arm64: dts: qcom: sc7280: Add venus DT node")
> Cc: stable@vger.kernel.org

Nothing to be fixed here, I already told you.

NAK

> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
> index 9725fcb761dc..cc31f3ba7e7e 100644
> --- a/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
> @@ -42,6 +42,8 @@ properties:
>        - const: vcodec_core
>        - const: vcodec_bus
>  
> +  dma-coherent: true
> +
>    iommus:
>      maxItems: 1
>  
> @@ -85,6 +87,7 @@ properties:
>  
>  required:
>    - compatible
> +  - dma-coherent

ABI break.

>    - power-domain-names
>    - iommus
>  
> @@ -119,6 +122,8 @@ examples:
>                          <&mmss_noc MASTER_VIDEO_P0 0 &mc_virt SLAVE_EBI1 0>;
>          interconnect-names = "cpu-cfg", "video-mem";
>  
> +        dma-coherent;
> +
>          iommus = <&apps_smmu 0x2180 0x20>;
>  
>          memory-region = <&video_mem>;
> 
> -- 
> 2.34.1
> 
