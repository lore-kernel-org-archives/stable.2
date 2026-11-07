Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046937;
	b=D2YB/qxe6+k2VjZFg/GGEq8HXpVTMifTiKdoZ6hvCL7XIpUZWE0k6rLTBtuascw2GmRd
	 YTTtxd+CR9Z7+i5Eo/8zaF58bplhHsQjn+q9laCwnjo4b4JJ/gpk6EprSONiHAESGw6l2
	 PZ0ZftQinmI0qK5Dh0aHDlTk+4s8BE2SMs4dolK7ePNa19RkN9vFkMoa0cfip20uw438a
	 VmPDYaZmE3gyJOhQXO5lTK6Mi+9kz7dV9nvx0tux7rA951MMdpEaYIWHt6S9cbPIzG7Ju
	 +KNs47YSkQ4TV19kT8XEWLW2Fz8T6cJpU+9fjo5FXIw3B0Ca4UsMiM0GRukV2L7Cixw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046937;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VrnsvAyaUL3Wobe869ngAAJ8N7dj0Fk3eY3DPBSNH7A=;
	b=UCgmG+ibW0jJ8Aou+hWr0fKy2Ft0AEXM0/p7o2FFPXBJiiUrcqde4enwZ6qMKWjbf6F3
	 RayqoTt7gkyzg5vep/JB0Zde5BTA4/41j9Mq8Amv5gdKDJV9cYuevdNiM2mEs9bfgozEy
	 rYXWWNvEO/GAikGTi768YOQdUaBt3XSPLWNcjjgX8WwsvM4Wzfh8IBYG7djb1WEsQ9M60
	 UY3Ue9X8P51n9oJcGqabeJxVEaVaunlGGjL6MzF9Kaj1FLPbODpyXccP12VzsIlr1hakk
	 mwrG8DEYaRqSxbg7cPLnwdrXcLs2sh/AnK8qCpFfC1oC9d4KhNziv9KApTLbHjFq3fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOaRe7H3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF503606D823
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOaRe7H3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F7C1F0089F;
	Sat,  7 Nov 2026 10:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046936;
	bh=VrnsvAyaUL3Wobe869ngAAJ8N7dj0Fk3eY3DPBSNH7A=;
	h=From:To:Cc:Subject:Date;
	b=EOaRe7H3WoxEh0Pb/zj/mjr+DZsf8SHiFY4253UbvEzHbVEeuyY/MMNCnu9oj37r2
	 tbztdNk1JDMW5tJ1rNkqmpqBog53UmxPuuTpBcO3+0gNe2Z/WeZjoX+BNDdv0dvC0f
	 QKkyg7DUTaN1emnVoFIHhSfyR/YTQQrWfHibElin6Oo3NZcgslm9IDT+GBAM4Yw2Xb
	 P6MqTZZx8lcjZU4n58iubYUOy985YGAeWwaE1Vag9Y7E+N+lJObMuFJ2ZSdeql4aTj
	 fDagLwMKOVmsF454NDrT4+FPI/FnW7uNHNFh7Zxk3pnpL9ucKQZWVaIshkfuNA3WN9
	 z5ISv7BhCUeOA==
From: Sasha Levin <sashal@kernel.org>
To: brads@mainlining.org,
	akpm@linux-foundation.org,
	pmladek@suse.com,
	linux@roeck-us.net,
	sashiko-bot@kernel.org,
	wangjinchao600@gmail.com,
	wim@linux-watchdog.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] panic: kill the "buffer unavailable" redirect fallback" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:22:14 -0500
Message-ID: <20261107052214-failed-6.12-68d956e9e235@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 68d956e9e235c2e125f77a9e98831e297b624a75
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052214-failed-6.12-68d956e9e235@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




