Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6721FC8
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784366265; cv=none; b=PXYAf3eZmStrWCyPE1naXB0xE1OL4UTOX+7JfYludjrg4GgQf4qkN3Ilzrxq04Yav40UjLWOhdMprLZfKAh6LBWxCi7tvSUr4sPdUdHJQnzrCQ+7fnphpP0st/kDqkkDXolKBDAhuMFJ2D0d4cVfY6+tsgGf5FXXYxZu25PYofg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784366265; c=relaxed/simple;
	bh=wDM4AvIGXM1aONb7ZX+veveiG7LUkrLo3P71iPWDevY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZjKI1fNcQ9bxIvW/XCcGv2lt8lzA33WeQJyyGxZDLgZxcg3Xkg5U8douMJaEgPjPZxWi0BG3FvcCcwwzpXtkEaq5ooPACnSkPhNjCzsxV7Z/+lA35jpJzsm/bo20GFvHTJU2G+WXTmq9ifE5rPX7LFYsVp/26UvB03oDZ1Fp6O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+qAOKbI; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+qAOKbI"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49545ba3d4eso11290865e9.3
        for <stable@vger.kernel.org>; Sat, 18 Jul 2026 02:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784366262; x=1784971062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+4ABO+bTkfPgOfO7AVPQCNenlwqlj31lfWE+FzUnWC8=;
        b=Z+qAOKbIphbTUpTLWli2MTKFz56hj0b+dJdYsuMkHoOMfNLaTTk3YXOeXMY5v53sv9
         NlSMcDYPOY6YVCWhhHNX5tya3xSwTeBAn5v8gsm6Pzppq690YcD93wd/8ZOuMfGUjOC2
         sbxCbcce2WIMrfL+aEQrxw0DeE6elVW8L++oHuzoAat9MteOgjOD36WlcQgW479TiIAy
         PLL9D0Xbj9gMYCzd7rLegD3C+FAJ3unAoGOIGTvVlN4yM1879xTIzt+pFADFfoWR/bdX
         o1q1UmTIYXEgNHhTRaecnBFcKXwvgvSuu+E0X8IWajnME2eWC+hQiuajUn0PA3TNz2m/
         aWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784366262; x=1784971062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+4ABO+bTkfPgOfO7AVPQCNenlwqlj31lfWE+FzUnWC8=;
        b=hJA9foXJQFhUkiyyhEN5RcQiaAkymQA62WBrxz2IO9P9wqT2OxzgZktxRk45w5QAgJ
         M1uGvNxT5khyhQxefqjsVxxRwt74OFu+AxcCGrsVljFYLwm/SGBhcTfMptJlYSXHqenx
         UYwVro4zJ5wsNZIt4PVNlnq99Jjb74RvRLBf0nKP8e5Gi8UDThzE1pO9opdKlR+OWNi/
         tqzAe6MtI6+GrcsI8IJ/JYwOpLLvKqqQNuWbm7MpP23dnAidEYDex9j1PBss2vJ/hXHd
         nqmneNGnPuvqq/fB9TgMLLPJBDhiVaYF1YNfTEUvw4KUuYG9WVxUYd7HFaHgOjtTQpWr
         JT2A==
X-Forwarded-Encrypted: i=1; AHgh+Rr5+OWSBLrgV5ReA1UoTG7DwsUpuy+IwMnfD+RCbbmhEjLiGHPAOt9q6tX6/vDqYwX0ofjVuYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKe+1QKyOVpDXLJ2W915BjxmUxdXhilHK0R+39d8Yijmq2WeAz
	DfPBRps2rr0QUTOHMnItRSAt3WNcyxBgeubwX2PVtveKlnfTV50vvvVe
X-Gm-Gg: AfdE7cm8eXzCsFRxZgQo8PKcyjp6Pxsz0pvFTFepcmiYn3uPfTLPcgInwRj0uqtbXp5
	vo8GD5ULiTh82J52o1MoMkqvyHOOr/A5DezL46rk70CGjwklTvd2kgN6FLh4AHvWeQfArwprK8D
	AxonTyCA1uVhc01hu5l4YTMRwD7kHcC4LCYjJBI8Oasb9r5lpeLasL6zLPx8wbe08nIECo0WUB+
	dEIIDJDHCgQulml+M1wkB584DfaYwgX9O4H8UKBW7TrFArBdsSfD+fup+5KdFHKA0ZQDKPNg76y
	I5Q87ZEQDxJ5oGDehttevTlM6e9wOk/iSxYFLeLezSjXXQCY09eIjKfG/UbJR2zbMVw4XIr76cn
	Y7mZXuZPGwkjonr9fdHDUX7FagGqQ/foB/RRaMSYznpMZnRG7vgpHkTwc5UjBCdIMWgNLXCZa6Z
	A9buTi0DpOMk/awwfaFvUIVgulHTOjAi4n467AZ5VmcxfCOwOic0uP8LZ6IaBRX+Cc9palv5xnK
	/p7vm1UkHc5YqQeAeL7Uv9Xb23piHzRjC+mV11S
X-Received: by 2002:a05:600d:6413:20b0:495:47b9:f46 with SMTP id 5b1f17b1804b1-4954a52411emr55531825e9.39.1784366261485;
        Sat, 18 Jul 2026 02:17:41 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-002-153-175.77.2.pool.telefonica.de. [77.2.153.175])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ec7c69sm11186363f8f.17.2026.07.18.02.17.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 18 Jul 2026 02:17:41 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ARM: smp: set current pointer in assembly before jumping into C
Date: Sat, 18 Jul 2026 11:16:00 +0200
Message-Id: <20260718091600.92021-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_KCOV_INSTRUMENT_ALL=y, secondary CPUs fail to come online
on ARMv6K/ARMv7 SMP:

  CPU1: failed to boot: -38

The compiler inserts a call to __sanitizer_cov_trace_pc() at the entry
of secondary_start_kernel(), before set_current(task). The KCOV hook
dereferences current while TPIDRURO is still uninitialized, causing a
data abort before cpu_init() has installed the exception stacks. The
secondary CPU consequently never completes startup.

Initialize current in the secondary assembly handoff, as
__mmap_switched already does for the boot CPU.

Fixes: 50596b7559bf ("ARM: smp: Store current pointer in TPIDRURO register if available")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Tested on QEMU vexpress-a15 (mainline and v6.12) and
realview-eb-mpcore with and without CONFIG_KCOV_INSTRUMENT_ALL.

The head-nommu.S change is untested because no currently reachable
Kconfig combination enables non-MMU SMP.

The redundant set_current(task) is retained to keep the fix minimal.

 arch/arm/kernel/head-nommu.S | 1 +
 arch/arm/kernel/head.S       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index b9d6818f1ee1..f80bbfbd3a6f 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -116,6 +116,7 @@ ENTRY(secondary_startup)
 	ldr	r7, __secondary_data		@ reload r7
 	ldr	sp, [r7, #12]			@ set up the stack pointer
 	ldr	r0, [r7, #16]			@ set up task pointer
+	set_current r0, r1
 	mov	fp, #0
 	b	secondary_start_kernel
 ENDPROC(secondary_startup)
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index f22c50d4bd41..a22403a629ef 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -442,6 +442,7 @@ ENTRY(__secondary_switched)
 	adr_l	r7, secondary_data + 12		@ get secondary_data.stack
 	ldr	sp, [r7]
 	ldr	r0, [r7, #4]			@ get secondary_data.task
+	set_current r0, r1
 	mov	fp, #0
 	b	secondary_start_kernel
 ENDPROC(__secondary_switched)
--
2.43.0
