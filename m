Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0668332604
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390272; cv=none; b=Ivr3z9XXWJQarf0Bd5c7MiaHrECvwQVp0SWm6sxsZ5zjxtQmHD8PeoajurmllRrCWOppRR/E0iX9D684VLZ44oIBww1oHf1lq8vxhTnDwsRmn6hF80IGWZA09EaDA0p5YZWHT4ZOcM4M9YIUWBxNNRfIX1Au20Sfi/396Xv23kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390272; c=relaxed/simple;
	bh=n200ToFg5EwfKmNuCsFI6CMDFlbYYSZX1PogO4tpe38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SG7hOd2VmW6VlLTNL28K0slmazHak5lqh+z1Rhr+d14sPP+dWCDA3P4TMAXRhx03050RjtjTTDn0aicKVdVSTZgc8kCMFZNJdxSLz04vOjaOCbDyl8+TJicNhMwXzdWNnbpERAjr8+ykJPIY7wbpaupCy/D+nIRGwANcx5MSaEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpL/yhSw; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpL/yhSw"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a18180so3419597a12.0
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 12:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390269; x=1786995069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QZEmNt2xvk8DgVJ1haHknaJRViHX9desP4cc5qWqOEo=;
        b=UpL/yhSwbYDNRhIjL1i+5QBsxaaOr76ywbf/RlZAs7zqUSGddXFSMwFBIl0siNNqyu
         8/e7vN4Wf/mT+s8IP3O3LPY/k2aEZO7q+nvDAJ4LSgvQcT2PZXzaMobDypl/t1Dur+x2
         0Jc2btYv8YaI+ZZK03yZDA+5LkCTAw64CAPB46oijJNtURlBWQttc+6HG9Au4IcfQ6cl
         c5DvU7tknAxQf/XmJbQ3+iYoC14CAPgTOkU3AURnjdvH66nw4idb/7xSw4oOafwIspzB
         lLKV8hAJBKa7eDdT8NufBMi5EqI/YJeTrAJpUpvWR756CMZsmleeUEKp5HRpRvZVAAfh
         JkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390269; x=1786995069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QZEmNt2xvk8DgVJ1haHknaJRViHX9desP4cc5qWqOEo=;
        b=PwuaW+EJLJSgLSnjxkBMsIQu2W1gs/AGMNlns9+NDTYrQBJLwVQ+OgDaFcwRWpSqCw
         61C2CldH3zbVPranCBsvxz7+wKX+JN4Vn3VoaOiLk5zWMGuCrRDAhVyPd9M+7S7kMWRg
         yfV1QXBlJAAs/AnXq8Y1e00952BcKqCa/0r5PBpZXUjr/DwUe2RBmCLkGhepVveQb0oG
         hADe4e5GKSpeVxL/2cVuGJTSgAZQRLY5qFKUQAgpDHgll1SpB5XJIgaDSnil/olR8r9H
         dCKFEpqzC04aplmyiI7F/lz68cqELoMS5DXk1xxVBqE4mjSIShJIg0hSGnEb5rceuqp9
         Ko8Q==
X-Gm-Message-State: AOJu0YzzvCQ3IIdva2TS45bVThAJaBFNZvswR8wBfJ9Eu38iqLuBFM1c
	9cXiukkq3U4guj41na423utUNM+pVvzcOJqBdNJmMSyEhOAiWmXW+zmrmC7wmXIF
X-Gm-Gg: AR+sD13OZXj2O8z2JiXuOGicjoaCgb/pvCLEJIzO03fwaCPx1wfsLSD6fkh0FiiVZFv
	CUY9huuHmVNqwRluZnIHVUg3/HNL0wzMS+A/XzupMHy+KxP2GeMh7ncnHVcmuAikEq7+bew2nhL
	VRnM0xJf2TE8pF0I4qltWC4cMMMQFrrfkv2CbRLwknu8wKfD59zPttD0UqRhKKhRvrMr+RVzqkX
	PwyFStzUWU7bFMSiGPGGO1zJSkUkT0tyj1hAJ5HMv2HwoOV0u9ws/q+73ny/L9X5/dJQQRYmqxR
	7GW7M13mw05ekZR7+52iZm/cPzA7ijAdEOZxQ9Tw22suABCtfbpazZ6Tk3mP2L2vzLF2tS+E76I
	51BOI+e2dYDpGrn4dsIn3FRFXd4+N6JwUD/X/Xer4SFB8DKA/96HwJHBiFc90szh1BTkeBp7wEy
	G70JOkpuI6/SRWzfUuPLsiFmBTetV8z1k308YaPZmEjkO68enLMUres78s6cx21TFro1+1GM3q+
	nTSfvhShsXMZAh7heNGGcQPIOyI8GI=
X-Received: by 2002:a05:6402:538c:b0:697:6417:ce7 with SMTP id 4fb4d7f45d1cf-6a1e5afe932mr12303875a12.11.1786390269018;
        Mon, 10 Aug 2026 12:31:09 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a1f4df3165sm3665532a12.10.2026.08.10.12.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:31:08 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: linmag7@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH 1/7] alpha: run check_mmu_context() from finish_arch_post_lock_switch()
Date: Mon, 10 Aug 2026 21:24:45 +0200
Message-ID: <20260810193055.3286239-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810193055.3286239-1-linmag7@gmail.com>
References: <20260810193055.3286239-1-linmag7@gmail.com>
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
rather than naming particular callers.

One consequence is worth stating, because the TLB patches that follow
depend on it. After kthread_use_mm() the hook does nothing, so the
asn_lock that ev5_switch_mm() set stays on that CPU until the next real
context switch. A borrowed mm therefore has current->mm set while its
context is not loaded, and the shootdown handlers rely on asn_locked()
being true to take the conservative path for the whole of that window.

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
2.53.0

