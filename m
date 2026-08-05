Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CAD3CA4BB;
	Wed,  5 Aug 2026 04:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785904881; cv=none; b=GTEGJ/wZSPFRjB6Injmi8bJr/+ZNltBvoDMzLqmmzXqrHGbncN6CdW8FurkERkG9S3940inbvm6L7NOK/vgF+oTiUqpBG9wYRwVpkEAsSccHl2KfAYhCbLNbIMWikREKIMLTf4e/rqXOBvHVSkivttYneUAvYjrIdyn2Ww/T294=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785904881; c=relaxed/simple;
	bh=s40AJqnSS2nUQMj0XkNHWgC2nw875jk0mOQ6JXyH1Ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QbIVXJIxSD5kzBPkZUZp0aKpXVPHNuPnVD/lTYX4CE6+KuUsohskV7F+PySfhRYNPuOWyzJ7rM894AE5/sLxiTN1unw6VpWk2nBo/q4r4z65PgBW7KtAnMnW5BikvR97JTz2dC363pTUV4i6b4SZu1UWNbWFpt58SSZ73D0nMtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBs52w2C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBs52w2C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064311F000E9;
	Wed,  5 Aug 2026 04:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785904880;
	bh=fmohnf+NExslodc8sYpAp9UQ+h99Uy9SYCNVeDX+0lA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fBs52w2Cp47y3AkdwpCin6AnrvtH3ETejSEPLKhsdvqz2uEVH+o1ty1NNpkulxK9k
	 HKELPb8v8yF7JcrmggOl4A5vIg9+OHXA6m39JPC7nEQms9N5gEM/27XkujWnF+xyZz
	 5M5mSt80xP25E8rmejfjSczxvElS1mWBW5wVegSskbrzUieRiujClPmuDCFouFT2lx
	 cYfRPGVuD9N61+lrCHdDRODu75uWQJ9WffeBgcYDI/wLet63N33avssQRT2oE4E7mz
	 HD4lJUOPeTdgBtIKiaiTukvjmeDhp5s9/VMtddrrJ5RJYP4/0Uhq2vGskxBp5y1AdC
	 u1sr3dUqwc3Rw==
Message-ID: <a68056fe-75d1-4ff6-82b0-954ee09183dc@kernel.org>
Date: Wed, 5 Aug 2026 05:41:14 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] media: iris: Fix DMA coherency, power-off ordering,
 and frame interval issues
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mansur Alisha Shaik <mansur@codeaurora.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Hans Verkuil <hverkuil@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <VEKY5BOnE_id6Ffw6u5r3P27fJtoDL7JS18ztQULo44427A70oT4o5SEHbD5wM4jJDH1CreNcmSnx_zfLLVi-w==@protonmail.internalid>
 <20260801-iris-fixes-dma-pseq-fint-v1-0-aba0cb22f6ab@oss.qualcomm.com>
From: Bryan O'Donoghue <bod@kernel.org>
Content-Language: en-GB
Autocrypt: addr=bod@kernel.org; keydata=
 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
In-Reply-To: <20260801-iris-fixes-dma-pseq-fint-v1-0-aba0cb22f6ab@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/08/2026 08:37, Vishnu Reddy wrote:
> This series fixes a set of issues found in the Qualcomm iris video
> driver and the venus/kodiak devicetree bindings:
> 
> - The venus devicetree nodes for sc7280-based bindings and the kodiak
>    platform do not declare dma-coherent, which allows the CPU and the
>    video hardware/controller to see stale or inconsistent data in DMA
>    buffers they share. This causes hardware faults on input and
>    corruption of captured output when the client dumps it, observed
>    while testing with some higher resolution clips.
> 
> - iris_vpu_power_off_hw() disables the power domain before disabling
>    the associated clocks, reversing the correct power-down order and
>    risking clock-controller access after its power domain is already
>    removed.
> 
> - iris_enum_frameintervals() advertised frame intervals as
>    V4L2_FRMIVAL_TYPE_STEPWISE with a fixed step derived from the
>    maximum FPS, which excluded valid framerates that aren't exact
>    divisors of the maximum and broke GStreamer caps negotiation for
>    those framerates. Switching to V4L2_FRMIVAL_TYPE_CONTINUOUS fixes
>    this.
> 
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
> Vishnu Reddy (4):
>        dt-bindings: media: qcom,sc7280-venus: Add dma-coherent property
>        arm64: dts: qcom: sc7280: Add dma-coherent property into venus node
>        media: iris: Fix power-off ordering to disable power domain after clocks
>        media: iris: Fix frame interval enumeration for non-divisor framerates
> 
>   Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml | 5 +++++
>   arch/arm64/boot/dts/qcom/kodiak.dtsi                           | 2 ++
>   drivers/media/platform/qcom/iris/iris_vidc.c                   | 4 ++--
>   drivers/media/platform/qcom/iris/iris_vpu_common.c             | 2 +-
>   4 files changed, 10 insertions(+), 3 deletions(-)
> ---
> base-commit: 415606a7be939835db9b0d6b711887586646346d
> change-id: 20260801-iris-fixes-dma-pseq-fint-8345b2d67e3d
> 
> Best regards,
> --
> Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> 

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
