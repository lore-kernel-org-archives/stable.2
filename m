Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F80560AC5
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092416; cv=none; b=BfwTCpcYz8/4t5Vm/0nyvdli2xfDEKEhZiMe1X0hPtHMy3kesHmll+c+QV37Lm7pHwefOsIwhmzsDK0QGB3dfHqLbxMPfm9vwN5uLyocfQcYCGt4nyR6I7PngtTrLKuCDHhI30ZoVpSfs78f0LnBqqgqhXicL17/0N+U2/jUCog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092416; c=relaxed/simple;
	bh=2h1hCHUi5lwHiXMucGYLITNEtxhUjGGPCrsb+zptgs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTSNEWHsS3lcdnZiABue+djcS74KyEE+zVya3zAQ+GN6wbdiTK7y14AfPkdX3JfRJ3XFYo3el1+G0xmg7+7Osog4wsIv7J0HpynBICEJ0EfoKeUHtNk/1Qje7JtM1vX7MMr4KV64WS+Xfgzt/YGx9qrnzfRt1TDAkASl6aJ+7n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4ihC6Zs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4ihC6Zs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78F71F000FF;
	Tue, 22 Sep 2026 15:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790092411;
	bh=WtO+X91tWEZV9U9GEVNHTt6wcjOkFJoeeUZk/KNrfOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G4ihC6Zsq/1eguimnYeybPTtR57h3wzqg08fTs7/fg7Xi+y8l6kmHV15zxVgV4QAV
	 IB/ECBUa17JM5fZA2XC+K1q9+/hJZPG33Fw7QlgqvRlxdSCFwedwhqKiCHP2Fjo2kH
	 yqkbyVMq7jiO+sSinZgmXDEUAtxUbc+ViDzIbSNCHFzhEUOPzez3JgTiiLc46TX2Ea
	 mRWK+Rp6rrh5/rDwxcD1qkZ61Jg1njf8DPEyLeSECIaA1uF3AOwHk+48VQuLvZ2uRZ
	 auZh79RmXq+aaaM1tJxd0ALtEHbEAIFcH0HGfikAGqPEeDGR0mtqyti/bhitGVx9eu
	 Zf13MyQ6XpO6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Will Deacon <will@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] arm64: Use load LSE atomics for the non-return per-CPU atomic operations
Date: Tue, 22 Sep 2026 11:53:28 -0400
Message-ID: <20260922155329.2918313-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092226-habitat-wipe-a94c@gregkh>
References: <2026092226-habitat-wipe-a94c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Catalin Marinas <catalin.marinas@arm.com>

[ Upstream commit 535fdfc5a228524552ee8810c9175e877e127c27 ]

The non-return per-CPU this_cpu_*() atomic operations are implemented as
STADD/STCLR/STSET when FEAT_LSE is available. On many microarchitecture
implementations, these instructions tend to be executed "far" in the
interconnect or memory subsystem (unless the data is already in the L1
cache). This is in general more efficient when there is contention as it
avoids bouncing cache lines between CPUs. The load atomics (e.g. LDADD
without XZR as destination), OTOH, tend to be executed "near" with the
data loaded into the L1 cache.

STADD executed back to back as in srcu_read_{lock,unlock}*() incur an
additional overhead due to the default posting behaviour on several CPU
implementations. Since the per-CPU atomics are unlikely to be used
concurrently on the same memory location, encourage the hardware to to
execute them "near" by issuing load atomics - LDADD/LDCLR/LDSET - with
the destination register unused (but not XZR).

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/e7d539ed-ced0-4b96-8ecd-048a5b803b85@paulmck-laptop
Reported-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>
[will: Add comment and link to the discussion thread]
Signed-off-by: Will Deacon <will@kernel.org>
Stable-dep-of: 8cf2093f5372 ("arm64: percpu: Fix LSE operations on {8,16}-bit types")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/percpu.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 1599e17379d86..98b083ef9ce17 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -76,7 +76,7 @@ __percpu_##name##_case_##sz(void *ptr, unsigned long val)		\
 	"	stxr" #sfx "\t%w[loop], %" #w "[tmp], %[ptr]\n"		\
 	"	cbnz	%w[loop], 1b",					\
 	/* LSE atomics */						\
-		#op_lse "\t%" #w "[val], %[ptr]\n"			\
+		#op_lse "\t%" #w "[val], %" #w "[tmp], %[ptr]\n"	\
 		__nops(3))						\
 	: [loop] "=&r" (loop), [tmp] "=&r" (tmp),			\
 	  [ptr] "+Q"(*(u##sz *)ptr)					\
@@ -123,9 +123,16 @@ PERCPU_RW_OPS(8)
 PERCPU_RW_OPS(16)
 PERCPU_RW_OPS(32)
 PERCPU_RW_OPS(64)
-PERCPU_OP(add, add, stadd)
-PERCPU_OP(andnot, bic, stclr)
-PERCPU_OP(or, orr, stset)
+
+/*
+ * Use value-returning atomics for CPU-local ops as they are more likely
+ * to execute "near" to the CPU (e.g. in L1$).
+ *
+ * https://lore.kernel.org/r/e7d539ed-ced0-4b96-8ecd-048a5b803b85@paulmck-laptop
+ */
+PERCPU_OP(add, add, ldadd)
+PERCPU_OP(andnot, bic, ldclr)
+PERCPU_OP(or, orr, ldset)
 PERCPU_RET_OP(add, add, ldadd)
 
 #undef PERCPU_RW_OPS
-- 
2.53.0

