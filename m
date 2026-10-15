Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837614349BA
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 08:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052255; cv=none; b=eXI7K1daq2ErLU84rPQFeapVQzd9B0cGRwrbKRY01UhFDJkCP6zw4yO6imKJF0RQCvcwmHNI7bt6zffHnYjECOO40t+WZtjWBaVjeyaFJKTcxJDsq0EdNSp3cY4tBJxn2T83WbCXkeQ2PgMiO/EuN7X8EGd5Qug78ISOFBRRaOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052255; c=relaxed/simple;
	bh=/PApresEYMKTPx7+96hME775C7u75MRj1fk2LTRZk/w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TgMEhuQusYqkwA4vOKZkRWj+frPW5UKq7uDuDCzoaCca5GDP4Uo9ZNR0c96xgEh4K74VLBznV9GjtEN9q1rqlVfRRhUwPDFF2BiJfAwNgaDpsi1Wtq4URMVoQn2kG5K37mx7I29k18NFb9juTBZWj9BOmGio4S+/W/J2ykgtobA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D/MKckIi; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D/MKckIi"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a028616bebso37043615e9.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 01:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792052249; x=1792657049; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NfI4genE6WXRM1srM58rq6uT6KKgMmKfLXV/7bwQ18s=;
        b=D/MKckIiBeafUn9PCoJJ5ZFd/OBT/oyf5NJKn086qlaaV057cFFaeMT/ufWXNYcqG0
         a/wmoRzy8AMcQcUuxGLpwNcsuwcC1Rq7af6im7BUxuXqb9e9v7rvZFTJQ4X2NjbybB8C
         EfC+ELWSiEFYppGrZIH1erfdCvkfSzOEXKt49/4epZ84ehjJyYoxjg8LLLsmmpQBdRbO
         s1BdJwjQDuMDqUWqghCFubwbfszYJPj9sCXjM/hxgbTk1p+0BaW+VqXmmRAFEkdhTV9C
         VIsqjPEhRMXJDHIgWG/D2Ony/2ANkOKekpC0zaeCfBIfQ1uI3tZIHyZU1oJEptdRAvly
         H3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792052249; x=1792657049;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NfI4genE6WXRM1srM58rq6uT6KKgMmKfLXV/7bwQ18s=;
        b=yUXJuup3Pm2Oq8RiJTkPAX+fXGbDIfJCBgsWXPRkL6r3hXTt/eDyfudK6iAqo9iWJW
         YEkvWJpmAxvR9RSAPYYYi8QLG5fXQaFAot2dbmHPwGm8GA731lfp9ObbSFNaHIdE9yKL
         c+b8bjPHFpPJHnRWXRj5H8Ougupvb8nr9Na1m1Td94+2qK4pXjTIocNEdwLmi1HYyxvH
         7w/7uHWjJBx8DS/57XFNCsFEDB+OmZKa8IRowK5McJxvCWfaUoH6rKGMPvojTq64WXdN
         1/AYkodXid2ZYcvgCW8/qsDWISl5ZU5qumCJ3NkTAO/Tl24o6GVRfAA2fIx1xQRVVojr
         shKw==
X-Gm-Message-State: AFq9FYJ+E1Sr8GWO3LGM0SNyPhsvmRvIR08eAGnH2fFn+LlgAVyeqcyO
	EW5ihz1K9NI4ftFY7QIyM5ETEvqIeGWt3HK0SxJhf9rcKBjM/R2Hv2XY8KQUnwI+9MDSm0KxBRO
	tL+n70LKqvnmSMKg68+8r1FhPZpw+kuhecmkjTajmFWAHCXy3slid8ZwBpPsiwCO31Cj1kH5q1b
	hWP82Ch4wxZNQBV2T2oYq0Cajrpr4jdL6eLLzAfdRHmbKzb4RBIDeE
X-Received: from wmbz11.prod.google.com ([2002:a05:600c:c08b:b0:4a1:88e2:2dde])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e83:b0:4a1:6d35:779a with SMTP id 5b1f17b1804b1-4a18e446880mr335103755e9.3.1792052248269;
 Thu, 15 Oct 2026 01:17:28 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:16:32 +0000
