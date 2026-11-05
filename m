Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895517;
	b=RmcPhm9xmgLrfnmdJ61XaPsSLnD2AgIJ3iumhAmAK+nkyJ/qKRR/fXOxsDKKwAuHV+H8
	 lHH3cP95FhVA/6GNFdQWxeoDAi2Z4ZFJYZqp8pEDKLCmdQTiq1MQCOIxsGEwjUIZfZkmI
	 O05jLkIprdLJ1Rg2UnS68s0cBtEALxJ+Xqw1GYVinc9skB46mF0r+xV4vCjdl8c3fz5pk
	 +n+O5UmAEDBt0+NyiQ45dY1ClKqvrcf8yOgdf1MTOx4H8sJSAOmtEUOtIJ1RPmJf37JuP
	 8Y4emXuzLQljx1mDsNa4uO4HprlH56jwPxDZ6B4Dhgr942LRKU4HZ/n9x+gAIwteU0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895517;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Q1wzICjfg9pLWF4uQ2Ye2aGYQ7sT5IneayGFNK4OhwI=;
	b=4yWMLz9d8ikJq+Krrc943ov67rvpDoNLqOfpjDlCTcH5TgyDnPqNjPzAsa9FKdX+KH5v
	 jXgDIqJqXrrLP9QjO3mJFYMN5ut+r9tHf6klSk4N7PjUc8x7ZvaqJBbeL8i6EZYGNdyMZ
	 uhir0K/ErXIMeQZ7/dehIqKuEhQL0kuPRa52yHXF6J5EB1/EaesuW74ckdzbArcpUa4VE
	 QK/jTkrA8wwspwdDaFCPx3RTvQUQIMv8JZkhCJ3hO0Zk2V/JB/iWnD8C2FnEDj1fZP/QB
	 M1wVKIJIzl2Q1sAVBWnKu1JIkQ4jL1pIbuCpk3+jiYqLwZtjrIwc+7oQmvWMzN2BCXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mdiE9o68;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855E7606D80A;
	Thu,  5 Nov 2026 16:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mdiE9o68
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605A81F00A02;
	Thu,  5 Nov 2026 16:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793895517;
	bh=Q1wzICjfg9pLWF4uQ2Ye2aGYQ7sT5IneayGFNK4OhwI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mdiE9o68vZabStM/LcLocNZ6X+zmyequVFrq+B50cKOyxoh2VKSq665BIjcImPyUA
	 qi2YUqiZxCkW/MXas074+KkL1bPiM6UJfmQNKepMp1uMxBAJnBuQsLTvjXlw/mcJcW
	 JVpIzVWR+x4GkHZp37Vxxj5y/ipb1Q7TDVcOv7FOeUiMqBn1qEKdVlEBC6nkvfAwU3
	 cj9k05TxPIFk5WUiZVaGy2SYNAzgw7CYyHhRpyQdtyGUm1WerlrP8f73y1D0S/hBxW
	 bXJfDZlUJHZde7PMWlld1ViZIl9B71Qfh9yN03laSGXSULHu3nn9OXIVwZmIKWpaig
	 C+h/+LgOcFDUA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 05 Nov 2026 16:05:05 +0000
Subject: [PATCH 2/2] arm64: suspend: Save GCS state over suspend
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
Message-Id: <20261105-arm64-fix-sysreg-suspend-v1-2-f4d9a99fec46@kernel.org>
References: <20261105-arm64-fix-sysreg-suspend-v1-0-f4d9a99fec46@kernel.org>
In-Reply-To: <20261105-arm64-fix-sysreg-suspend-v1-0-f4d9a99fec46@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2103; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Xja7UvEm5HI0itnYb/prznTdOhOEj4Bh5en96dVICsI=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLerAmdLiQY/8zuIIu9yAQ3X825tmtypkxf+PjcL8MJS
 RF9rttEOkpZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjCRz/KMDJ+X/X+8J2KOqvzS
 uhdizmt+NJ455Lf6ydkrz6ZePmbUtqCFkWGv/Ia/qYn73iQHh/55Ovt9WHXh7LpXIT/Z401/lW2
 9OIcHAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

GCSCRE0_EL1 and GCSPR_EL0 are live registers for EL0 on systems with GCS
but are not saved and restored by cpu_do_suspend()/cpu_do_resume(). This
means that the task that initiated suspend can return to userspace with
UNKNOWN or incorrect values for GCSPR_EL0 and GCSCRE0_EL1 (many fields
in GCSCRE0_EL1 reset to 0).  This will in turn lead to ongoing
corruption, including not restoring mode until a task with a different
GCS mode is run.  Fix this by saving and restoring the values over
suspend.

This increases the size of struct cpu_suspend_ctx by 16 bytes.

Fixes: 5d8b172e7005 ("arm64: Add Kconfig for Guarded Control Stack (GCS)")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/include/asm/suspend.h |  2 +-
 arch/arm64/mm/proc.S             | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index eb9ce315f146..8e9c97aab15a 100644
--- a/arch/arm64/include/asm/suspend.h
+++ b/arch/arm64/include/asm/suspend.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_SUSPEND_H
 #define __ASM_SUSPEND_H
 
-#define NR_CTX_REGS 16
+#define NR_CTX_REGS 18
 #define NR_CALLEE_SAVED_REGS 12
 
 /*
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 664ea9e3b9ad..99aacf03367d 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -121,6 +121,12 @@ alternative_else_nop_endif
 alternative_if ARM64_HAS_S1POE
 	mrs	x2, REG_POR_EL0
 	str	x2, [x0, #120]
+alternative_else_nop_endif
+alternative_if ARM64_HAS_GCS
+	mrs	x2, REG_GCSPR_EL0
+	str	x2, [x0, #128]
+	mrs	x2, REG_GCSCRE0_EL1
+	str	x2, [x0, #136]
 alternative_else_nop_endif
 	ret
 SYM_FUNC_END(cpu_do_suspend)
@@ -168,6 +174,12 @@ alternative_if ARM64_HAS_S1POE
 	ldr	x2, [x0, #120]
 	msr	REG_POR_EL0, x2
 alternative_else_nop_endif
+alternative_if ARM64_HAS_GCS
+	ldr	x2, [x0, #128]
+	msr	REG_GCSPR_EL0, x2
+	ldr	x2, [x0, #136]
+	msr	REG_GCSCRE0_EL1, x2
+alternative_else_nop_endif
 
 	msr	sctlr_el1, x12
 	set_this_cpu_offset x13

-- 
2.47.3

