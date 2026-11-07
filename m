Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050557;
	b=TCOlspoYIukt3MigIhv/YCNdFhEheYjxdgt9mjPbWfzFlQbgG6brsXHKpo0g9RgyAGCa
	 sVM1cq/qwuCcc9pzyhL32cTcRLkfCpyk0GsHkvfzTjAgm2I8saJnU0Ee4kYdEz0JPira3
	 NKEe3sHjpc+fO0Dmgfhae8jn0xZXh0NcEKHabnKonCPBRXsDsSQw2GggZgJkSfp0hzmHQ
	 06hbDv5LYOH4YB5Bftn267r4feCrFMjkGijso44VF2p5ZX6XF44DWhrtJpXhheeT1TdDz
	 mL2rDWnnHA+tfJdzqgDPMi5QcwYg/cDxkW+hy4zl/n0wT3dWDDw//EVScTPUwRlAJpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050557;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=59VwXCbuqBFNVKcJfl0EJ+CVMtqmZs0in3K6Av2BUsg=;
	b=48EereO1YBM9SstHpRXBXolrWKtvt930CvqrY2qKThAUvBmaeJE89jcVNsdgAfjdCpBg
	 Akx/a6PEF6sNEOD3NFXNihGhM8gi6kZ0byVSAiFXE1CIqIGVlpbjYFjr1tdGpU2fpyTQW
	 LACeZlLZByHYYgHOO9qokVsnsgrBUzx/Hv2G3E5qBvaFQi8rqQb3G6RQ43JisD/dQkpKl
	 fL37800sDij7vGnjtj1Bd3/Rp8U6u9/ZcMRvSxJ9rwWq1Tc4MutESA8sdC3gZQ25ZU45b
	 8SaVHesO8gqW7PtXZ6xnjvwHGiX4WxbHZAinMtY93blfukcxC1Gy16K1tqRmQxO+aag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fzms5tye;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F000606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fzms5tye
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFB51F0089F;
	Sat,  7 Nov 2026 11:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050556;
	bh=59VwXCbuqBFNVKcJfl0EJ+CVMtqmZs0in3K6Av2BUsg=;
	h=From:To:Cc:Subject:Date;
	b=Fzms5tyeIas3ZLpnB5CtSOeGCyoxUsxH8EZaSG9UcfLf5UKMI425R+I0K5AVjsboF
	 S5fAYmYAPozUFnBTEvO5o+5GMNY05CJgodgquRTkbWiyLXXRJq/DbyL6hVwlq6inl9
	 WKYedgUurY0b9g/jdba+Yn/lSle+XZR/DlsSLCiZu8CJtIdIWm8sS827wQCJmOvt3J
	 ev3YnM2y5/j3X5KDoD+8a8Icc66xoaFdkvUKeG7kRvAbl3dQpW4FA02CUJieVM7HAS
	 6R4OC/xO0bXzPX6bOS0Bn2QWCArdQJl1Ifmnaqc3RqSX+Hhqj4dFg1cGAbj00PKtkA
	 9fOkjR8F5su7w==
From: Sasha Levin <sashal@kernel.org>
To: brads@mainlining.org,
	akpm@linux-foundation.org,
	pmladek@suse.com,
	linux@roeck-us.net,
	sashiko-bot@kernel.org,
	wangjinchao600@gmail.com,
	wim@linux-watchdog.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] panic: restore variable arguments to nmi_panic()" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:22:34 -0500
Message-ID: <20261107062234-failed-5.10-ed9e4c1ff15d@kernel.org>
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
git cherry-pick -x ed9e4c1ff15d5b935f467811541ca0aa6e49c5d0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062234-failed-5.10-ed9e4c1ff15d@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ed9e4c1ff15d5b935f467811541ca0aa6e49c5d0 Mon Sep 17 00:00:00 2001
From: Bradley Morgan <brads@mainlining.org>
Date: Wed, 16 Sep 2026 18:29:55 +0000
Subject: [PATCH] panic: restore variable arguments to nmi_panic()

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
---
 drivers/watchdog/hpwdt.c |  2 +-
 include/linux/panic.h    |  3 ++-
 kernel/panic.c           | 10 ++++++++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 8af1fad2de0bd..78227d200afe4 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -199,7 +199,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 	}
 
 	hex_byte_pack(panic_msg, nmistat);
-	nmi_panic(regs, panic_msg);
+	nmi_panic(regs, "%s", panic_msg);
 
 	return NMI_HANDLED;
 }
diff --git a/include/linux/panic.h b/include/linux/panic.h
index 98dd7dfd27de7..17e61b61c45f8 100644
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
index 7388eb81a1c47..e240ca06faab2 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -518,13 +518,19 @@ EXPORT_SYMBOL(panic_on_other_cpu);
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




