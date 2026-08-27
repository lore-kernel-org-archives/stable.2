Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E9622FDE6;
	Thu, 27 Aug 2026 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787850328; cv=none; b=D7lKsQ0QzSb6jBtmNS6/aKZdPclplbjJOgAp4bN7WswcobHe1eWBkxj7nVTXwmiEiD5yWGLG03gOwInqcCTk1f9/Pav9Ar5YRBPuTZhR/QUbmTH+F2hoGIDKUAm9kAQux6dLbEoxxNn1SI7BxBOrWs9rWeTqzViAGHJGPPYTsqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787850328; c=relaxed/simple;
	bh=NvLI/JcVqapvW8+pY/epWx+uByhkIUaJTg2ZhPvQ3/Q=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=FCwZZqhehPi0kMHhCD9ViwHCaUJqqTQMEOzDmEnuFwlKvWne8CqjkHfhNGWPo6ejanTHWQU4fae6FR0z8D0quSWWBB90MeeQ16Un9Ofj/XCcCBHG6T9ZhLaim46gHHrHz9pwOfdq9VTlHiAU5m3nXzwXkIJx1SvdwsoddtibBZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=bGcQNhl0; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=5GCDeaZ0; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="bGcQNhl0";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="5GCDeaZ0"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1787850288; bh=dg+z/LOqVTYs8cEmYn7/6Jo
	cDFmCScsPIaY/59uwpRk=; b=bGcQNhl0T/8/OCii8oDRFX3YJihAL7lmhVjBn4BkWwxUS3aN3q
	r159f+P+NUQ6pZTya9ld8iL5afoJxzFgxZgM4HxkcYoa9mC2gg6eynThQA0UUTOKZukutbZeYT4
	zf1yeGhP6qPLFApLjP+Qty+7BUYqZrj0fqqWiAunkadeGXO9RP/mLBzNonZjViE8F3fXfo4MUUJ
	sDD2zzME76fuSigMfnfug41EY7LSZFPCnHAk7Fuiq04qJ5Q+slw/WiZq6o3PmGCoPPAFVuwuBMx
	MwtZv2Q8JKyLfPuyf5q+t+LafqCSB7bTaxtW0BluOqQRP+C5XEjezJeZZixO/el4nyg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1787850288; bh=dg+z/LOqVTYs8cEmYn7/6Jo
	cDFmCScsPIaY/59uwpRk=; b=5GCDeaZ0/jSyf6HGHrBxHlAnuXsE6huc906OPwfN+8t7G7AiWR
	WSJRPPI8JQu89pRG6LRktvpi4+Jo8cwwrnAQ==;
Date: Thu, 27 Aug 2026 18:04:48 +0100
From: Bradley Morgan <brads@mainlining.org>
To: xiangzao@linux.alibaba.com
CC: akpm@linux-foundation.org, andreyknvl@gmail.com, bp@alien8.de,
 dave.hansen@linux.intel.com, elver@google.com, glider@google.com,
 gor@linux.ibm.com, hpa@zytor.com, jpoimboe@kernel.org,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, luto@kernel.org,
 mingo@redhat.com, peterz@infradead.org, rdunlap@infradead.org,
 rostedt@goodmis.org, stable@vger.kernel.org, tglx@kernel.org, x86@kernel.org,
 xin@zytor.com
