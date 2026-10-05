Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100AE46DFF3
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 09:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193677; cv=none; b=BQfYma/8qPBteWiS094q0pULmq28+K+RcbWb1iTGDVY2pAwZ8gFJcGLV34SELGTJY3TTsGr4FtsEqGdBV7msnJMPgwhCkI53ebk+5KYAecI0EEw4MgGT3iKvNYwxJ/y/wKsZlisbcg8YQXeBN+J3IPrWBj2CI9xicK2p4wNciQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193677; c=relaxed/simple;
	bh=B32qDS3gcB+1WivhncmZx9+HRXeiflsLRNnnwT5UD8Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fufAUuyPqG2OVC5bctbIxMOMwKpAdmzGlpkONhPzdqDNVZhphch3rvM1QqsDrvtWgdnx8gf0vjOf3b7Lev/uk0Qf0e8LgR3CeEF8SqbPEXnl6TxPl7SfWH14w1QNBK0v2tHePNstIN0vRz3Mw9nEFvxOhZ+a3hFc5XLOT7aHS5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TvWbaw5r; arc=none smtp.client-ip=209.85.221.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TvWbaw5r"
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48c628e8ad3so272910f8f.0
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 02:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791193665; x=1791798465; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pNBI4ObJP8a6bGvOAbuHeaewmMqjZ0XNbJMtmkjrPds=;
        b=TvWbaw5rmkBw9aTMWbFWJXwvfl6f5C5UmSoTHgl4PAoY3zbsV3DODvUn7uYbBE5OrJ
         t+JMcoZXuGpwPixGCP8OC312ylaT/nJSA3AbY+/xaPWgQUA4rYG4SPdDrvm+8O7GO0mf
         k7Xlqzl5ZpOG95j9JPyaTGQqFrsRIvc3TYN1ss3+ZcHxO2L6gNzlJrrvro3RI96XFDQj
         kouofl1/thAM5GBKLDCLH2Ua4ai6X/kxxYe0UXjtJY/zbOmcqir5mxZZiPcaZ7SjhDT/
         RLZQlEDE9vm2OId8fBJWghuttnMRr8HKPXG9RCjrjQgaiwYQCQ5JhjmlSKX+ZvtzmeEy
         GW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791193665; x=1791798465;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pNBI4ObJP8a6bGvOAbuHeaewmMqjZ0XNbJMtmkjrPds=;
        b=RHBFaU4mKvuIiTQbqcSxmIu5Oq41bd8O8L9BYxtIKSIGTH3JGlS80bfnNnLL0txVKO
         c4V+60birib7phOyH2s9rJ54h4h4UH1xkBcZZ/UR7ucae7BX6qO4S86JyljhL9VrALq6
         z+lL0cBg/gNA8JR8so8mn9luziNqrTNdgGPXcG2RvDpQwkgB4vkbkx9rPUp0Jq8IuJ4c
         QtBVWIoMyTPPh2D7rb8OF+V8wMkV8pE+g2vmDaCQoyeP3T64vS9xKJ+TJWqff/nAtLGu
         OXBXHWCvb/Do4FGS4qjtFsA2zw94ZMPymbVMYKWBKm9ousWfwG5uJTU3YFAscQ7/U75y
         IRxA==
X-Gm-Message-State: AFq9FYLkpmux4YtLoaIhj+XvYP3m2eNW36WBXAFc99y44IYuMniMj3rC
	hQUOA5TDOrQBEauEZlweoSwdlZjXS9ZgJ8CO82Gy+mHHkBhDQ7rFH+SEBBZ5ZhJ91bIpM8+eo/r
	hzl1OEnqShqRJv032ecQooQGZPYuV5ZQBLBr3oi5TZ1aQ+XKDfEZF7VKQo5+UKpeEpeWdB/BEUe
	P9NPgbvruwUQeUjQVOlLt1NngkJ7CeXizivhVpfWmVXErLTP2YXX4f
X-Received: from wrsg10.prod.google.com ([2002:a5d:46ca:0:b0:48b:11b1:8003])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:420c:b0:48b:123e:2f5c with SMTP id ffacd0b85a97d-48b1272a06dmr18816393f8f.29.1791193665031;
 Mon, 05 Oct 2026 02:47:45 -0700 (PDT)
