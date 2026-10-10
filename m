Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31DA49EC76
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791642350; cv=none; b=HJXEvakB01Phju6gWrwEL4NHCSrc0VwkoB7x3ca0mBt8guHZX/dYzcPNXpKOks0BL5ueS1FIcMkEsp79DkpjL2GoukKmDETUFnhnJ/9HkjRT9udOaq3KBfgl99Vvrdrz/iSt90s2HP1rcNaagDmOcgVRDRnQVBU1s+GKz3FXOwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791642350; c=relaxed/simple;
	bh=9ypQxSCPJGLXlWd5dhzalcKsTjSW0YYrWgnrxVKaaSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1hztGLVEoojyrgalouM3CMo6jiFEPKi9dmGKWkWHLG9mPMMWJVauw1dZV13IZu/HCsxG6esMy3b55yvhILX7LdBBT55IZxaKd9w/SvD475GyfsMej8tvVjF+V/AID2JpGyqTO2VjVbzrsGMtP+jzVhsAU8GKJ6brwQF8dQZ8sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRtAM4vU; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRtAM4vU"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6acba4bf65eso752514a12.1
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 07:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791642346; x=1792247146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/SY31IwQG8K0FMtEN3imdz/ZZUjyZiV853x9as1x0tI=;
        b=VRtAM4vU3NZ7EdDkzycZyryjclAfs3t0UBJb1FWp7Mf0fZq1Dfwq2XhaooToPJeRs9
         H7ePPUgJhTdziiZ0s+3w9if9ZvGhLOZImujStJfSga8Wd/oREO59MLrwR59VO6ybwv9Q
         w0ijictQJtbmoBIDTD8KgoGy4Mh7wbspWwc+I8kgtTMOU70gEqM0/UBbx+oDodN4iczp
         ThdeQFJnzYxteMq34KG8yLf+m+GHznZHzLdgnKXuR/Z6DpWXv4ApHGozx8I2GfiLMzmx
         u6D75RpiKfmcYvv7VSJDl4VaobJZ5BG8Mbn5p1yQy5yt67Wv/mXNMLY4LQ13IxywbbN7
         W44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791642346; x=1792247146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/SY31IwQG8K0FMtEN3imdz/ZZUjyZiV853x9as1x0tI=;
        b=bvKrkn7Tv7cSHbQGLZ4kaukDeEZQiD7MCRpCnJVdByx/Xx/amIsTG0WKYYDrAT0kxI
         rKVUAf6OGPr5IBkfXItpamfCAufcFN+dnSVCc5Al29sI77nypqnM/AJtWJQvuDoyp+VN
         CMybpx+1xWXQdlY4taWaBONuvLRGLXtxuRqt5/+ve30cNwXQWL/ntvmrWgagXDIom6AY
         6+wuQiA6FTvG6RA5wiz0mbah0C/X3Gne7gIjkcTHelx3A4/WmRbYNK4rvflPsPQC6LvG
         Ag2CrIZN4PmUjxYfmfMVc9SUwmcnPKLaO3OSIa9dXxjth2kvlJBhvBb3XocxXp8EvzZn
         kVOA==
X-Forwarded-Encrypted: i=1; AKwUvBztHJ9bXmFevb+MH11nDI/QjKyngUgN0vA+y0kk8ne3wGoGp78OT7TB1y4wl5ZpeTzS87xQov4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLU/gIriX4Jty6Gu9Ui554Ol8Atfp/S9C281y3zL2qhiCaMJeuk
	FvMz/ElYDhVowuHz25e8XAWBsM3e6GyYxOU32/UjqYXJOBfbvHhXBWYmkhUblP7P
X-Gm-Gg: AYBFou0vSCHewg7IhHZIMBWUVlnfdRMNHXt67t0hI3IeRpnmaB2matO2nTk+ZL38G1l
	1Q13RG9Wbvi9pZGzPMwH808rjr+xTlknPAg+z6AWJN1d6o2NhjDKCkgpZjhSaSimWLtnxFZP4Bw
	FJiAbt8ZtahDB0xiI1xteV3WBOAXT6ZdqHxSAuyvbj/JKWP6tVE2fKSVx+xHJAE6NVtaINBii9d
	MRBngAbAFbjQ1j2oFGph1u2RA+u3g6raT2leL/ZFsZlAmCl9N6kN9oa+74arYxntDkAQl2+wDky
	FT1O31gKhtCRflPdCxeRUk5hNqUFZX3tZ19ZGE9KvwcRss7dvswP7ozWPYROm1Kj3EqzpphwtzQ
	w7CPmn8GrHeFlsnvB0xFH0I84+1Tu04sbz7bUH336FRsBSn7KOeN7E2XYLvEGF4RFoWiv9ZbEVT
	aOvfFcbs5LWvo6ABMLd6Izzh916m+pzlnFa69fk+kk03K1rjea2SFpRf5LjGksuaAbOavNxhf9J
	UMoxpXFD4b0xLKB0kjfMhK3VEfbCH/P5LW74EIt
