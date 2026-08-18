Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587B623ED5E;
	Tue, 18 Aug 2026 21:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787089946; cv=none; b=HkJvoP56d7vYekOu4DciAFdh5S59LjEplQRUV+/Isp67IDCSfXZkV/IXYF4AR8/172H+BGsXotkUecALkQgPzlwWyAtAr8BXf3dAPxghxrhixAjABegYrkPQtIXs64NsGhsv6k9vn6n8vTrrqAgq0Blmng9eBtpDC4UMRZ3fRZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787089946; c=relaxed/simple;
	bh=5rB3CzCVwjhOp1/bYvMXX/zf9TBvXxRkfs+sPNutojs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=NS8FbXCnzgL9KeHHZRZ7ocjxM2Zvm9mNwqyfYq5ZqHqjxu9dMbbHmX41DxTt8duokD946PNNIpkFLko9wCZdzyijNKq7x42+Xeu+cAprbnsym1v4KXebCohQBoyk13OnArASKW+zVNdrkKF/gd5Rm09BRppfMowwc8lT8QkDDrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDjoExYd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDjoExYd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2CD1F000E9;
	Tue, 18 Aug 2026 21:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787089945;
	bh=NpeHBToS6yPyfIxplx9AMeP2CHKJr5xgLNRGxEKyLxQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=bDjoExYdLzJj3dsXRoadqw1Mn7b4iugxnL60WLCyLbDE7mhlRkZMecu37jEMhy6uo
	 xt5QVZM+5NQZ8FlngqQH1s5UXSvbKABRTdj8DaKFNMeKq2jB08cdB+ZVXUXrHxlbio
	 y68d1g7u0UoTMg3hk9pPgh4EUW0K7FREYiOVmbNS9HqlE/q/x7k2l860L9w03hcIpW
	 tQ7gM8zynr3X0kyWKd7TResFV3C69B90gFOYCk/8F9VyeApTAqbACut+nSb00JrTUX
	 wA4ub4r4/dqM3tRZNoW0s9jjJloG5cYpOzsRP+15QsjWnFvS9DrQqbO9vOrRs5+KjS
	 XGPXOCXIbWsUw==
Date: Tue, 18 Aug 2026 16:52:24 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 stable@vger.kernel.org, Hans Verkuil <hverkuil+cisco@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, 
 Stefan Schmidt <stefan.schmidt@linaro.org>, 
 Hans Verkuil <hverkuil@kernel.org>, linux-kernel@vger.kernel.org, 
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
 Stanimir Varbanov <stanimir.varbanov@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
 Mansur Alisha Shaik <mansur@codeaurora.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Bryan O'Donoghue <bod@kernel.org>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <20260818-iris-fixes-dma-pseq-fint-v2-2-8dc8c4b3880e@oss.qualcomm.com>
References: <20260818-iris-fixes-dma-pseq-fint-v2-0-8dc8c4b3880e@oss.qualcomm.com>
 <20260818-iris-fixes-dma-pseq-fint-v2-2-8dc8c4b3880e@oss.qualcomm.com>
Message-Id: <178708994427.782078.4185269965925097284.robh@kernel.org>
Subject: Re: [PATCH v2 2/5] dt-bindings: media: qcom,sc7280-venus: Add
 dma-coherent property


On Tue, 18 Aug 2026 21:24:15 +0530, Vishnu Reddy wrote:
> The venus video hardware on SC7280 is IO-coherent hardware: even though
> the driver does dma_sync*() calls for the input and output buffers, the
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
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml: Unresolvable reference: /schemas/input/qcom,spmi-haptics.yaml#

doc reference errors (make refcheckdocs):
Documentation/translations/pt_BR/process/security-bugs.rst: :doc:`regular path submission </../../../process/submitting-patches>`
Documentation/translations/zh_CN/how-to.rst: Documentation/translations/zh_CN/xxx.rst
arch/arm/xen/enlighten.c: Documentation/devicetree/bindings/arm/xen.txt

See https://patchwork.kernel.org/project/devicetree/patch/20260818-iris-fixes-dma-pseq-fint-v2-2-8dc8c4b3880e@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

