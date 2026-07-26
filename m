Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660A917B50A;
	Sun, 26 Jul 2026 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785092665; cv=none; b=npPEnUYTVEE32Hqye+bRQhonhcGjWtA0/5a5Tph2+CHcIMXv5ltMmY6uZOmrKbP/yyoTDTo9apbuzZX/JHtWJM21RIkto04wyoQu/AO9NfqaOw5x9tPMaSgXxKY18AxZrzAsMtSN+pK9k3Z048kK/NZxHELx10+FDXs1bd2sevQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785092665; c=relaxed/simple;
	bh=cQ1Y36JcG+DxRPc7X0OEV9Winosh3GS2+ymHTwBgibw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVgwiJC7aZfZOYn4P1HYU0zogRxNZG8LBV3HD1wYBvu+5YuKtI5MQ9zu+DRCbP1Uq+GLj+nl+8M69HQjuxNRlZnI+aO959RNxiPY1WPi3IazS+ohgzv1Nhh2KwLvS7f0j5otUPD+YRP5XoybyAZOLruHLbqzWLsDcpdjycL7l2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=EtB9fSoV; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="EtB9fSoV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1785092656;
	bh=dMV6+bhO31L65Hw24GefTaQjPqfKORaQ+FsZBvilm68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EtB9fSoVf5YU+386SkA8gJ1JeZLR2l2LVaNAkkfB7T5F9neDkilGnSAO3ZgRjFtKE
	 QoPzNiJ9ILiVy1Jz04pF6X36Y9GSTpMFL9hmz6BfkvcnGtw1livm3aIXvtDdnGVj8+
	 MUDHds6qppmPLMxiC4pN5A//CeUzz5YBInVcINls=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4h7WNw3DJlz6vQY;
	Sun, 26 Jul 2026 19:04:16 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4h7WNv3wkxz4y2Q;
	Sun, 26 Jul 2026 19:04:15 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v5 4/4] panic: allow force_cpu redirect from an NMI
Date: Sun, 26 Jul 2026 19:04:12 +0000
Message-ID: <20260726190412.10891-5-include@grrlz.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726190412.10891-1-include@grrlz.net>
References: <20260726190412.10891-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nmi_panic() claims panic_cpu via panic_try_start() before calling
panic(). When the panic later reaches panic_try_force_cpu(), the
panic_in_progress() check sees panic_cpu set and refuses to redirect.
The crash kernel runs on the CPU that took the NMI instead of the CPU
requested with panic_force_cpu=:

  nmi_panic()
    panic_try_start()              wins, panic_cpu = X
    panic("%s", msg)
      vpanic()
        panic_try_force_cpu()
          panic_in_progress()      true, panic_cpu is X
          return false             redirect bypassed
        panic_try_start()          already won
        __crash_kexec()            on X, not the requested CPU

Try the redirect before claiming panic_cpu instead, as suggested by
Petr Mladek. nmi_panic() now calls panic_try_force_cpu() first and
claims panic_cpu only when no redirect happened. The requested CPU
claims panic_cpu itself when it runs panic(), so panic_cpu does not
need to be handed off.

nmi_panic() receives the final message as a plain string and has no
va_list. Let panic_try_force_cpu() take a va_list pointer instead,
where a NULL pointer means that @fmt already is the final message and
nothing needs to be formatted. This avoids both a variadic wrapper
and any formatting in the NMI path.

vpanic() hands over a disposable copy of its arguments because the
address of a va_list function parameter cannot be taken portably, for
example on x86_64 where va_list is an array type.

The redirect IPI is sent with smp_call_function_single_async(), which
is not guaranteed to work from NMI context. Treat it as best effort.
It is worth the risk because the redirection is only used when the
crash kernel would not work on the panicking CPU anyway.

Keep returning when the panic is already running on this CPU. A
nested NMI, for example with unknown_nmi_panic while this CPU is
inside panic(), must return and let the interrupted panic() continue
instead of parking the CPU in nmi_panic_self_stop().

Mark the redirecting CPU offline before stopping it, like vpanic()
does, so that panic_other_cpus_shutdown() on the target CPU does not
wait for it.

Fixes: 2e171ab29f91 ("panic: add panic_force_cpu= parameter to redirect panic to a specific CPU")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260708164312.19044-1-include@grrlz.net
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/panic.c | 55 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index a483587fdd2f..748773da178f 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -364,18 +364,19 @@ int __weak panic_smp_redirect_cpu(int target_cpu, void *msg)
 
 /**
  * panic_try_force_cpu - Redirect panic to a specific CPU for crash kernel
- * @fmt: panic message format string
- * @args: arguments for format string
+ * @fmt: panic message format string, or the final message when @args is NULL
+ * @args: arguments for the format string, or NULL when @fmt is final
  *
  * Some platforms require panic handling to occur on a specific CPU
  * for the crash kernel to function correctly. This function redirects
  * panic handling to the CPU specified via the panic_force_cpu= boot parameter.
  *
- * Returns false if panic should proceed on current CPU.
- * Returns true if panic was redirected.
+ * Returns true when this CPU must stop: the panic was redirected or is
+ * already running on another CPU.
+ * Returns false when panic() should proceed on this CPU.
  */
 __printf(1, 0)
