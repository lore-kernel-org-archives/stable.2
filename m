Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1766486B82
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863167; cv=none; b=Ap/DzG49aPS8yb8BLOYKBpua4i0HAfg/jsK05f/CFdaYlzl9fWc0SGSA9x15wh9S8IUYwg0kSNRvFC483xNJt1zLd3EAZZai5Sp79viIa1ZOYMafZh2ywFtfSzo4USjj3Czs1QxMc8mNwHj1m18lS3c8HcSY0/6FxqudlGCglnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863167; c=relaxed/simple;
	bh=YzD7+HPBTAQSY9PfPJMGymfBg5La+P63n6Hj+NlyMeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m/dQlN91k0jjd0WxqmarPbIIDI4ztRmS5XY7Ap48znQmw7LGuOp+DQBhiRkKzvrvDBl6dvVkJX0j54eiygRtDCzT+PAvQVuPEgR46YQvJlBhNmJZbXMIiLvD+mWQSNLMdhBtMFWaLJ5oBOv3wE5B9Ewcl7ZDZO5wqO1qu6KGdgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Rrgk9AnV; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Rrgk9AnV"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C76F01684;
	Tue,  4 Aug 2026 10:05:53 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8F9323F632;
	Tue,  4 Aug 2026 10:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785863157; bh=YzD7+HPBTAQSY9PfPJMGymfBg5La+P63n6Hj+NlyMeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rrgk9AnV7LxAb5EF/5/NRLyqnW1I9w7Xw25iV3FTEWX9st5hae8leuGEi29TgK4Su
	 Pl3yhDCXhn+c3jtSCzn8LyhmBlaMEjvhVESM/BhMns3pvqPL3PA/THo25wT+s94fgA
	 g9qyllyxHJ/G2NvHss2DGH+A1J1yHNW86WUVHDlw=
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
Subject: [PATCH v2 10/20] arm64: gpr-num: add __GPR_NUM() helper
Date: Tue,  4 Aug 2026 18:04:53 +0100
Message-Id: <20260804170503.3513916-11-mark.rutland@arm.com>
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

The gpr-num infrastructure requires users to concatenate the register
name with a long prefix in order to get a symbol that evaluates to a
compile-time constant. Doing this manually is error-prone and painful to
read.

Add a new __GPR_NUM() helper which wraps the concatenation.

For the moment I've left existing open-coded concatenation as-is. In
particular, the DEFINE_MRS_S() and DEFINE_MSR_S() macros have awkward
stringification requirements and would require invasive changes that
outweigh the benefit. I have plans to rework those in the near future to
remove the need to use gpr-num values.

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
 arch/arm64/include/asm/gpr-num.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/gpr-num.h b/arch/arm64/include/asm/gpr-num.h
index 240cd25d55c5a..30fb8a67b19f0 100644
--- a/arch/arm64/include/asm/gpr-num.h
+++ b/arch/arm64/include/asm/gpr-num.h
@@ -11,6 +11,8 @@
 	.equ	.L__gpr_num_xzr, 31
 	.equ	.L__gpr_num_wzr, 31
 
+#define __GPR_NUM(gpr)		(.L__gpr_num_##gpr)
+
 #else /* __ASSEMBLER__ */
 
 #define __DEFINE_ASM_GPR_NUMS					\
@@ -26,6 +28,8 @@
 "	wx\\n	.req	w\\n\n"										\
 "	.endr\n"
 
+#define __GPR_NUM(gpr)		"(.L__gpr_num_" gpr ")"
+
 #endif /* __ASSEMBLER__ */
 
 #endif /* __ASM_GPR_NUM_H */
-- 
2.30.2

