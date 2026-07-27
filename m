Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08E343231A;
	Mon, 27 Jul 2026 22:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192989; cv=none; b=X7kluEqIsPxO1QP0Zeecg4ks0A8EYDi3g5CcWMiLhPv5e9Dy8s7hEemG57dRxxTh1xWtoASv1YVvh9Ls1xHujrG5rxiK0vlLF3gZihWUDrWFQjPbFSq2Jjt9y1nQeVnU4eZWkk+/QLXNXGeC8sfyL6LgS+HOwGIj1c+ev82w66Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192989; c=relaxed/simple;
	bh=DLLz3yK03HDCGqps6m0UCmf9J2RReDSAKhRx+YmwGXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayybHY+Bclud/hUitYPV63mFcO8QicooiEJPE5qkF4vfec6Nx0xuxZ5YU61GAfm0TCisJOugvtsekKOeygUy9pL30x5cUt5RC/ytkj9WeeULuYDBAOt2Mb3ts6i/UGPAnq6WysPknfUqlenzUfpzLpVV/qv/fCYTGtHSPr/lfEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXejpFNP; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXejpFNP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785192988; x=1816728988;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DLLz3yK03HDCGqps6m0UCmf9J2RReDSAKhRx+YmwGXw=;
  b=aXejpFNPhzTyn2qPZuYJ6cNl+IxOp30g2RWnDF50IPqbKXD2iDFBtcVD
   tKz+gz6zSK5//t079NPaL6vm8cfFt3EHwZTLqoeEMO+Z9/WakoQB54R6k
   QgpjeGVFNVwDitXOUZst8eC+A1PP54nILaNqaQtNGBDSKYcWReXylHmaL
   VAb+3QpDDQyfi8Eqs+Ins0VsHJkmo32kID98MBLFdcLA5I8+BbOMt0m4b
   qQO5doKax8mux99S6FM3Mjp7bkDp6pBK6HK+sh64F0QckRhItFdTsoAmF
   Lr52VyZjxdcZC4eoLh0FoYOmlogSgnio3CrbcWrUc3AUPIGtBxlRmlTxn
   Q==;
X-CSE-ConnectionGUID: cqyTIWAfTva0qNr+fJE3zg==
X-CSE-MsgGUID: 5Q5ce5VETuy1nvCrOBc4Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="108564934"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="108564934"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 15:56:28 -0700
X-CSE-ConnectionGUID: jhwpLNidQ7KMV83k89NRuA==
X-CSE-MsgGUID: lgJZtba+TFquKbfjRlrYvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="255227198"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 15:56:27 -0700
Date: Mon, 27 Jul 2026 15:56:26 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, x86@kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.1.y 4/6] bpf: Skip redundant IBPB in pack allocator
Message-ID: <20260727-cbpf-jit-spray-hardening-6-1-y-v1-4-eb80dcf1eb6e@linux.intel.com>
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

commit a23c1c5396a91680703360d1ee28a44657c503c4 upstream.

bpf_prog_pack_alloc() issues IBPB on all CPUs on every cBPF allocation,
even when reusing chunks from an existing pack where no new memory was
touched since the last IBPB.

Since IBPB on all CPUs is heavy, Dave Hansen suggested to track allocation
since last IBPB, and only issue IBPB at reuse for the chunks that have not
seen an IBPB since they were last freed.

Track per-pack whether an IBPB is needed via arch_flush_needed. Set it when
allocating a chunk, reset on IBPB flush. On reuse, conditionally issue the
flush. Since IBPB invalidates all BTB entries, clear the flag on all packs
after flushing.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index f78ee18bab3b..5a0f804ecdf4 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -845,6 +845,7 @@ int bpf_jit_add_poke_descriptor(struct bpf_prog *prog,
 struct bpf_prog_pack {
 	struct list_head list;
 	void *ptr;
+	bool arch_flush_needed;
 	unsigned long bitmap[];
 };
 
@@ -900,6 +901,8 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 	bitmap_zero(pack->bitmap, BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE);
 	list_add_tail(&pack->list, &pack_list);
 
+	if (static_branch_unlikely(&bpf_pred_flush_enabled))
+		pack->arch_flush_needed = true;
 	set_vm_flush_reset_perms(pack->ptr);
 	set_memory_ro((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
 	set_memory_x((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
@@ -948,8 +951,15 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool
 
 found_free_area:
 	/* Flush only for cBPF as it may contain a crafted gadget */
-	if (static_branch_unlikely(&bpf_pred_flush_enabled) && was_classic)
+	if (static_branch_unlikely(&bpf_pred_flush_enabled) &&
+	    pack->arch_flush_needed &&
+	    was_classic) {
+		struct bpf_prog_pack *p;
+
 		static_call_cond(bpf_arch_pred_flush)();
+		list_for_each_entry(p, &pack_list, list)
+			p->arch_flush_needed = false;
+	}
 	bitmap_set(pack->bitmap, pos, nbits);
 	ptr = (void *)(pack->ptr) + (pos << BPF_PROG_CHUNK_SHIFT);
 
@@ -987,6 +997,9 @@ void bpf_prog_pack_free(struct bpf_binary_header *hdr)
 		  "bpf_prog_pack bug: missing bpf_arch_text_invalidate?\n");
 
 	bitmap_clear(pack->bitmap, pos, nbits);
+
+	if (static_branch_unlikely(&bpf_pred_flush_enabled))
+		pack->arch_flush_needed = true;
 	if (bitmap_find_next_zero_area(pack->bitmap, BPF_PROG_CHUNK_COUNT, 0,
 				       BPF_PROG_CHUNK_COUNT, 0) == 0) {
 		list_del(&pack->list);

-- 
2.43.0


