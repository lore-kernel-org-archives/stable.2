Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773DF395AF8
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149774; cv=none; b=TAicyC7ZahfysHa00PXVaqwmufcMvlHgiqivEjP8xGc5v0DKgDpHFXI7obePcu84cQ5wL3u/raB+OwCKty1RvInDQJwxdwSuc/0e0j7rHVAP/OJJFcVrsH1i8d7dmQcZnYLu8AL4H/HHt7N/IPKWSAoObPF1JhNglLv+x8eBoL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149774; c=relaxed/simple;
	bh=oARr0eCnkCHD+mROeY0dJ5/jgnSvSWjzHoHE0F6KYCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyCI+pnEFo8VXTLRJS1RRtEeXjlqP9QO/KG2YmKtlqLMLB+eSXencyXgDSxTw5OnfrmimCfgcQx/5twU+9n5ohgFA4xG7XJAGbu5PKOapMOhrXFMzm/1Eu/Bt5pgAZuD5H3mua422QGdnoc/v1IY2fwQibOmGSTQYhvJ5zwVPvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REMqsnLK; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REMqsnLK"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c294af0caa8so77351966b.1
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 00:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790149769; x=1790754569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wYqHLogoefTeHvs40y0M445o7+VTYO/XqvtDAqNdSwQ=;
        b=REMqsnLKSwRpliWPUH3/WXH8AW8mwfMNSDNWYwa+uj8WJN3Ph1kFqgJz8kPYBuzDlB
         zSajIIMRXhXx07wFlUZ+QbRm3HiS7Mb1kKfBePPFVMzEl0UuYsFVGhNKDLZpGYrd11G0
         dXW6+Z0wTNCyaroVxs4sx7wNSUpcMXT53jtpPK53jI5oLvwa5+kf7FCpePL9uGorRYF6
         Vga6B7xqvmBjDO+aUlgJ9OxgohaW2ylmgi4OwBnh1/HP9B0+7mphhxFmi3zqaw5IdVLE
         zco6QyASidNMbRJTjWcdc8tvwRcT0rAyXFRJgkDImFDCdGELtLVPGUTN0UzPeM13YMT8
         3vSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790149769; x=1790754569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wYqHLogoefTeHvs40y0M445o7+VTYO/XqvtDAqNdSwQ=;
        b=MYI4Zd5gDu8jlqPaXzXYXs5g0JpZLl7d6EF+y0g3vkzgkkHrn0blA0ptD0GI9hvoPx
         fyTCsSYRdl2YvDQp1H7sRgukoNCsPIG69S74YIGk43xBdZdASw5o0DHbPwdI/9LfROBk
         hOkY/7BTDrBIWjDNhcaWmIc6IQ+MHOw/gumlJYHEsRpRnF0pLpXObso5B98A4ceOdCIs
         3wbms+bdjUdAkAd8adafcZaJa95ez//F/Vp/eihOzY/Q1MNqMPWFxOH635v2ddWUdxNv
         Er4q+Qpx5Ly1m16iEUMYMi4PGw5UUf/SFSv25aCBKsEQWhXRFMCYW5W8YIjn/hjtqHOS
         9V2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxFKcgqybmNxH8AfP7y8X/uWjTmfdw0jFmTIxfRtKHMwpaJXPB7EppxnKPQWQYCsdL7UmZn7cA=@vger.kernel.org
X-Gm-Message-State: AFuF++lc9t8mCqxh254lHy9INxKY6BO4JPVDxfHV5/Vjg9OyKeKauTsE
	ov+0a5Woss1QAmT1JSWdON146QiqsJMiMZddi+vUu6Ft2yRNc/nONTyl
X-Gm-Gg: AYBFou0/p4O8+9YEH6GAqsSZ4L9XCbt+oqN4yFqUf6aewHCbHCrYaKPgFyNb2urynqa
	NQ3HXHoowp5HigLhdW/2oHPVUOVmwetii8meYfxUVdLQvXFTY3l0fmlE98M6UGnShsPNqAhmBG4
	Xu1CvRHEbdn8MrUR29yyxBTdxcHgWDpaxzrINOKrcXWc4e/FWfQXMerSuza9T/01ZoOx8QgsKUO
	KN6RtC9JBFpwj3F9E9vnXhzvbiRu0CoU2fJqF7SfB05OnMX6LQg7eKyNTD3MCDMsx62VIWvIM/q
	okADQET99fZr+wS96j2dZubO8OCPVSAlc5RRYagfh1glXT8v0SKDz3clLmZqUXfGB9olRSdHTwb
	mpUib1j/8zybfRHdsQhFc4bbXMQh5va/8BslLsL+ctdOL37z3MA7e3T8A9fryhcqBZ2WrND8q/6
	vKQJVgZ7LRiCIbSPeHarncHGJ/9ajiPw8MTArs37WGeq7pNJAhaFf/BicY+NDOsIHA9FfbNdKRl
	kDf0kz5l1SxhFzOBEral8vX/s24VcmgickZ3O/D
