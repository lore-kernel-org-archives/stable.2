Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795696002;
	b=kn4v1viBdIWOL0HV0DCmDMqaoQqkqBeHJmcZNCMNKSvDcxb3Ey/PisWH7fYgLg4lHv1z
	 mzUxCAShAvcySEkfyc2WE48vKMXHCjun5THlQPkUmXBeUacQtwsQ9cziBGqRbnreBCslF
	 9oSdbnLg9muVCMf1d06oQSbYPYz/99SSEU4hXeXGpjAokA0/q3A6dABzXPKMkycAVP4Q4
	 8ujNYhy4RYrbRx9KzgL5djMMVBy71Du/fv94JHEzt0yVBgy9z+SclOvBxM3WO95L25Eyr
	 feILV3uPn8g4IKzmmKaErgZYYCLt5+T6geev+KiOMhwYd+u/haqm5tgJniwupNlt+6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795696002;
	h=DMARC-Filter:DKIM-Signature:References:Content-Type:Message-Id:To:Cc:
	 Subject:Mime-Version:Content-Transfer-Encoding:X-Lms-Return-Path:From:
	 Date:User-Agent:X-Original-From:In-Reply-To;
	bh=j9ckxeIVbxf6YdC+lFxjKeacm1K4q7wcuucIH0pUPdA=;
	b=mjXSKzk1PAQpcpbYteJGO5TZAZKxoeQdDlxpJR4hqeDS6H7jNLJMlQWvyUkK2Y8lPCMU
	 NGKLm+Xym/n1gpBjwEHYArSW5BRCLmlCb6819NfkAjMutEKhu4vP+mDgbOn9boB3S5ZZb
	 sVpe33HpB1h5s3kzOx7zWFHMT7NSh86nZaNKDWnOFN2Qm+jeK0tGLSh4qnauyvQ/e6ymZ
	 ZvNk1+kXqan1P8N0CYSByzwfrarGvwa2VVGp0F0DlsqA1SR2yS9HlBm9UnaUEQuM8OEps
	 Bq08kNxp9rui0NP4JAKHrMduUAVLjhNlM3wbvCr+JNwwCxvBHBHX8nvFj6TtGpWbCDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=LdIjUzer;
	arc=none smtp.remote-ip=209.127.230.111
Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F039606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 12:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F039606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=LdIjUzer
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1795695993; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=j9ckxeIVbxf6YdC+lFxjKeacm1K4q7wcuucIH0pUPdA=;
 b=LdIjUzeraRq4imel3CjPY348Ih89uTaohNT0ujBKuiVqecNdxzBvJ53dDYgz5YX5MPL3Lm
 LmTfk3JmBndpzDO47qWYPlBj7U4vstdiH0V1vZkVIhCL7Lsvksk2o3XuxGIIhiASgd4CjV
 UVc/DlnKqefqpg0hhva8ukDyL+wF5gq9BDBv4miqzBcV+S5UZrFG7GvKjIDCpeNALk4ngd
 e1cueIHzUjZk10vSkrAoop4jOd/XXH8gT2uUL5m7IqBYE2oLVzU1Z2ZUM+VTW6zukgtVcj
 gSF6fFe2evXxSCvwEoSDrpkBe1r2tdvHdMQzfMazkkS25cmg0nFTRjdKa3tI4Q==
References: <20261117113535.399407-1-qirui.001@bytedance.com> <179560945711.1480244.17746046705685189549.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8
Message-Id: <6b3b684d-9f6c-4490-8c8d-aedffe35cc49@bytedance.com>
To: "Catalin Marinas" <catalin.marinas@arm.com>, <will@kernel.org>
Cc: <mark.rutland@arm.com>, <dylanbhatch@google.com>, <song@kernel.org>, 
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, <ardb@kernel.org>
Subject: Re: [PATCH v3] arm64: module: Use text-poke for late PLT/veneer emission
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26b082577+2a5834+vger.kernel.org+qirui.001@bytedance.com>
From: "Rui Qi" <qirui.001@bytedance.com>
Date: Thu, 26 Nov 2026 20:26:15 +0800
User-Agent: Mozilla Thunderbird
X-Original-From: Rui Qi <qirui.001@bytedance.com>
In-Reply-To: <179560945711.1480244.17746046705685189549.b4-ty@b4>

On 11/25/26 8:24 PM, Catalin Marinas wrote:
> On Tue, 17 Nov 2026 19:35:35 +0800, Rui Qi wrote:
>> module_emit_plt_entry() and module_emit_veneer_for_adrp() write PLT
>> entries into the .plt section by direct assignment.  Once a module is
>> fully formed its .plt is read-only/executable, so a late (livepatch)
>> relocation that falls back to PLT emission -- an out-of-range
>> R_AARCH64_CALL26/JUMP26, or an ADRP under CONFIG_ARM64_ERRATUM_843419
>> -- triggers a synchronous Data Abort and panics.
>>
>> [...]
> 
> Applied to arm64 (for-next/fixes), thanks!
> 
> [1/1] arm64: module: Use text-poke for late PLT/veneer emission
>       https://git.kernel.org/arm64/c/a7e632493acf
> 
> I folded in a small fix which addresses Sashiko's comment: the bounds
> check before the write must allow i == plt_max_entries since .plt has
> plt_max_entries + 1 slots (the last one is where a duplicate of the
> final entry is built before being discarded). I restored the
> plt_num_entries check after the duplicate test as well.
> 
> I moved the module_write_place() prototype to asm/module.h, next
> to the other PLT emitters. I concluded it's a better fit than
> text-patching.h. My concern on v2 was the macro but now it's an
> out-of-line function. I also dropped the const from the val argument,
> which removes the (void *) cast when calling aarch64_insn_copy(). All
> callers pass non-const locals anyway. It would be a good cleanup in the
> future but that should also add const to aarch64_insn_copy().
> 
> Please check that I got these right.

Thanks for applying the patch and for the adjustments.

I've checked the resulting patch, and the folded-in changes look correct
to me. Allowing i == plt_max_entries preserves the spare slot used to
build a candidate for the duplicate check, while the restored
post-duplicate check prevents a non-duplicate entry from exceeding the
reserved capacity.

Moving the declaration to asm/module.h makes sense now that the helper
is an out-of-line function. Dropping const also matches the current
aarch64_insn_copy() interface and avoids the cast.


> 
> Sashiko had some comments on v2 which we concluded are existing
> problems, just exposed because we no longer take a fault. If you have
> time for a livepatch reload follow-up (probably not cc stable), there
> are two separate problems when the target module is unloaded and loaded
> again:
> 
> - The livepatch module's .plt slots are reserved once but used again on
>   every klp_module_coming(), so a reload eventually hits the WARN and
>   the target module is rejected. This is safe but we need some slot
>   rewinding or a clear_relocate_add().
> 
> - With the A53 erratum 843419 workaround, if the first application
>   replaced an ADRP with a B to a veneer, reloc_insn_adrp() reads the
>   B back on reload as if it were an ADRP. It either encodes the ADR
>   immediate into the B or decodes Rd from the branch offset. This
>   corrupts the livepatch code silently on the first reload (unrelated to
>   how many slots are left). Not sure yet how to fix this, maybe the
>   original instruction needs restoring on unload (or saving).
> 
> Thanks.
> 


Thanks for detailing the reload issues. I agree that they need separate
handling: reclaiming PLT slots alone would not address the ADRP-to-B
case, since reapplying the relocation also needs the original
instruction, including its destination register. I'll look into the slot
lifecycle and instruction restoration for a separate follow-up,
initially without Cc'ing stable.

Thanks,
Rui
