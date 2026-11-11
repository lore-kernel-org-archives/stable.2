Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.68
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439594;
	b=3MFlhjMsRLWKBL0XbprfWt/Utw/ewWC6AShIjrXRjV1qeJnl53UpmnCog0gYaWLVm06Q
	 0TvDaqApYo6QmyM6+OAFI4fySS/jZX4biew5LCuO3ogq/FbRCy3U7bHiiG/5wVXu6QWm+
	 Sj4IR8Vs/gByNQaoaS3JY2Ix4T+pOoXalDP9GZ/jv9DaflE0Fj6CZ6gk4Bn07AMaNNNeq
	 b5qd1RiWBzkuEQoSXkx/Wr08dT8iY8PAIsHlSjbmEeRVPFZ8E9h/65AGl30f5yYqjtcrW
	 SlW1oGB/E4Q2OU65lBufDDFlyJD8eB9YlOia5U5J0Kkwwe16o/JrlNIC3dgZ8iGZR3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439594;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Subject:To:Cc:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id:
	 In-Reply-To:References;
	bh=RyEZLtXdOEy6YUs0iF5WO14oNHotCxIJ28slgWaTiiU=;
	b=Qbw/STb3FpgWZcwpDUpAA8mhxnLDPKq6TsEIsilwUs7d4lvdKKn+LSneo4b9SrQ2Ch89
	 kk002y+xR5ITJ4VRnj9N854eYs3LQwfwhqi2IrAMwHt58i8ZbrFAd38s2yqsGhqUsjxDZ
	 3uMyPmD+iTmiXaoZEjwWJG2YTGPsjA6nURRwOfdgo7rKLWXMOahKyhC7fmJOfz8fryd5X
	 2cly/RVQqC5Tlx75gTDF0BdWVCq3OBSHDz+aEjbLlSUAkbAQ0LM0s4ts48syAVoz8RFPC
	 fRftGiLryFinXBiIb7gc9iYG2UnBlYmFlVE9O+ykE9+5gwdHJ5Q/GLTS6tAqeu3kzEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cressey.dev;
	spf=pass smtp.mailfrom=cressey.dev;
	dkim=pass header.d=cressey.dev header.i=@cressey.dev header.a=rsa-sha256 header.s=key1 header.b=Sn33619E;
	arc=none smtp.remote-ip=95.215.58.68
Received: from mta1.migadu.com (out-68.mta1.migadu.com [95.215.58.68])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C68606A8B1
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5C68606A8B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cressey.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cressey.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cressey.dev header.i=@cressey.dev header.a=rsa-sha256 header.s=key1 header.b=Sn33619E
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Z+IeZxbPjIvbK3g0gOTsghY/BOFs/EzEtXZfgL4WUf8=;
 c=simple/simple; d=cressey.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794439591; v=1; x=1795044391;
 b=Sn33619EXcFGXCJK9LnzuueZXjZ9jbMi1mpw0G48KB9e2lRh9CHxJZP3OSp9X01dciXn80UK
 5zueYCDAo+Ky4oeq3N4IEd0zCdxK1lxYosEKo+Z88gl3driG7qIQ+LKae/JZscfJkOBk/juiZxq
 lV31+W1vYpD0MaXXOTDxOTCaCd7gTuvBNFkw/yMzStUtiTi/5bc6FfTZZ9NSx9Km10umlvGpl+O
 mC+u3ZH+MxOMreOEpahEhK+tf7aMp3y6P3n1kec9Oj8myFa7NHQbEznXAEgQBw7FTAV8k6W+JV5
 Ya+Oly/3jwGB/x1HysV0wgEMLlRF6egx5bUKSYXUJfARw==
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fa50d89f0875e7b8;
	Wed, 11 Nov 2026 23:26:31 +0000
X-Mizu-Trace-ID: fa50d89f0875e7b8
X-Migadu-Flow: FLOW_OUT
From: Ben Cressey <ben@cressey.dev>
Subject: [PATCH v2 1/2] arm64: kexec: use a typed entry to fix kCFI oops
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Kees Cook <kees@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, kexec@lists.infradead.org, 
 llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>, 
 Zhaoyang Huang <zhaoyang.huang@unisoc.com>, 
 Jeson Gao <jeson.gao@unisoc.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Date: Wed, 11 Nov 2026 15:26:04 -0800
Message-Id: <20261111-arm64-kexec-nocfi-v2-1-ddf0c4aa326f@cressey.dev>
In-Reply-To: <20261111-arm64-kexec-nocfi-v2-0-ddf0c4aa326f@cressey.dev>
References: <20261111-arm64-kexec-nocfi-v2-0-ddf0c4aa326f@cressey.dev>

An arm64 Linux kernel built with CONFIG_CFI=y oopses after "Bye!" on
every kexec that relocates the image. Crash images load in place and are
not affected. The oops reproduces under QEMU:

 Unable to handle kernel paging request at virtual address 00000000544bfffc
 pc : machine_kexec+0x104/0x274
 Code: d5182008 d5033fdf aa1303e0 f9418a68 (b85fc110)

