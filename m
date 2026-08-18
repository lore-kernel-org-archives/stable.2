Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3DB3B3890;
	Tue, 18 Aug 2026 08:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787040343; cv=none; b=AYTfs6u8f3q1ysCpT9SDWQYK/1d2zloEDBNbSsPJ+ubI3NCiOCD8qUZ9MG+xRAOlBT0w7r9LD44hx7IXz7aBohsCLJYN11kL5WtyZWANZKEwGrY10nS4ya0cToredScgGgvo00AgL2ETR6st9g7cx7jYqYGXm4nKKU6hmWhKQwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787040343; c=relaxed/simple;
	bh=TU/Bhi2gM0JbuD7T7dXHtIUaqsKA7Qy/oEy19b8K54k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hZvuoHpyxl00Ivn2ZWP+5UHubo+Twa6kjL41yRZtFU7mtkxwIJCU0AJI3lar1Q8DkSzgTso7qhlzB1reN8sRNvvqCEUiOB+dfpXfnYDmJ18D9TMs6loDz769kaKFgobEl2C9lY0jkXrB685Wr6VWB59sS05B6zodrCMx3Amm0+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqDFHv9R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqDFHv9R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B34D1F000E9;
	Tue, 18 Aug 2026 08:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787040342;
	bh=YpSGMsOy5RXLf3ioYqkFCn2tDlBgIKiLUH4GctlGLi4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DqDFHv9RJxF/pEU65Azm6UpjE+K8uwh2MR6UAKdfDK/Abuu7rhAnrU6avvRkEQmNt
	 tbaK5DaT6ft3lHuk5FUsVDth0pIaFRxnyJoW0wHwVUHd1A5nO9hni3oDwCueOmZFGY
	 DiZVPg5H/wggC3Am29rnxLmIULdhyYO8OyuynFl4r7O9/yGsbObcuIdsg+9RNwr9wN
	 6TqzScmu7x8i4pyKsQlKpJ+Lx1wcu9pdJCRlQN4zEr4L1sGeWMJ6zK6d5PBbI6h0kY
	 VmdlsR390DTRCy/uiT+mqO4b71Q4iofbL/BVx2J/R07j6sxhnrh9ZmmdPuuSSFFQQS
	 7ItAwprXBrOnw==
Message-ID: <662f7093-fb0a-4564-9ca0-98e03e68ba9a@kernel.org>
Date: Tue, 18 Aug 2026 10:05:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/22] arm64: dts: qcom: hamoa: Reserve low IOVA range for
 Iris
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
 Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Johan Hovold <johan+linaro@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Mansur Alisha Shaik <mansur@codeaurora.org>,
 Andy Gross <andy.gross@linaro.org>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Stephen Boyd <sboyd@codeaurora.org>,
 Yassine Oudjana <y.oudjana@protonmail.com>,
 Pierre-Hugues Husson <phhusson@freebox.fr>,
 Marc Gonzalez <mgonzalez@freebox.fr>, cros-qcom-dts-watchers@chromium.org,
 Matthias Kaehlcke <mka@chromium.org>,
 Douglas Anderson <dianders@chromium.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Aniket Masule <amasule@codeaurora.org>,
 Malathi Gottam <quic_mgottam@quicinc.com>,
 Rajendra Nayak <quic_rjendra@quicinc.com>, Jonathan Marek
 <jonathan@marek.ca>, Dikshita Agarwal <dikshita@qti.qualcomm.com>,
 Renjiang Han <quic_renjiang@quicinc.com>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Daniel J Blueman <daniel@quora.org>, stable@vger.kernel.org
