Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766BF456E11
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 09:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193672; cv=none; b=iJLqn2evRIM+p6uPk766XvDz5tdmoHDFOoHBJpoZ7/6k+gad5W4f36eUXtT+u06rEZmXk87E4DrwT5JnzXQSgUWpOl9GHkUwhVjOXairz2SCyNCVV9NFpix64PQ6A5hFCPY+0+ja+V7ilzIUxA+EUb3XIXWcgyzT3cuzkdMG/kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193672; c=relaxed/simple;
	bh=KjMVj7DFYl4/xFBcYhgI3H6VCEsnPnKioVDIfjADtYw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sUp1BbNvkfaTtQbu5XBfDRo54mNwzk0CD4EAjWdZ+Yeu8b4mcrPPYaydZ2JmRfIi0qECmz3HqyKiw+bzMBUQ2h7Yu2VrQJKkD87Msc1u1OJh+zsMtBs6xc9gYza3p7oZnXdGN2tpJVVhk87NGtiGKKaoHnPo2hubQDwNqf3HSVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N5nUdXMh; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N5nUdXMh"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a009f82bedso7413175e9.0
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 02:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791193662; x=1791798462; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LPzMZdZY/yX1DXs2u/QyN/dzvLdok9v7P4orL1JcPkE=;
        b=N5nUdXMhYNeCVUL2lvDtDP1D9o0O91FDEMBzgRNRmLwlc0Q4hA927cOVMV0zU0jAe+
         yDLyh90w4oaFBhOFRip/b3vVrfxiYEWfzazbXjtFC0dN72SzyEB6HxETEdVp0x2ySXGI
         wnoa/kqlkPHjSEfC/LG+p42D2m52WvgztDtpiJpcU3pMUevmJ7vjMHa4jaQ+66BeVpq1
         3svFvKcHB9pnFB+MIi+eB7fd4+Bz7zNlDO8o324jyiiH9mZg08OzDtYzn+LdSE2K9Poz
         MfAVk8rClApSyovcpzBTG2hJg9F1VKLx5CrzRLDaDU0vrmBTRHfNNiGWlEq8bRVW7hYW
         BGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791193662; x=1791798462;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LPzMZdZY/yX1DXs2u/QyN/dzvLdok9v7P4orL1JcPkE=;
        b=NDil3HpjTW4F6130feazEXn8fvOMLyOEetoxmOuJvUU2+lRX3W1ep1BVhaXcwKKKqe
         0mM+QhVqJ2C64et+0R3Z+2uybF5Cqta9oE7HDaVmGMs8X7WXs8PMpucDW3qMr0+gWbzw
         QE3syZDaC2AoJwex/GIvYII306bOvG5gj6uvcfoH7fxEpVEyKP9U1/Ri8wgq4OItu8BT
         1aRdyR1ON+BOSV22ACi0Rq54vBWI4LwOV9jnnyApUqI4PGeeWjnizc9yWvCc0b6+6HW2
         7EMr79eIFl2c+SUZfhxunWR9VtlwSpqINyHSFbD/If52LfrntcdqvMotLjR5vsMbzZKt
         SuAw==
X-Gm-Message-State: AFuF++kMBmFQvBbazMZ0mUOhNPxF7dGwD//WNpj4CgMzUasQ8nnHS9V0
	by+F8n1jkQ9krzvL4v9ZFrZU0f6x3rz3ZCuH0oOl5h+pf/1mjRsGPmCzATgW4jTlWqxB7ZqHlId
	EeJmGS/BPK4tozaR2NghfMSt/mbVdxXVIdSeoPcHmNZgqofUYYlpW5WNyCz4AinBTVQ4sINyMBL
	b56a6VkMuoJPISVD/xc0vTgOLJKmm4k3n8SIiV1Sqz6TzZnHR+wBnZ
