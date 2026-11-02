Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793643383;
	b=gfNUEbOzauvwWzU5I8sCEqXcTR7BmcvxV2q+q1EjHjJa3OXv4WUjjUv0lywjFcPHWgya
	 dEhCaTYEeUqdGrylu/w2CXG+vgDOSd0Sta07k+m6QPi4729Zv+PM+xvHA4p+vI4GWOfcw
	 88W0x00RpSxC2ob6ncIJUm8swVCd6xNv/IWf5k+GR7PjdATDVXeZDfCnsTyfUxA7xewPF
	 J+wyMwRiOFKN5CxBZRWnzuHIVLN0LOwJfGmsV04FuigxFBrpeJx9N9f3sl5mWJv+rn+Kt
	 nRro2exnoXlrJVrx/i6tRfMoJ2BtPScUDCYzraq/XUY1XWEacupagL/A0KFddmWUJTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643383;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=N9NuhjaQA7Vgqi9vuUF5hnhnomZtdYB10OuLNrlq1Uk=;
	b=mPOllSFfnOqrw6pK5TAUUni7KHiiDtVHPaGJcGANi3HvOyTQVwedrefH3eFTb8OamwHq
	 wgoc/uDzM527U9xtPRnUyOcY1EgAohQH++ZrwkoVjV0oOkDT3DPv1xbb5qBJ3rXf4LPuo
	 j42+RjcC7zXRo9jxUA/ZbnIDqZ8zTFuQ700xWYEjhBZJl5d5MM2Yy7h5qTH+zJNxWfrKu
	 PBbyLR1VuTrdjc9U8jtIDVYlmrrtAUrmgrtxSK9ER1WHGBbXFposBZPPmYd08sxtHqWVZ
	 ry3hogL8NUX//tMzxCg+/VljT6huf9VWvebgHVc4m7s9fuZRX2fe0F65v79ITk1gFGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=GlNQxF9v;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E7D606A32F;
	Mon,  2 Nov 2026 18:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6E7D606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=GlNQxF9v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=N9NuhjaQA7Vgqi9vuUF5hnhnomZtdYB10OuLNrlq1Uk=; b=GlNQxF9vnGO72iy0e/u3Z4fqcP
	vbrtx+IQNP47Q7ekSD4Q+4YwCwpgf0zxAUt84kH+4Bp/LgSxW2ms9XXIRmFxW5tRe/nKYVozbm9MQ
	i4f0mM3MzDEoARJrsSGMpcTWMK/WN+8ZUuyuLw65izKLZ+l7NC4xf6PJF46N68GsJ+ucIE6r8Zv1v
	773B5Rju0OEzoqvkXFv5HNGTjWeLV3iueI7xfpkqNt18AOaPaHYEJBK87tO8eQtcqbXwbqvqt1xo8
	62pwNF8TdvnWULCECQlQo4681Wg7RXiuHxdUYDJSj+BCH2alXd8GjGUtqkVh1hCnDnzelsCG1t/rC
	Ar0rmJwg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xNwZw-006L5B-2B;
	Mon, 02 Nov 2026 18:16:20 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 02 Nov 2026 10:14:55 -0800
Subject: [PATCH 2/2] crash: Flush unsafe consoles before
 machine_crash_shutdown()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-panic_unsafe_flush-v1-2-12d1e22fd6d8@debian.org>
References: <20261102-panic_unsafe_flush-v1-0-12d1e22fd6d8@debian.org>
In-Reply-To: <20261102-panic_unsafe_flush-v1-0-12d1e22fd6d8@debian.org>
To: Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>, 
 Kiryl Shutsemau <kas@kernel.org>
