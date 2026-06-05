Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831904266A1;
	Fri,  5 Jun 2026 06:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642305; cv=none; b=aGIwetevorRNzsPSCEtoLfqwhFABV1m8Du3m7sCU1rqwGU+SB4aOsUYmwTPnh38eo2sIJ4FGb4KQNGubSy7SZsznExkV2g7QDD3oJcS02A2QuvfPsSlubDVwoh89o7iDYIYN4ctOBNJfL8TvohL9v8QyJOm0b60W+YKReIWtcUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642305; c=relaxed/simple;
	bh=0GRND5Ewt6cXLnjmO6nyQPz6mj3/NACWiJfXWMDSpXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tc99jQGdRP/XP8D5C9lEncyIk2Ah5WgHv9xdeohl+BR39++hXZ+lDGKyWCEBOKRvtYWjToBbh29mI/l5Ocx7/OgKUaBvfA1X/46QBvYKqWtbqZR3apncTt3mpGqlh7Di/6kyUwpW4JIdKhyKui6xKmfrIfCicNDmwkf02PPWknU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=GMn0VyBk; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="GMn0VyBk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780642252;
	bh=fcCoLgbGRFsEscMKd9ACVxdk//KZN9GsWeew7GW6eiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=GMn0VyBkABQYJBLmo/dXtgavTtxIxvcI+uSjsZDtsL8hM8M772CxOsAo5UBLudfe7
	 7olVCMLls+iTNoJy34i4TxLatbAtSFniQAugYOTU7lLFQtsNoh0Zmwwmww4mo2qMk/
	 ZyyRUZaeMkS53Z+rk2EoYoGXMJ6LDBysfr15DUfk=
X-QQ-mid: zesmtpsz3t1780642249t5482864b
X-QQ-Originating-IP: 8+K/Zs9/X+TK3fr6lfPw+gApz3U20Ga2dKD/S6aS9P0=
Received: from [10.10.73.115] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 05 Jun 2026 14:50:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6908254221687791739
Message-ID: <18E186480A1197E1+43038b46-5635-4835-b01c-d64eacacea0f@uniontech.com>
Date: Fri, 5 Jun 2026 14:50:47 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] LoongArch: KVM: return full old CSR value from
 kvm_emu_xchg_csr()
To: Bibo Mao <maobibo@loongson.cn>, zhaotianrui@loongson.cn,
 chenhuacai@kernel.org, kernel@xen0n.name
Cc: kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260604123433.3182173-1-maqianga@uniontech.com>
 <08d3b817-9de6-746d-2b2c-acc4a578f95a@loongson.cn>
 <4CD61A5AB07B2388+7fa119a1-af5f-4def-b2c4-6073fc397b10@uniontech.com>
 <519ffada-5f2b-2896-30a8-9546d3795f62@loongson.cn>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <519ffada-5f2b-2896-30a8-9546d3795f62@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N4WhQbLQyIqSSc4Oc+Su76JEBnl0V2tgrOseoYUjpdfhjbfui4S4Eb2w
	nLjXTuBsi35/k0A5U2CCVdpfDOTfufDB5khxUCpwzVwGBR0+6oV1ZR6ea7CW+YfOKbpk3DQ
	y1Lk3puRx5N615c/qHneZkJfZkTQTRdUCJ10SrfdecT+NzJ6w79WIj8N6XU8T68qSf8Oyu6
	TGnU5B0qrSNdAsjSWq4Up+IVXZ6sCRAnRCWkfWwOvL8wshdBhGZh0rxj0rpWawQWkpcFyGT
	DzvxlmLH2iW/xY7VR0iUqQAssdeyvfpmkIQ4viIHAk3QHhjFryJ8KzzrstXSy1ncJiB9/ie
	cH8nqxJPP20x4BBig3ucFmWWVqQtAvjodgGAlnaX89IuCXu2/lZ5yPQaFnstnsgDxHB6gpL
	+FIfP/USpOgbAiuTeFc99d3EUG1m71LqFKB/UCqs/e9uw83ck4oLBphMRBnxkPHngtmkKCm
	DwnHZLNPiiJ+n8QzuspjBdUgUnosZIwna3On/zzVWfpKmXLoDQ5BWXDWdLtnC+vzKZ66YPw
	y5ekw4vOdZcwFMEz/sDymsy1DSY6mMK+qsVix4bXj6JkEAF2BPvLKAUXeAuiioP08Vuj77Y
	Z0IxooJxabH4c4oNe9f16uOOYTF9+hrvCqoW5NFiEpwQy0NT8E9E9CKMVxB7kN0YiPrglgx
	7XJP0z98ewr7/6zBD6jnt+ZC5hMqQbhOc8wXtzeKAATaYY/MWzz17U7fGaJS/tj9V1Pp5uP
	IgW7udljtfdeczw/tSnh+S9dpLG30djL5uxeu/nL/qmN+Q93MoCfWgavRumagVrU9l1f9AD
	S19ix9m0J03PQyu3HiHBMj94ihlkXIBlY5koC5SBdFeEQ2B6Ij15YQrj877zLxWqGqBp+gw
	vYdJBJIBqndPaR26aGm6squqdNIyS1DTwqpnOJRH3YKjthdaTX2lyEj72gCc77MAB0lgQNL
	rH10dT3RtRKCCHSlIx4hy6uvUZHRTkqeKYLWQuxBeIoUNsfqVx6eZvnI9PUe9eotQ55Jake
	QMbKqwC85I63x3qPCYfqIq3e2bTXOm40Qt/vnBHIbPx1qfXkGvze3DrVmPLovXGZNtgD/3X
	XcvJ+UhbLQTmT7wv2Sz4y8=
