Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728795;
	b=vozMo4IeR7YoJcLlpAR4jpetRxlLoY8+rX2quNwEmIAvlUtRtzYnsLfQznZvpp6JGqcp
	 IOtH1Gsj+SFLMlOlkwftsdYPoJ/qr2akapLrVitCvItWoQJdDtkLfbKGGdseYAIHD0LDE
	 Nu89cNNe77HnIVfk5c9nmdDqaJSOVd4V7iVAeON/5ppoq4GHxvVW59wWfhpuyG1Xs4wXt
	 TqdIlLpCrJc04WIBLTT+kZMsd6oR8dWNPzcuNbpmDLhzt0VqlkTDBO8makSubaKto2F1I
	 j3F0wnERExwOhNTuZu9wQgHem94pR5MTLEGyXFLjHZm173WZaew6MaBuJecyrUajySw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728795;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=FPwct+1U9T6oyA5Ruuz5LB/HvShMdpdhhsQD4HMVAhg=;
	b=GFohJ6WWzrguHg3S1gVXMfi3ZpA65uqJlfyi9wQlN9v5JzZ69BJrU1Ml9hd+SW4f63Do
	 O9lJ0AVdZ5mdkdaZyK296UuXOFflEHu+PrljscNpEnIWi2rbXZfRV8hnB8GOWTmhsNNOZ
	 SfZX0FepGak95MKokrj8KEob70gF3EEtrrgKeOZV78acWCvgVht6yoalAS3ayEu5RMiLz
	 2llba5vJ9aLK6XyVsajH+q1lwoo1nvl+CmHrJkWbRpQyOurQlDGcCywYd5PASQkMkNfiW
	 opJisT7GfVRAW7Z0OugxDEdrUF7iMTzR7puNYKuy0/9cp4Vx/MhZ59j15l3gaxQfKWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wvw.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oKWTE9wx;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7154606D803
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 17:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7154606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wvw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oKWTE9wx
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ae7faf4ff7so5873333a91.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 09:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793728794; x=1794333594; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FPwct+1U9T6oyA5Ruuz5LB/HvShMdpdhhsQD4HMVAhg=;
        b=oKWTE9wxvvkr6zCRmGOi7MD8BifRNWWeKWlQl288hGhFeyWHixUsNw7NTaikjfsx+E
         fl/68xwPzPUk2e/UEBmVVs41KowLq0QtKlvhIc47QqPmeD0M1otau9oULB6BOFOgWXIu
         5aVDEyLHY+EYQ0QJKkPWr1Ja0np0kBEm1xdQKdlv295PWhkpy4fDI/snUTgmU7qN0epA
         4wbVCoPw/xuYj/dhulM1DJVJxN3lD3yr16y0rwkMyt+0EaHFjkF5fr1M91lTR+AHIsda
         xaTQtNbiTAHCX4YmdvieCD8sC52zOSmqojGRDrTuu6Z4YmnDC4wgjuZ9AUqzWcUPF740
         OhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793728794; x=1794333594;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FPwct+1U9T6oyA5Ruuz5LB/HvShMdpdhhsQD4HMVAhg=;
        b=T+BkybsIBBVcxLh/ngzeU/Tiky/+UFtWzGU4imLaM+risSkgTbbV/+IIp/uWn6fIgB
         jqyh6JWfc4ZMizP6kaAoJCGGDs6nBDxEdTr1+qBV1cUxCT7Hmg02SZk9gS+sMlbWzhHC
         qQ474MhfPqSc20zXNSZwX8jfcRbeeSST7NNqliTYM3p/h8BQCup3PShS924gK/mcXFY/
         ZlzImWotwSBke7piyXm3UorhCUNOwozqavLJez0OgIoulSm58/Znp19b5Ep9WKd1hZs0
         5gFWI3qdC557dZAOj/xKDf0VIVdUqMpO0gDqW2UuhuBvNBvhwQBPdFZvssyJn5fQickt
         921g==
X-Forwarded-Encrypted: i=1; AKwUvBxfvvFpNcpDcXOIoJZnCCm3iD/BDzZIxty0gM5W7ImenHO730bByWIlu9rZ6XaszkpFNPxHjhU=@vger.kernel.org
X-Gm-Message-State: APuU4Z91Ju8xJlfEjs1EQpZxvAv3c2hcFCNAJ89ub9cZEc398gx6L3U2
	2PPFQv4X+00YU44djkdtZ6nn262BOVbeZRCIWY6eZOhzlDllROwFFbOjTTh+4crvok2QXg==
X-Received: from pggs9.prod.google.com ([2002:a63:dc09:0:b0:ccb:62e:3f01])
 (user=wvw job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b0d:b0:3ac:9e5e:d1a9
 with SMTP id 98e67ed59e1d1-3ae897ec5b1mr11095151a91.20.1793728793847; Tue, 03
 Nov 2026 09:59:53 -0800 (PST)
Date: Tue,  3 Nov 2026 17:59:41 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103175941.1349818-1-wvw@google.com>
Subject: [PATCH v2] arm64: suspend: Save and restore TPIDR2_EL0 across CPU suspend
From: Wei Wang <wvw@google.com>
To: catalin.marinas@arm.com, will@kernel.org
Cc: broonie@kernel.org, mark.rutland@arm.com, rafael@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, wei.vince.wang@gmail.com, 
	stable@vger.kernel.org, Wei Wang <wvw@google.com>
Content-Type: text/plain; charset="UTF-8"

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
---
v2:
 - Trim commit message (Will)
 - Keep mrs_s/msr_s as TPIDR2_EL0 isn't in tools/sysreg yet (Catalin)
 - Collect Acked-by/Reviewed-by tags
v1: https://lore.kernel.org/r/20261102234813.1069156-1-wvw@google.com

 arch/arm64/include/asm/suspend.h | 2 +-
 arch/arm64/mm/proc.S             | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index eb60c9735553..2cc5fb405769 100644
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
index 7afbece885a3..c7b7fa6491c3 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -103,6 +103,10 @@ SYM_FUNC_START(cpu_do_suspend)
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
@@ -142,6 +146,10 @@ alternative_if ARM64_HAS_TCR2
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
2.56.0.385.gac671c819a-goog

