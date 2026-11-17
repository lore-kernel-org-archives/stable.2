Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794908872;
	b=HZ766RV4j9EcXE/iPYCiEEA0aQqwRgC6Lok5TRwcmUF94xAj5kXn0VvYLozJATwhFJ4j
	 eJQ1bqBJYcZMnxup1azgKJeVvdSAbPZ56POXeqCzlI2KMTzVw+b5y2Tze3PImr/SYopY8
	 9fmrRkMTfSOu4TLlxvh3LZg/eBwql8LjZNJV3hF66ucH7GfMeyG1qZ7mhyMRpLwtqxkfb
	 ygGrRVM1Pngp85Uha+8OUvg26UXMvIpX207VFyy2HmASdbrGSYTrf0joK1gUiXAKHvlBC
	 ERJVhEMDs+H+F5XAwgBI9csyW6dgOtoo7VvWfW+D6YmTvpE3oGKXhKc6Pehl7Ijz2gA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908872;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XNWKjNP0ylTMFqS5R4s7agStVoLlbB3dV3UE5VmDOlE=;
	b=jRSGRk3ZecMi1kRS1AaRYKEE/jaD2kUeEt5o3wPBKPckD6DQ51b8Wgyby4k/rv8+KAAH
	 HeoCQOdCUON8xRsvh10oQmon5cfKWEAMutkjSrhX90sl4tSLDTQuzKKUYxKFxNk4K1EfP
	 LGNg5r/zyuu7TGUMqaUOgKcqTstc9kxQ+ApPBOYWYXuBvEQmgQUResv9SMFpPA0pG6ssR
	 msMjY3gmsI+TTe3E2xcB0WENlDuDXogQEpWGBI1b2ivr4X5IfZrHyx13G4bLOpOCKrV9A
	 G2iW6wTZIc4EuvAZoeGZT67VXHqtZ7BkvUTKq7DkZl54JvCWI01jxCSibiWdQ8ke1Ww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eukyEsXJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F73B606A329;
	Tue, 17 Nov 2026 09:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eukyEsXJ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794908872;
	b=yFwbkhtYib77j6dtQDMc57auIPm3DqvPI66X7wUAvkgStLZ9WwOOGTt/UIULIectPfxo
	 eE0QpJVAJcjGpi4v6y9UsfYI/Ck7DShhyAmRZaMZ/BJ0kMyK5mlq5zpr8A9OAPgm20WO9
	 03vuYbk9Pu+V2zJmg2T/92RJKEfYTXHFdynWx2wX3K7V63adUN5k1SJsCfZeLu/HkS1AT
	 MwVpcLWQSSiv2yaQGojudXNDOn7Q2hxeUUMTpCnxJY0JZP3ISMFu7iTCXNBpcgFdPa/A6
	 Srextx/u6EWlmfzOXhWD3iAMYPPAtwn0UjMfT0dLjFpyatsQURhLLzbg7AIt3bdnlZA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794908872;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XNWKjNP0ylTMFqS5R4s7agStVoLlbB3dV3UE5VmDOlE=;
	b=NjUEWb1SCK0aBtWhsY0SXkhHA3pFmD/lPm/hhrNM/j558/shPSRBkayPzoQyoHdrhW7A
	 US5CYDuK/2CXaG11k0iaBig3/gQgaKbyYSMZFQaBDGqgiVNLbDZlrpwfXy/QEZxcjh+jO
	 AZHRStG+CPpd13FGIl1lmHnb7zNwaHgO/cQQZRF1rMbvR+fSjnQNJqhENiMn4aJXaPenI
	 96i0AxRKRzu5HF2tQM4OYUvfH6eCaghIluS/4RkaDHO6D5VczWB5VNMMN+THRs1Ma82tk
	 2VjI0dwpNIenqVmurnV0dCoI8Nh/J85QG8i4bc+i438VFZWLOsNWVzf4oIWW7gA51xQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9899C1F000C5;
	Tue, 17 Nov 2026 09:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794908872;
	bh=XNWKjNP0ylTMFqS5R4s7agStVoLlbB3dV3UE5VmDOlE=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=eukyEsXJqU0/4gLBim9oDaQp85TGKZh6EXzX3C7aB/u+feriK4bokpaBM42f0DkiS
	 ucKKRLJ1QFNV55A3oehEzqmbX8OamJFtjV/OeW4mkjjSzxDWnkZsR0oMyMBKzVknOK
	 tZnagItasZE7oc4RI/TjYepIpLCpv1KF5wv85Yclf2kcXABgLhzN0JaccdCy2ezCZF
	 uXemzZh/2TlVX8KhfJNTdhnvLR6AZ6930x77qkQppelUhtG2SetmHCCww/tD5ce0qc
	 J+/HCUU4dzj5LkJ50VGnLeWOTTXfBp5kS0OYT3XDwSkQk6mUWidq8YS5BKXG+YTjWi
	 vuEinKoPyqFhA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 132BA4A793;
	Tue, 17 Nov 2026 09:47:51 +0000 (UTC)
