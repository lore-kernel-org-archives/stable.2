Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEF948CD40
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331582; cv=none; b=AESm8W37d7HdZrvoM4ANYPPwynrxPGhY+97+1uIYvlhbwB7vRYo6N/dojwQHKIdocabObTOjRtaiydNHZgARbcDMg5aF1Fas7e28Kdps8xmbWDFkEkCH3DnQRuCHr+1lqsBTQXFbdXS06ez5embKyfB3pkL5DqZBwhnZXqg4jPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331582; c=relaxed/simple;
	bh=PDjImYdhFWIzhBC1lN65KLuLWF4EEYVontxv987nXAc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bGsscBht7zZ8BxF4mnZYYSOdGyDQOrHVnbpBE01dPrb28mHbmuhde2aIXERLQJAg+zm8v8MkwnaPOx/Mnl++uBWUrtnp0WQSrCCD7bBbUiDey1Q0b3aj2Mlkfyckq3+x0tlAYHDXnYUgP/8qErftt7aB03y1nOm9j8+qtXnW/68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JwybEQvH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JwybEQvH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4601F000E9;
	Wed, 29 Jul 2026 13:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785331581;
	bh=anh8xH3df0+DLZcy4qfp/xv+SIPvPnluSwiegm7kFLU=;
	h=Subject:To:Cc:From:Date;
	b=JwybEQvHh1m1d+Jp/wCSR1iKl+UHiix+dCho8oGsjEy4YlW2zh9cZ12f5ofIqGRKH
	 KPlz3pXqBREpRajfP4guRobh74DXRNUfUgGDfwrH4dUKCUdHfWH5mnC+kUXBPqaQ/N
	 ax2Q6o5woZbLO/Cgi+iWEwtYV0+Qr0I9rvy9AQsU=
Subject: FAILED: patch "[PATCH] rust: device: avoid trailing ; in printing macros" failed to apply to 6.18-stable tree
To: aliceryhl@google.com,dakr@kernel.org,gary@garyguo.net,ojeda@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:26:07 +0200
Message-ID: <2026072907-spearhead-karma-9b2b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x a19bda861b3a79e25417462539df8b0d77c6b322
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072907-spearhead-karma-9b2b@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a19bda861b3a79e25417462539df8b0d77c6b322 Mon Sep 17 00:00:00 2001
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 16 Jul 2026 10:22:43 +0000
Subject: [PATCH] rust: device: avoid trailing ; in printing macros

These macros are used like expressions, so they should not emit a
semicolon. This is being turned into a hard error in a future release of
Rust.

    error: trailing semicolon in macro used in expression position
      --> drivers/gpu/nova-core/firmware/fsp.rs:79:34
       |
    79 |                 .inspect_err(|_| dev_err!(dev, "FMC firmware missing '{}' section\n", name))
       |                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
       |
       = warning: this was previously accepted by the compiler but is being phased out; it will become a hard error in a future release!
       = note: for more information, see issue #79813 <https://github.com/rust-lang/rust/issues/79813>
       = note: this error originates in the macro `dev_err` (in Nightly builds, run with -Z macro-backtrace for more info)

[ I was doubly surprised since upstream made it a deny-by-default lint
  a year ago for Rust 1.91.0, and yet we didn't see it; plus I hadn't
  seen this in my CI even yesterday.

  It turns out this just landed into today's nightly (nightly-2026-07-16,
  using upstream commit d0babd8b6):

    Link: https://github.com/rust-lang/rust/pull/159222

  which says:

    "The `semicolon_in_expressions_from_macros` lint previously
     suppressed warnings about non-local macros. This masks
     a lint that will subsequently become a hard error."

  So that explains it. And this is the PR that will make it a hard error
  at some point in the future:

    Link: https://github.com/rust-lang/rust/pull/159218

  Thus starting with Rust 1.99.0 (expected 2026-10-01), we will be
  seeing the deny-by-default lint above, so clean it up already.

    - Miguel ]