Date: Mon, 05 Oct 2026 09:47:28 +0000
In-Reply-To: <20261005-devres-6-18-backport-v1-0-06dcf0e592d5@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261005-devres-6-18-backport-v1-0-06dcf0e592d5@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7131; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=49+mgO+857Fb8fNIEf5fsz+pgDGrjfu/2usGY+iAnAs=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqw3I65eMDiPuCqkvVmkdK2pErDDTEewMpNGxcs
 ZQXg1JD5wWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCasNyOgAKCRAEWL7uWMY5
 RnkLD/9e4N8enc4tAFjyqkpP6dV6PkcShNu/AoA9wBlGY/SytI+6sa4t2vGoGtqyjoqVdVkQwwu
 BGUiDjWUxyS7coG2igxup2NYyLg7B5cBVl8yGTfeTPhRauldoAY116HwsMmQxQL+r4DoBy4Js1J
 ZUekCMbCf1dqw7YwsBZzKu1kIGOXrVCPqDPNSUhOWi1JJYQM7T1tJuUP8wy8E4g2yO8vaWQUN87
 87+KsKlOL/eC3eHfFln/WcnHQdvU0Ruk0Eap5WV2CJ942vfRjioA7sWabaG4H7zJ/EQbRxA9WeW
 0tEWywd88YTszdO0iJbzIwnLA6jj3NjyDkrxC5wmtjIGHjhz4wC0wc707RrHBmXVqd6YLjhB4c8
 Cy/lSKA1Wo7jUtOP8t3lyIzpvXsHbFM6mPbvWT/QlpI/PJGs1byR4s1BEy9ysuR+9LhrFYElGTN
 XeeDd9IXJXYipqEStsLbJ8oozKLCunUaG8IOU3dqwHjY+9puKnjeO81YKMzupq9pqddt1Yx/BO4
 yXDCusc3z7qhzcrN4tHx0iLLozCiuNFNyucxJIWrtXOe6Hj46ByFXanmVwEEZUObeRpf4cOJAS6
 MQMN4H+9T8uCaAltTIIEYVXsyD5nBaJRdhIFyQOdgMITW8DsoNpxJQslzLH2GWgp+SYN1kQPBo1 pjLzm6n/aLicDqA==
X-Mailer: b4 0.14.3
Message-ID: <20261005-devres-6-18-backport-v1-3-06dcf0e592d5@google.com>
Subject: [PATCH 6.18.y 3/5] rust: devres: fix race between concurrent revokers
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
	Alice Ryhl <aliceryhl@google.com>, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="utf-8"

From: Danilo Krummrich <dakr@kernel.org>

commit acc516dfa1972d31836b50abc0115216cd0fccc5 upstream.

There is a potential race condition when two paths try to revoke a
Devres concurrently.

The driver core's devres_release_all() calls Revocable::revoke() via the
release callback, while Devres::drop() calls revoke_nosync() on another
CPU.

The revoker that does not claim the is_available swap returns
immediately, but the revoker that did may still be executing
drop_in_place() on the inner data. This can cause a use-after-free when
the other revoker's caller proceeds to drop adjacent resources that
drop_in_place() still references (e.g., Devres<DmaMappedSgt> racing with
SGTable freeing the backing sg_table and pages).

Fix this by adding a Completion. The release callback signals the
Completion after revoke() finishes, and Devres::drop() waits for it when
it loses the is_available swap. This ensures the wrapped object is fully
torn down before Devres::drop() returns.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/dri-devel/20260612202841.2577C1F000E9@smtp.kernel.org/
Fixes: 05aa6fb1c21d ("rust: scatterlist: Add abstraction for sg_table")
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://patch.msgid.link/20260628174451.2275679-1-dakr@kernel.org
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
[ Re-introduce Inner<T> for Arc<Inner<T>> as commit 9aa64d2503c6 ("rust:
  devres: embed struct devres_node directly") is not in 6.18. ]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/devres.rs | 56 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 0fea4f2844a5..02916f80db5a 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -13,10 +13,18 @@
     ffi::c_void,
     prelude::*,
     revocable::{Revocable, RevocableGuard},
-    sync::{aref::ARef, rcu, Arc},
+    sync::{aref::ARef, rcu, Arc, Completion},
     types::ForeignOwnable,
 };
 
+#[pin_data]
+struct Inner<T> {
+    #[pin]
+    data: Revocable<T>,
+    #[pin]
+    revocation: Completion,
+}
+
 /// This abstraction is meant to be used by subsystems to containerize [`Device`] bound resources to
 /// manage their lifetime.
 ///
@@ -31,6 +39,10 @@
 /// After the [`Devres`] has been unbound it is not possible to access the encapsulated resource
 /// anymore.
 ///
+/// When a [`Devres`] is dropped, it is guaranteed that `T` has been fully dropped by the time
+/// [`Devres::drop`] returns, even if a concurrent revocation through the release callback is in
+/// progress.
+///
 /// [`Devres`] users should make sure to simply free the corresponding backing resource in `T`'s
 /// [`Drop`] implementation.
 ///
@@ -104,7 +116,7 @@ pub struct Devres<T: Send + 'static> {
     /// Has to be stored, since Rust does not guarantee to always return the same address for a
     /// function. However, the C API uses the address as a key.
     callback: unsafe extern "C" fn(*mut c_void),
-    data: Arc<Revocable<T>>,
+    inner: Arc<Inner<T>>,
 }
 
 impl<T: Send + 'static> Devres<T> {
