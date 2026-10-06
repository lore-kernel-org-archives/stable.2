Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDF24A4984
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 18:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791311960; cv=none; b=MkIw7GB6fffUR0qW6qyQ8QvHJJzLgVmsE9BdX6YppjyInxcJRoTrWlLpCSqw7idNg7nH3qBNlBrOVO7G3hiZPVqWM0t1HEFR/Dpuk834WhmXIctDjVEGL4K5InXlkfDiXjUUq5PmOnssXYj21yaT2leeXaf7YJxOP4Txk7sbfLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791311960; c=relaxed/simple;
	bh=K/j+bsonhNbTR5DrbOfhjLBpWLgePPTcrQwEmKtP0kA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VBWQBY+w+Ptp5rJ5Ps7fz07T92ch50dNt7XyYcGz8Jv2srzIxSBvuLfDFKKn6LhUkuC/CjpJ6VzZPJ/fBynVBKz5lc36c/NC4+6VUeiq3732viEMKU61UrlIEXZt5+1GeLlIykWgEYtV0jCjDQpZuNYLUbElqqSIwJreklWlcso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I/htNYOu; arc=none smtp.client-ip=74.125.82.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I/htNYOu"
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1384427c3efso4644434c88.0
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 11:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791311957; x=1791916757; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eT3Gs/ct1o9Y5IkFW19eA0/7ZUOALFp5CHXC49qt6gs=;
        b=I/htNYOu1fXLWYAB7EHCcQGvXuj4d9HpohC1xFipbOTJD3GxaI9+/NR7n3WOFB6W6F
         nZp0ofwtscEhoftDzRNuJRZEJjG1U4FdrPS7prEnanWM/niuVO8X4Bg9FvXMgwjhwKEL
         cD8R+7Gk0twQxefsGqqVU7i7FrTtCOxUFpa9ZogxNMqYYvPW7vVr5oqZ9ZMFGWgzpaC5
         ostruIsvTL9wZjCc2QCTwLEdjW2Ql9axJZ9XSwAwpWEi3U/UzCsAIkP99xk0aMGYrZR8
         cebO9Gc0pemrg1OZ5rf/4XOJJFA5zL9bbd+7vrPQeYE+nIWS/BhLE16Qj5aB2BCxmW/B
         3Bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791311957; x=1791916757;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eT3Gs/ct1o9Y5IkFW19eA0/7ZUOALFp5CHXC49qt6gs=;
        b=bGflbC4+99SqxAg1uh4vpzlvMANPztGH3tFOcVG0kjti2BVYoieY5dn1RjPhcazFhG
         w5WHE81emga/PUKF0Sn/T/uQCRgp8Y+EtqBwqNlKUd0laSI+KQrHU4+QZyVY0e4/bYMz
         Bmakc07BG2iUE9XdW83+UL3Tam39LgZqyCPmArzY2Lf3ItMDZf6DI1P08l2+4ukxqk9U
         Fp9VSaWBEcAk2IndxRaZRNcV1nK8K/Xnj21TQW4FerZZEFiDeX4egsgjlSqyeJSE1leP
         L+XO97t2wqRGDI2qaqUU58vpnpeI0oo9i/5xVX3DOHOnEYviqeqbfJp7hY5zwTg7LOMr
         4Ylg==
X-Forwarded-Encrypted: i=1; AKwUvBwIZgvEVryWYjHVGaw0U3BcNDCY1sjTVxRPQzV86NyKltLxaCyFAsVFk0OL097aw2OAz7qAPT8=@vger.kernel.org
X-Gm-Message-State: AFuF++lGhwwcTjVwC8dkFkGYaEyQrqZwMjDViRjahlsLXlQYk8Zslx2V
	BMpn2C75qxfO6ddobfKKvaYIH7E1tgvQyMT1ACoFvsK8pzbjSnWGBDK08rcUYTmETu5yTMmHz6f
	onzH4KBGvHpUv4Q==
X-Received: from dly13-n1.prod.google.com ([2002:a05:701b:204d:10b0:15d:9efd:93a5])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:230e:b0:159:76b0:a9e3 with SMTP id a92af1059eb24-15ec01d3454mr2774882c88.6.1791311956910;
 Tue, 06 Oct 2026 11:39:16 -0700 (PDT)
