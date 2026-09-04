Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C26E377034
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 02:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490537; cv=none; b=gmiQAIyqv1Z8CELqbbuFi9eBEE/yaVGZuv7CD4AAVI7cANKMEKeaL2fC/U+6TRxjXFJD6fmCO8IJEyHWNwa2Tovo34TCy6mTOEr9TFKltQZpWRIehpskj/9rT93L0nQ2p7P9xM+fAe62BggkfKm+SiaQpul51TV7OcW7AXA3hds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490537; c=relaxed/simple;
	bh=xErff8YwLCnuVRv45ZsBMhZ6l57hJIUPRP98y1ywpzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GM1u2O4kBz+9DSnfqg2RQCtNSsa4CAyaV54S+KHoKVv9Lf2Ql7e/1xun3Sz6892pUDv60Vy45LH4r9JmvLDJs9hGE0Z8F7C0ZD6YDBzqZ57br5J+8XWvNpqIqbvqkacMgzG59thzo4eOCxzuxFSOUFn6ED34FyutW8ZgdKf5Igg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYW5KpUO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYW5KpUO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB211F000E9;
	Fri,  4 Sep 2026 02:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788490536;
	bh=hkkEy3GfkXY6FNlfjpeNXEQMm2Nqc5AKy6gICqsN+yQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aYW5KpUOPMgPj/YTFEd4kS9TEo7wSjNJ+UwGJqddH9IUNqRemVIjAVRZws9wmsRoM
	 VUJWj5Ebmp7/f6YxNnU6tohFjw888H8EYQJIdU9HT54fZrTEVe9EbJnAEkF+In3qYC
	 82eigvOQrwhPoSKjq7T+XcoJLv/HZ3kFBN0wC7DTvjxwmuuTewcIWBjSWvV5LkV5i4
	 k0doIj185busdAVqphvnRNawaIDhT9bu8wNrhlVlAMyUU3/bQIYkqzyP8s6pVxovVB
	 /8/5tiqlkRmYiiOth4gLm5W58WZ3Fx1XWK1AMpwGlMkPosnbOJJ9LhoWx+nL3LskTv
	 ckmrrC7YQAN8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] x86/locking: Remove semicolon from "lock" prefix
Date: Thu,  3 Sep 2026 22:55:33 -0400
Message-ID: <20260904025534.2271771-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090322-unsaid-demote-cc78@gregkh>
References: <2026090322-unsaid-demote-cc78@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Uros Bizjak <ubizjak@gmail.com>

[ Upstream commit 023f3290b02552ea006c1a2013e373750d2cbff6 ]

Minimum version of binutils required to compile the kernel is 2.25.
This version correctly handles the "lock" prefix, so it is possible
to remove the semicolon, which was used to support ancient versions
of GNU as.

Due to the semicolon, the compiler considers "lock; insn" as two
separate instructions. Removing the semicolon makes asm length
calculations more accurate, consequently making scheduling and
inlining decisions of the compiler more accurate.

