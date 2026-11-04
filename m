Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793831811;
	b=G8Rtgv+7aGfd12z5IWjjswxGqahn6D4pLGir0f4rJ1d/zLtnDOWKhIrZ7BndRfXJZya2
	 6ljz96DULt2175e0gnQZa3/HghX+LG5JGS+L180bvLjUqjL+lO8Tg6B+2Z7UhiqdCeu3g
	 G3Wye4OmnQIOPtoMSYp1ma0A/5Kb3ddEjFLNfalZITy+WqaiJjKWCp2FqVTlUO+KcfEpd
	 NTdOBDtc5GT8uGfITqeVn1EtW5eq8/oIlsH707hwVZiYMYSLmR9+Je1k0vayVIpRVZyhR
	 e9wBCn5kkMAnnDVcYA8pgls+T1tjoEpxnxEGw/HjzEqXe5ZNpmYSHNMoDJzIWa9lbfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793831811;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zX++9I2DfscRQXteGt7QPsKvk0K+ejOj2VW52nYgAes=;
	b=4R5ZwIg5GswCB4Vygn7SAJ0TTVlrQiRgXAg/i/guz1z5h329SUU5GNLChkC0NBinkWyW
	 MIGave8yQqpRaG3x5FYcwvNffSbGMf0XE5Ks8kdV/qHsYoRoovl1IlZUcXJYoOu2AEG5r
	 +81n6g7LshEMjeOmhBAB4rUzfOUhNdLhMOdiN1a+nWguaFduYqfsPFIehqLhXVbznH5qm
	 E6mxTNEiZuXF9z5mk/E7SRBqrsZv/APtGpVLr+g+XRJnOZMnKK3+0rCTxgKXYyQMM9HxF
	 uOGJG/9hKbEK/ea5ezrkNkqHB9CUZ3XxBqFT/+Fi3XpoNo8RAxUqGlhHhi6fpxl+53A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S7KzrwKZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEED606A863
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 22:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S7KzrwKZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CA71F000C1;
	Wed,  4 Nov 2026 22:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793831810;
	bh=zX++9I2DfscRQXteGt7QPsKvk0K+ejOj2VW52nYgAes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S7KzrwKZqbCpQnwAqf6DZ8ck2wesQrG2FfPfmM/TC9dvIrSIW9ZP37GeWvUwzEbow
	 rLrGsuyIhYF77wcr0LKEh0bZLqAD75gXZGMSKnuYyF0l1kNpsCtcw/HL0O2E2HUpVk
	 aATqFdG0QKM/+x8kxp3Hr0KXLsvpUKn3IxUobAuj/2nHty9szZ/LTsjukJCNOLfwCh
	 onqB6aCUIPoaWiMnbXsTn7CdXBw1PDi43mJoJMYqi1239AVHQrnbMHHGVMKYGO7ES2
	 x4Zixk6MSZTPai8RUvx1UbBuMgg9hmQm2HLx46CMX+PKkOwLi1bqSRomSu/lqyv2hK
	 XMMaIEtXQkt5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Gary Guo <gary@garyguo.net>,
	Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] rust: irq: declare cfi_encoding for irqreturn
Date: Wed,  4 Nov 2026 17:36:48 -0500
Message-ID: <20261104223318.627233-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110407-hydrated-decipher-a8a9@gregkh>
References: <2026110407-hydrated-decipher-a8a9@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sami Tolvanen <samitolvanen@google.com>

