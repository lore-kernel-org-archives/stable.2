Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9935A3ED5A6;
	Wed,  5 Aug 2026 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785926236; cv=none; b=H8GO1pkDOBkUgWevVwTIoCCiZVYvVDCLzJuDzb+vz3ZFUSoui53LlzcwEGnQkwrTQ4mvHLzi42xK7OnPk31fxOxmFU5xad7QAiY740UgqxalSuXoZ4Nsos2ojdQgXKCx1/KmtyQZCqpcYTIvwAw9Mx2vb0aUg353Cu10pB/Au8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785926236; c=relaxed/simple;
	bh=6j74S3cLexqcLITvrHeMVBeyygoGrT/agJwd49sR8a4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BxDK3c5v/vDo2gi0qVvAsj/VQclg+ZeepFG/sQrpoH3942q6e7lmZ+AzaF7dVUfCbF/O8OET1q7vcUrz8EIqyf0syMJtTTW2SmqVkBqeZ5vV8CL5UuW8K+HNcpejj0VpZoDdux8mHLjcN9xRH5r75PnFt1NliMd1fNLp2bmjRzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJepDiKe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJepDiKe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382451F000E9;
	Wed,  5 Aug 2026 10:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785926235;
	bh=OAxwhBYIO95KtDIaoXuab1su0SLSJjFZiFHG87J7N2Q=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=BJepDiKe+Sd7spZkhxuxchfNjxKGkO5940nQaPLmacy37k8Os0H2vbNZEv880R3f6
	 8LG8UaWuZ0VbfEzFqjzEa/fr2/X4bFjX3UV0zJGyZNt9q9STu6vhsA4NDJUQFI/Mbv
	 A6qayWRIbLRZOrAXRkJNZOfdeE2MWoZh5HxOUnVaYPQVZmYac9gVVnC3PMqcKs9420
	 6HfsAHmnQuZ7eYdiAKo+7W+IdRr2SStKs2U/RNp4p17pVcLuh7q/SRh2WGyYtJQj5Z
	 nCuNXKsB3hdDGoslSTZP1H8M+lCXcxUjv1HBEZTijhjXHVNeTsSUG4x9ih0GhEPOT4
	 hiW5jp+q7lNYw==
Message-ID: <7a546bc6-a2b4-457d-ac27-05fc1cfe17f5@kernel.org>
Date: Wed, 5 Aug 2026 12:37:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] dt-bindings: media: qcom,venus: Add context bank
 subnodes to common schema
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio
 <konrad.dybcio@oss.qualcomm.com>, stable@vger.kernel.org,
 Daniel J Blueman <daniel@quora.org>
