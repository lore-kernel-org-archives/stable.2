Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D95D42D77D;
	Mon, 27 Jul 2026 22:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192944; cv=none; b=guDdrzU8MVVVPXePx3QFeMVdGv31aJWEvObzlCqINkRi1JPnPMbhSOnSUDKyzsxwIOVxeiKPBMtcqDlha0zkz/I4Ccc+LLSUnWaLr5z5hQ+zREVS3A1bRfwW9AXgy3M/c63orANDnFOrtCpmzuh0FemLEJNlR5SegZDIYufd5Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192944; c=relaxed/simple;
	bh=SIFIRMXJ4rPuIRbyY/oXVwFL+9mqEeynymO/dtkY9ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEY3YP9NLQ++vytXZLvVwR4n7qMPkPQXbUUBqxBp+wooY1bv/9VGs0VmEuVY9ng4BKeOgVFqUQ1Ziu1hBvcGg0iDgmyjnSxqnkoJWxP12O8EeNfxIaK/TW73MgSNp7NnYHrHwjvoGYdmaohkwiSuVjq6IdXBdYwSDhaNXhOPAqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YcjUL/yz; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YcjUL/yz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785192943; x=1816728943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SIFIRMXJ4rPuIRbyY/oXVwFL+9mqEeynymO/dtkY9ks=;
  b=YcjUL/yzbL3I8iDK3JCl7sjyw16iIM6KL7d+BGLwt1UFYngktuhxI/Ms
   8nGWXGCEkMLzPcQb68v10OoCOLhrGKh7bE0W2Wje2ZqM2pD+1V9feGDqN
   CrP8YsFbkXV7r/EQ+8jY9kYEKpeCe7phBtJY7G0TwPxuIdWwnGczhSucC
   thyJlrOsb1Mshap5e92YUjd//el+Sq1k3fd5Q0fSKCISOOD+c2g5inHeK
   cX77DvZ4gGDcSOjOkHPG1pLnXZy4VfUnOeHboTMVAdAm3V3ADwCTfb8sg
   paqhF/BwDIWjVW6rZ67NXnhb3J/Cc6cpDQOKQfVHKfiBczAEdUJxMAth9
   g==;
X-CSE-ConnectionGUID: 2jztj3QAQWGw6jWompz00Q==
X-CSE-MsgGUID: oq9oH0+RT3yvOJqYwAlzAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="108564912"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="108564912"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 15:55:42 -0700
X-CSE-ConnectionGUID: r/I01hJ8RWiHGidAPwczmA==
X-CSE-MsgGUID: e9wXalOvQ4y4+hFTnA/6Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="255227095"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 15:55:41 -0700
Date: Mon, 27 Jul 2026 15:55:40 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, x86@kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.1.y 1/6] bpf: Support for hardening against JIT spraying
Message-ID: <20260727-cbpf-jit-spray-hardening-6-1-y-v1-1-eb80dcf1eb6e@linux.intel.com>
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

commit 96cce16e26dd02a8678f1e87f88a4b5cdb63b995 upstream.

The BPF JIT allocator packs many small programs into larger executable
allocations and reuses space within those allocations as programs are
loaded and freed. When fresh code is written into space that a previous
program occupied, an indirect jump into the new program can reuse a branch
prediction left behind by the old one.

Flush the indirect branch predictors before reusing JIT memory so that
indirect jumps into a newly written program don't reuse predictions from an
old program that occupied the same space.

Introduce bpf_arch_pred_flush_enabled static key and bpf_arch_pred_flush
static call for flushing the branch predictors on JIT memory reuse.
Architectures that need a flush, can update it to a predictor flush
function. By default, its a NOP and does not emit any CALL.

Allocations larger than a pack are not covered by this flush. That is safe
because cBPF programs (the unprivileged attack surface) are bounded well
below a pack size. Issue a warning if this assumption is ever violated
while the flush is active.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/filter.h | 10 ++++++++++
 kernel/bpf/core.c      | 19 +++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 37260c48fad4..fa7bb6f99598 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -21,6 +21,7 @@
 #include <linux/vmalloc.h>
 #include <linux/sockptr.h>
 #include <crypto/sha1.h>
+#include <linux/static_call.h>
 #include <linux/u64_stats_sync.h>
 
 #include <net/sch_generic.h>
@@ -1058,6 +1059,15 @@ extern long bpf_jit_limit_max;
 
 typedef void (*bpf_jit_fill_hole_t)(void *area, unsigned int size);
 
+/*
+ * Flush the indirect branch predictors before reusing JIT memory, so that
+ * indirect jumps into a newly written program don't reuse predictions left
+ * behind by an old program that occupied the same space.
+ */
+void bpf_arch_pred_flush(void);
+DECLARE_STATIC_CALL(bpf_arch_pred_flush, bpf_arch_pred_flush);
+DECLARE_STATIC_KEY_FALSE(bpf_pred_flush_enabled);
+
 void bpf_jit_fill_hole_with_zero(void *area, unsigned int size);
 
 struct bpf_binary_header *
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 77044d4a80cc..4643554c6e3a 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -35,6 +35,7 @@
 #include <linux/bpf_verifier.h>
 #include <linux/nodemask.h>
 #include <linux/nospec.h>
+#include <linux/static_call.h>
 
 #include <asm/barrier.h>
 #include <asm/unaligned.h>
@@ -852,6 +853,15 @@ void bpf_jit_fill_hole_with_zero(void *area, unsigned int size)
 	memset(area, 0, size);
 }
 
+DEFINE_STATIC_CALL_NULL(bpf_arch_pred_flush, bpf_arch_pred_flush);
+
+/*
+ * Enabled once bpf_arch_pred_flush points at a real flush routine. Lets the
+ * pack allocator test "is a predictor flush wired up at all" with a cheap
+ * static branch instead of repeatedly querying the static call target.
+ */
+DEFINE_STATIC_KEY_FALSE(bpf_pred_flush_enabled);
+
 #define BPF_PROG_SIZE_TO_NBITS(size)	(round_up(size, BPF_PROG_CHUNK_SIZE) / BPF_PROG_CHUNK_SIZE)
 
 static DEFINE_MUTEX(pack_mutex);
@@ -905,6 +915,14 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 
 	mutex_lock(&pack_mutex);
 	if (size > BPF_PROG_PACK_SIZE) {
+		/*
+		 * Allocations larger than a pack get their own pages, and
+		 * predictors are not flushed for such allocation. This is only
+		 * safe because cBPF programs (the unprivileged attack surface)
+		 * are bounded well below a pack size.
+		 */
+		if (static_branch_unlikely(&bpf_pred_flush_enabled))
+			pr_warn_once("BPF: Predictors not flushed for allocations greater than BPF_PROG_PACK_SIZE\n");
 		size = round_up(size, PAGE_SIZE);
 		ptr = module_alloc(size);
 		if (ptr) {
@@ -929,6 +947,7 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 	pos = 0;
 
 found_free_area:
+	static_call_cond(bpf_arch_pred_flush)();
 	bitmap_set(pack->bitmap, pos, nbits);
 	ptr = (void *)(pack->ptr) + (pos << BPF_PROG_CHUNK_SHIFT);
 

-- 
2.43.0


