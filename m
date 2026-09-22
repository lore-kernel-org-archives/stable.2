Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A88455D888
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092422; cv=none; b=RtPNuAYx+NC5Ru7uyscpZwGVUqfoILI2pT3xaobvT3i+VqbKFHGVm6Ol5TOyFqdATldwwTH9wc+HzURlHLFbH/qLZGKzcuq0uoi1heSMwDq61gnbfTXmmxlmnUE3OlV+DEQs4jgTOrBOXdZXeBxb6Nb8n4zkRgXzpP4u+Q/UcxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092422; c=relaxed/simple;
	bh=SMTYFc63MUMWlmi89MPBVXVfscMor8n3qqpOviA7LAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdrxFVTN5V1jianY9wWBVvhjSaJ8D/3O+PGzUw7NF7Nxm4oEIoZc0IFR7QpjKis9y08vBjOnkVoXypVAyKohZbXqK5Ja3o8IqmM174zCqWwfQZlW6freO5TjY1pjk1+4wIIZe+KzlkVDw0GStmeheQ4HG4C99/VNPBknCDhPNrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFbLADkQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFbLADkQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25C11F00899;
	Tue, 22 Sep 2026 15:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790092413;
	bh=GyCm7ikamgXegEIhM2qmztEoz7QCAjNhcy2rkhsoQNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TFbLADkQGrxbWTWe0/75v9GmpYAxH+8f2kzFyTCEMd0VXaD1v4imjX2YxU00uOLpY
	 XnjjHpwA0ioHXGnNZizaWCLjc8V5bbHKGboU5iOURvGuVm4Ktm5o0lUZiqqjK6+OzX
	 0Wjmio7pRwTNg3wPjG17u77HBP4XSlJQoP7GQswrh9Y4M/ReU14j8hTkHUO/AnFRWy
	 mG6UN9cKEmu77yl3UMu314W5l9f48Dygj9RoFgTUBt6Xlj5xZYsvJx9GUF1aw3UyCW
	 ZibE7fHml1eDDcuFe9TEhTcmt8cHaBfbC/bwJ+QS/P7V3PCzm4svfcajuHbushbVmZ
	 nJHH4DllOhA/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	James Morse <james.morse@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Will Deacon <will@kernel.org>,
	Yang Shi <yang@os.amperecomputing.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] arm64: percpu: Fix LSE operations on {8,16}-bit types
Date: Tue, 22 Sep 2026 11:53:29 -0400
Message-ID: <20260922155329.2918313-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922155329.2918313-1-sashal@kernel.org>
References: <2026092226-habitat-wipe-a94c@gregkh>
 <20260922155329.2918313-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 8cf2093f5372952a9ebc805c418d45df7112cd14 ]

The assembly for __percpu_##name##_case_##sz() and
__percpu_##name##_return_case_##sz() doesn't use the 'sfx' macro
argument to form the LSE instruction. Without 'sfx', a W register
argument will imply a 32-bit memory location, and consequently
{8,16}-bit ops will erroneously read and write 32 bits of memory when
the LSE instruction is used.

Fix this by appending 'sfx' to 'op_lse' to LSE instruction. It is not
necessary (and not valid) to append 'sfx' to 'op_llsc', as 'op_llsc' is
a register-register operation which does not access memory (and does not
take a size suffix).

Fixes: 959bf2fd03b5 ("arm64: percpu: Rewrite per-cpu ops to allow use of LSE atomics")
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
Cc: stable@vger.kernel.org
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/percpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 98b083ef9ce17..a3c891d79e922 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -76,7 +76,7 @@ __percpu_##name##_case_##sz(void *ptr, unsigned long val)		\
 	"	stxr" #sfx "\t%w[loop], %" #w "[tmp], %[ptr]\n"		\
 	"	cbnz	%w[loop], 1b",					\
 	/* LSE atomics */						\
-		#op_lse "\t%" #w "[val], %" #w "[tmp], %[ptr]\n"	\
+		#op_lse #sfx "\t%" #w "[val], %" #w "[tmp], %[ptr]\n"	\
 		__nops(3))						\
 	: [loop] "=&r" (loop), [tmp] "=&r" (tmp),			\
 	  [ptr] "+Q"(*(u##sz *)ptr)					\
@@ -97,7 +97,7 @@ __percpu_##name##_return_case_##sz(void *ptr, unsigned long val)	\
 	"	stxr" #sfx "\t%w[loop], %" #w "[ret], %[ptr]\n"		\
 	"	cbnz	%w[loop], 1b",					\
 	/* LSE atomics */						\
-		#op_lse "\t%" #w "[val], %" #w "[ret], %[ptr]\n"	\
+		#op_lse #sfx "\t%" #w "[val], %" #w "[ret], %[ptr]\n"	\
 		#op_llsc "\t%" #w "[ret], %" #w "[ret], %" #w "[val]\n"	\
 		__nops(2))						\
 	: [loop] "=&r" (loop), [ret] "=&r" (ret),			\
-- 
2.53.0

