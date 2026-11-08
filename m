Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177369;
	b=vz/aDcUF50E/kBIALWJb/MDPp6oAEk55mkMWmlgbik9xXY3lnb/G4oEHewTPrYrI2Kvp
	 PJLgI+eF6jXpSSwqM+zEuOpWu6QqhOLjeAmPPdRF+zgdj3lX4/qehvM0TVfgKr9piqK2Z
	 vjprv897esKJTVV7EL+5krmJBGv5tHdOQSuZY8HWU1tQ8Vjw2TDAvG6FwYSjvA9P6TrNA
	 4wMj9mxA5+ZbQtQ+0NN4kSsRwqDAyoBOtHCBcdR8Bii3GQHpe+vMJVopr4h3LXgFkkcEp
	 BAjBqMPTEED388t7y4ON7dQwHs56kUBpl882wlzRYvmEqxCPc1VCA0kmF1/87uUSXEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177369;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=62VFOg8MBQwHAYCXFCSU2NA7xtVlUF2RJoBXeGfN2Ak=;
	b=DEbe/qD/emINAs6nvl/ERVdP+5xh7eCN7sU0y3vOteXDgQ7oVQfGANc4iGrvvYhvUF71
	 l0H9JxiJUJ5D8tXqhCBd7NB72ocJW2I3LtyUe1Q6Xjn8c1wRgyGc9vqOurGKmDgW7Ym3M
	 TLmreqKkzU4g4Q/PpNs8pkFhFp1JRsYu790I227JQs+ZkwztYWPkHOV9jbOnZPOx60I02
	 zoh8/CNIcweX9snktJ3I7YQ+pOQXZe+Fw4sC+A3jfQXtlnnCWZs19Sa5+Erf6d0XMe1Hb
	 2pCUJ9v6MPUetrQpz3Lr8zGhgDFifu1FFyJ6k1iE8BhZCwN+Ezl2pUUbD4dVqvdx91Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QnUYllcq;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4715B606EEAC
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 22:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4715B606EEAC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QnUYllcq
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso369553a12.3
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 14:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794177368; x=1794782168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=62VFOg8MBQwHAYCXFCSU2NA7xtVlUF2RJoBXeGfN2Ak=;
        b=QnUYllcqes2uRUEHKIf8dGsbZO+dZMH3dFyctkPLkJcF5UcUN1RMmWfZut99JVGJQ+
         PS+fsuOvEAK0SLcPD/toeULEOekIFAXvoBXHUVGXkKrAtxyAVt7Vv/v59B68uWYDZ0P9
         ZZP/+6/Prr2xCYasYCWamghb+iZ9TDhWh6pFeCnfpPs6Shwwk3F0b4t1ivgite0dOJFu
         kXwzIKFWl08hqJnR5IB/yiVxYKNI2L7zjKKKbeikUbgmYSidPfYkxDTZHIEWx25zKw+/
         qSOpnCUVY2nlp6MCxzS0lJc5icxNouiW7DDZnI/Y/OEh753VbsKBX45PC4WtvdHl2CGq
         bMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177368; x=1794782168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=62VFOg8MBQwHAYCXFCSU2NA7xtVlUF2RJoBXeGfN2Ak=;
        b=wrMFZgijleqJkxjhJzJhd4O2arZZMz1Yjf2hbvEKWVzkqE4Nfm5AYSpqI6yzEle/zY
         gM9/flblX+CojPzP89w38vetMnnRor72x/i/lbQQNwqKsyxHLQVPb+xJVrGbim6fDYyh
         d/h5pCalnfRJ7+hRGWKRrp57di8aiEFkZwi5NhkHcC2K9fAms/jsSnQnt9x0wG476qH6
         E+H83XJxjDcIvKLmVqq0lUUuXt0zqJCL0UuG7yYR7oYxUNeL4Guzjm/RcuteXNd6gPRr
         qqk1l6VXDcrLWtCYWiYDPIYulJXBF0uOkRrxsj6zrsWpfFk7umRddKaJgxizW46yRtaj
         8Vlw==
X-Forwarded-Encrypted: i=1; AL+hErGSBL3xkWS36w9VWmPjkX8KdgPK26mzU70NKS/0zulPF3ZtWocyhTU+y453c9VGOExAaPSJio8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8y/7/9Ln2h3E9qpPudLm6OkScJcxMK2ziVqAjpZaviv4CKXziV
	qGZ8zg1lIWPEn326zMIpXGbX/Qq+W3zCJJsOI7nFJSXJrhT5EmFLrAtEcc9/kBdN