-static bool panic_try_force_cpu(const char *fmt, va_list args)
+static bool panic_try_force_cpu(const char *fmt, va_list *args)
 {
 	int this_cpu = raw_smp_processor_id();
 	int old_cpu = PANIC_CPU_INVALID;
@@ -412,14 +413,18 @@ static bool panic_try_force_cpu(const char *fmt, va_list args)
 		return old_cpu != this_cpu;
 
 	/*
-	 * Use dynamically allocated buffer if available, otherwise
-	 * fall back to static message for early boot panics or allocation failure.
+	 * A NULL @args means that @fmt is already the final message, for
+	 * example from nmi_panic(). Otherwise use the dynamically allocated
+	 * buffer if available, or fall back to a static message for early
+	 * boot panics or allocation failure.
 	 */
-	if (panic_force_buf) {
+	if (!args) {
+		msg = fmt;
+	} else if (panic_force_buf) {
 		va_list ap;
 
 		/* Do not consume args, the caller reuses it if we fail */
-		va_copy(ap, args);
+		va_copy(ap, *args);
 		vsnprintf(panic_force_buf, PANIC_MSG_BUFSZ, fmt, ap);
 		va_end(ap);
 		msg = panic_force_buf;
@@ -452,7 +457,7 @@ static bool panic_try_force_cpu(const char *fmt, va_list args)
 }
 #else
 __printf(1, 0)
-static inline bool panic_try_force_cpu(const char *fmt, va_list args)
+static inline bool panic_try_force_cpu(const char *fmt, va_list *args)
 {
 	return false;
 }
@@ -512,13 +517,24 @@ bool panic_on_other_cpu(void)
 EXPORT_SYMBOL(panic_on_other_cpu);
 
 /*
- * A variant of panic() called from NMI context. We return if we've already
- * panicked on this CPU. If another CPU already panicked, loop in
- * nmi_panic_self_stop() which can provide architecture dependent code such
- * as saving register state for crash dump.
+ * A variant of panic() called from NMI context. The panic is first
+ * redirected to the CPU requested via panic_force_cpu=, when configured.
+ * We return if we've already panicked on this CPU. If another CPU already
+ * panicked, loop in nmi_panic_self_stop() which can provide architecture
+ * dependent code such as saving register state for crash dump.
  */
 void nmi_panic(struct pt_regs *regs, const char *msg)
 {
+	/* Try to redirect to the requested CPU before claiming panic_cpu. */
+	if (panic_try_force_cpu(msg, NULL)) {
+		/*
+		 * Mark ourselves offline so panic_other_cpus_shutdown() won't
+		 * wait for us on architectures that check num_online_cpus().
+		 */
+		set_cpu_online(raw_smp_processor_id(), false);
+		nmi_panic_self_stop(regs);
+	}
+
 	if (panic_try_start())
 		panic("%s", msg);
 
@@ -590,6 +606,7 @@ void vpanic(const char *fmt, va_list args)
 	long i, i_next = 0, len;
 	int state = 0;
 	bool _crash_kexec_post_notifiers = crash_kexec_post_notifiers;
+	va_list redirect_args;
 
 	if (panic_on_warn) {
 		/*
@@ -610,8 +627,13 @@ void vpanic(const char *fmt, va_list args)
 	local_irq_disable();
 	preempt_disable_notrace();
 
-	/* Redirect panic to target CPU if configured via panic_force_cpu=. */
-	if (panic_try_force_cpu(fmt, args)) {
+	/*
+	 * Redirect panic to the target CPU if configured via panic_force_cpu=.
+	 * Hand over a disposable copy of the arguments, the address of a
+	 * va_list parameter cannot be taken portably.
+	 */
+	va_copy(redirect_args, args);
+	if (panic_try_force_cpu(fmt, &redirect_args)) {
 		/*
 		 * Mark ourselves offline so panic_other_cpus_shutdown() won't wait
 		 * for us on architectures that check num_online_cpus().
@@ -619,6 +641,7 @@ void vpanic(const char *fmt, va_list args)
 		set_cpu_online(smp_processor_id(), false);
 		panic_smp_self_stop();
 	}
+	va_end(redirect_args);
 	/*
 	 * It's possible to come here directly from a panic-assertion and
 	 * not have preempt disabled. Some functions called from here want
-- 
2.47.3

