Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6B675809;
	Mon,  8 Jun 2026 04:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780892175; cv=none; b=n+TEJP6zkx5XSlDj/0VzIH+KdzPcK8n0NcD3yEEoff2NzPcGWe+v4Dwurl1Iu9p0rA/mNzbV+cPfRjWYI2kkrRSVhmVnVXp+cM1Ozoz/PHtCmpg6JBUFasTIEqpTPXAGqb1fEL9ts9gcdj6PpBU6JEEBDReZITQK4n+frvm2t1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780892175; c=relaxed/simple;
	bh=YmBFGh6OqqdfCwFRHu4pem9rD5jhpqP1ykVz6uTzM7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSexgIWC9coTRrnIJNosoV8JqjZaXZntFXRv8hB46i9ky01Wul+FJ2JJQipJDce8pS5qgQikINCX7QftTdZpfwHBBj1gD1s+UVeHnEhqr2wV1AuiAeDTI0phgOPdfVSsQYXtK/qwIND2rBd/XH/3csOVDiqVcDXAxbgjYXWR8Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpgz1t1780892129t68dedcff
X-QQ-Originating-IP: kLOHYzZH5ZNN56hgnufq3vuFP2j+0x+tfhxzFbkzXkk=
Received: from [127.0.0.1] ( [116.234.26.110])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 08 Jun 2026 12:15:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10463631921484763401
Message-ID: <519CAAC5BE344EB7+e6d7f90a-e481-468c-a987-dac3c69d7362@radxa.com>
Date: Mon, 8 Jun 2026 12:17:57 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: hamoa: Reserve low IOVA range for
 Iris
To: Val Packett <val@packett.cool>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
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
 Bryan O'Donoghue <bod@kernel.org>
References: <20260601041336.9497-1-daniel@quora.org>
 <ecavEnqJTDXvfFykc9uJb5No7ioighpjrCdw2CFZ4c8Izr5DxpTs-606Bg7K0RtHTaOqksWivHxWQLzMBP6qow==@protonmail.internalid>
 <20260601041336.9497-2-daniel@quora.org>
 <ec7c564e-745a-4998-af9a-e9632fe063f7@kernel.org>
 <CAMVG2ssnyH=KUKrdfnUOtPYU7p17inyzcYWcKhT4EAZxDzDjfg@mail.gmail.com>
 <cb37e7cc-4fb0-4c24-8f89-f6f9eb08a107@oss.qualcomm.com>
 <ff3748ef-cf75-42b3-850c-b8742a814920@packett.cool>
Content-Language: en-US
From: Xilin Wu <sophon@radxa.com>
In-Reply-To: <ff3748ef-cf75-42b3-850c-b8742a814920@packett.cool>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Nr7EfX/rtCyrTbSevDAI1CO8hHmQl9GEJOhwPbF8ZUIVxVzI/AEwS3KY
	AOqm12IB7uCHq4deXkPA1XGidSo52ZXKC38uqkw6EKhGMTVaH53s2wd9ubuGf/n45NbhwoY
	dYqljM2E+Br/+ANw1HS0D8HvEMdc8xl54eb7AN2wIEOT8nhhCOrgk8dSv3afOmU8hdBjKpb
	wXT7vWRzYyjDyElWk5pHkVkcotW2rleZKiZpBAa2A1UodI5/GwtQE8nKf8Bp+wmG7QVuZOd
	U2reKjYFas4BMn77nK5G1ZplpzhT1JP/i0VmDXvKDldnE8Osjuo+mP0a0+Di72ofNZVmTgc
	NsLBh3HPFDeoGG+TE+y26cxzv7TkthlhH4u7xzwpinev45lpbnDw1omGA7twIx8QBcRg6WV
	lHNqCcSUf70RZ5caG3YGKrIOC9cKepq6ryOq1kgl8Okyclxw4xt4SGiJOAQvSbjIWw+f7tq
	JXCLxwvSRyNgR+gltXFS+W3+nXvTku7cVEI23mhbBmRGmOr9gKiGFphevfUBTtvSbA606R9
	WnshaN5xylTXCdz6J1GiNm1koK91Bq+AYHqCThUe5sHoJqTN+QFm1e5TDaQSkFD3nxKEiWz
	GYCENhBPlAan6h99oAX2h7JtMc2iycBZFeh9Q1zIsdZemIcZinya1IOMGfRBcBdxujd3GaL
	2JiU18g6Pna/YXqZQyk7W6mqtQZxwOdSLVaWcq88H7OWf8tX+KTvaIikyABNsJG6OwaB2fi
	MPtvaTt7ZZVnIlUpB9qw7Msu4rgBqkvWRxhMJsKW7muVsv7QeZAZj3aD1B9+l9IQ0Hus3xQ
	nGfvudTK6Yx6SgkildU2ksTzc8sb5DDXeemzN6OVxA5BoGfn7qjc/S51vnk/+aylsIlKcZ2
	USRCHb+wNuz8pXqBK95Oy/cs0AniMVV8vaOLszfHUR9qCZ9gZvEb7mAMxEO1Dzp6AlgA353
	E/jc70VE/Z03xNSMyjDca5j9NtafMZOH9dTIA45LIQI1kknqYn3Rrfd8OGjyLJ4MY4178Eh
	eZTLI3sWH5Bumoco42wU141RTWDzjI+JtxD42te1/eeO6PPpRzOABiCzR2tMco+9WuoU1HA
	WFDyY0iTqI4oAd7POIKfhw=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

