Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B05A199EAD
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 11:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519964; cv=none; b=HaXgGCM5N58t3xYgM15sGcOBnj+i570jCYi9QXpkLPWJsFGNuqANMWpJGM4jX8MD8lir8OkOgltKn1VyITysxLQV/MPb67n6bxh0o33YSiNxGYcnk56eKDtg2BMqcirQ9nyIfhS5WLBVA/femmqpN0jDCN5Yx+kb0FX18cqo6VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519964; c=relaxed/simple;
	bh=6JMzM0p05IV/3OLS+Wyo11qKjrgn4NmAw1sGEMIPu4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKdCEym1nBbMs7DfS82tasSKAUiEymz48NGE/GJyVeRI2F0f0Ug+/WwDgnl/XvhBh4K7czzcX2CguKudMF7bnLg+Gw25+qc75J4NvBjGpcXRjkJo+VTmcmVQMr3b+aRF2T4QhAFDos0THeafCLrm9qbKrkysfoPuV9V0uykrDyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LG7ah1Va; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LG7ah1Va"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2671F00A3D;
	Fri,  4 Sep 2026 11:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788519962;
	bh=R45r/hMefZ9xLehOtyseiqZFMw0kaIo8VXlPhenQCIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LG7ah1Va+kLLQe4pClEUmQEnu9IhHu6AJawUQlfpU8xup79V7VBE0aynJzYBtOYgw
	 3BFH6kWCGV71BceMsUa2p4SeSkWP6L6+qhuiD5m201AiWrRRdWb2xIztnAe1bWQrG+
	 4hw26RQecoVOS7BU4l8S5Z9aIm30U0N3Mii87PWUry9ERgRa/r37V2OmBMnwr3bsPc
	 AcdcZQnoirqLBSu5wm4szE3brj2Zz8eaAMJoopS1ttQlbnW1CowQU3ZX1Tb0WxBl+U
	 NNCvI4zDQ5oiG9aMe7zivorZKrzr4DCIAGx7I4o/ncGtE6X8yzMssgAYnXX60O2HU1
	 LR6qiBcO7Up/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yao Zi <me@ziyao.cc>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] x86/locking: Use sfence for wmb() if SSE is available
Date: Fri,  4 Sep 2026 07:06:00 -0400
Message-ID: <20260904110600.2983335-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090323-calculate-stoneware-3481@gregkh>
References: <2026090323-calculate-stoneware-3481@gregkh>
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
index dab2db15a8c47..298348fe7be48 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -17,7 +17,7 @@
 #define rmb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)", "lfence", \
 				       X86_FEATURE_XMM2) ::: "memory", "cc")
 #define wmb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)", "sfence", \
-				       X86_FEATURE_XMM2) ::: "memory", "cc")
+				       X86_FEATURE_XMM) ::: "memory", "cc")
 #else
 #define mb() 	asm volatile("mfence":::"memory")
 #define rmb()	asm volatile("lfence":::"memory")
-- 
2.53.0

