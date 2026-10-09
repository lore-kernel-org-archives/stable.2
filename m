Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6776C3CF1E1
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791579907; cv=none; b=P/HllnelVyj7SHxJH+0RW+SS3X+zbNhGKirXOh12ly48ft9k/8sxltycN/tMYbDg9kmI6nPQFLBIHf1KBTMCOuLrn4YrjwPnh6djkpxw//DG2FltSgLtWetV4RF47A4I3CBoR2JYIZs+u2tshFmwJ1I5nBl/+fCLQF6N4nv6pBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791579907; c=relaxed/simple;
	bh=o8NInYcacEBtJJYkNL8A9Y89bhP4iWvTh0eJqEKznrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYQ9PobexY8YMGsu/2maWXd8AglH7SqV9rXueL204xyZsgMVjSYMA/jNWj5hG30CIOdJg8iC2B7Ae7/VknDeQOke374NcaGKMoxPSmSyF/RF1V/XkfYmL+1/1+R2DrSDmqPK79sYFzjImCu+Pq+3huEYWHlcHGqSqvKio17xWZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqnITw36; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqnITw36"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c2acc1e170cso42506666b.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 14:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791579903; x=1792184703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zyFOrqikvwTJb07hDdL2TG/8R+pB8FRf4xqb8xkWNGQ=;
        b=fqnITw3624WzRpmFASDoSxadJtSdLNy4IxNd2r1X5C2hOBbZLYClJFbCNMFCnRz5ec
         S6WUuk1xJIQCgQZG93aMO4ua8hdps5+8r5bIZgTswT4+f4J+Ne68/VBZ1hmAB5OUDnqv
         RHEE7RbNNrBNDJANgSJzM4k0iLQYnuWXshsCP8NpyDZamY9aj8zjF0ELohDjQRBk6eDw
         HvTPe0ZHpQejZmyfKbIIgxFe78DdyV5I0lxTTyHTknDSOOdYFmT/K8UT5dhfAlJi4EcV
         i7oakEwR/zhpGmPkyu+CIupND6vi94lHWPy7YSJVqg7xnuFoYVL9Ts4ULjZIElLBnprw
         kaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791579903; x=1792184703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zyFOrqikvwTJb07hDdL2TG/8R+pB8FRf4xqb8xkWNGQ=;
        b=qorXLYXTLWmuvknChT/XxC3ESyMGdDu8N6+V4p45CvuNzCRPOc3t3S+RKwihIBo4qw
         e0SqAmqkXWMsd+O9eDMdeWnuMmsodPwfdqziDlieHkqzlKmyxMgMqbRvsjt+10Mys7qu
         u4rsnSRsRQQaj5qsdAO0bT8dVSqMG98F+6lF5bSNv9ut+L5gitarrBb5iH+323JixEpY
         ZSt5JxLS4JLAjkdgCT5edmKD+3sb54B34HngYSbQAfrg2sXGb1qtuC7mbUDmqKlSNPZn
         gFLWX2G/+bjLJ/+lJLsS7zRju8Lg6TE/dZkIP5R39rL4f4lnYq2sv6AURHmMG7PnWKyI
         ylEQ==
X-Forwarded-Encrypted: i=1; AKwUvBzGLNMflk5RNZIggPKnQKIQbv3jp28Oknx1xpmW+Y3jRY9JDWmlkiSJCDMlB7kjpcUW1Hvedmw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJheK2eu2k1UaXxJR06qL1uQZmtDE05cqetwwVe4gQe1gdfSozk
	M+f7rLI3+wWot8hKqac1VjLuXyIyQCv0hVlq46W1KNpwSl3kqJ96zOoy
X-Gm-Gg: AYBFou1Mn0h5lsXYuWpYgZNTfokzA3AAEoO2EcmL8slQUKR/VjhS2IerzpQepbS3WEh
	ASCDIu4U3F97kBxa1YPJTm0BCuVnqSuoT30lxXGwwc5TxwAenFuVm/r5uebqK635qRbklxlyC+O
	hCqKrxLLbcBTd2aUrgb6N2MbYh3EZBveQ2wKZ5+T4NPGlwfZRff+uNPmKG1OvPeec1rCDq0nhZ6
	UHjfbSaacE+Y6UgRa69fdVjzWUMDYjaQcYqj+y5psmzLsjtNaVgXB1nGuNTXytyZHLPLfVrnCxb
	yWY7hNolHZ1V3mma9H82vujyf/PyZBn+iJyg8wcqDtDIsnn23uL90svAzJbSUzpv56JGDDOtRVt
	YbYwy44UzESalQMpwqjxJsOwQecnpEPV1lfjh6u6p4hLwqkvnytkISbMGL/Zag55KMuSJvBFDG9
	QRQb8UM5et0P2e+1D9F8lCv/k7f+AU9iq4XoMKiz4AlcXUvtYgz53FX6tWBgTzV/3eBMbwZxJwb
	g3ag3037T2rQRIq+2QFHhxCDJG1nyzK4oTaQJp9
X-Received: by 2002:a17:907:94c2:b0:c2e:9034:138f with SMTP id a640c23a62f3a-c31aa0d3522mr342370966b.47.1791579903393;
        Fri, 09 Oct 2026 14:05:03 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9765d1asm142141266b.8.2026.10.09.14.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 14:05:02 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v4 2/8] alpha: run check_mmu_context() from finish_arch_post_lock_switch()
Date: Fri,  9 Oct 2026 23:03:47 +0200
Message-ID: <20261009210449.971057-3-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009210449.971057-1-linmag7@gmail.com>
References: <20261009210449.971057-1-linmag7@gmail.com>
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
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/include/asm/mmu_context.h | 11 +++++++++--
 arch/alpha/include/asm/switch_to.h   |  1 -
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/include/asm/mmu_context.h b/arch/alpha/include/asm/mmu_context.h
index c5cf7dbe6161..e5a5737506db 100644
--- a/arch/alpha/include/asm/mmu_context.h
+++ b/arch/alpha/include/asm/mmu_context.h
@@ -161,8 +161,8 @@ ev5_switch_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm,
 		next_mm->context[cpu] = mmc;
 	}
 #ifdef CONFIG_SMP
-	else
-		cpu_data[cpu].need_new_asn = 1;
+	/* A deferred shootdown can also invalidate a newly allocated ASN. */
+	cpu_data[cpu].need_new_asn = 1;
 #endif
 
 	/* Always update the PCB ASN.  Another thread may have allocated
@@ -191,6 +191,13 @@ do {								\
 #define check_mmu_context()  do { } while(0)
 #endif
 
+/* Alpha has no kernel preemption; these callers cannot migrate here. */
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

