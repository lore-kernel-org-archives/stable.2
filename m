Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914547;
	b=Zqo7kE2Sw/RVqm6TtlEMCpL6prsrUrfb47/NfdHjGX83sK7KRGbnKIUTaekCxoS0Misb
	 DZd47T1VWR67xzzASaP1v5HJyqC9dppHpu3ISJ7v/Gbxxt/rRMKG+oF5mmY5Bei+dxnD5
	 UMrMKjsmCjmcxbaIXQQVYkDxbSzBZqjKP5UcGcAfFgb8RuN/7eAIG/YresGXbbkKJh9dW
	 gQucHPwpS8s2yDcdLAZFvzr0Am6Q/MSZ9nfEuIuPDZhvOXGoP6DsMseHsTS94LxpQOfOs
	 NytWk9nVDh1WbSpty+eHptOfpWdjurakY3qQJvF65m53Ywp4vbt4WI90CDqD6skuuSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914547;
	h=DMARC-Filter:DKIM-Signature:X-Lms-Return-Path:Date:Message-Id:
	 User-Agent:X-Original-From:Content-Type:Cc:From:Mime-Version:
	 References:To:Subject:In-Reply-To:Content-Transfer-Encoding;
	bh=qgcXr3Kfe2i/grQTzX0p6YOpmAeo7+UNA6FacQY2sPU=;
	b=f6cy1V5Dw2ZR/YQJnhSXmi697Rb+vHSVnetOMsjWj5jWpf9O1v93+PSnKfzaUpM1XyeU
	 JuPCujb0eDZ2jEOkU5EeJAVs7Qzr6Yik9TQmAAyiJJrxbwv5dhSF+B799yXUr5g2fmHQK
	 m/WnBeHcX1W+XZFOHXkC/yeHH885WvS7mQlpw6fo2qaBxjA5SxS7UNy5i7Po3Wfi1G3TD
	 N7Vb7PfAbTLfG2WO3u3EbXSOwbqGOlINcBHlBPMij9G630pl4DioZJEoeyUhIaZeA3qow
	 TAcugF52U3PPmqpwDL5XBlK8ldS3597IhIHUXPB6qvAi8v9Vh9kGM13h3Dd+4yj5BUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=AdL89ub8;
	arc=none smtp.remote-ip=209.127.230.112
Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4D0606A323
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 11:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E4D0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=AdL89ub8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1794914541; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=qgcXr3Kfe2i/grQTzX0p6YOpmAeo7+UNA6FacQY2sPU=;
 b=AdL89ub8AgKPW4E9xn6q9Op0Zl67JYr7g9NMx1mEM9/TMFCvEwVoibj7TTAAx9ePBQSn09
 hS2Yax2fGIMGz/ALuKv52X6mHHGK8j32XlCg6ZD39v1mQszmYz2aubDo1IYAhPGO0237nM
 HgOoBx+oBeO2//iwJodiJj3Hardm9i1vCwjraomK+wd1vRwEB1al3GDSOdPxwXNsAsUetA
 IJs6WnMfy5f9VuruTZeQf/AWovVkq1RGvHQsL7P7QcrLuYa8I5cEk2iGU4t56jgAOexe9p
 s3FNLpGd1lHVtOvodiaf+G1Wyo1CJMq9JifrgVSJVu3tmyLqKSBZIIQtFzP1fQ==
X-Lms-Return-Path: <lba+26afc38eb+1aac54+vger.kernel.org+qirui.001@bytedance.com>
Date: Tue, 17 Nov 2026 19:22:03 +0800
Message-Id: <c6cc9216-147d-41dc-8139-690fac6f6015@bytedance.com>
User-Agent: Mozilla Thunderbird
X-Original-From: Rui Qi <qirui.001@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Cc: <will@kernel.org>, <mark.rutland@arm.com>, <ardb@kernel.org>, 
	<song@kernel.org>, <dylanbhatch@google.com>, 
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>
From: "Rui Qi" <qirui.001@bytedance.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261111073906.652400-1-qirui.001@bytedance.com> <avdVsAOC_fpoDNDr@arm.com>
To: "Catalin Marinas" <catalin.marinas@arm.com>
Subject: Re: [PATCH v2] arm64: module: Use text-poke for late PLT/veneer emission
In-Reply-To: <avdVsAOC_fpoDNDr@arm.com>
Content-Transfer-Encoding: 7bit

