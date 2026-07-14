Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2712F747A;
	Tue, 14 Jul 2026 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784050277; cv=none; b=LLBo7cp4EJs9KgeMpxFrKa8jfF13x4+9u13ESX4ZfMz52fWsy1hEV08xRtDlcimiJVqJEEf8KMXgnw8GdArbLTj2WarBERz2fdXsdVZkUTt+aels1yucGSw+Vqh4xaTjIlV0ngt4MS621HLtzyV4aHBjgTtF+SnxzVksfX0lZh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784050277; c=relaxed/simple;
	bh=w1mYjv8GbbGlh4L3ZkV5ZAOlY2kZDkhvdzF2MV31uXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aS6e5/rJbXRu7m+os1dCGqF9Z8V0B4MDdWSXwD86eY3cEOWEc6Dy1h/oQ1vvcUggPOiJOGVhpQ1TJnaNG5tbo+9IZmtaouSV/wtcuAT+NhgEu90YwVW9NJrUt9GhyME94hp9WHc/FdQGSr0ybHT27CBh0CiJ9iNtV9lnzQ27+9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=dsC0w/N4; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="dsC0w/N4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1784050272;
	bh=VSvZ2YmFYJgswAHCUCoQI7VB4pGV7FI8gD3I7LgNYB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dsC0w/N4Hi+6pNWEqkFywPQuy3K8QsIArIpcpKexwqPotzSlpzuPrXV0off1wwd2o
	 cd/mViiRY4yO19hC1CmGF4T/Sv+i+3IiPSwcm8apt2Ggibo3V0spN4e+j40DDCyrCG
	 jn4Xr5motEY2HDi117gJfamSJpXUWqNwJPTjVC5k=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4h05v42Zg7z112m;
	Tue, 14 Jul 2026 17:31:12 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4h05v263L3z112c;
	Tue, 14 Jul 2026 17:31:10 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: akpm@linux-foundation.org
Cc: pmladek@suse.com,
	feng.tang@linux.alibaba.com,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	include@grrlz.net
Subject: [PATCH v4 1/3] panic: fix redirect CPU race in panic_try_force_cpu()
Date: Tue, 14 Jul 2026 17:31:00 +0000
Message-ID: <20260714173103.11585-2-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714173103.11585-1-include@grrlz.net>
References: <20260714173103.11585-1-include@grrlz.net>
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

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260705164123.18746-1-include@grrlz.net
Closes: https://sashiko.dev/#/patchset/20260707172252.4842-1-include@grrlz.net
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/panic.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 03f1eef07b17..4b1de407a73a 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -396,16 +396,20 @@ static bool panic_try_force_cpu(const char *fmt, va_list args)
 		return false;
 	}
 
-	/* Another panic already in progress */
+	/*
+	 * Don't redirect when a panic is already in progress. Stop this
+	 * CPU when it's another one, proceed when it's this one.
+	 */
 	if (panic_in_progress())
-		return false;
+		return !panic_on_this_cpu();
 
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
2.53.0

