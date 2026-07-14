Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A653CAA41;
	Tue, 14 Jul 2026 18:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784055571; cv=none; b=XjWKMgRm5AEhHjeVS+HXua079XlJkFoCKiGD6fkoVLfZ+yoYziYIMYR/0ekjnQvzPZl6ag6ZTnutXDvdM2tSa1k6BIFzoy6hloG85EfHXOJSAXMeMYNF4g8LpaxgkAGvlXe16GGG7Y4Wm2baJZrNDLjecAIsDmxMJ0NRPLTX9W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784055571; c=relaxed/simple;
	bh=+XeoTue884A7t3GJfD8FvT8jZHCVJOdHW2hRNYvWNfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaiSu9qvui/aVNllt1TB8UFEWOfgBoDzDVtrqUjcUBpQQmEmkmfTycREcV/X9XbAIlZkWnJf7XEKG6+PtZSWTryQsgjcGXUwgImQbN5TLJjOh6g31qXIgPTtIj5vxBJTEmR+oHC+swKxCkg92bNmXn6+380AjAZA0Jt1DklEqU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=etVvB278; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="etVvB278"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784055570; x=1815591570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+XeoTue884A7t3GJfD8FvT8jZHCVJOdHW2hRNYvWNfY=;
  b=etVvB278RNdIo9SYSK+540x/EBHiaqzRVIqrGNlszMVlEAEuG4CH9tvG
   Z75q/iWYmIaV7QtcEebhMuypuWzcVq5gbZAqPV8u4xyUHAg/cAJII9XD5
   RrKLXInaAhGQxlejAXJid+Ffm3uMA/VPRYBI2EbMmUEHAPKb1wOVuE2DB
   HfEKVDsiYmOcG8symLYhrFXTPuHxFNXJVWQlhdY3ta9R+wiy7IahAVHUN
   ifWF1YF9iL11CgkSeHjPwdmTmHXyTQUgkBCGL4Tal3KLDXs0u45QzS/DJ
   3/Fsalua9l6B7YcTY5mk0SsOPlpxsAo4YR3GYY7IqR1aaoTCHhl+Ge21J
   g==;
X-CSE-ConnectionGUID: lo1CceO5Sum8ot3+1sPuJQ==
X-CSE-MsgGUID: ods8IWsfQCyG5T/pyJMm1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84708168"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="84708168"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:59:27 -0700
X-CSE-ConnectionGUID: pFSGXzHkT5+lUEyqkpz+uw==
X-CSE-MsgGUID: MiN61Di7TpmJkTg8hiI/ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="254209921"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:59:27 -0700
Date: Tue, 14 Jul 2026 11:59:26 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.16.y 4/6] bpf: Skip redundant IBPB in pack allocator
Message-ID: <20260714-cbpf-jit-spray-hardening-6-16-y-v1-4-2fc3e16263ac@linux.intel.com>
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
index 63569d23cfa0..9fc2decac07d 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -885,6 +885,7 @@ int bpf_jit_add_poke_descriptor(struct bpf_prog *prog,
 struct bpf_prog_pack {
 	struct list_head list;
 	void *ptr;
+	bool arch_flush_needed;
 	unsigned long bitmap[];
 };
 
@@ -938,6 +939,8 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 	bpf_fill_ill_insns(pack->ptr, BPF_PROG_PACK_SIZE);
 	bitmap_zero(pack->bitmap, BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE);
 
+	if (static_branch_unlikely(&bpf_pred_flush_enabled))
+		pack->arch_flush_needed = true;
 	set_vm_flush_reset_perms(pack->ptr);
 	err = set_memory_rox((unsigned long)pack->ptr,
 			     BPF_PROG_PACK_SIZE / PAGE_SIZE);
@@ -1000,8 +1003,15 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool
 
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
 
@@ -1039,6 +1049,9 @@ void bpf_prog_pack_free(void *ptr, u32 size)
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


