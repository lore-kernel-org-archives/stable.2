Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881FC542817;
	Thu, 15 Oct 2026 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083480; cv=none; b=BERbaLN6fqcRrpTtJ9RmwuwSzazyJtDsJ798JvtRdLtcpkVfs8vbPalVWcAMTyIdAKFXONADgzMiHPFuf1K9cipK+MhVaSzK8eO/V8fUwxoRiVnqFmGDZGl6Vt9b4HbIR+q1mN0zjk0MFrvnUwnA0mfyfVlB+04uoK+FpCjq9tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083480; c=relaxed/simple;
	bh=edtqmcBc9C5Jw1XnkpzZfUNKGjFPKHCCqCLCye+YyAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oePbC3KHCYuVzAI90Tzjb/dAdwXTHOamYOTgWbBde9Tj30qomQu6BjULH8rFJDrJETjDCjsFFdPpIcqw2caXSs8j7iwVUUET0fRNQcibI+I90v/tF040JBD0+k5C9Y6MFOuK6GqmMo3nMfW5uVJ/zN++3s9+VpPCpBZontmgjIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YZAnapSf; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YZAnapSf"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D75E14BF;
	Thu, 15 Oct 2026 09:57:44 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EF033F871;
	Thu, 15 Oct 2026 09:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792083467; bh=edtqmcBc9C5Jw1XnkpzZfUNKGjFPKHCCqCLCye+YyAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YZAnapSfFDb2v5eT9NxdaYQzZWh5zW1x2ikWd2mGY3XDP8Dua+82I1p44tn+XCdak
	 o/labSzWV+oIosxxCWcdu+DiyH3ip0Dw2x//wtGphvZvqzZNxM0VQ9zWh6u23kCAJA
	 mA5XNkL5epMvjCG8DAl8ZimTGS8jqXVvHz4FHLis=
Date: Thu, 15 Oct 2026 17:57:42 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Rui Qi <qirui.001@bytedance.com>
Cc: will@kernel.org, mark.rutland@arm.com, ardb@kernel.org, song@kernel.org,
	dylanbhatch@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: patching: Fix instruction byte order in
 aarch64_insn_set()
Message-ID: <atEGBsR3eI3cXKay@arm.com>
References: <20261010084721.2197683-1-qirui.001@bytedance.com>
 <20261010085055.2200241-1-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010085055.2200241-1-qirui.001@bytedance.com>

On Sat, Oct 10, 2026 at 04:50:54PM +0800, Rui Qi wrote:
> aarch64_insn_set() passes the host-endian u32 instruction straight to
> text_poke_memset(), which memset32()'s it into memory in host byte order.
> AArch64 instructions must be little-endian in memory, so on a big-endian
> kernel the written bytes are reversed and the CPU takes an UNDEFINED
> instruction exception when fetching them.  The sibling aarch64_insn_write()
> already converts with cpu_to_le32(); aarch64_insn_set() does not.
> 
> This is reachable in-tree: bpf_arch_text_invalidate() fills freed JIT
> regions with AARCH64_BREAK_FAULT through aarch64_insn_set(), and arm64
> selects HAVE_EBPF_JIT without a big-endian guard, so the path is taken on
> BE kernels with BPF JIT.  The direct-fill loop in the same file already
> cpu_to_le32()'s the constant, confirming the expected byte order.
> 
> Convert the instruction to little-endian before the memset, mirroring
> aarch64_insn_write().  On LE the conversion is a no-op, so behaviour is
> unchanged.

We are just about to remove big-endian support (in 7.4).

-- 
Catalin
