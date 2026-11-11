Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794412528;
	b=Zrd7x3GKxaZaymQGR5k15GGOeF514LxUQ2zCiSo9cuNr/Il0PeqwXAkYtscvEGJ6pNZw
	 YNK9WFZLJiOIKJ+zaxnvPleT6sBplaf0+J5xyXM7EBdSnwBD12jsGIlfCv0C+U1k4mzs6
	 JR50FizeKljkNhUTskEMF8s1CoouPHRBhlsjJTrWcrXTfx2CnJJ36M8UKHsyRNc10eyjG
	 /4/uARXrB/YvjlyB1xngT4cs4Ra/tWb1z18dPkzw2zubaRLnD1dZEYU0GTa6tE3VvPeTS
	 8hZVZ83kOpKThGB9XpXhmgrjSkMGZgoKJLg6SfNp2DkyYy0C41beRvM3fQbq3ZDueGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412528;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Li3/2+Dw3+eIilIJtFzmZ1Ta/kOk3NbRS8rcUQ99uLY=;
	b=X8oRV8cws9n+CEAkv3Y2nLUaJ2NtWZIp4om/v7qEgcZzfFXq4MMc1bnk7INMMfHWxwyj
	 QDzr9XalwqN6Xxx41NwJn971jymuOlbwUkAFRH3ydvn5BjDLH4If8uZ4eJbgD34U6t2kG
	 TME8F8INHyHOF804KnZsa/T0CIcDDISW8mk47OARIe+Z3XFCZ4WcpA1SOmFvFl+7Zl0AS
	 nbMC/5P35Awx4gSA9rX3Ufo3BpUzn6J7lEm8iVL8A84XQlxLut7snjKnk5kc4+A0cCah8
	 0zeQZxq52tiOkFzL5sMqJf4LTRlIKvxO0thUycBW1tx0iWQGtsShmNtXecGQ0bfu+AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3c3Y8rO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B91E606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3c3Y8rO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831121F00A06;
	Wed, 11 Nov 2026 15:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794412528;
	bh=Li3/2+Dw3+eIilIJtFzmZ1Ta/kOk3NbRS8rcUQ99uLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S3c3Y8rOkcE6x3z0pjA8/p7SpsR41FScY2rmsOKtJ9zuQJtKx1jNoDfFETvIWXeOt
	 DrxNRu03je6Etg/LU03ug9DwchDMo3FLtiUMXO1VZf4ZQ42u0jUaIXPmsfIaJZd7eO
	 cOcRtZ0x26wc72D6YkU9w10ou3t76s3ndsshmjcrqPMEQcUYZhzuiqWi5QKxm4v9Zf
	 P8m2RavVb5ZBF9vTltfYv0P9CydsvGSxxaV0D9+4kG4LyEQNw8tPdPfGHUcp5XVhht
	 3nUri8lbCYH2yIo+dyl8oZfYlBSi+wytVPSgkmypHD8NzhriBFr2lw7Q2Mx7YJnTXA
	 i8qy3eZExa5aQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] panic: Add vpanic()
Date: Wed, 11 Nov 2026 10:55:23 -0500
Message-ID: <20261111155515.2677444-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111155515.2677444-1-sashal@kernel.org>
References: <20261107052212-failed-6.12-ed9e4c1ff15d@kernel.org>
 <20261111155515.2677444-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nam Cao <namcao@linutronix.de>

[ Upstream commit 3f045de7f557850ca6b3632c6d45c2cdaf948694 ]

vpanic() is useful for implementing runtime verification reactors. Add it.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Stable-dep-of: ed9e4c1ff15d ("panic: restore variable arguments to nmi_panic()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/panic.h |  3 +++
 kernel/panic.c        | 16 ++++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index f0b779d2915e6..baf7de33aa0e6 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -3,6 +3,7 @@
 #define _LINUX_PANIC_H
 
 #include <linux/compiler_attributes.h>
+#include <linux/stdarg.h>
 #include <linux/types.h>
 
 struct pt_regs;
@@ -10,6 +11,8 @@ struct pt_regs;
 extern long (*panic_blink)(int state);
 __printf(1, 2)
 void panic(const char *fmt, ...) __noreturn __cold;
+__printf(1, 0)
+void vpanic(const char *fmt, va_list args) __noreturn __cold;
 void nmi_panic(struct pt_regs *regs, const char *msg);
 void check_panic_on_warn(const char *origin);
 extern void oops_enter(void);
diff --git a/kernel/panic.c b/kernel/panic.c
index d5307a8e89283..dce6197233161 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -327,13 +327,13 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
 /**
  * panic - halt the system
  * @fmt: The text string to print
+ * @args: Arguments for the format string
  *
  * Display a message, then perform cleanups. This function never returns.
  */
-void panic(const char *fmt, ...)
+void vpanic(const char *fmt, va_list args)
 {
 	static char buf[1024];
-	va_list args;
 	long i, i_next = 0, len;
 	int state = 0;
 	int old_cpu, this_cpu;
@@ -384,9 +384,7 @@ void panic(const char *fmt, ...)
 
 	console_verbose();
 	bust_spinlocks(1);
-	va_start(args, fmt);
 	len = vscnprintf(buf, sizeof(buf), fmt, args);
-	va_end(args);
 
 	if (len && buf[len - 1] == '\n')
 		buf[len - 1] = '\0';
@@ -523,7 +521,17 @@ void panic(const char *fmt, ...)
 		mdelay(PANIC_TIMER_STEP);
 	}
 }
+EXPORT_SYMBOL(vpanic);
 
+/* Identical to vpanic(), except it takes variadic arguments instead of va_list */
+void panic(const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	vpanic(fmt, args);
+	va_end(args);
+}
 EXPORT_SYMBOL(panic);
 
 #define TAINT_FLAG(taint, _c_true, _c_false, _module)			\
-- 
2.53.0

