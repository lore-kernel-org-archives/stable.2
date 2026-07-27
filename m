Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3303F6C27;
	Mon, 27 Jul 2026 22:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785193004; cv=none; b=C8hA2qbdPC8ojgNz5m2/XhJuJGOWOh8lQe91b+VmVN1c9HBLeYeHSMjoAlvBsUtX+Ct6P/Au+l4zi0Y0l5F+dzrSiuvGhTaOh15Cxce630RO42F0NlAKPNjqXzGxEMe02zlQS9wE5PUL9O40E8OjBEDQVc0UucDaNNHHy2BcFB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785193004; c=relaxed/simple;
	bh=r6p2AvYaSoOYixBajzJXk7+xfjMSMUntlxotLamSiD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGX8smzT5yUEm6OkN4ziD22/ek3lwVFbGiPqPowKo1eWbGKBx1CviBWLptop7xw9kK9EJaaz08ntodTEQ6X75OmBwGTaOWFtq/JTKuGzytlZqrc5jNWi8G/CfCYKgIYMx8bQbZUGs/b+ffl8HD+7xmrcNylM5pGRoCbfw0Z9lSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mw0Khh6g; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mw0Khh6g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785193004; x=1816729004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r6p2AvYaSoOYixBajzJXk7+xfjMSMUntlxotLamSiD4=;
  b=mw0Khh6gx5wakmIdWgqJoluC1GLXtWWWlR6PFz2ni5IWCCSCfiFwp4nU
   tYE2i7P9iuRaa1J0CANRqBCuTiEGrZHTyLa5zXUvPu1ckQdf8B4jaLdy2
   fbzc4gss7Q1X2UwObWNdbaTHTYffV4fBl/phiLBHhC9Q4KxK4LUZT0MNj
   pupTHXH7d8m+Yx1tbBqizsaULaTtv6FUAIRtBsr/uRmD5h83+o9pqVxtP
   LcnjWZPnEa6xATPP7mBrs4rT0B6n7D48G2pKP+5Et9JcENpFYZ7Z3I1PQ
   gIok5t8jiYc0/qBXjZe+QYNWHzedcvzdaEMvV08gaKJebNNLrpwskkGI1
   w==;
X-CSE-ConnectionGUID: k/ioUBm1RsCHKgsJxC6iBw==
X-CSE-MsgGUID: WJ4/ZcHNT8SKIWDUMbv9iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="108564942"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="108564942"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 15:56:43 -0700
X-CSE-ConnectionGUID: 14PR3d5eTzKVdiXlO0zmEg==
X-CSE-MsgGUID: e+g9zCE/QOKR8+kFwIDaaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="255227288"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 15:56:42 -0700
Date: Mon, 27 Jul 2026 15:56:42 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, x86@kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.1.y 5/6] bpf: Prefer packs that won't trigger an IBPB flush
 on allocation
Message-ID: <20260727-cbpf-jit-spray-hardening-6-1-y-v1-5-eb80dcf1eb6e@linux.intel.com>
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
index 5a0f804ecdf4..926bf11aeaf2 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -912,8 +912,8 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool was_classic)
 {
 	unsigned int nbits = BPF_PROG_SIZE_TO_NBITS(size);
-	struct bpf_prog_pack *pack;
-	unsigned long pos;
+	struct bpf_prog_pack *pack, *fallback_pack = NULL;
+	unsigned long pos, fallback_pos = 0;
 	void *ptr = NULL;
 
 	mutex_lock(&pack_mutex);
@@ -939,8 +939,29 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool
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


