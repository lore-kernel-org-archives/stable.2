Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436DF41B8C3;
	Tue, 14 Jul 2026 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784055600; cv=none; b=JWr7pzy5NHA2fyy9l8aYnT4mlYdFb1mo6TMGHifPAW7XfgZnBBMnPhu1SDSzv2P5FVRynKCYHoq2Kc3ialOy4FcLx6OZJKtyULP/wWUpeADlcmJ62vp0ukrrES6go3QnNnzD7HSwU+GEjS/RRl2i5DVZCfWrX34A2ZdI/AmfDu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784055600; c=relaxed/simple;
	bh=ikwe3QzBMYqyLtMu8y0CioWHL4Q5Qo0Uc8ghNJ9gyv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJfprbkWHK5+rRMI/7O4AsbDP3jLWjrvMxugGcQJPL3yqVPiR2DFORU7pNqvcz8yWEFUZK5Fx+i9yHkfZQkeaoQI++iKFCfJnZvLASBKKj1G4nmCd1Tkjh9jwdXPFVE7kuB4M0/Or3iXTYwXRn49wqxOMt9DvvX/2UMcGjpkmIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kSdGiQ0S; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kSdGiQ0S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784055599; x=1815591599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ikwe3QzBMYqyLtMu8y0CioWHL4Q5Qo0Uc8ghNJ9gyv8=;
  b=kSdGiQ0SuOEGw9rjn5nsROKGKrDDk3UVJI4LJ6uzhMh+1ex8YFkNOqTw
   al/KuLSWgCH8CUnpCBE2ptP6szKkWdTTKwUp6SaopTGpyzysUHRGnLrw2
   tmkObX1KOkIAcs3Sze3f4h+X5zkBRq9RqnI+eI5F0e3ZWUzY+9h54TzTa
   QxZnYcriqUjnAx53W0R73OQPU+mzzwxkc2Qw8mAsTts18nygm4QvYLO6y
   gksx2I0PevkJOOQYOkNknKiDLBzlpmpNFVDKraogMXQMzawhHoltyv5Hj
   9KjMld9I/W4+qwFItcxIdVes8gwjuk+8AR3S8RrAPAseG0q5HEBQaebgu
   w==;
X-CSE-ConnectionGUID: R1hRo9Y5TA6UuvL2kL9jQQ==
X-CSE-MsgGUID: 7GNlMrrXTd6iaQsBnCd0zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="102241382"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="102241382"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:59:57 -0700
X-CSE-ConnectionGUID: 95cGieXzRFy9UhU+YBoKFQ==
X-CSE-MsgGUID: kfliOx19SOG+1mAaLyHOnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="279225339"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:59:57 -0700
Date: Tue, 14 Jul 2026 11:59:57 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.16.y 6/6] bpf: Prefer dirty packs for eBPF allocations
Message-ID: <20260714-cbpf-jit-spray-hardening-6-16-y-v1-6-2fc3e16263ac@linux.intel.com>
X-Mailer: b4 0.16-dev
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
index 81ba423d0f8e..0bed7fe9821e 100644
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


