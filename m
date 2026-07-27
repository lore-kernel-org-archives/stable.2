Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9018243786F;
	Mon, 27 Jul 2026 22:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192974; cv=none; b=VYN/THTO4fs4pyOwUO3MsQlnDiSohpff8CSO6CchwGvVeM31GdVpYs+r/ggbNhDhRv4bYwG0Ot9PMlX3gOjOhOLDxVUTT6oDZcrqbHNgbfyRlO8jqKcgsmFmbiOFnreEP+hmjJtRrous6S/nx6vhtDellnQ56p3TuPQST+srxII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192974; c=relaxed/simple;
	bh=gKfX6sAEz+5cmO0cD+Ui1yF8DWAUeWF8pdeAoDEplQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdpCak0D//RUqBzEqLPSDsl+uqAfw2/dikQ/Wnzgil/UTMJVy8DI+HdkMSzkpL46jsbIjItj90sPAKZd14qMrRxaoS/do8AdFVcbPzybBOdoAG1RnEEtu1nIIxkvYLZlkvbDPLoFoUL9vNYXIYCpahTbKgu2MzVv6nEwXQiOtQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ch055J5W; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ch055J5W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785192973; x=1816728973;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gKfX6sAEz+5cmO0cD+Ui1yF8DWAUeWF8pdeAoDEplQo=;
  b=ch055J5WsFsPbDj8u/84dcq8V+Yjui6zC7jueIQVhlD8PydF7hHrkb7z
   47NGQhH2I9cqVBNk28LsXBFAkydDmaGpaadidD5v/0vwXmVxyGmn7LxEi
   w2vCnjtjq0R7XL+bRYuTjl/yyghzSEkO6KhgirUujRHGCwxSKXWptOeZD
   4kE4z1BxKY3+ru/qwXmvEdP3quwjtmXCQQijS5LIfRd8AbcxQBiNmRR7U
   uOEhpFU+Odw1lRENxiDNodUgPQZBNIcm1+b33Puue4Lth4SDwt++klwCl
   XMA+Ca0PSIKsiycPZpZQ2jS3bOABMRSzeCGGERLOYftNG9OinGI7uE70g
   g==;
X-CSE-ConnectionGUID: 25MQadIcRvS0ffUs5J/QBA==
X-CSE-MsgGUID: lQXjSH8lRLGxPoIPu4DhMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="88309462"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="88309462"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 15:56:12 -0700
X-CSE-ConnectionGUID: cGIwKDkvR0607UPqrKBUzQ==
X-CSE-MsgGUID: 143a7zhTS5uheOLCzdfeYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="259594512"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 15:56:12 -0700
Date: Mon, 27 Jul 2026 15:56:11 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, x86@kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.1.y 3/6] bpf: Restrict JIT predictor flush to cBPF
Message-ID: <20260727-cbpf-jit-spray-hardening-6-1-y-v1-3-eb80dcf1eb6e@linux.intel.com>
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

commit 0bb99f2cfaae6822d734d69722de30af823efdf3 upstream.

Currently predictor flush on memory reuse is done for all BPF JIT
allocations, but only cBPF programs can be loaded by an unprivileged user.
eBPF is privileged by default, and flushing predictors for all CPUs on
every eBPF reuse penalizes the common case for no security benefit.

eBPF allocations can be frequent on busy systems, only flush predictors
for cBPF programs. Trampoline and dispatcher allocations also skip the
flush as they are eBPF-only.

  [pawan: backport dropped "was_classic" hunk for arches that do not
          support pack allocator]

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/net/bpf_jit_comp.c |  3 ++-
 include/linux/filter.h      |  5 +++--
 kernel/bpf/core.c           | 13 ++++++++-----
 kernel/bpf/dispatcher.c     |  2 +-
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 095fec941bb7..30c6a021abca 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2553,7 +2553,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 			/* allocate module memory for x86 insns and extable */
 			header = bpf_jit_binary_pack_alloc(roundup(proglen, align) + extable_size,
 							   &image, align, &rw_header, &rw_image,
-							   jit_fill_hole);
+							   jit_fill_hole,
+							   bpf_prog_was_classic(prog));
 			if (!header) {
 				prog = orig_prog;
 				goto out_addrs;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index fa7bb6f99598..673aef4e1465 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1082,7 +1082,7 @@ void bpf_jit_free(struct bpf_prog *fp);
 struct bpf_binary_header *
 bpf_jit_binary_pack_hdr(const struct bpf_prog *fp);
 
-void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns);
+void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool was_classic);
 void bpf_prog_pack_free(struct bpf_binary_header *hdr);
 
 static inline bool bpf_prog_kallsyms_verify_off(const struct bpf_prog *fp)
