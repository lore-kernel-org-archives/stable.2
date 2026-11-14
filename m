Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794668526;
	b=w413FDBnnhc3KiM3cqG8abMtYjVMZKOcz+Ev6rD0Y7OypJU0x4iok8hiRKaVMfsOyR8Q
	 ctehWtysjtay1Wc8sn5YQqolhyQfKWgfM03UdJJxul8pwUaaF3EctvqUdBh0UjI7GDUAP
	 HtsBHfEACRZmrQlXV1tZ2sW2DFUOu9XwEUBPs0SVqY6u+6ipkbSZXgoHUKBYiOpImVJw0
	 U9Q8LCH93465vBpB0aFTYUlp0CzUbgFPly4b0aSvloxiUPZAjSRwxlg/3ks5+zy6secEA
	 sS8WxRS7BDZgXp86HzFaqrZavyXWAWuasu8ZUxhWSoDpFZxkOIXlNPG74XW17LOP3/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794668526;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Xoblsgif3lTvF1FDDvh5AYAzBbx98jZP3WdicE+0lts=;
	b=jgq8psxejfoYD1HFQ2WCHn3mHrph+SRJRYRDClqVOFu9YsqSq3IuxkFnREQcTZAcLNZL
	 rjnsbhKjsVwEXEHw3WYImA0gv9zaWlWpMkspCqgEHmXf6j24jDB+CNZGGPbdPWe9W7isC
	 Z5E3rIQo+vBkJulTsatMUWwpDKDTuvO3nULe7qAo+3fFlueafGwaguCcxUfxvgmMYJHT2
	 Iywd6yaR+/0mJRPK1wvKAlclCITz64CgXZO7oXDI9UnG7e2tvr3VhTC5WkFUFIH8urVGR
	 FtQ7p8n/KJ2P6dSPgcTqD/ojxIhtN6YSJAxYH2vXsU8OEorJVvOl+7dbWg4Fy/TYc0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4due+h7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CF0606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4due+h7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2931F000C4;
	Sat, 14 Nov 2026 15:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794668525;
	bh=Xoblsgif3lTvF1FDDvh5AYAzBbx98jZP3WdicE+0lts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I4due+h7MDvmCRiyOQBobfXQUvCTgnvKIDoX6Fnnj0bTZC9PpS6Ogj0wgD0iXUZqF
	 CAmp08mRt05vAtm9Si8ccAsZFw03wOB2QCrkaMO14PlOX2Pamu+I9FCPz9lHhiLpWO
	 xJWZQTJtMprYfIJ92TTeiN1LQIC+7sjWUpi9DAxXNhDBc+fCQM6cSh4yy/W6BTp2m3
	 hDlZFVKQ6x/g6npBR7lFNwRus9l7CoFh4er+uSsx3qpXFAk20zfS7drVm3AcofpwM9
	 fEAhcm3iFPd907EQ7XyxuWB/0D2DY5Iyepse5XQRwO9rtfxqpTFxZSS0jTKUDOdPkU
	 TcsukTdI1dL8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yeoreum Yun <yeoreum.yun@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] arm64: Fix cleared E0POE bit after cpu_suspend()/resume()
Date: Sat, 14 Nov 2026 10:02:02 -0500
Message-ID: <20261114150157.3428169-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201436-failed-6.6-beeec0404622@kernel.org>
References: <20261109201436-failed-6.6-beeec0404622@kernel.org>
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

From: Yeoreum Yun <yeoreum.yun@arm.com>

[ Upstream commit bdf3f4176092df5281877cacf42f843063b4784d ]

TCR2_ELx.E0POE is set during smp_init().
However, this bit is not reprogrammed when the CPU enters suspension and
later resumes via cpu_resume(), as __cpu_setup() does not re-enable E0POE
and there is no save/restore logic for the TCR2_ELx system register.

As a result, the E0POE feature no longer works after cpu_resume().

To address this, save and restore TCR2_EL1 in the cpu_suspend()/cpu_resume()
path, rather than adding related logic to __cpu_setup(), taking into account
possible future extensions of the TCR2_ELx feature.

Fixes: bf83dae90fbc ("arm64: enable the Permission Overlay Extension for EL0")
Cc: <stable@vger.kernel.org> # 6.12.x
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Stable-dep-of: beeec0404622 ("arm64: suspend: Save and restore TPIDR2_EL0 across CPU suspend")
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
index 14fdf645edc88..51c48ac29ad5d 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -102,6 +102,10 @@ SYM_FUNC_START(cpu_do_suspend)
 	 * call stack.
 	 */
 	str	x18, [x0, #96]
+alternative_if ARM64_HAS_TCR2
+	mrs	x2, REG_TCR2_EL1
+	str	x2, [x0, #104]
+alternative_else_nop_endif
 	ret
 SYM_FUNC_END(cpu_do_suspend)
 
@@ -144,6 +148,10 @@ SYM_FUNC_START(cpu_do_resume)
 	 */
 	disable_daif
 	msr	mdscr_el1, x10
+alternative_if ARM64_HAS_TCR2
+	ldr	x2, [x0, #104]
+	msr	REG_TCR2_EL1, x2
+alternative_else_nop_endif
 
 	msr	sctlr_el1, x12
 	set_this_cpu_offset x13
-- 
2.53.0

