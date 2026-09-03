Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8014BCAD0
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447665; cv=none; b=dkfmgpR9zsMNjCX5nAYLQoeu+eS62bh5RL9TryjhAoTFR5xKLwhALKzZdthfClFjbX4u8dzMWR1r1aSYIWrBY+3SpP7ohmsE2rSASXIu3xbDnYTtHl+AwxB9jB1Q3cXHehHqoSK09T3qw1OaRoismsxJbRsKUQzeuuQlyhnaPBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447665; c=relaxed/simple;
	bh=lZXY2GQgDn161XSwICjc4Qyhz2JyLS2LPpnS42o6TaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFi8tgjEPQu0659q1T1/vV8Joalu06YYvWBAxebkW1Pp0kei36b2+PIW46bTvEJjwC21jeVsavNt7hByTpnPKXD2NoNmqzhsMdpA7p3Iaegi0JlzQxm4C29J8mzFDrMkurx26CKxuuJ6QZM8PEfPaI0w7A9JUxo68yeNoyDEibI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GF+K6+ss; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GF+K6+ss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8BC1F00A3A;
	Thu,  3 Sep 2026 15:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788447664;
	bh=6WdM+FX9JRyeZeTWnI3CxOASBNZSxJO/iOIEi4Udix0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GF+K6+ss3oLtOE4nJqFQY6Bz3rWlG8rB82dWrJ/yXK9ybFWhpeMeh9LEcqSrx1gEF
	 cOJ4fvT/RJZTE6vsdydTXbfop1kb/ow3hEVTyBBruP6YlTfW3mDfXt46H8bAn+vfBH
	 mvcO4atX2lYvwtlHDg2zKJ7RTGaebf93g6qljWLIAt0dM/+tPX8sf5S6yRCdB+QYsI
	 wbAGDKelKlOzoiUKJpyccIy3hGbeSG+lf/Dx0JLcmIMg4OZwHPiSDnUpQOWDLmfPGd
	 qrbLKbB9RWNtd+6geUNhdbjzokfecCITaXeGIpebbE0lNlqP8nkleLyIuM061hUwqA
	 issL37fr0QWYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] rust: bug: prevent dead_code warning from warn_on!'s flags constant
Date: Thu,  3 Sep 2026 11:01:02 -0400
Message-ID: <20260903150102.856955-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090347-reformat-saddled-eea6@gregkh>
References: <2026090347-reformat-saddled-eea6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: FUJITA Tomonori <fujita.tomonori@gmail.com>

[ Upstream commit e66cfc29e0d06fec34c06bb40d4d281f595677b1 ]

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
[ adapted unreachable flag consumption to the older one-argument warn_flags! interface. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 rust/kernel/bug.rs | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
index 36aef43e5ebec..9de7e96eb6791 100644
--- a/rust/kernel/bug.rs
+++ b/rust/kernel/bug.rs
@@ -94,6 +94,10 @@ macro_rules! warn_flags {
 #[cfg(all(CONFIG_BUG, any(CONFIG_LOONGARCH, CONFIG_ARM)))]
 macro_rules! warn_flags {
     ($flags:expr) => {
+        if false {
+            _ = $flags;
+        }
+
         // SAFETY: It is always safe to call `WARN_ON()`.
         unsafe { $crate::bindings::WARN_ON(true) }
     };
@@ -103,7 +107,11 @@ macro_rules! warn_flags {
 #[doc(hidden)]
 #[cfg(not(CONFIG_BUG))]
 macro_rules! warn_flags {
-    ($flags:expr) => {};
+    ($flags:expr) => {
+        if false {
+            _ = $flags;
+        }
+    };
 }
 
 #[doc(hidden)]
-- 
2.53.0