@@ -117,43 +129,51 @@ pub fn new<E>(dev: &Device<Bound>, data: impl PinInit<T, E>) -> Result<Self>
         Error: From<E>,
     {
         let callback = Self::devres_callback;
-        let data = Arc::pin_init(Revocable::new(data), GFP_KERNEL)?;
-        let devres_data = data.clone();
+        let inner = Arc::pin_init::<Error>(
+            try_pin_init!(Inner {
+                data <- Revocable::new(data),
+                revocation <- Completion::new(),
+            }),
+            GFP_KERNEL,
+        )?;
+        let devres_inner = inner.clone();
 
         // SAFETY:
         // - `dev.as_raw()` is a pointer to a valid bound device.
-        // - `data` is guaranteed to be a valid for the duration of the lifetime of `Self`.
+        // - `inner` is guaranteed to be a valid for the duration of the lifetime of `Self`.
         // - `devm_add_action()` is guaranteed not to call `callback` for the entire lifetime of
         //   `dev`.
         to_result(unsafe {
             bindings::devm_add_action(
                 dev.as_raw(),
                 Some(callback),
-                Arc::as_ptr(&data).cast_mut().cast(),
+                Arc::as_ptr(&inner).cast_mut().cast(),
             )
         })?;
 
         // `devm_add_action()` was successful and has consumed the reference count.
-        core::mem::forget(devres_data);
+        core::mem::forget(devres_inner);
 
         Ok(Self {
             dev: dev.into(),
             callback,
-            data,
+            inner,
         })
     }
 
     fn data(&self) -> &Revocable<T> {
-        &self.data
+        &self.inner.data
     }
 
     #[allow(clippy::missing_safety_doc)]
     unsafe extern "C" fn devres_callback(ptr: *mut kernel::ffi::c_void) {
-        // SAFETY: In `Self::new` we've passed a valid pointer of `Revocable<T>` to
-        // `devm_add_action()`, hence `ptr` must be a valid pointer to `Revocable<T>`.
-        let data = unsafe { Arc::from_raw(ptr.cast::<Revocable<T>>()) };
+        // SAFETY: In `Self::new` we've passed a valid pointer of `Inner<T>` to
+        // `devm_add_action()`, hence `ptr` must be a valid pointer to `Inner<T>`.
+        let inner = unsafe { Arc::from_raw(ptr.cast::<Inner<T>>()) };
 
-        data.revoke();
+        if inner.data.revoke() {
+            inner.revocation.complete_all();
+        }
     }
 
     fn remove_action(&self) -> bool {
@@ -165,7 +185,7 @@ fn remove_action(&self) -> bool {
             bindings::devm_remove_action_nowarn(
                 self.dev.as_raw(),
                 Some(self.callback),
-                core::ptr::from_ref(self.data()).cast_mut().cast(),
+                Arc::as_ptr(&self.inner).cast_mut().cast(),
             )
         } == 0)
     }
@@ -243,11 +263,15 @@ fn drop(&mut self) {
         if unsafe { self.data().revoke_nosync() } {
             // We revoked `self.data` before the devres action did, hence try to remove it.
             if self.remove_action() {
-                // SAFETY: In `Self::new` we have taken an additional reference count of `self.data`
+                // SAFETY: In `Self::new` we have taken an additional reference count of `self.inner`
                 // for `devm_add_action()`. Since `remove_action()` was successful, we have to drop
                 // this additional reference count.
-                drop(unsafe { Arc::from_raw(Arc::as_ptr(&self.data)) });
+                drop(unsafe { Arc::from_raw(Arc::as_ptr(&self.inner)) });
             }
+        } else {
+            // The release callback is concurrently revoking; wait for it to finish
+            // `drop_in_place()` of the wrapped object before returning.
+            self.inner.revocation.wait_for_completion();
         }
     }
 }

-- 
2.56.0.360.g66cac248cb-goog

