Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA39A36C0CD
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538760; cv=none; b=nxiv9zLPE1NNtAgnfhYLWdL2rG/URcrl30eWZ8mFBjynNXv3u34UmDiFH1+Exw4P+cuDhDcn6raFf9GYBdxo1yyEr0BrvR/SZodZ2qQmcZnPk+52SJiSLRcA75GXiBedJg4WRpjKtRExO6JZp4HpukkEB5iUxbE2VphvcDLrJpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538760; c=relaxed/simple;
	bh=i6uO/jj8wEknXLiLBTGSQRd6LqWzqYzc+btd1yT327U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FeXpUx+D2LsiRFUGDNI0Bwa2XSGUDZVjSP/588rMXh6zBPMbiYgVyoJOpU2bYLjVUDJHoaMS4GvlS/dmGW0UoiqMkp+p91LoJqbrCdBAuyKk0BkDJoBe/VuoPCNFud9NwZ0lVr1Dg/0vjtPgsofK4IT3fqM0dvApmK8k39f+U5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=owuUoS8D; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="owuUoS8D"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B737F169C;
	Fri,  4 Sep 2026 09:19:13 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 70BD23F673;
	Fri,  4 Sep 2026 09:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788538757; bh=i6uO/jj8wEknXLiLBTGSQRd6LqWzqYzc+btd1yT327U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=owuUoS8DqJFW5eEiv8+r4W2JWCoO4ejeLm7OUu5P72hb/bwUQEJvsFHkgxd810BT0
	 JEZMVMZvlIx1wxm+QeOqlP67xk/8p07UYY6HljTcb9J3bVSZ7AIOSo/dN06buHxxSB
	 53owcEslbiK/aKejwzrTo7tUxV5D8U6dtM4C+HUc=
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: ada.coupriediaz@arm.com,
	ardb@kernel.org,
	catalin.marinas@arm.com,
	cl@gentwo.org,
	david.laight.linux@gmail.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	maz@kernel.org,
	peterz@infradead.org,
	ruanjinjie@huawei.com,
	stable@vger.kernel.org,
	usama.anjum@arm.com,
	vladimir.murzin@arm.com,
	will@kernel.org,
	yang@os.amperecomputing.com
Subject: [PATCH v3 21/21] arm64: percpu: Remove _pcp_protect*() wrappers
Date: Fri,  4 Sep 2026 17:17:58 +0100
Message-Id: <20260904161758.376504-22-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260904161758.376504-1-mark.rutland@arm.com>
References: <20260904161758.376504-1-mark.rutland@arm.com>
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
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
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
index 5cd98e20e825d..6ec6e212932d3 100644
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

