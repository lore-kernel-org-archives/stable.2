Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D0F3AAF61;
	Mon, 31 Aug 2026 12:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788177763; cv=none; b=XXD9NpNF09ZhCTkOwg9IU9znTZ6JilgXobSoTWQPz3VPZu2hEyK62mU3Tc5OfXgo/Yc0KU7HBMrMt5FnnXCGOCGhU+hG0v8G+HM0aegr/gSy+LBcmPgyu0EcYHx1TdI4T506kgc5CNpsjQE//i/U2hl5Z3FRqpfnEterXJdKZqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788177763; c=relaxed/simple;
	bh=bNTRFLCKSrohGHZfBMu+t+cK3j6zLMXCFDhTQ8wtHpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+DC1DqCNZfQiyJGl7kOsntGn7xq9v0uf+9e8Sz8tlEsng05OVHrm4AFris30ksANXiYr1+ShNSTfxc7fCF4XTZGmfTjq5MHJVWe5EmfMH4m7Q0zwnjiyl9yrIoS8RRpiWRQUMrCwGOXlJvElrGL99cnum7eABu8KA2U3gEV+yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bynLrbik; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bynLrbik"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788177758; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=IYrO3wfildX7BWWCUBoQ6GD40D4gTQ9XGLryLUpATSc=;
	b=bynLrbikuwCOnwsv6i6utkRSmOek61DaVYgOk+dEdlT1WiXGPZrKvVPH3OdfktnChTk5JTBkcvGC6vNYmYuZV+xOwxRjrSr6ljgJWe9UlqBkckKPd5DphIEdwp2bN6mUySQAM/D6Z/IcQ9mgTlvJYkp1iDj9txVPqFuptWO1JXQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0X9y.-8L_1788177755;
Received: from banye.tbsite.net(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0X9y.-8L_1788177755 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Aug 2026 20:02:36 +0800
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
Subject: [PATCH v2 1/2] stacktrace: Provide arch_in_event_entry_text() hook
Date: Mon, 31 Aug 2026 20:02:20 +0800
Message-ID: <20260831120221.2874445-2-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260831120221.2874445-1-xiangzao@linux.alibaba.com>
References: <20260831120221.2874445-1-xiangzao@linux.alibaba.com>
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
name the hook after it: the ranges it tests are not necessarily irq-only
- on x86 they also cover the exception entry stubs - and what
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
---
 kernel/stacktrace.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index afb3c116da91..487ab2c858ca 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -14,6 +14,7 @@
 #include <linux/kallsyms.h>
 #include <linux/stacktrace.h>
 #include <linux/interrupt.h>
+#include <asm/sections.h>
 
 /**
  * stack_trace_print - Print the entries in the stack trace
@@ -374,12 +375,27 @@ unsigned int stack_trace_save_user(unsigned long *store, unsigned int size)
 
 #endif /* !CONFIG_ARCH_STACKWALK */
 
-static inline bool in_irqentry_text(unsigned long ptr)
+/*
+ * Optional arch hook for event entry text which cannot be placed in
+ * .irqentry.text.  filter_irq_stacks() uses this and the section checks
+ * below to find where a trace entered the kernel, so the ranges are not
+ * necessarily irq-only: on x86 they also cover the exception entry stubs,
+ * and an architecture may deliver syscalls through the same entry text.
+ * A caller that has to tell interrupt entry and syscall entry apart
+ * cannot use this.  An architecture overrides it by defining a macro of
+ * the same name in <asm/sections.h>, next to the markers it tests.
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
@@ -394,7 +410,7 @@ unsigned int filter_irq_stacks(unsigned long *entries, unsigned int nr_entries)
 	unsigned int i;
 
 	for (i = 0; i < nr_entries; i++) {
-		if (in_irqentry_text(entries[i])) {
+		if (in_event_entry_text(entries[i])) {
 			/* Include the irqentry function into the stack. */
 			return i + 1;
 		}
-- 
2.43.7

