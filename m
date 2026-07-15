Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC833CF1FE;
	Wed, 15 Jul 2026 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784150953; cv=none; b=ZuQYmmJoS99z4GFYKbxTunpJpt5D+0bADjVbcKUDQ+UI5rLdhRwZs3FVl2HoLlWaiska7+akdx9wTRiUfBQbbiMCerUkqDJxdJ/KjmIGr4qR9XpoqDM8yDN0cxa9roiE6pSwgPG7jdpufDRqxasMy/7rRrSzpPt5A8OHtL0YfOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784150953; c=relaxed/simple;
	bh=wDb0ezA9eFyOvG4pCNK3eJil6YKm7mNmDWs3yGdmdkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMyyS3tPU3q2PY5gsKK/dSIo4Pyo2+J1xCF8uT3FNzb9JYTf71liZpUHtY5Bqmsv8z7FGkoQ1Hsearg3MVDqz3clL6MZyZ1kHCmcme+4X0XLijdiAFT51nOUdbgig2QxKjRs2pfwIE7zcTyXhc2FnGfK6XRjvXTLnJreMWATr+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qgm9gD+l; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qgm9gD+l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784150951; x=1815686951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wDb0ezA9eFyOvG4pCNK3eJil6YKm7mNmDWs3yGdmdkc=;
  b=Qgm9gD+l471DTKMTyPWCMKy3btgTd3AlHlUMB2pm5jg+c9ncyl6RFrWn
   b9fDoGdHWlV2btXvl8tx9j6MEd50dWy8DpNKUmIE5aCv0ASGZenHObZIH
   j0NMJDYq+vOu8FwZJlVM27sjMjmSWpDihykbzFUsdVPqKuTBzjYdGmS7S
   xngV2NOd8FWrRkKIOJXn3mrDSrT+y4M+DKZCklZhcD1sy++WpBIMQFJ/c
   2gt2IItzEcJ9a22BTCzP4Rz4o8etPzHTRCcPBaSPu9pkX+ARRBqb6szM+
   O1YjpsmZw8vNl87Qm2iHxePI+gMf223dE7pJa8jtBDqPgm311OoQnQIfN
   w==;
X-CSE-ConnectionGUID: Kol+Cfd5TJSHfr40bLxCJA==
X-CSE-MsgGUID: pM40vrcvR/Srl74o3UpsVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84897313"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="84897313"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 14:29:11 -0700
X-CSE-ConnectionGUID: j2zqk8J3TmyP7lamzXyFAg==
X-CSE-MsgGUID: sHu8xZFPQjSTg5dDdA8UPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="260616267"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 14:29:11 -0700
Date: Wed, 15 Jul 2026 14:29:11 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.12.y 6/6] bpf: Prefer dirty packs for eBPF allocations
Message-ID: <20260715-cbpf-jit-spray-hardening-6-12-y-v1-6-d8585a9aed80@linux.intel.com>
X-Mailer: b4 0.16-dev
References: <20260715-cbpf-jit-spray-hardening-6-12-y-v1-0-d8585a9aed80@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715-cbpf-jit-spray-hardening-6-12-y-v1-0-d8585a9aed80@linux.intel.com>

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
index 665f8423b760..d9131b235f79 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -998,10 +998,10 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool
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


