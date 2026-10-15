Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DDD4C652E
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052253; cv=none; b=t8Mo5jB2hgwAXw8iqREV2b/JiqjnU7K4WBTpHJVjhkPUe9WOEXwV9V0nky5ChHhrEUM4pPUjEnYVJKEcd2cbj3Dz6Jkot8Ewnq926pg+TTjeUTWZVhe99mLMSbZ9zKMQDLi73QAST29beQgmI61O2iPzxvdyW2gmfbKRxsgyp/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052253; c=relaxed/simple;
	bh=GfvhBpt6HuNKBUXhfsOGKyOjwz+Zd3Wr8fqbx6QbhAs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k4rJycF0HRnKYdWmFBBOGK+SlRXtCDeJ/MFdePEFIzon/KtLuX3OxUEyLyxpA+btF/HFmk5VA3m5EI7FUP9DQ5FHLxAPI0WLipzxw/U+wUzHbo0H/mToOZRD2xrsvXtBLaAE8i0vQtKdb+hlXS9xQ8sXRgHM0nY4oWx3K6isp6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G2ToU8Z6; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G2ToU8Z6"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a01b112fa2so26699495e9.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 01:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792052247; x=1792657047; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLuT0BfQ1oxUuugXGHeSuinf27axMqJZwaGyCaQXVZE=;
        b=G2ToU8Z6w1Dpr5Ypl4ACGAEDQP4jHP0A8LiYocyHElcA64wrB3jVGnIL/dDgQE1PC3
         jmsFZi+voqUMnB4slRvB3VR2NYfcRFw1gixVjtnVxaCyFcQDG/oR9VpEbpF20CDX/SH0
         PDAnRn5NB3RH9DOFgeoSj1JNWuEhPsFjNETb6z27L8PmcpzZ70THB/rzkAVi8zQdg1gQ
         ZjXA8Qi94SPQ9yktePzSnEFHMcKHF4l6bKFyTZYslKFax6xu+lypEqlvAc4pkJC9e3JO
         bW5hfQ06ZVW8D5neFXk4SEzfTXVch6LESqlt0Tv3elFJ7l0H7nL9qebez8evjJ8xL342
         pJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792052247; x=1792657047;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oLuT0BfQ1oxUuugXGHeSuinf27axMqJZwaGyCaQXVZE=;
        b=YuMaWekApA/z9jwktID5aZ0L40QV42ZqE72JPrM8YfSNP2RmZLJxUQAklOu9L7lR45
         J2LAgAsG4EXDrINv40PEKVMsLAkMiRFXKxT+SwAg5/lz9rFKJf4spzA/cmybqaYRPCkb
         cV59SvKzkhOfQakI81+bU9jfGaal5KWJI4H75TTc+Q7TDZR8sq1+p2Azo9GSEIFchaxR
         xxcbWBJIG9lEOUJEOmhIVAfzAlKiM4itooDhlx+aawVxQNkGIF58DLmWVYEUUaGrYq99
         qk64pGrJsDIHUsiGEij2gwZtxgMQwVWmDJPJXGoDczy4GyYwiRlu7eBwHb6z6fR338lq
         ir5Q==
X-Gm-Message-State: AFq9FYKD2ISdH+hTlPsJcGpxogqvwxI/HTupn4QCLtX7u2WveC2dlP8P
	7/5MsRvh4Z3PcJIKjpeYYTeY6gXliuP8yz1g57qB/CE7+97W2PLwLoUj0COKUltRlGyEc4CsCcT
	Wytm1nl3rWiFlOoiOvKjupFHPh8MM6Ls/sgj620Ms56GJEu4skzBCCkQTxqlcIGgJMI9l1doumU
	wvegIOVIadna7uk8r0xWW+AgtnPIRE9BCxjuewR12xjLTYAxWN2/oD