References: <20260731-vpu_iommu_iova_handling-v2-0-da52b5228dbd@oss.qualcomm.com>
 <20260731-vpu_iommu_iova_handling-v2-1-da52b5228dbd@oss.qualcomm.com>
 <20260805-dark-voracious-jacamar-6aae4c@quoll>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGPBBMBCgA5AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJp2mE8AAoJEBuTQ307QWKbeaIP
 /ihHTkTW4KsN/DQ945JJbyu5tI0J80Wue7QyyLPglyKfhgb5cLLNPpOC8cCIJsc7+W3i2P38
 s2c1cOH6CYGE7E9ur3Vfme8NW2S2I/Z8VC7bZnzyS23wT17LrsdS/qCpx4o8U+pt/xdXDKph
 EGRYrIEmMpUWvyYzyYKGIe25FtaayIIKpq8eZYyFcp2f/sG5IkOW5uZzHPMPdcm87jU7fyuQ
 rAU2vx9r+ulUfQ/q9Z2roC/ode3l7t2pN7BCBCsUDp6JCrUyZrtT1e7EbA0ZRP3aOBNk2P2E
 DQOgJGjGdO5Yx2Y9LFtltu6JbsBJHi1syGRX3AtQYOMc4Y1WGoeZJmMlvKj2ZqqXNkcWi2DS
 IQEWB0uW6CqFsBBIMGDa+6OzdaVO/uAVXWDWml02Men3CILdI1MbVjoh8ECqYUY7OQ+JJvNN
 vnliuq5WM3Ghd3jg/LZZrxXjdIginRHFQCjIJYLKpLZWm1/iDFedcfzqRNYmTtqscdCNHW41
 oT3Z7BmO9xwdjuwBS6nmS6JJwkbf5Ot2QR4pB/DRU7ZwjT1qHe+9r9gF32wXVQatHNGK/VVu
 sfwOnkdxCWkp/qb2gdQRmZh+SedStWshigH6sNfuHBloF/q+hjMRc8b2m326OZdrbSHwY1Sz
 vti8Hn7n8NjdHO9LKB7BIdjkA9DA5WsqOuVCzsFNBFVDXDQBEADNkrQYSREUL4D3Gws46JEo
 Z9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLueMNsWLJBv
 BaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6eiOMheesVS
 5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wAGldWsRxb
 f3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA6z6lBZn0
 WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9YegxWKvX
 XHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt91pFzBSO
 IpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gUBLHFTg2h
 YnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/JoFzZ4B0
 p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu4vXVFBYI
 GmpyNPYzRm0QPwARAQABwsF2BBgBCgAgAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtBYpsFAmna
 YUkACgkQG5NDfTtBYptX+BAApg32CkxwNucNEi8WfWA8oKkW0y8YDuY6ORMo9FWNGiT/OTy0
 vyJrLocrpn86zwfjVp+eCrssPYh8eqJfnWqmYv6ACQtHPYzPZQ3mSo8H97Z01oUxITzCxpXm
 ZkLgPIqtDPcC2E3dPM/fVxcyowM8XsaMA9wcsaUYrta8toOq2b9tKcjleKMfMrm0gQ9u7wUc
 QbLkwj6TCLOwucb07GXzLTNF9PZmaDUpKAZjMjmrW+le+SFvQbhamx0rxLWPR0NWntXpbCn+
 +ACch03p/JyTBVktxFsFyCt7pTPE1kEaeuXBTe/a2D9iQvRxRW19LvuO2e59/u1wYUiH/orz
 wbIC2S4dBsPAPihL3ztOU1yE86GPyQtSE0kU+/7snnLt4QGi6PChf3t5gnNjAzjUUovO8rgI
 c+5yN5heq5loYHgK6OQ9OlHzsPHO9e9MOQcKlFycs1pyijFGzDwdNUm/SchK8iWT2QApTx4A
 K9bCVaboTA2T77QYkRcRJYSsO1alGX0ome/hMLD1daXlkrNUp1HWa3K4iytLRXjCSIorWiGs
 n+q3krnpXu3TFkA8qtOFZMdnIiFuiq1yLT8hptsV5xh1TA2nsVvSYiaCr3q4s4BKjS/KrLDb
 qoxzw8ISjdUp4pA85vb6YLCmb39NgidD+7PmAr65lBNveIFynTgsja1rRQ4=
