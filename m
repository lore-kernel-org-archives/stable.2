Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8695392C28
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 06:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131519; cv=none; b=S6hggKZxX8FGdbJwtNyHEYRVA1VCevnL4wnxd72bbruVRw2EHHG2idkvMaRF6Y10lvu4kCe2XdMmqJ0NOmNEopiPpmfT8kPwxc6AcDMXDSDhwwwOliBAC8DOP0k6m2dlVz8ELgSE4+IxAKkjYW/fR6O2CR1uRS2TPoZZfCQ8nbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131519; c=relaxed/simple;
	bh=T3TaAmFgphpIJVeaERp7JPN/N3mG7s9sCVeOmyIk2UI=;
	h=Cc:To:Date:Message-Id:In-Reply-To:From:Mime-Version:Content-Type:
	 References:Subject; b=XI6DdTR16L7yRgrNSoup9EggY5fFehZ/7SYoo9MelURapTeiBM6NDCsr53bd6PfFuRthgnPF9XMjUwtNja3LCxiwlxp0rNQFt3NWwq6D/TCPDfaN3lfC5sH79F3HiXKr85rTLn+1tD+ivOw4X03l1EfdmLNcbKkixIvr8ACzOGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PEU+PT0H; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PEU+PT0H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1792131511; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=CfbTlnpulMZSnkTZ0v/+czU1W90GNJRnt5mWzrYoJog=;
 b=PEU+PT0HYC+D9Wexd7ivowvxB5PD8hbFpiYGbh1DaGdlVLuvmeJkn5RZsx74J7Rmc26PuJ
 zhOH6LJ2iqUbsoRofh4/iK5Z1HdGz+jn+LS9OtvEDXYT8lxC+XXRXZvZGgaA/ddlm4xUrb
 kpnCZttysDRN0Qc10wXI9W10Qrtq60kn5XWHwKAzmC/hAnSlPHicHOaEYcxuvyTGaB0/fm
 8s08mtrMK0jcY7sjq/JHZPt2iL4dhLUyGtEtYdI1A1QVicsuXwNrI3scnmt34Gv1FXU6Ox
 FGQ7Mo7otS2EYcpDeWD3ofr8XgDKiYk8QCIgtU1pvoKM/c5d+M9MWiWbpd52Fg==
Cc: <will@kernel.org>, <mark.rutland@arm.com>, <ardb@kernel.org>, 
	<song@kernel.org>, <dylanbhatch@google.com>, 
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>
X-Lms-Return-Path: <lba+26ad1c1b5+11c666+vger.kernel.org+qirui.001@bytedance.com>
Content-Transfer-Encoding: 7bit
To: "Catalin Marinas" <catalin.marinas@arm.com>
Date: Fri, 16 Oct 2026 14:18:13 +0800
Message-Id: <e8020121-d771-4a23-80bb-aff20b21efe4@bytedance.com>
User-Agent: Mozilla Thunderbird
In-Reply-To: <atEGBsR3eI3cXKay@arm.com>
From: "Rui Qi" <qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Original-From: Rui Qi <qirui.001@bytedance.com>
References: <20261010084721.2197683-1-qirui.001@bytedance.com> <20261010085055.2200241-1-qirui.001@bytedance.com> <atEGBsR3eI3cXKay@arm.com>
Subject: Re: [PATCH 2/3] arm64: patching: Fix instruction byte order in aarch64_insn_set()

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

Thanks for the heads-up.

I'm fine with dropping the big-endian-specific patches for mainline if
arm64 BE support is going away.  The remaining patch, however, is not
related to BE: patch 3/3 fixes late PLT/veneer emission into a ROX
module .plt section in the livepatch/module relocation path.

Could you please review that one separately?

Thanks,
Rui