X-Received: by 2002:a05:6402:2812:b0:6ac:6fe6:b391 with SMTP id 4fb4d7f45d1cf-6b17c24c8dbmr4320358a12.18.1791642345707;
        Sat, 10 Oct 2026 07:25:45 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b179dfff40sm2635586a12.34.2026.10.10.07.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 07:25:44 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v5 2/8] alpha: run check_mmu_context() from finish_arch_post_lock_switch()
Date: Sat, 10 Oct 2026 16:24:28 +0200
Message-ID: <20261010142533.974797-3-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010142533.974797-1-linmag7@gmail.com>
References: <20261010142533.974797-1-linmag7@gmail.com>
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
at ret_from_fork and reaches schedule_tail() without returning to the
code following alpha_switch_to(). New kernel threads take the same
path through schedule_tail().

asn_lock is left set on that CPU, so the new task can run with
interrupts enabled while shootdown IPIs keep taking the deferred path.
The handshake meant to complete those invalidations never runs.

Move check_mmu_context() to finish_arch_post_lock_switch(), which is
called by finish_task_switch() for both existing and newly created tasks.
Drop the now redundant call from switch_to().

The hook runs after finish_lock_switch() releases the rq lock and enables
interrupts. An IPI arriving before asn_lock is cleared retires the slot
through flush_tlb_other(); an IPI arriving afterwards can flush directly,
since PAL_swpctx has already installed the incoming context.

Set need_new_asn whether ev5_switch_mm() reuses or allocates an ASN. An
IPI in that interval can zero either slot. Without this, the allocated
case can return to user space with a live ASN but a zero context slot,
which a later context-based shootdown shortcut could mistake for an
inactive CPU. check_mmu_context() reloads only when the slot is zero.

Call the hook unconditionally. Alpha selects ARCH_NO_PREEMPT, and neither
kthread_use_mm() nor sched_force_init_mm() sleeps between the direct
switch and this hook. RCU_STRICT_GRACE_PERIOD can enable PREEMPT_COUNT,
but cannot make those callers migrate there. Testing preemptible() would
only leave asn_lock set in that configuration.

This requires the preceding direct-switch fix, "alpha: load the MMU
context when switch_mm() switches the current task". It installs the
borrowed context before kthread_use_mm() reaches this hook, so clearing
asn_lock cannot expose a targeted invalidate against the wrong context.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/include/asm/mmu_context.h | 15 +++++++++++++--
 arch/alpha/include/asm/switch_to.h   |  1 -
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/include/asm/mmu_context.h b/arch/alpha/include/asm/mmu_context.h
index d366f89fee58..f41d7c73fdd6 100644
--- a/arch/alpha/include/asm/mmu_context.h
+++ b/arch/alpha/include/asm/mmu_context.h
@@ -162,8 +162,8 @@ ev5_switch_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm,
 		next_mm->context[cpu] = mmc;
 	}
 #ifdef CONFIG_SMP
-	else
-		cpu_data[cpu].need_new_asn = 1;
+	/* A deferred shootdown can also invalidate a newly allocated ASN. */
+	cpu_data[cpu].need_new_asn = 1;
 #endif
 
 	/* Always update the PCB ASN.  Another thread may have allocated
@@ -192,6 +192,17 @@ do {								\
 #define check_mmu_context()  do { } while(0)
 #endif
 
+/*
+ * Also called from kthread_use_mm() with preemption enabled. Alpha has
+ * no kernel preemption, so the task is still on the CPU that ran
+ * switch_mm().
+ */
+#define finish_arch_post_lock_switch finish_arch_post_lock_switch
+static inline void finish_arch_post_lock_switch(void)
+{
+	check_mmu_context();
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

