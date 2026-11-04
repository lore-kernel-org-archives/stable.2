Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801654;
	b=n3HA0WHRgMNS3YYAvY/qfSE41kVW4Jkv8ME1lDeyA5Yaw9cg1sR4L4eXrJosfoumTG5C
	 8HjFa3yQOyBb7xDb0gkEa7VxSJASr78xFnM0+uQN3JVJEYl/LJ1TMbEqsVFByJPSNvcHg
	 tKmO0xk8TPxSk2CRtu00rW5+DP9OsVK17cjOtgklQys5oxpsceGCSwbkz7MwkRfdvuofD
	 buVWSv8H0/plbzP68YBBG0S4Fp9nkffcQdVxYhFTOsCy1KQbKh+GZdSmo/jVnBFy7XymC
	 u1VVctLJM3aBQxwBipSyRqkyTkXf3HmcrXNEyuilxVWAeKRxfVyKzUkMjWZ7yC9fpzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801654;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HN5EdBmp7jc6AdnoG9r6wRnz0GPOcBsSLzM6xNXg/K0=;
	b=brlBxLfy0kdvhX0hujHEX1HTr8Xo5LpPmnq6Q7WDTpJJkKl8eDW7Vn/TzKuCg4mhtVQX
	 kvoDCB3kaGWCVSJ3yTCbveyT8vTLTboMr6HGaKZwcwPXDqxSTLhfyMEhtpTP+GzuNaIy8
	 Sg6ND/8bl6yf4bxB8zZVvVD2/cVHLm8jhoLemsNvoySn+aXLOCXBJI3pq6LWXD+00Rpcb
	 +LbNgtXhSFOXGKCzbpt16w9C6twJ/bJCp+tAh8nJBH6m/qWbb2x+nz+/0eqWTNRFVE/Zc
	 SkA0OrfZ9YLWgrH3UqKIWXVvSREXSkheA1eYFB5qs3VOYgjxPQi1+bONVmOWA1EyrnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="r/PcwQPA";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2803606A329
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=r/PcwQPA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BA71F00919;
	Wed,  4 Nov 2026 14:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793801653;
	bh=HN5EdBmp7jc6AdnoG9r6wRnz0GPOcBsSLzM6xNXg/K0=;
	h=Subject:To:Cc:From:Date;
	b=r/PcwQPArWI78Uck6Eaq7zX37RwQOyaymYRAzYpKV3oy80f9Odq3EODZt1qqmCmtR
	 Pc51q4CTg+oi0ZE1JJ8CWOg0dTm2YbO1HIS0mwMP5S4eV3LsqVeW3jwqhxay2WkmGD
	 uxSQbMIS2jWBFsZljDQm/p2hrbJuNjv0KzbDbHmc=
Subject: FAILED: patch "[PATCH] rust: irq: declare cfi_encoding for irqreturn" failed to apply to 6.18-stable tree
To: samitolvanen@google.com,aliceryhl@google.com,dakr@kernel.org,gary@garyguo.net,ojeda@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:14:07 +0100
Message-ID: <2026110407-hydrated-decipher-a8a9@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 01f3e6b4b1c8c1748e59ba53631ab1f5d9ad0ea4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110407-hydrated-decipher-a8a9@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 01f3e6b4b1c8c1748e59ba53631ab1f5d9ad0ea4 Mon Sep 17 00:00:00 2001
From: Sami Tolvanen <samitolvanen@google.com>
Date: Mon, 19 Oct 2026 23:34:37 +0000
Subject: [PATCH] rust: irq: declare cfi_encoding for irqreturn

The IRQ callbacks return c_uint. C calls them through irq_handler_t,
which returns enum irqreturn. kCFI encodes enum types by name even with
integer normalization, so the type ids never match and every call fails
the CFI check.

Generate irqreturn as a newtype with a cfi_encoding, as is done for
lru_status, and return bindings::irqreturn_t from the callbacks.

Fixes: 0851d34a8cc3 ("rust: irq: add support for non-threaded IRQs and handlers")
Fixes: 135d40523244 ("rust: irq: add support for threaded IRQs and handlers")
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261019-rust-cfi-fixes-v1-1-9503472ba738@google.com
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index 8402b0c93545..5059cc74cb3c 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -27,6 +27,8 @@
 --opaque-type spinlock
 
 # enums that appear in indirect function calls should specify a cfi type