From: Peder Bergan via B4 Relay <devnull+peder.bergan.gmail.com@kernel.org>
Date: Tue, 17 Nov 2026 10:47:51 +0100
Subject: [PATCH] rust: str: tie Formatter to its backing buffer
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261117-formatter-lifetime-v1-1-9d7f38686552@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMYi/GoC/yWMQQ6CQBAEv0Lm7CSuGlG/Yjws0CtjZCEzgyEh/
 F3QY3W6aiaDCoxuxUyKj5j0eYWwK6huY36CpVmZDvvDOYRQcuq1i+5QfkuCSwc+XY7XgKaMKTW
 0ioMiyfSL3h9/trF6ofattD2qaOBKY67bbRoHc0XsWEdzzpicluULhAGl9psAAAA=
X-Change-ID: 20261117-formatter-lifetime-48391ed7affd
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Georgios Androutsopoulos <georgeandrout13@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794908870; l=2702;
 i=peder.bergan@gmail.com; s=kernel-contributions;
 h=from:subject:message-id;
 bh=c2EXF63mEwnQnsVVyx1xUR6wHcOb7PHcB7oVHC4kogc=;
 b=cmJf587r8vKEHlsRLXxBys9PRoJzmqc7PY99ABcGPBG30A/U+CR4NFqDkHVTlCpCiZjZyEmEh
 B0zCJRZLbAaAGYDmROGMsitdX3LRLm5XVeeEoCJThHNaAH++9pnec/m
X-Developer-Key: i=peder.bergan@gmail.com; a=ed25519;
 pk=39790pn1YZCulHBoUG1uiQI1Hm01EvhBEa2zVrS/yN0=
X-Endpoint-Received: by B4 Relay for
 peder.bergan@gmail.com/kernel-contributions with auth_id=1395
X-Original-From: Peder Bergan <peder.bergan@gmail.com>
Reply-To: peder.bergan@gmail.com
Content-Transfer-Encoding: 7bit

From: Peder Bergan <peder.bergan@gmail.com>

Formatter::new() returns a Formatter whose lifetime is independent of the
borrow of its backing buffer. Safe code can therefore drop the buffer and
then write through the formatter, causing a use-after-free.

Tie the buffer borrow to the formatter's lifetime so that the borrow
checker rejects such callers and prevents overlapping mutable access.
Add a doctest showing formatting into a borrowed buffer.

Fixes: 87482d6d9104 ("rust: str: allow `str::Formatter` to format into `&mut [u8]`.")
Cc: stable@vger.kernel.org
Reported-by: Georgios Androutsopoulos <georgeandrout13@gmail.com>
Closes: https://github.com/Rust-for-Linux/linux/issues/1261
Signed-off-by: Peder Bergan <peder.bergan@gmail.com>
---
I compiled the in-tree callers with Clippy and ran the string tests and
kernel doctests under x86_64 QEMU. Three borrowing probes compiled before
the fix and failed with the expected borrow-checker errors after it.
Rust documentation and formatting checks passed.

OpenAI Codex assisted with coding and testing.
---
 rust/kernel/str.rs | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 644b4279a..6222faacf 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -645,7 +645,7 @@ impl fmt::Write for RawFormatter {
 /// Fails if callers attempt to write more than will fit in the buffer.
 pub struct Formatter<'a>(RawFormatter, PhantomData<&'a mut ()>);
 
-impl Formatter<'_> {
+impl<'a> Formatter<'a> {
     /// Creates a new instance of [`Formatter`] with the given buffer.
     ///
     /// # Safety
@@ -658,7 +658,23 @@ impl Formatter<'_> {
     }
 
     /// Create a new [`Self`] instance.
-    pub fn new(buffer: &mut [u8]) -> Self {
+    ///
+    /// The formatter exclusively borrows `buffer` for its lifetime.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::fmt::Write as _;
+    /// use kernel::str::Formatter;
+    ///
+    /// let mut buffer = [0; 4];
+    /// let mut formatter = Formatter::new(&mut buffer);
+    /// formatter.write_str("test")?;
+    /// assert_eq!(formatter.bytes_written(), 4);
+    /// assert_eq!(&buffer, b"test");
+    /// # Ok::<(), kernel::error::Error>(())
+    /// ```
+    pub fn new(buffer: &'a mut [u8]) -> Self {
         // SAFETY: `buffer` is valid for writes for the entire length for
         // the lifetime of `Self`.
         unsafe { Formatter::from_buffer(buffer.as_mut_ptr(), buffer.len()) }

---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261117-formatter-lifetime-48391ed7affd

Best regards,
--  
Peder Bergan <peder.bergan@gmail.com>


