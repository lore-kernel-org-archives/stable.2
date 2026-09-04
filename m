Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5784437F75D
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 02:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490538; cv=none; b=QqENX0sKT9hPjQLS6Slhc63V7i7qa43k9yApvY0d01EzJYVJizH2/cBmAqmNCVDua0zhK46nqBaPf2Qkh8t8rI94tYMwuI+J3lnG/sEAF+KPY5D2fFK8vsqgJC7lmW1VDoip4DQlGF43Vo4FzcAtvSbLb6z1lCkWNS0mZd1XAp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490538; c=relaxed/simple;
	bh=/ZxrFDswxaIlb8Z4iuFl3T9vKvwS0ZpEW5hpW93XbSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnkF4KM23WAl7qPS5jtWYAwMRNkQP15ijsisGbS25qQwuADrYD9vwgYskjNkGgf2PMZ8+lx5tkJzNQK/ejhLGPJdBnSQT9WA3Tsd7Hi/p22TfFZ8ok/pVykomrZluXM/g5u5sX2ecuxmNNSKZt/tt9DyGKdW4xsa8hdB+jIsOkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXu8t9Vk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXu8t9Vk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67EB1F00A3E;
	Fri,  4 Sep 2026 02:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788490537;
	bh=yBh/wo+EYg8x3+3j5JFNr67PZVzKACB4n4wvvdjMaMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cXu8t9VkKtO1nREfaFQkfsQX13lfSg7RSXMws36R6//uSMsIFTkCtpXnijfMFHFqd
	 hnaGjs0zejz+IgKOp3v0Cp/lcw+AOnpATwOxRjhaP3hCEFDC5QufXofI5UfKqjz8Gz
	 h22YnGqtTN5vkzIUOhczbs0pjEUf13+GfZGBTAv8ob8qPQ4bhE0qJx/BCgf3e8+hN5
	 q/50Fbp0OUBXALZrRdfcKN4lc0T9oLxm+FUyaXr6M+eIh3QGK/M2UO29I94PX/KM2S
	 b5qSjgRFqJsMU/UPVHaEAEuJWlwMxibLikk5pm+1XonP6IOEQ6Fxr449v32CSnwJnt
	 Ju0RoxoPcUZmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yao Zi <me@ziyao.cc>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] x86/locking: Use sfence for wmb() if SSE is available
Date: Thu,  3 Sep 2026 22:55:34 -0400
Message-ID: <20260904025534.2271771-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904025534.2271771-1-sashal@kernel.org>
References: <2026090322-unsaid-demote-cc78@gregkh>
 <20260904025534.2271771-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/barrier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index db70832232d4a..3e78bb76153ce 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -17,7 +17,7 @@
 #define rmb() asm volatile(ALTERNATIVE("lock addl $0,-4(%%esp)", "lfence", \
 				       X86_FEATURE_XMM2) ::: "memory", "cc")
 #define wmb() asm volatile(ALTERNATIVE("lock addl $0,-4(%%esp)", "sfence", \
-				       X86_FEATURE_XMM2) ::: "memory", "cc")
+				       X86_FEATURE_XMM) ::: "memory", "cc")
 #else
 #define __mb()	asm volatile("mfence":::"memory")
 #define __rmb()	asm volatile("lfence":::"memory")
-- 
2.53.0

