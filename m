Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E9C3E315E;
	Wed,  5 Aug 2026 07:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914501; cv=none; b=nNFKcTFVB0vYCa4pmQw72S3i75Ie1pwUHasGhV2q6WJDkuX9bkrgv8H7MlXawG0JFBC/DQ+le7+cFWM0RmosyZ74/Z8XghTdbCRFyAA8PHIiIocxLxiwN+D0c2wFkp20iI8zcFPkpQ2PazrJtGmH4FSMYJcaGYqa0KJhEuHq3/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914501; c=relaxed/simple;
	bh=4xXbWTtC/7UGZN2BXVjiO/BZNeH5ESPefA0/PdFdxAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7IVzyWmlTa6odyXSOLJi1E/U56CZAXDFjNQUyQ6LA2h19vCSl0EIEWST05ldOzX9+NTj2TjmYoCUV2cpgHPQwJhKInwH5PJBSb8hPUfmBFoCa8gimDWCIMix0Dd1Pqkrp7elfWCTL7RPx6mVxUKJcf4vtRfyjGkDZquCbyycbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnMKQb5g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnMKQb5g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EDC1F000E9;
	Wed,  5 Aug 2026 07:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785914500;
	bh=cdK8AKWPPhEwUaQW7Dxg4qsOc242eUKSg7dv/RpWNH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AnMKQb5grAjIrRzRANKpLl4LWF5Axk1uByKzp1TuCorI/OV0dfKrV+S5wcM7YuIsK
	 JBWx5gvWO6NnpQuUOY6hLobCWOZFCc2tGZK4OW8jL7HhNH6Nj7Wlc3Xm45/gwqSFC1
	 jZOdILr7uaYVNPEympm1RVDVA9tTs0tsT7DLoGVNoyTLGAqX2t962EFKDG2sNbEuBQ
	 yxcELEgxstI5MSR5NwpP8BZp/pFJV9EUjvmaRNKzMIo8lLMxmTsD8dPuXHfxco7tNj
	 WL8dNJd2KZ1Jtx4ptCrivyz5id+MawmU07MX06PXPkKVlN+njo0RNILat1mmtmPm6H
	 wEtSGBJerDydA==
Date: Wed, 5 Aug 2026 09:21:36 +0200
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
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, stable@vger.kernel.org, 
	Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, Daniel J Blueman <daniel@quora.org>
Subject: Re: [PATCH v2 02/12] dt-bindings: media: qcom,sm8550-iris: Add
 context bank subnodes
Message-ID: <20260805-hulking-woodpecker-from-wonderland-15b7c0@quoll>
References: <20260731-vpu_iommu_iova_handling-v2-0-da52b5228dbd@oss.qualcomm.com>
 <20260731-vpu_iommu_iova_handling-v2-2-da52b5228dbd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260731-vpu_iommu_iova_handling-v2-2-da52b5228dbd@oss.qualcomm.com>

On Fri, Jul 31, 2026 at 11:52:17PM +0530, Vikash Garodia wrote:
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
> non-pixel buffer above 600 MB. Once an allocation lands below that
> boundary the hardware faults, which shows up as unhandled SMMU page
> faults and spontaneous reboots:
> https://gitlab.freedesktop.org/drm/msm/-/work_items/100
> 
> Reference qcom,venus-common.yaml, which describes the per-stream context
> bank subnodes, and drop "iommus" from the required list. The common
> schema accepts either the flat "iommus" or the "non-pixel" and "pixel"
> subnode pair, so device trees that have not been converted still
> validate.
> 
> Update the example to the subnode form, which also picks up the two
> supporting properties the subnodes need on the parent video-codec node,
> '#address-cells' and '#size-cells' of 2 and an empty "dma-ranges". Both
> are described in the common schema change.
> 
> Fixes: 41661853ae8e ("arm64: dts: qcom: sm8550: add iris DT node")
> Cc: stable@vger.kernel.org
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Tested-by: Daniel J Blueman <daniel@quora.org>

Also not a valid tag.


> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/media/qcom,sm8550-iris.yaml    | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml b/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
> index 0400ca1bff05dcef6b742c3fbf77e38adca9f280..3d8ff5677bd4fb7f3619a95b1c5f6f9eaf39b32c 100644
> --- a/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
> @@ -98,10 +98,10 @@ required:
>    - interconnect-names
>    - resets
>    - reset-names
> -  - iommus
>    - dma-coherent
>  
>  allOf:
> +  - $ref: qcom,venus-common.yaml#
>    - if:
>        properties:
>          compatible:
> @@ -177,12 +177,24 @@ examples:
>          resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>;
>          reset-names = "bus";
>  
> -        iommus = <&apps_smmu 0x1940 0x0000>,
> -                 <&apps_smmu 0x1947 0x0000>;
>          dma-coherent;
>  
>          operating-points-v2 = <&iris_opp_table>;
>  
> +        #address-cells = <2>;
> +        #size-cells = <2>;

Drop both

Best regards,
Krzysztof

