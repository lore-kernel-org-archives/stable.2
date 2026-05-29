Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5EE2F3C1F;
	Fri, 29 May 2026 22:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780095214; cv=none; b=iwnTyYayMS4Jdq3tPfUUIz5gFZ23g2dvwStgYiZpJ4SXcsqjRN+obVuwtXSOZvHPhoKgZJlFWkoBK7dsS7hcpw0LlUokaJ5jC7m6bYFBxH3A7bCDn0BElCPu+TPXSs2/J3ricjhOmVLj0qz7SdnmaHy5Xut0D/h2fugEUHPih5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780095214; c=relaxed/simple;
	bh=G0fH7RKtfbAcuwWYv8qR8FxdNld+RPq8HHIjpN3Pr14=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=TNN78EUrbdQ1JooMdQfliDuPwgzGCv4x7EO6mOyedmCkkd7B7vPjV595x5Ai/YSRmzeIxtvPLc9GINaggipFXRg550WRC4hAlo21yAY98Ex7aLK1IdsoIQ7HZmphyKJu27lPq2/HKRKJGtotGfBciFl6VBpOSiNSjmf1eWs+FMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fvShiN0g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OyQqcbg/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fvShiN0g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OyQqcbg/"
Date: Fri, 29 May 2026 22:53:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780095209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=3rpljOHeSS7TL3aq3YU4dskbC3kuoCBkmESPO1DiA1A=;
	b=fvShiN0glhn6jt02KtDMOaRXNHmLEVOrNi2g62EL6vKe2VS+I6JW+PW0nLzoBZ15W2Iw7f
	9E/og2K5MVDJBN80gnywcQRWz89/iRDNm085pYeYUtTWvIsXV48mHTmZ55AKPr8HpKc7li
	Ex9Jk04ZvxRHvevLuclNHSVbMnDkne4V0Fj3vhXeiveA+UyD0MfM3CeFZ6Hw8AUYWwmmjw
	qKFwCC4xxAV2/EnrfP83O97NfcQCvEgtbjLjrT5C/fKQLbZ2xFkIbHjS00lqgslj027HVF
	ESgOQYqNxntmv0i24uRU2aHJ+ATzwWY5Kb7z00m+fM97lFaVUzQ7F0jxOIrxxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780095209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=3rpljOHeSS7TL3aq3YU4dskbC3kuoCBkmESPO1DiA1A=;
	b=OyQqcbg/H0nxPpsmV2ZYXNtLA3ecXdGVN8fiLDeE/KcbcRvsuupRxcSq0HHaeFNS0JUV+L
	PoRU4WTL3kaIXbAQ==
From: "tip-bot2 for Andrei Vagin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] Revert "x86/fpu: Refine and simplify the magic
 number check during signal return"
Cc: Andrei Vagin <avagin@google.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Chang S. Bae" <chang.seok.bae@intel.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178009520795.1039918.8317029204745792627.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     44eeff9bc467bc7d1fec34fc3f6001f385fe462c
Gitweb:        https://git.kernel.org/tip/44eeff9bc467bc7d1fec34fc3f6001f385f=
e462c
Author:        Andrei Vagin <avagin@google.com>
AuthorDate:    Tue, 26 May 2026 20:50:43=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 29 May 2026 15:05:30 -07:00

Revert "x86/fpu: Refine and simplify the magic number check during signal ret=
urn"

This reverts

  dc8aa31a7ac2 ("x86/fpu: Refine and simplify the magic number check during s=
ignal return").

The aforementioned commit broke applications that construct signal frames in
userspace (such as CRIU and gVisor) if the frame's xstate size is smaller than
the kernel's fpstate->user_size.

Furthermore, this introduces a critical issue for checkpoint/restore tools
like CRIU. If a process is checkpointed while inside a signal handler, its
stack contains a signal frame formatted according to the source host's xstate
capabilities.

If that process is later restored on a destination host with larger xstate
capabilities (e.g., a newer CPU with more features enabled, resulting in
a larger fpstate->user_size), the kernel will look for FP_XSTATE_MAGIC2 at the
destination host's larger user_size offset instead of the offset encoded in
the frame's fx_sw->xstate_size.

This causes the magic2 check to fail, forcing sigreturn to silently fall back
to "FX-only" mode. Upon return from the signal handler, the process's extended
state is reset to initial values instead of being restored, leading to silent
data corruption.

The aforementioned commit cited

  d877550eaf2d ("x86/fpu: Stop relying on userspace for info to fault in xsav=
e buffer")

as justification to stop relying on userspace for the magic number check.

However, these two changes are fundamentally different. The last one only
changed how much memory the kernel ensures is paged-in before running XRSTOR
to prevent an infinite loop. It did not change the signal frame format or how
the layout is validated.

Reverting this change restores the use of fx_sw->xstate_size for
locating magic2 and restores the necessary sanity checks, ensuring that
the signal frame remains self-describing and portable.

  [ bp: Massage commit message. ]

Fixes: dc8aa31a7ac2 ("x86/fpu: Refine and simplify the magic number check dur=
ing signal return")
Signed-off-by: Andrei Vagin <avagin@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260429000623.3356606-1-avagin@google.com
---
 arch/x86/kernel/fpu/signal.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index c3ec251..20b638c 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -27,14 +27,19 @@
 static inline bool check_xstate_in_sigframe(struct fxregs_state __user *fxbu=
f,
 					    struct _fpx_sw_bytes *fx_sw)
 {
+	int min_xstate_size =3D sizeof(struct fxregs_state) +
+			      sizeof(struct xstate_header);
 	void __user *fpstate =3D fxbuf;
 	unsigned int magic2;
=20
 	if (__copy_from_user(fx_sw, &fxbuf->sw_reserved[0], sizeof(*fx_sw)))
 		return false;
=20
-	/* Check for the first magic field */
-	if (fx_sw->magic1 !=3D FP_XSTATE_MAGIC1)
+	/* Check for the first magic field and other error scenarios. */
+	if (fx_sw->magic1 !=3D FP_XSTATE_MAGIC1 ||
+	    fx_sw->xstate_size < min_xstate_size ||
+	    fx_sw->xstate_size > x86_task_fpu(current)->fpstate->user_size ||
+	    fx_sw->xstate_size > fx_sw->extended_size)
 		goto setfx;
=20
 	/*
@@ -43,7 +48,7 @@ static inline bool check_xstate_in_sigframe(struct fxregs_s=
tate __user *fxbuf,
 	 * fpstate layout with out copying the extended state information
 	 * in the memory layout.
 	 */
-	if (__get_user(magic2, (__u32 __user *)(fpstate + x86_task_fpu(current)->fp=
state->user_size)))
+	if (__get_user(magic2, (__u32 __user *)(fpstate + fx_sw->xstate_size)))
 		return false;
=20
 	if (likely(magic2 =3D=3D FP_XSTATE_MAGIC2))
