Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6153DCD95;
	Wed,  5 Aug 2026 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914465; cv=none; b=CGrPr8PZ3pwA2rmSuoWR6Dmla/g8Wkwt/b0hl3UHHygEhftcLnvG8xCtI+JEKoFQQ9Tu9OhIOzl6s8N0QJZKf8haVI3p6+Fg6zIo4oblb9/chbxipCGtbZ3TfOWKQeYmiTxldKFeWqGRDnhDCsJVEcUVADDtGJCy0qET3ZTlzxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914465; c=relaxed/simple;
	bh=J//R8ok82HpAY8G4OfUCqGx+fy66wwAbC8XHJK7GiMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9B/tjs9gysC3cCSruFASCpjMIBiAsTo+lX20jJZHNKdT1fMmeB04dVxC8Y9rNA2PurgaKKe3iz1DScL/rd2y6VXsYVddlcRTMAc/Aauyz41sjW04K2zB1bJCZyxSZL1BhyBqKPdki366YNDE5QJ8vhGF80BoGaPHOXt1IS2K9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbD6FXrf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbD6FXrf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FD71F000E9;
	Wed,  5 Aug 2026 07:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785914463;
	bh=FXsyZUd7PboUwtcX4ZZ0HKtYdB6exjVx91wRAsJHsOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RbD6FXrfZv9mf8buab9MdwkROVJz5pMIYQDSU95jdpNMTQfwiQZD7+GVpC4qRgzsb
	 gamck3R2iqcMfvDCmpxQirAfz6fafuXCoKTyNZh/aOjXPgRlr1ca5SuC57KzmmX+it
	 jUJ+OSIcpq4DVwk4Y3r9sGphu/xkWAO8KzAwk358MEYUbFaT4cMsFqQon7jtxxmR0V
	 ngMof+zGqD/IHeEebQ27s9TIaTOywkf5VU9KsrcG2K7zb//u+CGUiYx7VSQl91ISU9
	 9fSiJwEKSOrI9jRs0nVfDiiKfyd0RQxImSzF/dOW5s0Gi7Phc0ngW8+9P8EuDp8F0Q
	 U6iVUXYaOvL6Q==
Date: Wed, 5 Aug 2026 09:21:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Stanimir Varbanov <stanimir.varbanov@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, stable@vger.kernel.org, Daniel J Blueman <daniel@quora.org>
Subject: Re: [PATCH v2 01/12] dt-bindings: media: qcom,venus: Add context
 bank subnodes to common schema
Message-ID: <20260805-dark-voracious-jacamar-6aae4c@quoll>
References: <20260731-vpu_iommu_iova_handling-v2-0-da52b5228dbd@oss.qualcomm.com>
 <20260731-vpu_iommu_iova_handling-v2-1-da52b5228dbd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260731-vpu_iommu_iova_handling-v2-1-da52b5228dbd@oss.qualcomm.com>

