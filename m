Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153863DFC7B
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 06:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785912437; cv=none; b=ctmkVqlGWx9MWu0v44qCvUMfsvH8P8TVooMdA0u287YQw8PC9kmrLFx6QyOWpAtaXq4pmkbnTKOeON4DS0LwCfXj7vfOeDuryeyCfoFGLBK7ywvfE+tAQccIm9dG2+V6Bfa3548aPiWcEMTAQWnLvqAZfAoZNDujeBPNlevVJ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785912437; c=relaxed/simple;
	bh=imKn3tuWaSCWyxM4SH0hgkanysCvnBUm2QITeWJ66KA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sGFfzABp6AGRd2/jBJanlxBekwOnLTRbUAw7NsXb3+rF+yQ+zsEWt5doMIvWvxuA6b0tmUQYnHZ1RH5qVEQjt+WLBpHQES30qkbAmWC+OM1qOKEQjTYBU1zT5kGOtSD+T/+I/ZDGQaEDrr2pDCL8jyVPgk4MsoYg81YTyJUNd5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Opi1qu8J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Opi1qu8J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A9D1F000E9;
	Wed,  5 Aug 2026 06:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785912435;
	bh=lzxl6ov54XABkEdqGVKNEiBDIIDgS5W3+aFuZLq5XxY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=Opi1qu8JZZLOL3KmQh79XU8FqJKFaFl4tD3f2O1brEVBwfq1buPJZInLNUIgFOdVo
	 wXj/1meF0rQI5di7eqK+U5G1QvmQG0dhg6xYr/IZEq0R/FZRgf9OSJyDmN49geFKmY
	 NVOqU6XjUSdgMtaCTp5iwCvgolM57dbXArM5nP+WiD2OVOi5dl7Rr8zR6KbSKaey2P
	 Ic9SG6Y/9wpeBP9JjnGzHFV5W/0xCH9+ib9IyDutIyU21VmfupAhvxYKQ6re7/pAbr
	 P4nXHctAoaIYQbmJvBMMO4I+m4PUq2iUIpAaLfp3cZs8eOYHUDrF66eXey+f2zALg5
	 l2+Gzf+lPBquA==
Message-ID: <d600d0db-5109-4386-9a49-955be74cc432@kernel.org>
Date: Wed, 5 Aug 2026 08:47:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/20] arm64: percpu: Add infrastructure for
 preemptible this_cpu_*() ops
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: ada.coupriediaz@arm.com, ardb@kernel.org, catalin.marinas@arm.com,
 cl@gentwo.org, david.laight.linux@gmail.com, james.morse@arm.com,
 ljs@kernel.org, maz@kernel.org, peterz@infradead.org, ruanjinjie@huawei.com,
 ryan.roberts@arm.com, stable@vger.kernel.org, vladimir.murzin@arm.com,
 will@kernel.org, yang@os.amperecomputing.com
References: <20260804170503.3513916-1-mark.rutland@arm.com>
 <20260804170503.3513916-14-mark.rutland@arm.com>
 <7df18d5e-886e-43d1-b53d-52a1d08aba49@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <7df18d5e-886e-43d1-b53d-52a1d08aba49@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/26 08:45, David Hildenbrand (Arm) wrote:
>> Atop v7.2-rc4, with GCC 15.2.0 and defconfig, this is compiled as:
>>
>> | <outline_this_cpu_add_u64>:
>> |        paciasp
>> |        stp     x29, x30, [sp, #-16]!
>> |        mrs     x2, sp_el0
>> |        mov     x29, sp
>> |        ldr     w3, [x2, #8]
>> |        add     w3, w3, #0x1
>> |        str     w3, [x2, #8]
>> |        mrs     x3, tpidr_el1
>> |        add     x0, x0, x3
>> | 1:     ldxr    x5, [x0]
>> |        add     x5, x5, x1
>> |        stxr    w4, x5, [x0]
>> |        cbnz    w4, 1b
>> |        ldr     x0, [x2, #8]
>> |        sub     x0, x0, #0x1
>> |        str     w0, [x2, #8]
>> |        cbz     x0, 2f
>> |        ldr     x0, [x2, #8]
>> |        cbnz    x0, 3f
>> | 2:     bl      preempt_schedule_notrace
>> | 3:     ldp     x29, x30, [sp], #16
>> |        autiasp
>> |        ret
> 
> FWIW, in a recent discussion on some prototype hacking [1] we saw some overhead
> in micro-benchmarks that would really hammer on a path that would now do a
> preempt_disable()+preempt_enable().
> 
> Switching from preempt_disable() to preempt_enable_no_resched() made it turn to
> noise. Of course, that has other undesirable impacts, and I am not sure if we
> are in the territory of code layout changes affecting the numbers.
> 
> Just mentioning it as some data point.
> 

[1] https://lore.kernel.org/linux-mm/20260630174852-mutt-send-email-mst@kernel.org/

-- 
Cheers,

David
