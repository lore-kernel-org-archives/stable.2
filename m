Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6952952FE4E
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880853; cv=none; b=Se05xiqHvLNvXq27gjFuQAuQeR/iU/DKec3wCf2vivtRCBWhXAOXVInk0oq3CxL5TJvRoJhOEp8lYmAVATi+G2xw+oFaAlDJtPM3Z56LG+ho7VYKvU98NAINCMf6VJmHRKWnUD0IETmwZYoR8FK3bN2cb/BLze3ZBTtKBq18maM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880853; c=relaxed/simple;
	bh=nBixZw3/1BkQyzToGEomClwqPJ2mncw8+26Z2hHqfxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j8kT5+A4wxRrADXbBjNGjII/oXiRtCRMwvWmkkTEI0SWjTCCgQYvZ9nkc331jGczPzcQXSyQ23m72wuzEyzo6Sn2OW0boJIwsrTuCG0Xkx3QyP+XxBzpf4VMcs6Lj9eXbSG+OSL0Bz0S3z0F0xRjwkxFX2TMYshMpQyBBK4h6S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WZQctxI6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WZQctxI6"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3933D1C01;
	Tue,  8 Sep 2026 08:20:34 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 25B5E3F7B4;
	Tue,  8 Sep 2026 08:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788880837; bh=nBixZw3/1BkQyzToGEomClwqPJ2mncw8+26Z2hHqfxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WZQctxI6borBrSRp66atEYh17JJqVlpIDG9uAcJd74bbKecAvUMHhxEZ4jF8jx0TY
	 71gS7ZdmpNaqzvzM3pz/6qoFe6hE/kw0CkOlrnM6rW8c9zYf5Hmk8vIjE2KwcpUDMM
	 MVl6XRceGotKrIs8AXKDk3L+G1NqnzpaOaP+kBa0=
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
	usama.anjum@arm.com,
	vladimir.murzin@arm.com,
	will@kernel.org,
	yang@os.amperecomputing.com
Subject: [PATCH v4 08/21] arm64: ptrace: Always inline pt_regs_[read,write}_reg()
Date: Tue,  8 Sep 2026 16:17:28 +0100
Message-Id: <20260908151741.394589-9-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260908151741.394589-1-mark.rutland@arm.com>
References: <20260908151741.394589-1-mark.rutland@arm.com>
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

