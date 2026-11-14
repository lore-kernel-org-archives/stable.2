Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669358;
	b=3APYuuVMwJjYYpe2wI7DeMcGbomfFHvejerkrtG8vbk2kHzceFpQJPTj1pvau3huVGx3
	 d3/eNn/Bwch+vREFbMN5eBeN2noRWXJlnnou8XE1JJSPHzbJSZ5sCLZFZwUsa8Dw2FDS4
	 O+qF3UJ5R/NWQTFYmV3xVJ8Q7imCU5McEV0JdabuHaCPBgOSfnB7K8wOc4C62mTCqW8Hq
	 7l2slCGAVbgfIZgSQ5q+dU8mUq6DV67OosgM3iH1uj4HeBvjySs3XE06ztqdFyrzCxQf/
	 S8DqtYhebU56/So7Ym1AcYj0gLo25GDWpMFN6IaYBdePz3HbzV9bBOfM2GY4/Uw6dOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669358;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ns+Vtt0gloFNgRyJBkm9c7URdPK9hD7QUQdViMFHoxY=;
	b=TORlF9jL81nykzklV9rpGBHT2DJ573vVIJ+jg7Ik4jEdF1MR78khaMkqHoLEQurSiBEP
	 Y97Y89yMmCnlULjTrs1msBt2zjfigDsWnVpF2VG0x7RHvGxD6f/i/9bYjcNwKOviWHaLV
	 I5B0DhGzKG2bY55ufdtEqCs5c3N/zuGs28eBm+Vg6Kx8dvXLaFNnHGfq5ndDg1XTaDlrQ
	 9dOff4Xjhbln89k+4dvA86jtifi8ZIiqPNH+4zOP4ZIzJCrl5sRZp7J5CrYhRU2u6dkSS
	 efql74K8aG9ltvofqaTK/FkNBg4pXGBU42FtSp27sfp+IefkyTctX93GIN0pyjLRsug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XcjwWc0+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2C5606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XcjwWc0+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BC91F000C4;
	Sat, 14 Nov 2026 15:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794669358;
	bh=Ns+Vtt0gloFNgRyJBkm9c7URdPK9hD7QUQdViMFHoxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XcjwWc0+RLoqbP+qnVYpoU5fDzkm5zXWDeZbFAnVAfbxLFtmoB1xxL1dFzRpFxa8L
	 UjkKUs8Vm/prk4PKkt6pnR8ghvSV1P2HGx6sKQOvT+46vGKVJzPNnWzlpxvz1SLqUu
	 6OzyzeABOEBS4arfa0Et6rlrumRZY40UGdPdtfsERUcqHnSgL6gKTB8m6chjvRj1nG
	 SEV2NcMhplStlezApXR+cf0RMgW5FvzSYBajDwEfev3+gdr/uvt7ixiV2GUMGE5q/Y
	 HSjystmSbQTgYkaqqSG4cirGmUBa/Aj2v0v6rf/RRidePMnAmtPsA9X/5JFZp+h5Or
	 qcR9ZXG9JfPxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wei Wang <wvw@google.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] arm64: suspend: Save and restore TPIDR2_EL0 across CPU suspend
Date: Sat, 14 Nov 2026 10:15:56 -0500
Message-ID: <20261114151544.3432889-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201937-failed-6.1-beeec0404622@kernel.org>
References: <20261109201937-failed-6.1-beeec0404622@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Wang <wvw@google.com>

[ Upstream commit beeec04046227eba42b7cc5ab32498aa43da9632 ]

TPIDR2_EL0 is a live EL0 register on systems with SME, but
cpu_do_suspend()/cpu_do_resume() don't preserve it. Its value is
UNKNOWN after a warm reset, so the task that initiates suspend can
return to userspace with a corrupted TPIDR2_EL0.

Save and restore it alongside TPIDR_EL0 and TPIDRRO_EL0. The new slot
fits in existing padding, so sizeof(struct cpu_suspend_ctx) is
unchanged.

Fixes: a9d691585950 ("arm64/sme: Implement support for TPIDR2")
Cc: stable@vger.kernel.org
Acked-by: Will Deacon <will@kernel.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Wei Wang <wvw@google.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[ sashal: Adapted the suspend context layout for the missing TCR2_EL1 slot, using offset 104 instead of 112 for TPIDR2_EL0. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/suspend.h | 2 +-
 arch/arm64/mm/proc.S             | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index 0cde2f473971e..eb60c97355530 100644
--- a/arch/arm64/include/asm/suspend.h
+++ b/arch/arm64/include/asm/suspend.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_SUSPEND_H
 #define __ASM_SUSPEND_H
 
-#define NR_CTX_REGS 13
+#define NR_CTX_REGS 14
 #define NR_CALLEE_SAVED_REGS 12
 
 /*
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index b9ecbbae1e1ab..5d41d39d58472 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -102,6 +102,10 @@ SYM_FUNC_START(cpu_do_suspend)
 	 * call stack.
 	 */
 	str	x18, [x0, #96]
+alternative_if ARM64_SME
+	mrs_s	x2, SYS_TPIDR2_EL0
+	str	x2, [x0, #104]
+alternative_else_nop_endif
 	ret
 SYM_FUNC_END(cpu_do_suspend)
 
@@ -145,6 +149,10 @@ SYM_FUNC_START(cpu_do_resume)
 	 */
 	disable_daif
 	msr	mdscr_el1, x10
+alternative_if ARM64_SME
+	ldr	x2, [x0, #104]
+	msr_s	SYS_TPIDR2_EL0, x2
+alternative_else_nop_endif
 
 	msr	sctlr_el1, x12
 	set_this_cpu_offset x13
-- 
2.53.0

