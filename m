Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418BF38735D
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091126; cv=none; b=exq6pehdCXo+OUjc1S5YOeY2hsVz+ffMWHdRnhWAKbGM4TzOTFpBNGo1hbrtqVe8mNOSBk8pIzfrpDYxQu3TqR/YWzBruGGdq7LEs2B4/NnzFxeWbs2mg27Jm+IxpLftBEI90b3Hr3jP0dIs6crgSDXlCvhVXR61AGO2mutJ+Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091126; c=relaxed/simple;
	bh=ZpmfDgxXSvElSc8bNKB42ALR3vm5DJUo9xX0ZFN0Iko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEqG9ofIJFXFSUC385BJmFJkv1YUYkvjfucayYJMELysXM4+Vpc2AwS3hl3Ml13ldIdgG5XUaIYazdgO7TvxLyEkH2LzIV5Tp7AJyTmp7L8y866a87KTmXCNIE2Kwu/mR9M0hI7MSum7jHds7n9hY9hk24UU+EJgCl3oxvuWLq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3nCaUsz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3nCaUsz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DAA21F00893;
	Tue, 22 Sep 2026 15:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790091124;
	bh=q5MRm4MVxFVHUzCo7fBVsZayK1eXbHD4p92CaLBZo1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I3nCaUsz04GXnhUKLw8aZFrC1kWxDEU468k+eIvpVuS+GJV7kwY/AzIkcNzgNuwVd
	 gEhgcD8fRyuDkRqE9odIoCLDv++pdmHj8hCqz9Z5azQz4S7RTr9oFrMRgDtnyheF3Z
	 7ARX1F96ss2FOKYtRfYKSnw1gnEnN8NbYg+wNRdULDYIOpd6Fu8q1nYD7guyt1wHTq
	 JEnh915IsP+8HxQX7L8bAhO0mUsKOE/wKhueKrJQ+EvwVGHJ++6mSvLTnn5x3yWYkN
	 Rryz0dpVHDmoAeca5ASWUP8wRX11syuGEhUbYO699I8UD5NsBfJZGYarhE0Mke1vbm
	 FvNdb/TO3c2Xg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Will Deacon <will@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] arm64: Use load LSE atomics for the non-return per-CPU atomic operations
Date: Tue, 22 Sep 2026 11:32:01 -0400
Message-ID: <20260922153202.2820773-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092223-oxford-subside-0146@gregkh>
References: <2026092223-oxford-subside-0146@gregkh>
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
index 9abcc8ef3087b..b57b2bb009677 100644
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

