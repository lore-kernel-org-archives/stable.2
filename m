Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795050692;
	b=pCbkctgkFH0HRB+ubNhLysyS/y6c4YWsa3kOiPj1c8DY96uaUcUHAFatQrteZWhKS9hX
	 gcPi8zVfD6XSh5kX8wgVuYuauQhGTUYvXyG6kM/CVCD5pr2oYnGgtgGXse8Bzg/CwVdnb
	 kBWxwaRXdZo643ojzsY4ttPEnPI6DVpgqFqwGyk/EB25sl+Jc8PgnKbW1Kkv/U/uiQToN
	 kzURHUdcqMo9gZHYFW+3kg+imnjjDbpP+FaiyxJI1nep3scdbQL6CGyyxrOE8JdhKdn7z
	 T+ADvYf5DcEHWU2fKqHSZ/X85Hl+hvWFGZU+G3PpfKqF9w/hQNeWwVstboFd/dY8RPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795050692;
	h=DMARC-Filter:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=dqweL7BsG9XRQRfrzEERF8eiQCXHDKK+nX4SLZICRgY=;
	b=PMYNsb0Fx8bGyWkFGTPMzil35c6AjnP73U44v5KnuNOEukjFpmwLi5xFUIJZHup8IyNN
	 XeGbRUibDNIk5dgPx90X2hO+an9s6g2W9LdTS2YL1lyKWciroQOjMbnQIvPyHu5+wfZXL
	 bYuYY9d1hK0rFYyANX3wyhMdM8T33i1mEn13KRU5e67BrUHDZm886+8TkAU6+qa49Hfug
	 JNcy/cYSt9m+y78V99pKMimpCEAA7RFQydlfUmOzxRKHa+VMtF4hf77M4QUXMmDjjmtgB
	 OL4VMBZhpwo15tq3v+FpJO7lBRig6ubLFh+7OTFJ6sEvVvF6mtb+PhSmhBAPSjijRxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9709B606A31C;
	Thu, 19 Nov 2026 01:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9709B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxTNK+TP5qFwAhAA--.28957S3;
	Thu, 19 Nov 2026 09:11:26 +0800 (CST)
Received: from [127.0.0.1] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJCx9cy7TP5qNr41AA--.14754S2;
	Thu, 19 Nov 2026 09:11:25 +0800 (CST)
Subject: Re: [PATCH v2] LoongArch: BPF: Fix the offset of stptr.w and stptr.d
 stores
To: Huacai Chen <chenhuacai@kernel.org>, George Guo <dongtai.guo@linux.dev>
Cc: hengqi.chen@gmail.com, guodongtai@kylinos.cn, bpf@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261118071444.10258-1-dongtai.guo@linux.dev>
 <CAAhV-H4TNuXk60LyzZhFwQTfNtdzLEFQTwS84u3ZMQ6b=8S0NA@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <0f79389b-ceb3-8c2f-16bb-1111ac40fc43@loongson.cn>
Date: Thu, 19 Nov 2026 09:11:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4TNuXk60LyzZhFwQTfNtdzLEFQTwS84u3ZMQ6b=8S0NA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx9cy7TP5qNr41AA--.14754S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WrW5XryxZry8ZFWUKFy8Zwc_yoW8Jw4kpw
	4DKw4SyrykArZ3twnxXwn5J3WIyw45Kr45WrW3t34DAw15WFyIgFyxKFW5Kay5XrZ5Zw1U
	ZFWxtw1xua9xJacCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jepB-UUUUU=

On 11/18/26 7:59 PM, Huacai Chen wrote:
> On Wed, Nov 18, 2026 at 3:15 PM George Guo <dongtai.guo@linux.dev> wrote:
>>
>> From: George Guo <guodongtai@kylinos.cn>
>>
>> When testing bpf selftests "jit_insns" and "jit_insns_blinded", the
>> "ldst_offsets" subtest fails for word and doubleword stores:

...

>>   #define is_signed_imm12(val)   signed_imm_check(val, 12)
>> -#define is_signed_imm14(val)   signed_imm_check(val, 14)
> Is there instructions really take a 14bit imm (not something like
> ldptr.d/stptr.d)?
> If yes, I suggest keeping is_signed_imm14() because maybe we need it in future.

According to the LoongArch Reference Manual, there are 8 instructions
in total that take a 14-bit signed immediate (si14):
ldptr.{w,d}, stptr.{w,d}, ll.{w,d}, and sc.{w,d}.

All of them implicitly shift si14 left by 2 bits when calculating the
virtual address (vaddr = GR[rj] + SignExtend({si14, 2'b0}, GRLEN)),
so none of them take an unscaled 14-bit immediate directly.

In the JIT, byte offsets for all these instructions should be validated
with is_aligned_signed_imm16() and encoded as (off >> 2). Removing the
unused is_signed_imm14() macro also helps prevent similar misuse in the
future.

So there is no need to keep is_signed_imm14(), and v2 should be good
to go.

Thanks,
Tiezhu

