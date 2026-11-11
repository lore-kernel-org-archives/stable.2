Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794412530;
	b=sCtb3oRJUeaDFVsDBv8BsMRXncmpNmFN+Jh2Ul873TWs1AgPBEKrroSAprg/tKn4Dx2U
	 uiXYf2ojppRzTpT+YlZeqsNhd+qnHrP61fb3E2N5bL/prd99r6HhSeJ8aHM/NoQHtpNDV
	 J53XMD/z6x5st7Wk4X7oR2gQzX82S2UxsMbxYLz2ovWJixdzMYwcf0qYjis1Ea8Kee1jo
	 qFepFJ0FYR76O2ABwxEE9bAQJnZfrTkNffeylFi4msgdlz51klcxFNUhfSTpbDGGyZSk1
	 IE45Jbrpz8/r7vH1uM1GGmDH9UQF/jwqQsxZenrSsPXSG/+KdXbWgJQ2jHKQMQJ7E5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412530;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=N4UmSSvEy8BAoG/P5LOTvkXny9D+XbCkM/1PpgCvp04=;
	b=T1zQPIMZ20wVsqm3uRNG2BzT2wJstfbDUe5OmT4X4YpqREY5XqmGoBgKq/fECuZBLtfb
	 +J1/2fXWo3VWwRObPuAcOyi3pzTM6I5IZ/3RlwOXMPx4PBhbyOOG06wa+3pBOXdj/r08W
	 815GbqL4IQVINb/lX9grfjUUASMBu208htY/UExQ03zLCLkqk+QKtFacf/FB3/djoqy0D
	 6PxkOGv75dyaco/Jq1J6q2qJWmxKjzN6KDeTXLlBTNQHYAJ18b4kwJT8BE/LiFTcR7FvU
	 A+5uY/8aod0LS0/wK5tPt0yDlW55gm0JuW8TH+S5JzH6yAeSvJsmjY9JPn16tXK4mcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DpwkW7YO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DED0606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DpwkW7YO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2A61F00A06;
	Wed, 11 Nov 2026 15:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794412530;
	bh=N4UmSSvEy8BAoG/P5LOTvkXny9D+XbCkM/1PpgCvp04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DpwkW7YOkcA87fdw9DcjAkY1+rKEgwzdK/jUa9LBygqFrukg0eITkrLIL8g289V8f
	 EAABDfK4v0qd3jXCgy1i03AfOm5AfG0jeOopGfZiLZJXlXn5yVY/eb/ZKuZ9AmXyWG
	 FX01I89pxFfL5Penph7WU/7rHs0Q961hmP0ikGKh2pI5GO0BASUMxvlhVbOuDQOrhu
	 1aO+oHMhSDwm1NKEkb4EKfrxJexK+/TtX6OhQUrtJKb3zAT7tbbWd3hE3l89B9q088
	 mfR5DjaAOV5+PKohJEp/8dWAJWqaXHKuyp9FVQ6uk9Zs69kvR2w+wQ0uaMu7oih//i
	 cN4V4kVdHMyZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bradley Morgan <brads@mainlining.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Guenetr Roeck <linux@roeck-us.net>,
	Sashiko <sashiko-bot@kernel.org>,
	Wang Jinchao <wangjinchao600@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] panic: restore variable arguments to nmi_panic()
Date: Wed, 11 Nov 2026 10:55:25 -0500
Message-ID: <20261111155515.2677444-4-sashal@kernel.org>
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

From: Bradley Morgan <brads@mainlining.org>

[ Upstream commit ed9e4c1ff15d5b935f467811541ca0aa6e49c5d0 ]

nmi_panic() used to accept variable arguments until commit ebc41f20d77f
("panic: change nmi_panic from macro to function") flattened it to a final
message string.  vpanic() did not exist back then, so the function had to
format through panic("%s", msg).

Bring the variable arguments back and format with vpanic() directly.
The next patch makes nmi_panic() try the panic_force_cpu= redirect
before claiming panic_cpu.  panic_try_force_cpu() needs to print the
message but it is used also by panic() which accepts variable argument
list.  The string could be formatted only when a CPU gets assigned to
process the redirection.  Otherwise, there might be a race when writing
to the `panic_force_buf`.

No current caller passes a string with format specifiers.  The closest one
is hpwdt_pretimeout(), which builds panic_msg with hex_byte_pack() and has
only two variants, both plain strings.  But the new __printf() annotation
on nmi_panic() would warn with -Wformat-security there because the buffer
is passed directly as the format argument, so switch it to nmi_panic(regs,
"%s", panic_msg).

[pmladek@suse.com: changelog fix]
	Link: https://lore.kernel.org/arJxFybmtD7OBIcL@pathway.suse.cz
Link: https://lore.kernel.org/20260916182957.7788-5-brads@mainlining.org
Signed-off-by: Bradley Morgan <brads@mainlining.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Suggested-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Cc: Guenetr Roeck <linux@roeck-us.net>
Cc: Sashiko <sashiko-bot@kernel.org>
Cc: Wang Jinchao <wangjinchao600@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/hpwdt.c |  2 +-
 include/linux/panic.h    |  3 ++-
 kernel/panic.c           | 10 ++++++++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index ba08189937ec6..32e9ac24e0d5f 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -198,7 +198,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 	}
 
 	hex_byte_pack(panic_msg, nmistat);
-	nmi_panic(regs, panic_msg);
+	nmi_panic(regs, "%s", panic_msg);
 
 	return NMI_HANDLED;
 }
diff --git a/include/linux/panic.h b/include/linux/panic.h
index baf7de33aa0e6..99c53d2792b1b 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -13,7 +13,8 @@ __printf(1, 2)
 void panic(const char *fmt, ...) __noreturn __cold;
 __printf(1, 0)
 void vpanic(const char *fmt, va_list args) __noreturn __cold;
-void nmi_panic(struct pt_regs *regs, const char *msg);
+__printf(2, 3)
+void nmi_panic(struct pt_regs *regs, const char *fmt, ...);
 void check_panic_on_warn(const char *origin);
 extern void oops_enter(void);
 extern void oops_exit(void);
diff --git a/kernel/panic.c b/kernel/panic.c
index dce6197233161..0bc445155035a 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -246,13 +246,19 @@ EXPORT_SYMBOL(panic_on_other_cpu);
  * nmi_panic_self_stop() which can provide architecture dependent code such
  * as saving register state for crash dump.
  */
-void nmi_panic(struct pt_regs *regs, const char *msg)
+void nmi_panic(struct pt_regs *regs, const char *fmt, ...)
 {
+	va_list args;
+
+	va_start(args, fmt);
+
 	if (panic_try_start())
-		panic("%s", msg);
+		vpanic(fmt, args);
 
 	if (panic_on_other_cpu())
 		nmi_panic_self_stop(regs);
+
+	va_end(args);
 }
 EXPORT_SYMBOL(nmi_panic);
 
-- 
2.53.0

