Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1F33A9601
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 19:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791489386; cv=none; b=Cs1AlXmE7b+45J1ZTpBxpqXoStAmKrpFZJa5yJ8urI8j7O1KExXdIALKYCuSo18yH1Kdw7ICcU8V5L0RPncsLy0THMFEQtR0I34ptz/1S3jbYG5E4nfNw82DQbArcWrVXmJEsHV9I6sxKhQkYV+zSYI73cZwGoTGJNxS5+Ig3o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791489386; c=relaxed/simple;
	bh=D4K0GXojNGjvr1AbkeLUSfw3kOHSP/1aVzKIdo8uIlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/vdfb/bfFgyPV8bM2jSeAv3RmSaIggp3xTyT0gtYqpHDRrGCUCVE09Lay4Qt6l+P+bZuoANtw4NjcSP6OUSaQ0fpeoUk5pOiweplFtAEE7LJwGyaanQl7AM7V+UGHGeY6pxJOptX6xwYZHUn1WLFJNMSty3WF38H7KL7nYmOQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2c58+hO; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2c58+hO"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2e8e738ae0so535854266b.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 12:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791489383; x=1792094183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t+pnQvX2Ln0ty0BBS0HTGOY5DxdQhaFsMGL4gqOpSC8=;
        b=H2c58+hO+MeT+WYg40PyuKLvPskqg/GChmtqULoKDXeR2S7Zeq/1S11AOHu8ipXvWZ
         o1b0qjIhvw67Zlg1UrGiMzhgcXuJDba0T8zovo0r8eBeW71i7eqI0vp8DNztKXoZHgup
         ue2KfjbP7OL6pJPL9d0yxLgAbWo9n53GRr8Qw0cYROoAEg++gm6idHgAM50dqPP16lc2
         VJaaLy0RJKMYCVRIYLgQhFiPtXpo6JPc/IgOHrQu00fIKR/JglYL3pBnINYul6XJqYxZ
         tEXfvHYHK/ASfEktQ+BUYCPIzCad+3sTkMLsAi+LmPgN64uyHcYxtTE0hNg+FVWOEQ8n
         axgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791489383; x=1792094183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t+pnQvX2Ln0ty0BBS0HTGOY5DxdQhaFsMGL4gqOpSC8=;
        b=bmnj44YQmWL+UAPvx0UBB+TdM3RFzYIK+ZRGGdKnoem9/hRTSsX/DaSmEMWtmmZBjM
         jDQEfg65xVC5FAS00iHsJkRFp1H2ocNzpnyEWEGIYCuBNkvDHb8oT8BM1ySDitg2pIIC
         VyUCqvjqpHqMdPhEY3en04QFlWY34gcHszJdl96rvRVPvdjE88QeEQLHX6vsMirgBjPM
         SnwHP/X45QsqwULWv26kpISzGWshOPu4Q0wbtmYjCuMAU9eMFbDxyeHh/fuL8eBJ9CMk
         MpvoR5tRokPsEQIfIk4ub+Xne6fmB+wkcNPUGdOWX27If2zKT60tp+AiXMQIHkyvo2su
         s2MA==
X-Forwarded-Encrypted: i=1; AKwUvBwjpFH806zLfscgWbEPPgiUmNUMZk33VUp0XBSWubEKeGn25AlHGeihutAztzdO7NI6whLT7bo=@vger.kernel.org
X-Gm-Message-State: AFuF++neDWtWso0P4Pc4gnWyJ7l4rtrlfmvDLhvVU7a3f8q+8wCBqZWV
	LsDR0R6j23kONEFoWaKCMSDCBBIOGJMtSwhzQ99lJlrrfsiEo4DTMIos
