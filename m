Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF492236E0
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309563; cv=none; b=KKQEutpTM6TeaggWt4Xa43Lf9ozK89SY8eqTNqfF+NBhHHq10+TJf7buyivss6fwWfrbEZdASWEWH0Vi+sPBYOckV6JEouGUITU0vZV77q6lF/MoXff8erLP1Sx1/VTfEuD1vM6ADJg5NptDPb9Y9HtuCTRhJzpTwUcoDLHvIxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309563; c=relaxed/simple;
	bh=79SQjC6vNv5qiKx0UeetsLf9+TPjIMwk9epokBbXn0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKCJagix+X+b9RfzqW84t3jFSkhrIo5avBNKcM0oVKzzHTUaA9MVzkWdhXQu6emddOT7wbX8Sq933lzcnQKaw3XIQqaMUWwzpiWZd2rR/BhUNuEPERF5HK0LEAYUqdZgsxvE/294F5b8LRd/9t3z+UpXGvNjuGJeCgGJI5VJ/qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PqKTw9jd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5jirEbQL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PqKTw9jd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5jirEbQL"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780309559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WEioM98anSZyVH5LJiAiEYpJnhRb/xcgy+gC4lIRJZc=;
	b=PqKTw9jd7nv5fkgJ7fhjMzjrQ+gZrloCgtkUUSm7H7UnijCUxZxWyDDjdB/8/B+3mLmOmy
	Zy6HUcOl5XLfsumE1XP6XaCrAxoMk+FUVGT7Moc0YKWPESXcGHeVu4UssRm0/xSUaQe70j
	U9nBBepPUVz9w1vGHnq7aEY3K9uFrsdCycW7iBLIRgisEQ2NYPwUAHtBNttWk0bt6iyxKl
	ifddT98BQ+36mN6yeqWGiV20g9HtqJIr+4FgBluVb7Pr1hMVtcpwHQEu1+FaN/fEDmJfoP
	MKH8MHPQIfbimqVIKhRIgf+riy6rwnC1brX4TRlpqVo6swT57MBIntzxh5qM6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780309559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WEioM98anSZyVH5LJiAiEYpJnhRb/xcgy+gC4lIRJZc=;
	b=5jirEbQLac0v7D8Cu+MKtAhpMNRYKA8rCX+85QpjZl2PIaVC7Z3YrVlqKNrZWIcMFPGKcK
	zpmka85FLEWKdCCA==
To: stable@vger.kernel.org
Cc: Mostafa Saleh <smostafa@google.com>,
	Kees Cook <kees@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>
Subject: [PATCH v6.12-stable v2 01/15] arm64: Introduce esr_is_ubsan_brk()
Date: Mon,  1 Jun 2026 12:25:40 +0200
Message-ID: <20260601102554.233076-2-bigeasy@linutronix.de>
In-Reply-To: <20260601102554.233076-1-bigeasy@linutronix.de>
References: <20260601102554.233076-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mostafa Saleh <smostafa@google.com>

Upstream commit dc1fd37a7f501731e488c1c6f86b2f591632a4ad

Soon, KVM is going to use this logic for hypervisor panics,
so add it in a wrapper that can be used by the hypervisor exit
handler to decode hyp panics.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Kees Cook <kees@kernel.org>
Link: https://lore.kernel.org/r/20250430162713.1997569-2-smostafa@google.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
---
 arch/arm64/include/asm/esr.h | 5 +++++
 arch/arm64/kernel/traps.c    | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 5f4dc6364dbb9..b0520b18192c5 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -409,6 +409,11 @@ static inline bool esr_is_cfi_brk(unsigned long esr)
 	       (esr_brk_comment(esr) & ~CFI_BRK_IMM_MASK) =3D=3D CFI_BRK_IMM_BASE;
 }
=20
+static inline bool esr_is_ubsan_brk(unsigned long esr)
+{
+	return (esr_brk_comment(esr) & ~UBSAN_BRK_MASK) =3D=3D UBSAN_BRK_IMM;
+}
+
 static inline bool esr_fsc_is_translation_fault(unsigned long esr)
 {
 	esr =3D esr & ESR_ELx_FSC;
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index e2e8ffa65aa58..5e138cf5d4ade 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -1136,7 +1136,7 @@ int __init early_brk64(unsigned long addr, unsigned l=
ong esr,
 		return kasan_handler(regs, esr) !=3D DBG_HOOK_HANDLED;
 #endif
 #ifdef CONFIG_UBSAN_TRAP
-	if ((esr_brk_comment(esr) & ~UBSAN_BRK_MASK) =3D=3D UBSAN_BRK_IMM)
+	if (esr_is_ubsan_brk(esr))
 		return ubsan_handler(regs, esr) !=3D DBG_HOOK_HANDLED;
 #endif
 	return bug_handler(regs, esr) !=3D DBG_HOOK_HANDLED;
--=20
2.53.0

