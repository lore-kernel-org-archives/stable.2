Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FF93E47B;
	Thu,  9 Jul 2026 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783635858; cv=none; b=gnRLDYBiNGoaU0BGu6u8UMuwLJhkoByVciueiRtScs5BZXyreLrtiDgvXGH8q+m0d1Tu0JWvN2ikaW5AqyObN7tdNvDezQJUKrs/V1cPcIH/oJwe9DLMUkvVxV3Kr+k0FYLyI3tNOMO02sJXjSYhqPn2W4MHYLstSy/YFur8t1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783635858; c=relaxed/simple;
	bh=vmkP0yQw4l/AwIxIqFDbAQio17LtOdykU5QuvODGdUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjN3vSfcVyGL9EEsv2Grp8uin70AnLpbHkPbDkuTUyu9WAq0DUFRHhtIpbWQCG6sDTCau8+HDYuLLIjwvgceZNd0KFoPBRu7IWzADSH3Otj/4pv3s4wR4hujedYzt1ZIFHnpNv3hsTh1rJhbQIhyjGg2qzjWm8kkGZM7lLbfQEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PQ6k0XZY; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PQ6k0XZY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783635858; x=1815171858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vmkP0yQw4l/AwIxIqFDbAQio17LtOdykU5QuvODGdUQ=;
  b=PQ6k0XZYF0KZc1dpKlVCLu3d7/rjklYs1k1O0y5VcHd2M0H21EHzdB6N
   x5FLbTUx6Si5OuKpFaBfdjRu+ARbC1isUVOGhQEzIu0tyESVGnfxOtf7V
   wgpPf8q8MYB/vgmKMiNCTgI8hTMzl8MmNkyI/b4ju2LsqzFVWEPDo63/V
   FvR0KnG0oI+SpFukSLeogd0ltxNgGS+8kNrkJ5k6Rm5FtqfJqSx0vPp4Y
   /d35Z0uiwtK18PsLQZjqjerxYjQhLEVIOz2KdDnrw1Sd14L61YIQq6LSt
   N6QLxoXp+hOCLAIC6MTMNQERziYoGo5C5crabxL2Ro6kOKw8yZm/oqV/0
   g==;
X-CSE-ConnectionGUID: e0rdjkLwQ/mvdcawoUhr3w==
X-CSE-MsgGUID: iXD/UGUmS0aNwHVW9UrJ/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101886001"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="101886001"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:24:17 -0700
X-CSE-ConnectionGUID: 1JRy3pUPTIukZZL50LIqNA==
X-CSE-MsgGUID: TrxwbYv9SZa+fOOrPTfkBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254226918"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:24:17 -0700
Date: Thu, 9 Jul 2026 15:23:56 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 7.1.y 4/6] bpf: Skip redundant IBPB in pack allocator
Message-ID: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-4-5ac5a2d6797f@linux.intel.com>
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
index 1b7e74e63bd4..1bf4b8dffe91 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -876,6 +876,7 @@ int bpf_jit_add_poke_descriptor(struct bpf_prog *prog,
 struct bpf_prog_pack {
 	struct list_head list;
 	void *ptr;
+	bool arch_flush_needed;
 	unsigned long bitmap[];
 };
 
@@ -928,6 +929,8 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 	bpf_fill_ill_insns(pack->ptr, BPF_PROG_PACK_SIZE);
 	bitmap_zero(pack->bitmap, BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE);
 
+	if (static_branch_unlikely(&bpf_pred_flush_enabled))
+		pack->arch_flush_needed = true;
 	set_vm_flush_reset_perms(pack->ptr);
 	err = set_memory_rox((unsigned long)pack->ptr,
 			     BPF_PROG_PACK_SIZE / PAGE_SIZE);
@@ -990,8 +993,15 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool
 
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
 
@@ -1029,6 +1039,9 @@ void bpf_prog_pack_free(void *ptr, u32 size)
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