Date: Tue,  6 Oct 2026 18:38:23 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261006183857.396710-1-cmllamas@google.com>
Subject: [PATCH] rust: fmt: drop the "0x" prefix from {:p} to match %p
From: Carlos Llamas <cmllamas@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, "=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>, Ke Sun <sunke@kylinos.cn>, 
	Carlos Llamas <cmllamas@google.com>, Dirk Behme <dirk.behme@de.bosch.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, "open list:RUST" <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Commit 643a7c306b8c ("rust: fmt: route {:p} through HashedPtr to prevent
address leaks") made {:p} go through the kernel's %p so that pointers
are hashed by default. However, it formats them with %#0*p, where the
'#' flag prepends a '0x' prefix that the plain %p does not produce in C.
Thus the same pointer is printed differently from C and from Rust:

    C     %p      00000000e8efa736
    Rust  {:p}  0x00000000e8efa736

The prefix is a leftover from 'core::fmt::Pointer', which always adds
one. However, doing so deviates from the %p format documented in
Documentation/core-api/printk-formats.rst and makes it harder to
correlate the same pointer across C and Rust messages.

Format the pointer with '%0*p' instead and adjust the default field
width accordingly, so that {:p} produces exactly the same output as
plain %p which is zero-padded to the width of a pointer and without any
prefix, both for hashed pointers and for real addresses under
'no_hash_pointers'. Update the KUnit test expectations to match.

Note this patch focuses only on fixing the '{:p}' prefix to match %p.
The '#' flag remains ignored as before, so the '{:#p}' equivalent to
%#p should be sent as a follow up patch.

Fixes: 643a7c306b8c ("rust: fmt: route {:p} through HashedPtr to prevent address leaks")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 rust/kernel/fmt.rs | 48 ++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/rust/kernel/fmt.rs b/rust/kernel/fmt.rs
index 29582b053ab1..b35858a28d38 100644
--- a/rust/kernel/fmt.rs
+++ b/rust/kernel/fmt.rs
@@ -64,6 +64,9 @@ pub trait Pointer {
 /// By default, `%p` prints a hashed representation of the pointer address to prevent kernel address
 /// leaks. When the `no_hash_pointers` kernel command-line parameter is enabled, the real address is
 /// printed instead (for debugging purposes).
+///
+/// The output matches that of `%p` in C: zero-padded to the width of a pointer and, unlike
+/// [`core::fmt::Pointer`], without a `0x` prefix.
 pub struct HashedPtr<T: ?Sized>(pub *const T);
 
 impl<T: ?Sized> Pointer for HashedPtr<T> {
@@ -72,33 +75,32 @@ fn fmt(&self, f: &mut Formatter<'_>) -> Result {
 
         let mut buf = [0u8; 32];
 
-        // Use `%#0*p` for the `0x` prefix and zero-padding; `+2` compensates for
-        // the prefix counting toward the field width.
-        let default_width = (2 * size_of::<usize>() + 2) as c_int;
+        // Like `%p`, zero-pad to the width of a pointer and do not add a `0x` prefix.
+        let default_width = (2 * size_of::<usize>()) as c_int;
         let width = match (f.sign_aware_zero_pad(), f.width()) {
             (true, Some(w)) if w > 0 => w.min(buf.len() - 1) as c_int,
             _ => default_width,
         };
 
         // SAFETY: `buf` is a valid, writable 32-byte buffer, sufficient for
-        // all architectures (max 19 bytes for 64-bit under the default width).
+        // all architectures (max 17 bytes for 64-bit under the default width).
         // The format string is null-terminated; `width` (c_int) and pointer
         // match the `%*` and `%p` specifiers.
         let len = unsafe {
             crate::bindings::scnprintf(
                 buf.as_mut_ptr().cast(),
                 buf.len(),
-                c"%#0*p".as_char_ptr(),
+                c"%0*p".as_char_ptr(),
                 width,
                 self.0.cast::<c_void>(),
             )
         };
 
-        // SAFETY: `%#0*p` produces only ASCII, which is valid UTF-8.
+        // SAFETY: `%0*p` produces only ASCII, which is valid UTF-8.
         let s = unsafe { core::str::from_utf8_unchecked(&buf[..len as usize]) };
 
         if f.sign_aware_zero_pad() {
-            // `scnprintf` already applied the width and zero-padding via `%#0*p`.
+            // `scnprintf` already applied the width and zero-padding via `%0*p`.
             f.write_str(s)
         } else {
             f.pad(s)
@@ -224,26 +226,26 @@ mod tests {
     mod expected {
         pub(super) const PTR_VALUE: usize = 0xffffffffdeadbeef;
         pub(super) const PTR_VAL_NO_CRNG: &str = "(____ptrval____)";
-        pub(super) const HASHED_PREFIX: &str = "0x00000000";
-        pub(super) const RAW_POINTER: &str = "0xffffffffdeadbeef";
-        pub(super) const PADDED_RIGHT: &str = "      0xffffffffdeadbeef";
-        pub(super) const ZERO_PADDED: &str = "0x000000ffffffffdeadbeef";
-        pub(super) const HASHED_PADDED_RIGHT_PREFIX: &str = "      ";
-        pub(super) const HASHED_ZERO_PADDED_PREFIX: &str = "0x00000000000000";
-        pub(super) const CLAMPED: &str = "0x0000000000000ffffffffdeadbeef";
+        pub(super) const HASHED_PREFIX: &str = "00000000";
+        pub(super) const RAW_POINTER: &str = "ffffffffdeadbeef";
+        pub(super) const PADDED_RIGHT: &str = "        ffffffffdeadbeef";
+        pub(super) const ZERO_PADDED: &str = "00000000ffffffffdeadbeef";
+        pub(super) const HASHED_PADDED_RIGHT_PREFIX: &str = "        ";
+        pub(super) const HASHED_ZERO_PADDED_PREFIX: &str = "0000000000000000";
+        pub(super) const CLAMPED: &str = "000000000000000ffffffffdeadbeef";
     }
 
     #[cfg(not(CONFIG_64BIT))]
     mod expected {
         pub(super) const PTR_VALUE: usize = 0xdeadbeef;
         pub(super) const PTR_VAL_NO_CRNG: &str = "(ptrval)";
-        pub(super) const HASHED_PREFIX: &str = "0x";
-        pub(super) const RAW_POINTER: &str = "0xdeadbeef";
-        pub(super) const PADDED_RIGHT: &str = "              0xdeadbeef";
-        pub(super) const ZERO_PADDED: &str = "0x00000000000000deadbeef";
-        pub(super) const HASHED_PADDED_RIGHT_PREFIX: &str = "              ";
-        pub(super) const HASHED_ZERO_PADDED_PREFIX: &str = "0x00000000000000";
-        pub(super) const CLAMPED: &str = "0x0000000000000000000000deadbeef";
+        pub(super) const HASHED_PREFIX: &str = "";
+        pub(super) const RAW_POINTER: &str = "deadbeef";
+        pub(super) const PADDED_RIGHT: &str = "                deadbeef";
+        pub(super) const ZERO_PADDED: &str = "0000000000000000deadbeef";
+        pub(super) const HASHED_PADDED_RIGHT_PREFIX: &str = "                ";
+        pub(super) const HASHED_ZERO_PADDED_PREFIX: &str = "0000000000000000";
+        pub(super) const CLAMPED: &str = "00000000000000000000000deadbeef";
     }
 
     #[test]
@@ -289,8 +291,8 @@ fn test_ptr_formatting() -> core::result::Result<(), crate::error::Error> {
 
             let cstr = CString::try_from_fmt(fmt!("{:0100p}", ptr))?;
             let output = cstr.to_str()?;
-            assert!(output.starts_with("0x"));
-            assert!(!output[2..].chars().all(|c| c == '0'));
+            assert_eq!(output.len(), expected::CLAMPED.len());
+            assert!(!output.chars().all(|c| c == '0'));
         }
 
         Ok(())
-- 
2.56.0.385.gd3acb90ef8-goog

