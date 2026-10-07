Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360683B14BB
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 06:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791352931; cv=none; b=g1FU0CKErRKIs83VK64aae7Kii3FxcKM+Cp00FwsgCAb8ehB/rkGyUMmMX8yaufWZhBXEL4SEHAwyNsVxbD2mukH/bGV7W8Vv+tLG6b1g+H8XcAdW7W6EpU51VMexJa4M8goacubwlexk/5a3z6ve8+NqILhWd7KZU0Twk4PDJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791352931; c=relaxed/simple;
	bh=rQfaCbBZLe4g1iOwgkblh3H4rtlzI9x5A6MeoY1dh5o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OWWoPHAKDZWnbWhgMWLGaj0xgreJ7THYTz15lenCHBCvr7XVp4HGz/aMOAiKHPeG27nCM1PReGeyTFEJOn2k26Juv/RKfmGNP8iha8qN9zFnQobMSPhlF2PC6arSO2VYhZWfBtxDIDxAyVDOjm6x4Bp/QqHWawj3xGox2eP8zpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XAv0bhof; arc=none smtp.client-ip=209.85.208.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XAv0bhof"
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6aaa3fa0bd5so4410973a12.3
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 23:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791352928; x=1791957728; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cXKngLXqd7wBtEapgw6gle8hlEt27JPb69mdqcAv6zU=;
        b=XAv0bhof8aafa2NHQKEKFrJ+RAqiaQXS15+OOVtd/tRK82bkVL7E2iba8t2MBOiOLE
         MqizSu2iU1PmSWyrtdzU6fAkn+gw1fOEB6PO1ZFugmJvWmCezPTDy+20MPsfk6FeT7rg
         wO36VaBMOqsALRThmgjKMa8gvLu6KHYToXC1V8Rw1eVL/LNVYdbB7xc+CCVMi6SWFB+i
         ShdoS3JZW3DTMSb2gjCWK5ZJEThzQ6Jsv3u+E/gaXDljGaYHpvhKApLKEFMHjGmmDvZS
         /No15cajAXuFwYUtXddhAJHJM4pXQ/3hgb6F8eMOyJoOeZXABpLIJ4fGTdVh3rzfdzLE
         N/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791352928; x=1791957728;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cXKngLXqd7wBtEapgw6gle8hlEt27JPb69mdqcAv6zU=;
        b=wFbYLcT8k6ru2noI6+RFsaWbz4hgJQhAPeeoh+uva3f5hONaOV8JzBZdkWkU5cZAck
         VYXbyZCwH0v5Wemph7mpls8gf6GySFnt+1eHiWAUVwdG8NKwXPnGgbvWMquvU2dvMfc4
         MIwvTaJygiKqvbWx9fyCsj31SngNU9sKBVfV/M0A7zHrHN/GE3M7/wfIO5CqZIsZEI+N
         xWIBDLeUPyODmN6n9v3FuK1dP7G4LwIEnu2Ay0nBvQqeDqOfgIV9LCvGioTHxJ07Fcbh
         3FjAnJR9H/ELR2uttKFsHTdhWrHs6eAqIAADhKV7+6J+nG3Z89Kj2ONak2jz/z+2copx
         HlXA==
X-Gm-Message-State: AFq9FYI1WVuG2dfIlhhk8lflSvRjw2o/OwwjhduDrKtzL7ZPaNDLtMLW
	H7XWrCWpZfgpeAEp39uW+fKCZmn64A+M8HYCa7kR1SfREhp7FI3lUKnFaSYh0hDA3u6krnlXYXo
	UT9Q8JhXUUNqD2UI0twwXHgwpU53RiV0hBe7gaV+MynZAiWRlEMRuo+uZcoMidjY7TPgPPF/OTa
	ex1srko4zjt5gEckXs7JhQTHy7XqPLiddsR9YjVi8WvDFhg76HWYSE
X-Received: from edfh25-n1.prod.google.com ([2002:a05:6402:a299:10b0:6af:f782:bcdf])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2348:b0:6ac:b861:dab3 with SMTP id 4fb4d7f45d1cf-6aff47d68b6mr1042163a12.39.1791352928116;
 Tue, 06 Oct 2026 23:02:08 -0700 (PDT)
Date: Wed, 07 Oct 2026 06:01:58 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFXgxWoC/x3MwQqDMAyA4VeRnE1Jg2vBVxkerGYaBHWpjA3x3
 Vc8fof/PyGLqWRoqxNMPpp1Wwt8XcEw9+skqGMxMHHwRAHV3hiRMfXDsm92oPcxRWqaRA+Gku0 mL/3eyydEx+4H3XX9AX6Z/AhpAAAA
