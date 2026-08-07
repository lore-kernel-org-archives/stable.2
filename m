Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038DF38552C;
	Fri,  7 Aug 2026 22:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140882; cv=none; b=jZ6gUDcRLvv1zc0ty4B7RUq2TIO3jiAkO2IMS1wTp+irBWJR4HD/bHTG3HDY1cayocflBpUjPMJLzeG5ivdJTBCYQdY7qmJafSiOdRxHZJiKRQTJu6Z8e8FcgVmI+qnWuzOg9FpmoPS9R1eVRt1bIOoWBSG2Ge2dL76vuGclgwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140882; c=relaxed/simple;
	bh=1ZzlIvNpc8okggRlMNuOSYeEQuksrWKHdkMicIsD3Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sCUbmsoMQkvZIsSqM8jFrrrXazhhw9KXD/hVK2cE/aWKrx57pq9Wyh7PGhGK0PRIF2sdSqYtA5KseGTQwkAa8MYYf1fj0pO6y25UPcKb4bu+ooq0akcJbIhtSUXfD86DrIJAvCU57PrVPpegeBA9PUlSTdW0ieL4YQpr9cZ990c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9HEd20v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9HEd20v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193981F000E9;
	Fri,  7 Aug 2026 22:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786140880;
	bh=fTBBp/gNut3PNIaiIMKAtMdux5qfIbqgE4sHisRqcBA=;
	h=From:To:Cc:Subject:Date;
	b=Q9HEd20vmC6B7tE6GWWGc/regbVKdRgKtew6QPAE46eqklmJhR8R4TorjdsI/LiDR
	 0e9cldaGfdL/2laVsmkEoD55us3nn2mhX2H4Ef09Xk+CYH0cwX7F48rO3PyiFNCRg4
	 uEgmBMbFdgGYS2VaZP22ZSg6yXArJIBjUHoEMZvdO6ZcemWzbcXi0+iw2YP3MTSpWv
	 QyFic0TGkC6AsPpkKscfhcpg1550TvAV9NqvU85VaNhK0QkneIDpeKmfP7+/cdyPmw
	 h1qxrYCTgVLM+Wm/zJAvnNqf0kSzFoApUIL/wjmoXiuH6LC60XDxg8mx4fMBld5IsT
	 RYlqDJfJFmRxA==
From: Miguel Ojeda <ojeda@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Linus Walleij <linusw@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	rust-for-linux@vger.kernel.org,
	Drew Fustini <fustini@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers),
	soc@lists.linux.dev,
	WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH] rust: bug: fix `dead_code` warning in `warn_on!`
Date: Sat,  8 Aug 2026 00:14:29 +0200
Message-ID: <20260807221429.155946-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On arm and loongarch64, or under `CONFIG_BUG=n`, the upcoming SRCU
abstractions from commit

  59cf3a5bda61 ("rust: sync: add SRCU abstraction")

use `warn_on!`, which in turn warns:

    error: constant `WARN_ON_FLAGS` is never used
       --> rust/kernel/bug.rs:126:19
        |
    126 |               const WARN_ON_FLAGS: u32 = $crate::bug::bugflag_taint($crate::bindings::TAINT_WARN);
        |                     ^^^^^^^^^^^^^
        |
       ::: rust/kernel/sync/srcu.rs:106:12
        |
    106 |           if crate::warn_on!(
        |  ____________-
    107 | |             // SAFETY: By the type invariants, `self` contains a valid and pinned `struct srcu_struct`
    108 | |             // and `srcu_readers_active()` only checks the active reader count.
    109 | |             unsafe { bindings::srcu_readers_active(ptr) }
    110 | |         ) {
        | |_________- in this macro invocation
        |
        = note: `-D dead-code` implied by `-D warnings`
        = help: to override `-D warnings` add `#[allow(dead_code)]`
        = note: this error originates in the macro `crate::warn_on` (in Nightly builds, run with -Z macro-backtrace for more info)

The reason is that `warn_flags!` discards both arguments in those cases,
and so the `const` becomes unused. And since it is a macro, it went
unnoticed so far.

Thus fix it by simplifying by removing the `const`.

Cc: stable@vger.kernel.org
Fixes: dff64b072708 ("rust: Add warn_on macro")
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
Either this or adding an underscore.

 rust/kernel/bug.rs | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
index ed943960f851..874adb93cdfe 100644
--- a/rust/kernel/bug.rs
+++ b/rust/kernel/bug.rs
@@ -123,9 +123,10 @@ macro_rules! warn_on {
         const _COND_STR: &str = file!();

         if cond {
-            const WARN_ON_FLAGS: u32 = $crate::bug::bugflag_taint($crate::bindings::TAINT_WARN);
-
-            $crate::warn_flags!(_COND_STR, WARN_ON_FLAGS);
+            $crate::warn_flags!(
+                _COND_STR,
+                $crate::bug::bugflag_taint($crate::bindings::TAINT_WARN)
+            );
         }
         cond
     }};

base-commit: dc01dfb37b34beeefcfe1c3055364d41a4070c7e
--
2.55.0
