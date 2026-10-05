Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857BA45D5FA
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193682; cv=none; b=kKH3ffdESzT2Q3yD89WvN3B3dQR8JohAz9i/nmIDs0Ey1ywPGTFZKu7x7Jw2d1Azm/Xsq9NNigtO4qjKN5xpKdeo7hFsldhDrqCCqK3ntMHevWSsF0NFdz9r7x9T72HaRo2htXK89i4XtVm9R02wcC/fH81AjEBzLDNWlX3vE3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193682; c=relaxed/simple;
	bh=CbBsgcoFQqhzB9X8FxVIVPwtT/gD2BSFLE+Sv3uIDFA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hij5Y1X41pHolMkwtG/V8f4OYO8XScGkQqS1IjUfo71pMZftSOLotgB36iGKXRIwxdAVPDMjLYyjWKzglWwcED3H6WQcOdNMRuI3h6l1+BRd7yrr5zd8MR18PmXssWcMbO1a7qJyshd0nSIunUdvf6xtobzYiAWFqKqeWSX5J3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RWXP3XTb; arc=none smtp.client-ip=209.85.218.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RWXP3XTb"
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c210c66672eso256158166b.2
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 02:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791193669; x=1791798469; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fDR531f1kJBuWB4fk6q8SQd8GDQ9jmjZIPjXS1HCN/w=;
        b=RWXP3XTbXTRz/7M2Kq5PEXV0A7JwbCWYHLbsInYlKa7YFO03uHuW7A0W28KYHbYwtK
         ly7D6LuZDFSlDPz6uNipI2jDRQWFlgUC6OX6KbUvLkf8135sxaC85SWBZBIHVrgAyFZe
         J6EHO75KxkuwuTq7kadOOtURHdTZfZp6J4PNW1QeT0vs0g0pH8AmueAZw7uzM7xmlbJi
         1d/kscUP6KBv3rIw3G75x0cDIs2s1d2jyUqeVRnARQgEgG96IBDf9Xlx/pD2+HwRyRwN
         btcmQHgnaXrsSf4zjqaDWI9vfYEfhqneHMm9ocImNV0jA0ygNBDG6D5247tGT6xCfNmW
         YH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791193669; x=1791798469;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fDR531f1kJBuWB4fk6q8SQd8GDQ9jmjZIPjXS1HCN/w=;
        b=ZKEF97H560pMmkHAmbLAWHWB33tTcQcSRp2R+D32GhcDEYvhvCWucA7M6QrurznzQn
         b1/3fJT3mZROvuqP2uDXRpnEFQlBcrwaX1I6GQQSDnH1+NjMcO4ygOCoBN8PjhHmGT+Q
         X6pexKry3Z9xbKzypDE6yL7Ea2q9PgSv7qYKNYGd5RgV7AgMgYDxpaC+WRCeYI82YO/t
         mBMfuAZa5JUBHTFeo/B4NDfvzsx7JoblK5d49sIq5unVuo4OefRG+44cHbI6Ohpr9NHV
         s8AWhgon+50LbTR/bIvL09TvSdWj1+9U5UB/nwq0okyEB9wOnaQp9hhHf2UeXxWJqUyj
         tHfw==
X-Gm-Message-State: AFq9FYKY/l2a0pMmK+rYDCx5Hrccik9Zs3zNvHxw68Bm26Cz3JhG9Ky2
	f1+TWHwXpjAEuprU3VYipbHC7lji9M+fuep6PJRcvMPc+YitPQMvIqHNJ9zOkCq4KteatrhA+S1
	ksbQMvsi6TKjA/mWsBr6EDO9KetHYe3crECMYjS8kpm4l5rNgKh1KkkfBNg3KDFz2N4GewIvBae
	ouk7dCV4M87FHL087/r3IRO+UoLFYacU+v6qLxsld2QmHWGFe0HRgx
X-Received: from ejcfv18.prod.google.com ([2002:a17:907:5092:b0:c2e:4d0a:d961])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:f594:b0:c29:53ba:a4cd with SMTP id a640c23a62f3a-c2e4ad13e7amr829699966b.11.1791193668617;
 Mon, 05 Oct 2026 02:47:48 -0700 (PDT)