@@ -1096,7 +1096,8 @@ bpf_jit_binary_pack_alloc(unsigned int proglen, u8 **ro_image,
 			  unsigned int alignment,
 			  struct bpf_binary_header **rw_hdr,
 			  u8 **rw_image,
-			  bpf_jit_fill_hole_t bpf_fill_ill_insns);
+			  bpf_jit_fill_hole_t bpf_fill_ill_insns,
+			  bool was_classic);
 int bpf_jit_binary_pack_finalize(struct bpf_prog *prog,
 				 struct bpf_binary_header *ro_header,
 				 struct bpf_binary_header *rw_header);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 4643554c6e3a..f78ee18bab3b 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -906,7 +906,7 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 	return pack;
 }
 
-void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
+void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool was_classic)
 {
 	unsigned int nbits = BPF_PROG_SIZE_TO_NBITS(size);
 	struct bpf_prog_pack *pack;
@@ -921,7 +921,7 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 		 * safe because cBPF programs (the unprivileged attack surface)
 		 * are bounded well below a pack size.
 		 */
-		if (static_branch_unlikely(&bpf_pred_flush_enabled))
+		if (was_classic && static_branch_unlikely(&bpf_pred_flush_enabled))
 			pr_warn_once("BPF: Predictors not flushed for allocations greater than BPF_PROG_PACK_SIZE\n");
 		size = round_up(size, PAGE_SIZE);
 		ptr = module_alloc(size);
@@ -947,7 +947,9 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 	pos = 0;
 
 found_free_area:
-	static_call_cond(bpf_arch_pred_flush)();
+	/* Flush only for cBPF as it may contain a crafted gadget */
+	if (static_branch_unlikely(&bpf_pred_flush_enabled) && was_classic)
+		static_call_cond(bpf_arch_pred_flush)();
 	bitmap_set(pack->bitmap, pos, nbits);
 	ptr = (void *)(pack->ptr) + (pos << BPF_PROG_CHUNK_SHIFT);
 
@@ -1107,7 +1109,8 @@ bpf_jit_binary_pack_alloc(unsigned int proglen, u8 **image_ptr,
 			  unsigned int alignment,
 			  struct bpf_binary_header **rw_header,
 			  u8 **rw_image,
-			  bpf_jit_fill_hole_t bpf_fill_ill_insns)
+			  bpf_jit_fill_hole_t bpf_fill_ill_insns,
+			  bool was_classic)
 {
 	struct bpf_binary_header *ro_header;
 	u32 size, hole, start;
@@ -1120,7 +1123,7 @@ bpf_jit_binary_pack_alloc(unsigned int proglen, u8 **image_ptr,
 
 	if (bpf_jit_charge_modmem(size))
 		return NULL;
-	ro_header = bpf_prog_pack_alloc(size, bpf_fill_ill_insns);
+	ro_header = bpf_prog_pack_alloc(size, bpf_fill_ill_insns, was_classic);
 	if (!ro_header) {
 		bpf_jit_uncharge_modmem(size);
 		return NULL;
diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
index fa3e9225aedc..b3f164e31c6b 100644
--- a/kernel/bpf/dispatcher.c
+++ b/kernel/bpf/dispatcher.c
@@ -145,7 +145,7 @@ void bpf_dispatcher_change_prog(struct bpf_dispatcher *d, struct bpf_prog *from,
 
 	mutex_lock(&d->mutex);
 	if (!d->image) {
-		d->image = bpf_prog_pack_alloc(PAGE_SIZE, bpf_jit_fill_hole_with_zero);
+		d->image = bpf_prog_pack_alloc(PAGE_SIZE, bpf_jit_fill_hole_with_zero, false);
 		if (!d->image)
 			goto out;
 		d->rw_image = bpf_jit_alloc_exec(PAGE_SIZE);

-- 
2.43.0


