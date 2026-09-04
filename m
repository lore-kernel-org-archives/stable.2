Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BB64CA764
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538734; cv=none; b=PGNwlM3WBAm4z+zjfOnqKnHvkjdATdeDnIIJQ7iaxgXO53xl3CNsEE4IWVL7sbZveiNR59FHeFgPDyo4M0NtA14CbSlsW5ew4DwWF+pSQoqRfUhycfUuP1Sd4bthhRYvq+eoSSA/d814/jHChsMlXyaCd+0fafA+JBl1IDKTZ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538734; c=relaxed/simple;
	bh=nBixZw3/1BkQyzToGEomClwqPJ2mncw8+26Z2hHqfxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OAekyQ22tQZpTQ9MKjjj9eHUkuRStXK+Q7u3JgP8mNL5KB3e2dVr5WQCHuzW3VpdCpGuJi+oVtdIOd1rfAmZsp+FfKHf8ziT0IDzrbBrEkdd43IpPhifusWRPDDbQxqpN+1Gkm4UHawbMEMgFWzschDzpErn1R2mfMEV6DUlb5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SzGq2iA5; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SzGq2iA5"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C4EB1BCA;
	Fri,  4 Sep 2026 09:18:43 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 390853F8D6;
	Fri,  4 Sep 2026 09:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788538727; bh=nBixZw3/1BkQyzToGEomClwqPJ2mncw8+26Z2hHqfxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SzGq2iA5rQ+zWCWm0tmiIlgMADjCbI/9IFmR9Zpb7wjp8x2zPNPNWRac6iHQxNei/
	 JbDZ2gO1aGGr6HZukCxwyhgcOw6ZILeA0qpHG9vWnNE6/UyrFVUQW+dnQiDAF60us9
	 lAYrvwXb7bwVUF74uYYa297Rdqt/viyo8ckDLgpw=
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
Subject: [PATCH v3 08/21] arm64: ptrace: Always inline pt_regs_[read,write}_reg()
Date: Fri,  4 Sep 2026 17:17:45 +0100
Message-Id: <20260904161758.376504-9-mark.rutland@arm.com>
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
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
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
index f7dc5fb9427d6..f635c3453a858 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -266,7 +266,8 @@ static inline u64 regs_get_register(struct pt_regs *regs, unsigned int offset)
  * Read a register given an architectural register index r.
  * This handles the common case where 31 means XZR, not SP.
  */
-static inline unsigned long pt_regs_read_reg(const struct pt_regs *regs, int r)
+static __always_inline unsigned long
+pt_regs_read_reg(const struct pt_regs *regs, int r)
 {
 	return (r == 31) ? 0 : regs->regs[r];
 }
@@ -275,8 +276,8 @@ static inline unsigned long pt_regs_read_reg(const struct pt_regs *regs, int r)
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