X-Received: from wrve2.prod.google.com ([2002:a5d:5302:0:b0:488:7f88:84a2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:474c:b0:4a0:89:6727 with SMTP id 5b1f17b1804b1-4a02756efd4mr170503505e9.16.1791193662023;
 Mon, 05 Oct 2026 02:47:42 -0700 (PDT)
Date: Mon, 05 Oct 2026 09:47:26 +0000
In-Reply-To: <20261005-devres-6-18-backport-v1-0-06dcf0e592d5@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261005-devres-6-18-backport-v1-0-06dcf0e592d5@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=12880; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=5odWMiTWog9Fc/mWDF2G7I0wCfaLbw7MIq1+t/k/TzY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqw3I6nAqRt0/NpEf3UgQNWcw71xzskR0PQwyr6
 hbfdPGC0TuJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCasNyOgAKCRAEWL7uWMY5
 RvuED/0ZKlUyZf9e/VfLWK7citTMLiqclr6pIydt0FDEhyKBAUB9dbg+JJ6ran7R8XPnIVQuUpx
 Oa1orCjzjayBTxOn9CiPfyaiZ1ILUJcnBfuu8+WbHD8JpVe3KGS7TqISGTi8UZsoKHFQDAj99GW
 Sd1WbwR9ArKl9U4JDsO4af1SJ/kza3aW/DLHtGT/umZJPL9aTnJEddj8EvoO/B9EHt9MDrRWPxF
 O2AcgiKiYrj2/J8kiWc9V1CO1rT0XSfH97K26ItsBxF0a3K6zYgVuMs4BJXFW9euCEqbITDtHs8
 rQYcnb75RJPH61UUoIu4X/hX0sHA9ZJpm6t3PP8lEcJl0h6wXFXQOPP8qLiT2O/fjaX90hiYBHv
 akYnjK638tir6uPK9a5XmaQu9GwIeTB6HkJTuAQORWiRBnGLS0XRhDR+68FmbEa6x3bRMK8YNCV
 A7niF0QNg9unwBm/n/m/GuQm5dOAm06rcRjWoqej1e1uZt3kPizRRxVl32qDmckQCv0lareC+ai
 kXBFWAXuQ+f3P3Eeja2hyqImO5PoGdN4ZLViczPRA22g6R5GdEtwhB7frqpIXcQv2Wei9NcrmGJ
 HixCMPPky9zn7Ig7HXP7e/Sr6QKy4hfBHAnppymDOFCJyARRLo7JCXm9u9EMWougJI7fdUQ8Cbx UdawMaeO2sv/vJg==
X-Mailer: b4 0.14.3
Message-ID: <20261005-devres-6-18-backport-v1-1-06dcf0e592d5@google.com>
Subject: [PATCH 6.18.y 1/5] rust: devres: fix race condition due to nesting
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

From: Danilo Krummrich <dakr@kernel.org>

commit ba268514ea14b44570030e8ed2aef92a38679e85 upstream.

Commit f5d3ef25d238 ("rust: devres: get rid of Devres' inner Arc") did
attempt to optimize away the internal reference count of Devres.

However, without an internal reference count, we can't support cases
where Devres is indirectly nested, resulting into a deadlock.

Such indirect nesting easily happens in the following way:

A registration object (which is guarded by devres) hold a reference
count of an object that holds a device resource guarded by devres
itself.

For instance a drm::Registration holds a reference of a drm::Device. The
drm::Device itself holds a device resource in its private data.

When the drm::Registration is dropped by devres, and it happens that it
did hold the last reference count of the drm::Device, it also drops the
device resource, which is guarded by devres itself.

Thus, resulting into a deadlock in the Devres destructor of the device
resource, as in the following backtrace.

	sysrq: Show Blocked State
	task:rmmod           state:D stack:0     pid:1331  tgid:1331  ppid:1330   task_flags:0x400100 flags:0x00000010
	Call trace:
	 __switch_to+0x190/0x294 (T)
	 __schedule+0x878/0xf10
	 schedule+0x4c/0xcc
	 schedule_timeout+0x44/0x118
	 wait_for_common+0xc0/0x18c
	 wait_for_completion+0x18/0x24
	 _RINvNtCs4gKlGRWyJ5S_4core3ptr13drop_in_placeINtNtNtCsgzhNYVB7wSz_6kernel4sync3arc3ArcINtNtBN_6devres6DevresmEEECsRdyc7Hyps3_15rust_driver_pci+0x68/0xe8 [rust_driver_pci]
	 _RINvNvNtCsgzhNYVB7wSz_6kernel6devres16register_foreign8callbackINtNtCs4gKlGRWyJ5S_4core3pin3PinINtNtNtB6_5alloc4kbox3BoxINtNtNtB6_4sync3arc3ArcINtB4_6DevresmEENtNtB1A_9allocator7KmallocEEECsRdyc7Hyps3_15rust_driver_pci+0x34/0xc8 [rust_driver_pci]
	 devm_action_release+0x14/0x20
	 devres_release_all+0xb8/0x118
	 device_release_driver_internal+0x1c4/0x28c
	 driver_detach+0x94/0xd4
	 bus_remove_driver+0xdc/0x11c
	 driver_unregister+0x34/0x58
	 pci_unregister_driver+0x20/0x80
	 __arm64_sys_delete_module+0x1d8/0x254
	 invoke_syscall+0x40/0xcc
	 el0_svc_common+0x8c/0xd8
	 do_el0_svc+0x1c/0x28
	 el0_svc+0x54/0x1d4
	 el0t_64_sync_handler+0x84/0x12c
	 el0t_64_sync+0x198/0x19c

In order to fix this, re-introduce the internal reference count.

Reported-by: Boris Brezillon <boris.brezillon@collabora.com>
Closes: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/.E2.9C.94.20Deadlock.20caused.20by.20nested.20Devres/with/571242651
Reported-by: Markus Probst <markus.probst@posteo.de>
Closes: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/.E2.9C.94.20Devres.20inside.20Devres.20stuck.20on.20cleanup/with/571239721
Reported-by: Alice Ryhl <aliceryhl@google.com>
Closes: https://gitlab.freedesktop.org/panfrost/linux/-/merge_requests/56#note_3282757
Fixes: f5d3ef25d238 ("rust: devres: get rid of Devres' inner Arc")
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Boris Brezillon <boris.brezillon@collabora.com>
Link: https://patch.msgid.link/20260205222529.91465-1-dakr@kernel.org
[ Call clone() prior to devm_add_action(). - Danilo ]
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/devres.rs | 145 ++++++++++++++------------------------------------
 1 file changed, 40 insertions(+), 105 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 835d9c11948e..562dd54fbe43 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -13,25 +13,10 @@
     ffi::c_void,
     prelude::*,
     revocable::{Revocable, RevocableGuard},
-    sync::{aref::ARef, rcu, Completion},
-    types::{ForeignOwnable, Opaque, ScopeGuard},
+    sync::{aref::ARef, rcu, Arc},
+    types::ForeignOwnable,
 };
 
-use pin_init::Wrapper;
-
-/// [`Devres`] inner data accessed from [`Devres::callback`].
-#[pin_data]
-struct Inner<T: Send> {
-    #[pin]
-    data: Revocable<T>,
-    /// Tracks whether [`Devres::callback`] has been completed.
-    #[pin]
-    devm: Completion,
-    /// Tracks whether revoking [`Self::data`] has been completed.
-    #[pin]
-    revoke: Completion,
-}
-
 /// This abstraction is meant to be used by subsystems to containerize [`Device`] bound resources to
 /// manage their lifetime.
 ///
@@ -105,18 +90,13 @@ struct Inner<T: Send> {
 /// # fn no_run(dev: &Device<Bound>) -> Result<(), Error> {
 /// // SAFETY: Invalid usage for example purposes.
 /// let iomem = unsafe { IoMem::<{ core::mem::size_of::<u32>() }>::new(0xBAAAAAAD)? };
-/// let devres = KBox::pin_init(Devres::new(dev, iomem), GFP_KERNEL)?;
+/// let devres = Devres::new(dev, iomem)?;
 ///
 /// let res = devres.try_access().ok_or(ENXIO)?;
 /// res.write8(0x42, 0x0);
 /// # Ok(())
 /// # }
 /// ```
-///
-/// # Invariants
-///
-/// `Self::inner` is guaranteed to be initialized and is always accessed read-only.
-#[pin_data(PinnedDrop)]
 pub struct Devres<T: Send> {
     dev: ARef<Device>,
     /// Pointer to [`Self::devres_callback`].
@@ -124,14 +104,7 @@ pub struct Devres<T: Send> {
     /// Has to be stored, since Rust does not guarantee to always return the same address for a
     /// function. However, the C API uses the address as a key.
     callback: unsafe extern "C" fn(*mut c_void),
-    /// Contains all the fields shared with [`Self::callback`].
-    // TODO: Replace with `UnsafePinned`, once available.
-    //
-    // Subsequently, the `drop_in_place()` in `Devres::drop` and `Devres::new` as well as the
-    // explicit `Send` and `Sync' impls can be removed.
-    #[pin]
-    inner: Opaque<Inner<T>>,
-    _add_action: (),
+    data: Arc<Revocable<T>>,
 }
 
 impl<T: Send> Devres<T> {
@@ -139,74 +112,48 @@ impl<T: Send> Devres<T> {
     ///
     /// The `data` encapsulated within the returned `Devres` instance' `data` will be
     /// (revoked)[`Revocable`] once the device is detached.
-    pub fn new<'a, E>(
-        dev: &'a Device<Bound>,
-        data: impl PinInit<T, E> + 'a,
-    ) -> impl PinInit<Self, Error> + 'a
+    pub fn new<E>(dev: &Device<Bound>, data: impl PinInit<T, E>) -> Result<Self>
     where
-        T: 'a,
         Error: From<E>,
     {
-        try_pin_init!(&this in Self {
-            dev: dev.into(),
-            callback: Self::devres_callback,
-            // INVARIANT: `inner` is properly initialized.
-            inner <- Opaque::pin_init(try_pin_init!(Inner {
-                    devm <- Completion::new(),
-                    revoke <- Completion::new(),
-                    data <- Revocable::new(data),
-            })),
-            // TODO: Replace with "initializer code blocks" [1] once available.
-            //
-            // [1] https://github.com/Rust-for-Linux/pin-init/pull/69
-            _add_action: {
-                // SAFETY: `this` is a valid pointer to uninitialized memory.
-                let inner = unsafe { &raw mut (*this.as_ptr()).inner };
+        let callback = Self::devres_callback;
+        let data = Arc::pin_init(Revocable::new(data), GFP_KERNEL)?;
+        let devres_data = data.clone();
+
+        // SAFETY:
+        // - `dev.as_raw()` is a pointer to a valid bound device.
+        // - `data` is guaranteed to be a valid for the duration of the lifetime of `Self`.
+        // - `devm_add_action()` is guaranteed not to call `callback` for the entire lifetime of
+        //   `dev`.
+        to_result(unsafe {
+            bindings::devm_add_action(
+                dev.as_raw(),
+                Some(callback),
+                Arc::as_ptr(&data).cast_mut().cast(),
+            )
+        })?;
 
-                // SAFETY:
-                // - `dev.as_raw()` is a pointer to a valid bound device.
-                // - `inner` is guaranteed to be a valid for the duration of the lifetime of `Self`.
-                // - `devm_add_action()` is guaranteed not to call `callback` until `this` has been
-                //    properly initialized, because we require `dev` (i.e. the *bound* device) to
-                //    live at least as long as the returned `impl PinInit<Self, Error>`.
-                to_result(unsafe {
-                    bindings::devm_add_action(dev.as_raw(), Some(*callback), inner.cast())
-                }).inspect_err(|_| {
-                    let inner = Opaque::cast_into(inner);
+        // `devm_add_action()` was successful and has consumed the reference count.
+        core::mem::forget(devres_data);
 
-                    // SAFETY: `inner` is a valid pointer to an `Inner<T>` and valid for both reads
-                    // and writes.
-                    unsafe { core::ptr::drop_in_place(inner) };
-                })?;
-            },
+        Ok(Self {
+            dev: dev.into(),
+            callback,
+            data,
         })
     }
 
-    fn inner(&self) -> &Inner<T> {
-        // SAFETY: By the type invairants of `Self`, `inner` is properly initialized and always
-        // accessed read-only.
-        unsafe { &*self.inner.get() }
-    }
-
     fn data(&self) -> &Revocable<T> {
-        &self.inner().data
+        &self.data
     }
 
     #[allow(clippy::missing_safety_doc)]
     unsafe extern "C" fn devres_callback(ptr: *mut kernel::ffi::c_void) {
-        // SAFETY: In `Self::new` we've passed a valid pointer to `Inner` to `devm_add_action()`,
-        // hence `ptr` must be a valid pointer to `Inner`.
-        let inner = unsafe { &*ptr.cast::<Inner<T>>() };
+        // SAFETY: In `Self::new` we've passed a valid pointer of `Revocable<T>` to
+        // `devm_add_action()`, hence `ptr` must be a valid pointer to `Revocable<T>`.
+        let data = unsafe { Arc::from_raw(ptr.cast::<Revocable<T>>()) };
 
-        // Ensure that `inner` can't be used anymore after we signal completion of this callback.
-        let inner = ScopeGuard::new_with_data(inner, |inner| inner.devm.complete_all());
-
-        if !inner.data.revoke() {
-            // If `revoke()` returns false, it means that `Devres::drop` already started revoking
-            // `data` for us. Hence we have to wait until `Devres::drop` signals that it
-            // completed revoking `data`.
-            inner.revoke.wait_for_completion();
-        }
+        data.revoke();
     }
 
     fn remove_action(&self) -> bool {
@@ -218,7 +165,7 @@ fn remove_action(&self) -> bool {
             bindings::devm_remove_action_nowarn(
                 self.dev.as_raw(),
                 Some(self.callback),
-                core::ptr::from_ref(self.inner()).cast_mut().cast(),
+                core::ptr::from_ref(self.data()).cast_mut().cast(),
             )
         } == 0)
     }
@@ -289,31 +236,19 @@ unsafe impl<T: Send> Send for Devres<T> {}
 // SAFETY: `Devres` can be shared with any task, if `T: Sync`.
 unsafe impl<T: Send + Sync> Sync for Devres<T> {}
 
-#[pinned_drop]
-impl<T: Send> PinnedDrop for Devres<T> {
-    fn drop(self: Pin<&mut Self>) {
+impl<T: Send> Drop for Devres<T> {
+    fn drop(&mut self) {
         // SAFETY: When `drop` runs, it is guaranteed that nobody is accessing the revocable data
         // anymore, hence it is safe not to wait for the grace period to finish.
         if unsafe { self.data().revoke_nosync() } {
             // We revoked `self.data` before the devres action did, hence try to remove it.
-            if !self.remove_action() {
-                // We could not remove the devres action, which means that it now runs concurrently,
-                // hence signal that `self.data` has been revoked by us successfully.
-                self.inner().revoke.complete_all();
-
-                // Wait for `Self::devres_callback` to be done using this object.
-                self.inner().devm.wait_for_completion();
+            if self.remove_action() {
+                // SAFETY: In `Self::new` we have taken an additional reference count of `self.data`
+                // for `devm_add_action()`. Since `remove_action()` was successful, we have to drop
+                // this additional reference count.
+                drop(unsafe { Arc::from_raw(Arc::as_ptr(&self.data)) });
             }
-        } else {
-            // `Self::devres_callback` revokes `self.data` for us, hence wait for it to be done
-            // using this object.
-            self.inner().devm.wait_for_completion();
         }
-
-        // INVARIANT: At this point it is guaranteed that `inner` can't be accessed any more.
-        //
-        // SAFETY: `inner` is valid for dropping.
-        unsafe { core::ptr::drop_in_place(self.inner.get()) };
     }
 }
 

-- 
2.56.0.360.g66cac248cb-goog

