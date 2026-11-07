Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050570;
	b=0k4IsPTH8ebDpTjQK2a2mhsmfu/va35L9m7aj3YfwDv6t2tjyFRV7L6ih+dFw6N8409C
	 d8AWaCIimpWmskWjq9qrqdPlaAfz1GqjdxRg1Il6/a8VeDacQM6qKDLK2DAQozAAHF5Bt
	 eR+39F6vwFpnH4dPbyPizs4KUagYtH85tqO2btIc4rcrFnDxr/ExFG4hSHv7gyUlI7uCd
	 l4i0mXZ5RhZcuHRTv/Q0THClj0angakQs53CzRoG17MKpQrt0xvFSVl9QCwYSeANqAMh9
	 KojPvLQ7OJIybUPg21sSAPFfwtCzS+inYcBWkhY0ZUWuZiNWIUvqZOPv04Y8xXJWt1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050570;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UgBw0NvvvVGZeiQ5LMalVjVMdBHxnb14W2KdgXVjYH8=;
	b=kRXad1ELG/TbuZOFO8Z7yhleRaRRl2XJp6V36R1gfIEj/JSw5zMEoPHwxc/SaEbRQ8So
	 xCM/7I/UqoulhR+baBsWKAFcMOrTi982AG0A6U9+dVAGh8YTpljaPM8UAgatz4FEhEb4A
	 SjkUMg69A+iyJxGQcUHaoc0DoR3nk8MgODX54sUOWSWZM1sTkgHSAnYCxednF82V9QI3F
	 cGiEtbE2BOuaQ4gwN6dcH0RdkJnvmZ+LJTe/9mc+wJ5QSjfR0091RRi+9s5/t1LC5+Qmc
	 pXL6cjM1vzYqLZYIy8Kt3P8yicGHiwBb9ufH7rBjSCWu9qLLcoAVOuItnJ8lJnxPhmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="E/wlyEUw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607DE606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E/wlyEUw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBC91F0089F;
	Sat,  7 Nov 2026 11:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050570;
	bh=UgBw0NvvvVGZeiQ5LMalVjVMdBHxnb14W2KdgXVjYH8=;
	h=From:To:Cc:Subject:Date;
	b=E/wlyEUwGvk6UKnTGeXrJK6WdX480nil9qc4TuGVEMc2yIpsGkB3rVNmRqgoBQ4gp
	 h0WDLAN7aIqJHQox6Z+Tzm4OgVR1wotIsc8AhSN+zV4ElqB5zQo6s8EmwYHjemCDto
	 z1Z3vo36bUQ2EymFMCrU8t0PexTmT6UwCIUg8+Jj8rpPS7OWHRHi6HS74keRCrRfZ8
	 BAz9F3eJImuxzO8d1ezbDIlC4sHX1QAR8OMpp1hM6svlCxsMPCy8J8hH6gSPra0Inu
	 x9231mE77ANEnLIUOE8bLqUzykoE1SmQ+O1gXZvEpXNpqxZxzYGegouI++nqufuWcp
	 dBD7hfwszB/AA==
From: Sasha Levin <sashal@kernel.org>
To: brads@mainlining.org,
	akpm@linux-foundation.org,
	pmladek@suse.com,
	linux@roeck-us.net,
	sashiko-bot@kernel.org,
	wangjinchao600@gmail.com,
	wim@linux-watchdog.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] panic: kill the "buffer unavailable" redirect fallback" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:22:47 -0500
Message-ID: <20261107062247-failed-5.10-68d956e9e235@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 68d956e9e235c2e125f77a9e98831e297b624a75
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062247-failed-5.10-68d956e9e235@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 68d956e9e235c2e125f77a9e98831e297b624a75 Mon Sep 17 00:00:00 2001
From: Bradley Morgan <brads@mainlining.org>
Date: Wed, 16 Sep 2026 18:29:57 +0000
Subject: [PATCH] panic: kill the "buffer unavailable" redirect fallback

The redirect buffer is a disgusting terrible hack.  panic_force_buf is
kmalloc'ed in a late_initcall, and until then the redirect delivers this
as the panic message:

  Redirected panic (buffer unavailable)

The whole point of the redirect is to hand the panic message to the target
CPU, so the crash kernel boots knowing it panicked and not why.  And that
window is the entire boot, from the early_param to the late_initcall,
which is exactly when you most want the message.

Make it a static 1KB buffer and kill the initcall.  The cost is 1KB of
.bss in SMP crash dump builds, and it is only ever touched when
panic_force_cpu= is set anyway.  The local msg variable is gone too, the
buffer goes directly to panic_smp_redirect_cpu().

Link: https://lore.kernel.org/20260916182957.7788-7-brads@mainlining.org
Signed-off-by: Bradley Morgan <brads@mainlining.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Suggested-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Cc: Guenetr Roeck <linux@roeck-us.net>
Cc: Sashiko <sashiko-bot@kernel.org>
Cc: Wang Jinchao <wangjinchao600@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: <stable@vger.kernel.org>
---
 kernel/panic.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 29c981926f5f3..170744163fc2a 100644
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
@@ -380,7 +369,7 @@ static bool panic_try_force_cpu(const char *fmt, va_list args)
 {
 	int this_cpu = raw_smp_processor_id();
 	int old_cpu = PANIC_CPU_INVALID;
-	const char *msg;
+	va_list ap;
 
 	/* Feature not enabled via boot parameter */
 	if (panic_force_cpu < 0)
@@ -413,20 +402,11 @@ static bool panic_try_force_cpu(const char *fmt, va_list args)
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
 
 	console_verbose();
 	bust_spinlocks(1);
@@ -441,7 +421,7 @@ static bool panic_try_force_cpu(const char *fmt, va_list args)
 		dump_stack();
 	}
 
-	if (panic_smp_redirect_cpu(panic_force_cpu, (void *)msg) != 0) {
+	if (panic_smp_redirect_cpu(panic_force_cpu, panic_force_buf) != 0) {
 		atomic_set(&panic_redirect_cpu, PANIC_CPU_INVALID);
 		pr_warn("panic: failed to redirect to CPU %d, continuing on CPU %d\n",
 			panic_force_cpu, this_cpu);
-- 
2.53.0




