Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D804BD7B8
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052243; cv=none; b=dSy1s48pad7JyotCC+sY0NLHgsyIrvD76xzTC22peq/6LL4ocuyePhZUZwnzI9AEaef1Wt165JdJSmjHssQdyF5FAdwynRtnDGJXGcVSvDFldi8Vc+S8QdZVXFQsu5tCYIHZdjINCjAAgj7oWnYzZS5XavsJ7/4V8+dxy5NBnc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052243; c=relaxed/simple;
	bh=2MxsPkdsOyTiF67kRTAkKr9D+DGoZJy/1CV3o17d4xc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dRLP9PJtBe1BKTZZO5Zi8mTiSLq/GwJEyQaQNrGhhto9ldmuU12YcNOmZXfIDf6m+7PNpIrP7VTL13DF7XCs83SA0ortXiiJSMZNoiSUjRhmXoWwo8MKz36nSAJodFSqamnneMgnlvdlnFSyz58P4f76q70W5B/Gnv6KthF5rZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=beY3Ftiv; arc=none smtp.client-ip=209.85.218.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="beY3Ftiv"
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c3d9daffbc3so126665166b.2
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 01:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792052240; x=1792657040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KPVsJuNPkB5Zm5XIwrtcO8ixxtEggcJ8wyEDlPgIY4s=;
        b=beY3FtivbmiM6dwuJ0MuETHXaijHsZshScki0vlIHPB1aS5Pwdqm09GSgPI4aKv0xA
         hLUY6gN5Lf3rw4p5x1tLpO1vV8C1RqG1pzUv2+0J8sOsyI6OtirWTuCd4XbT9ADMvAr4
         8Tjybdg1eqMBw0Q7hHkaIBitaMBoDznYibxLZOpG9gJAN39BTyVuG8e1cKPwNhxUENZ6
         8d7gExiH7pEkp308PD6AOEfHimmAAMPaoSkfaazGDHvR38Z4IKoLqRF7U3axt7anDDUW
         yie34V6EoqHia7Fbim0c3CoEJXYHigsceuMEFJn+fR7PD0QGeKy/baGonDrtpa5xwh4j
         pp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792052240; x=1792657040;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KPVsJuNPkB5Zm5XIwrtcO8ixxtEggcJ8wyEDlPgIY4s=;
        b=UYSLhvxP8XV7Y9+qKYB8xE6PL7ewlraCLFpRjPkXu2uFvn1HfErkVS6eIGMmSF4+Va
         9w1wEcquacrMgh3XQ93KShpOhB4gH1NcsDWg2Ep+oYL5lFLtjHgNu1sFTd4VzMtacUk/
         MkBtPFeerUUXFf3gNyw9GYcVa0uKR3WyfE/CjMD8b5HjvV1SbWDxwRpNSnvOKyiyG1po
         jxAObCPXt5TEkVIgHwSj8CwEoVvoSLVLJdcfD/QrkHRHuigEX4TAVWvHTLGL/GrVBL5Q
         /Ir5okOFAJblaGgbW37fHw5E1KYnZsaz4n2cDqivwyoeNV8sab1r2vu5pU4yllY275MB
         ykfQ==
X-Gm-Message-State: AFq9FYLyOX7BbOsfeYOJtJSeb3adRt5aE+qv5pqHXc5uGF4vw4R5wH1M
	UV8PuYmsVGeK2ptEmHlZwBTUOPvooYfL3RmDi6zCLG3IhHylNzDAsbftiVgDSovFZkdKOQQOzgG
	cY1Wzxd2EiI/QEdg9wKEIZzT1Fl/6A9lMASiHVTxPqlxhl+Spzm+LQIJy2AWaymrtJG1Zulf7tZ
	WCMNwKTLLnYuALUZCAE4EQ68KEpjjPNWBwGJBm44sLkLpV8ilZZzG2
