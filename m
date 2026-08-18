Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF29F47A0B5;
	Tue, 18 Aug 2026 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071099; cv=none; b=G1x98zeg5GurT4YYenIJedA+4e5g1bRMqJRzeIKmTzuSKFJ+5i5q8xITO2/yjrwshPGv33iQkq6SEkxh0SXvA19yHYA3Uu7Scxh3Zd+SnLnA3vuhRvsxeDD0W6tM2dZX2HZZPU2rNBp1mATLbLHdqByP6sduOK0ng1YkpG5W1JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071099; c=relaxed/simple;
	bh=pWgKCKhLtIwYBGK+/4BfPDMRP2CNS3id9PZMAciK9uM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ol4YR/7iuEq9ASJcc7xCR3tTbTkOjXZMGpI4TJKeIUaErqhAIY6FZlLf0Q3jHjQvOn3865cAv14WPrBIEvYZrtULuXnapNhx60pQvrVmdTxr15HktoNrvS3O54caWYdVceMj3Lq+BxJQDocYmDd7WN53biIG6muzbDhiCcqaAh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=QXWkAfpm; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="QXWkAfpm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787071092;
	bh=gpV9M3rSbKpE5EaCMtQTeEgcaFpIxQJ+r2mH4Lkcy2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QXWkAfpmFL1QRL3kFkTd64EV2vnzsKZpnD7Fovc0Zxk6C/IgpghIKm8VkZvHiabbd
	 sdamVOGzGk/qGli3SlCbr0YZkrZbt1ZoeNL22WvmX8cabekmwfjN0VjIE59LxEBlvK
	 HGs91r8PgxItXDzRunPrVp4aPH2k6TbOHkIP+dPs=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with UTF8SMTP id 4hPb3m18RNz6vMw;
	Tue, 18 Aug 2026 16:38:12 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4hPb3l5b33z4y6W;
	Tue, 18 Aug 2026 16:38:11 +0000 (UTC)
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
Subject: [PATCH v6 5/6] panic: allow force_cpu redirect from an NMI
Date: Tue, 18 Aug 2026 16:38:05 +0000
Message-ID: <20260818163806.17460-6-include@grrlz.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260818163806.17460-1-include@grrlz.net>
References: <20260818163806.17460-1-include@grrlz.net>
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
need to be handed off. panic_try_force_cpu() copies the arguments
before formatting (patch 3), so nmi_panic() can pass them to vpanic()
again when no redirect happens.

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
 kernel/panic.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index bc142485faa4..356c03f2361c 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -513,10 +513,11 @@ bool panic_on_other_cpu(void)
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
 __printf(2, 3)
 void nmi_panic(struct pt_regs *regs, const char *fmt, ...)
@@ -525,6 +526,16 @@ void nmi_panic(struct pt_regs *regs, const char *fmt, ...)
 
 	va_start(args, fmt);
 
+	/* Try to redirect to the requested CPU before claiming panic_cpu. */
+	if (panic_try_force_cpu(fmt, args)) {
+		/*
+		 * Mark ourselves offline so panic_other_cpus_shutdown() won't
+		 * wait for us on architectures that check num_online_cpus().
+		 */
+		set_cpu_online(raw_smp_processor_id(), false);
+		nmi_panic_self_stop(regs);
+	}
+
 	if (panic_try_start())
 		vpanic(fmt, args);
 
-- 
2.47.3