Removing the semicolon also enables assembler checks involving lock
prefix. Trying to assemble e.g. "lock andl %eax, %ebx" results in:

  Error: expecting lockable instruction after `lock'

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250228085149.2478245-1-ubizjak@gmail.com
Stable-dep-of: d824ed130768 ("x86/locking: Use sfence for wmb() if SSE is available")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/alternative.h |  2 +-
 arch/x86/include/asm/barrier.h     |  8 ++++----
 arch/x86/include/asm/cmpxchg.h     |  4 ++--
 arch/x86/include/asm/cmpxchg_32.h  |  4 ++--
 arch/x86/include/asm/edac.h        |  2 +-
 arch/x86/include/asm/sync_bitops.h | 12 ++++++------
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index f8dab517de8ac..2c7f83a1e670c 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -48,7 +48,7 @@
 		".popsection\n"				\
 		"671:"
 
-#define LOCK_PREFIX LOCK_PREFIX_HERE "\n\tlock; "
+#define LOCK_PREFIX LOCK_PREFIX_HERE "\n\tlock "
 
 #else /* ! CONFIG_SMP */
 #define LOCK_PREFIX_HERE ""
diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 7b44b3c4cce11..db70832232d4a 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -12,11 +12,11 @@
  */
 
 #ifdef CONFIG_X86_32
-#define mb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)", "mfence", \
+#define mb() asm volatile(ALTERNATIVE("lock addl $0,-4(%%esp)", "mfence", \
 				      X86_FEATURE_XMM2) ::: "memory", "cc")
-#define rmb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)", "lfence", \
+#define rmb() asm volatile(ALTERNATIVE("lock addl $0,-4(%%esp)", "lfence", \
 				       X86_FEATURE_XMM2) ::: "memory", "cc")
-#define wmb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)", "sfence", \
+#define wmb() asm volatile(ALTERNATIVE("lock addl $0,-4(%%esp)", "sfence", \
 				       X86_FEATURE_XMM2) ::: "memory", "cc")
 #else
 #define __mb()	asm volatile("mfence":::"memory")
@@ -50,7 +50,7 @@
 #define __dma_rmb()	barrier()
 #define __dma_wmb()	barrier()
 
-#define __smp_mb()	asm volatile("lock; addl $0,-4(%%" _ASM_SP ")" ::: "memory", "cc")
+#define __smp_mb()	asm volatile("lock addl $0,-4(%%" _ASM_SP ")" ::: "memory", "cc")
 
 #define __smp_rmb()	dma_rmb()
 #define __smp_wmb()	barrier()
diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index 5612648b02022..fd8afc1f5f6bb 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -134,7 +134,7 @@ extern void __add_wrong_size(void)
 	__raw_cmpxchg((ptr), (old), (new), (size), LOCK_PREFIX)
 
 #define __sync_cmpxchg(ptr, old, new, size)				\
-	__raw_cmpxchg((ptr), (old), (new), (size), "lock; ")
+	__raw_cmpxchg((ptr), (old), (new), (size), "lock ")
 
 #define __cmpxchg_local(ptr, old, new, size)				\
 	__raw_cmpxchg((ptr), (old), (new), (size), "")
@@ -222,7 +222,7 @@ extern void __add_wrong_size(void)
 	__raw_try_cmpxchg((ptr), (pold), (new), (size), LOCK_PREFIX)
 
 #define __sync_try_cmpxchg(ptr, pold, new, size)			\
-	__raw_try_cmpxchg((ptr), (pold), (new), (size), "lock; ")
+	__raw_try_cmpxchg((ptr), (pold), (new), (size), "lock ")
 
 #define __try_cmpxchg_local(ptr, pold, new, size)			\
 	__raw_try_cmpxchg((ptr), (pold), (new), (size), "")
diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index fd1282a783ddb..496ae94096ffd 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -103,7 +103,7 @@ static __always_inline bool __try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp,
 
 static __always_inline u64 arch_cmpxchg64(volatile u64 *ptr, u64 old, u64 new)
 {
-	return __arch_cmpxchg64_emu(ptr, old, new, LOCK_PREFIX_HERE, "lock; ");
+	return __arch_cmpxchg64_emu(ptr, old, new, LOCK_PREFIX_HERE, "lock ");
 }
 #define arch_cmpxchg64 arch_cmpxchg64
 
@@ -136,7 +136,7 @@ static __always_inline u64 arch_cmpxchg64_local(volatile u64 *ptr, u64 old, u64
 
 static __always_inline bool arch_try_cmpxchg64(volatile u64 *ptr, u64 *oldp, u64 new)
 {
-	return __arch_try_cmpxchg64_emu(ptr, oldp, new, LOCK_PREFIX_HERE, "lock; ");
+	return __arch_try_cmpxchg64_emu(ptr, oldp, new, LOCK_PREFIX_HERE, "lock ");
 }
 #define arch_try_cmpxchg64 arch_try_cmpxchg64
 
diff --git a/arch/x86/include/asm/edac.h b/arch/x86/include/asm/edac.h
index 426fc53ff8030..dfbd1ebb9f10b 100644
--- a/arch/x86/include/asm/edac.h
+++ b/arch/x86/include/asm/edac.h
@@ -13,7 +13,7 @@ static inline void edac_atomic_scrub(void *va, u32 size)
 	 * are interrupt, DMA and SMP safe.
 	 */
 	for (i = 0; i < size / 4; i++, virt_addr++)
-		asm volatile("lock; addl $0, %0"::"m" (*virt_addr));
+		asm volatile("lock addl $0, %0"::"m" (*virt_addr));
 }
 
 #endif /* _ASM_X86_EDAC_H */
diff --git a/arch/x86/include/asm/sync_bitops.h b/arch/x86/include/asm/sync_bitops.h
index 6d8d6bc183b74..cd21a0405ac52 100644
--- a/arch/x86/include/asm/sync_bitops.h
+++ b/arch/x86/include/asm/sync_bitops.h
@@ -31,7 +31,7 @@
  */
 static inline void sync_set_bit(long nr, volatile unsigned long *addr)
 {
-	asm volatile("lock; " __ASM_SIZE(bts) " %1,%0"
+	asm volatile("lock " __ASM_SIZE(bts) " %1,%0"
 		     : "+m" (ADDR)
 		     : "Ir" (nr)
 		     : "memory");
@@ -49,7 +49,7 @@ static inline void sync_set_bit(long nr, volatile unsigned long *addr)
  */
 static inline void sync_clear_bit(long nr, volatile unsigned long *addr)
 {
-	asm volatile("lock; " __ASM_SIZE(btr) " %1,%0"
+	asm volatile("lock " __ASM_SIZE(btr) " %1,%0"
 		     : "+m" (ADDR)
 		     : "Ir" (nr)
 		     : "memory");
@@ -66,7 +66,7 @@ static inline void sync_clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline void sync_change_bit(long nr, volatile unsigned long *addr)
 {
-	asm volatile("lock; " __ASM_SIZE(btc) " %1,%0"
+	asm volatile("lock " __ASM_SIZE(btc) " %1,%0"
 		     : "+m" (ADDR)
 		     : "Ir" (nr)
 		     : "memory");
@@ -82,7 +82,7 @@ static inline void sync_change_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool sync_test_and_set_bit(long nr, volatile unsigned long *addr)
 {
-	return GEN_BINARY_RMWcc("lock; " __ASM_SIZE(bts), *addr, c, "Ir", nr);
+	return GEN_BINARY_RMWcc("lock " __ASM_SIZE(bts), *addr, c, "Ir", nr);
 }
 
 /**
@@ -95,7 +95,7 @@ static inline bool sync_test_and_set_bit(long nr, volatile unsigned long *addr)
  */
 static inline int sync_test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
-	return GEN_BINARY_RMWcc("lock; " __ASM_SIZE(btr), *addr, c, "Ir", nr);
+	return GEN_BINARY_RMWcc("lock " __ASM_SIZE(btr), *addr, c, "Ir", nr);
 }
 
 /**
@@ -108,7 +108,7 @@ static inline int sync_test_and_clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline int sync_test_and_change_bit(long nr, volatile unsigned long *addr)
 {
-	return GEN_BINARY_RMWcc("lock; " __ASM_SIZE(btc), *addr, c, "Ir", nr);
+	return GEN_BINARY_RMWcc("lock " __ASM_SIZE(btc), *addr, c, "Ir", nr);
 }
 
 #define sync_test_bit(nr, addr) test_bit(nr, addr)
-- 
2.53.0

