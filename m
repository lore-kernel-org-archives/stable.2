Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A389637E2E5;
	Tue,  1 Sep 2026 12:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788266441; cv=none; b=b2HZ7ZNABhO1ucHFZ8p0BQ3wtLSxGZsbi7JlNuwkPBpS7rs/37b0lszNSQ7F6cXozfIzq2EH0DXmqVd7exqby7vOYJoIvhfMvSrclZ0fYsY7DfxrtAGefLnzcv2Tsx+MPx15/aXLD9qyb1T4XfcbGLUFxB/zpflthMCVcSA6C9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788266441; c=relaxed/simple;
	bh=yMyZgZUL0YYG2IWxV3xUszXbUrJJCZG/+6OEM1uDTro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEY0a3F9z6zo3FeZJ3lVxLTqSCDKmIR//jAknJ7PkBdiVB1McWRBUqKNoFVtCct4qkxf4D3fsY8o6y/errqEahH8DHU+G29D/4A1Uq/sOo/BV059f/gJ79kcPSqeoSz5dlHVHEj5a5VorAk4XcEVPmsXre+v7xvhuOhTleKIfkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GjOdSDNv; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GjOdSDNv"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788266432; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=z9QPVwHndHlBSqUmecBJIZzxHjCGmQ/Teg06KwoLW1E=;
	b=GjOdSDNvlTTTgpo1LHOSByyFj/Vi5ELdoyooODWLhDoqEyoH4KPv85ifRKUIbcrlCnps0WSnOPI4BUuvpjO7O6Dl9CMMNVUkhnNhgFVhFhh0vuaqwHUEG+vfSbKSCFlmJcX6CBiuGR3OKNOWT+3ER356dtmdosOX2JEySkbNiYo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0XA8SZw4_1788266429;
Received: from banye.tbsite.net(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0XA8SZw4_1788266429 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 01 Sep 2026 20:40:30 +0800
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
	brads@mainlining.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Yuanhe Shu <xiangzao@linux.alibaba.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] stacktrace: Provide arch_in_event_entry_text() hook
Date: Tue,  1 Sep 2026 20:40:12 +0800
Message-ID: <20260901124013.1098560-2-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260901124013.1098560-1-xiangzao@linux.alibaba.com>
References: <20260901124013.1098560-1-xiangzao@linux.alibaba.com>
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
fills with unfiltered stacks:

  https://lore.kernel.org/all/CACT4Y+aReMGLYua2rCLHgFpS9io5cZC04Q8GLs-uNmrn1ezxYQ@mail.gmail.com/

Add an optional arch_in_event_entry_text() hook, consulted in addition to
the section range checks.  An architecture overrides it by defining a
macro of the same name in <asm/sections.h>, next to the section markers
it tests; the default here is a static inline returning false, which
folds away entirely on every architecture that does not opt in.  This
mirrors the existing arch hook pattern of arch_nmi_enter() in
<linux/hardirq.h>.  The fallback sits next to the hook's only user, so
no generic header gains a new dependency.

Rename in_irqentry_text() to in_event_entry_text() at the same time and
name the hook after it: the ranges it tests are not necessarily irq-only -
on x86 they also cover the exception entry stubs - and what
filter_irq_stacks() asks of them is where a trace entered the kernel.
The helper is file local with a single caller, so the rename stays inside
kernel/stacktrace.c; filter_irq_stacks() keeps its name as it is exported
and used treewide.

No functional change on its own.

The first user is the FRED fix in the follow-up patch.  Both carry the
same Fixes: tag and are Cc'ed to stable so that they are picked up as a
pair.

Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
Cc: stable@vger.kernel.org # v6.9+
Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
---
 kernel/stacktrace.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index afb3c116da91..62b84998b13e 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -14,6 +14,7 @@
 #include <linux/kallsyms.h>
 #include <linux/stacktrace.h>
 #include <linux/interrupt.h>
+#include <asm/sections.h>
 
 /**
  * stack_trace_print - Print the entries in the stack trace
@@ -374,12 +375,24 @@ unsigned int stack_trace_save_user(unsigned long *store, unsigned int size)
 
 #endif /* !CONFIG_ARCH_STACKWALK */
 
-static inline bool in_irqentry_text(unsigned long ptr)
+/*
+ * Used to help find where a trace entered the kernel.
+ *
+ * Architectures use this when event entry text cannot be placed in
+ * .irqentry.text alone.  Architectures should define a macro of the
+ * same name in <asm/sections.h>.
+ */
+#ifndef arch_in_event_entry_text
+static inline bool arch_in_event_entry_text(unsigned long addr) { return false; }
+#endif
+
+static inline bool in_event_entry_text(unsigned long ptr)
 {
 	return (ptr >= (unsigned long)&__irqentry_text_start &&
 		ptr < (unsigned long)&__irqentry_text_end) ||
 		(ptr >= (unsigned long)&__softirqentry_text_start &&
-		 ptr < (unsigned long)&__softirqentry_text_end);
+		 ptr < (unsigned long)&__softirqentry_text_end) ||
+		arch_in_event_entry_text(ptr);
 }
 
 /**
@@ -394,7 +407,7 @@ unsigned int filter_irq_stacks(unsigned long *entries, unsigned int nr_entries)
 	unsigned int i;
 
 	for (i = 0; i < nr_entries; i++) {
-		if (in_irqentry_text(entries[i])) {
+		if (in_event_entry_text(entries[i])) {
 			/* Include the irqentry function into the stack. */
 			return i + 1;
 		}
-- 
2.43.7

