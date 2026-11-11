Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.115
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379987;
	b=IFXVLcgJ6qlUWbM8Og+nXT88ELOlA+DwJpmRNM5kB0m37wksVGm0+bdFMvRPt3H2lvKh
	 kjg66MiP89Hi18jT/CW9+yKLfbD38RwutzdYwlxJ7em2FkN8w6SYFZCq3LyNT4yZTUuMl
	 EfLR+iSFci1+Qvg8Fx+oSHV+Hrhfc0aPUsuozh5ad4OZaycrwk4g3oM8tgGBjrgU+ujHb
	 zIL79tA49mywxH72i6BOpxJePjgVhyBKeY0x3DFDJCTqepeO2a/VKo2Cs4y8U2rvgvAHZ
	 nMk+CXOz501GJRekTO+/V2b3OIh87eA5/OeA0sVc+Nr0KySO9m3RMWjkwFshtQfu4MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379987;
	h=DMARC-Filter:DKIM-Signature:To:From:Content-Transfer-Encoding:
	 X-Lms-Return-Path:X-Original-From:Cc:Subject:Message-Id:References:
	 Date:Content-Type:Mime-Version:User-Agent:In-Reply-To;
	bh=WWvXwf/HB1PDEXpuXx9F2cLGqVaTcytjyLMkY2k569Y=;
	b=U9shyUkzHMHb43Dt50NCowNEGI2m0W7HTZxzVAdkYe2ot/L1pqnPuwbLJ3epcGzc0PCk
	 45fyl/4ehnwbLLqMIxOPTDZ3nuTakTAB6GzxmkylxwpaS9X98WhqcIRzkNs8azN6oGnr5
	 7bHjpctkzNX1lBP+E0uzRmlsb7/Tj5JYVG/1LixrwdR9u3IE29Job5CDu13PY3XguCfdj
	 Y7U4l53vMV9nCKpDHrqaH8pSeS6696WP4CHC10oM//ZXfYxRzFfRzbMOjXEacO07Z3qIl
	 167cnZDIWa385UFHeO2rqzILXrgi95V/YRpJ0nWzKDlt2St3jiJ7a+rXS4caE/e9pGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=E6W1UrtA;
	arc=none smtp.remote-ip=209.127.230.115
Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9043606A330
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9043606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=E6W1UrtA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1794379982; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=WWvXwf/HB1PDEXpuXx9F2cLGqVaTcytjyLMkY2k569Y=;
 b=E6W1UrtA69SYn1W9a9oorBiMtgz06JLW2RILWngLuFkAhHst94f8FrlGbzl+jW+LfjS+K9
 uEXThHvux72CdXGLDCCu30W6QsBuw+yBzhVM6fBf3UV9nLm4Asd3F0W7CeaMrt+qTm0WZN
 cfNXrOJPQJyKi4KpQid6UrK5lEwTlnnISjsvrGOYlcZ/Vq9Ol57bNyjyfsaoOpFIE3qXry
 Jo6amyaN6aJ4A2eUd/aqxzsOxFrPjnWtssjze08Z8BIgXrHGpBaaINTw/zwS4Hg5EaXp/z
 5PlUohLyKwuMfJ+1wta8+3uFwp1yqykDd83oFj4EG0aEoVxvD0ms0HK53ajMJQ==
To: "Catalin Marinas" <catalin.marinas@arm.com>
From: "Rui Qi" <qirui.001@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26af410cc+bd1395+vger.kernel.org+qirui.001@bytedance.com>
X-Original-From: Rui Qi <qirui.001@bytedance.com>
Cc: <will@kernel.org>, <mark.rutland@arm.com>, <ardb@kernel.org>, 
	<song@kernel.org>, <dylanbhatch@google.com>, 
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>
Subject: Re: [PATCH 2/3] arm64: patching: Fix instruction byte order in aarch64_insn_set()
Message-Id: <3b540bc9-69b3-42a8-8431-75dd6079bf4f@bytedance.com>
References: <20261010084721.2197683-1-qirui.001@bytedance.com> <20261010085055.2200241-1-qirui.001@bytedance.com> <atEGBsR3eI3cXKay@arm.com>
Date: Wed, 11 Nov 2026 14:52:44 +0800
Content-Type: text/plain; charset=UTF-8
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
In-Reply-To: <atEGBsR3eI3cXKay@arm.com>

On 10/16/26 12:57 AM, Catalin Marinas wrote:
> On Sat, Oct 10, 2026 at 04:50:54PM +0800, Rui Qi wrote:
>> aarch64_insn_set() passes the host-endian u32 instruction straight to
>> text_poke_memset(), which memset32()'s it into memory in host byte order.
>> AArch64 instructions must be little-endian in memory, so on a big-endian
>> kernel the written bytes are reversed and the CPU takes an UNDEFINED
>> instruction exception when fetching them.  The sibling aarch64_insn_write()
>> already converts with cpu_to_le32(); aarch64_insn_set() does not.
>>
>> This is reachable in-tree: bpf_arch_text_invalidate() fills freed JIT
>> regions with AARCH64_BREAK_FAULT through aarch64_insn_set(), and arm64
>> selects HAVE_EBPF_JIT without a big-endian guard, so the path is taken on
>> BE kernels with BPF JIT.  The direct-fill loop in the same file already
>> cpu_to_le32()'s the constant, confirming the expected byte order.
>>
>> Convert the instruction to little-endian before the memset, mirroring
>> aarch64_insn_write().  On LE the conversion is a no-op, so behaviour is
>> unchanged.
> 
> We are just about to remove big-endian support (in 7.4).
> 

Understood.  In -next arm64 no longer has a config CPU_BIG_ENDIAN and
nothing selects it, so 1/3 and 2/3 are fixing a configuration that no
longer exists.  I'll drop both.

3/3 ("arm64: module: Use text-poke for late PLT/veneer emission") is
independent of the byte-order work: it routes
module_emit_plt_entry() / module_emit_veneer_for_adrp() through
aarch64_insn_copy() so a late livepatch relocation that falls back to
PLT emission does not write into the ROX .plt and Data Abort.  That
path is reachable on LE today (klp_write_section_relocs() on a
MODULE_STATE_LIVE patch module), so it is not BE-specific; it carries
Fixes: 91b89a634487 and Cc: stable.

I'll resend 3/3 as a standalone patch in a new thread.  Happy to route
it a particular way if you'd prefer.
