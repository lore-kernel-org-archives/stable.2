Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDF935E1DA;
	Tue, 14 Jul 2026 01:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783991577; cv=none; b=o2++whQ/FQ98YckDmp/TGLEbnHCSeflLBqQyWKMqR5ZSrzfm7iqyLcKZy4ZSxOwQ0p9wLADOFbOACtBG/WmYS1cY2GuF3VbggOFEeSzv1Gj730o0y3BPbc7sdzcgf58cCDXRr8wHpBh3432Zpgck3/mBqqys29G+RQN9hQ8ofjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783991577; c=relaxed/simple;
	bh=+RTLxExJBFEh/unuxwhi0vcb1IHbn6oEjuCS/eEhK3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/iW7k55BdqbqekWwyu9xrR+PCb/1JK1nJjY34Q+mHkcLBmJDGaDzCJuiFh6ocpeNX+gNwovYuLv9d+VMEjE43D7A79WsLJnrJyhroAZcMYi9/RldZs1yLnxQZJtPgRlhqUnCAUxwW4fERo0kAv2OsrZwt9KVQ5CqsD+olzCDmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=asa4fXl6; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="asa4fXl6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783991576; x=1815527576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+RTLxExJBFEh/unuxwhi0vcb1IHbn6oEjuCS/eEhK3w=;
  b=asa4fXl6MkyQyRS4EzD+X0tajRcwskMyVL+7reaX9X3h5YCBYCzgSyH4
   krfOQcAtrNM9sAFnEZBUdnGymc8aHVjSCG31DNIm05E6moXqlbA5vT+p5
   wco9rvKPBc1p+DLJLDu1KQzsFzjyAIlaHp3l88I+xyJu/IPntpnwOexmy
   x2J5a2s2Xg2IJ96Tzwv+KEmbRUxaIegzkywf+tUYyTxU4/BSANHPRYF66
   rQN83vpLhPcWYAdWEKYGBdCKfcdunCuHGCtSl7HefbWrLvTWkQxi0Q18f
   QdTInEeCf1uHVEYSYUJsbOYlDSHJWXLLAEE4dyjI1QOIPv1jqRvauyP1K
   A==;
X-CSE-ConnectionGUID: dHOUToMyT6aU/ZAsHrj8ug==
X-CSE-MsgGUID: hmfK1s7VTY6hTDoBAnqp/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94961842"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="94961842"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 18:12:55 -0700
X-CSE-ConnectionGUID: g03EV14ERB63gf8iSRo98g==
X-CSE-MsgGUID: mF7R0phSSyy+jniBTMACKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="249344059"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 18:12:54 -0700
Date: Mon, 13 Jul 2026 18:12:53 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.18.y 6/6] bpf: Prefer dirty packs for eBPF allocations
Message-ID: <20260713-cbpf-jit-spray-hardening-6-18-y-v1-6-755f60c55705@linux.intel.com>
X-Mailer: b4 0.16-dev
References: <20260713-cbpf-jit-spray-hardening-6-18-y-v1-0-755f60c55705@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713-cbpf-jit-spray-hardening-6-18-y-v1-0-755f60c55705@linux.intel.com>

commit b72e29e0f7ee329d89f86db8700c8ea99b4a370a upstream.

The pack allocator only flushes predictors when reusing a dirty pack for
cBPF, eBPF allocations never trigger a flush. Currently, eBPF picks the
first free pack, which could be a clean pack. As an optimization, leaving
a clean pack for cBPF can avoid flushes.

Prefer dirty packs for eBPF and keep clean packs free for cBPF. This
mirrors the existing cBPF preference for clean packs: each program kind
prefers the pack that avoids an extra flush, and falls back to the other
kind only when no preferred pack has room. eBPF reuse of a dirty pack is
harmless since eBPF being privileged does not flush.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index e0ffdd985eb5..b102704f89bc 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -970,10 +970,10 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool
 			goto found_free_area;
 		/*
 		 * cBPF reuse of a dirty pack triggers a flush, so prefer a
-		 * clean pack for cBPF. eBPF never flushes, so pick the first
-		 * free pack, dirty or clean.
+		 * clean pack for cBPF. eBPF never flushes, so steer it to a
+		 * dirty pack and keep clean packs free for cBPF.
 		 */
-		if (!was_classic || !pack->arch_flush_needed)
+		if (was_classic ^ pack->arch_flush_needed)
 			goto found_free_area;
 		if (!fallback_pack) {
 			fallback_pack = pack;

-- 
2.43.0


