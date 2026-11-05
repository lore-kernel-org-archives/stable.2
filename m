Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895515;
	b=b4tULwmtnOMwj/c+2SsWO7Wy8OAdpwDXDkyTv6ZRTACDfuUsqSP0a91dX4Z2YS6JT0+/
	 g5UNvxHC72hgFwXa0ZrTQuevDH9kSSgNHGTueBrMSDtjt17lw8naNrEd62KzFY40XuRQd
	 V1S11dSf4/qY7w+pX7mZ6TNVzSbUX5fCHxNkRW4hsL1uOoEVREDdw3NgUf9SolaHMJWMo
	 H6QuTXY8eE+OyMRTh4RWO5TiH4qF0hrDERjEKmVtJ9WzVlIPKp7vyGQb4kGBgHmPoOD6T
	 hfL9LtzfuSwinyS4cn5FlqJACgbAfZ8sgs7IHSOsKF/4qMuHp5ECw7tjjs2UTToLV9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895515;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=0J8HAE6fhEZu8JqEpog8/ysJSaUFoTKmnmkh+IDODZI=;
	b=es6I+6Rtl1aypG6Nff9E8Q+L16FJDlGXwDsW1H3Hs00zutG7gKYezVDa4Tjv9JGLLIh/
	 xp0YPCBiufjw6eaeWdmlHk/WzkA4pU9A5u5XRaSaeYQ6mNtkkWTXklYpju+/O3qnfuSFZ
	 rdb745s/4FLIXCIL0RRJeU1Tsly43N3O/P52DV+LL1+gQNERa44I1TW2P9dZldyTPedDl
	 I04Wki4Zpzxf6Gf2SGkUP1JDjRinmmQpu0/XeeXF+M1Z230N02HWu8xlYNbE6EgLe+5nZ
	 eUo9AmtZPY2sCu42JbGi8wEBGTCe1bkfWuN/YYkoiZ7BvVFVQr2+ICpGIDMPFW4A9sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SL5DlQfk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEA3606D81D;
	Thu,  5 Nov 2026 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SL5DlQfk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC291F0093A;
	Thu,  5 Nov 2026 16:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793895514;
	bh=0J8HAE6fhEZu8JqEpog8/ysJSaUFoTKmnmkh+IDODZI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SL5DlQfkF75//kBq74BLhyYrGyh09AZ5vuIYMAZwnTRGKvWpQ8voQ3p09E9KAXH1D
	 jPGG/rMN+7C4Ea4xbqYw5IYi+eIc9BFWabg/AiNSlqGZn3xTJuL5gCvnUS+MJFqMLE
	 Lt+BPV+IcN2tXm16eNPnXjCGdLdN4Fed1j9nR83v6KlakfWQag40zDef521k5nbt4i
	 wHNg4DnP4x6KMcs77aj2xLNjZekoLW9rLE0wcCSABy7DEc2ZSWZOXEON94aMFxv8fx
	 qG4ZvF2rlfchbimy8dEsHm/2R4UjbJAJR82BT1j25AhrVFDwFmjJqQsRPCcpF6KAPv
	 WYlQPL0Ue7xFA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 05 Nov 2026 16:05:04 +0000
Subject: [PATCH 1/2] arm64: suspend: Save POR_EL0 over suspend
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-arm64-fix-sysreg-suspend-v1-1-f4d9a99fec46@kernel.org>
References: <20261105-arm64-fix-sysreg-suspend-v1-0-f4d9a99fec46@kernel.org>
In-Reply-To: <20261105-arm64-fix-sysreg-suspend-v1-0-f4d9a99fec46@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1760; i=broonie@kernel.org;
 h=from:subject:message-id; bh=SP+OuiZxr0S1Vipeh1xjDaZfgd3xHIYWyxtkizFr0qM=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLerAlNurjN/0bbvmVhASJ8G1wS3OdVLJrQr2V57M6cm
 23f7FfIdpSyMIhxMciKKbLEZXG/rC95vYbv4MI2mDmsTCBDGLg4BWAik0QZGT4+0Lj4vcpsV/iu
 tXoKdiIvXnJsq/PbZjzpUb+Uy8sPngsYGfZJsSQsNzWp+Zcz84PF9Inn/tm9+m8g0cS262PlHP8
 IXWYA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

POR_EL0 is a live EL0 register on systems with S1POE but it is not saved
and restored by cpu_do_suspend()/cpu_do_resume(). This means that the task
that initiated suspend can return to userspace with an UNKNOWN value. Fix
this by saving and restoring the value over suspend.

This increases the size of struct cpu_suspend_ctx.

Fixes: bf83dae90fbc ("arm64: enable the Permission Overlay Extension for EL0")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/include/asm/suspend.h | 2 +-
 arch/arm64/mm/proc.S             | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index a5abf0615594..eb9ce315f146 100644
--- a/arch/arm64/include/asm/suspend.h
+++ b/arch/arm64/include/asm/suspend.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_SUSPEND_H
 #define __ASM_SUSPEND_H
 
-#define NR_CTX_REGS 15
+#define NR_CTX_REGS 16
 #define NR_CALLEE_SAVED_REGS 12
 
 /*
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index b1516630904d..664ea9e3b9ad 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -117,6 +117,10 @@ alternative_else_nop_endif
 alternative_if ARM64_SME
 	mrs_s	x2, SYS_TPIDR2_EL0
 	str	x2, [x0, #112]
+alternative_else_nop_endif
+alternative_if ARM64_HAS_S1POE
+	mrs	x2, REG_POR_EL0
+	str	x2, [x0, #120]
 alternative_else_nop_endif
 	ret
 SYM_FUNC_END(cpu_do_suspend)
@@ -160,6 +164,10 @@ alternative_if ARM64_SME
 	ldr	x2, [x0, #112]
 	msr_s	SYS_TPIDR2_EL0, x2
 alternative_else_nop_endif
+alternative_if ARM64_HAS_S1POE
+	ldr	x2, [x0, #120]
+	msr	REG_POR_EL0, x2
+alternative_else_nop_endif
 
 	msr	sctlr_el1, x12
 	set_this_cpu_offset x13

-- 
2.47.3

