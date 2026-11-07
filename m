Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049556;
	b=B0Iu8d9KLB9YIuk12WcRKe1F5PIIjZeZOfOHhKjP2S1lC9+CryJwB3gl+bIvHeyeGIVB
	 /1rtbNRiOzVNijNz7ZJh3WGBlE0nz4mMWqtyGiXrMqpL9lNzcIRFFbxWY4ySAhkcM0jvU
	 bzh+vtSq4POWb8lxZDEzd/HIJJUxAjvj7wPcGBUj2PqplnMVyoAmHacI0bGjsu7UgVSWJ
	 CPab+RorpzpwMQf+NkYdkwMzmeWwi06IX6IxIX7CaODYTT5xKj2EQMJuUtskCkSyMDM5v
	 Vqs9/Jz3B+RcPsjsJD2DAdKTLgW/e1D9TJpvoX/lG1+QHDYr5n/ujcBYRrFITiafj0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049556;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TMNics0MfC5Xco1oD5sEeYWxnlcZJSZpAqxSJTEwUPo=;
	b=bz2G+aBzOnIolaRsRgBMfUQa0cb6vccTRHhj1NZqZ7rHNGcXRmm9hc0H/6CRYXFf/j2b
	 b16NQR5CiiRcEqa0tfXyfIX/mlY/Uk64Ub8fQV58/PHT2sYh3/lrTJWbyxcljBY7cIEaX
	 /1wMxKnnl4kw7D2Vs0I13LWut6dkspDF4usrPywNCHzwBLW/Ol0hkGS+qvtDUtYRa+5nT
	 h/6fLVaRxizYetC3o+QGdRKdEm8Zi2FW1Cvj/p9LjV6N44UkLxyHIn/G88o7oqpwXmfe8
	 H6obJyYnnhKMB5R9Z9qOSaq3SYnKI8pxPlJI75Iy4Zd3fQQ0bh5tUZ2Z40vbmiHvbLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WnKxQO06;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B778606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WnKxQO06
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A441F0089F;
	Sat,  7 Nov 2026 11:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049555;
	bh=TMNics0MfC5Xco1oD5sEeYWxnlcZJSZpAqxSJTEwUPo=;
	h=From:To:Cc:Subject:Date;
	b=WnKxQO0656P17BLnaHqxkv7f5AhpfMthPgQXFCp5c29laWj+T6RwFcwUk5hsnxX4q
	 INxq1cswtC0OIm8laqAb3SwXvYwc+9FmUQJVDViPQy2RjN4lds0RfRS4seODyqs6yR
	 xC++BTJUjVUVKLhxMNvz4xXAGbehZ6Y1qmtGluwbIFcCmLIejBcVblCoWlzaeUvwqR
	 3of2lexoZwuSJ27uFM0IKRJIzv3Hk8VW9AOIHOLEwCWvgKOnYsO0nZkJ+hTW4Zi6LM
	 ClXOh4emnAaPSrO16BV4Y2S4Ncaw3nwVOznSM31rs473bYprY8K6LYDkQ6SYNGcuVO
	 d5WFdrhJHHEvA==
From: Sasha Levin <sashal@kernel.org>
To: brads@mainlining.org,
	akpm@linux-foundation.org,
	pmladek@suse.com,
	linux@roeck-us.net,
	sashiko-bot@kernel.org,
	wangjinchao600@gmail.com,
	wim@linux-watchdog.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] panic: kill the "buffer unavailable" redirect fallback" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:05:53 -0500
Message-ID: <20261107060553-failed-5.15-68d956e9e235@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 68d956e9e235c2e125f77a9e98831e297b624a75
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060553-failed-5.15-68d956e9e235@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