+--newtype-enum irqreturn
+--with-attribute-custom-enum=irqreturn='#[cfi_encoding="9irqreturn"]'
 --newtype-enum lru_status
 --with-attribute-custom-enum=lru_status='#[cfi_encoding="10lru_status"]'
 
diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
index c1c6525a676a..1afa9fcaad1f 100644
--- a/rust/kernel/irq/request.rs
+++ b/rust/kernel/irq/request.rs
@@ -25,10 +25,10 @@
 #[repr(u32)]
 pub enum IrqReturn {
     /// The interrupt was not from this device or was not handled.
-    None = bindings::irqreturn_IRQ_NONE,
+    None = bindings::irqreturn::IRQ_NONE.0,
 
     /// The interrupt was handled by this device.
-    Handled = bindings::irqreturn_IRQ_HANDLED,
+    Handled = bindings::irqreturn::IRQ_HANDLED.0,
 }
 
 /// Callbacks for an IRQ handler.
@@ -240,25 +240,28 @@ fn drop(self: Pin<&mut Self>) {
 /// # Safety
 ///
 /// This function should be only used as the callback in `request_irq`.
-unsafe extern "C" fn handle_irq_callback<T: Handler>(_irq: i32, ptr: *mut c_void) -> c_uint {
+unsafe extern "C" fn handle_irq_callback<T: Handler>(
+    _irq: i32,
+    ptr: *mut c_void,
+) -> bindings::irqreturn_t {
     let ptr = ptr.cast_const().cast::<Registration<'_, T>>();
     // SAFETY: `ptr` is a pointer to `Registration<'_, T>` set in `Registration::new()`.
     let registration = unsafe { &*ptr };
 
-    T::handle(&registration.handler) as c_uint
+    bindings::irqreturn_t(T::handle(&registration.handler) as c_uint)
 }
 
 /// The value that can be returned from [`ThreadedHandler::handle`].
 #[repr(u32)]
 pub enum ThreadedIrqReturn {
     /// The interrupt was not from this device or was not handled.
-    None = bindings::irqreturn_IRQ_NONE,
+    None = bindings::irqreturn::IRQ_NONE.0,
 
     /// The interrupt was handled by this device.
-    Handled = bindings::irqreturn_IRQ_HANDLED,
+    Handled = bindings::irqreturn::IRQ_HANDLED.0,
 
     /// The handler wants the handler thread to wake up.
-    WakeThread = bindings::irqreturn_IRQ_WAKE_THREAD,
+    WakeThread = bindings::irqreturn::IRQ_WAKE_THREAD.0,
 }
 
 /// Callbacks for a threaded IRQ handler.
@@ -461,23 +464,26 @@ fn drop(self: Pin<&mut Self>) {
 unsafe extern "C" fn handle_threaded_irq_callback<T: ThreadedHandler>(
     _irq: i32,
     ptr: *mut c_void,
-) -> c_uint {
+) -> bindings::irqreturn_t {
     let ptr = ptr.cast_const().cast::<ThreadedRegistration<'_, T>>();
     // SAFETY: `ptr` is a pointer to `ThreadedRegistration<'_, T>` set in
     // `ThreadedRegistration::new()`.
     let registration = unsafe { &*ptr };
 
-    T::handle(&registration.handler) as c_uint
+    bindings::irqreturn_t(T::handle(&registration.handler) as c_uint)
 }
 
 /// # Safety
 ///
 /// This function should be only used as the callback in `request_threaded_irq`.
-unsafe extern "C" fn thread_fn_callback<T: ThreadedHandler>(_irq: i32, ptr: *mut c_void) -> c_uint {
+unsafe extern "C" fn thread_fn_callback<T: ThreadedHandler>(
+    _irq: i32,
+    ptr: *mut c_void,
+) -> bindings::irqreturn_t {
     let ptr = ptr.cast_const().cast::<ThreadedRegistration<'_, T>>();
     // SAFETY: `ptr` is a pointer to `ThreadedRegistration<'_, T>` set in
     // `ThreadedRegistration::new()`.
     let registration = unsafe { &*ptr };
 
-    T::handle_threaded(&registration.handler) as c_uint
+    bindings::irqreturn_t(T::handle_threaded(&registration.handler) as c_uint)
 }