In-Reply-To: <20261015-spinlock-irq-6-18-v1-0-72c58975994e@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261015-spinlock-irq-6-18-v1-0-72c58975994e@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=8106; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=zVnF3eKmulblrtu2mdx3tgcrgHC4aOCqG48rTPtzHMo=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBq0IwK8hFKMgZsqs7m9CCq4TSD7+yz1TOK+Yu7Y
 r0qFPNg0g2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCatCMCgAKCRAEWL7uWMY5
 RsrsD/9ecevBXs5lR7ZzI8YbFvphIWUzSiMvvgVj+AKoaZQ78k69kgHMgLJU1e5B5KmvofPssbU
 +/eH5xFUcBTXGXlby8jFWT/v5QgjIh1Fm7lM9r9fIHZPLWZzLDMbcD+vjrYurKDXoe8QiUuUxdg
 rayfS2JeiB1eKirdLcHbNoPL+v0V8PXE/n0L5EcliiyBKk57f+Ut17DwOzYUWt26Hjgjjt39uoY
 ZAPrA6ruHbRTnHAxhu5malyBQJb4AeSoP/bzjT9u5dNEVFXli5p90I4C0DgwYGWjdGtkX1Dvm4D
 gmZNvdEaJo6aQFhoaZAt/74AzXQ99K44br0/XP5TNA9eZKS8aAL8Yu1E8NEV40Xs2kXJSZVXUwo
 Rn+6tu3pSJq2YBOBMQNc8ESBooeJvLSOOl/TVCgXIlSrcd3rWm/QeZ7a3kpDnQhhl+8fEVoG9mg
 99VzPYvjuqJhwd60l/zakO51AvXWGtqEsuN2x/a5A3N1b1LNivWkM06PRtRTn4/fqf8j0rgf28G
 D0CI/IiGcZOIOAlSt+T/py5cGCe01rwe6Ecg2iJxOdve1b9JFQRaTlwFYxgv1HU4g2Pjy4EEzHn
 uBFOH61ZEaSglGUbbUQxWXoxoSBQFNg+ArbMCKHqSkygYE5lu+sHNkC2UjPT6c7FvXNYHSWi/7H dgXi69bhjQfztsw==
X-Mailer: b4 0.14.3
Message-ID: <20261015-spinlock-irq-6-18-v1-6-72c58975994e@google.com>
Subject: [PATCH 6.18.y 6/6] rust: sync: Introduce SpinLockIrq::lock_with() and friends
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

From: Lyude Paul <lyude@redhat.com>

commit ec4fad7c2bdc80c62fa73f799b77ad299f73dcc3 upstream.

`SpinLockIrq` and `SpinLock` use the exact same underlying C structure,
with the only real difference being that the former uses the
irq_disable() and irq_enable() variants for locking/unlocking. These
variants can introduce some minor overhead in contexts where we already
know that local processor interrupts are disabled, and as such we want a
way to be able to skip modifying processor interrupt state in said
contexts in order to avoid some overhead - just like the current C API
allows us to do.

In order to do this, we add some special functions for SpinLockIrq:
lock_with() and try_lock_with(), which allow acquiring the lock without
changing the interrupt state - as long as the caller can provide a
LocalInterruptDisabled reference to prove that local processor
interrupts have been disabled.

In some hacked-together benchmarks we ran, most of the time this did
actually seem to lead to a noticeable difference in overhead:

  From an aarch64 VM running on a MacBook M4:
    lock() when irq is disabled, 100 times cost Delta { nanos: 500 }
    lock_with() when irq is disabled, 100 times cost Delta { nanos: 292 }
    lock() when irq is enabled, 100 times cost Delta { nanos: 834 }

    lock() when irq is disabled, 100 times cost Delta { nanos: 459 }
    lock_with() when irq is disabled, 100 times cost Delta { nanos: 291 }
    lock() when irq is enabled, 100 times cost Delta { nanos: 709 }

  From an x86_64 VM (qemu/kvm) running on a i7-13700H
    lock() when irq is disabled, 100 times cost Delta { nanos: 1002 }
    lock_with() when irq is disabled, 100 times cost Delta { nanos: 729 }
    lock() when irq is enabled, 100 times cost Delta { nanos: 1516 }

    lock() when irq is disabled, 100 times cost Delta { nanos: 754 }
    lock_with() when irq is disabled, 100 times cost Delta { nanos: 966 }
    lock() when irq is enabled, 100 times cost Delta { nanos: 1227 }

    (note that there were some runs on x86_64 where lock() on irq
    disabled vs. lock_with() on irq disabled had equivalent benchmarks,
    but it very much appeared to be a minority of test runs.)

While it's not clear how this affects real-world workloads yet, let's
add this for the time being so we can find out.

This makes it so that a `SpinLockIrq` will work like a `SpinLock` if
interrupts are disabled. So a function:

        (&'a SpinLockIrq, &'a LocalInterruptDisabled) -> Guard<'a, .., SpinLockBackend>

makes sense. Note that due to `Guard` and `LocalInterruptDisabled`
having the same lifetime, interrupts cannot be enabled while the Guard
exists.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://patch.msgid.link/20260807070218.27144-19-boqun@kernel.org
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/lock/spinlock.rs | 92 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index e566f223c649..b3a0d7a3de04 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -4,7 +4,10 @@
 //!
 //! This module allows Rust code to use the kernel's `spinlock_t`.
 use super::*;
-use crate::prelude::*;
+use crate::{
+    interrupt::LocalInterruptDisabled,
+    prelude::*, //
+};
 
 /// Creates a [`SpinLock`] initialiser with the given name and a newly-created lock class.
 ///
