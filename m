Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A53483BC6
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 17:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863156; cv=none; b=l6ZYEDmoKyLy6jFYKtmh3AFgz0aGvHANLzsMrtZw7h9njwnKOskyrOnMsjj9o6lLIe7w/wHSd/QYVFqI7kClxzSSvhAti4zp1zNChfVMXfCm+2Mt77O5SoK7qyuG6o5PCecB9QK/l4UdkcYt2d9uNvPYNSSb2BZ+b06yV5x9UIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863156; c=relaxed/simple;
	bh=qCT1jKAmGgSsjUkSBt87PeNx7fLkJ1u97Bx7EBNo5ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jTxRqpFZIF3lXQt59qfUGpmKScGQIXOC39VwYgPs2U0XwFNFde4lnDmVT/WjeNsPN1eWlta0tamPFAcIN4C9r6SjGq54zszozbz3qG9suPTzkMD4c1KcsXDic4ogr66KNSxA7+pN/xITBoRjCZ7954LyuYA7DhPU+8cQsxLhr5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=AldYjHIZ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="AldYjHIZ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62B3E1684;
	Tue,  4 Aug 2026 10:05:40 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 701EA3F632;
	Tue,  4 Aug 2026 10:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785863144; bh=qCT1jKAmGgSsjUkSBt87PeNx7fLkJ1u97Bx7EBNo5ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AldYjHIZREaNdW3I478USfBmmV6zy7HwhSWsviRWmDn4FUWgSPnKHO6CUnQTWy7Mu
	 2T4oCUzs+ttK9zwjJ/JKyizO+/v+0IMx3JFTpYDFwtGZIavG1OnLSrVareartAH2a3
	 7hO2gj1N/mdbCMur3aEwBjP+AwWC0v4ZuQpYP4pI=
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
Subject: [PATCH v2 07/20] arm64: ptrace: Always inline pt_regs_[read,write}_reg()
Date: Tue,  4 Aug 2026 18:04:50 +0100
Message-Id: <20260804170503.3513916-8-mark.rutland@arm.com>
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

In subsequent patches we'll want to use pt_regs_read_reg() and
pt_regs_write_reg() in noinstr code.

To ensure noinstr safety, both functions must be inlined into their
caller. As both functions are marked as 'inline' rather than
'__always_inline', that's not strictly guaranteed, and the compiler is
permitted to generate out-of-line copies.

Mark both functions as '__always_inline' to ensure this.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/include/asm/ptrace.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 39582511ad72f..a1aa668aad50e 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -268,7 +268,8 @@ static inline u64 regs_get_register(struct pt_regs *regs, unsigned int offset)
  * Read a register given an architectural register index r.
  * This handles the common case where 31 means XZR, not SP.
  */
-static inline unsigned long pt_regs_read_reg(const struct pt_regs *regs, int r)
+static __always_inline unsigned long
+pt_regs_read_reg(const struct pt_regs *regs, int r)
 {
 	return (r == 31) ? 0 : regs->regs[r];
 }
@@ -277,8 +278,8 @@ static inline unsigned long pt_regs_read_reg(const struct pt_regs *regs, int r)
  * Write a register given an architectural register index r.
  * This handles the common case where 31 means XZR, not SP.
  */
-static inline void pt_regs_write_reg(struct pt_regs *regs, int r,
-				     unsigned long val)
+static __always_inline void
+pt_regs_write_reg(struct pt_regs *regs, int r, unsigned long val)
 {
 	if (r != 31)
 		regs->regs[r] = val;
-- 
2.30.2