Cc: stable@vger.kernel.org # Needed in 6.18.y and later.
Link: https://github.com/rust-lang/rust/issues/79813
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Link: https://github.com/rust-lang/rust/pull/159218
Link: https://github.com/rust-lang/rust/pull/159222
Link: https://patch.msgid.link/20260716-device-trail-semicolon-v1-1-f48e9dcfae15@google.com
[ Fixed typo. ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 645afc49a27d..1a38b3bbdfb7 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -708,9 +708,7 @@ macro_rules! impl_device_context_into_aref {
 #[macro_export]
 macro_rules! dev_printk {
     ($method:ident, $dev:expr, $($f:tt)*) => {
-        {
-            $crate::device::Device::$method($dev.as_ref(), $crate::prelude::fmt!($($f)*))
-        }
+        $crate::device::Device::$method($dev.as_ref(), $crate::prelude::fmt!($($f)*))
     }
 }
 
@@ -737,7 +735,7 @@ macro_rules! dev_printk {
 /// ```
 #[macro_export]
 macro_rules! dev_emerg {
-    ($($f:tt)*) => { $crate::dev_printk!(pr_emerg, $($f)*); }
+    ($($f:tt)*) => { $crate::dev_printk!(pr_emerg, $($f)*) }
 }
 
 /// Prints an alert-level message (level 1) prefixed with device information.
@@ -763,7 +761,7 @@ macro_rules! dev_emerg {
 /// ```
 #[macro_export]
 macro_rules! dev_alert {
-    ($($f:tt)*) => { $crate::dev_printk!(pr_alert, $($f)*); }
+    ($($f:tt)*) => { $crate::dev_printk!(pr_alert, $($f)*) }
 }
 
 /// Prints a critical-level message (level 2) prefixed with device information.
@@ -789,7 +787,7 @@ macro_rules! dev_alert {
 /// ```
 #[macro_export]
 macro_rules! dev_crit {
-    ($($f:tt)*) => { $crate::dev_printk!(pr_crit, $($f)*); }
+    ($($f:tt)*) => { $crate::dev_printk!(pr_crit, $($f)*) }
 }
 
 /// Prints an error-level message (level 3) prefixed with device information.
@@ -815,7 +813,7 @@ macro_rules! dev_crit {
 /// ```
 #[macro_export]
 macro_rules! dev_err {
-    ($($f:tt)*) => { $crate::dev_printk!(pr_err, $($f)*); }
+    ($($f:tt)*) => { $crate::dev_printk!(pr_err, $($f)*) }
 }
 
 /// Prints a warning-level message (level 4) prefixed with device information.
@@ -841,7 +839,7 @@ macro_rules! dev_err {
 /// ```
 #[macro_export]
 macro_rules! dev_warn {
-    ($($f:tt)*) => { $crate::dev_printk!(pr_warn, $($f)*); }
+    ($($f:tt)*) => { $crate::dev_printk!(pr_warn, $($f)*) }
 }
 
 /// Prints a notice-level message (level 5) prefixed with device information.
@@ -867,7 +865,7 @@ macro_rules! dev_warn {
 /// ```
 #[macro_export]
 macro_rules! dev_notice {
-    ($($f:tt)*) => { $crate::dev_printk!(pr_notice, $($f)*); }
+    ($($f:tt)*) => { $crate::dev_printk!(pr_notice, $($f)*) }
 }
 
 /// Prints an info-level message (level 6) prefixed with device information.
@@ -893,7 +891,7 @@ macro_rules! dev_notice {
 /// ```
 #[macro_export]
 macro_rules! dev_info {
-    ($($f:tt)*) => { $crate::dev_printk!(pr_info, $($f)*); }
+    ($($f:tt)*) => { $crate::dev_printk!(pr_info, $($f)*) }
 }
 
 /// Prints a debug-level message (level 7) prefixed with device information.
@@ -919,5 +917,5 @@ macro_rules! dev_info {
 /// ```
 #[macro_export]
 macro_rules! dev_dbg {
-    ($($f:tt)*) => { $crate::dev_printk!(pr_dbg, $($f)*); }
+    ($($f:tt)*) => { $crate::dev_printk!(pr_dbg, $($f)*) }
 }