X-Gm-Gg: AYBFou3NBhrq34yUQGB7ePsn70JwfIAY+RPyIqLXy/aC0t2temP54mBKMxS4V8Q2rZm
	E+Skzm/DdOd/DScw5iNkBSe8lKFMpQBCQW3bBydMr5RtSLmNiWnFDnG93bQtApWMNYRwWRDUI/Y
	x6NYwziLSONxOKnBJRvgQMamGVTDDKLQO2IpAA4QvwgTQ7PiJSYuBUyYfmqndQjGYzq76ZS4YRy
	6s8rE71OsF2lcDz8BrXCQN+sZ5Xrms987x/YwOex1PiWin9LGamd7ww0tTnBPBMozLgsB6yXuZw
	dWmmru2MeIBbBMBt7DwFqCcmdApxHe3IHn3fxl4TobmYYrJvBWVu2MRExlAQ76tNo3hyaxItZ9l
	s7LcZKzsV7XQMpn4IFL6aWSGEDS2hOSrVXInWRR03jnQ/udkTMRYnR+s7fleeajxz08veXB5w+e
	wmE295rShoZAvAEq5/fVudZ5yinUgel2pVeKexZEg7QgC9z+1TtCnWbR3gJGqBO6cuOOv/hx10F
	5McTYWzRYp06expgiVFQ3nfOnRauaqFB6Ksh8vl
X-Received: by 2002:a17:906:c106:b0:c2e:2fb6:ff37 with SMTP id a640c23a62f3a-c317bdb14fbmr630342466b.21.1791489383297;
        Thu, 08 Oct 2026 12:56:23 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a4d0c2efsm9906266b.26.2026.10.08.12.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 12:56:22 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] alpha: load the MMU context when switch_mm() switches the current task
Date: Thu,  8 Oct 2026 21:55:16 +0200
Message-ID: <20261008195608.965266-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008195608.965266-1-linmag7@gmail.com>
References: <20261008195608.965266-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ev5_switch_mm() only prepares the incoming PCB. The context is installed
by PAL_swpctx, which alpha_switch_to() issues against that PCB on the way
out of the scheduler.

Two callers reach switch_mm_irqs_off() without going through
alpha_switch_to(): kthread_use_mm(), which borrows an mm for the current
kernel thread, and sched_force_init_mm() on the CPU-hotplug teardown path.
Neither explicitly loads the context, so the task can carry on running
under whatever was loaded before while current->mm says otherwise.

The stale page-table root need not be swapper_pg_dir; it may belong to a
user process that ran on the CPU earlier, and the kthread's user accesses
can then read and write that process's memory wherever the stale mappings
allow. Translations taken that way can also end up tagged with the
borrowed mm's ASN: ev5_switch_mm() writes that ASN into the PCB, which the
next PAL_swpctx installs against the stale ptbr. An address the stale
tables do not map faults instead, and since do_page_fault() resolves
faults against current->mm without reloading the context, the same access
can fault again on return.

sched_force_init_mm() needs CONFIG_HOTPLUG_CPU, which alpha does not
support, so kthread_use_mm() is the only one of the two reachable in
practice; the fix below tests the caller's identity rather than
special-casing either one.

The scheduler passes the incoming task, which is not current until
alpha_switch_to() runs; both direct callers pass current. Test for that
and load the context the way activate_mm() does. Both hold interrupts
disabled across switch_mm_irqs_off(), so this completes before any
shootdown can be taken and needs no asn_lock handshake.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: <stable@vger.kernel.org>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/include/asm/mmu_context.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/include/asm/mmu_context.h b/arch/alpha/include/asm/mmu_context.h
index 825d3b9605c9..6ecc8a0676cb 100644
--- a/arch/alpha/include/asm/mmu_context.h
+++ b/arch/alpha/include/asm/mmu_context.h
@@ -130,6 +130,8 @@ __get_new_mm_context(struct mm_struct *mm, long cpu)
 	return next;
 }
 
+extern void __load_new_mm_context(struct mm_struct *);
+
 __EXTERN_INLINE void
 ev5_switch_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm,
 	      struct task_struct *next)
@@ -139,6 +141,15 @@ ev5_switch_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm,
 	unsigned long mmc;
 	long cpu = smp_processor_id();
 
+	/*
+	 * kthread_use_mm() and sched_force_init_mm() switch current's mm
+	 * without alpha_switch_to(), which is what loads the context.
+	 */
+	if (next == current) {
+		__load_new_mm_context(next_mm);
+		return;
+	}
+
 #ifdef CONFIG_SMP
 	cpu_data[cpu].asn_lock = 1;
 	barrier();
@@ -160,7 +171,6 @@ ev5_switch_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm,
 	task_thread_info(next)->pcb.asn = mmc & HARDWARE_ASN_MASK;
 }
 
-extern void __load_new_mm_context(struct mm_struct *);
 asmlinkage void do_page_fault(unsigned long address, unsigned long mmcsr,
 			      long cause, struct pt_regs *regs);
 
-- 
2.43.0

