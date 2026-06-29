Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EDA391851
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744100; cv=none; b=uIXKOuHt+4cKsAMF77XAHXcuwb5XsNzLe3MbefkTvzcjtz9s4xynrYQuL9QBHWWNjkORD5tygEdPjECjQSvXSrpUoMkgoLvax25U+GWe0F8E6BXGw4RQprH4Fu7FD6shdb1bL+obAXn3gf9AaeZF/dNpguuVS8elTwNaUSelwAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744100; c=relaxed/simple;
	bh=152id66Hu5Nzg08+7L/HjF+igyB4xqz7dgqyjP1f9ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBXBJq6huDwwAGBkyCT3BJA/XFbeyZDS1tvxvca0eduf5Gy+MI4qKa1NwLqATbxxlh7qPFU6lZ/O3ODLsq5i6ukMe6ADpAPfCMjfep5GmbfzCZmeVF6+etFSdUwLDhm+qOG4mGhO7p3ST1srcvdYu3Mltqlu3R/2gKSlmBdYR9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HPj1xucu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GkUhMfiw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HPj1xucu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GkUhMfiw"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782744097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nsl65AG9WdEaIO/06DkaQgf8+pe1r0Pl8PphA68mXaA=;
	b=HPj1xucufGASQAzF9yZ0/WnhhWfjJWqWjxk5Qx0y9HIGO+iiBBvQLICccAgVgwZZNCS1u5
	eUnB76L9ZE6yJy92xSuzGhl0dGVR8gSNd698g7L1pJUDjH1zXrRs9zvm+T2VMI/rW3sux5
	5ngXT46oaLxFpv80SaDvF0QhMN9UuYKLPtx73kABDuvyRQFmvZLPBsEv5Lao1BjzG9fuU1
	BxdqzVAIqJ016Hax3KrSuMzueGRu0Ruxv9zMXjg5EzJH/u4P+ips/yqm44+oanJiDOR8B2
	zkqK0OrXuzDQLy2+Y93aV8nqltECDRPc1/Zng1rtrVfUvLnTfrRsvEGGlTwGkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782744097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nsl65AG9WdEaIO/06DkaQgf8+pe1r0Pl8PphA68mXaA=;
	b=GkUhMfiwudazWBX0w6DxNxX+b6Klp8Wx1+4CnpwLUDml5n7Shz5H1JxKK7oZMApzRm88cY
	3qQ2KNYsooyXQdBw==
To: stable@vger.kernel.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Jon Humphreys <j-humphreys@ti.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v6.18 1/3] ARM: 9459/1: Disable jump-label on PREEMPT_RT
Date: Mon, 29 Jun 2026 16:41:29 +0200
Message-ID: <20260629144131.788576-2-bigeasy@linutronix.de>
In-Reply-To: <20260629144131.788576-1-bigeasy@linutronix.de>
References: <20260629144131.788576-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Thomas Gleixner <tglx@linutronix.de>

commit 256d97d3587b441630c345ab3d773a9e7dcd964b upstream.

jump-labels are used to efficiently switch between two possible code
paths. To achieve this, stop_machine() is used to keep the CPU in a
known state while the opcode is modified. The usage of stop_machine()
here leads to large latency spikes which can be observed on PREEMPT_RT.

Jump labels may change the target during runtime and are not restricted
to debug or "configuration/ setup" part of a PREEMPT_RT system where
high latencies could be defined as acceptable.

On 64-bit Arm, it is possible to use jump labels without the
stop_machine() call, which architecturally provides a way to atomically
change one 32-bit instruction word while keeping maintaining consistency,
but this is not generally the case on 32-bit, in particular in thumb2
mode.

Disable jump-label support on a PREEMPT_RT system when SMP is enabled.

[bigeasy: Patch description.]
[arnd: add !SMP case, extend changelog]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e481254e36455..b7f3ad66ff15f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -82,7 +82,7 @@ config ARM
 	select HAS_IOPORT
 	select HAVE_ARCH_AUDITSYSCALL if AEABI && !OABI_COMPAT
 	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
-	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
+	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU && =
(!PREEMPT_RT || !SMP)
 	select HAVE_ARCH_KFENCE if MMU && !XIP_KERNEL
 	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
 	select HAVE_ARCH_KASAN if MMU && !XIP_KERNEL
--=20
2.53.0

