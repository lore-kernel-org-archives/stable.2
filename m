Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B4530BF6D;
	Tue, 21 Jul 2026 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784639302; cv=none; b=aM+9BtO+R53L455qQoC355Grk+FigR5tOU7bxe6+CKSfOr/KykYTKn4sEunbp03CCZuhjSTgyisBbYFEs7dpKzrCtpyfEeuwPrfMJXMUNNMsyKAyvO8RCBcMDMkS8wdvR/ki5w61b1SmMs3QIznzGniJuZTFjFfqFH8ehr8ljH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784639302; c=relaxed/simple;
	bh=rcAygpI/OJg3FVWLYpuLgsXPmMSPCIccC5rzw7T21IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWvEzj16Oc8o2ZTmL2aK3RifEK1FCkoQFwhlDg1Y98JbLDR5wKlr2C09IJM2WL7N63BCO6184Hq8COP0lJDvuTwv5GcRScO+zvMgJbwJxizIYa8jT7oDy3tep6Z0T39GdQoG84iyRWCvI9WxhgfWqIGz+ns5wPCgt1NExZjxWhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d6/V2aPE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d6/V2aPE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A081F00A3A;
	Tue, 21 Jul 2026 13:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784639301;
	bh=TYa/G9Ikx6NJ1Cb3jjSRc0JJzXsBaNhe6e1UGVGm/9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d6/V2aPEpPAB2I6Ua7LPwlcHwngi1zJi/XHIgdgpWsC+OpJGb8lJA2aRw5XgvUCSk
	 5IZrdAIm+bmynNmQblXUQu5K3mThBRK4gT3ERximvLzMKDANxWBbmBkq/iBUG9clUc
	 4TcfxO32nUe0BTZC9S93Hw6aq20MtO0npuydVBV4=
Date: Tue, 21 Jul 2026 15:08:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, x86@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 6.16.y 0/6] cBPF JIT spray hardening
Message-ID: <2026072151-outsell-suburb-64ea@gregkh>
References: <20260714-cbpf-jit-spray-hardening-6-16-y-v1-0-2fc3e16263ac@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714-cbpf-jit-spray-hardening-6-16-y-v1-0-2fc3e16263ac@linux.intel.com>

On Tue, Jul 14, 2026 at 11:58:24AM -0700, Pawan Gupta wrote:
> Hi,
> 
> These backports harden BPF JIT against spectre-v2 class of attacks. Without
> a predictor flush, execution of new BPF program may use stale prediction
> left behind by the freed one.
> 
> To avoid this, issue an IBPB flush on all CPUs on JIT program allocation.
> The flush is conditional to spectre-v2 mitigation applied.
> 
> Patch 1-2: Adds the predictor flush hook and enables it on x86 via IBPB.
> 
> 	  bpf: Support for hardening against JIT spraying
> 	  x86/bugs: Enable IBPB flush on BPF JIT allocation
> 
> Patch 3-6: Narrow the flush to only unprivileged JIT allocations
> 	   to avoid redundant flushes. Also adds pack-selection changes
> 	   that minimizes flushes.
> 
> 	  bpf: Restrict JIT predictor flush to cBPF
> 	  bpf: Skip redundant IBPB in pack allocator
> 	  bpf: Prefer packs that won't trigger an IBPB flush on allocation
> 	  bpf: Prefer dirty packs for eBPF allocations
> 
> This one is mostly similar to 6.18:
> 
>   https://lore.kernel.org/all/20260713-cbpf-jit-spray-hardening-6-18-y-v1-0-755f60c55705@linux.intel.com/

There is no active 6.16.y kernel branch, so why is this being sent to
us?

confused,

greg k-h
