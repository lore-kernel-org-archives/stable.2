Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823481;
	b=U/8OslGqt5Spl6K51m0ibRPPu+c/UYLuvlT0rdwfV1Gp5vGQnmIXyXGfIFkWOZQgzfed
	 48kiHtNgx5345xt+LebRtcqeycnXgcgAhiLdfcf8d7ayjBKopjXLwiGph+Pl0mOyrC+K0
	 dFiw1wCgHGanR1EYjNqn+Q0SKCPp54uZGXpvxlfal03fhC7x5GqqIYfu2KmXu5dDuGVFz
	 f/mec8N6ARkaekxbfa5Z8FNabmlMqbWBVNFutyNH6LG6ljRrgqe8mHFug9EPmhybYCATV
	 y6DkaHf1L+0drYsefEGzk6XEWh6JqWJvWyeMHbX48swP0a6VH8Zm0AOVO0McZgubXnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823481;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=izetZ7FXETA3hMto9JIcPYbq7w2tZYgethiOLfUWsAo=;
	b=Zp1GyLk1OBBNQHhUgEFZFqYiurw3mILmff4Mj26S/mpNptHVCTOHvWs3OYjx25RspSGP
	 wqOevyQ4TJc7DjS0bYq9XD4QZ44suWXHIT2wn7E9D/OVlPdVhID+yHoxY7tJqRyc7uZMC
	 UgBmkb9ICvQ1Lccit5QxMg8NjGnGmt+BuKuiovY5sd/BCZYBWdFoM2tCYsSYTuwb34ow6
	 b0EejKXS3o+VH21mnCc9IZyB9yqRG40SyYdB6us915P0QPYRTXdxPEy8m+o0OS5Ih6sVi
	 4WDzRJGXDLJH9tAJyfXerDGsb0x6Lv+9yAo1dK5lxEdTvP/1wO94UAScfH6CyQ7u8FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=corw5kGw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24DB606D810
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 20:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=corw5kGw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55621F000C1;
	Wed,  4 Nov 2026 20:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793823480;
	bh=izetZ7FXETA3hMto9JIcPYbq7w2tZYgethiOLfUWsAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=corw5kGwgJQYErHb9sNb5FrTEWUeslQQSAiy0hpbCn1dH7pmy8OoJnTnkOZGyW+0/
	 uhacioW+AwJ2wD+5VFP4UvR3EJdyr8OrcCpjDkOfjE0G0WfzrrYeSlFGLf3OrLSHXd
	 yc6jr4g9b1e6oKmSaLRDWqggVmtlWs7U45++ImMB83ho0AbCa9p57z4GlgJLjshHyL
	 YS1CiHi9PHgQOh6SDLwOZN3VY/fhFV3FZJV6txyGeZ631rOrq7JUWpecF+u52ZVMXM
	 7sNHMP5HvtrmYFSuw45I9gXAWwiC7q1Jdww9qtYxydQBtRrAsw+/xw9CnIwpMX0+/y
	 usTBYh3nBDvMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Gary Guo <gary@garyguo.net>,
	Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] rust: irq: declare cfi_encoding for irqreturn
Date: Wed,  4 Nov 2026 15:17:58 -0500
Message-ID: <20261104201749.480655-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110407-tubeless-endorse-45e8@gregkh>
References: <2026110407-tubeless-endorse-45e8@gregkh>
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
[ sashal: Adjusted insertion context to preserve existing fwctl_rpc_scope CFI declarations. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 rust/bindgen_parameters    |  2 ++
 rust/kernel/irq/request.rs | 28 +++++++++++++++++-----------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index 39aae62dca669..cbc0a302647e5 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -29,6 +29,8 @@
 # enums that appear in indirect function calls should specify a cfi type
 --newtype-enum fwctl_rpc_scope
 --with-attribute-custom-enum=fwctl_rpc_scope='#[cfi_encoding="15fwctl_rpc_scope"]'
+--newtype-enum irqreturn
+--with-attribute-custom-enum=irqreturn='#[cfi_encoding="9irqreturn"]'
 --newtype-enum lru_status
 --with-attribute-custom-enum=lru_status='#[cfi_encoding="10lru_status"]'
 
diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
index c1c6525a676a7..1afa9fcaad1f6 100644
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
-- 
2.53.0

