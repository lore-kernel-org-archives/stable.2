Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249173750BC;
	Fri, 31 Jul 2026 20:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785530213; cv=none; b=qPVuhs+1NbAEDP9JPqWZK5f98IBawE9qGm5vKfXrq78TXPyr/pLKgnC9S59om6pEaWy6ml/e/ajeSDONgQUOPH++UsMgR1CWbcglBoQmmv2PM4+Fsf9zvMlevZ+rc6/qpLQkFuKNXK0wpAGZaaTZyw+7EelGf5L4F8YUGdF5oSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785530213; c=relaxed/simple;
	bh=UqKWb+idgz8CdHbksmqSbsNQm+yn31XekBmBRUKS3FM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=W2TMEar8SEwzSgC0WQ3M+aA94iFyGOYOUAAhIwSayhYUshXkbamhOAxEIf2bqLsuphh7pCHrrsLCkA+iiemGOb559fEvSI2b/zqXW4Ty+0zZ1R53/uw2NqqQeY+HT4fswyRtodTdvNSS3jk9E6LUJg3dtkhrVILMT+6w6Vbf9w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkRuSP/Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkRuSP/Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A8B1F00AC4;
	Fri, 31 Jul 2026 20:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785530212;
	bh=DNG9QK/E1bVjVyZQG6BbnWYDur9kDPWeCKs1nMVxImc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=kkRuSP/QIxNNsb6GJtIAIkUxBkUbXJLcPRg/uNAUvw9Ztk7cTIUiY7zBZqrQK+WkT
	 q0589ywOpgECE+CVZ//4Cu7bsx2q9iFHB8DYoVMNi5Ypj/5T7ccVO3ITKWNBmeZS0w
	 +33zUb+mUf6QFAVk3uF2dMpHLVlTVpubGjy2P1IZPgkC9X9Izoj/UFNVc5lX4gSRkD
	 U5sz5IzoGtSbpa1nP28lRMy6CXbX+6kPwlnwd5tuU0+3hEywg1S32tAE52bpzJY29B
	 +mLh64wQh3oMhzbvLhL0x2pYRoD5N9DUpXg4gdjjx9d57m5zcIUBFhcI6fAqwVg5/T
	 EJGO2oal3hXMA==
Date: Fri, 31 Jul 2026 15:36:51 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stanimir Varbanov <stanimir.varbanov@linaro.org>, 
 Daniel J Blueman <daniel@quora.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, stable@vger.kernel.org, 
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-media@vger.kernel.org, 
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Bryan O'Donoghue <bod@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260731-vpu_iommu_iova_handling-v2-2-da52b5228dbd@oss.qualcomm.com>
References: <20260731-vpu_iommu_iova_handling-v2-0-da52b5228dbd@oss.qualcomm.com>
 <20260731-vpu_iommu_iova_handling-v2-2-da52b5228dbd@oss.qualcomm.com>
Message-Id: <178553021128.1745605.17032924779293673178.robh@kernel.org>
Subject: Re: [PATCH v2 02/12] dt-bindings: media: qcom,sm8550-iris: Add
 context bank subnodes


On Fri, 31 Jul 2026 23:52:17 +0530, Vikash Garodia wrote:
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
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/media/qcom,sm8550-iris.yaml    | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/media/qcom,sm8550-iris.example.dts:67.13-24: Warning (dma_ranges_format): /example-0/video-codec@aa00000:dma-ranges: empty "dma-ranges" property but its #address-cells (2) differs from /example-0 (1)
Documentation/devicetree/bindings/media/qcom,sm8550-iris.example.dts:67.13-24: Warning (dma_ranges_format): /example-0/video-codec@aa00000:dma-ranges: empty "dma-ranges" property but its #size-cells (2) differs from /example-0 (1)

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260731-vpu_iommu_iova_handling-v2-2-da52b5228dbd@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

