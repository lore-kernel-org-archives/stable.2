Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124F13815D0;
	Tue, 14 Jul 2026 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784055554; cv=none; b=rVSk+hKD0CGc0hZMnD9KpLrA/QmKTDR0ua3Mu5yOnZ4NqB0B4HRXm55Z0rmkPV5DEIqpfI9TKGSs+svw+k613sLRM19ubuQxF4Hp0HZPxwZYvL3ieCEI2yWqtP+101e+GIZUXHBCtzBP35SGSJT2+vlgNscclY1oTyDproK9pGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784055554; c=relaxed/simple;
	bh=vqDi0nkfbSWMLfe0Qfa+D1+yEaLu5hMRUhND/3jnP+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCtIY1AysGEtHxReKM9OnVCvLc9ApvyrVX+byw3ixuoR/SnSsrSlX2B1gFE+zTSp5Go8ZXONVVCbuHrtD2peYLE4qaepK4hOd7P1/iRR+dW1LJglgdunv9Sqf1PJCP7b9eGSz0myn0VNKJm8ZL8mhkmgBscn7Y2xeuWoShBWeqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iiGnwdoE; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iiGnwdoE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784055554; x=1815591554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vqDi0nkfbSWMLfe0Qfa+D1+yEaLu5hMRUhND/3jnP+0=;
  b=iiGnwdoECCU4GqSEF4g7MeujDzNHAPAVUJ59Zf4kibf0HbNMa17BNNcE
   F/BJbq9mC1WWnm8EtIF1Fw9nLspgWwTV3bKbVsuJAb2mMRXB4zs0DXvzR
   tZIs903PIlIAAuBldvgyDFJhRViNNWi8TwEwGQB5EO6osnK0EapXz65y9
   vP1kqnsZN3YaAIZdXEayYn+nZOWm5ojltCUko43R2ciUCva718HG7mChx
   qJ4MWt4AELJ2nJcbUxTzLgPV1YTDlIIGYgF5gmAK0DdFmDoWHEM7NTfhx
   cxAB8o+ge8zKCJbBAqH1ViLD1OqC8iQ2CLw+OEWgrocOYGmHEWuG3ygRA
   w==;
X-CSE-ConnectionGUID: bAW+6fiTS/aAsEn8/RRoVQ==
X-CSE-MsgGUID: L6FSECKVSgm86rKKsBWCZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84708153"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="84708153"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:59:13 -0700
X-CSE-ConnectionGUID: 5Skwvtn/QWapAREMMWmqLA==
X-CSE-MsgGUID: +6eDOvXhR8a/FSeA+z+55A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="254209906"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:59:12 -0700
Date: Tue, 14 Jul 2026 11:59:11 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.16.y 3/6] bpf: Restrict JIT predictor flush to cBPF
Message-ID: <20260714-cbpf-jit-spray-hardening-6-16-y-v1-3-2fc3e16263ac@linux.intel.com>
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

commit 0bb99f2cfaae6822d734d69722de30af823efdf3 upstream.

Currently predictor flush on memory reuse is done for all BPF JIT
allocations, but only cBPF programs can be loaded by an unprivileged user.
eBPF is privileged by default, and flushing predictors for all CPUs on
every eBPF reuse penalizes the common case for no security benefit.

