Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794668526;
	b=aRRJ9JhhWef8ZbOFYhslL7xwpJer2RVPqmJs2Y99XzAtqLAIkrqluoY+5OSo1Mv1sz6a
	 CRzJiCPGAPaglon4OKYsf+0ZU5W/KeHuMMCjojzFtSimWpcxXGyb1IxRrumRKwfmeHbht
	 xLoq6Gc54ESxm5h8ypRjCVaXoywc6WnqJqSw4kmJcM0ijHbXLLAmwcUkvauA8nlaaar7F
	 Hrvk0erTqiR9izCWqv0OnRsjjIrao0P3p61rsIGE5TWVPzB0ky8rjYMNsKuT2VP5UFV55
	 uKKqSUli4G7MfpT1RAeViRn06gUGpY1Utulqoccloi+/tlU1pWGeAb90Ccs0l8oJyrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794668526;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MJ29jJIc22ay2O47EEGo8ZhDju/xc4gcijopUeqz/Xw=;
	b=lCLYz3CCK1xK0HHVO7F7aULc15Mv65whZ2PsZIWV4sko/utsxZOXRtvOlCG2zJ18eu+Y
	 vUl+nwexr3bLNFIuiMlZBuDzgQhIGFjeX65JcWvxdcMXQ5HWuYOZOTUGUhhUAYmIw+OAf
	 GkE/L/pWXpU5i77SPv2dxqnOYvdrv8qOxQhOXQtyvTIa1Z2AXGCz3nezZXwkslnsV3Q+G
	 YpLnAVm7D03P+bHueFMuE2zhxTaTgqcfPg2rBnAiMgDxiKy7S6qRlBUg0UbTbNpegGzxl
	 f0JwLWnD8MBdKkimhxDpgEpXTqBQ9vo5Sq/jbBplYWYNYKBRmr4I8gbFr1S3MAZkSkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TwPlBaCG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC904606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TwPlBaCG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D7A1F000C5;
	Sat, 14 Nov 2026 15:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794668526;
	bh=MJ29jJIc22ay2O47EEGo8ZhDju/xc4gcijopUeqz/Xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TwPlBaCGJTW//ShiuO3NU7bCW9+atsdve8A1cNIgUYbgSffTmeLJeJ4jebXH3KwYZ
	 ZVQckUPJDcWPNWGnMn7WcXx3e5hWcZCjpGZDSU+893VT14a7fpf2BXg5bgHZcyfed9
	 Gd7jKeXChYWRn+/XsA85gRnT2BpVSaGNkYlt+KHHsg98FT4vVXPm7M9C6P65aByqq5
	 XetoNPKznlIW2PXIo5jB7Taw2cnqQ9EqsFaa5fvE19HRHR+lzCGuT+XJ8PcI/flm45
	 rgmeeK4+WMRrTMPRaj5nmv7K9N3P6M0d5sc74cjWWEtF12VeGD5GApWToZeJzyjCCV
	 uE5kolx8PKfUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wei Wang <wvw@google.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] arm64: suspend: Save and restore TPIDR2_EL0 across CPU suspend
Date: Sat, 14 Nov 2026 10:02:03 -0500
Message-ID: <20261114150157.3428169-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114150157.3428169-1-sashal@kernel.org>
References: <20261109201436-failed-6.6-beeec0404622@kernel.org>
 <20261114150157.3428169-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/suspend.h | 2 +-
 arch/arm64/mm/proc.S             | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index eb60c97355530..2cc5fb405769c 100644
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
index 51c48ac29ad5d..574136a35ea21 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -105,6 +105,10 @@ SYM_FUNC_START(cpu_do_suspend)
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

