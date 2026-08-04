Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3453247A896
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 17:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863218; cv=none; b=Z5szsCoBaTV8vMXN0P7augYNJGb4jpAifdZ5/6HD2oRs55SK7fQBgw6mprawjKYy88Cmn5Z4N/h/P/vMXrj/lwAL2PLiPOaZT6adbDyR5KtgKzTZ5RS0NSkiNIpisyMlLHt8q/e/RiDDZKzaixooGIf1HG5wlMbuJK+Lcd//yHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863218; c=relaxed/simple;
	bh=N3k/BFqcD2WTlvO7Svd3PMSwWKY1jVLsm+NzT03qOVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GklGF0wz0sGw2AaelFaNVacvk9j1hstdqPfVyy0OyTsTi/EmHP/LGGwxJNXVaHaAYdGwBm/rNQ9yZwr0K7wzw+l1qRW41Ez9vDZayIUi0OCxXywUu1moxseINKUc8MFHLrw0IP7DpOS15vjGXyEhH/DNE7aHgO7HOQrJkq9q5Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Xa8ZGufP; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Xa8ZGufP"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D181168F;
	Tue,  4 Aug 2026 10:06:37 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8C7253F632;
	Tue,  4 Aug 2026 10:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785863201; bh=N3k/BFqcD2WTlvO7Svd3PMSwWKY1jVLsm+NzT03qOVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xa8ZGufPuIFz8CCSyocV/nU9zIT0o78uhZrtFg81RdPfTS9Zk2uQpkIwnkKybOcL3
	 6hDOmJRpDd94ByEyXIyzhAecqhX8HZhJsiJMBSABWn3NOqBt0q24PTqOPyIEerBxRL
	 jyQhURGb4JLWMcQe2iu+eQbNsspdXOAs0LOGkPXU=
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: ada.coupriediaz@arm.com,
	ardb@kernel.org,
	catalin.marinas@arm.com,
	cl@gentwo.org,
	david@kernel.org,
	david.laight.linux@gmail.com,
	james.morse@arm.com,
	ljs@kernel.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	peterz@infradead.org,
	ruanjinjie@huawei.com,
	ryan.roberts@arm.com,
	stable@vger.kernel.org,
	vladimir.murzin@arm.com,
	will@kernel.org,
	yang@os.amperecomputing.com
Subject: [PATCH v2 20/20] arm64: percpu: Remove _pcp_protect*() wrappers
Date: Tue,  4 Aug 2026 18:05:03 +0100
Message-Id: <20260804170503.3513916-21-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260804170503.3513916-1-mark.rutland@arm.com>
References: <20260804170503.3513916-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that all this_cpu_*() operations are preemptible, there are no users
of _pcp_protect() or _pcp_protect_return().

Remove them both, along with the associated comment regarding
preemption.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/include/asm/percpu.h | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 8087ed6e12241..d868a88960123 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -368,33 +368,6 @@ PERCPU_CMPXCHG_OP(x,  , 64)
 #undef PERCPU_XCHG_OP
 #undef PERCPU_CMPXCHG_OP
 
-/*
- * It would be nice to avoid the conditional call into the scheduler when
- * re-enabling preemption for preemptible kernels, but doing that in a way
- * which builds inside a module would mean messing directly with the preempt
- * count. If you do this, peterz and tglx will hunt you down.
- *
- * Not to mention it'll break the actual preemption model for missing a
- * preemption point when TIF_NEED_RESCHED gets set while preemption is
- * disabled.
- */
-
-#define _pcp_protect(op, pcp, ...)					\
-({									\
-	preempt_disable_notrace();					\
-	op(raw_cpu_ptr(&(pcp)), __VA_ARGS__);				\
-	preempt_enable_notrace();					\
-})
-
-#define _pcp_protect_return(op, pcp, args...)				\
-({									\
-	typeof(pcp) __retval;						\
-	preempt_disable_notrace();					\
-	__retval = (typeof(pcp))op(raw_cpu_ptr(&(pcp)), ##args);	\
-	preempt_enable_notrace();					\
-	__retval;							\
-})
-
 #define _pcp_wrap(op, pcp, ...)						\
 ({									\
 	op(&(pcp), __VA_ARGS__);					\
-- 
2.30.2

