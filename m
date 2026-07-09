Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4594D1D6195;
	Thu,  9 Jul 2026 22:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783635889; cv=none; b=Q+bPZ4EmkFgBoLRUuYZt6R9qPII63q1vvzo55CXwV6Yj2T/ZyJwwQMBk6AS/tgBYCThAb+38fJx3lM3LG8M80BTSC1OvLC6EaH22oAvpBV/7Pp7ZKIKroR5VcsF2fAYudBhMyNEPVIK79VOR4AMqtnnuEqoDWtPv+Pfxz65goXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783635889; c=relaxed/simple;
	bh=j+SGpxnxcXP2jP/D2FzTuZpBaLImj0yoHLCpJzVrAQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUJ/+Bg2O5lkjyCj58gwEecdFLhczPFiiAkUrrng6hXeXRQXz9Rn/eSX1tbI+lBudFPpM98m4GUEnUoX4tOvriTmnuCEEt3uXlPAwmEAn5sM6u4pUZYp6arTnL5FMVhdy7gjAuxfrxBaaS7A4uoafF80lj/yAEn8ZZMSw/gzi1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OFXpWgY+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OFXpWgY+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783635888; x=1815171888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j+SGpxnxcXP2jP/D2FzTuZpBaLImj0yoHLCpJzVrAQQ=;
  b=OFXpWgY+ZzWYKKz2eWNPkVCCUkPuYURBezgEIjnQfA1DMB7cdEiq8pna
   541Otjlk18BHGmQqPzoWda9xqug01z4qahNOV/A3Nu6a3iGTxJGhgAZ33
   ENkdHbV8qiHZlJg3AuHgFuk6PZWwAnehIhJerScxOr8EHY3cWXI/O+edw
   L4BSk9/mi/Ek+BS/5YAv8MRxa1kTubMzWDsQyvvY3fV38cqNpcb9EHGqw
   LuWK3r8pchJD/G4R9+uDSkKn5czHJf3Z9IJqTTMLwKfzMuJqZbDvSsvQ0
   aleKkFoMZY2kg7Nnsw13KIQ8i40eXOi1djEffzJasTj09jlWBYgPb6DE0
   A==;
X-CSE-ConnectionGUID: 1za2hnrwTiWbNsYebWoAhw==
X-CSE-MsgGUID: hmcSMFo2RmaJB+aZXOWX2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84213776"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84213776"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:24:47 -0700
X-CSE-ConnectionGUID: ibAssKHeRbmUZQiMyyryAg==
X-CSE-MsgGUID: ffWZe+IPSh2xsAc9y1Tnaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="248335750"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:24:47 -0700
Date: Thu, 9 Jul 2026 15:24:47 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 7.1.y 6/6] bpf: Prefer dirty packs for eBPF allocations
Message-ID: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-6-5ac5a2d6797f@linux.intel.com>
X-Mailer: b4 0.16-dev
References: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-0-5ac5a2d6797f@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-0-5ac5a2d6797f@linux.intel.com>

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
index bba4acd61d41..de61e1894452 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -988,10 +988,10 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool
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


