Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E3926ED46;
	Tue, 25 Aug 2026 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650682; cv=none; b=VMrzHsDXKchH7cbF9k8pZhLLMds0Lp47r5sErvtABQZjRtVaU5X45+Lmav9lBBFvlHw4ZDEsKQDCe0eonIvEvyk1iDPxJZF1gfgh8qcw0vT3yTYs42lzTmYmFeGoXDK/bqomDS76J97ZSXhlh5BRQbm+gvraGfwg2enXTDCllpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650682; c=relaxed/simple;
	bh=fsyUPCOMWirZH7lhIrLk49oBm6i10sLeX8WRTXlnxZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j09HtkJ8AodwD8erS5pbURxjPqfumBQavOxq+Jul5vHS2Kfa2DG7HJGj1EqO1Y/9KXIzgQFTCHkgSEp/DtkBO+kgj34Nh7fRl0wTI8JIk8/G+VlWijzsf+W5rh4KC03uGcJW2eDFyCnADpdqMKtxj8TGar7TU3pV9WURaPAgs4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjGu6Cl7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjGu6Cl7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2391F000E9;
	Tue, 25 Aug 2026 09:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787650679;
	bh=uHMbwppkoGY2sHxRgCTh9Ue6zxQIMWpcljbfz+/NqZQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XjGu6Cl72Sv4ZQ8ciSrINAMtN6nEKV9RpdGUJHvBp+azwFwyeB1z73CkMeIrUmeoJ
	 LWn0l23yBBk6KjDAZIqAc4NB3RL272gxTQzY5cBfv0B4Gbi0WzKeLX0TFUuXcA7tiU
	 SqrXzLtr2+8QqlAcSiF0adrEUoRlUDQJMglWQSgSynVLwwovlJr5oYCdEzIWgFlHYQ
	 m4nyxFRlpOTfwNHd7jwcSeMtzTLJ8Z5vBici7PAS8FF11OI+Q5XqWRYN9JGaX5UGTb
	 BqUGY9LP/kyTJXYVFFY+WwZyp5CgpteabzL7IL1+EzknQkS9T3+XTIsVZnjSH/0h6M
	 hIioTqJLOg76g==
Message-ID: <0a00c5c4-5dca-4957-b4cf-2a52efb2deb1@kernel.org>
Date: Tue, 25 Aug 2026 11:37:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] x86/alternative: exclude text poking against
 change_page_attr()
To: Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
 David CARLIER <devnexen@gmail.com>, David Hildenbrand <david@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Juergen Gross <jgross@suse.com>, Kevin Tian <kevin.tian@intel.com>,
 Kiryl Shutsemau <kas@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Pedro Falcato <pfalcato@suse.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Steffen Dirkwinkel
 <lists@steffen.cc>, Suren Baghdasaryan <surenb@google.com>,
 Thomas Gleixner <tglx@kernel.org>, Toshi Kani <toshi.kani@hpe.com>,
 Vishal Moola <vishal.moola@gmail.com>, Vlastimil Babka <vbabka@kernel.org>,
 Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org,
 syzbot@syzkaller.appspotmail.com, x86@kernel.org
