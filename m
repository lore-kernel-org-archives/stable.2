Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793643379;
	b=pGRc6iumJK+1cE8Cim6U7eH/fyqQkRd+wWApPJgeIzRtWCHUt06PWWZdluKiXGt07qJ6
	 HbJlMkbQ+nCxaG2h7t3YlTeA0zzNXVdgR5l0eQ2q8E60kFtiGlngHyDPOgT7QSUMNc7qt
	 BKb2u+xpBFQB6+CL8ZyWklHDVG3XJzMH8S2mGKfxVCyMXDSLyeiCDusy+25hyDn7+B1jT
	 63BBj2TenAzZNQ6oMliV8G4tJrkLQ2K3QrD6OK9PIg/NsSoOiX7gQvxvuO6AVtRgxLu44
	 pM301YAhOch/BKhsBhBqrW5EvSW0obOq2d+TNktWGp8pkpkjJ/XJl6ZXz/fHoopdeoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643379;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=MZr4xK/e/kskw1+dwAzoYK22bsgBPbQ+0u7SWNx43YY=;
	b=PZvNTSKQNXM4ZHgfVSLmjHtoy4R+U/tdJovSAh1EqFjpuWpIKBjzCCZt1GXVYo7nZt1X
	 s9phjfs/w0HdllsFwHHnM45R+NHMMuo5uNwXx7B4BUa7rQX6UY5RxbVluQhRz88Obk8Px
	 YaJphfuDPbSzLsdiSxVcRkgZ1y1CBiq536e1amz/42VnglDIzBWp0b9IzKHr7XLmWkvgv
	 mORv1LZu8nXqtGUl9Si3fxL+tGVls3hQdgzYrtCGrjQK3Q/xYPKcnflF3PDgeyPn3hgac
	 N2c3TvJiSqifBNGh969jdoOWPLsD5wvMnKTSH2kqar6+C+H1qzUtTYYVP0I7rIpSAAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=TFybXUFj;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7648B606A336;
	Mon,  2 Nov 2026 18:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7648B606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=TFybXUFj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=MZr4xK/e/kskw1+dwAzoYK22bsgBPbQ+0u7SWNx43YY=; b=TFybXUFjsa9shueXvUXz6KiP/C
	iZL3hlLAHdQB/9jVV8yvARO+BcBtzUa37hrTt0ZyCDToEcX2SipB+HcilkpKJ/nBe73Sqfw3+eMK1
	WKFyWCkh0Minh52LuiF5Szn6A4C9pg5kArF8LG21k/9f+3rny36TmB9FM8IYpWJ4/NVPpWpKrTKqo
	QWjImC9W0RjVXW/l/FvQSyosrvTYjPgwu8Q7KcNeA3MmBX3NDAWEKmTMl3Nx+QZSLh8IiLFovXQDs
	EuU9Pgrw4TuI9RQqqi4ePTIJrvdsZDy+wTYuYUCMYC2FI6AlJtw62eUXjYVfbAmNarAqci767EF/I
	WmR08dKQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xNwZs-006L4x-1D;
	Mon, 02 Nov 2026 18:16:16 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 02 Nov 2026 10:14:54 -0800
Subject: [PATCH 1/2] printk: nbcon: Flush unsafe consoles from printk() in
 panic
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
Message-Id: <20261102-panic_unsafe_flush-v1-1-12d1e22fd6d8@debian.org>
References: <20261102-panic_unsafe_flush-v1-0-12d1e22fd6d8@debian.org>
In-Reply-To: <20261102-panic_unsafe_flush-v1-0-12d1e22fd6d8@debian.org>
To: Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>, 
 Kiryl Shutsemau <kas@kernel.org>
Cc: linux-kernel@vger.kernel.org, printk@lists.linux.dev, 
 gustavold@gmail.com, samuelcrossley@gmail.com, ryan.roberts@arm.com, 
 brads@mainlining.org, x86@kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5349; i=leitao@debian.org;
 h=from:subject:message-id; bh=XjqI9zhy44n+3HVWcHa7tpd01JvINrslG4W6DjZMhQc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq6NNl77PaGuThSezE1CeFvFl8hRNLW+BT3KYk7
 hxf15nZ62OJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaujTZQAKCRA1o5Of/Hh3
 bSL0D/0ZPJZJbHZIht2uadrAlsYz0xTT5pVl6qEmbfx6pDZiewp594jS8TK50UVnKlGUohnwemD
 Of1occ2BAxjIc3XUxuT6w0+msKxrIsxOU1x7A9fxYk/Hga9DI6h2XM8fcKzuLrCM+MXT2e76OTt
 gCPBIrE3d7mfFM5tsalw/RHWhM1QfU7k2+VsC3niktFub9uIRrpAnUtPi3Li/nr2fOVskAQlXGu
 j84lHGBhllexwv4xN0XTtTKQCFqRfOpihTKhHTGrvO1HKcuhpksp046CIMqphmvCcuxlTXD9BS1
 mdTjcQrphsvdT5VWpEqFINgZWK6DcaHOGuM/uuUEjJRe7O3z4tJhJ+Emy0Hqcl+V8JfCOWMV7GM
 4xlY0bvGJ24Ru+Csye8l8SUa7ZPKuHxB66fPG52CeGxsgBo3TzA3qmldTM4cdsag3p3Tpv0H+dJ
 pw4P3yui1Ay2ScSmcdRTNL/VOyR3kNadOFe+G7QMVtCcuGBk+l4dAbYgq0eKB7SZdURt6h20Aiq
 M0IDsEFvAzGCd6iKzHgkgvbtsZwDAeLBHH4w9cBlQ3hLr3Rs6Eq5gGmPQFCmTVfVmk0Zyk1ujEW
 cbSAaei270skEk44Pf+E4BNHhrg627B/QYoztQ032io7ifgXoWTgYgvgi2AMG4JGNjaDeHXXzKG
 jhzGqSSLXePmXBQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