Cc: linux-kernel@vger.kernel.org, printk@lists.linux.dev, 
 gustavold@gmail.com, samuelcrossley@gmail.com, ryan.roberts@arm.com, 
 brads@mainlining.org, x86@kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3383; i=leitao@debian.org;
 h=from:subject:message-id; bh=PEgly2nrOBmRoGLBh6KuvNEk+JIGyOZAWyTxUecxtSw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq6NNmYufl7gexU6p5spkNYWtTqVKfxp+Yp8u8m
 2Oguq+XeEaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaujTZgAKCRA1o5Of/Hh3
 bSYeD/9QPzjWlYPyyVDAjK34PGG/Dwh/KXs5/3uOZJ32mclG0SviP0VyFxG5yZ+s4AZhS5Tpds4
 qhwD5sDfpNZ8cEtvaVlRhDUlcJe06WaEuL+kCvpRgsLt2H72Xa7ifvNtgK+4wMNrAE0kXvrJnO6
 d5YLL2aN8e+cvJuMZSQyuxmxa7WHP0pVbRglbt3KSXzML+nurXly5ZG5bPfu7EEKDVvJEdEs0me
 p6+8ots+kays3Fbzc6GuvhdraFvHMHA5nEl9SRyJKkhjNJ3K1/GEb10wSshSxCTOvMmjgZqeyA0
 /FIrscVfgbpOxcIHZJpDZi8/SASaRdnu7AiEvWO1nQtqZB+44VdLhAfkFBfwo5rbWkUUd4Z4UYl
 GWdbaodkBRt9mAhlEdSD4uVJjCh4iVFuV7uKx3M4i5ructCUXKG5q695aUX7co75IAKQIbjbNVD
 OkoJS7RysibKLyrJYhkVOkXBzprmjMUGNsgF5m1rJTm1Egd2dy1xT7AfXsM21Id7C3Vv+ihbgL6
 nAFjAH+cosoeNuI6AAmWgLBR5x/7+a2LKjTez/oe5bsECGGq3LszR2hoxxZ7wgQT4ajs6SfsXM6
 KVXfR38ir5r+wCrwbdfK6cU72KkgdEnXDXIgP5qCwYIYheSRqehUykS2whzA1/wgInksyOukkFN
 Me/Pbo2M3MWfujg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

On x86, an oops that goes to kdump never reaches netconsole. oops_end()
calls crash_kexec() after the oops is printed, before this CPU becomes
the panic CPU, so printk() skips the unsafe consoles for the whole
report. Unless something fails, nothing else is printed on the panic CPU
before machine_kexec().

Add nbcon_atomic_unsafe_only_flush(), which flushes only the
CON_NBCON_ATOMIC_UNSAFE consoles and allows unsafe takeovers on them.
Call it in __crash_kexec() before machine_crash_shutdown() tears down
what they may need, such as the shared memory of a TDX guest. As with
the legacy console, the other CPUs are still running at that point,
unless crash_kexec_post_notifiers is set.

When kdump comes from panic(), printk() has already flushed the unsafe
consoles and the call finds nothing pending.

Fixes: 187de7c212e5 ("printk: nbcon: Allow unsafe write_atomic() for panic")
Suggested-by: John Ogness <john.ogness@linutronix.de>
Suggested-by: Petr Mladek <pmladek@suse.com>
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/printk.h |  5 +++++
 kernel/crash_core.c    |  1 +
 kernel/printk/nbcon.c  | 14 ++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index f594c1266bfd41..95da3904c0d30e 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -208,6 +208,7 @@ void printk_legacy_allow_panic_sync(void);
 extern bool nbcon_device_try_acquire(struct console *con);
 extern void nbcon_device_release(struct console *con);
 void nbcon_atomic_flush_unsafe(void);
+void nbcon_atomic_unsafe_only_flush(void);
 bool pr_flush(int timeout_ms, bool reset_on_progress);
 #else
 static inline __printf(1, 0)
@@ -322,6 +323,10 @@ static inline void nbcon_atomic_flush_unsafe(void)
 {
 }
 
+static inline void nbcon_atomic_unsafe_only_flush(void)
+{
+}
+
 static inline bool pr_flush(int timeout_ms, bool reset_on_progress)
 {
 	return true;
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index d0bd2d0cf8990b..6580eaa86685a9 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -140,6 +140,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
 
 			crash_setup_regs(&fixed_regs, regs);
 			crash_save_vmcoreinfo();
+			nbcon_atomic_unsafe_only_flush();
 			machine_crash_shutdown(&fixed_regs);
 			crash_cma_clear_pending_dma();
 			machine_kexec(kexec_crash_image);
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 19fa9f79cac3cb..c22175a33ce17e 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1717,6 +1717,20 @@ void nbcon_atomic_flush_unsafe(void)
 	panic_nbcon_allow_unsafe_takeover = false;
 }
 
+/**
+ * nbcon_atomic_unsafe_only_flush - Flush only the CON_NBCON_ATOMIC_UNSAFE
+ *	consoles, allowing unsafe hostile takeovers
+ *
+ * Like nbcon_atomic_flush_unsafe(), but consoles with a safe write_atomic()
+ * are left alone. Only effective on the panic CPU.
+ */
+void nbcon_atomic_unsafe_only_flush(void)
+{
+	panic_nbcon_allow_unsafe_takeover = true;
+	__nbcon_atomic_flush_pending(prb_next_reserve_seq(prb), true);
+	panic_nbcon_allow_unsafe_takeover = false;
+}
+
 /**
  * nbcon_cpu_emergency_enter - Enter an emergency section where printk()
  *				messages for that CPU are flushed directly

-- 
2.53.0-Meta

