Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896CD47DFB9;
	Tue, 18 Aug 2026 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071098; cv=none; b=CK9J57pVGDSBIYr7feShdqzJQnbUVjfELlsK46FljXDWuArpB2JaWTFuTCnqxw7bM4MUKOi0ouRzrKuMcLthHkCbAAjKe/RrAI4T9MzmtinQruITuiuf0Nz4Yd1nGO1Ck9W6Ax2X+qslrmfGcacAuRLMj1EZaiEKXCptv69CPAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071098; c=relaxed/simple;
	bh=nWl0mcx1eOQ5JCm6jhBRFctAobqoXTgWsv7jJW7mDg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LMKizXWO68w4KNlNJGvCH680ZwwGZzXuSVBxNHdLFPuG4OXPvBm5IXdE4ZWGQpk5cIibBzTWZs5ZiOqtoYj9YVUG1tiFkEuuB4dUXg98WTLirD6pkUPqkDf39m8CMD3wQVJEIjTCKVWebbw0Ht9XMfmW8lXgRWUFvPek7VYVuTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=I8upyRUt; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="I8upyRUt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787071089;
	bh=7ziHvPvoxTW3lsGEnBm05gJXCbZNtWg3ecsAkbmTRMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I8upyRUtesoY8s1XZcVsq3AekFs1392pmJJFBLVxz2+XdK+k05LVliPx8Rft0Ix5g
	 /tPG/R3fhuz7UokWD689mRehZVETbcBVOnZNgrf6AG6gKPWFeSsbFZHNMdXU38FGn/
	 3ARAXmGE2QO7/Xzt/Por82xEdIbbajyTjMfJyC0w=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with UTF8SMTP id 4hPb3j0xWjz6vMT;
	Tue, 18 Aug 2026 16:38:09 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4hPb3h497Kz4y6W;
	Tue, 18 Aug 2026 16:38:08 +0000 (UTC)
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
Subject: [PATCH v6 1/6] panic: fix redirect CPU race in panic_try_force_cpu()
Date: Tue, 18 Aug 2026 16:38:01 +0000
Message-ID: <20260818163806.17460-2-include@grrlz.net>
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

The cmpxchg() in panic_try_force_cpu() makes sure that only one CPU
tries to redirect panic() to the requested CPU. It is similar to the
cmpxchg() in panic_try_start() which makes sure that only one CPU does
the panic(). In both situations, only the winner of cmpxchg() should
proceed further. Other CPUs should go offline.

There is a bug because the cmpxchg loser returns false and falls through
into vpanic(). Two non-target CPUs A and B panic, the requested CPU is C:

             cpu A                          cpu B
          ----------                     ----------
    panic()                              panic()
    vpanic()                             vpanic()
    panic_try_force_cpu()                panic_try_force_cpu()
        cmpxchg wins                        cmpxchg fails
        redirect = A                        old_cpu = A
        IPI -> C                            return false      <- BUG
        return true                     panic_try_start() wins
    panic_smp_self_stop()                __crash_kexec() on B
    (A stops)                            (target C bypassed)

The loser must stop, not fall through. It cannot just return true,
though. A CPU that already won the redirect cmpxchg can reenter
panic_try_force_cpu() on the same CPU, for example a nested NMI during
the message formatting, before the IPI is sent:

             cpu A (1st)                  cpu A (nested)
          ----------                     ----------
    panic()
    vpanic()
    panic_try_force_cpu()
        cmpxchg wins (redirect = A)
        vsnprintf(msg) ...
            <-- NMI, nested panic -->
                                     panic()
                                     vpanic()
                                     panic_try_force_cpu()
                                         cmpxchg fails
                                         old_cpu == A (this CPU)
                                         return true   <- would halt
                                     panic_smp_self_stop()
                                     (IPI never sent, panic abandoned)

Check old_cpu against this_cpu so a second call from the same CPU
returns false and falls through to panic_try_start() instead.

Also fix the panic_in_progress() check. We must not redirect when
panic_cpu is already assigned. Return true to stop when the panic is on
another CPU, false to proceed when it is this one.

Update the panic_try_force_cpu() doc comment for the new return value
semantics.

Fixes: 2e171ab29f91 ("panic: add panic_force_cpu= parameter to redirect panic to a specific CPU")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260705164123.18746-1-include@grrlz.net
Closes: https://sashiko.dev/#/patchset/20260707172252.4842-1-include@grrlz.net
Cc: stable@vger.kernel.org
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/panic.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 213725b612aa..010b331658b6 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -371,8 +371,9 @@ int __weak panic_smp_redirect_cpu(int target_cpu, void *msg)
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
 static bool panic_try_force_cpu(const char *fmt, va_list args)
@@ -396,16 +397,20 @@ static bool panic_try_force_cpu(const char *fmt, va_list args)
 		return false;
 	}
 
-	/* Another panic already in progress */
+	/*
+	 * Don't redirect when a panic is already in progress. Stop this
+	 * CPU when it's another one, proceed when it's this one.
+	 */
 	if (panic_in_progress())
-		return false;
+		return panic_on_other_cpu();
 
 	/*
-	 * Only one CPU can do the redirect. Use atomic cmpxchg to ensure
-	 * we don't race with another CPU also trying to redirect.
+	 * Only one CPU can do the redirection. Others should go offline.
+	 * Continue with panic() when we already tried the redirection
+	 * from this CPU before, for example via nmi_panic().
 	 */
 	if (!atomic_try_cmpxchg(&panic_redirect_cpu, &old_cpu, this_cpu))
-		return false;
+		return old_cpu != this_cpu;
 
 	/*
 	 * Use dynamically allocated buffer if available, otherwise
-- 
2.47.3