On 6/8/2026 11:48 AM, Val Packett wrote:
> 
> On 6/4/26 3:38 AM, Vikash Garodia wrote:
>>
>>
>> On 6/2/2026 9:05 PM, Daniel J Blueman wrote:
>>> On Tue, 2 Jun 2026 at 18:27, Bryan O'Donoghue <bod@kernel.org> wrote:
>>>>
>>>> On 01/06/2026 05:13, Daniel J Blueman wrote:
>>>>> On X1-family hamoa platforms, Iris DMA below IOVA 0x25800000 (600MB)
>>>>> triggers unhandled SMMU page faults
>>>>
>>>> How do we know that is a correct address - does it come from qcom
>>>> documentation or trial and error ?
>>>
>>> @Vikash, beyond your comment I linked in the patch [1] kindly cite a
>>> source for the different stream-ID <600MB behaviour, and share
>>> specifics, eg if silicon, firmware, or driver and constraint, defect
>>> or otherwise, so I can include a definitive description.
>>>
>>> Also good to know if my workaround is good for long-term, or on the
>>> other hand handling streams <600MB is important/useful.
>>>
>>
>> Thanks Daniel for raising this patch. Did you also try the memory fix 
>> i mentioned in the bug [1] discussion ?
>>
>> Coming to 600MB, this have been the VPU hardware restriction all the 
>> while since venus days, and since address could not go deeper all the 
>> way lower than 600MB, the issue never popped up earlier.
>>
>> Consider the memory layout split as below (Iris device range is capped 
>> to 0xe0000000)
>>
>> |-----600MB-----|-----(0xe0000000 - 600MB)-----|----IO reg--|
>>
>> 0-600MB range, VPU hardware would reserve this to generate different 
>> stream-IDs primarily for internal (non-pixel) buffers.
>>
>> 0-600 --> VPU would generate *secure* stream ID for non-pixel buffers
>> 601 - 0xe0000000 --> VPU would generate non-secure stream ID for non- 
>> pixel buffers.
>>
>> When many concurrent sessions were tried, non-pixel buffers were 
>> mapped into 0-600MB range, and VPU generated secure ID for those. 
>> Since those were not associated with the iommus configured for iris 
>> node, it led to USF (un-identified stream fault) and device would crash.
> 
> Umm.. is anything *actually* preventing us from adding the "secure" SID 
> to the iommu node?
> 
> I just saw a patch for sc8280xp that did just add an "extra" SID for iris:
> 
> https://github.com/strongtz/linux-radxa-qcom/commit/ 
> e92850f792498c3a72d72d667503a29bf6bb0a31
> 
> and I'm wondering if that's about the same exact issue.. (Adding sophon@ 
> to Cc: here)
> 

I'm not sure if we're having the same issue. Without adding that SID on 
sc8280xp (HFI Gen2 FW), it fails to decode anything and crashes 
instantly. From the trustzone log inside the crashdump, I can see that 
the buffer isn't actually in the 0-600MB range.

-- 
Best regards,
Xilin Wu <sophon@radxa.com>
