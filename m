Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936236;
	b=2pGoCWXgtKRVhXt2uCrCGBCn0q2BzvoTwuBEdy/z54ZukHEHqJ88blr+yv0wkPYH+HXE
	 p/gYMnh1pICF2ZEkPnT0QDiehM5WS+x9rRp5+uTqo+9MU/Bb3sR1gibukz75EvAoXCkpa
	 HeMoHnxFYRxSk1xMBS1ypR4JGUuM1leC8LmoUXIozLJhVCCNmLHlpYErFAggoytUMEguU
	 sGtJoTZGMnB23H0KtxWtyXj6Id17tIXnkKLgelIgJhFeIVWYjWE7ALb2CuZTvR3HCyR3x
	 VeGZQNy83uRuviFyXlfKO8XV9r20b22f88dEUKB7F1mCjynoGGSMFMPXoxi+fr5OD8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936236;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=+1CUcFNE7JwfSHGV62hBf/oteDplXzPtQU4sFGBvXqM=;
	b=0aBkCLHEv2kE88jjUzHMDc2v34pMwp34/lPCRxNGNUbmi6OlLEC//+m5QLgEcKqI/mTn
	 B8UhZ4xeFomZgQHhw1OPNHU/wgAl/e+q4qLg5PZt3YE5s0fxsgt/Md+52HUL9222+oblg
	 xVEykLAbbqPAzjGUZhQDRnLb92DjInPrYqXS83uZLKPsY09DnWtLvuBOXCAUKDO5ch9/S
	 Aga1SJ4JYewRY1DVzlpdJ4vYLJ0liKhUKcFi+QAbtezwZyGb6SdiXf2PZQ4I1pynLjc6k
	 0lz2wxTX+aLMgXG1GYMyBuU4g0dxrTKCisx8WzDdakqGZqowJt2d3KV5NFob0dwjnMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=X26tYuWa;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B62606A32A;
	Tue, 17 Nov 2026 17:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51B62606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=X26tYuWa
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B615E1A00;
	Tue, 17 Nov 2026 09:23:52 -0800 (PST)
Received: from e144440.cambridge.arm.com (e144440.arm.com [10.2.199.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE1CD3F632;
	Tue, 17 Nov 2026 09:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794936235; bh=nuuxNabwLDGMU43xHBMlv65TOjY4YdPO5UFA/AgDsmQ=;
	h=From:To:Cc:Subject:Date:From;
	b=X26tYuWa+ayRlYoEsgE88VEUuQSKMuliPzXKPOx6yh/KWkxN39IiELtTfcS2gRk3J
	 6SmATcQOc+s/hgPrJ2rIOdWmsmZjONdKMp3qu4lS9iHVksalcZjuqR3cNGG1+ne+gb
	 N4PM08YSNtMxOaR3KFb20OenFJijKD09w0Es5IQ8=
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] arm64: Mitigate Spectre v1 in the BPF interpreter
Date: Tue, 17 Nov 2026 17:23:40 +0000
Message-ID: <20261117172341.3152407-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF verifier can accept programs with unsafe speculative paths by
inserting BPF_NOSPEC instructions instead of rejecting them. It relies
on those instructions to prevent execution of the unsafe paths.

The arm64 JIT implements BPF_NOSPEC with a speculation barrier, but the
interpreter calls barrier_nospec(), which falls back to a no-op on
arm64. Programs executed by the interpreter therefore lack the
Spectre-v1 barriers assumed by the verifier. Contrary to the code
comment, kernel-wide SSBD does not provide this protection, since it
mitigates Spectre v4 rather than Spectre v1.

Rename spec_bar() to barrier_nospec() so that the interpreter and other
callers receive SB if supported, or DSB NSH followed by ISB otherwise.

Defining barrier_nospec() would also add barriers to the generic
copy_from_user() and copy_from_user_iter() paths. These are unnecessary
on arm64: its uaccess primitives mask user pointers so that they cannot
address kernel memory even when an access_ok() check is mispredicted.

Introduce user_access_may_speculate_kernel_addr(), defaulting to true,
and have arm64 return false. Then update the uaccess sites to call
barrier_nospec() conditionally on the macro.

Cc: stable@vger.kernel.org
Fixes: d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1")
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/barrier.h | 6 +++---
 arch/arm64/include/asm/uaccess.h | 3 +++
 arch/arm64/kernel/proton-pack.c  | 2 +-
 include/linux/uaccess.h          | 7 ++++++-
 kernel/bpf/core.c                | 9 +--------
 lib/iov_iter.c                   | 3 ++-
 6 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 9495c4441a46..088ee29d36f4 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -40,9 +40,9 @@
  */
 #define dgh()		asm volatile("hint #6" : : : "memory")

-#define spec_bar()	asm volatile(ALTERNATIVE("dsb nsh\nisb\n",		\
-						 SB_BARRIER_INSN"nop\n",	\
-						 ARM64_HAS_SB))
+#define barrier_nospec() asm volatile(ALTERNATIVE("dsb nsh\nisb\n",		\
+						  SB_BARRIER_INSN"nop\n",	\
+						  ARM64_HAS_SB) : : : "memory")

 #define gsb_ack()	asm volatile(GSB_ACK_BARRIER_INSN : : : "memory")
 #define gsb_sys()	asm volatile(GSB_SYS_BARRIER_INSN : : : "memory")
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 9f5bd9c69c24..6fd03dc1ae76 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -174,6 +174,9 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	return safe_ptr;
 }