Date: Mon, 05 Oct 2026 09:47:30 +0000
In-Reply-To: <20261005-devres-6-18-backport-v1-0-06dcf0e592d5@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261005-devres-6-18-backport-v1-0-06dcf0e592d5@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=10538; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=CbBsgcoFQqhzB9X8FxVIVPwtT/gD2BSFLE+Sv3uIDFA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqw3I6DRApiGhCdXXJ3PwzAl0mMhE76tM4SmfGp
 8yIkeX6xHKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCasNyOgAKCRAEWL7uWMY5
 RsS+D/4jO9cZ0DGotCFpkFzu0YKj6NiHGR6dK9ajnJR+VkWIVaDU0xvMBqybrIjayPW8DOMjQiV
 Q5KVLHvqiTAvtwXmZJR69E9RAhGGJ2F3mSZPioCl4EP1YsifnwdwuEh8VAIID7cCgSyxR7O6PPw
 /ZptwGtqil20EJniMB3+z3z7860icirU+zg1RBIWg70njICEiFIp99XO0dwKcOFjGisIRjT4IJf
 eXJbaWyP0iihYPAnFXWdg2yDCufwZfUORNLf+nObUy2CS/nF0Kjnom6zGCG2o5Q1UP0XvJT1ea2
 TNatAF4KzDbJFJfzZ/vA2/rPwuNoMRgugpUAsg9ZbUN2V4ene5kYz8a1DK7d1Xs1lT9r7OTSMzs
 pyRe4OtdW2XDMm89PbVHvrWj8Ijmusyk6oTLz0qWpMlzYB6bQyA+KKgRt6lHA5z1NRm2UTfvtNh
 bHRuF0bh5pRvKz8j6o12tVM+gpOnSgfEdJ14xQD89Y+r5khT3uwcpwtdwR/3Mi0P5SdlKVPZ4pV
 /T/MYENWZvIBYNfaiHpx04+++NP7pZ6yP+x1i1Yu/JDiGEXmEsTzOpcfoMo4LRtZLykbehjLpxl
 KWW/ZXJNtTPAKBjA9xb70+RaFihfk84ay6pY9vgDFS36n83FyMBlWkzn+pyAsNl4wQYdEjFAEBw +85e1L5N5OxGRFQ==
X-Mailer: b4 0.14.3
Message-ID: <20261005-devres-6-18-backport-v1-5-06dcf0e592d5@google.com>
Subject: [PATCH 6.18.y 5/5] rust: irq: pass RegistrationInner as cookie to request_irq
From: Alice Ryhl <aliceryhl@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Eliot Courtney <ecourtney@nvidia.com>, 
	Gary Guo <gary@garyguo.net>, Markus Probst <markus.probst@posteo.de>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