eBPF allocations can be frequent on busy systems, only flush predictors
for cBPF programs. Trampoline and dispatcher allocations also skip the
flush as they are eBPF-only.

  [pawan: backport had various conflicts in arches bpf_int_jit_compile().
	  loongarch bpf_int_jit_compile() doesn't use pack allocator,
	  dropped "was_classic" hunk. Also for arch_alloc_bpf_trampoline()]

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/net/bpf_jit_comp.c   |  4 ++--
 arch/powerpc/net/bpf_jit_comp.c |  4 ++--
 arch/riscv/net/bpf_jit_comp64.c |  2 +-
 arch/riscv/net/bpf_jit_core.c   |  3 ++-
 arch/x86/net/bpf_jit_comp.c     |  5 +++--
 include/linux/filter.h          |  5 +++--
 kernel/bpf/core.c               | 13 ++++++++-----
 kernel/bpf/dispatcher.c         |  2 +-
 8 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 58f838b310bc..fec93c352f35 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1962,7 +1962,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	image_size = extable_offset + extable_size;
 	ro_header = bpf_jit_binary_pack_alloc(image_size, &ro_image_ptr,
 					      sizeof(u32), &header, &image_ptr,
-					      jit_fill_hole);
+					      jit_fill_hole, was_classic);
 	if (!ro_header) {
 		prog = orig_prog;
 		goto out_off;
@@ -2594,7 +2594,7 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 
 void *arch_alloc_bpf_trampoline(unsigned int size)
 {
-	return bpf_prog_pack_alloc(size, jit_fill_hole);
+	return bpf_prog_pack_alloc(size, jit_fill_hole, false);
 }
 
 void arch_free_bpf_trampoline(void *image, unsigned int size)
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index c0684733e9d6..ea64203f768f 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -244,7 +244,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	alloclen = proglen + FUNCTION_DESCR_SIZE + fixup_len + extable_len;
 
 	fhdr = bpf_jit_binary_pack_alloc(alloclen, &fimage, 4, &hdr, &image,
-					      bpf_jit_fill_ill_insns);
+					 bpf_jit_fill_ill_insns, bpf_prog_was_classic(fp));
 	if (!fhdr) {
 		fp = org_fp;
 		goto out_addrs;
@@ -442,7 +442,7 @@ bool bpf_jit_supports_far_kfunc_call(void)
 
 void *arch_alloc_bpf_trampoline(unsigned int size)
 {
-	return bpf_prog_pack_alloc(size, bpf_jit_fill_ill_insns);
+	return bpf_prog_pack_alloc(size, bpf_jit_fill_ill_insns, false);
 }
 
 void arch_free_bpf_trampoline(void *image, unsigned int size)
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 9883a55d61b5..f67533a7ef3d 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1280,7 +1280,7 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 
 void *arch_alloc_bpf_trampoline(unsigned int size)
 {
-	return bpf_prog_pack_alloc(size, bpf_fill_ill_insns);
+	return bpf_prog_pack_alloc(size, bpf_fill_ill_insns, false);
 }
 
 void arch_free_bpf_trampoline(void *image, unsigned int size)
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index f6ca5cfa6b2f..a2eed555ed96 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -125,7 +125,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 				bpf_jit_binary_pack_alloc(prog_size + extable_size,
 							  &jit_data->ro_image, sizeof(u32),
 							  &jit_data->header, &jit_data->image,
-							  bpf_fill_ill_insns);
+							  bpf_fill_ill_insns,
+							  bpf_prog_was_classic(prog));
 			if (!jit_data->ro_header) {
 				prog = orig_prog;
 				goto out_offset;
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 15672cb926fc..e8034c3d9599 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3347,7 +3347,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 void *arch_alloc_bpf_trampoline(unsigned int size)
 {
-	return bpf_prog_pack_alloc(size, jit_fill_hole);
+	return bpf_prog_pack_alloc(size, jit_fill_hole, false);
 }
 
 void arch_free_bpf_trampoline(void *image, unsigned int size)
@@ -3687,7 +3687,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
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
index 65e2e804a5cd..8a2285db0866 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1261,7 +1261,7 @@ void bpf_jit_free(struct bpf_prog *fp);
 struct bpf_binary_header *
 bpf_jit_binary_pack_hdr(const struct bpf_prog *fp);
 
-void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns);
+void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool was_classic);
 void bpf_prog_pack_free(void *ptr, u32 size);
 
 static inline bool bpf_prog_kallsyms_verify_off(const struct bpf_prog *fp)
@@ -1275,7 +1275,8 @@ bpf_jit_binary_pack_alloc(unsigned int proglen, u8 **ro_image,
 			  unsigned int alignment,
 			  struct bpf_binary_header **rw_hdr,
 			  u8 **rw_image,
-			  bpf_jit_fill_hole_t bpf_fill_ill_insns);
+			  bpf_jit_fill_hole_t bpf_fill_ill_insns,
+			  bool was_classic);
 int bpf_jit_binary_pack_finalize(struct bpf_binary_header *ro_header,
 				 struct bpf_binary_header *rw_header);
 void bpf_jit_binary_pack_free(struct bpf_binary_header *ro_header,
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 48208c3f5814..63569d23cfa0 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -952,7 +952,7 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 	return NULL;
 }
 
-void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
+void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool was_classic)
 {
 	unsigned int nbits = BPF_PROG_SIZE_TO_NBITS(size);
 	struct bpf_prog_pack *pack;
@@ -967,7 +967,7 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 		 * safe because cBPF programs (the unprivileged attack surface)
 		 * are bounded well below a pack size.
 		 */
-		if (static_branch_unlikely(&bpf_pred_flush_enabled))
+		if (was_classic && static_branch_unlikely(&bpf_pred_flush_enabled))
 			pr_warn_once("BPF: Predictors not flushed for allocations greater than BPF_PROG_PACK_SIZE\n");
 		size = round_up(size, PAGE_SIZE);
 		ptr = bpf_jit_alloc_exec(size);
@@ -999,7 +999,9 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 	pos = 0;
 
 found_free_area:
-	static_call_cond(bpf_arch_pred_flush)();
+	/* Flush only for cBPF as it may contain a crafted gadget */
+	if (static_branch_unlikely(&bpf_pred_flush_enabled) && was_classic)
+		static_call_cond(bpf_arch_pred_flush)();
 	bitmap_set(pack->bitmap, pos, nbits);
 	ptr = (void *)(pack->ptr) + (pos << BPF_PROG_CHUNK_SHIFT);
 
@@ -1159,7 +1161,8 @@ bpf_jit_binary_pack_alloc(unsigned int proglen, u8 **image_ptr,
 			  unsigned int alignment,
 			  struct bpf_binary_header **rw_header,
 			  u8 **rw_image,
-			  bpf_jit_fill_hole_t bpf_fill_ill_insns)
+			  bpf_jit_fill_hole_t bpf_fill_ill_insns,
+			  bool was_classic)
 {
 	struct bpf_binary_header *ro_header;
 	u32 size, hole, start;
@@ -1172,7 +1175,7 @@ bpf_jit_binary_pack_alloc(unsigned int proglen, u8 **image_ptr,
 
 	if (bpf_jit_charge_modmem(size))
 		return NULL;
-	ro_header = bpf_prog_pack_alloc(size, bpf_fill_ill_insns);
+	ro_header = bpf_prog_pack_alloc(size, bpf_fill_ill_insns, was_classic);
 	if (!ro_header) {
 		bpf_jit_uncharge_modmem(size);
 		return NULL;
diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
index b77db7413f8c..ea2d60dc1fee 100644
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


