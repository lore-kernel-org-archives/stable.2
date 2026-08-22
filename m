Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A2E3932FC;
	Sat, 22 Aug 2026 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787388302; cv=none; b=oKI9RNuDWmJoZoE0rV9vG9kaeKRzq3UC41XNQkTsQdRmbKU5JnpRkmcI4xfFRxwXSrXXVbJAwI1LNehLmIyyUh//wnt3Ugb89qkRddpEl3drzJD1n8gRF5IUA4ulJVnPDOauRwzxvKtz9gADtO6qwFCvuEYZ4I2rFDGl05bYcUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787388302; c=relaxed/simple;
	bh=S8kVlWKPgITuTrHMuHgp1CJyp2XZIpgjnPgN20FRxNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gi/hJzwybFDcvQaSGoQuDPYcmYKvrwyT19p3cUY4tbu0D58/NoYTdexGzRRmMyRDAdpDiw29/RkH+MAzOrYrecNwJH8/4lK2wQ0fxdZ1+u1EoDvxcIKkGConQv2ZMMdSCLYknv0Eb+u+7wYTpF/Zqv6bB4TW1IrnTiu6mFZ1U60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3x7TeKh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3x7TeKh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3585AC2BCB8;
	Sat, 22 Aug 2026 08:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787388301;
	bh=S8kVlWKPgITuTrHMuHgp1CJyp2XZIpgjnPgN20FRxNg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Z3x7TeKhWhHXS+Em8a/TWslB+f+7GpGFOmbo9CNU6aH08aip+FcSSeOeUUZoRrsip
	 cACkMYD6sani7XjGnSEzYIEH4PpsTJPWsKiC+9PZp+FAUkaNk0UMh4UOvTo9UHEpVv
	 8I41DpYFQM0xfNgpv4iJMKlHBF51XxjHESFCSxGXl+0fyxyfN7LTE8Sbt4kp0O7g9c
	 mjr5Ysi6gk9pp3L3x34ImFYD0Ag8IWqX2Pb7UGyeJsZutEDqVvyeEyZfDnFqlYw6kZ
	 dcqDY4tKC36+5YFQl/z/+bKmlhuE5f7obbhDMn+ofG41VW0AeUh+IaRnyJmgPSiTrd
	 612/DGFurMtYA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072C1C5B572;
	Sat, 22 Aug 2026 08:45:01 +0000 (UTC)
From: Younes Akhouayri via B4 Relay <devnull+git.younes.io@kernel.org>
Date: Sat, 22 Aug 2026 10:44:47 +0200
Subject: [PATCH v4] rust: num: restrict bool conversion to unsigned Bounded
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260822-fix-rust-bounded-from-bool-submit-v4-1-aa780bfe7f30@younes.io>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XOTW7DIBAF4KtErEsLQxKTrnKPqAt+hniqBirAV
 qLIdy+4m6o7Lx96fPOerGAmLOx992QZZyqUYgv7lx1zo4lX5ORbZiDgKLQ88EB3nqdSuU1T9Oh
 5yOnWQvriZbI3qlyZoNXR6zBIzZrznbF9Wm9cPn5za36iqx3uDWsKcptNdGN/SpmuFN/WKxHvt
 VdGKjXlx7pzlp3aMmmWXHKtAWCwYS+sOT9aFcsrJdYnzbBZhCYaow7WggPw8r+oNouqicE7A0o
 IrU7DX3FZlh8ttU81qwEAAA==
X-Change-ID: 20260815-fix-rust-bounded-from-bool-submit-3af836d8f718
To: Alexandre Courbot <acourbot@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, stable@vger.kernel.org, 
 Younes Akhouayri <git@younes.io>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787388300; l=5566;
 i=git@younes.io; s=20260712; h=from:subject:message-id;
 bh=uVHW1vRI40wncU+HxWBGCohHG+09Mqux9cJ0Hc6a/WI=;
 b=IPbUgMeiLVJyxLAr06nVZQ5UqIc20DQ5JzKifJlZWm6zjy3cPAbkufN/xxQyyDUDpV6yfsmYI
 iM1xmrxdwGzBqKVReaowq+ZdA1kdUROa6cOBgNoHMlFY8iPoVUZOxw8
X-Developer-Key: i=git@younes.io; a=ed25519;
 pk=1DRfzPrQ04RQHHgGK28t+vjIAPv5oISPiAdLMU6J5dE=
X-Endpoint-Received: by B4 Relay for git@younes.io/20260712 with
 auth_id=866
X-Original-From: Younes Akhouayri <git@younes.io>
Reply-To: git@younes.io

From: Younes Akhouayri <git@younes.io>

From<bool> turns true into 1. A signed Bounded with N = 1 can hold
only -1 and 0. The current implementation can therefore create a value
that breaks Bounded's invariant. Deref relies on that invariant and
calls unreachable_unchecked() when it is broken, so safe Rust can reach
undefined behavior.

The other primitive conversions require the source and destination to
have the same signedness. Treat bool as an unsigned one-bit value and
allow conversions between bool and Bounded only when the backing integer
type is unsigned.