References: <20260807-iris_iova_600mb_fix-v1-0-3996f67e33f9@oss.qualcomm.com>
 <20260807-iris_iova_600mb_fix-v1-4-3996f67e33f9@oss.qualcomm.com>
 <ruow4uus64krlpy2gvm3g2d6rq5kgmgxnlhstmecil3gw7lhkd@2golvucd473l>
 <20260807162405.GA896590-robh@kernel.org>
 <c3hVumMy_QnRbUmbFTSWGjkfG7lPjGFEcZfPsZeGQ57nWKkhlBL3wgmcDcAgT9cNb8Ju3qZ_sSKgHk8vmow0xQ==@protonmail.internalid>
 <6ee7f32e-eb6c-e264-6f0d-541555f8fd62@oss.qualcomm.com>
 <56b3dfcf-b1ad-4192-8199-06c80cc5d124@kernel.org>
 <Gm8h4cjoxHsgA2enLuxEd_3c_3Nq_RVJ9PkosuciOEss5Bw-GbnVoJCzsc5ciseK-L6bnlf9dbkbbh4ui3PSOQ==@protonmail.internalid>
 <CAL_JsqLGOz7Fh=AsM+g84=Uko10YXU4QN1buApD3CJMkOmsebA@mail.gmail.com>
 <e5e2d588-cee0-4105-b34e-34d2718786ee@kernel.org>
 <xbzl4s37jr3uzsd23kvphiguxmq4ngkajju4ifg76kwqrs4xrg@2egp56nwrxgu>
 <0bccfd31-dbbd-4bc7-9d9d-be048ef22b04@oss.qualcomm.com>
 <c339cbff-490e-42fe-a461-042fdd6bfea6@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
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
In-Reply-To: <c339cbff-490e-42fe-a461-042fdd6bfea6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/08/2026 10:00, Vikash Garodia wrote:
> 
> On 8/18/2026 1:21 PM, Vikash Garodia wrote:
>>
>> On 8/18/2026 11:53 AM, Dmitry Baryshkov wrote:
>>> On Mon, Aug 17, 2026 at 10:54:47AM +0100, Bryan O'Donoghue wrote:
>>>> On 10/08/2026 14:47, Rob Herring wrote:
>>>>>>> As per the reserved-memory.yaml schema document, the iommu-addresses
>>>>>>> property for IOVA reservation into /reserved-memory is allowed — it's
>>>>>>> documented for IOVA carveout reservations:
>>>>>>> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/
>>>>>>> schemas/reserved-memory/reserved-memory.yaml#L56
>>>>>> I think that is an entirely reasonable reading of the text
>>>>>>
>>>>>> Quote:
>>>>>>
>>>>>> "If no "reg" property is specified, the "iommu-addresses" property
>>>>>>     defines carveout regions in the IOVA space for the given 
>>>>>> device. This
>>>>>>     can be useful if a certain memory region should not be mapped 
>>>>>> through
>>>>>>     the IOMMU."
>>>>>>
>>>>>> Which is exactly what this series does. Excludes a specific IOVA range
>>>>>> from being allocated for this device.
>>>>> But if "iommu-addresses" is the only property of the reserved memory,
>>>>> why put this property in reserved-memory rather than directly in the
>>>>> device's node? I'm only questioning where is the right place to
>>>>> describe a reserved IOVA.
>>>>>
>>>>> Rob
>>>>
>>>> Back from the eclipse, sorry for the delayed response.
>>>>
>>>> Ah I get you.
>>>>
>>>> Yes.
>>>>
>>>> I take your point. This is a property of the node itself; the IOVA < 
>>>> 600MB
>>>> only matters _if_ the venus or iris nodes are enabled - otherwise an 
>>>> IOVA <
>>>> 600MB is perfectly fine.
>>>>
>>>> So it follows its a property specific to this node not specific to the
>>>> overall system.
>>>>
>>>> Yep, I agree - its a device/node property, not a top-level property.
>>>
>>> :-)
>>>
>>> FWIW, I think it's a proper way to describe it too.
>>>
>>
>>  From my readings, a node defined under reserved-memory can have other 
>> properties like "reg" alongwith "iommu-addresses". Are we saying when 
>> *only* "iommu-addresses" is there, then move to the device and when 
>> other property is there, then move to individual device ?
> 
> sorry, typo. Pls read the last few words as ".., then keep under 
> reserve-memory ?"
> 
>>
>> Again the device may have the "reg" property already, in such case, 
>> moving the iommu-addresses + reg in corresponding device might not be 
>> feasible.

Your sub-devices do not have reg property, so there is no such case,
unless you meant the entire iris node?

Anyway, the point is that this does not describe anyhow system memory,
any reserved memory. You want to affect the device virtual memory
mappings and as such this is a property of the device itself, because
this is how we structure DT. Attributes of devices do not go to
top-level but to the devices themselves as properties.

Best regards,
Krzysztof