b85fc110 is "ldur w16, [x8, #-4]", the kCFI check's load of the type
hash in front of the callee. Commit efc2d0f20a9d ("arm64: kexec: keep
MMU enabled during kexec relocation") made machine_kexec() call the
control page's copy of arm64_relocate_new_kernel() indirectly, while
TTBR0 maps only that page. The copy starts at the page's first byte, so
the load faults. SYM_CODE_START() also gives the routine no hash.

SYM_TYPED_FUNC_START() emits the hash inside .kexec_relocate.text, and
machine_kexec_post_load() already copies that whole section, at most
4 KiB, to the page's start, so the mapped page holds both hash and
entry.

The ASSERT from commit dc4824faa265 ("arm64: avoid executing padding
bytes during kexec / hibernation") kept the entry first, since C
branched to the page's start. Relax it, so the entry need only be in the
section.

Fix by typing the routine with SYM_TYPED_FUNC_START() and a C prototype,
and entering the copy at the symbol's offset in the section.

The code is Kees Cook's, as posted in review, with two comments and the
ASSERT message reworded.

An LLM diagnosed the oops.

Fixes: efc2d0f20a9d ("arm64: kexec: keep MMU enabled during kexec relocation")
Cc: stable@vger.kernel.org
Suggested-by: Kees Cook <kees@kernel.org>
Link: https://lore.kernel.org/linux-arm-kernel/202609241804.BB23BF10@keescook/
Signed-off-by: Ben Cressey <ben@cressey.dev>
---
 arch/arm64/include/asm/kexec.h      |  2 ++
 arch/arm64/kernel/machine_kexec.c   |  7 +++++--
 arch/arm64/kernel/relocate_kernel.S | 11 +++++++----
 arch/arm64/kernel/vmlinux.lds.S     |  5 +++--
 4 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 892e5bebda95..0be042ec22c1 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -100,6 +100,8 @@ void cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
 		      unsigned long arg0, unsigned long arg1,
 		      unsigned long arg2);
 
+void arm64_relocate_new_kernel(struct kimage *kimage);
+
 int machine_kexec_post_load(struct kimage *image);
 #define machine_kexec_post_load machine_kexec_post_load
 #endif
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 48f343704cb5..24366b5b3259 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -147,9 +147,12 @@ int machine_kexec_post_load(struct kimage *kimage)
 	kimage->arch.ttbr1 = __pa(trans_pgd);
 	kimage->arch.zero_page = __pa_symbol(empty_zero_page);
 
+	/* Copy the whole section: a kCFI hash may precede the entry point */
 	reloc_size = __relocate_new_kernel_end - __relocate_new_kernel_start;
 	memcpy(reloc_code, __relocate_new_kernel_start, reloc_size);
-	kimage->arch.kern_reloc = __pa(reloc_code);
+	kimage->arch.kern_reloc = __pa(reloc_code) +
+		((unsigned long)arm64_relocate_new_kernel -
+		 (unsigned long)__relocate_new_kernel_start);
 	rc = trans_pgd_idmap_page(&info, &kimage->arch.ttbr0,
 				  &kimage->arch.t0sz, reloc_code);
 	if (rc)
@@ -204,7 +207,7 @@ void machine_kexec(struct kimage *kimage)
 		restart(is_hyp_nvhe(), kimage->start, kimage->arch.dtb_mem,
 			0, 0);
 	} else {
-		void (*kernel_reloc)(struct kimage *kimage);
+		typeof(arm64_relocate_new_kernel) *kernel_reloc;
 
 		if (is_hyp_nvhe())
 			__hyp_set_vectors(kimage->arch.el2_vectors);
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index 6cb4209f5dab..064db5856bba 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -8,6 +8,7 @@
  * Pasha Tatashin <pasha.tatashin@soleen.com>
  */
 
+#include <linux/cfi_types.h>
 #include <linux/kexec.h>
 #include <linux/linkage.h>
 
@@ -32,11 +33,13 @@
  * new image to its final location.  To assure that the
  * arm64_relocate_new_kernel routine which does that copy is not overwritten,
  * all code and data needed by arm64_relocate_new_kernel must be between the
- * symbols arm64_relocate_new_kernel and arm64_relocate_new_kernel_end.  The
- * machine_kexec() routine will copy arm64_relocate_new_kernel to the kexec
+ * symbols __relocate_new_kernel_start and __relocate_new_kernel_end.  The
+ * machine_kexec_post_load() routine will copy that whole region to the kexec
  * safe memory that has been set up to be preserved during the copy operation.
+ *
+ * Called indirectly by machine_kexec(), this routine needs a kCFI type hash.
  */
-SYM_CODE_START(arm64_relocate_new_kernel)
+SYM_TYPED_FUNC_START(arm64_relocate_new_kernel)
 	/*
 	 * The kimage structure isn't allocated specially and may be clobbered
 	 * during relocation. We must load any values we need from it prior to
@@ -98,4 +101,4 @@ SYM_CODE_START(arm64_relocate_new_kernel)
 	mov	x2, xzr
 	mov	x3, xzr
 	br	x28				/* Jumps from el1 */
-SYM_CODE_END(arm64_relocate_new_kernel)
+SYM_FUNC_END(arm64_relocate_new_kernel)
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 1869b44ae190..c95243a8b24e 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -440,6 +440,7 @@ ASSERT(swapper_pg_dir - tramp_pg_dir == TRAMP_SWAPPER_OFFSET,
 ASSERT(__relocate_new_kernel_end - __relocate_new_kernel_start <= SZ_4K,
        "kexec relocation code is bigger than 4 KiB")
 ASSERT(KEXEC_CONTROL_PAGE_SIZE >= SZ_4K, "KEXEC_CONTROL_PAGE_SIZE is broken")
-ASSERT(__relocate_new_kernel_start == arm64_relocate_new_kernel,
-       "kexec control page does not start with arm64_relocate_new_kernel")
+ASSERT(arm64_relocate_new_kernel >= __relocate_new_kernel_start &&
+       arm64_relocate_new_kernel < __relocate_new_kernel_end,
+       "kexec relocation code does not contain arm64_relocate_new_kernel")
 #endif

-- 
2.56.0

