Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B159B377A92;
	Mon, 27 Jul 2026 22:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785193020; cv=none; b=fM6ezPIfzC9ZevjwZDlFQO9di/bSd+Y2Vbo07p0Q3OeMozdTlKSILRJi9pNwlBYiYDanOgxtIV5wdgHVRNNr0T36df1On2Bx5x3ajYFJQtGySCNNdZBLMzjyd/fiKQcPH+fXdfSnqNpczklMBJARqbGVGSq0/a3gINlArFpDGu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785193020; c=relaxed/simple;
	bh=hbqfyqquiR7qQ6/7govUEoL1nj2YlXuDt8RFXgSOC0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNepLzgf67ad+1kqdxl3K/VDhwNaIqViTRy22D1cTYY2WIvwxkmMcVQAtWEtrk+Qca3ZxZYBoMOO2Im3dyGmA3cmdIYt7qCMC1fGa79jbv1ADk/PA7me6OB/MKZ/fc//9XHAgqwF7T7Q4TlxUUvfyBZV4OqhPvfi/6lIMfeZiHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L8+ob4gl; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L8+ob4gl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785193019; x=1816729019;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hbqfyqquiR7qQ6/7govUEoL1nj2YlXuDt8RFXgSOC0o=;
  b=L8+ob4glUfg88e3PSclPsOv/GfTz+PL5heJqmIur1TV23d9vtuSl2opz
   BMGThV2QhDkE18zG/rqptP2dVg11unEZjw10eaOgZF5xDlr5bQ8HgwFvY
   SFCW2QedQZJ87FDtLhPYiZSUa3qtq07cRAi8ciQYmsxW4FhUl9/B5KjV1
   ofGoChlfEFSyG8JUURr3WQEkND3D966Sxa/EiaASlLCWQYUACzBiJYj5c
   VgQQM385ZgIrOy7Bi3cq4dgaFXVR1CqYstbfAl7Jzr3LtFPGJ457A4FlD
   82aCX9Cn7tPlKj77AyX2IeRqj6lzhJCj0y0tULXADd7KCO6S3/wpTgdNb
   g==;
X-CSE-ConnectionGUID: JHSIo6VZQVqZrQJWo8kReg==
X-CSE-MsgGUID: t5vgH3jzQeGePlxvvOyezg==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="84748828"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="84748828"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 15:56:58 -0700
X-CSE-ConnectionGUID: 8HPGW4UbQ1WCrcag4wkslg==
X-CSE-MsgGUID: HfImdwGISy2KkRqrVUt/XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="258265933"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 15:56:58 -0700
Date: Mon, 27 Jul 2026 15:56:57 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, x86@kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.1.y 6/6] bpf: Prefer dirty packs for eBPF allocations
Message-ID: <20260727-cbpf-jit-spray-hardening-6-1-y-v1-6-eb80dcf1eb6e@linux.intel.com>
X-Mailer: b4 0.16-dev
References: <20260727-cbpf-jit-spray-hardening-6-1-y-v1-0-eb80dcf1eb6e@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727-cbpf-jit-spray-hardening-6-1-y-v1-0-eb80dcf1eb6e@linux.intel.com>

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
index 926bf11aeaf2..4ea21434bf78 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -946,10 +946,10 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool
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


