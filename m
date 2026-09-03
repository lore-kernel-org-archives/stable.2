Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926F04A5EAA
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439435; cv=none; b=BX5kOzUuNbQAufH85YcLw/B3N95N0kPqFIsF36cvcK4wo9VUpIAS4AaPJkf104ry2qpFiv/ThDsCFdQiRAs0AVFfVRdU5xt8KpU3Bp9uraHCTOi2yVZ9w3BjGFGId25HBidIpZ9fINlksCa0/dUllbbqaRji/RfjFRXb49A6pOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439435; c=relaxed/simple;
	bh=+qvEi8u0HGfYG1ro9sN67nupIzmXCB2hRfGWW7QmDOg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hFnYa7sTYfpDcOQRXLhLiCi1sEmBfVgvsr6oIJro2BjhxVwAUmJQsn651gxIOS3AfyaVibwK86SgVbUfbzlaN4XcPddw5AB0fvvGxWT8djoNxTIO4mUSGZpQIdw7x8Psal8mD4pGI6iGw6WHiqkoTzQuyLzzOAjTqMbCbwPED/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tL1yfZQ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tL1yfZQ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A4A1F000E9;
	Thu,  3 Sep 2026 12:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439434;
	bh=02GjXr4H/VpnggSjms2lT8FsCABctWx5kCl27qT8zyM=;
	h=Subject:To:Cc:From:Date;
	b=tL1yfZQ5hrceI8Ssux4eAXHfZjtyvqOowscLzn8yWrEl5w1Oasc9s6n0hqty4cuPi
	 kSmRx+3PmlOMwUf25+D1fgPysU4+ZuelZK+5hhjiGujt2vlUEOyVxPGnypbjak3lnt
	 QW8j0Q41e5+jnJbFwxzijhg+qep0MFfRTDZRjhXk=
Subject: FAILED: patch "[PATCH] rust: bug: prevent dead_code warning from warn_on!'s flags" failed to apply to 6.18-stable tree
To: fujita.tomonori@gmail.com,ojeda@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 12:42:47 +0200
Message-ID: <2026090347-reformat-saddled-eea6@gregkh>
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
git cherry-pick -x e66cfc29e0d06fec34c06bb40d4d281f595677b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090347-reformat-saddled-eea6@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e66cfc29e0d06fec34c06bb40d4d281f595677b1 Mon Sep 17 00:00:00 2001
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
Date: Sat, 1 Aug 2026 11:48:41 +0900
Subject: [PATCH] rust: bug: prevent dead_code warning from warn_on!'s flags
 constant

Fix the following dead_code warning on some configurations in an
atomic development branch:

warning: constant `WARN_ON_FLAGS` is never used
   --> linux/rust/kernel/bug.rs:126:19
    |
126 |               const WARN_ON_FLAGS: u32 = $crate::bug::bugflag_taint($crate::bindings::TAINT_WARN);
    |                     ^^^^^^^^^^^^^
    |
   ::: linux/rust/kernel/sync/srcu.rs:106:12
    |
106 |           if crate::warn_on!(
    |  ____________-
107 | |             // SAFETY: By the type invariants, `self` contains a valid and pinned `struct srcu_struct`
108 | |             // and `srcu_readers_active()` only checks the active reader count.
109 | |             unsafe { bindings::srcu_readers_active(ptr) }
110 | |         ) {
    | |_________- in this macro invocation
    |
    = note: `#[warn(dead_code)]` (part of `#[warn(unused)]`) on by default
    = note: this warning originates in the macro `crate::warn_on` (in Nightly builds, run with -Z macro-backtrace for more info)

The warn_on! macro always defines a WARN_ON_FLAGS constant and hands it
to warn_flags!. On configurations where warn_flags! does not reference
its flags argument (the LOONGARCH/ARM variant, which only calls
WARN_ON(), and the !CONFIG_BUG no-op variant), the constant is left
unused and triggers a dead_code warning.

warn_flags! is the macro that accepts (and here discards) the flags
argument, so make it responsible for the argument it drops.

Also rename `_COND_STR` to `COND_STR` and consume `$file` for consistency.

Fixes: dff64b072708 ("rust: Add warn_on macro")
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260801024841.786664-1-tomo@flapping.org
[ Added newlines. - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
index ed943960f851..a09e6c9b314e 100644
--- a/rust/kernel/bug.rs
+++ b/rust/kernel/bug.rs
@@ -53,6 +53,10 @@ macro_rules! warn_flags {
     ($file:expr, $flags:expr) => {
         const FLAGS: u32 = $crate::bindings::BUGFLAG_WARNING | $flags;
 
+        if false {
+            _ = $file;
+        }
+
         // SAFETY:
         // - `flags` and `size` are all compile-time constants, preventing
         // any invalid memory access.
@@ -76,6 +80,10 @@ macro_rules! warn_flags {
 #[cfg(all(CONFIG_BUG, CONFIG_UML))]
 macro_rules! warn_flags {
     ($file:expr, $flags:expr) => {
+        if false {
+            _ = $file;
+        }
+
         // SAFETY: It is always safe to call `warn_slowpath_fmt()`
         // with a valid null-terminated string.
         unsafe {
@@ -94,6 +102,11 @@ macro_rules! warn_flags {
 #[cfg(all(CONFIG_BUG, any(CONFIG_LOONGARCH, CONFIG_ARM)))]
 macro_rules! warn_flags {
     ($file:expr, $flags:expr) => {
+        if false {
+            _ = $file;
+            _ = $flags;
+        }
+
         // SAFETY: It is always safe to call `WARN_ON()`.
         unsafe { $crate::bindings::WARN_ON(true) }
     };
@@ -103,7 +116,12 @@ macro_rules! warn_flags {
 #[doc(hidden)]
 #[cfg(not(CONFIG_BUG))]
 macro_rules! warn_flags {
-    ($file:expr, $flags:expr) => {};
+    ($file:expr, $flags:expr) => {
+        if false {
+            _ = $file;
+            _ = $flags;
+        }
+    };
 }
 
 #[doc(hidden)]
@@ -118,14 +136,14 @@ macro_rules! warn_on {
         let cond = $cond;
 
         #[cfg(CONFIG_DEBUG_BUGVERBOSE_DETAILED)]
-        const _COND_STR: &str = concat!("[", stringify!($cond), "] ", file!());
+        const COND_STR: &str = concat!("[", stringify!($cond), "] ", file!());
         #[cfg(not(CONFIG_DEBUG_BUGVERBOSE_DETAILED))]
-        const _COND_STR: &str = file!();
+        const COND_STR: &str = file!();
 
         if cond {
             const WARN_ON_FLAGS: u32 = $crate::bug::bugflag_taint($crate::bindings::TAINT_WARN);
 
-            $crate::warn_flags!(_COND_STR, WARN_ON_FLAGS);
+            $crate::warn_flags!(COND_STR, WARN_ON_FLAGS);
         }
         cond
     }};

