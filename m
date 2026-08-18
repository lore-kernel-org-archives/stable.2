Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9393B27466A;
	Tue, 18 Aug 2026 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071427; cv=none; b=sq+vO9OZuR+2NOLQ7WD+QAV3A/Fyyu9PeA5rQGqZHCjsNl1oBcAuVif4abALIKDlcfm0AvcVo5OoLt2fs+gnETiejNNppnr8P/FdAyQxuWt7xulYOCRogpxAuiJ6WFS0fDSsg1FT9cBsCqnJYpSfPJColkVUWLNbbZvxXA/U9Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071427; c=relaxed/simple;
	bh=fHWd0JzSqc9d9gw3vYGeNRWW4xD1Lr6AARkkmQz8jZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipvgl6W/WkOFM1wT2AB6J6O2OGjrelec9IcTsjIrIYRd+olku6jsUuwxwGdYBtZAbewyFtff9NVrZPa5bVuxZw7u35IQkRa7dLuOLKLiBXGgEkQ2smNM3xLNq2cXJivpAQlLPeR0kN9xwyRTyN/gDM5B/9YqJ9EmIrP1jn4AHwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=WsCn066/; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="WsCn066/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787071093;
	bh=XN+gRENczvMpAtzyfo4mL9HSCxiCo5ZA3Ax1qyovq8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WsCn066/mNGw7U84qHNuDtlRwY5cOvUz2dCj72MofdtY6uvF8tP6bJr4jbdlihMuD
	 xrAR64Sg/3y070x0dGXdveWdKl5UR4WvaajgloFGcYVAjc1musm3MobWK03pv8UDDP
	 qDdEGG6Iyz2nGcWOIhTd9M9LArYTjiKh7nZ7c32E=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with UTF8SMTP id 4hPb3n0Spcz10vQ;
	Tue, 18 Aug 2026 16:38:13 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4hPb3m530Gz10v6;
	Tue, 18 Aug 2026 16:38:12 +0000 (UTC)
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
Subject: [PATCH v6 6/6] panic: kill the "buffer unavailable" redirect fallback
Date: Tue, 18 Aug 2026 16:38:06 +0000
Message-ID: <20260818163806.17460-7-include@grrlz.net>
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

The redirect buffer is a disgusting terrible hack. panic_force_buf is
kmalloc'ed in a late_initcall, the return value is not even checked,
and until then the redirect delivers this as the panic message:

  Redirected panic (buffer unavailable)

The whole point of the redirect is to hand the panic message to the
target CPU, so the crash kernel boots knowing it panicked and not why.
And that window is the entire boot, from the early_param to the
late_initcall, which is exactly when you most want the message. A
failed kmalloc just keeps it broken forever, silently.

Make it a static 1KB buffer and kill the initcall. The cost is 1KB of
.bss in SMP crash dump builds, and it is only ever touched when
panic_force_cpu= is set anyway.

Fixes: 2e171ab29f91 ("panic: add panic_force_cpu= parameter to redirect panic to a specific CPU")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/panic.c | 32 +++++++-------------------------
 1 file changed, 7 insertions(+), 25 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 356c03f2361c..b41a7efc0931 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -307,7 +307,7 @@ atomic_t panic_cpu = ATOMIC_INIT(PANIC_CPU_INVALID);
 atomic_t panic_redirect_cpu = ATOMIC_INIT(PANIC_CPU_INVALID);
 
 #if defined(CONFIG_SMP) && defined(CONFIG_CRASH_DUMP)
-static char *panic_force_buf;
+static char panic_force_buf[PANIC_MSG_BUFSZ];
 
 static int __init panic_force_cpu_setup(char *str)
 {
@@ -326,17 +326,6 @@ static int __init panic_force_cpu_setup(char *str)
 }
 early_param("panic_force_cpu", panic_force_cpu_setup);
 
-static int __init panic_force_cpu_late_init(void)
-{
-	if (panic_force_cpu < 0)
-		return 0;
-
-	panic_force_buf = kmalloc(PANIC_MSG_BUFSZ, GFP_KERNEL);
-
-	return 0;
-}
-late_initcall(panic_force_cpu_late_init);
-
 static void do_panic_on_target_cpu(void *info)
 {
 	panic("%s", (char *)info);
@@ -381,6 +370,7 @@ static bool panic_try_force_cpu(const char *fmt, va_list args)
 	int this_cpu = raw_smp_processor_id();
 	int old_cpu = PANIC_CPU_INVALID;
 	const char *msg;
+	va_list ap;
 
 	/* Feature not enabled via boot parameter */
 	if (panic_force_cpu < 0)
@@ -413,20 +403,12 @@ static bool panic_try_force_cpu(const char *fmt, va_list args)
 		return old_cpu != this_cpu;
 
 	/*
-	 * Use dynamically allocated buffer if available, otherwise
-	 * fall back to static message for early boot panics or allocation failure.
+	 * Do not consume args, the caller reuses them if we fail.
 	 */
-	if (panic_force_buf) {
-		va_list ap;
-
-		/* Do not consume args, the caller reuses it if we fail */
-		va_copy(ap, args);
-		vsnprintf(panic_force_buf, PANIC_MSG_BUFSZ, fmt, ap);
-		va_end(ap);
-		msg = panic_force_buf;
-	} else {
-		msg = "Redirected panic (buffer unavailable)";
-	}
+	va_copy(ap, args);
+	vsnprintf(panic_force_buf, PANIC_MSG_BUFSZ, fmt, ap);
+	va_end(ap);
+	msg = panic_force_buf;
 
 	console_verbose();
 	bust_spinlocks(1);
-- 
2.47.3

