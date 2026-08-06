Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DE23D7D70;
	Thu,  6 Aug 2026 10:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011520; cv=none; b=Im9vX4F6hdDzkbTkBjzrdUMspUWGqeDznVVf+Mu6KzJolE6Kz29z0/d9U2VK35Uw89Szg+ZmZAXUrNvKTSchYmtgSLblPqhxyf/rncaHh1iIxWRl/1avcx0WtqbjOxavnV3HtuPtOW8YopPZ16QNn6VqqzzUaQz5Th4Wh/2hYSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011520; c=relaxed/simple;
	bh=a/ktzM+M5NJYxFpdP7NSDQ/AP6CYbmbaQ3o9nnBo8kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h87eQTY3uk+YppBWmn3hCvRY/HyIYlB/imUkbleLZXi3vAFNG2tt8XY7RrZzYtswDoivSH9FtYRAH8hRIvy/HcGQJsfW5jxSR0YdiiFi8nyDNMsNU+8+L4iR1M45Oc26KA3U0bTmNyrUtnDPqMBRc1WlxDTI2uHSoW6XaP5nrHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMcD5jJG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMcD5jJG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC43F1F000E9;
	Thu,  6 Aug 2026 10:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786011519;
	bh=AuCl1BP2ZnvHnrPdM8vJ14bFDLWZlulNvgD/oSTdoFQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FMcD5jJGfLn/oTIhXTMG0/8x13GSrVz1mNbmeKN30b23v38HrRCdaJcc9lz+XyY8j
	 wRB+x4VI+jpGuFKP5Y2twEG1qZEqcqfLxLkqvqYZzMJdGOH+d3iDem2yMaCTHzbTHA
	 jp77vwib+kWvxe+Cm/MUH+OsskomOsDuB0xoqpTVMrC8DwlPqwNJeY/6BnbRRRmz37
	 8cOwPCpedJiFndFiOQRM7V2OO/8WHSFw1mUnaI3xbSZO5KjMknrnw4Q47eI13ZfZ9x
	 TVuOj/+y0Rm/SeZWI9aLI9uO/27f028elPvZWRRrBM62I7fOheCJUijZNfbEJ+MJZv
	 lD8WZxdxuZt3w==
Message-ID: <4460a2c3-6b4a-4a7d-ba86-51c1c8363781@kernel.org>
Date: Thu, 6 Aug 2026 12:18:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] media: iris: Add helper to create a context bank
 device
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio
 <konrad.dybcio@oss.qualcomm.com>, stable@vger.kernel.org,
 Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
 Daniel J Blueman <daniel@quora.org>
References: <20260731-vpu_iommu_iova_handling-v2-0-da52b5228dbd@oss.qualcomm.com>
 <20260731-vpu_iommu_iova_handling-v2-4-da52b5228dbd@oss.qualcomm.com>
 <o6s5kezlsbe6z53jbsezeixp2wfrmwmvwda67t6chf57jnbm3x@ta5hktzs7mdf>
 <36b53e0d-82e2-4fbb-a2b6-3fd7b9c98663@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <36b53e0d-82e2-4fbb-a2b6-3fd7b9c98663@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/08/2026 12:08, Vikash Garodia wrote:
> 
> 
> On 8/6/2026 2:27 PM, Dmitry Baryshkov wrote:
>> On Fri, Jul 31, 2026 at 11:52:19PM +0530, Vikash Garodia wrote:
>>> The VPU issues DMA through several SMMU streams, and the hardware does
>>> not give every stream the same addressable range. The non-pixel stream
>>> is restricted to use 0-600MB of IOVA space, while the pixel stream can
>>> address the full range. A stream can only be confined to its range if it
>>> has an IOMMU domain of its own, and the IOMMU core attaches a domain per
>>> struct device, so each stream needs its own device.
>>> Add iris_create_cb_dev(), which looks up a named child of the iris node
>>> and registers it as a platform device parented to the iris core. The
>>> child's fwnode is handed to platform_device_register_full() so the OF
>>> core applies that subnode's "iommus" property and the new device gets
>>> its own IOMMU domain. The DMA mask comes from platform data, and the
>>> segment size and boundary are capped at 32 bits to match the addressing
>>> the VPU performs.
>>> Return NULL when the named child is absent, so callers can treat a
>>> device tree without context bank subnodes as a supported configuration
>>> rather than an error.
>>> Backports are intended since the first DTS of 8550 binding schema.
>>
>> What does this mean in the commit message?
>>
>>>
>>> Fixes: 41661853ae8e ("arm64: dts: qcom: sm8550: add iris DT node")
>>
>> How can driver fix the DT?
>>
> 
> The idea is to backport the driver fixes till the kernels when the first 
> DTS landed. Ideally the fixes tags the commit which introduced the bug, 
> while in this case, was thinking to keep it for DTS.

Fixes tag does not represent the backport, so your idea is wrong. You
point here to the commit which introduced incorrect code.

If DTS is incorrect, then a DTS patch fixes it. How a driver can fix
DRIVER-INDEPENDENT hardware description? It's contradictory to the
"independent" part.

Best regards,
Krzysztof