Subject: Re: [PATCH 1/2] stacktrace: Provide arch_in_irqentry_text() hook
In-Reply-To: <20260827150022.1618235-2-xiangzao@linux.alibaba.com>
Message-ID: <58EF0ADB-E7CC-4A15-B124-B5A870281D55@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 27 August 2026 16:00:21 BST, Yuanhe Shu <xiangzao@linux.alibaba.com>
wrote:
>in_irqentry_text() decides whether a stack address belongs to interrupt
>entry code by checking the .irqentry.text and .softirqentry.text section
>ranges.  filter_irq_stacks() uses it to truncate interrupt stacks at the
>entry point, which stack depot depends on to deduplicate them: traces
>that continue past the interrupt entry lead to unbounded depot growth,
>see commit e94006608949 ("lib/stackdepot: always do filter_irq_stacks()
>in stack_depot_save()").
>
>An architecture may deliver interrupts through entry code that cannot be
>placed in .irqentry.text.  in_irqentry_text() then never recognizes the
>entry point and the truncation silently stops happening.  The markers are
>meant to cover all interrupt entry functions; when they do not, the depot
>ends up holding essentially random stacks:
>
>  https://lore.kernel.org/all/CACT4Y+aReMGLYua2rCLHgFpS9io5cZC04Q8GLs-uNmrn1ezxYQ@mail.gmail.com/
>
>Add an optional arch_in_irqentry_text() hook, consulted in addition to
>the section range checks, gated on a new ARCH_HAS_IN_IRQENTRY_TEXT
>symbol.  Gating keeps the default a static inline returning false, which
>folds away entirely on every architecture that does not opt in, instead
>of a __weak stub that every architecture would have to call.  This
>mirrors the existing ARCH_HAS_* hooks in lib/Kconfig such as
>ARCH_HAS_COPY_MC.
>
>No functional change on its own.
>
>The first user is the FRED fix in the follow-up patch, which carries a
>Fixes: tag and is Cc'ed to stable; tag this prerequisite for stable too,
>so the two are picked up as a pair.
>
>Cc: stable@vger.kernel.org

LGTM, thanks

Reviewed-by: Bradley Morgan <brads@mainlining.org>

>Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
>---
> include/linux/stacktrace.h | 16 ++++++++++++++++
> kernel/stacktrace.c        |  3 ++-
> lib/Kconfig                |  3 +++
> 3 files changed, 21 insertions(+), 1 deletion(-)
>
>diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
>index 525cf60673fe..e933ce86447f 100644
>--- a/include/linux/stacktrace.h
>+++ b/include/linux/stacktrace.h
>@@ -62,6 +62,22 @@ void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
> 			  const struct pt_regs *regs);
> #endif /* CONFIG_ARCH_STACKWALK */
> 
>+/*
>+ * Optional arch provided check for additional IRQ entry text, called
>+ * in addition to the .irqentry.text and .softirqentry.text range
>+ * checks in in_irqentry_text().  Implement this if the architecture
>+ * delivers interrupts or exceptions through entry code which cannot
>+ * reside in those sections.
>+ */
>+#ifdef CONFIG_ARCH_HAS_IN_IRQENTRY_TEXT
>+bool arch_in_irqentry_text(unsigned long addr);
>+#else
>+static inline bool arch_in_irqentry_text(unsigned long addr)
>+{
>+	return false;
>+}
>+#endif
>+
> #ifdef CONFIG_STACKTRACE
> void stack_trace_print(const unsigned long *trace, unsigned int
> nr_entries,
> 		       int spaces);
>diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
>index afb3c116da91..9e85ac900889 100644
>--- a/kernel/stacktrace.c
>+++ b/kernel/stacktrace.c
>@@ -379,7 +379,8 @@ static inline bool in_irqentry_text(unsigned long ptr)
> 	return (ptr >= (unsigned long)&__irqentry_text_start &&
> 		ptr < (unsigned long)&__irqentry_text_end) ||
> 		(ptr >= (unsigned long)&__softirqentry_text_start &&
>-		 ptr < (unsigned long)&__softirqentry_text_end);
>+		 ptr < (unsigned long)&__softirqentry_text_end) ||
>+		arch_in_irqentry_text(ptr);
> }
> 
> /**
>diff --git a/lib/Kconfig b/lib/Kconfig
>index 4e6b34c3346d..45ff30d0a995 100644
>--- a/lib/Kconfig
>+++ b/lib/Kconfig
>@@ -551,6 +551,9 @@ config ARCH_HAS_COPY_MC
> config ARCH_STACKWALK
>        bool
> 
>+config ARCH_HAS_IN_IRQENTRY_TEXT
>+	bool
>+
> config STACKDEPOT
> 	bool
> 	select STACKTRACE
>


--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
