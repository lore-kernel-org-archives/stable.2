Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273278;
	b=kAj4Wt+ZesTHZ2NKa5663Wp6BXdrDdFpXJz0KwrSuNOvTBaZ8a4IbjMdShdhZIBvj6ed
	 4OregCn7Vg1pRJ4f7IJfaJ7mYPl7TMz3/VVKEMGRL2SCImoYAgO1DusByoRP1vud9rBKX
	 I4Da/QSdFVtuAiKrvZ8+A3yiWuoK7TFJ3sEkMnsSoZ+YeFa5Qj0MwhOgesW9lJtzNAKg0
	 YM0bY6I94SYz8jGUMCTDLxoQvd+GDsh5xdDXaGQ9FtSSPYrG7zQ/4N3fJ3iYZBOOH1ERV
	 ippQnVtXMpDA7hVdI9HUsdMZtwSZjdQSJxnYH9agOizNP9Z6j35zaj+SRc55HH9vUoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273278;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=M+rRgv8k/jXTK7VDdlA8QOkeCDcgtZ+VykEqUZivMdI=;
	b=M+IdAO8NCYCeYwC/nCSbmB09PNWXQazZeoizUGWuI4YRnqNdQV7t1Tbia5Bblf1bZ6jN
	 vsWRTtNE86JdvWB1sQ5WvCC5eLcM8f1B6wTa0tMYjNKllLfYQ86nhaCm7+QDOJYoSMtJw
	 J+7PqVNv6DDD97OD7NBJaFqiat1Pa+hFQSZEJ7oJp2F9ZG0sgISlJ84QVtYNtS4v20zYB
	 ykSrqcjicpK86M7Nv4kozaD13Bwfos+4yS/G3PSBdvbM73Qh9HtvUJYiw9nTFWQKy2aK4
	 kSUi//1Bn6Au+3n+qJC4tuoY4IxSSaQ8SvmYDZmNaiaUVmyjfibEFN2U9iRoiA+XS+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bz+ur3bW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E60606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bz+ur3bW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FB41F0089F;
	Tue, 10 Nov 2026 01:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273278;
	bh=M+rRgv8k/jXTK7VDdlA8QOkeCDcgtZ+VykEqUZivMdI=;
	h=From:To:Cc:Subject:Date;
	b=Bz+ur3bWG6MVJe+TfS4lVo4MekxpONzuc1G40HnZl5ntO8bKAG5BClfp2qG7nIiO/
	 wCee2x3E2ZnwFHu00tQhR/C4ZlV4yza7JmXBxGhxHqlG1QMSXZQAUwIxQ4ya1jAUng
	 uEe3TX3KVreOLY8OxbRmLBLdWyq4ZLU3XVNpDkHxIq32I11e/cJedCHROT8CCwBpLP
	 6F2F55Texfd9vW/GmFzAWlQUPAHa+bco3vm4jK0kKu+OHKb6t0LSS9GuCT2XzTsoGz
	 rwu7Edo/DED/iLcPiPHEmfcP5f2NsSU/pQiTHFm9Qq9EUud7vZAQwDD4P5hyyM2pHc
	 +KYr+wXoYs8Lw==
From: Sasha Levin <sashal@kernel.org>
To: wvw@google.com,
	will@kernel.org,
	broonie@kernel.org,
	catalin.marinas@arm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] arm64: suspend: Save and restore TPIDR2_EL0 across CPU suspend" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:14:36 -0500
Message-ID: <20261109201436-failed-6.6-beeec0404622@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x beeec04046227eba42b7cc5ab32498aa43da9632
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201436-failed-6.6-beeec0404622@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From beeec04046227eba42b7cc5ab32498aa43da9632 Mon Sep 17 00:00:00 2001
From: Wei Wang <wvw@google.com>
Date: Tue, 3 Nov 2026 17:59:41 +0000
Subject: [PATCH] arm64: suspend: Save and restore TPIDR2_EL0 across CPU
 suspend

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
---
 arch/arm64/include/asm/suspend.h | 2 +-
 arch/arm64/mm/proc.S             | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index e9ce68d50ba45..a5abf0615594d 100644
--- a/arch/arm64/include/asm/suspend.h
+++ b/arch/arm64/include/asm/suspend.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_SUSPEND_H
 #define __ASM_SUSPEND_H
 
-#define NR_CTX_REGS 14
+#define NR_CTX_REGS 15
 #define NR_CALLEE_SAVED_REGS 12
 
 /*
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 12aacc74f7647..b1516630904d7 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -113,6 +113,10 @@ SYM_FUNC_START(cpu_do_suspend)
 alternative_if ARM64_HAS_TCR2
 	mrs	x2, REG_TCR2_EL1
 	str	x2, [x0, #104]
+alternative_else_nop_endif
+alternative_if ARM64_SME
+	mrs_s	x2, SYS_TPIDR2_EL0
+	str	x2, [x0, #112]
 alternative_else_nop_endif
 	ret
 SYM_FUNC_END(cpu_do_suspend)
@@ -152,6 +156,10 @@ alternative_if ARM64_HAS_TCR2
 	ldr	x2, [x0, #104]
 	msr	REG_TCR2_EL1, x2
 alternative_else_nop_endif
+alternative_if ARM64_SME
+	ldr	x2, [x0, #112]
+	msr_s	SYS_TPIDR2_EL0, x2
+alternative_else_nop_endif
 
 	msr	sctlr_el1, x12
 	set_this_cpu_offset x13
-- 
2.53.0