X-QQ-XMRINFO: Mp0Kj//9VHAxErtib8qEEVA+DLqTo30zhQ==
X-QQ-RECHKSPAM: 0


在 2026/6/5 14:27, Bibo Mao 写道:
>
>
> On 2026/6/5 下午2:08, Qiang Ma wrote:
>>
>> 在 2026/6/5 09:41, Bibo Mao 写道:
>>>
>>>
>>> On 2026/6/4 下午8:34, Qiang Ma wrote:
>>>> The LoongArch CSRXCHG instruction returns the full old CSR value in rd
>>>> after applying the masked update. kvm_emu_xchg_csr() currently masks
>>>> the saved value before returning it to the guest, so rd receives only
>>>> the bits selected by the write mask.
>>>>
>>>> That breaks the architectural behavior and makes a zero mask return 0
>>>> instead of the previous CSR value. Keep the masked CSR update, but
>>>> return the unmodified old CSR value.
>>>>
>>>> Fixes: da50f5a693ff ("LoongArch: KVM: Implement handle csr exception")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>>>> ---
>>>>   arch/loongarch/kvm/exit.c | 1 -
>>>>   1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
>>>> index 3b95cd0f989b..264813d45cbe 100644
>>>> --- a/arch/loongarch/kvm/exit.c
>>>> +++ b/arch/loongarch/kvm/exit.c
>>>> @@ -103,7 +103,6 @@ static unsigned long kvm_emu_xchg_csr(struct 
>>>> kvm_vcpu *vcpu, int csrid,
>>>>           old = kvm_read_sw_gcsr(csr, csrid);
>>>>           val = (old & ~csr_mask) | (val & csr_mask);
>>>>           kvm_write_sw_gcsr(csr, csrid, val);
>>>> -        old = old & csr_mask;
>>>
>>> Hi Qiang Ma
>>>
>>> This is correct from the manual. Is there any test case or problem 
>>> in practice?  I want to evaluate severity about this problem.
>>
>> Yes, I have written a selftest for this. Below are the test results 
>> comparing without and with the patch.
>>
>> I have not encountered this problem in an actual operating environment.
>>
>> without this patch:
>>
>> [root@node1 loongarch]# ./csrxchg_testRandom seed: 0x6b8b4567Testing 
>> guest mode: PA-bits:47, VA-bits:47, 16K pagesTesting CSR: IMPCTL1 
>> (implementation-specific control 1)Initial guest CSR value: 
>> 0x10000100Checking that CSRXCHG updates the CSR per mask and 
>> returnsthe full old CSR value in rd.
>>
>> Case: zero-maskwrite value : 0xffffffffffffffffwrite mask : 0returned 
>> old CSR value : 0expected old CSR value : 0x10000100CSR value after 
>> update : 0x10000100expected CSR after update: 0x10000100result : FAIL
>>
>> Case: partial-maskwrite value : 0write mask : 0x100returned old CSR 
>> value : 0x100expected old CSR value : 0x10000100CSR value after 
>> update : 0x10000000expected CSR after update: 0x10000000result : FAIL
>>
>> CSRXCHG test FAILED
>>
>> with this patch:
>>
>> [root@node1 loongarch]# ./csrxchg_testRandom seed: 0x6b8b4567Testing 
>> guest mode: PA-bits:47, VA-bits:47, 16K pagesTesting CSR: IMPCTL1 
>> (implementation-specific control 1)Initial guest CSR value: 
>> 0x10000100Checking that CSRXCHG updates the CSR per mask and 
>> returnsthe full old CSR value in rd.
>>
>> Case: zero-maskwrite value : 0xffffffffffffffffwrite mask : 0returned 
>> old CSR value : 0x10000100expected old CSR value : 0x10000100CSR 
>> value after update : 0x10000100expected CSR after update: 
>> 0x10000100result : PASS
>>
>> Case: partial-maskwrite value : 0write mask : 0x100returned old CSR 
>> value : 0x10000100expected old CSR value : 0x10000100CSR value after 
>> update : 0x10000000expected CSR after update: 0x10000000result : PASS
>>
>> CSRXCHG test PASSED
>>
>> Should this selftest case be included as a patch and sent along with 
>> version 2?
> No, it is not necessary. I test csrxchg instruction by myself, the 
> manual is right, return value should be the whole old value.
>
> My meaning is that what is the scenery where CSR register is SW 
> emulated in KVM mode, or this problem is found by code browsing.
Understood. This was discovered while browsing the code.
>
> Regards
> Bibo Mao
>
>>
>>>
>>> Regards
>>> Bibo Mao
>>>>       } else
>>>>           pr_warn_once("Unsupported csrxchg 0x%x with pc %lx\n", 
>>>> csrid, vcpu->arch.pc);
>>>>
>>>
>>>
>
>

