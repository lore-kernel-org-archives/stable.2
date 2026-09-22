Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB3155C1D5
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091127; cv=none; b=aI+6sPaCSmEdvQh7vMm3sFcpN7S25RDpa6MNWky+fH4rFk5+72gCEY+fIQXGzInMe0pwQr0pUPhbkkznxSVy4VTcRBVmpPfs45qKt7N8LrtYFbgxr+KmyTxGuL4hFwCWx9Zl7dhsxe9s+5blJhIhnRB3DPzXwfizALDcXPkPGw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091127; c=relaxed/simple;
	bh=zUk812i3RX1SnYfAogigJkC4oxIEX8B/elESkAPS/2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4FTyJO0m0iLsqRJ8BQ0iAoNNh1f3jiA587kKNV+7/4X9hxDDsChF5uSzl0TjbKsuMK8NakBNNA5rWlHd9kQPyUprCLM55AllnrUJ/EsWUVr6bSoqUTqKtl+W+hFZYVvEW6lQo57kl0A3IOTOieAEPoCPKqbvi9BWKrGwfnC9wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+Ve6DcD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+Ve6DcD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A801F000FF;
	Tue, 22 Sep 2026 15:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790091126;
	bh=E4Hf8FYDhMQfObsIum5mXwnQPAroQlmlTeISr/+NdV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K+Ve6DcDxZseEfQR7T00B015CvPE+yKjVg2GZJWdaD+Q8JX6BWFlblNqt1dNSkF9+
	 T8tpYOq+HSLYR1BmCTyZNNHeEcN6rghB/w4aOdAcfnBqy/zrW+GD0/jcgriv0Uxs4/
	 3jlBs4VKLYoNeuV6NVDJemOkZrAmARwMh7f2Mj3mE6EPFSvkuJ6UbwTaNT10UIHxIj
	 si/fkt+/uG0vzEk9DWAAYIdUusx6ZjvZ46UcdLUZy92XJkZIgVxzfKdaoAlPg4kjm6
	 hQpQd877jsciGrkhFoKX/6CcsCpzhlzYcTr7q/sxSr2uK1qGEcT3m/FxEbdWic2jPG
	 2AEt7B8ZimnKA==
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
Subject: [PATCH 6.6.y 2/2] arm64: percpu: Fix LSE operations on {8,16}-bit types
Date: Tue, 22 Sep 2026 11:32:02 -0400
Message-ID: <20260922153202.2820773-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922153202.2820773-1-sashal@kernel.org>
References: <2026092223-oxford-subside-0146@gregkh>
 <20260922153202.2820773-1-sashal@kernel.org>
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
index b57b2bb009677..cb83d6776c6f5 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -77,7 +77,7 @@ __percpu_##name##_case_##sz(void *ptr, unsigned long val)		\
 	"	stxr" #sfx "\t%w[loop], %" #w "[tmp], %[ptr]\n"		\
 	"	cbnz	%w[loop], 1b",					\
 	/* LSE atomics */						\
-		#op_lse "\t%" #w "[val], %" #w "[tmp], %[ptr]\n"	\
+		#op_lse #sfx "\t%" #w "[val], %" #w "[tmp], %[ptr]\n"	\
 		__nops(3))						\
 	: [loop] "=&r" (loop), [tmp] "=&r" (tmp),			\
 	  [ptr] "+Q"(*(u##sz *)ptr)					\
@@ -98,7 +98,7 @@ __percpu_##name##_return_case_##sz(void *ptr, unsigned long val)	\
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