[ Upstream commit 01f3e6b4b1c8c1748e59ba53631ab1f5d9ad0ea4 ]

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
[ sashal: replaced bindgen's custom enum attribute option with sed post-processing to support older bindgen ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 rust/Makefile              |  3 ++-
 rust/bindgen_parameters    |  3 +++
 rust/bindings/lib.rs       |  1 +
 rust/kernel/irq/request.rs | 22 +++++++++++-----------
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index d4618f646b05b..3867ff14fbdec 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -367,7 +367,8 @@ quiet_cmd_bindgen = BINDGEN $@
 $(obj)/bindings/bindings_generated.rs: private bindgen_target_flags = \
     $(shell grep -Ev '^#|^$$' $(src)/bindgen_parameters)
 $(obj)/bindings/bindings_generated.rs: private bindgen_target_extra = ; \
-    sed -Ei 's/pub const RUST_CONST_HELPER_([a-zA-Z0-9_]*)/pub const \1/g' $@
+    sed -Ei 's/pub const RUST_CONST_HELPER_([a-zA-Z0-9_]*)/pub const \1/g' $@; \
+    sed -Ei 's/^pub struct irqreturn\(/#[cfi_encoding="9irqreturn"]\n&/' $@
 $(obj)/bindings/bindings_generated.rs: $(src)/bindings/bindings_helper.h \
     $(src)/bindgen_parameters FORCE
 	$(call if_changed_dep,bindgen)
diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index e13c6f9dd17b2..9e02500dc9792 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -23,6 +23,9 @@
 # warning. We don't need to peek into it anyway.
 --opaque-type spinlock
 
+# enums that appear in indirect function calls should specify a cfi type
+--newtype-enum irqreturn
+
 # `seccomp`'s comment gets understood as a doctest
 --no-doc-comments
 
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index 8305adbdf8cbf..37f584727eba1 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -23,6 +23,7 @@
     unreachable_pub,
     unsafe_op_in_unsafe_fn
 )]
+#![feature(cfi_encoding)]
 
 #[allow(dead_code)]
 #[allow(clippy::as_underscore)]
diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
index 70700f43ddd37..4f2b315856b9b 100644
--- a/rust/kernel/irq/request.rs
+++ b/rust/kernel/irq/request.rs
@@ -20,10 +20,10 @@
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
@@ -275,7 +275,7 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
 unsafe extern "C" fn handle_irq_callback<T: Handler + 'static>(
     _irq: i32,
     ptr: *mut c_void,
-) -> c_uint {
+) -> bindings::irqreturn_t {
     // SAFETY: `ptr` is a pointer to `RegistrationInner` set in `Registration::new`
     let inner = unsafe { &*(ptr as *const RegistrationInner) };
     // SAFETY: `inner.handler` is a pointer to `T` set in `Registration::new`
@@ -284,20 +284,20 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
     // callback is running implies that the device has not yet been unbound.
     let device = unsafe { inner.dev.as_bound() };
 
-    T::handle(handler, device) as c_uint
+    bindings::irqreturn_t(T::handle(handler, device) as c_uint)
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
@@ -501,7 +501,7 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
 unsafe extern "C" fn handle_threaded_irq_callback<T: ThreadedHandler + 'static>(
     _irq: i32,
     ptr: *mut c_void,
-) -> c_uint {
+) -> bindings::irqreturn_t {
     // SAFETY: `ptr` is a pointer to `RegistrationInner` set in `ThreadedRegistration::new`
     let inner = unsafe { &*(ptr as *const RegistrationInner) };
     // SAFETY: `inner.handler` is a pointer to `T` set in `ThreadedRegistration::new`
@@ -510,7 +510,7 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
     // callback is running implies that the device has not yet been unbound.
     let device = unsafe { inner.dev.as_bound() };
 
-    T::handle(handler, device) as c_uint
+    bindings::irqreturn_t(T::handle(handler, device) as c_uint)
 }
 
 /// # Safety
@@ -519,7 +519,7 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
 unsafe extern "C" fn thread_fn_callback<T: ThreadedHandler + 'static>(
     _irq: i32,
     ptr: *mut c_void,
-) -> c_uint {
+) -> bindings::irqreturn_t {
     // SAFETY: `ptr` is a pointer to `RegistrationInner` set in `ThreadedRegistration::new`
     let inner = unsafe { &*(ptr as *const RegistrationInner) };
     // SAFETY: `inner.handler` is a pointer to `T` set in `ThreadedRegistration::new`
@@ -528,5 +528,5 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
     // callback is running implies that the device has not yet been unbound.
     let device = unsafe { inner.dev.as_bound() };
 
-    T::handle_threaded(handler, device) as c_uint
+    bindings::irqreturn_t(T::handle_threaded(handler, device) as c_uint)
 }
-- 
2.53.0

