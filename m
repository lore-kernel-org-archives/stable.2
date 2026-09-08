Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6711FCFEF
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880834; cv=none; b=KwIVD+jz0sGKzWG+bWQtfc1JtV/91AeIFKRTiCBzwXSy9J5HPdq+NlmnTmKdHkVrAhg8inV4zmRk17o2VtRRC2tiUBB6A2V1fn04ZG0NFuQ7bYdwpet36eR8rIlMfShiC1CQznitpS1AH56/+sdZ+Ieyqug2ja7XmnkN1AF/Qn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880834; c=relaxed/simple;
	bh=GcKZFnQgJw6u5Wdp85aJgg7AOSBlCknf/ylfv6Qx5pc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PVa27VjHqrlrR0vrscQoIcdOlwesHQD/PcGtrIeh2ydJqOHh24hsqeac+CBJy2NH3DiZruyfoA2K+5VulT218Wd9GmitGURa+0IajJ7/HeZmKMdHZhKcZAdmoRZaUH4pEuGTfnR/oGJqle6FtqrA6UV9VMSaj3sahxk4JCCxraI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DkBJ3aVl; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DkBJ3aVl"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B5CA165C;
	Tue,  8 Sep 2026 08:20:21 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EB0243F7B4;
	Tue,  8 Sep 2026 08:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788880824; bh=GcKZFnQgJw6u5Wdp85aJgg7AOSBlCknf/ylfv6Qx5pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DkBJ3aVl2qByDZzL9lu5QLAxwLt4uFwIMdTL2pelH5xKTSiSX9ityLueZNHvR+QM5
	 SjJoHKyeW9HI9z85zQ/IELLjZ+Cn8vvCYRb0lIzayR/NxERsz6pvpquHB7jdVsFlVJ
	 wljH3y12Vv/wR6uOmVSaIauVqLR/BPEKq8xD7DD4=
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
Subject: [PATCH v4 07/21] arm64: preempt: Treat should_resched() as unlikely
Date: Tue,  8 Sep 2026 16:17:27 +0100
Message-Id: <20260908151741.394589-8-mark.rutland@arm.com>
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

The arm64 implementation of should_resched() doesn't treat the need to
resched as unlikely, while all other implementations do, e.g.

* asm-generic since:
  bdb43806589096ac ("sched: Extract the basic add/sub preempt_count modifiers")

* x86 since:
  c2daa3bed53a8117 ("sched, x86: Provide a per-cpu preempt_count implementation")

* s390 since:
  c360192bf4a8dc72 ("s390/preempt: move preempt_count to the lowcore")

Do the same for arm64.

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
 arch/arm64/include/asm/preempt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index 92ae2eb95a738..0a99ef9b59609 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -78,7 +78,7 @@ static inline int __preempt_count_sub_return(int val)
 static inline bool should_resched(int preempt_offset)
 {
 	u64 pc = READ_ONCE(current_thread_info()->preempt_count);
-	return pc == preempt_offset;
+	return unlikely(pc == preempt_offset);
 }
 
 static inline bool __preempt_count_dec_and_test(void)
-- 
2.30.2

