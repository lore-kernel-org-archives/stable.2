Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4553C9EE8
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791579905; cv=none; b=BPrM8wFZWUjU4J4LeC03OMJNj8Tv5HHpAnFrt5ZN9d1Q8ijwgkrkOuPZb2H2RnydNOD/hmllfi5JL5uJ83PXrsP/Plzju1z7KwOHk1MdbUeeU/+rx2Tiq52PasQP84WVoJrhaQ/IUXcNHroXRqk3MlzE9MPVOaSdhgchn+MzRp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791579905; c=relaxed/simple;
	bh=6opi/5R9M3NXlfgYoH61tIu1FvaiunNCfa3uJFb93kY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7nAd5y9hcGgXm5YBOldFP/JAea96lWZa6xsiNyfdujHeP9H+aDHOQqb2ik/zcHhf+BcwqF8cOo0ks4oNzOkQc6k5btHapXv7TV8LTXScMhZTznadqa6KId2ql/aB+vOk6VmppfyugsZ/SKmwzOU4yDE5mykmO2qp4rbZ1avJTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rwXQqGpc; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwXQqGpc"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c315729ad50so48898466b.0
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 14:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791579902; x=1792184702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=59gWwwZKc4LtbAwf3F0whP4Jml+i88HQZDtzu/90YQc=;
        b=rwXQqGpc8+yHz2zOiwvJHPG5mdhiojWxn8kHL41yZfpnMlFegWy46GZxSQi1+zm8NN
         6USm7+mxQMZu1qeKrAL+Uo4hWi0C5K1H6+V1P/RfGzWhxcaHA17koYBbvSA//m5vjnPu
         9L+hIdgnzvIIFLDXMEU/BtZbf0X8ZK5GbMOlUBDUjgtZOrOUsbgpChJXnIT397kKiHVp
         qm/rkwqOkIn7RMfyVLxilR9iG/KpU1/SpK7+EHfddKaA4o5IZOuysLLd3C39MI5AKY5f
         V369DzcBaMxX9IiOTKLv5TqmkW7z+zvPhiX1hzIz3oarJcPX9dNKG5irtVLl5gXvi9Mr
         KIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791579902; x=1792184702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=59gWwwZKc4LtbAwf3F0whP4Jml+i88HQZDtzu/90YQc=;
        b=dgHwCaeGpMyyh7AooAUCgJ97MENoF/lu50GjZbxejJ+qe6iCOuyw/r/Hw1G8k+Xsyc
         LyE/OVWd8Z8QVXfV3zHgy+3tuiea0XAExhTFb1Yq1FCVyoEOK+XOAZ09QpObAn9NsVw2
         ZWFqQyZ3lfmTlhANMD7XYwax+v3MtkSPvhzbB9Ym3dk5vm0ctr4pX1eE3NPwwYO6zMoy
         sS1vZDfo/usa1s68lpYah7JKsXFFwAz2TOJ4g3A5v46PbXkDCcT0Eu6lcRK9TLucnJqR
         GeiGYuhX8GFTlk2ZbQz9o0/yCstGaYMHJYD9YF7WHCNqiptz8znzUljroy8Q/MSDKXjc
         hHBQ==
X-Forwarded-Encrypted: i=1; AKwUvBw8c9ThrydgiQlwZev4cryE5SUWcAZ2NzxyMGBaKJ5SVjphSV4gW5hdVh12O4NP0LeERY+8bRk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJOGu7waVR9aiyTN+JP9+ZU/PkXof76Rx2bhxczVaBRJLEjif8
	yERTs/09G3mmwhFxpyqjV0TmaDBvaUQ76LY+8PY7Q3b6sSOyqPF8oGaB
X-Gm-Gg: AYBFou3BZ528AdZtA/w4VqAGLO0b2LKP+D1+VFO4iNsA3/99OAqgruUkaaDAOXS0J4F
	Bpf/WJFkhc/kUT9jHVV/RxgkbPpTDD3rCKlET0c1VaVhEAtNwLNn9WW4foKKdwIm8FoEiNPikO1
	OZ46jbEWWaVmvvyICelxlRt5auX+VN6beyuJzSXZ4etQEjx2cxcSjW1dexcpiA5w65fYD6c5Vnx
	c5yF3VgyQnH2Lu3J0zDAXtQs+2/Q01sJITF24l1/v/dtYB76ck4p+m+5a4USjNZ5zcMG77Kt2aq
	mq+P2WHz/dsTE3bZf7w67Y2doxGnJ3+uuDSqUHLGYMQXWSp4wt96/7uavv0VBel47vaiBS2PfEK
	zPzwwhBGNLCVZSxxcOq7kJgeR/IY0cn7crApSUFSVPR+sAsfBZXnqVLG4BFlGeKY44hvoMEErs4
	uogCKXTm1SfP0ojXeotm+bMjo12e3j85hx8miu+N7RfFT7yqgI4aaGUALwAQMDWq0t6G8HDVShP
	P1jZU5NCOgpjkSdHqICDNAB+/ynkX1QudRnept5
X-Received: by 2002:a17:906:630c:b0:c2e:4601:24d7 with SMTP id a640c23a62f3a-c31aa0b038fmr334122466b.39.1791579902349;
        Fri, 09 Oct 2026 14:05:02 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9765d1asm142141266b.8.2026.10.09.14.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 14:05:01 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v4 1/8] alpha: load the MMU context when switch_mm() switches the current task
Date: Fri,  9 Oct 2026 23:03:46 +0200
Message-ID: <20261009210449.971057-2-linmag7@gmail.com>
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
Reviewed-by: Matt Turner <mattst88@gmail.com>
Message-ID: <20261008195608.965266-2-linmag7@gmail.com>
---
 arch/alpha/include/asm/mmu_context.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/include/asm/mmu_context.h b/arch/alpha/include/asm/mmu_context.h
index eee8fe836a59..c5cf7dbe6161 100644
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

