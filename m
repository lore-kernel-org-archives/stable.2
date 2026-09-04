Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1143471255
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 10:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518499; cv=none; b=rXq9z3+sakjrdu0grQdgiin0ejagU6dhVJRNDSEE8LrBkRsIJyLHQMJqsbkgA6wo3//h4Hus+LJDcjgnZ7UWMlQVKD9sR+kPGNdXxEc4HEXQLnggW4obVb8k5xN/Or6iiJAJHpNtfwQDxjquFhyNLx+RKvx1c6hkVN/+9VKqnJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518499; c=relaxed/simple;
	bh=z2cdki49WMQ0SNCAxZxp2iiX8Ta+0m/FDf9k25zbGW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTsMlv/ZxLn7maJdqUClRnTW88D8xlxRPEkjFLqWQJklh/MX+MClNFdg4v1mpJwSBWq/VzNm30qgDtwmylJQz0oxy+ingi0t0eykvhEqK8Q7aPHmsmGeXptx3DCDEaLkYMXiUu9SAQU5b4oanEJCbDAwqfDxUrgfGXjL3fEGEhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvE21pH4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvE21pH4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127B81F00A3D;
	Fri,  4 Sep 2026 10:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788518497;
	bh=0BuA1EGHNnyBw46ZRsZDy+y934W5pgkfS6q/nnkrZFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gvE21pH4BvDf6YkXXYUTDDF5p3EdIbayi3H8ci89kV8cBLITyvlxjido4JkwoDFaQ
	 0FeCmYZeD8O0gydDo5nJtcNOXOx01/G67e66yhry0dwZLaXclR1Q1OyuV8amQe/Ln6
	 nPOppxDc69HyR4X5h/EiFSIjh91vNGLh1USEQC5YbM7Pwhmm22SkBIaiP/2p7vgs2o
	 z93bW7A180oahXySOJV+8kIOOwJ0KHXCKpIKnEcCbjrDNRV/3TzThEgGKWaIYZ/5I4
	 y3ef2MTtHy7QN3yqJXy4TmkPXKl1WqcmBv+lzLion/NDhRQP9udlBW2tlxri5+4TJr
	 KeF0mf5DJ+3oA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yao Zi <me@ziyao.cc>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] x86/locking: Use sfence for wmb() if SSE is available
Date: Fri,  4 Sep 2026 06:41:35 -0400
Message-ID: <20260904104135.2545820-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090323-cold-protector-374f@gregkh>
References: <2026090323-cold-protector-374f@gregkh>
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
index 0216f63a366b5..b744fee19797d 100644
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

