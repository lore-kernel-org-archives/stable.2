Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A706E55C1D2
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091714; cv=none; b=ChEz/C9oCeMhUKEKP4U5AOFLCpI/6JL2MhVrMBzeih+kJDOe8BzkNeN4R8blDxXv9fHFzLBLU0sI9LgzcJ2vwuz0kjiPDLSSB7OWpxiKKsVZa8oWy3yON6IySpvN75h2gmKOiZAbv/66g/URY+ACfh5IdjsrMkYwF8hxyCLCU9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091714; c=relaxed/simple;
	bh=4i4IVQoZM2TmAG0/9qcPC73aT0gobf0PZBzG+Jny0NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=No03P+uEslSdDtwayU24Zr20+Chv2LIL3S6atrpguV8pbPKnmPdLQ3kbM8OPFuCXACf+D9sRCJB7XBOtd80lGzdAYxhRg4b9KfwTisFL+jBW51bHzBtYDX7y1pl/xBKMg0ZOG6NT/v/rFFLHPA2MV8ZF2X5sgWnkefRTXnqBzhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBH1AE//; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBH1AE//"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8981F000FF;
	Tue, 22 Sep 2026 15:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790091713;
	bh=dEzSEGQ95uQb0UliQs/rgVTyn2lf9w3BHz5/jghJWsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WBH1AE//Fin6P++4wuqNac3dki8FEwCDW2RAh/FNDjRdpAFlN3oxQiAGaR4n2DfnA
	 EAVvBqAVlvLsluiWBeu27bTshGBMVCJmifz1ysZiIFdDSVu7vEwCxV0aG62XH/89vT
	 ym+9qVaxR9eD0jFLpJ89xG5l9/HO+Skzxvkgb7gbfBwu2KhWigythXehbjt5PEdfZq
	 67SUbtRq/3QEXXxoY+j0UURLmDmcLu4hVQ3uiAg6qJclEM0QfE+ixzH1LNzmESLD+w
	 jFURTGiN+e9zYJfX0Hl3z/T3/zE+ss8B+5M5xRaxwxv5frDCboAH42rZwtszmc1GOD
	 capfGJTT/J2AQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Will Deacon <will@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] arm64: Use load LSE atomics for the non-return per-CPU atomic operations
Date: Tue, 22 Sep 2026 11:41:49 -0400
Message-ID: <20260922154150.2890616-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092224-crabmeat-morbidity-9c34@gregkh>
References: <2026092224-crabmeat-morbidity-9c34@gregkh>
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
index b9ba19dbdb694..aaa96f746c1ab 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -77,7 +77,7 @@ __percpu_##name##_case_##sz(void *ptr, unsigned long val)		\
 	"	stxr" #sfx "\t%w[loop], %" #w "[tmp], %[ptr]\n"		\
 	"	cbnz	%w[loop], 1b",					\
 	/* LSE atomics */						\
-		#op_lse "\t%" #w "[val], %[ptr]\n"			\
+		#op_lse "\t%" #w "[val], %" #w "[tmp], %[ptr]\n"	\
 		__nops(3))						\
 	: [loop] "=&r" (loop), [tmp] "=&r" (tmp),			\
 	  [ptr] "+Q"(*(u##sz *)ptr)					\
@@ -124,9 +124,16 @@ PERCPU_RW_OPS(8)
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

