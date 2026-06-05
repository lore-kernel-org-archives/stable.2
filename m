Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17E745039;
	Fri,  5 Jun 2026 06:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641075; cv=none; b=PZt9pNqEeBa1sftBFtzQC0j7tiEpLKgfSsxf75mrqITBUoCM4nb/LuQIPmRcIXHuUoTs8p80k1MzpUStDVIn7R2m5FBcyNoAfjl408tBp3F1ZuokqvNF/mwtPogFwLE6zg3dlC7TrXgtJMT4yEfSlMgcNy0yLJ5EbmELS7N7L94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641075; c=relaxed/simple;
	bh=kGmpVHGql2LZGI7p7pJWXq7/ggZJ/cvE5E3yok4Gh+k=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=H2LHnPV8tdSRi+0u0FJwzyEg72amc043HM+sRySHMI5yuZbqUyOebTX3qMmbdZpLyOmCt1xOY6G6hsVVo0hVLRPRiWQfVKsEYgh72aTYHH9E71kkQHKTtKHUhcKL7USCbtt5Pf2jdsu19hKsZ+bPS9uXu5ZVZHi7KTx85qSeXu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8CxncAobSJqbNoQAA--.22338S3;
	Fri, 05 Jun 2026 14:31:04 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCxfcImbSJqkKScAA--.32857S3;
	Fri, 05 Jun 2026 14:31:03 +0800 (CST)
Subject: Re: [PATCH] LoongArch: KVM: return full old CSR value from
 kvm_emu_xchg_csr()
To: Qiang Ma <maqianga@uniontech.com>, zhaotianrui@loongson.cn,
 chenhuacai@kernel.org, kernel@xen0n.name
Cc: kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260604123433.3182173-1-maqianga@uniontech.com>
 <08d3b817-9de6-746d-2b2c-acc4a578f95a@loongson.cn>
 <4CD61A5AB07B2388+7fa119a1-af5f-4def-b2c4-6073fc397b10@uniontech.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <519ffada-5f2b-2896-30a8-9546d3795f62@loongson.cn>
Date: Fri, 5 Jun 2026 14:27:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4CD61A5AB07B2388+7fa119a1-af5f-4def-b2c4-6073fc397b10@uniontech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxfcImbSJqkKScAA--.32857S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAry5XF4DKF1rKryrZr1xCrX_yoWrXr1kpr
	Z3tF1jkrWvqr18Xry2gwn8JFn8ArsrA3WIqryqqF1UZr4Yk3WIgF1Fqryv9FsFvw4fKryI
	qrWDJa10vw45AabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E
	14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
	vfC2KfnxnUUI43ZEXa7IU8r9N3UUUUU==



On 2026/6/5 下午2:08, Qiang Ma wrote:
> 
> 在 2026/6/5 09:41, Bibo Mao 写道:
>>
>>
>> On 2026/6/4 下午8:34, Qiang Ma wrote:
>>> The LoongArch CSRXCHG instruction returns the full old CSR value in rd
>>> after applying the masked update. kvm_emu_xchg_csr() currently masks
>>> the saved value before returning it to the guest, so rd receives only
>>> the bits selected by the write mask.
>>>
>>> That breaks the architectural behavior and makes a zero mask return 0
>>> instead of the previous CSR value. Keep the masked CSR update, but
>>> return the unmodified old CSR value.
>>>
>>> Fixes: da50f5a693ff ("LoongArch: KVM: Implement handle csr exception")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>>> ---
>>>   arch/loongarch/kvm/exit.c | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
>>> index 3b95cd0f989b..264813d45cbe 100644
>>> --- a/arch/loongarch/kvm/exit.c
>>> +++ b/arch/loongarch/kvm/exit.c
>>> @@ -103,7 +103,6 @@ static unsigned long kvm_emu_xchg_csr(struct 
>>> kvm_vcpu *vcpu, int csrid,
>>>           old = kvm_read_sw_gcsr(csr, csrid);
>>>           val = (old & ~csr_mask) | (val & csr_mask);
>>>           kvm_write_sw_gcsr(csr, csrid, val);
>>> -        old = old & csr_mask;
>>
>> Hi Qiang Ma
>>
>> This is correct from the manual. Is there any test case or problem in 
>> practice?  I want to evaluate severity about this problem.
> 
> Yes, I have written a selftest for this. Below are the test results 
> comparing without and with the patch.
> 
> I have not encountered this problem in an actual operating environment.
> 
> without this patch:
> 
> [root@node1 loongarch]# ./csrxchg_testRandom seed: 0x6b8b4567Testing 
> guest mode: PA-bits:47, VA-bits:47, 16K pagesTesting CSR: IMPCTL1 
> (implementation-specific control 1)Initial guest CSR value: 
> 0x10000100Checking that CSRXCHG updates the CSR per mask and returnsthe 
> full old CSR value in rd.
> 
> Case: zero-maskwrite value : 0xffffffffffffffffwrite mask : 0returned 
> old CSR value : 0expected old CSR value : 0x10000100CSR value after 
> update : 0x10000100expected CSR after update: 0x10000100result : FAIL
> 
> Case: partial-maskwrite value : 0write mask : 0x100returned old CSR 
> value : 0x100expected old CSR value : 0x10000100CSR value after update : 
> 0x10000000expected CSR after update: 0x10000000result : FAIL
> 
> CSRXCHG test FAILED
> 
> with this patch:
> 
> [root@node1 loongarch]# ./csrxchg_testRandom seed: 0x6b8b4567Testing 
> guest mode: PA-bits:47, VA-bits:47, 16K pagesTesting CSR: IMPCTL1 
> (implementation-specific control 1)Initial guest CSR value: 
> 0x10000100Checking that CSRXCHG updates the CSR per mask and returnsthe 
> full old CSR value in rd.
> 
> Case: zero-maskwrite value : 0xffffffffffffffffwrite mask : 0returned 
> old CSR value : 0x10000100expected old CSR value : 0x10000100CSR value 
> after update : 0x10000100expected CSR after update: 0x10000100result : PASS
> 
> Case: partial-maskwrite value : 0write mask : 0x100returned old CSR 
> value : 0x10000100expected old CSR value : 0x10000100CSR value after 
> update : 0x10000000expected CSR after update: 0x10000000result : PASS
> 
> CSRXCHG test PASSED
> 
> Should this selftest case be included as a patch and sent along with 
> version 2?
No, it is not necessary. I test csrxchg instruction by myself, the 
manual is right, return value should be the whole old value.

My meaning is that what is the scenery where CSR register is SW emulated 
in KVM mode, or this problem is found by code browsing.

Regards
Bibo Mao

> 
>>
>> Regards
>> Bibo Mao
>>>       } else
>>>           pr_warn_once("Unsupported csrxchg 0x%x with pc %lx\n", 
>>> csrid, vcpu->arch.pc);
>>>
>>
>>