References: <20260813-cpa-fixes-v2-0-39b4ff90f91d@kernel.org>
 <20260813-cpa-fixes-v2-3-39b4ff90f91d@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSFKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAa2VybmVsLm9yZz7CwXcEEwEIACEFAlW3RUwCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AACgkQvSWxBAa0cEnVTg//TQpdIAr8Tn0VAeUjdVIH9XCFw+cPSU+zMSCH
 eCZoA/N6gitEcnvHoFVVM7b3hK2HgoFUNbmYC0RdcSc80pOF5gCnACSP9XWHGWzeKCARRcQR
 4s5YD8I4VV5hqXcKo2DFAtIOVbHDW+0okOzcecdasCakUTr7s2fXz97uuoc2gIBB7bmHUGAH
 XQXHvdnCLjDjR+eJN+zrtbqZKYSfj89s/ZHn5Slug6w8qOPT1sVNGG+eWPlc5s7XYhT9z66E
 l5C0rG35JE4PhC+tl7BaE5IwjJlBMHf/cMJxNHAYoQ1hWQCKOfMDQ6bsEr++kGUCbHkrEFwD
 UVA72iLnnnlZCMevwE4hc0zVhseWhPc/KMYObU1sDGqaCesRLkE3tiE7X2cikmj/qH0CoMWe
 gjnwnQ2qVJcaPSzJ4QITvchEQ+tbuVAyvn9H+9MkdT7b7b2OaqYsUP8rn/2k1Td5zknUz7iF
 oJ0Z9wPTl6tDfF8phaMIPISYrhceVOIoL+rWfaikhBulZTIT5ihieY9nQOw6vhOfWkYvv0Dl
 o4GRnb2ybPQpfEs7WtetOsUgiUbfljTgILFw3CsPW8JESOGQc0Pv8ieznIighqPPFz9g+zSu
 Ss/rpcsqag5n9rQp/H3WW5zKUpeYcKGaPDp/vSUovMcjp8USIhzBBrmI7UWAtuedG9prjqfO
 wU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02XFTI
 t4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P+nJW
 YIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYVnZAK
 DiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNeLuS8
 f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+BavGQ
 8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUFBqgk
 3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpotgK4
 /57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPDGHo7
 39Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBKHQxz
 1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkFAk6S
 54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH/1ld
 wRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+Kzdr
 90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj9YLx
 jhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbcezWI
 wZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+dyTKL
 wLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330mkR4g
 W6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/tJ98
 f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCujlYQ
 DFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmffaK/
 S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
In-Reply-To: <20260813-cpa-fixes-v2-3-39b4ff90f91d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13. 08. 26, 11:01, Mike Rapoport wrote:
> From: Pedro Falcato <pfalcato@suse.de>
> 
>  From time to time, the following BUG can be observed[0]:
> 
>> kernel BUG at arch/x86/kernel/alternative.c:2576!
>> Oops: invalid opcode: 0000 [#1] SMP NOPTI
>> CPU: 0 UID: 0 PID: 355 Comm: (udev-worker) Not tainted 7.1.3-1-default #1 PREEMPT(full) openSUSE Tumbleweed  8c1795b03ec64f997e57a8ad38b1161e3b98da64
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS unknown 02/02/2022
>> RIP: 0010:__text_poke+0x2aa/0x450
>> Call Trace:
>>   <TASK>
>>   smp_text_poke_batch_finish+0x2a7/0x320
>>   __static_call_transform+0xb7/0x220
>>   arch_static_call_transform+0x5b/0xb0
>>   __static_call_init+0xe9/0x270
>>   static_call_module_notify+0x11f/0x150
>>   notifier_call_chain+0x61/0xe0
>>   blocking_notifier_call_chain_robust+0x63/0xc0
>>   load_module+0x1c92/0x20c0
>>   init_module_from_file+0xd8/0x140
>>   idempotent_init_module+0x100/0x2f0
>>   __x64_sys_finit_module+0x71/0xe0
>>   do_syscall_64+0xe1/0x610
>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> which matches the following BUG_ON in alternative.c:
> 	/*
> 	 * If something went wrong, crash and burn since recovery paths are not
> 	 * implemented.
> 	 */
> 	BUG_ON(!pages[0] || (cross_page_boundary && !pages[1]));
> 
> This can happen if vmalloc_to_page() fails, for any reason. Such can happen
> if text poking races with CPA, which can possibly result in the collapsing
> of page tables (or breaking of PMD hugepages). It is not a problem for most
> users of vmalloc_to_page() (they solely own the vmalloc'd range) but, when
> CONFIG_ARCH_HAS_EXECMEM_ROX=y, various modules own a single execmem vmalloc
> range, and can call set_memory_*() in parallel on it. This can happen to
> race against __text_poke and cause havoc in vmalloc_to_page().
> 
> Fix it by excluding against CPA using the init_mm mmap read lock.
> 
> Fixes: 64f6a4e10c05 ("x86: re-enable EXECMEM_ROX support")
> Reported-by: Jiri Slaby <jirislaby@kernel.org>

FWIW
Tested-by: Jiri Slaby <jirislaby@kernel.org>

We have not seen any BUGs since applied to the SUSE's kernel.
https://bugzilla.suse.com/show_bug.cgi?id=1271202#c26

thanks,
-- 
js
suse labs