X-Received: from ejjn21.prod.google.com ([2002:a17:906:7015:b0:c37:639a:ae6b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:c0d:b0:c2e:3ed7:7db4 with SMTP id a640c23a62f3a-c31aa00dc1bmr1650344766b.23.1792052239276;
 Thu, 15 Oct 2026 01:17:19 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:16:28 +0000
In-Reply-To: <20261015-spinlock-irq-6-18-v1-0-72c58975994e@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261015-spinlock-irq-6-18-v1-0-72c58975994e@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6737; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=rkPvEnNh4hZKTMQ/1ZfQn7xFtFDz62+phCPQ6tCEhSw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBq0IwJyUqPv/iepCJgcco7Qigcjr2Vm0fAyGJlb
 Zej70rWXrmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCatCMCQAKCRAEWL7uWMY5
 RtqtD/4gEzLokher0bE4JspzSqUlMsN5GIgKkoSf7hQcF8vUrApCmQ8Pirta+nWvEHq95KvHe0K
 JPyJXnFapDZ3GZxSxxYViVGM4FcucoYpk2mnZTiPKJqd8NFxAXdXN7ZFlQsV3NiIlmH8GN7tzkV
 CFJRCEfIt+5HAKJXk32REa6CWOsVvSv+I1sq/fpIVt5vTwOV1AAs2QEsfdNRrkYV0mywg8JMWpv
 kvG92TaLemU2XedgBB4bUGDH0w8HwgetCrF5mZI70sRF5mC7N7ZzDhcrvzPXMECMbI/D0y0oD0t
 9azCmBmjzKhY5hbbAZmRwruMGFA6Ll8tSe9UylpNUPSGYzUB1E0r5oO/0fWeDabUZcHlBSbROOB
 vAVsmcOABxUMYFlOd7cMkQ0sCGqZGmW4lmt8/Arn5CteEwGvHAEJSJnh32mweRhYtQjeNqLdiWi
 Vp8qxiN0c5ozoDkpuiaQsRScWG1ds2xE07D5rBQxJEiJCu2C972LjMhLDwfhmZ9ivTmqDY6mq+V
 VHlxJ8uqpCSlKLJgJY43XTkOYnMCxG0fGwQeA4H+/qKgU47FTo+p83ESM3LWWGsotbSf2hZGA54
 f1ORjiHB1C5LIwFfro8tkSB4XpX83Qz9eJ+/8p09mkaHPCAbHD76+F7znH8kCPd2X/CJ3UYmA16 Bce/c6oZFKQWTNw==
X-Mailer: b4 0.14.3
Message-ID: <20261015-spinlock-irq-6-18-v1-2-72c58975994e@google.com>
Subject: [PATCH 6.18.y 2/6] rust: Introduce interrupt module
From: Alice Ryhl <aliceryhl@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Gary Guo <gary@garyguo.net>
Cc: Boqun Feng <boqun@kernel.org>, Lyude Paul <lyude@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

From: Lyude Paul <lyude@redhat.com>

commit c1f0451ec748f7a58a4e50bcb8f75bd89718be78 upstream.

This introduces a module for dealing with interrupt-disabled contexts,
including the ability to enable and disable interrupts along with the
ability to annotate functions as expecting that IRQs are already
disabled on the local CPU.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://patch.msgid.link/20260807070218.27144-15-boqun@kernel.org
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/helpers/helpers.c   |  1 +
 rust/helpers/interrupt.c | 13 +++++++
 rust/helpers/sync.c      |  5 +++
 rust/kernel/interrupt.rs | 89 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 rust/kernel/lib.rs       |  1 +
 5 files changed, 109 insertions(+)

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 551da6c9b506..01ffade6c038 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -29,6 +29,7 @@
 #include "err.c"
 #include "irq.c"
 #include "fs.c"
+#include "interrupt.c"
 #include "io.c"
 #include "jump_label.c"
 #include "kunit.c"
diff --git a/rust/helpers/interrupt.c b/rust/helpers/interrupt.c
new file mode 100644
index 000000000000..69595498620f
--- /dev/null
+++ b/rust/helpers/interrupt.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/spinlock.h>
+
+__rust_helper void rust_helper_local_interrupt_disable(void)
+{
+	local_interrupt_disable();
+}
+
+__rust_helper void rust_helper_local_interrupt_enable(void)
+{
+	local_interrupt_enable();
+}
diff --git a/rust/helpers/sync.c b/rust/helpers/sync.c
index ff7e68b48810..3bc5930c39c5 100644
--- a/rust/helpers/sync.c
+++ b/rust/helpers/sync.c
@@ -11,3 +11,8 @@ void rust_helper_lockdep_unregister_key(struct lock_class=
_key *k)
 {
 	lockdep_unregister_key(k);
 }
+
+__rust_helper void rust_helper_lockdep_assert_irqs_disabled(void)
+{
+	lockdep_assert_irqs_disabled();
+}
diff --git a/rust/kernel/interrupt.rs b/rust/kernel/interrupt.rs
new file mode 100644
index 000000000000..a880ec3b8538
--- /dev/null
+++ b/rust/kernel/interrupt.rs
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Interrupt controls
+//!
+//! This module allows Rust code to annotate areas of code where local pro=
cessor interrupts should
+//! be disabled, along with actually disabling local processor interrupts.
+//!
+//! # =E2=9A=A0=EF=B8=8F Warning! =E2=9A=A0=EF=B8=8F
+//!
+//! The usage of this module can be more complicated than meets the eye, e=
specially surrounding
+//! [preemptible kernels]. It's recommended to take care when using the fu=
nctions and types defined
+//! here and familiarize yourself with the various documentation we have b=
efore using them, along
+//! with the various documents we link to here.
+//!
+//! # Reading material
+//!
+//! - [Software interrupts and realtime (LWN)](https://lwn.net/Articles/52=
0076)
+//!
+//! [preemptible kernels]: https://www.kernel.org/doc/html/latest/locking/=
preempt-locking.html
+
+use crate::types::NotThreadSafe;
+
+/// A guard that represents local processor interrupt disablement on preem=
ptible kernels.
+///
+/// [`LocalInterruptDisabled`] is a guard type that represents that local =
processor interrupts have
+/// been disabled on a preemptible kernel.
+///
+/// Certain functions take an immutable reference of [`LocalInterruptDisab=
led`] in order to require
+/// that they may only be run in local-interrupt-disabled contexts on pree=
mptible kernels.
+///
+/// This is a marker type; it has no size, and is simply used as a compile=
-time guarantee that local
+/// processor interrupts are disabled on preemptible kernels. Note that no=
 guarantees about the
+/// state of interrupts are made by this type on non-preemptible kernels.
+///
+/// # Invariants
+///
+/// Local processor interrupts are disabled on preemptible kernels for as =
long as an object of this
+/// type exists.
+pub struct LocalInterruptDisabled(NotThreadSafe);
+
+/// Disable local processor interrupts on a preemptible kernel.
+///
+/// This function disables local processor interrupts on a preemptible ker=
nel, and returns a
+/// [`LocalInterruptDisabled`] token as proof of this. On non-preemptible =
kernels, this function is
+/// a no-op.
+///
+/// **Usage of this function is discouraged** unless you are absolutely su=
re you know what you are
+/// doing, as kernel interfaces for Rust that deal with interrupt state wi=
ll typically handle local
+/// processor interrupt state management on their own and managing this by=
 hand is quite error
+/// prone.
+#[inline]
+pub fn local_interrupt_disable() -> LocalInterruptDisabled {
+    // SAFETY: It's always safe to call `local_interrupt_disable()`.
+    unsafe { bindings::local_interrupt_disable() };
+
+    LocalInterruptDisabled(NotThreadSafe)
+}
+
+impl Drop for LocalInterruptDisabled {
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: Per type invariants, a `local_interrupt_disable()` must=
 be called to create this
+        // object, hence calling the corresponding `local_interrupt_enable=
()` is safe.
+        unsafe { bindings::local_interrupt_enable() };
+    }
+}
+
+impl LocalInterruptDisabled {
+    /// Assume that local processor interrupts are disabled on preemptible=
 kernels.
+    ///
+    /// This can be used for annotating code that is known to be run in co=
ntexts where local
+    /// processor interrupts are disabled on preemptible kernels. It makes=
 no changes to the local
+    /// interrupt state on its own.
+    ///
+    /// # Safety
+    ///
+    /// For the whole life `'a`, local interrupts must be disabled on pree=
mptible kernels. This
+    /// could be a context like, for example, an interrupt handler.
+    #[inline]
+    pub unsafe fn assume_disabled<'a>() -> &'a LocalInterruptDisabled {
+        const ASSUME_DISABLED: &LocalInterruptDisabled =3D &LocalInterrupt=
Disabled(NotThreadSafe);
+
+        // Confirm they're actually disabled if lockdep is available
+        // SAFETY: It's always safe to call `lockdep_assert_irqs_disabled(=
)`.
+        unsafe { bindings::lockdep_assert_irqs_disabled() };
+
+        ASSUME_DISABLED
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 3dd7bebe7888..75a466d9319b 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -96,6 +96,7 @@
 pub mod fs;
 pub mod id_pool;
 pub mod init;
+pub mod interrupt;
 pub mod io;
 pub mod ioctl;
 pub mod iov;

--=20
2.56.0.385.gd3acb90ef8-goog