On 11/14/26 2:23 AM, Catalin Marinas wrote:
> Thanks Rui for respinning.
> 
> On Wed, Nov 11, 2026 at 03:39:06PM +0800, Rui Qi wrote:
>> diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
>> index fb9b88eebeb1..4a1a47f8ba1a 100644
>> --- a/arch/arm64/include/asm/module.h
>> +++ b/arch/arm64/include/asm/module.h
>> @@ -6,6 +6,7 @@
>>  #define __ASM_MODULE_H
>>  
>>  #include <asm-generic/module.h>
>> +#include <asm/text-patching.h>
>>  
>>  struct mod_plt_sec {
>>  	int			plt_shndx;
>> @@ -29,6 +30,21 @@ u64 module_emit_plt_entry(struct module *mod, Elf64_Shdr *sechdrs,
>>  u64 module_emit_veneer_for_adrp(struct module *mod, Elf64_Shdr *sechdrs,
>>  				void *loc, u64 val);
>>  
>> +/*
>> + * Write a relocation value to @place within a module.  While the module
>> + * is MODULE_STATE_UNFORMED the destination is writable and a direct store
>> + * is used; once the module is fully formed the region is read-only and
>> + * executable, so the write is routed through the text-poke API.
>> + */
>> +#define module_write_place(place, val, mod) do {			\
>> +	__typeof__(*place) __val = (val);				\
>> +									\
>> +	if (mod->state == MODULE_STATE_UNFORMED)			\
>> +		*(place) = __val;					\
>> +	else								\
>> +		aarch64_insn_copy(place, &(__val), sizeof(*place));	\
>> +} while (0)
> 
> A nit here, I'd move this macro to asm/text-patching.h since
> asm/module.h is pulled in by linux/module.h. Even better if you could
> make this a function (either static inline or out of line).
> 

I'll replace the macro with an out-of-line function:

    void module_write_place(void *place, const void *val,
                            size_t size, struct module *mod);

I'll declare it in asm/text-patching.h with a forward declaration of
struct module, and define it in arch/arm64/kernel/module.c.

Keeping the implementation out of line avoids adding a dependency on
linux/module.h to text-patching.h. The header only needs the module
pointer type, while access to mod->state and MODULE_STATE_UNFORMED
stays in the .c file.


>> --- a/arch/arm64/kernel/module-plts.c
>> +++ b/arch/arm64/kernel/module-plts.c
>> @@ -76,11 +76,13 @@ u64 module_emit_plt_entry(struct module *mod, Elf64_Shdr *sechdrs,
>>  	int i = pltsec->plt_num_entries;
>>  	int j = i - 1;
>>  	u64 val = sym->st_value + rela->r_addend;
>> +	struct plt_entry entry;
>>  
>>  	if (is_forbidden_offset_for_adrp(&plt[i].adrp))
>>  		i++;
>>  
>> -	plt[i] = get_plt_entry(val, &plt[i]);
>> +	entry = get_plt_entry(val, &plt[i]);
>> +	module_write_place(&plt[i], entry, mod);
> 
> Sashiko reported PLT exhaustion/overrun and ADRP corruption when
> relocations are reapplied after unloading and reloading a target module:
> 
> https://sashiko.dev/#/patchset/20261111073906.652400-1-qirui.001@bytedance.com
> 
> These look like existing problems, only exposed now because we no longer
> get the ROX fault. I think they can be addressed in separate follow-up
> patches. This patch still fixes the fault on the first application.
> 

Agreed, pre-existing.  I checked: plt_num_entries is only reset to 0 in
module_frob_arch_sections(), i.e. once at load.  livepatch reapplication
(klp_apply_object_relocs() -> apply_relocate_add(), e.g. on target-module
unload/reload) doesn't reset it, so module_emit_plt_entry() keeps emitting
past the original entries and overruns .plt; before this patch that path
died on the ROX fault first.  I'll send a separate follow-up.  The .plt
section is shared across target objects, so the fix is more than a count
reset.


> However, could we include a bounds check before writing the PLT entry,
> maybe with a WARN_ON_ONCE? Once late writes use text-poke, retrying
> after slot exhaustion can overwrite memory beyond .plt.
> 
> Thanks.
> 

Yes.  The hole is in module_emit_plt_entry(): the write runs before the
existing WARN_ON, so on exhaustion text-poke corrupts past .plt before
the check fires.  module_emit_veneer_for_adrp() already checks before
its write (and returns 0 on exhaustion), so it isn't affected.

I'll add, after the is_forbidden_offset_for_adrp() bump and before the
write:

    if (WARN_ON_ONCE(i >= pltsec->plt_max_entries))
        return 0;

This is the same condition as the post-write check -- num_entries becomes
i + 1, so (num_entries > plt_max_entries) <=> (i >= plt_max_entries) --
just evaluated before the write.  The caller maps a 0 return to -ENOEXEC,
so exhaustion becomes a clean load failure instead of corruption.  The
post-write WARN_ON is then redundant and I'll drop it.

v3 to follow.