X-Gm-Gg: AYBFou31b6iyUTWXX83W+pVu3FkT3OPdibEjj0lY2ObbnIh6snjQBOrbUEE+tLOgmU+
	p7XM14b9/elhwBLJ3dT7dtOAQR8h9AMNtuJESxHeSsa8pgefGBf6879zItXD5/wsWwx1/yz3zM+
	Z5omfsvRI3vDByC4HFGJurOAElk3iPea6RZjVBHxj74Jha5jpSmTBWOxoy6dkrNqfgRWcXGVFpg
	h3by3pdPfmmbiQycULr1/H2aL5TLFFhBCecBEOY8awi9WTJtkLXpzBQ9XsszM07elm0xgPe8w9+
	gxr0zi/JU+6LL07GUY0ihdw0QlV4fJQlYxcpYI8nn6sxrppFg4iTV1w9CcyUB01tA7ymzUoqhuj
	oVp8MoWcR1D+x3NKs8igzpj4fFgy4P5Gn1Pv9ZOjw2C4mQ6OYUjtfORCzcObK+UTy0Vf/rKQPHC
	BTytUsb40JNbk+iYF0QrKIzfT5MxjYFX6kvMWb49kwIhWJXYNO9pCOXuoeFXG044pmgbsHuoH1/
	9BwoAmG2guU0xnWJrLYz3+fGCM+hdoYuxfjbNvvzbb6pYxWR0p9xyEzJgJEM/JupqJlnTz117we
	uqlqSEjpX6yZEaBDiXBFaB6hDBO63RRb10u5hgusA/4R6SuepbHNLTFU63ZVxzafZ/Wm3oE=
X-Received: by 2002:a05:6402:3787:b0:6b7:1b3b:d309 with SMTP id 4fb4d7f45d1cf-6b7224c54abmr1481109a12.33.1794177367600;
        Sun, 08 Nov 2026 14:36:07 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ebc7b0sm859272a12.14.2026.11.08.14.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:36:06 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 9/9] sparc32: enroll and order CPUs before switching address spaces
Date: Sun,  8 Nov 2026 23:34:19 +0100
Message-ID: <20261108223516.1125534-10-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108223516.1125534-1-linmag7@gmail.com>
References: <20261108223516.1125534-1-linmag7@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The task-switch macro records a CPU in the incoming active_mm mask, but
kthread_use_mm() changes address spaces without switching tasks. A
shootdown can therefore miss a CPU using that mm.

Move enrollment to switch_mm(), before installing the context. User task
switches and activate_mm() pass here, as does kthread_use_mm(). Lazy
kernel threads inherit the already active mm on that CPU; they do not
introduce a different hardware context. Keep CPU bits until mm teardown,
as in the preceding fix, and remove the duplicate switch_to() update.

SPARC32 smp_mb() currently expands to a compiler barrier. The hash lock in
set_bit() is acquired before the mask store, so it does not provide a
hardware StoreLoad fence after enrollment. Use STBAR followed by a native
LDSTUB of a private stack byte before changing the context. STBAR orders
prior stores before the atomic operation, including under PSO; LDSTUB
blocks subsequent memory operations. The memory clobber orders the
compiler. SPARC Architecture Manual V8 sections 6.2 and 6.3 describe these
rules.

The shootdown side updates PTEs using native SWAP before inspecting the mm
mask. A newly enrolling CPU must publish its bit before accessing the new
address space: either a concurrent shootdown includes it, or it observes
the updated tables. A returning CPU remains enrolled and cannot be
omitted. Do not rely on processor-specific cache maintenance or a later
refcount operation for this ordering. The local helper does not change the
general SPARC32 barrier implementation and acquires no shared lock.

Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/include/asm/switch_to_32.h |  1 -
 arch/sparc/mm/srmmu.c                 | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/switch_to_32.h b/arch/sparc/include/asm/switch_to_32.h
index 42eeafcb8a41..1d9855abbc00 100644
--- a/arch/sparc/include/asm/switch_to_32.h
+++ b/arch/sparc/include/asm/switch_to_32.h
@@ -58,7 +58,6 @@ extern struct thread_info *current_set[NR_CPUS];
 #define switch_to(prev, next, last) do {						\
 	SWITCH_ENTER(prev);								\
 	SWITCH_DO_LAZY_FPU(next);							\
-	cpumask_set_cpu(smp_processor_id(), mm_cpumask(next->active_mm));		\
 	__asm__ __volatile__(								\
 	"sethi	%%hi(here - 0x8), %%o7\n\t"						\
 	"mov	%%g6, %%g3\n\t"								\
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index d3634bcb048d..e5c136c8ecd7 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -467,6 +467,18 @@ static void __init sparc_context_init(int numctx)
 		add_to_free_ctxlist(ctx_list_pool + ctx);
 }
 
+/* Order CPU enrollment before accesses through the new context. */
+static inline void sparc32_mm_context_barrier(void)
+{
+#ifdef CONFIG_SMP
+	unsigned char scratch = 0;
+
+	/* STBAR orders prior stores; LDSTUB blocks subsequent loads. */
+	asm volatile("stbar\n\tldstub %0, %%g0"
+		     : "+m" (scratch) : : "memory");
+#endif
+}
+
 void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm,
 	       struct task_struct *tsk)
 {
@@ -479,6 +491,10 @@ void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm,
 		srmmu_ctxd_set(&srmmu_context_table[mm->context], mm->pgd);
 	}
 
+	/* kthread_use_mm() can enter an mm without a task switch. */
+	cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
+	sparc32_mm_context_barrier();
+
 	if (sparc_cpu_model == sparc_leon)
 		leon_switch_mm();
 
-- 
2.43.0

