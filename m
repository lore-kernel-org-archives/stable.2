Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC7344A40F
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788517818; cv=none; b=M6qEGh7Xt/4WKtC2Cx9eo1srxozKGa/XCldaZEDZleNrRr/gkzV18ePy5/YNTuPtmiXse7La0e1UTy9V9FdkJRn2rTh8tZ25ZS4pzxThwk/qsF5ZnBI8810Ngow2yywombkALUFCGFE10R1PBgJxIqhfc7vvoGYFZKBpgn333Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788517818; c=relaxed/simple;
	bh=pcxHM0P/eM6nNVHPYH+UxvmRNRq7bbW6Vl4qst+UdU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cP6YjAIq+aYri6BvqTmqc57gKRNisx1eJNpNgHTm4esEEEFnN29+9ieLvs1HxfW3ZPbcLDdvPMP3po9DwI8D7TgQ67hGQAa5RDtnVbow6o65dSWkFsVNfFQotmUIOon12l/ZvZEDXJ4jJAf4KWhuHEfKgBfqHTYu4XYdDj04mr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5irC+Wb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5irC+Wb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2FB1F00A3F;
	Fri,  4 Sep 2026 10:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788517817;
	bh=cTQ5LaaO4UfRX4KsdCusIcRVlKytUaX9wu4EdX8Jjhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C5irC+WbWQfNBAC03ju18GBvYqbDaqlU1qg0xfcWGDbyR6ItEq0uAkUFwwv3yyVe6
	 2QmiAibUiC+k5O3pNbqhaH3IgMfk8UrDWDcRYzzyz7vzXYoct2OZ6v4XtYFi+gb+i4
	 TpEC/ORzmt1ztb80/rJgtUSFpQyZ3NEAdEiCHCFWrMSn5AoXZTLAofrrQlTSZeprQ0
	 2BAF5jJ6fn2ZPBi2QcQsDnk248PHX0fXRWD0VYggAwtkU88nxHsJaEmyqfQsaPtB76
	 M7nNqwXIKApr2uSsSxrzoNTO5m1nDyuF3Bu2W9o+V4exy9DGwkG8ZddR0wXF31LhL6
	 coLVVWTO9M1Cg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yao Zi <me@ziyao.cc>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] x86/locking: Use sfence for wmb() if SSE is available
Date: Fri,  4 Sep 2026 06:30:15 -0400
Message-ID: <20260904103015.2500965-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090322-entrap-donation-7004@gregkh>
References: <2026090322-entrap-donation-7004@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yao Zi <me@ziyao.cc>

[ Upstream commit d824ed1307680dd482f607b0e707c575f70668c4 ]

When adding cc clobber to wmb()'s definition, the alternative()
condition to use sfence was incorrectly raised from X86_FEATURE_XMM to
X86_FEATURE_XMM2.

Restore the correct constraint for potential better performance on
machines without SSE2.

Fixes: bd922477d935 ("locking/x86: Add cc clobber for ADDL")
Signed-off-by: Yao Zi <me@ziyao.cc>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260801182953.15069-1-me@ziyao.cc
[ preserved the Linux 6.6 "lock; addl" syntax instead of upstream "lock addl" ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/barrier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index d0795b5fab46a..fc85b3df0f0fb 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -17,7 +17,7 @@
 #define rmb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)", "lfence", \
 				       X86_FEATURE_XMM2) ::: "memory", "cc")
 #define wmb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)", "sfence", \
-				       X86_FEATURE_XMM2) ::: "memory", "cc")
+				       X86_FEATURE_XMM) ::: "memory", "cc")
 #else
 #define __mb()	asm volatile("mfence":::"memory")
 #define __rmb()	asm volatile("lfence":::"memory")
-- 
2.53.0