netconsole registers with CON_NBCON_ATOMIC_UNSAFE since commit
7eab73b18630 ("netconsole: convert to NBCON console infrastructure"), so
its write_atomic() only runs from nbcon_atomic_flush_unsafe(). vpanic()
calls that right before its final busy loop, after emergency_restart()
and after __crash_kexec().

A panic that reboots (panic_timeout != 0) or boots a crash kernel
therefore never reaches the netconsole target. Before the conversion,
netconsole was a legacy console and printk() wrote each panic message to
it as it was printed.

Flush the unsafe consoles from nbcon_atomic_flush_pending() as well,
right after the safe ones, when it runs on the panic CPU with
oops_in_progress set. Every printk() on the panic CPU then reaches
netconsole again, "Rebooting in" included.

An unsafe write_atomic() that hangs now stops the panic CPU at the first
message, before the other consoles print the rest and before the reboot
or the crash kernel. Getting the messages out is worth that.

Fixes: 187de7c212e5 ("printk: nbcon: Allow unsafe write_atomic() for panic")
Reported-by: Ryan Roberts <ryan.roberts@arm.com>
Closes: https://lore.kernel.org/all/20260915100140.3631650-1-ryan.roberts@arm.com/
Suggested-by: Petr Mladek <pmladek@suse.com>
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/console.h |  7 ++++---
 kernel/printk/nbcon.c   | 24 ++++++++++++++++++------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index cb8be9ea4a767b..934fe72978b0e5 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -183,7 +183,8 @@ static inline void con_debug_leave(void) { }
  * @CON_NBCON:		Console can operate outside of the legacy style console_lock
  *			constraints.
  * @CON_NBCON_ATOMIC_UNSAFE: The write_atomic() callback is not safe and is
- *			therefore only used by nbcon_atomic_flush_unsafe().
+ *			therefore only used in panic, when unsafe takeovers
+ *			are allowed.
  */
 enum cons_flags {
 	CON_PRINTBUFFER		= BIT(0),
@@ -246,8 +247,8 @@ static_assert(sizeof(struct nbcon_state) <= sizeof(int));
  * @NBCON_PRIO_MAX:		The number of priority levels
  *
  * A higher priority context can takeover the console when it is
- * in the safe state. The final attempt to flush consoles in panic()
- * can be allowed to do so even in an unsafe state (Hope and pray).
+ * in the safe state. The panic CPU can be allowed to do so even in
+ * an unsafe state (Hope and pray).
  */
 enum nbcon_prio {
 	NBCON_PRIO_NONE = 0,
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 5f8afaca886650..19fa9f79cac3cb 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -84,8 +84,8 @@
  *        b) Gives up console ownership by clearing the 'prio' field.
  *
  *   3) Unsafe hostile takeover allows to take over the lock even when the
- *      console is an unsafe state. It is used only in panic() by the final
- *      attempt to flush consoles in a try and hope mode.
+ *      console is an unsafe state. It is used only on the panic CPU, in a
+ *      try and hope mode.
  *
  *      Note that separate record buffers are used in panic(). As a result,
  *      the messages can be read and formatted without any risk even after
@@ -543,7 +543,7 @@ static int nbcon_context_try_acquire_handover(struct nbcon_context *ctxt,
  * Acquire the console even in the unsafe state.
  *
  * It can be permitted by setting the 'allow_unsafe_takeover' field only
- * by the final attempt to flush messages in panic().
+ * on the panic CPU.
  *
  * Return:	0 on success. -EPERM when not allowed by the context.
  */
@@ -1653,8 +1653,9 @@ static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
  * __nbcon_atomic_flush_pending - Flush all nbcon consoles using their
  *					write_atomic() callback
  * @stop_seq:			Flush up until this record
+ * @unsafe_only:		Flush only the CON_NBCON_ATOMIC_UNSAFE consoles
  */
-static void __nbcon_atomic_flush_pending(u64 stop_seq)
+static void __nbcon_atomic_flush_pending(u64 stop_seq, bool unsafe_only)
 {
 	struct console *con;
 	int cookie;
@@ -1666,6 +1667,9 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq)
 		if (!(flags & CON_NBCON))
 			continue;
 
+		if (unsafe_only && !(flags & CON_NBCON_ATOMIC_UNSAFE))
+			continue;
+
 		if (!console_is_usable(con, flags, true))
 			continue;
 
@@ -1688,7 +1692,15 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq)
  */
 void nbcon_atomic_flush_pending(void)
 {
-	__nbcon_atomic_flush_pending(prb_next_reserve_seq(prb));
+	u64 stop_seq = prb_next_reserve_seq(prb);
+
+	__nbcon_atomic_flush_pending(stop_seq, false);
+
+	if (panic_on_this_cpu() && oops_in_progress) {
+		panic_nbcon_allow_unsafe_takeover = true;
+		__nbcon_atomic_flush_pending(stop_seq, true);
+		panic_nbcon_allow_unsafe_takeover = false;
+	}
 }
 
 /**
@@ -1701,7 +1713,7 @@ void nbcon_atomic_flush_pending(void)
 void nbcon_atomic_flush_unsafe(void)
 {
 	panic_nbcon_allow_unsafe_takeover = true;
-	__nbcon_atomic_flush_pending(prb_next_reserve_seq(prb));
+	__nbcon_atomic_flush_pending(prb_next_reserve_seq(prb), false);
 	panic_nbcon_allow_unsafe_takeover = false;
 }
 

-- 
2.53.0-Meta