+/* __uaccess_mask_ptr() prevents speculative accesses to kernel addresses. */
+#define user_access_may_speculate_kernel_addr() false
+
 /*
  * The "__xxx" versions of the user access functions do not verify the address
  * space - it must have been done previously with a separate "access_ok()"
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 3bcf86154d95..c96e93eca3b9 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -559,7 +559,7 @@ static enum mitigation_state spectre_v4_enable_hw_mitigation(void)
 	 * could mis-speculate branches and bypass a conditional barrier.
 	 */
 	if (IS_ENABLED(CONFIG_ARM64_ERRATUM_3194386))
-		spec_bar();
+		barrier_nospec();

 	return SPECTRE_MITIGATED;
 }
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 67cdb0a4f583..5a1fa4f48c77 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -50,6 +50,10 @@
  #define mask_user_address(src) (src)
 #endif

+#ifndef user_access_may_speculate_kernel_addr
+#define user_access_may_speculate_kernel_addr() true
+#endif
+
 /*
  * Architectures should provide two primitives (raw_copy_{to,from}_user())
  * and get rid of their private instances of copy_{to,from}_user() and
@@ -179,7 +183,8 @@ _inline_copy_from_user(void *to, const void __user *from, unsigned long n)
 		 * lead to nasty side effects *after* the copy is
 		 * finished:
 		 */
-		barrier_nospec();
+		if (user_access_may_speculate_kernel_addr())
+			barrier_nospec();
 	}
 	instrument_copy_from_user_before(to, from, n);
 	res = raw_copy_from_user(to, from, n);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 0b8456f2dce9..abd938d310bb 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2250,14 +2250,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 	/* ST, STX and LDX*/
 	ST_NOSPEC:
 		/* Speculation barrier for mitigating Speculative Store Bypass,
-		 * Bounds-Check Bypass and Type Confusion. In case of arm64, we
-		 * rely on the firmware mitigation as controlled via the ssbd
-		 * kernel parameter. Whenever the mitigation is enabled, it
-		 * works for all of the kernel code with no need to provide any
-		 * additional instructions here. In case of x86, we use 'lfence'
-		 * insn for mitigation. We reuse preexisting logic from Spectre
-		 * v1 mitigation that happens to produce the required code on
-		 * x86 for v4 as well.
+		 * Bounds-Check Bypass and Type Confusion.
 		 */
 		barrier_nospec();
 		CONT;
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index fa4fe2e92383..abd27189beff 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -60,7 +60,8 @@ size_t copy_from_user_iter(void __user *iter_from, size_t progress,
 		 * lead to nasty side effects *after* the copy is
 		 * finished:
 		 */
-		barrier_nospec();
+		if (user_access_may_speculate_kernel_addr())
+			barrier_nospec();
 	}
 	to += progress;
 	instrument_copy_from_user_before(to, iter_from, len);
--
2.43.0