With commit ba268514ea14 ("rust: devres: fix race condition due to
nesting"), Devres::new() returns Result<Self> by value instead of
initializing in-place via PinInit. Because request_irq() is called
inside Devres::new(), registration.inner is still uninitialized when the
IRQ is enabled, so accessing registration.inner.device() in the IRQ
callback can read uninitialized memory.

Fix this by storing the Device and handler pointer in RegistrationInner
and passing RegistrationInner as the IRQ cookie after its fields are
initialized.

This is not needed in mainline because commit 98c63ce4d760 ("rust: irq:
make Registration compatible with lifetime-bound drivers") removed
Devres from irq::Registration.

Fixes: 29e16fcd67ee ("rust: irq: add &Device<Bound> argument to irq callbacks")
Fixes: ba268514ea14 ("rust: devres: fix race condition due to nesting")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/irq/request.rs | 89 ++++++++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 35 deletions(-)

diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
index 2ceeaeb0543a..70700f43ddd3 100644
--- a/rust/kernel/irq/request.rs
+++ b/rust/kernel/irq/request.rs
@@ -14,7 +14,7 @@
 use crate::irq::flags::Flags;
 use crate::prelude::*;
 use crate::str::CStr;
-use crate::sync::Arc;
+use crate::sync::{aref::ARef, Arc};
 
 /// The value that can be returned from a [`Handler`] or a [`ThreadedHandler`].
 #[repr(u32)]
@@ -54,13 +54,18 @@ fn handle(&self, device: &Device<Bound>) -> IrqReturn {
 /// # Invariants
 ///
 /// - `self.irq` is the same as the one passed to `request_{threaded}_irq`.
-/// - `cookie` was passed to `request_{threaded}_irq` as the cookie. It is guaranteed to be unique
+/// - `&self` was passed to `request_{threaded}_irq` as the cookie. It is guaranteed to be unique
 ///   by the type system, since each call to `new` will return a different instance of
 ///   `Registration`.
+/// - `self.handler` points to a valid instance of the handler `T` that lives at least until
+///   `Self::drop` completes.
 #[pin_data(PinnedDrop)]
 struct RegistrationInner {
     irq: u32,
-    cookie: *mut c_void,
+    dev: ARef<Device>,
+    handler: *const c_void,
+    #[pin]
+    _pin: PhantomPinned,
 }
 
 impl RegistrationInner {
@@ -77,18 +82,22 @@ fn drop(self: Pin<&mut Self>) {
         //
         // Safe as per the invariants of `RegistrationInner` and:
         //
-        // - The containing struct is `!Unpin` and was initialized using
+        // - `RegistrationInner` is `!Unpin` and was initialized using
         // pin-init, so it occupied the same memory location for the entirety of
         // its lifetime.
         //
         // Notice that this will block until all handlers finish executing,
         // i.e.: at no point will &self be invalid while the handler is running.
-        unsafe { bindings::free_irq(self.irq, self.cookie) };
+        unsafe {
+            bindings::free_irq(
+                self.irq,
+                core::ptr::from_mut::<Self>(self.get_unchecked_mut()).cast::<c_void>(),
+            )
+        };
     }
 }
 
-// SAFETY: We only use `inner` on drop, which called at most once with no
-// concurrent access.
+// SAFETY: `RegistrationInner` has no interior mutability and `handler` points to a `Sync` handler.
 unsafe impl Sync for RegistrationInner {}
 
 // SAFETY: It is safe to send `RegistrationInner` across threads.
@@ -180,7 +189,7 @@ pub fn irq(&self) -> u32 {
 ///
 /// # Invariants
 ///
-/// * We own an irq handler whose cookie is a pointer to `Self`.
+/// * We own an irq handler whose cookie is a pointer to `Self::inner`.
 #[pin_data]
 pub struct Registration<T: Handler + 'static> {
     #[pin]
@@ -207,10 +216,13 @@ pub fn new<'a>(
             handler <- handler,
             inner <- Devres::new(
                 request.dev,
-                try_pin_init!(RegistrationInner {
-                    // INVARIANT: `this` is a valid pointer to the `Registration` instance
-                    cookie: this.as_ptr().cast::<c_void>(),
-                    irq: {
+                try_pin_init!(&inner_this in RegistrationInner {
+                    irq: request.irq,
+                    dev: request.dev.into(),
+                    // SAFETY: `this` is a valid pointer to the `Registration` instance.
+                    handler: unsafe { &raw const (*this.as_ptr()).handler }.cast(),
+                    _pin: PhantomPinned,
+                    _: {
                         // SAFETY:
                         // - The callbacks are valid for use with request_irq.
                         // - If this succeeds, the slot is guaranteed to be valid until the
@@ -225,11 +237,10 @@ pub fn new<'a>(
                                 Some(handle_irq_callback::<T>),
                                 flags.into_inner(),
                                 name.as_char_ptr(),
-                                this.as_ptr().cast::<c_void>(),
+                                inner_this.as_ptr().cast::<c_void>(),
                             )
                         })?;
-                        request.irq
-                    }
+                    },
                 })
             ),
             _pin: PhantomPinned,
@@ -265,13 +276,15 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
     _irq: i32,
     ptr: *mut c_void,
 ) -> c_uint {
-    // SAFETY: `ptr` is a pointer to `Registration<T>` set in `Registration::new`
-    let registration = unsafe { &*(ptr as *const Registration<T>) };
+    // SAFETY: `ptr` is a pointer to `RegistrationInner` set in `Registration::new`
+    let inner = unsafe { &*(ptr as *const RegistrationInner) };
+    // SAFETY: `inner.handler` is a pointer to `T` set in `Registration::new`
+    let handler = unsafe { &*inner.handler.cast::<T>() };
     // SAFETY: The irq callback is removed before the device is unbound, so the fact that the irq
     // callback is running implies that the device has not yet been unbound.
-    let device = unsafe { registration.inner.device().as_bound() };
+    let device = unsafe { inner.dev.as_bound() };
 
-    T::handle(&registration.handler, device) as c_uint
+    T::handle(handler, device) as c_uint
 }
 
 /// The value that can be returned from [`ThreadedHandler::handle`].
@@ -401,7 +414,7 @@ fn handle_threaded(&self, device: &Device<Bound>) -> IrqReturn {
 ///
 /// # Invariants
 ///
-/// * We own an irq handler whose cookie is a pointer to `Self`.
+/// * We own an irq handler whose cookie is a pointer to `Self::inner`.
 #[pin_data]
 pub struct ThreadedRegistration<T: ThreadedHandler + 'static> {
     #[pin]
@@ -428,10 +441,13 @@ pub fn new<'a>(
             handler <- handler,
             inner <- Devres::new(
                 request.dev,
-                try_pin_init!(RegistrationInner {
-                    // INVARIANT: `this` is a valid pointer to the `ThreadedRegistration` instance.
-                    cookie: this.as_ptr().cast::<c_void>(),
-                    irq: {
+                try_pin_init!(&inner_this in RegistrationInner {
+                    irq: request.irq,
+                    dev: request.dev.into(),
+                    // SAFETY: `this` is a valid pointer to the `ThreadedRegistration` instance.
+                    handler: unsafe { &raw const (*this.as_ptr()).handler }.cast(),
+                    _pin: PhantomPinned,
+                    _: {
                         // SAFETY:
                         // - The callbacks are valid for use with request_threaded_irq.
                         // - If this succeeds, the slot is guaranteed to be valid until the
@@ -447,11 +463,10 @@ pub fn new<'a>(
                                 Some(thread_fn_callback::<T>),
                                 flags.into_inner(),
                                 name.as_char_ptr(),
-                                this.as_ptr().cast::<c_void>(),
+                                inner_this.as_ptr().cast::<c_void>(),
                             )
                         })?;
-                        request.irq
-                    }
+                    },
                 })
             ),
             _pin: PhantomPinned,
@@ -487,13 +502,15 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
     _irq: i32,
     ptr: *mut c_void,
 ) -> c_uint {
-    // SAFETY: `ptr` is a pointer to `ThreadedRegistration<T>` set in `ThreadedRegistration::new`
-    let registration = unsafe { &*(ptr as *const ThreadedRegistration<T>) };
+    // SAFETY: `ptr` is a pointer to `RegistrationInner` set in `ThreadedRegistration::new`
+    let inner = unsafe { &*(ptr as *const RegistrationInner) };
+    // SAFETY: `inner.handler` is a pointer to `T` set in `ThreadedRegistration::new`
+    let handler = unsafe { &*inner.handler.cast::<T>() };
     // SAFETY: The irq callback is removed before the device is unbound, so the fact that the irq
     // callback is running implies that the device has not yet been unbound.
-    let device = unsafe { registration.inner.device().as_bound() };
+    let device = unsafe { inner.dev.as_bound() };
 
-    T::handle(&registration.handler, device) as c_uint
+    T::handle(handler, device) as c_uint
 }
 
 /// # Safety
@@ -503,11 +520,13 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
     _irq: i32,
     ptr: *mut c_void,
 ) -> c_uint {
-    // SAFETY: `ptr` is a pointer to `ThreadedRegistration<T>` set in `ThreadedRegistration::new`
-    let registration = unsafe { &*(ptr as *const ThreadedRegistration<T>) };
+    // SAFETY: `ptr` is a pointer to `RegistrationInner` set in `ThreadedRegistration::new`
+    let inner = unsafe { &*(ptr as *const RegistrationInner) };
+    // SAFETY: `inner.handler` is a pointer to `T` set in `ThreadedRegistration::new`
+    let handler = unsafe { &*inner.handler.cast::<T>() };
     // SAFETY: The irq callback is removed before the device is unbound, so the fact that the irq
     // callback is running implies that the device has not yet been unbound.
-    let device = unsafe { registration.inner.device().as_bound() };
+    let device = unsafe { inner.dev.as_bound() };
 
-    T::handle_threaded(&registration.handler, device) as c_uint
+    T::handle_threaded(handler, device) as c_uint
 }

-- 
2.56.0.360.g66cac248cb-goog

