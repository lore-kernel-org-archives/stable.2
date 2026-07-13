Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E826C1DF27F;
	Mon, 13 Jul 2026 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783960676; cv=none; b=N7d4tROM+ePzocJ+guczcdLvDKq6xVu4JlzHTGb59B/bxX0OnThVzc+oKvUi9N8l4EH1+z8v9xuuabkiJZmr0qkWbXdR4r1Gy4jrkZnB9IPpQom1NocFmnif7jHdYHXcyQJx2e9Irqe71kdznviR3XCGiiAA7XcLJzdkwIq2sro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783960676; c=relaxed/simple;
	bh=4kZEQHCKkpYpxkKyYJlUA0Zza6SQ8vOAw/fP08uqXDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0Gfim81iuf4twb6eoTxcsGyQbAHJv3Et0tjPfmmMopgtFUlD7lFdL7MrzBql7dDsZVvKrr7oUyIx7lMRB9XUSjdUxr1c5AXc7Av6aE4a+A17bweW5FglFzqPZk0zIFqnCljTthVKjkGmyPoIekTF9ZM9NOr5VcksKTqz7epi4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nQz4E89H; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nQz4E89H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783960674; x=1815496674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4kZEQHCKkpYpxkKyYJlUA0Zza6SQ8vOAw/fP08uqXDo=;
  b=nQz4E89HUMitOZCEmSWVBv4LAWu95S4/LyNlzqY33xqbbJekqldVxGBl
   Rar6VjCG/IegZ+jR5JTkmbVw5sVEVPlYRvNRp+LwJ7qCOOFBYV4GyUTR4
   8cOUkAWSJWCouvfywIxlWeARU8zSeeg7xoRebivytAAvk2EpaK9EOlP2V
   nO0Cv9hmvY4LqaExxP8dgdDrwiB3OtT3je8VAoY6dF/82V7KrXPXP7i2q
   zLSaQ8ZyDzHYqZ1T4kKAtKTXzF7bgXMFXBBEWqiMpGpo9B2OHNmn0WJGy
   rZS5IOuQHYLtdn2o8hLTl2RSXG4wrk8oQZCsVnJhH5BxLlhFsx8PqR8qI
   Q==;
X-CSE-ConnectionGUID: IHnlXfNsQQurCo8xWJ1SAw==
X-CSE-MsgGUID: 9iCaQIk+Q7qeyBYQMqqf7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84591894"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84591894"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 09:37:53 -0700
X-CSE-ConnectionGUID: hWdotUdbRAyEFlX+x/kfWQ==
X-CSE-MsgGUID: leJxOZsNRQSKnAtRZj8eFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="249245643"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 09:37:52 -0700
Date: Mon, 13 Jul 2026 09:37:45 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: bot+bpf-ci@kernel.org
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org, 
	bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, x86@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH 7.1.y 1/6] bpf: Support for hardening against JIT spraying
Message-ID: <ehtglcrfzb4feb2ysknrcyvz7t2vc2ui2nfbunypteeexbsfu7@x477johvq6pl>
References: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-1-5ac5a2d6797f@linux.intel.com>
 <de3ebfe684f280473617b560a9dcf501df07833f835a08eb6e75720cd03662b4@mail.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de3ebfe684f280473617b560a9dcf501df07833f835a08eb6e75720cd03662b4@mail.kernel.org>

On Thu, Jul 09, 2026 at 10:52:04PM +0000, bot+bpf-ci@kernel.org wrote:
> > commit 96cce16e26dd02a8678f1e87f88a4b5cdb63b995 upstream.
> > The BPF JIT allocator packs many small programs into larger executable
> > allocations and reuses space within those allocations as programs are
> > loaded and freed. When fresh code is written into space that a previous
> > program occupied, an indirect jump into the new program can reuse a branch
> > prediction left behind by the old one.
> > Flush the indirect branch predictors before reusing JIT memory so that
> > indirect jumps into a newly written program don't reuse predictions from an
> > old program that occupied the same space.
> > Introduce bpf_arch_pred_flush_enabled static key and bpf_arch_pred_flush
> > static call for flushing the branch predictors on JIT memory reuse.
> > Architectures that need a flush, can update it to a predictor flush
> > function. By default, its a NOP and does not emit any CALL.
> > Allocations larger than a pack are not covered by this flush. That is safe
> > because cBPF programs (the unprivileged attack surface) are bounded well
> > below a pack size. Issue a warning if this assumption is ever violated
> > while the flush is active.
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> > Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> 
> The reuse path this patch hardens (bpf_prog_pack_alloc() finding a free
> area within a pack, and the size > BPF_PROG_PACK_SIZE branch) comes from
> the pack allocator that first packed many programs into shared executable
> allocations and reused freed space within a pack.
> 
> Should this carry a Fixes: tag pointing at that commit?
> 
>   Fixes: 57631054fae6 ("bpf: Introduce bpf_prog_pack allocator")

It doesn't add much value. This commit insn't really buggy, it needs no fix
for the eBPF. The fact that cBPF is unprivileged, opens a window for a JIT
spraying attack. Also, the the patch is a backport, so it should stay close
to upstream.
