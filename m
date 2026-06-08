Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3278D54654;
	Mon,  8 Jun 2026 03:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780890551; cv=none; b=lvOCR2ttfYBAhgvP/KZjqAoiZWQfVkeD/L8FnXpp9gcg0+TcX15wJi1nbDhM3J68oaXAjxy+K9cT18yxFf+1nAUqeP67ixFI0vssP2l8AEIF3lZRh6ahaKlcXT4TCQvn3nxGTEOJvdlGdK3LSbxXLkwrsraDrv5Lg4uZSEntsyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780890551; c=relaxed/simple;
	bh=KFL5bv8OFk8aF4aDG6GfEVOlCyTfQOOh26CT0X317vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bzy8z2HhpB6ZbyZ+jXQXje+KiuTo8TT9QXnPSv44ayHhjsdBLS5Igw3xitpimp6zsMUR1edasDMTqYkKHtXdiZEZXB6PgiD3ZnSSO8ak82ZHjsFor9i5k2Xj7/JR22y/Vqe4ZWFzHc3wY1gbgx/0w5zNHKpvmDVZ1PCy8J2/sAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=PJdWabiS; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="PJdWabiS"
Message-ID: <ff3748ef-cf75-42b3-850c-b8742a814920@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1780890534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ixD0UqODeSKBYHAT0YqzVEOqtsHUd2w3XgZfWPYTogE=;
	b=PJdWabiS8Pg4g6omz/iGtK8qchoMRPy1WwvNmpTo/oCgYXWRg8g7VIzIMLHTtHhlr9Gsj5
	0AMrWsUGy4sXqo6+zlrOPMqBcc1upMA0G+1WXnDPbaEGCdo9+7dR9E7d8n1aHFABgPmIv8
	k4rMJUiMp88c2h4kaqiMRN3z2TFD1udXPz5lRDEwKwb7NJIRk4kzar2U1/BoAf1D+M234m
	++4C5KZqYaZC0iPQ6mkiTCiK0Bw0fUomc3OBgp9JByf02Oprq8fQqCu+YogO1NnFsyQpRc
	QVK2GXQNvWP52UVggU1ji5GCb1Y9RpZkCVdqaRIRev5lulDaDMI4F3YAozifqg==
Date: Mon, 8 Jun 2026 00:48:46 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: hamoa: Reserve low IOVA range for
 Iris
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Daniel J Blueman <daniel@quora.org>,
 Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Bryan O'Donoghue <bod@kernel.org>, Xilin Wu <sophon@radxa.com>
References: <20260601041336.9497-1-daniel@quora.org>
 <ecavEnqJTDXvfFykc9uJb5No7ioighpjrCdw2CFZ4c8Izr5DxpTs-606Bg7K0RtHTaOqksWivHxWQLzMBP6qow==@protonmail.internalid>
 <20260601041336.9497-2-daniel@quora.org>
 <ec7c564e-745a-4998-af9a-e9632fe063f7@kernel.org>
 <CAMVG2ssnyH=KUKrdfnUOtPYU7p17inyzcYWcKhT4EAZxDzDjfg@mail.gmail.com>
 <cb37e7cc-4fb0-4c24-8f89-f6f9eb08a107@oss.qualcomm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
In-Reply-To: <cb37e7cc-4fb0-4c24-8f89-f6f9eb08a107@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/4/26 3:38 AM, Vikash Garodia wrote:
>
>
> On 6/2/2026 9:05 PM, Daniel J Blueman wrote:
>> On Tue, 2 Jun 2026 at 18:27, Bryan O'Donoghue <bod@kernel.org> wrote:
>>>
>>> On 01/06/2026 05:13, Daniel J Blueman wrote:
>>>> On X1-family hamoa platforms, Iris DMA below IOVA 0x25800000 (600MB)
>>>> triggers unhandled SMMU page faults
>>>
>>> How do we know that is a correct address - does it come from qcom
>>> documentation or trial and error ?
>>
>> @Vikash, beyond your comment I linked in the patch [1] kindly cite a
>> source for the different stream-ID <600MB behaviour, and share
>> specifics, eg if silicon, firmware, or driver and constraint, defect
>> or otherwise, so I can include a definitive description.
>>
>> Also good to know if my workaround is good for long-term, or on the
>> other hand handling streams <600MB is important/useful.
>>
>
> Thanks Daniel for raising this patch. Did you also try the memory fix 
> i mentioned in the bug [1] discussion ?
>
> Coming to 600MB, this have been the VPU hardware restriction all the 
> while since venus days, and since address could not go deeper all the 
> way lower than 600MB, the issue never popped up earlier.
>
> Consider the memory layout split as below (Iris device range is capped 
> to 0xe0000000)
>
> |-----600MB-----|-----(0xe0000000 - 600MB)-----|----IO reg--|
>
> 0-600MB range, VPU hardware would reserve this to generate different 
> stream-IDs primarily for internal (non-pixel) buffers.
>
> 0-600 --> VPU would generate *secure* stream ID for non-pixel buffers
> 601 - 0xe0000000 --> VPU would generate non-secure stream ID for 
> non-pixel buffers.
>
> When many concurrent sessions were tried, non-pixel buffers were 
> mapped into 0-600MB range, and VPU generated secure ID for those. 
> Since those were not associated with the iommus configured for iris 
> node, it led to USF (un-identified stream fault) and device would crash.

Umm.. is anything *actually* preventing us from adding the "secure" SID 
to the iommu node?

I just saw a patch for sc8280xp that did just add an "extra" SID for iris:

https://github.com/strongtz/linux-radxa-qcom/commit/e92850f792498c3a72d72d667503a29bf6bb0a31

and I'm wondering if that's about the same exact issue.. (Adding sophon@ 
to Cc: here)

> Keeping the region reserved, makes the non-pixel buffer always in the 
> non secure range (601-..) and avoids the crash.
>
> Downside of this design - It would eventually reserve 0-600MB un-map 
> 'able for all buffer types, like pixel as well which do not have any 
> such restriction.
>
> Forward looking design - create devices dynamically and set reserve 
> regions for those specific device using the api [1], instead of 
> applying one reserve for all.
>
> [1] 
> https://lore.kernel.org/all/20260119054936.3350128-1-busanna.reddy@oss.qualcomm.com/ 



~val