Fixes: 01e345e82ec3 ("rust: num: add Bounded integer wrapping type")
Closes: https://lore.kernel.org/rust-for-linux/OzuVxu0--J-9@younes.io/
Cc: stable@vger.kernel.org
Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Younes Akhouayri <git@younes.io>
---
Only allow conversions between bool and unsigned Bounded types.
---
Changes in v4:
- Restrict Bounded-to-bool conversion and into_bool() to unsigned types.
- Link to v3: https://patch.msgid.link/20260815-fix-rust-bounded-from-bool-submit-v3-1-fdca23008397@younes.io

Changes in v3:
- Restrict From<bool> to unsigned Bounded types, matching the other
  primitive conversions.
- Remove the BoolFits helper and signed-width list.
- Link to v2: https://lore.kernel.org/rust-for-linux/20260815-fix-rust-bounded-from-bool-submit-v2-1-aa35bb2c22d1@younes.io/

Changes in v2:
- Use vertical formatting for the nested `num` import.
- Link to v1: https://lore.kernel.org/rust-for-linux/20260815-fix-rust-bounded-from-bool-submit-v1-1-882227bf40ba@younes.io/

To: Alexandre Courbot <acourbot@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>
To: Boqun Feng <boqun@kernel.org>
To: Gary Guo <gary@garyguo.net>
To: Björn Roy Baron <bjorn3_gh@protonmail.com>
To: Benno Lossin <lossin@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
To: Trevor Gross <tmgross@umich.edu>
To: Danilo Krummrich <dakr@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
To: Tamir Duberstein <tamird@kernel.org>
To: Onur Özkan <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 rust/kernel/num/bounded.rs | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/num/bounded.rs b/rust/kernel/num/bounded.rs
index d192610a687d..2a2b0a4bca5e 100644
--- a/rust/kernel/num/bounded.rs
+++ b/rust/kernel/num/bounded.rs
@@ -13,7 +13,10 @@
 };
 
 use kernel::{
-    num::Integer,
+    num::{
+        Integer,
+        Unsigned, //
+    },
     prelude::*, //
 };
 
@@ -174,13 +177,16 @@ fn fits_within<T: Integer>(value: T, num_bits: u32) -> bool {
 /// // `u8` (regardless of the passed value).
 /// // let _ = Bounded::<u32, 6>::from(10u8);
 ///
-/// // Booleans can be converted into single-bit `Bounded`s.
+/// // Booleans can be converted into unsigned `Bounded`s.
 ///
 /// let v = Bounded::<u64, 1>::from(false);
 /// assert_eq!(v.get(), 0);
 ///
 /// let v = Bounded::<u64, 1>::from(true);
 /// assert_eq!(v.get(), 1);
+///
+/// // This does not build because `i8` is signed.
+/// // let _ = Bounded::<i8, 2>::from(true);
 /// ```
 ///
 /// Infallible conversions from a [`Bounded`] to a primitive integer are also supported, and
@@ -203,12 +209,16 @@ fn fits_within<T: Integer>(value: T, num_bits: u32) -> bool {
 /// let _v = Bounded::<u32, 10>::new::<10>();
 /// // assert_eq!(u8::from(_v), 10);
 ///
-/// // Single-bit `Bounded`s can be converted into a boolean.
+/// // Unsigned single-bit `Bounded`s can be converted into a boolean.
 /// let v = Bounded::<u8, 1>::new::<1>();
 /// assert_eq!(bool::from(v), true);
 ///
 /// let v = Bounded::<u8, 1>::new::<0>();
 /// assert_eq!(bool::from(v), false);
+///
+/// // This does not build because `i8` is signed.
+/// // let v = Bounded::<i8, 1>::new::<-1>();
+/// // let _ = bool::from(v);
 /// ```
 ///
 /// Fallible conversions from any primitive integer to any [`Bounded`] are also supported using the
@@ -1109,31 +1119,33 @@ fn from(value: Bounded<T, N>) -> $type {
     i8 i16 i32 i64 isize
 );
 
-// Single-bit `Bounded`s can be converted from/to a boolean.
+// Unsigned single-bit `Bounded`s can be converted to a boolean.
 
 impl<T> From<Bounded<T, 1>> for bool
 where
-    T: Integer + Zeroable,
+    T: Integer<Signedness = Unsigned> + Zeroable,
 {
     fn from(value: Bounded<T, 1>) -> Self {
         value.get() != Zeroable::zeroed()
     }
 }
 
+// Booleans can be converted to unsigned `Bounded`s.
+
 impl<T, const N: u32> From<bool> for Bounded<T, N>
 where
-    T: Integer + From<bool>,
+    T: Integer<Signedness = Unsigned> + From<bool>,
 {
     fn from(value: bool) -> Self {
-        // SAFETY: A boolean can be represented using a single bit, and thus fits within any
-        // integer type for any `N` > 0.
+        // SAFETY: A boolean is represented by `0` or `1`, so it fits within any valid unsigned
+        // `Bounded` width.
         unsafe { Self::__new(T::from(value)) }
     }
 }
 
 impl<T> Bounded<T, 1>
 where
-    T: Integer + Zeroable,
+    T: Integer<Signedness = Unsigned> + Zeroable,
 {
     /// Converts this [`Bounded`] into a [`bool`].
     ///

---
base-commit: 47f27155f17498fccb1f222f79089642337498a9
change-id: 20260815-fix-rust-bounded-from-bool-submit-3af836d8f718

Best regards,
--  
Younes Akhouayri <git@younes.io>


