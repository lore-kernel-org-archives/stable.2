Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E2430171C;
	Fri, 17 Jul 2026 17:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784307978; cv=none; b=KsYcLcny0vIa9RbqzrYL9IJstQpNqAflGkz+8PXd1GWqE/xM1+Pumrq2F+e3AJthfuqmJxTL3eNpqZsD0tb/rHOTOg1kVV6wy/trqwI4cNZD9tL7o5Fjx6aP29WjM96xEh2KtKK5hsLO1+bBeNyGsrydy/rmh1hDNogffhGVuyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784307978; c=relaxed/simple;
	bh=jnozS+dcwhktfM0icgludR4+nPtDOS9pVMppKIAwCUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6M+AdhIG5GpsdPm0RignPLPWeHK8b/zqrvaLAc8uvecS+n5ptiggjsRzwk2ZzPvk74xejj4b+hic5dW3eN7QvbYAaasaoUXz7DsGbXFPZBDm3/+OLZaq/+OX6vaDxySsaoG49eaUV1UQdRXqvojz1k5vR06ylgOWIXWiJl0TYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7IGsLxN; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7IGsLxN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784307977; x=1815843977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jnozS+dcwhktfM0icgludR4+nPtDOS9pVMppKIAwCUA=;
  b=k7IGsLxNETVGHH6sG1CuhVjBgdUV5J5ldqIp4nDZB3X4JSa0B25029AU
   4Qms6nr2u93Y6q+TB4Dj0GcoKEWwViODWH2ML4Ydy/OBe02de5FwwFOG8
   5FqKC0tqPkpfxsmc0pBNzU2jyCllcT6N2ttH6b1vOq9fA3LCH1N4sRNDP
   0RuxsVgAkjM+/6iE2JlKTZA16l3YQojSbXjGRPmQ0HAX4RYa2JYdVdOpg
   MzFjGzOeT4XKa11DXUbT0zR5Y3tfLUudPH82UNxoJHVGqwn3xCedtNZcS
   +UCXktKyBtSx6eDGW3efDuD+Ir8GU4fzFM24BBFOYVLciQZbh9h1i/wq4
   Q==;
X-CSE-ConnectionGUID: faUxKrh0Q22yJhIPVP1bww==
X-CSE-MsgGUID: zTrNtC28Tnud3EsWDCueBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="96348734"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="96348734"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 10:06:16 -0700
X-CSE-ConnectionGUID: hP4HVq98RBOw/F6Ed12JuA==
X-CSE-MsgGUID: MJC5toU5Sdiike/Z3xXiXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="260637384"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 10:06:16 -0700
Date: Fri, 17 Jul 2026 10:06:16 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.6.y 3/6] bpf: Restrict JIT predictor flush to cBPF
Message-ID: <20260717-cbpf-jit-spray-hardening-6-6-y-v1-3-e04f1b2893de@linux.intel.com>
X-Mailer: b4 0.16-dev
References: <20260717-cbpf-jit-spray-hardening-6-6-y-v1-0-e04f1b2893de@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717-cbpf-jit-spray-hardening-6-6-y-v1-0-e04f1b2893de@linux.intel.com>

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
 arch/riscv/net/bpf_jit_core.c |  3 ++-
 arch/x86/net/bpf_jit_comp.c   |  3 ++-
 include/linux/filter.h        |  5 +++--
 kernel/bpf/core.c             | 13 ++++++++-----
 kernel/bpf/dispatcher.c       |  2 +-
 5 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index 7b70ccb7fec3..8d8c5eb2e8da 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -123,7 +123,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
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
index 0be138fbd0a0..8028a5a4ab64 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2927,7 +2927,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
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
index 72926bc394ad..f2e351cc543d 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1065,7 +1065,7 @@ void bpf_jit_free(struct bpf_prog *fp);
 struct bpf_binary_header *
 bpf_jit_binary_pack_hdr(const struct bpf_prog *fp);
 
-void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns);
+void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool was_classic);
 void bpf_prog_pack_free(struct bpf_binary_header *hdr);
 
 static inline bool bpf_prog_kallsyms_verify_off(const struct bpf_prog *fp)
@@ -1079,7 +1079,8 @@ bpf_jit_binary_pack_alloc(unsigned int proglen, u8 **ro_image,
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
index 0d8008711629..509f1b9c2b2e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -911,7 +911,7 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 	return pack;
 }
 
-void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
+void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool was_classic)
 {
 	unsigned int nbits = BPF_PROG_SIZE_TO_NBITS(size);
 	struct bpf_prog_pack *pack;
@@ -926,7 +926,7 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 		 * safe because cBPF programs (the unprivileged attack surface)
 		 * are bounded well below a pack size.
 		 */
-		if (static_branch_unlikely(&bpf_pred_flush_enabled))
+		if (was_classic && static_branch_unlikely(&bpf_pred_flush_enabled))
 			pr_warn_once("BPF: Predictors not flushed for allocations greater than BPF_PROG_PACK_SIZE\n");
 		size = round_up(size, PAGE_SIZE);
 		ptr = bpf_jit_alloc_exec(size);
@@ -951,7 +951,9 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 	pos = 0;
 
 found_free_area:
-	static_call_cond(bpf_arch_pred_flush)();
+	/* Flush only for cBPF as it may contain a crafted gadget */
+	if (static_branch_unlikely(&bpf_pred_flush_enabled) && was_classic)
+		static_call_cond(bpf_arch_pred_flush)();
 	bitmap_set(pack->bitmap, pos, nbits);
 	ptr = (void *)(pack->ptr) + (pos << BPF_PROG_CHUNK_SHIFT);
 
@@ -1111,7 +1113,8 @@ bpf_jit_binary_pack_alloc(unsigned int proglen, u8 **image_ptr,
 			  unsigned int alignment,
 			  struct bpf_binary_header **rw_header,
 			  u8 **rw_image,
-			  bpf_jit_fill_hole_t bpf_fill_ill_insns)
+			  bpf_jit_fill_hole_t bpf_fill_ill_insns,
+			  bool was_classic)
 {
 	struct bpf_binary_header *ro_header;
 	u32 size, hole, start;
@@ -1124,7 +1127,7 @@ bpf_jit_binary_pack_alloc(unsigned int proglen, u8 **image_ptr,
 
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