X-Received: from wmbg12.prod.google.com ([2002:a05:600c:a40c:b0:49f:fd3d:3bd3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b98:b0:499:79b9:e220 with SMTP id 5b1f17b1804b1-4a18e49886amr410276525e9.10.1792052246808;
 Thu, 15 Oct 2026 01:17:26 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:16:31 +0000
In-Reply-To: <20261015-spinlock-irq-6-18-v1-0-72c58975994e@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261015-spinlock-irq-6-18-v1-0-72c58975994e@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=10364; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=qb3NoZMsCmLWxcAJZcOIE1GyhX2JZYwXAOS4ABpQPIY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBq0IwKqLKXqiDfazirPKoyYZi3jXbJmawoxD8Wq
 LJO9NBMaOmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCatCMCgAKCRAEWL7uWMY5
 RuL2D/48lgngN3n64Uu+pcLXtECeF2q6gv5f7J7PnolqUnb/2eC89/rzq4qFA3OP/2fUzEDDv85
 DIBGFPZAogmKveTvmudMDlWhR3Gty7eoUouC8ST23NfIwmjmNbllsr5P6CHCGJOBG+W2Khios+L
 DHTveohP1C00iSIGnJ7/8ldRy80IpaUcJWF2sZNq86+wF6RY79YwddHaPfaG7BO7sx/UCkAJnpW
 olGerq7dhCz0UU8N8N5VqL+ixVC5GtGRQkaZ1Io2jXceZF9ZiXM/3AbCYZrMcldKljzzxvY9xf3
 b519cE1tZvrLQJswfuaFcHBuLFIILnJKrLZ83O9N+yD8oD3vfwWMYSEieasETpFoQQ6M8swTzpd
 vAQY/lXOtsEelbww4yg+0sySd6FspoOOPX6qJVvO7VHIbOn3y+z7sCmah1SCwGolSt30YG4V1kq
 dHCXGP58/9SOAFGVvvcuEtifXC4U3T9yPCj7q8tabGzTnngdYMkFQOkW8lDw2mfo7L4u1cpqrCu
 Dk0PbTFfo8jqdmnRZLHE5vL/jfuL8NqEnEsGKiqAy6o4FrQKsOOj0rsQBWmyPG9rQuW76JQM4UX
 a+t+IRezifEsIXAOyzWH6ukyyWCEHlZqSvsY22kNqKhU+GFdAfb++Q/b715mkpmuyCPBEuNiBgY ECXjvuJ9TMo4W4A==
X-Mailer: b4 0.14.3
Message-ID: <20261015-spinlock-irq-6-18-v1-5-72c58975994e@google.com>
Subject: [PATCH 6.18.y 5/6] rust: sync: Add SpinLockIrq
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

commit 5967f4df55521de596cbe34e0c0c96e962ef3f2e upstream.

A variant of `SpinLock` that ensures interrupts are disabled in the
critical section. `lock()` will ensure that either interrupts are
already disabled or disable them. `unlock()` will reverse the respective
operation.

[Boqun: Port to use spin_lock_irq_disable() and
spin_unlock_irq_enable()]

Signed-off-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://patch.msgid.link/20260807070218.27144-18-boqun@kernel.org
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync.rs               |   9 +-
 rust/kernel/sync/lock/global.rs   |   3 +
 rust/kernel/sync/lock/spinlock.rs | 230 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 241 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index cf5b638a097d..cf3c361bab15 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -26,7 +26,14 @@
 pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
 pub use lock::global::{global_lock, GlobalGuard, GlobalLock, GlobalLockBackend, GlobalLockedBy};
 pub use lock::mutex::{new_mutex, Mutex, MutexGuard};
-pub use lock::spinlock::{new_spinlock, SpinLock, SpinLockGuard};
+pub use lock::spinlock::{
+    new_spinlock,
+    new_spinlock_irq,
+    SpinLock,
+    SpinLockGuard,
+    SpinLockIrq,
+    SpinLockIrqGuard, //
+};
 pub use locked_by::LockedBy;
 pub use refcount::Refcount;
 
diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global.rs
index d65f94b5caf2..47e200b750c1 100644
--- a/rust/kernel/sync/lock/global.rs
+++ b/rust/kernel/sync/lock/global.rs
@@ -299,4 +299,7 @@ macro_rules! global_lock_inner {
     (backend SpinLock) => {
         $crate::sync::lock::spinlock::SpinLockBackend
     };
+    (backend SpinLockIrq) => {
+        $crate::sync::lock::spinlock::SpinLockIrqBackend
+    };
 }
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index 78432a598a45..e566f223c649 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -4,6 +4,7 @@
 //!
 //! This module allows Rust code to use the kernel's `spinlock_t`.
 use super::*;
+use crate::prelude::*;
 
 /// Creates a [`SpinLock`] initialiser with the given name and a newly-created lock class.
 ///
@@ -138,3 +139,232 @@ unsafe fn assert_is_held(ptr: *mut Self::State) {
         unsafe { bindings::spin_assert_is_held(ptr) }
     }
 }
+
+/// Creates a [`SpinLockIrq`] initialiser with the given name and a newly-created lock class.
+///
+/// It uses the name if one is given, otherwise it generates one based on the file name and line
+/// number.
+#[macro_export]
+macro_rules! new_spinlock_irq {
+    ($inner:expr $(, $name:literal)? $(,)?) => {
+        $crate::sync::SpinLockIrq::new(
+            $inner, $crate::optional_name!($($name)?), $crate::static_lock_class!())
+    };
+}
+pub use new_spinlock_irq;
+
+/// A variant of `SpinLock` that ensures interrupts are disabled in the critical section.
+///
+/// For more info on spinlocks, see [`SpinLock`]. For more information on interrupts,
+/// [see the interrupt module](kernel::interrupt).
+///
+/// # Examples
+///
+/// The following example shows how to declare, allocate initialise and access a struct (`Example`)
+/// that contains an inner struct (`Inner`) that is protected by a spinlock that requires local
+/// processor interrupts to be disabled.
+///
+/// ```
+/// use kernel::sync::{new_spinlock_irq, SpinLockIrq};
+///
+/// struct Inner {
+///     a: u32,
+///     b: u32,
+/// }
+///
+/// #[pin_data]
+/// struct Example {
+///     #[pin]
+///     c: SpinLockIrq<Inner>,
+///     #[pin]
+///     d: SpinLockIrq<Inner>,
+/// }
+///
+/// impl Example {
+///     fn new() -> impl PinInit<Self> {
+///         pin_init!(Self {
+///             c <- new_spinlock_irq!(Inner { a: 0, b: 10 }),
+///             d <- new_spinlock_irq!(Inner { a: 20, b: 30 }),
+///         })
+///     }
+/// }
+///
+/// // Allocate a boxed `Example`
+/// let e = KBox::pin_init(Example::new(), GFP_KERNEL)?;
+///
+/// // Accessing an `Example` from a context where interrupts may not be disabled already.
+/// let c_guard = e.c.lock(); // interrupts are disabled now, +1 interrupt disable refcount
+/// let d_guard = e.d.lock(); // no interrupt state change, +1 interrupt disable refcount
+///
+/// assert_eq!(c_guard.a, 0);
+/// assert_eq!(c_guard.b, 10);
+/// assert_eq!(d_guard.a, 20);
+/// assert_eq!(d_guard.b, 30);
+///
+/// drop(c_guard); // Dropping c_guard will not re-enable interrupts just yet, since d_guard is
+///                // still in scope.
+/// drop(d_guard); // Last interrupt disable reference dropped here, so interrupts are re-enabled
+///                // now
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// [`lock()`]: SpinLockIrq::lock
+pub type SpinLockIrq<T> = super::Lock<T, SpinLockIrqBackend>;
+
+/// A kernel `spinlock_t` lock backend that can only be acquired in interrupt disabled contexts.
+pub struct SpinLockIrqBackend;
+
+/// A [`Guard`] acquired from locking a [`SpinLockIrq`] using [`lock()`].
+///
+/// This is simply a type alias for a [`Guard`] returned from locking a [`SpinLockIrq`] using
+/// [`lock()`]. It will unlock the [`SpinLockIrq`] and decrement the local processor's interrupt
+/// disablement refcount upon being dropped.
+///
+/// [`lock()`]: SpinLockIrq::lock
+pub type SpinLockIrqGuard<'a, T> = Guard<'a, T, SpinLockIrqBackend>;
+
+// SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion. `relock` uses the
+// default implementation that always calls the same locking method.
+unsafe impl Backend for SpinLockIrqBackend {
+    type State = bindings::spinlock_t;
+    type GuardState = ();
+
+    #[inline]
+    unsafe fn init(
+        ptr: *mut Self::State,
+        name: *const crate::ffi::c_char,
+        key: *mut bindings::lock_class_key,
+    ) {
+        // SAFETY: The safety requirements ensure that `ptr` is valid for writes, and `name` and
+        // `key` are valid for read indefinitely.
+        unsafe { bindings::__spin_lock_init(ptr, name, key) }
+    }
+
+    #[inline]
+    unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState {
+        // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
+        // memory, and that it has been initialised before.
+        unsafe { bindings::spin_lock_irq_disable(ptr) }
+    }
+
+    #[inline]
+    unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
+        // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that the
+        // caller is the owner of the spinlock.
+        unsafe { bindings::spin_unlock_irq_enable(ptr) }
+    }
+
+    #[inline]
+    unsafe fn try_lock(ptr: *mut Self::State) -> Option<Self::GuardState> {
+        // SAFETY: The `ptr` pointer is guaranteed to be valid and initialized before use.
+        let result = unsafe { bindings::spin_trylock_irq_disable(ptr) };
+
+        if result != 0 {
+            Some(())
+        } else {
+            None
+        }
+    }
+
+    #[inline]
+    unsafe fn assert_is_held(ptr: *mut Self::State) {
+        // SAFETY: The `ptr` pointer is guaranteed to be valid and initialized before use.
+        unsafe { bindings::spin_assert_is_held(ptr) }
+    }
+}
+
+#[kunit_tests(rust_spinlock_irq_condvar)]
+mod tests {
+    use super::*;
+    use crate::{
+        sync::*,
+        workqueue::{
+            self,
+            impl_has_work,
+            new_work,
+            Work,
+            WorkItem, //
+        },
+    };
+
+    struct TestState {
+        value: u32,
+        waiter_ready: bool,
+    }
+
+    #[pin_data]
+    struct Test {
+        #[pin]
+        state: SpinLockIrq<TestState>,
+
+        #[pin]
+        state_changed: CondVar,
+
+        #[pin]
+        waiter_state_changed: CondVar,
+
+        #[pin]
+        wait_work: Work<Self>,
+    }
+
+    impl_has_work! {
+        impl HasWork<Self> for Test { self.wait_work }
+    }
+
+    impl Test {
+        pub(crate) fn new() -> Result<Arc<Self>> {
+            Arc::try_pin_init(
+                try_pin_init!(
+                    Self {
+                        state <- new_spinlock_irq!(TestState {
+                            value: 1,
+                            waiter_ready: false
+                        }),
+                        state_changed <- new_condvar!(),
+                        waiter_state_changed <- new_condvar!(),
+                        wait_work <- new_work!("IrqCondvarTest::wait_work")
+                    }
+                ),
+                GFP_KERNEL,
+            )
+        }
+    }
+
+    impl WorkItem for Test {
+        type Pointer = Arc<Self>;
+
+        fn run(this: Arc<Self>) {
+            // Wait for the test to be ready to wait for us
+            let mut state = this.state.lock();
+
+            // Make sure the interrupts actually turned off
+            // SAFETY: It's always safe to call `lockdep_assert_irqs_disabled()`
+            unsafe { bindings::lockdep_assert_irqs_disabled() };
+
+            while !state.waiter_ready {
+                this.waiter_state_changed.wait(&mut state);
+            }
+
+            // Deliver the exciting value update our test has been waiting for
+            state.value += 1;
+            this.state_changed.notify_sync();
+        }
+    }
+
+    #[test]
+    fn spinlock_irq_condvar() -> Result {
+        let testdata = Test::new()?;
+
+        let _ = workqueue::system().enqueue(testdata.clone());
+
+        // Let the updater know when we're ready to wait
+        let mut state = testdata.state.lock();
+        state.waiter_ready = true;
+        testdata.waiter_state_changed.notify_sync();
+
+        // Wait for the exciting value update
+        testdata.state_changed.wait(&mut state);
+        assert_eq!(state.value, 2);
+        Ok(())
+    }
+}

-- 
2.56.0.385.gd3acb90ef8-goog