In-Reply-To: <20260805-dark-voracious-jacamar-6aae4c@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/08/2026 09:21, Krzysztof Kozlowski wrote:
> On Fri, Jul 31, 2026 at 11:52:16PM +0530, Vikash Garodia wrote:
>> The VPU issues DMA through several SMMU streams, and the hardware does
>> not give every stream the same addressable range. The non-pixel stream
>> is restricted to use 0-600MB of IOVA space, while the pixel stream can
>> address the full range:
>>     +-----------------------------------------------------------+
>>     | non-pixel stream addressable range (600 MB - 3.5 GB)      |
>>     | 0x25800000 - 0xe0000000                                   |
>>     +-----------------------------------------------------------+
>>     | pixel stream addressable range (0 - 3.5 GB)               |
>>     | 0x00000000 - 0xe0000000                                   |
>>     +-----------------------------------------------------------+
>> A single "iommus" property on the video-codec node puts every stream in
>> one IOMMU domain sharing one IOVA allocator, so nothing keeps a
>> non-pixel buffer inside the low 600 MB. Once an allocation lands below
>> that boundary the hardware faults, which shows up as unhandled SMMU page
>> faults and spontaneous reboots:
>> https://gitlab.freedesktop.org/drm/msm/-/work_items/100
>>
>> Describe each stream as its own context bank subnode instead, so that
>> each can be associated with the IOVA range its stream can actually
>> reach. This limitation applies to every VPU generation, so add the
>> subnodes to the common schema rather than to each SoC schema
>> individually. "video-firmware" moves here from qcom,sc7180-venus.yaml
>> for the same reason; it is the same kind of node and was already
>> duplicated per-SoC.
>> Adding the subnodes requires two supporting properties on the parent
>> video-codec node:
>> - '#address-cells' and '#size-cells', both fixed at 2. These do not
>>    describe registers on the codec node. They set the cell widths
>>    used when a reserved-memory node names one of these subnodes in an
>>    "iommu-addresses" entry: of_translate_dma_region() reads the
>>    address/size cell counts from the parent of the phandle target, not
>>    from the reserved-memory node. Pinning both to 2 lets a subnode be
>>    referenced with a full 64-bit IOVA base and length, and keeps the
>>    encoding identical across SoCs, whose buses vary between 1 and 2
>>    cells.
>> - "dma-ranges", empty "dma-ranges" states the intended translation:
>>    the subnode DMA address space maps 1:1 into the parent's, so an IOVA
>>    reservation written against a subnode needs no offset applied.
>>    of_translate_one() treats an empty "dma-ranges" as exactly that
>>    identity mapping.
>>
>> The parent's "iommus" is kept as an alternative via "oneOf", so
>> platforms that have not been converted to subnodes still validate. New
>> platforms should use the subnode form.
>>
>> Fixes: 41661853ae8e ("arm64: dts: qcom: sm8550: add iris DT node")
>> Cc: stable@vger.kernel.org
>> Tested-by: Daniel J Blueman <daniel@quora.org>
> 
> Not a valid tag.
> 
> 
> 
> 
>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> ---
>>  .../bindings/media/qcom,sc7180-venus.yaml          | 15 -------
>>  .../bindings/media/qcom,venus-common.yaml          | 51 ++++++++++++++++++++++
>>  2 files changed, 51 insertions(+), 15 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
>> index b21bed314848480b82153e49602f0b19e08e7335..bfd8b1ad473128c974bce84639cb0aff59d8c2cc 100644
>> --- a/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
>> +++ b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
>> @@ -91,21 +91,6 @@ properties:
>>      deprecated: true
>>      additionalProperties: false
>>  
>> -  video-firmware:
>> -    type: object
>> -    additionalProperties: false
>> -
>> -    description: |
>> -      Firmware subnode is needed when the platform does not
>> -      have TrustZone.
>> -
>> -    properties:
>> -      iommus:
>> -        maxItems: 1
>> -
>> -    required:
>> -      - iommus
>> -
>>  required:
>>    - compatible
>>    - power-domain-names
>> diff --git a/Documentation/devicetree/bindings/media/qcom,venus-common.yaml b/Documentation/devicetree/bindings/media/qcom,venus-common.yaml
>> index 59a3fde846d2196ab1e4588eb396012ba6860712..ccae41bed757bf3d9518cd4afe4565f043b45166 100644
>> --- a/Documentation/devicetree/bindings/media/qcom,venus-common.yaml
>> +++ b/Documentation/devicetree/bindings/media/qcom,venus-common.yaml
>> @@ -47,6 +47,50 @@ properties:
>>      minItems: 1
>>      maxItems: 4
>>  
>> +  dma-ranges: true
>> +
>> +  '#address-cells':
>> +    const: 2
>> +
>> +  '#size-cells':
>> +    const: 2
> 
> Above do not look valid. You do not describe the addressing of some
> other device node (not a child) here. You describe that addressing in
> that other device node's parent.

As we talked offline, these are actually needed for dma-ranges, but I am
honestly confused whether we are representing this correct.

dma-ranges tell how this bus - so venus/iris - performs DMA translation
in respective to parent. Address/size-cells are obviously also needed if
this is a bus with addressing.

But there are no children with addressing, thus what sort of bus would
it be?

It looks to me that having here both:
1. dma-ranges + address/size-cells
2. children without bus addressing
is some sort of abuse of the DT syntax. It is allowed, but does not
really represent hardware.

IOW, dma-ranges alone feels okay, although unusual, and it states proper
DMA translation for this bus. If you add address/size-cells, it means
this bus HAS addressing and thus YOU MUST use addressing.

If my understanding is correct, then solution would be to add addressing
to the children (so unit address and "reg" property) or drop
address/size-cells as Rob pointed out. [1]

If kernel disagrees with the latter, then kernel is wrong, IMO.

[1] https://lore.kernel.org/all/20260716165434.GA290489-robh@kernel.org/


Best regards,
Krzysztof
