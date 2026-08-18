Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8F4359A89;
	Tue, 18 Aug 2026 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787080047; cv=none; b=OeHCfHt0Fe9xciGaZqyUcgX6zJS+qKk+PwbIw1EKDrkI3GQ8HHghTOSe7vjB163n3KVGD+xbruwoDgN1sSmqGtIk+l3St1NAnLjme8/HQEwqMKkoSN9jeK4GY7m/QrKJ6qVJ9VCXvgnXPsMRUIbrnpF26UEwSjGez1qR8L+PIb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787080047; c=relaxed/simple;
	bh=oQsN0JDGE+ID28UHRXZtravvONZsfHiP09AINJ4C7YM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QaLptskz9nHFvl/E95ah0ABLwrYTDl3A+eQiWOlUmrqKYAvxZRF+BhyXJg90Txm8L1QfUeMwakjtvtqmCNKo+z9vTpwNEmvRQNQLGU2J6qntKQStDiFAU4gEAP50P+bQM1Q+rj3UxrNQnshHuU+ay9Nix1VBnzKdotnAkVJD+FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcKAFk1A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcKAFk1A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88141F000E9;
	Tue, 18 Aug 2026 19:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787080045;
	bh=QfhtHHt4kUbNni13r0FOvSWk4317t9VwKtP/rNfP/p4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IcKAFk1AuDKzUEQsW9942PhLfDpvNIfyPqUnBITnE9A5fUjANnRrQrAPnBrq/YanY
	 HNKgsXveJFugbmFuzDnQYw6nH/bov+lEI9/O1D4W+siL3PidmQRAjRTWMUYpt8ou/B
	 cI/RONxKOJ5ge0n/oLkurtb15FnLhlAKHZEj6J6r4iGODc5ODOtK2PTQFkJbdVTtMI
	 UqIRP5EpE6k6x57x+pbkcaGXjf2DM//jSfJWp+aymLd0uGI6YRv5YEkdk8YZ45DZNX
	 hc48dyIiuS/9ML+GMn79nW7u6aNvcm86TVhsXivZHnxJ8T8bJV3TJxRxxV/pL5V8QJ
	 uaLvHvQaAFlDA==
Message-ID: <5b3cac01-075d-4f21-83fa-31cefd76ffe5@kernel.org>
Date: Tue, 18 Aug 2026 21:07:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sc7280: Add dma-coherent property
 into venus node
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
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
 Hans Verkuil <hverkuil+cisco@kernel.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260801-iris-fixes-dma-pseq-fint-v1-0-aba0cb22f6ab@oss.qualcomm.com>
 <20260801-iris-fixes-dma-pseq-fint-v1-2-aba0cb22f6ab@oss.qualcomm.com>
 <20260813-frisky-augmented-crow-fd5d3d@quoll>
 <4b34e718-0878-25cc-a5bd-0d8858df5133@oss.qualcomm.com>
 <30195e14-0dcb-476d-af0d-f85ee57e2aa5@kernel.org>
 <e287e538-135a-4eb7-1b21-55b475c844e0@oss.qualcomm.com>
 <26a880b2-5f37-43be-ae8b-2c0c27c777a1@kernel.org>
 <c03354d1-843c-af24-0e7b-a4c0cfb8e001@oss.qualcomm.com>
 <ed6c14b1-49b4-44ba-87b1-65b685e6c25c@kernel.org>
 <25b990fc-558d-d64b-1a5d-e593f4c8d649@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <25b990fc-558d-d64b-1a5d-e593f4c8d649@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/08/2026 12:57, Vishnu Reddy wrote:
> 
> On 8/14/2026 3:56 PM, Krzysztof Kozlowski wrote:
>> On 14/08/2026 12:24, Vishnu Reddy wrote:
>>> On 8/14/2026 3:26 PM, Krzysztof Kozlowski wrote:
>>>> On 14/08/2026 11:49, Vishnu Reddy wrote:
>>>>> On 8/14/2026 12:01 PM, Krzysztof Kozlowski wrote:
>>>>>> On 14/08/2026 07:29, Vishnu Reddy wrote:
>>>>>>> On 8/13/2026 2:49 PM, Krzysztof Kozlowski wrote:
>>>>>>>> On Sat, Aug 01, 2026 at 01:07:28PM +0530, Vishnu Reddy wrote:
>>>>>>>>> While testing with some higher resolution clips, the venus hardware
>>>>>>>>> triggers a fault due to wrong input data being received. Corruption
>>>>>>>>> was also observed in the captured output when the client dumped it
>>>>>>>>> to a file.
>>>>>>>>>
>>>>>>>>> On debugging, this was traced to the venus node not declaring
>>>>>>>>> dma-coherent. As a result, DMA buffers shared between the CPU and the
>>>>>>>>> venus video hardware/controller are not guaranteed to be I/O coherent:
>>>>>>>>> CPU writes to an input buffer can remain in CPU caches without being
>>>>>>>>> visible to the video hardware when it reads the same buffer, so the
>>>>>>>>> hardware receives input data that does not match what the CPU wrote.
>>>>>>>>> Likewise, on the capture path, data written by the video hardware to
>>>>>>>>> the output buffer may not be visible to the CPU, so the client reads
>>>>>>>>> stale or partial data, resulting in corruption.
>>>>>>>>>
>>>>>>>>> Add the dma-coherent property to the venus node so that DMA buffers
>>>>>>>>> shared between the CPU and the video hardware and controller remain
>>>>>>>>> coherent.
>>>>>>>>>
>>>>>>>>> Fixes: 37613aee2179 ("arm64: dts: qcom: sc7280: Add venus DT node")
>>>>>>>> Really does not look like a fix. How skipping a cache sync can fix
>>>>>>>> anything exactly?
>>>>>>> dma-coherent tells the kernel that this device DMA path is hardware-coherent,
>>>>>>> so the SMMU maps its buffers as cacheable. That attribute is what causes the
>>>>>>> coherent interconnect to snoop CPU cache lines on every VPU transaction, so
>>>>>>> hardware keeps CPU caches and VPU-visible memory in sync — which is why the
>>>>>>> dma-coherent property lets us skip the unnecessary cache clean/invalidate.
>>>>>> You just repeated what I wrote. What for?
>>>>>>
>>>>>>> If a device doesn't support I/O coherence, its buffers would instead be mapped
>>>>>>> non-cacheable, no snooping would occur, and the driver would need explicit
>>>>>>> dma_sync_*() calls at each transition. Venus on SC7280 does support I/O
>>>>>>> coherence, so dma-coherent describes that existing hardware capability to
>>>>>>> the DMA subsystem.
>>>>>> How does this anyhow explain your commit msg? Are you saying driver is
>>>>>> buggy that it misses sync calls?
>>>>> No, driver is not buggy here. dma-coherent flag is missed in the dt node.
>>>> Again, no... or explain why. Missing dma-coherent is not a fix, but
>>>> rather optimisation, but you claimed it is a fix. Explain why.
>>> Is the dma-coherent flag only for skipping cache sync?
>>> I might be repeating here — it enables the hardware level snoop between CPU
>>> caches and DMA memory. Without dma-coherent, the CPU cache and the memory
>>> which VPU accesses aren't in sync at the hardware level, which is what
>> They are in sync, because driver explicitly MUST sync it.
> 
> No, currently driver is not calling the dma_sync*() explicitly.
> It won't be in sync. That's why dma-coherent flag added to keep the
> CPU cache and DMA memory in sync.
> Will you suggest to sync from the driver explicitly?

And we are telling you that this is the problem. Already in three or
four emails.

> 
> If we call dma_sync*() in driver, will you recommend to add the
> dma-coherent flag or not in the dt node?

I think yes, at least that would be my advice for every typical device
(and obviously necessity if you use streaming mappings). Your device is
DMA coherent so this will make dma_sync* operations no-op. Proper usage
of DMA API also describes the ownership of the memory between device and
CPU. IOW, lack of dma_sync suggests driver has incorrect or incomplete
DMA API usage and this should be fixed in the driver, not via DT properties.

Best regards,
Krzysztof
