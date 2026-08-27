Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDD8383993;
	Thu, 27 Aug 2026 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787842846; cv=none; b=NVUKFb/kBei5ISgv7HO+fvnD3Uch9/dH54KLN0dUIMsJDXMTB2oNZpgcK4wTnrIHiUBxXUMlCEUKKwa8/cZRxAsCQ+vw3gNd6nujTnUZBy/sBAADwIhkK7XheVsNY0xYCVm2dFtb09gHkFma5SIDIzRMl+RhQDahJJlteg9rFNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787842846; c=relaxed/simple;
	bh=oOR5Bw39qTo7+ULeAO9TLlF4bQZXPfJUr2P2MfnW6c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rr+4H6MQqcIaW0bYgdmw5xFgK73u91bjwJqD5y33vztdI8GtJzBFC04JV44Eq2dU3wjhOgtfDrVm6jo4jfy5SrJnPRhPSVtUiKov8kAffTuVZtAxABys831kssnzGJDkw9tQC13MVEUQVMsIhvhQnQm4ICpH1KyhQVUiRFmdiG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kfSaef0t; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kfSaef0t"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787842839; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=bs3P8qUrpqQYo5gu3WjsOBtkbsx6dtb75aGZvmg2wZg=;
	b=kfSaef0t/H6cH6YXbhC/O48dNUlZZQacac/HWfZhC8EqjA0IwefDROGiOhKyBSj5iYdP0LU+an5rexc5VLo4eYI1j3yuyQl64bOf1VlYSxFYc8m+/flXhIdtpW5KGOW1By3dQx3hz72HSFd9PdgdZ+oSxjGEQ4jgAbMSTw//+Oo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0X9jzaec_1787842836;
Received: from banye.tbsite.net(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0X9jzaec_1787842836 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 27 Aug 2026 23:00:37 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: hpa@zytor.com,
	xin@zytor.com,
	luto@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	akpm@linux-foundation.org,
	rdunlap@infradead.org,
	elver@google.com,
	andreyknvl@gmail.com,
	glider@google.com,
	gor@linux.ibm.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Yuanhe Shu <xiangzao@linux.alibaba.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] stacktrace: Provide arch_in_irqentry_text() hook
Date: Thu, 27 Aug 2026 23:00:21 +0800
Message-ID: <20260827150022.1618235-2-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260827150022.1618235-1-xiangzao@linux.alibaba.com>
References: <20260827150022.1618235-1-xiangzao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

in_irqentry_text() decides whether a stack address belongs to interrupt
entry code by checking the .irqentry.text and .softirqentry.text section
ranges.  filter_irq_stacks() uses it to truncate interrupt stacks at the
entry point, which stack depot depends on to deduplicate them: traces
that continue past the interrupt entry lead to unbounded depot growth,
see commit e94006608949 ("lib/stackdepot: always do filter_irq_stacks()
in stack_depot_save()").

An architecture may deliver interrupts through entry code that cannot be
placed in .irqentry.text.  in_irqentry_text() then never recognizes the
entry point and the truncation silently stops happening.  The markers are
meant to cover all interrupt entry functions; when they do not, the depot
ends up holding essentially random stacks:

  https://lore.kernel.org/all/CACT4Y+aReMGLYua2rCLHgFpS9io5cZC04Q8GLs-uNmrn1ezxYQ@mail.gmail.com/

Add an optional arch_in_irqentry_text() hook, consulted in addition to
the section range checks, gated on a new ARCH_HAS_IN_IRQENTRY_TEXT
symbol.  Gating keeps the default a static inline returning false, which
folds away entirely on every architecture that does not opt in, instead
of a __weak stub that every architecture would have to call.  This
mirrors the existing ARCH_HAS_* hooks in lib/Kconfig such as
ARCH_HAS_COPY_MC.

No functional change on its own.

The first user is the FRED fix in the follow-up patch, which carries a
Fixes: tag and is Cc'ed to stable; tag this prerequisite for stable too,
so the two are picked up as a pair.

Cc: stable@vger.kernel.org
Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
---
 include/linux/stacktrace.h | 16 ++++++++++++++++
 kernel/stacktrace.c        |  3 ++-
 lib/Kconfig                |  3 +++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
index 525cf60673fe..e933ce86447f 100644
--- a/include/linux/stacktrace.h
+++ b/include/linux/stacktrace.h
@@ -62,6 +62,22 @@ void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
 			  const struct pt_regs *regs);
 #endif /* CONFIG_ARCH_STACKWALK */
 
+/*
+ * Optional arch provided check for additional IRQ entry text, called
+ * in addition to the .irqentry.text and .softirqentry.text range
+ * checks in in_irqentry_text().  Implement this if the architecture
+ * delivers interrupts or exceptions through entry code which cannot
+ * reside in those sections.
+ */
+#ifdef CONFIG_ARCH_HAS_IN_IRQENTRY_TEXT
+bool arch_in_irqentry_text(unsigned long addr);
+#else
+static inline bool arch_in_irqentry_text(unsigned long addr)
+{
+	return false;
+}
+#endif
+
 #ifdef CONFIG_STACKTRACE
 void stack_trace_print(const unsigned long *trace, unsigned int nr_entries,
 		       int spaces);
diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index afb3c116da91..9e85ac900889 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -379,7 +379,8 @@ static inline bool in_irqentry_text(unsigned long ptr)
 	return (ptr >= (unsigned long)&__irqentry_text_start &&
 		ptr < (unsigned long)&__irqentry_text_end) ||
 		(ptr >= (unsigned long)&__softirqentry_text_start &&
-		 ptr < (unsigned long)&__softirqentry_text_end);
+		 ptr < (unsigned long)&__softirqentry_text_end) ||
+		arch_in_irqentry_text(ptr);
 }
 
 /**
diff --git a/lib/Kconfig b/lib/Kconfig
index 4e6b34c3346d..45ff30d0a995 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -551,6 +551,9 @@ config ARCH_HAS_COPY_MC
 config ARCH_STACKWALK
        bool
 
+config ARCH_HAS_IN_IRQENTRY_TEXT
+	bool
+
 config STACKDEPOT
 	bool
 	select STACKTRACE
-- 
2.43.5