@@ -155,6 +158,16 @@ macro_rules! new_spinlock_irq {
 
 /// A variant of `SpinLock` that ensures interrupts are disabled in the critical section.
 ///
+/// This lock can be acquired in two ways:
+///
+/// - Using [`lock()`] like any other type of lock, in which case the bindings will modify the
+///   interrupt state to ensure that local processor interrupts remain disabled for at least as
+///   long as the [`SpinLockIrqGuard`] exists.
+/// - Using [`lock_with()`] in contexts where a [`LocalInterruptDisabled`] token is present and
+///   local processor interrupts are already known to be disabled, in which case the local
+///   interrupt state will not be touched. This method should be preferred if a
+///   [`LocalInterruptDisabled`] token is present in the scope.
+///
 /// For more info on spinlocks, see [`SpinLock`]. For more information on interrupts,
 /// [see the interrupt module](kernel::interrupt).
 ///
@@ -208,7 +221,47 @@ macro_rules! new_spinlock_irq {
 /// # Ok::<(), Error>(())
 /// ```
 ///
+/// The next example demonstrates locking a [`SpinLockIrq`] using [`lock_with()`] in a function
+/// which can only be called when local processor interrupts are already disabled.
+///
+/// ```
+/// use kernel::sync::{new_spinlock_irq, SpinLockIrq};
+/// use kernel::interrupt::*;
+///
+/// struct Inner {
+///     a: u32,
+/// }
+///
+/// #[pin_data]
+/// struct Example {
+///     #[pin]
+///     inner: SpinLockIrq<Inner>,
+/// }
+///
+/// impl Example {
+///     fn new() -> impl PinInit<Self> {
+///         pin_init!(Self {
+///             inner <- new_spinlock_irq!(Inner { a: 20 }),
+///         })
+///     }
+/// }
+///
+/// // Accessing an `Example` from a function that can only be called in no-interrupt contexts.
+/// fn noirq_work(e: &Example, interrupt_disabled: &LocalInterruptDisabled) {
+///     // Because we know interrupts are disabled from interrupt_disable, we can skip toggling
+///     // interrupt state using lock_with() and the provided token
+///     assert_eq!(e.inner.lock_with(interrupt_disabled).a, 20);
+/// }
+///
+/// # let e = KBox::pin_init(Example::new(), GFP_KERNEL)?;
+/// # let interrupt_guard = local_interrupt_disable();
+/// # noirq_work(&e, &interrupt_guard);
+/// #
+/// # Ok::<(), Error>(())
+/// ```
+///
 /// [`lock()`]: SpinLockIrq::lock
+/// [`lock_with()`]: SpinLockIrq::lock_with
 pub type SpinLockIrq<T> = super::Lock<T, SpinLockIrqBackend>;
 
 /// A kernel `spinlock_t` lock backend that can only be acquired in interrupt disabled contexts.
@@ -273,6 +326,43 @@ unsafe fn assert_is_held(ptr: *mut Self::State) {
     }
 }
 
+impl<T: ?Sized> Lock<T, SpinLockIrqBackend> {
+    /// Casts the lock as a `Lock<T, SpinLockBackend>`.
+    #[inline]
+    fn as_lock_in_interrupt<'a>(&'a self, _context: &'a LocalInterruptDisabled) -> &'a SpinLock<T> {
+        // SAFETY:
+        // - `Lock<T, SpinLockBackend>` and `Lock<T, SpinLockIrqBackend>` both have identical data
+        //   layouts.
+        // - As long as local interrupts are disabled (which is proven to be true by _context), it
+        //   is safe to treat a lock with SpinLockIrqBackend as a SpinLockBackend lock.
+        unsafe { core::mem::transmute(self) }
+    }
+
+    /// Acquires the lock without modifying local interrupt state.
+    ///
+    /// This function should be used in place of the more expensive [`Lock::lock()`] function when
+    /// possible for [`SpinLockIrq`] locks.
+    #[inline]
+    pub fn lock_with<'a>(&'a self, context: &'a LocalInterruptDisabled) -> SpinLockGuard<'a, T> {
+        self.as_lock_in_interrupt(context).lock()
+    }
+
+    /// Tries to acquire the lock without modifying local interrupt state.
+    ///
+    /// This function should be used in place of the more expensive [`Lock::try_lock()`] function
+    /// when possible for [`SpinLockIrq`] locks.
+    ///
+    /// Returns a guard that can be used to access the data protected by the lock if successful.
+    #[must_use = "if unused, the lock will be immediately unlocked"]
+    #[inline]
+    pub fn try_lock_with<'a>(
+        &'a self,
+        context: &'a LocalInterruptDisabled,
+    ) -> Option<SpinLockGuard<'a, T>> {
+        self.as_lock_in_interrupt(context).try_lock()
+    }
+}
+
 #[kunit_tests(rust_spinlock_irq_condvar)]
 mod tests {
     use super::*;

-- 
2.56.0.385.gd3acb90ef8-goog

