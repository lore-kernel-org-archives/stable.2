Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63833AE6F5;
	Thu,  9 Jul 2026 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783635874; cv=none; b=P2oCpkdHidC0UkHR2GKuRB/6mzUCFpS6cY21393wx+D4bXsQPbq7ENEF4f2HRnHDAamHlX/yjQ9PqSHxrqSgnhif5jouH7K1SNcs6zO4GmWZoq98eoBYyXedHqYyEEvX44zH5h5l3Q+y7d/D2U9yZrJsTs99984fsvM0syMuA3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783635874; c=relaxed/simple;
	bh=S6jcatq9rAz67HKNH8gbg4m4YYp2XfxuWPzu2PZTxAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kT2gvsSsvYqHs6UgQCUtsyXnpOOrZkxI+giM5S6Lkz7Efuc7wbPMKjAWb/5vMe61zTsP00kde6AQA7MoxjqJR21GGZKco9ItPcwOMVDrir9Ml6jXKHvw8b3iLnebb9WYXY/dNXP6cjpzajBrQTZ3D+NGmqQSzKQ6EjJ8aUO+9Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D8XHzhck; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D8XHzhck"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783635872; x=1815171872;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S6jcatq9rAz67HKNH8gbg4m4YYp2XfxuWPzu2PZTxAk=;
  b=D8XHzhckTJhGL2ZjOgHeIhLlrzYz5R71COpHQZnBX3jPoX+Q5WA3kXv8
   Ud6tQwUCr79z8DErt5ZYfadVXzdtuTxCmWoxeULsFGIuBauqjgSex42SL
   oGR+6qsUrwtrRhGHVNzZX6/qL/UA5hFovZODxBFWWFEq7QSItDOCHzLWX
   vBwNovsgozzhcctRE5h44toVgmKLKHOA5i/dEnwIXeNMJEvgRnkGtrrkK
   x5MY4ypGyP3a/vxKp+ytRtXH8hPd4i31JSN2iEzCBQpR6ktUc2lN1O1OX
   dmdK3WC+y7Qkx9xVA3mmodmrAI+kOpH6U5gXsej6ZOJX4K2Y466EGOUNG
   w==;
X-CSE-ConnectionGUID: T4b85iXmSruWVIYPdrzDtg==
X-CSE-MsgGUID: 3kCRc49YRA62zHQJelfr8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84213759"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84213759"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:24:32 -0700
X-CSE-ConnectionGUID: pUlEMESESPa21fZcMt/3tA==
X-CSE-MsgGUID: btpjP1nmQqezXE7bXxYJZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="248335696"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:24:32 -0700
Date: Thu, 9 Jul 2026 15:24:31 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 7.1.y 5/6] bpf: Prefer packs that won't trigger an IBPB flush
 on allocation
Message-ID: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-5-5ac5a2d6797f@linux.intel.com>
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

commit a9b1f19a6a673ba06820898d0f1ad02883ea1639 upstream.

Currently BPF pack allocator picks the chunks from the first available
pack. While this is okay, it naturally leads to more frequent flushes
when there are multiple packs in the system that weren't used since the
last flush.

As an optimization prefer allocating the new programs from packs that
are unused since last flush. When all packs are dirty, allocation forces
a flush and marks all packs clean.

Below are some future optimizations ideas:

  1. Currently, the "dirty" tracking is only done at the pack-level.
     Flush frequency can further be reduced with chunk-level tracking.
     This requires a new bitmap per-pack to track the dirty state.
  2. IBPB flush is done on all CPUs, even if only a single CPU ran the
     BPF program. On a system with hundreds of CPUs this could be a
     major bottleneck forcing hundreds of IPIs to deliver the flush.
     The solution is to track the CPUs where a BPF program ran, and
     issue IBPB only on those CPUs.
  3. Avoid IBPB when flush is already done at other sources (e.g.
     context switch).

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/core.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 1bf4b8dffe91..bba4acd61d41 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -948,8 +948,8 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool was_classic)
 {
 	unsigned int nbits = BPF_PROG_SIZE_TO_NBITS(size);
-	struct bpf_prog_pack *pack;
-	unsigned long pos;
+	struct bpf_prog_pack *pack, *fallback_pack = NULL;
+	unsigned long pos, fallback_pos = 0;
 	void *ptr = NULL;
 
 	mutex_lock(&pack_mutex);
@@ -981,8 +981,29 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool
 	list_for_each_entry(pack, &pack_list, list) {
 		pos = bitmap_find_next_zero_area(pack->bitmap, BPF_PROG_CHUNK_COUNT, 0,
 						 nbits, 0);
-		if (pos < BPF_PROG_CHUNK_COUNT)
+		if (pos >= BPF_PROG_CHUNK_COUNT)
+			continue;
+		/* Flush not enabled, use any pack */
+		if (!static_branch_unlikely(&bpf_pred_flush_enabled))
 			goto found_free_area;
+		/*
+		 * cBPF reuse of a dirty pack triggers a flush, so prefer a
+		 * clean pack for cBPF. eBPF never flushes, so pick the first
+		 * free pack, dirty or clean.
+		 */
+		if (!was_classic || !pack->arch_flush_needed)
+			goto found_free_area;
+		if (!fallback_pack) {
+			fallback_pack = pack;
+			fallback_pos = pos;
+		}
+	}
+
+	/* No preferred pack found */
+	if (fallback_pack) {
+		pack = fallback_pack;
+		pos = fallback_pos;
+		goto found_free_area;
 	}
 
 	pack = alloc_new_pack(bpf_fill_ill_insns);

-- 
2.43.0