On Fri, Jul 31, 2026 at 11:52:16PM +0530, Vikash Garodia wrote:
> The VPU issues DMA through several SMMU streams, and the hardware does
> not give every stream the same addressable range. The non-pixel stream
> is restricted to use 0-600MB of IOVA space, while the pixel stream can
> address the full range:
>     +-----------------------------------------------------------+
>     | non-pixel stream addressable range (600 MB - 3.5 GB)      |
>     | 0x25800000 - 0xe0000000                                   |
>     +-----------------------------------------------------------+
>     | pixel stream addressable range (0 - 3.5 GB)               |
>     | 0x00000000 - 0xe0000000                                   |
>     +-----------------------------------------------------------+
> A single "iommus" property on the video-codec node puts every stream in
> one IOMMU domain sharing one IOVA allocator, so nothing keeps a
> non-pixel buffer inside the low 600 MB. Once an allocation lands below
> that boundary the hardware faults, which shows up as unhandled SMMU page
> faults and spontaneous reboots:
> https://gitlab.freedesktop.org/drm/msm/-/work_items/100
> 
> Describe each stream as its own context bank subnode instead, so that
> each can be associated with the IOVA range its stream can actually
> reach. This limitation applies to every VPU generation, so add the
> subnodes to the common schema rather than to each SoC schema
> individually. "video-firmware" moves here from qcom,sc7180-venus.yaml
> for the same reason; it is the same kind of node and was already
> duplicated per-SoC.
> Adding the subnodes requires two supporting properties on the parent
> video-codec node:
> - '#address-cells' and '#size-cells', both fixed at 2. These do not
>    describe registers on the codec node. They set the cell widths
>    used when a reserved-memory node names one of these subnodes in an
>    "iommu-addresses" entry: of_translate_dma_region() reads the
>    address/size cell counts from the parent of the phandle target, not
>    from the reserved-memory node. Pinning both to 2 lets a subnode be
>    referenced with a full 64-bit IOVA base and length, and keeps the
>    encoding identical across SoCs, whose buses vary between 1 and 2
>    cells.
> - "dma-ranges", empty "dma-ranges" states the intended translation:
>    the subnode DMA address space maps 1:1 into the parent's, so an IOVA
>    reservation written against a subnode needs no offset applied.
>    of_translate_one() treats an empty "dma-ranges" as exactly that
>    identity mapping.
> 
> The parent's "iommus" is kept as an alternative via "oneOf", so
> platforms that have not been converted to subnodes still validate. New
> platforms should use the subnode form.
> 
> Fixes: 41661853ae8e ("arm64: dts: qcom: sm8550: add iris DT node")
> Cc: stable@vger.kernel.org
> Tested-by: Daniel J Blueman <daniel@quora.org>

Not a valid tag.




> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  .../bindings/media/qcom,sc7180-venus.yaml          | 15 -------
>  .../bindings/media/qcom,venus-common.yaml          | 51 ++++++++++++++++++++++
>  2 files changed, 51 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
> index b21bed314848480b82153e49602f0b19e08e7335..bfd8b1ad473128c974bce84639cb0aff59d8c2cc 100644
> --- a/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
> @@ -91,21 +91,6 @@ properties:
>      deprecated: true
>      additionalProperties: false
>  
> -  video-firmware:
> -    type: object
> -    additionalProperties: false
> -
> -    description: |
> -      Firmware subnode is needed when the platform does not
> -      have TrustZone.
> -
> -    properties:
> -      iommus:
> -        maxItems: 1
> -
> -    required:
> -      - iommus
> -
>  required:
>    - compatible
>    - power-domain-names
> diff --git a/Documentation/devicetree/bindings/media/qcom,venus-common.yaml b/Documentation/devicetree/bindings/media/qcom,venus-common.yaml
> index 59a3fde846d2196ab1e4588eb396012ba6860712..ccae41bed757bf3d9518cd4afe4565f043b45166 100644
> --- a/Documentation/devicetree/bindings/media/qcom,venus-common.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,venus-common.yaml
> @@ -47,6 +47,50 @@ properties:
>      minItems: 1
>      maxItems: 4
>  
> +  dma-ranges: true
> +
> +  '#address-cells':
> +    const: 2
> +
> +  '#size-cells':
> +    const: 2

Above do not look valid. You do not describe the addressing of some
other device node (not a child) here. You describe that addressing in
that other device node's parent.

> +
> +  non-pixel:
> +    type: object
> +    description:
> +      Context bank for VPU non-pixel buffers, including compressed and internal buffers.
> +    properties:
> +      iommus:
> +        maxItems: 1
> +      memory-region:
> +        maxItems: 1
> +    required:
> +      - iommus
> +      - memory-region
> +    additionalProperties: false
> +
> +  pixel:
> +    type: object
> +    description:
> +      Context bank for VPU pixel buffers containing uncompressed video data.
> +    properties:
> +      iommus:
> +        maxItems: 1
> +    required:
> +      - iommus
> +    additionalProperties: false
> +
> +  video-firmware:
> +    type: object
> +    description:
> +      Context bank for the VPU firmware processing domain.

Missing blank line

> +    properties:
> +      iommus:
> +        maxItems: 1
> +    required:
> +      - iommus
> +    additionalProperties: false

For children this follows type or description for readability

foo:
  ...
  description:
  additionalprops:...

  properties:
    ...
  required:
    ...


Best regards,
Krzysztof