X-Received: by 2002:a17:907:d23:b0:c24:47b8:ae5b with SMTP id a640c23a62f3a-c2aadf60e74mr132300666b.22.1790149769310;
        Wed, 23 Sep 2026 00:49:29 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c6f5asm64951366b.15.2026.09.23.00.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 00:49:28 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3 1/7] alpha: run check_mmu_context() from finish_arch_post_lock_switch()
Date: Wed, 23 Sep 2026 09:47:44 +0200
Message-ID: <20260923074903.862898-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923074903.862898-1-linmag7@gmail.com>
References: <20260923074903.862898-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_mmu_context() clears asn_lock and acts on need_new_asn, but it
runs only as the tail of switch_to(), after alpha_switch_to() returns.
A newly forked task never gets there: its first context switch resumes
at ret_from_fork, which goes to schedule_tail() and then to user space
rather than returning to the code following alpha_switch_to(). A new
kernel thread reaches schedule_tail() the same way, through
ret_from_kernel_thread().

asn_lock is left set on that CPU, so the forked task runs user space
with it set and interrupts enabled. A TLB shootdown IPI arriving in
that window takes the deferred path, and the need_new_asn handshake
meant to cover that never runs.

finish_task_switch() calls finish_arch_post_lock_switch() with
preemption disabled, on the CPU that ran switch_mm(), so hooking
check_mmu_context() there completes the bookkeeping for both. The
existing call from switch_to() then becomes redundant, since
finish_task_switch() runs immediately afterwards and does the same
work, so drop it.

kthread_use_mm() and sched_force_init_mm() reach the same hook outside
the scheduler's preemption-disabled switch tail, where the CPU may have
changed since switch_mm(). check_mmu_context() acts on per-CPU state,
so testing preemptible() expresses the required condition directly
rather than naming particular callers. alpha selects ARCH_NO_PREEMPT,
so unless something else turns on PREEMPT_COUNT the test is a
compile-time 0 and the hook runs everywhere, including at the end of
kthread_use_mm(); it only takes effect in PREEMPT_COUNT builds.

Moving the call changes when it runs. switch_to() ran it with the rq
lock held and interrupts off, while finish_arch_post_lock_switch() runs
after finish_lock_switch() has dropped that lock and re-enabled
interrupts, with preemption still disabled. A shootdown IPI taken in
that window either finds asn_lock still set and defers, or finds it
already cleared and flushes directly and by then PAL_swpctx has
installed the incoming context, so the direct flush acts on the right
one. need_new_asn is only ever set while asn_lock is 1.

It also changes one case for the worse, which the series that follows
does not fix. Before this patch nothing cleared asn_lock during a
kthread_use_mm() borrow, since check_mmu_context() ran only from
switch_to(), so a shootdown IPI for the borrowed mm found asn_locked()
true and took the conservative flush_tlb_other() path, retiring
mm->context[cpu]. With the hook in place asn_lock is cleared when
kthread_use_mm() returns, so such an IPI instead issues a targeted tbi()
against a context that ev5_switch_mm() prepared but never installed, and
leaves the slot valid. Loading the context on a direct mm switch closes
that window; where both changes are applied, that one belongs first.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/include/asm/mmu_context.h | 8 ++++++++
 arch/alpha/include/asm/switch_to.h   | 1 -
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/include/asm/mmu_context.h b/arch/alpha/include/asm/mmu_context.h
index eee8fe836a59..825d3b9605c9 100644
--- a/arch/alpha/include/asm/mmu_context.h
+++ b/arch/alpha/include/asm/mmu_context.h
@@ -181,6 +181,14 @@ do {								\
 #define check_mmu_context()  do { } while(0)
 #endif
 
+/* Per-CPU state: only safe while still on the switching CPU.  */
+#define finish_arch_post_lock_switch finish_arch_post_lock_switch
+static inline void finish_arch_post_lock_switch(void)
+{
+	if (!preemptible())
+		check_mmu_context();
+}
+
 __EXTERN_INLINE void
 ev5_activate_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm)
 {
diff --git a/arch/alpha/include/asm/switch_to.h b/arch/alpha/include/asm/switch_to.h
index 762b7f975310..35c4b2c9d992 100644
--- a/arch/alpha/include/asm/switch_to.h
+++ b/arch/alpha/include/asm/switch_to.h
@@ -9,7 +9,6 @@ extern struct task_struct *alpha_switch_to(unsigned long, struct task_struct *);
 #define switch_to(P,N,L)						 \
   do {									 \
     (L) = alpha_switch_to(virt_to_phys(&task_thread_info(N)->pcb), (P)); \
-    check_mmu_context();						 \
   } while (0)
 
 #endif /* __ALPHA_SWITCH_TO_H */
-- 
2.43.0