X-Change-Id: 20261006-irq-7-2-backport-117b7044b052
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=11005; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=rQfaCbBZLe4g1iOwgkblh3H4rtlzI9x5A6MeoY1dh5o=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqxeBZelHrU8v5IqHLX+XnQ8LTujjZjPuKceE5C
 5bXZMrWvLCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCasXgWQAKCRAEWL7uWMY5
 RlmOD/sEQSWFAFRJsCQkyxoBeZ47XD5nT0/NWRDUX/5MKLrRYMVEdbhEdbUIc7WutoHzVGtqKro
 Crbvh4GFe4vqA4lwIg7hMPJAK6UHGfJ5qJUTRpTDqEhw0GZDhdWLD3Y5FvM3J0ueYCP4jvBKuSq
 H7DhVVR8MrJq5ZG/BM4/np1PQ+1EMt8rPUm+GAR3pe0jS5IrEQqmHSztihvxiIecl/3V/PpXsck
 zJdmFRLuJG/fNLS3JN8xHMGMzd/mhEexpFm6UXFupN5iCmBlCBBxPy/8Oq1tQuy2QETff0KUAyw
 5y6teApRE0XDBnKjGXq+X83lcPZbf2gVxyVeYgNJcc4K23qcABenpKgz8L2Y/sPCQfgFCwrkqZd
 KaoglRyWAHorwvl6RuOlo5hi5kuMqSkIib3InwXFf72E/uXUBXtDShz8Xnz94lv5nQXeDRQpZOg
 djTGYGArmGqHIOvmwM3WknWIe1FMNMrISf7pvmiqt4Azoq3KVZBP9FSzJ2mSRpoBfEwT6cq9UZ7
 OapascmRGhg6cGdLFYtaVH+32F3oVLwG6TfiNyD12GG3JLt3cF+N+xuuPnRimLanZXqjajOaPaj
 fcl2OX6rd2q7avZDOzFBTd2JR7Z41o0Q/tqU4qUHbKYA4hSyCQCa/w728R2mc/ab7NABtwmqdKD xp5g7WeKKCCFc3w==
X-Mailer: b4 0.14.3
Message-ID: <20261007-irq-7-2-backport-v1-1-183f514f2aac@google.com>
Subject: [PATCH 7.2.y] rust: irq: pass RegistrationInner as cookie to request_irq
From: Alice Ryhl <aliceryhl@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Boqun Feng <boqun@kernel.org>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Eliot Courtney <ecourtney@nvidia.com>, 
	Gary Guo <gary@garyguo.net>, Markus Probst <markus.probst@posteo.de>, 
	Miguel Ojeda <ojeda@kernel.org>, "=?utf-8?q?Onur_=C3=96zkan?=" <work@onurozkan.dev>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Tamir Duberstein <tamird@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
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
Devres from irq::Registration and moved request_irq() after all fields
are initialized.

Fixes: 29e16fcd67ee ("rust: irq: add &Device<Bound> argument to irq callbacks")
Fixes: ba268514ea14 ("rust: devres: fix race condition due to nesting")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
This is the 7.2 version of:
https://lore.kernel.org/all/20261005-devres-6-18-backport-v1-5-06dcf0e592d5@google.com/
---
 rust/kernel/irq/request.rs | 89 ++++++++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 35 deletions(-)

diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
index f425fe12f7c8..d84a32ff0f7c 100644
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
@@ -179,7 +188,7 @@ pub fn irq(&self) -> u32 {
 ///
 /// # Invariants
 ///
-/// * We own an irq handler whose cookie is a pointer to `Self`.
+/// * We own an irq handler whose cookie is a pointer to `Self::inner`.
 #[pin_data]
 pub struct Registration<T: Handler> {
     #[pin]
@@ -206,10 +215,13 @@ pub fn new<'a>(
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
@@ -224,11 +236,10 @@ pub fn new<'a>(
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
@@ -261,13 +272,15 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
 ///
 /// This function should be only used as the callback in `request_irq`.
 unsafe extern "C" fn handle_irq_callback<T: Handler>(_irq: i32, ptr: *mut c_void) -> c_uint {
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
@@ -396,7 +409,7 @@ fn handle_threaded(&self, device: &Device<Bound>) -> IrqReturn {
 ///
 /// # Invariants
 ///
-/// * We own an irq handler whose cookie is a pointer to `Self`.
+/// * We own an irq handler whose cookie is a pointer to `Self::inner`.
 #[pin_data]
 pub struct ThreadedRegistration<T: ThreadedHandler> {
     #[pin]
@@ -423,10 +436,13 @@ pub fn new<'a>(
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
@@ -442,11 +458,10 @@ pub fn new<'a>(
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
@@ -482,24 +497,28 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
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
 ///
 /// This function should be only used as the callback in `request_threaded_irq`.
 unsafe extern "C" fn thread_fn_callback<T: ThreadedHandler>(_irq: i32, ptr: *mut c_void) -> c_uint {
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

---
base-commit: 5fce161649b4d779d1b76d9fcd52dc77779774b8
change-id: 20261006-irq-7-2-backport-117b7044b052

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

