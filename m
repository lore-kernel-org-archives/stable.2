Received: from mta1.migadu.com (out-31.mta1.migadu.com [95.215.58.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8415422D4C3
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 21:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786744336; cv=none; b=MonlfEC4zBbzO+pbTOi9hfaM8FlINW4LmuBhDzeEw+EQWlfYmbghwJxNsuGbPRrATb5my3nFzJPTkcy52kc7KdnLDPJ8NAb7K/djiKXgudu3U5OHSq3PYNieQDcpG8Tk8Qh0e7n2+LEMQvfC4kMf4vHTzWmAAz20ejrZ6BAM9NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786744336; c=relaxed/simple;
	bh=N0myQE++yQTI9u7tY4JAkVybawx1xDvKBp+IGvHCvPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkfpCVpp6ShRJ2PzHszjeA8Tv+Ua3ksdxkoTPCpTm4zv2F61NNeG82nofsGMwJzoTDGfGG2ka1G0NYGVw4ONEUZ4fsaRtLyqrphJehU63PCYYeWDbH/lhuWbPTwgrhXsWi2uO4ITYSL3a4uAU2jOzpLIBzN26Kp+UvZjrGCUvvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZgpZxy+k; arc=none smtp.client-ip=95.215.58.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZgpZxy+k"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=N0myQE++yQTI9u7tY4JAkVybawx1xDvKBp+IGvHCvPI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786744332; v=1; x=1787349132;
 b=ZgpZxy+k0z/aXelvFgJIreejIpGF4yhVN9oTIguC51biWo/FiJP9sKVBNXa3YioFIQGxLyhe
 QnBlpLLK0k33fAgqRt+xQtTCM+z3Lf7bfdSXUEuiVyv/APIfSxUTmTayorBqpgHQcDY1zcUWDkU
 9slA2h79ZR0bVPlHWHXRC91A=
X-Envelope-To: stable@vger.kernel.org
Received: from [IPV6:2a03:83e0:1251:27:9295:e585:8bf6:fa24] (2620:10d:c090:500::6:7be4)
	by smtp.migadu.com with ESMTPS id 92d4703bf2947a41;
	Fri, 14 Aug 2026 21:52:02 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <c2650d12-784f-4f74-a520-ea97e4cb548c@linux.dev>
Date: Fri, 14 Aug 2026 14:51:54 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Check per-CPU address
 resolution per register
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, x86@kernel.org,
 stable@vger.kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
References: <20260814203248.3714536-3-vineet.gupta@linux.dev>
 <7276efcb565f80eed9a05dd364570b432a68ba5d980d9d1676bf620501f10040@mail.kernel.org>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <7276efcb565f80eed9a05dd364570b432a68ba5d980d9d1676bf620501f10040@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/26 2:20 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c b/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c
>> new file mode 100644
>> index 000000000000..962faea8ef90
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c
>> @@ -0,0 +1,114 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include "bpf_misc.h"
>> +
>> +int percpu_data SEC(".percpu");
>> +
>> +#if defined(__TARGET_ARCH_x86)
>> +
>> +/*
>> + * An ld_imm64 of a per-CPU map value is followed by a mov_percpu_addr that
>> + * reuses the same register, so the register the address lands in decides how
>> + * the JIT encodes the add. On x86 R5, R7, R8 and R9 are the extended
>> + * registers, whose high bit needs REX.R because the destination sits in
>> + * ModRM.reg. Check one program per extended register, since getting the
>> + * prefix wrong resolves the address into whichever register shares the low
>> + * three bits instead.
>> + */
>> +
>> +SEC("raw_tp")
>> +__description("per-CPU address into r5")
>> +__success
>> +__arch_x86_64
>> +__jited("	addq	%gs:{{.*}}, %r8")
>> +__naked void percpu_addr_into_r5(void)
>> +{
>> +	asm volatile ("					\
>> +	r5 = %[percpu_data] ll;				\
>> +	r0 = *(u32 *)(r5 + 0);				\
>> +	exit;						\
>> +"	:
>> +	: __imm_addr(percpu_data)
>> +	: __clobber_all);
>> +}
> This isn't a bug, but would it be tidier to move the percpu_data
> declaration inside the __TARGET_ARCH_x86 block?
>
> Currently percpu_data is declared above the arch guard, but its only
> readers (percpu_addr_into_r1/r5/r7/r8/r9) are inside the guard:
>
> +int percpu_data SEC(".percpu");
> +
> +#if defined(__TARGET_ARCH_x86)
> +
> +/* ... test functions using percpu_data ... */
>
> On every other target the object still carries a .percpu section, so
> libbpf still creates an unused percpu data map for it.

That's a good point, will address this in v3

Thx,
-Vineet

>
> Comparable files in the same directory keep objects used only by guarded
> programs inside the guard. verifier_private_stack.c declares its 'struct
> elem' and 'array SEC(".maps")' after the '#if defined(__TARGET_ARCH_x86)
> || defined(__TARGET_ARCH_arm64)' guard, and verifier_ldsx.c declares its
> 'arena SEC(".maps")' map inside its arch guard.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31839526403

