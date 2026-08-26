Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D38C448B8A;
	Wed, 26 Aug 2026 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756215; cv=none; b=aFYlQD7BQN7iwMJza93oMEvqIUjgnomemGJQqIxeysrYB6Gz9M/uqv2DkvJgB3SviTqKH6na8f4yuy/z1BSmvcgpe/FCZIBCPHUrWBH1gNj/MGYhDzPzflVleFnJFeqRpWeN7A6obB6PJFLI/+6be9WW5Oi0PKw0rl11e694ZwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756215; c=relaxed/simple;
	bh=MT26pk9Zk0/h5vg6FjDJ4/fHEItjljvrNP9VqUDN6IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XxfbCJPgQXc8ggf7S8/yh0QAvCVSXfxIkEFgOU4smSW06dyfyOoSHTYjH2W6u6/MYlMaxo1vX8v2ZYxc8HNZwvj9dIOFVqg4WIttSWUrjjQ3LwxHLl1VZVvvCDoTkFMyo90/ManwKrowFsgYsP+jmS0/NOZA0YjagEAHOO/WliE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjykGl2d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjykGl2d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0851F000E9;
	Wed, 26 Aug 2026 14:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787756214;
	bh=Lqj3WyT4uUSyg5vPTud/NlBT/9oGUsXf3w6yMFvssHk=;
	h=From:To:Cc:Subject:Date;
	b=AjykGl2d0NtadVh1HDftsuRFQVDNwr7fprTrNgVyOS38MibtI+mqw9ib00+W2F1qc
	 b6mxzPeBVB4DGNlNu7Q4Wigqad605YQNYt1jJHrtz3XbVRZQ5XjYxGKr7GknQzwOGz
	 +gKGJrJjb3pdqRtJOx7M0WJUoaobJoj293QNGl6oUjLWMpoIrIX1WmGBuBPrMoNydC
	 T/3PfEq4gNfFLUU/4NUFKOgLuUN8aBNk1SWjm2RK4JkvhYsrSRxKobEQ6nRJ7fdkJ3
	 Q+qsM4CLu83UdxBORErr3Pyk+G62haCIxFIXvDE+EEvrE6gPsJQXP8P7H6msJJc6Oe
	 6S3GR5crvE3jw==
From: Miguel Ojeda <ojeda@kernel.org>
To: Jocelyn Falempe <jfalempe@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	Boqun Feng <boqun@kernel.org>,
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
	stable@vger.kernel.org
Subject: [PATCH] drm/panic: clean new `clippy::needless_range_loop` lint for Rust 1.100.0
Date: Wed, 26 Aug 2026 16:56:42 +0200
Message-ID: <20260826145642.43807-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting with Rust 1.100.0 (expected 2026-11-12), Clippy warns:

    warning: the loop variable `i` is only used to index `self.decimals`
       --> drivers/gpu/drm/drm_panic_qr.rs:410:18
        |
    410 |         for i in 0..len {
        |                  ^^^^^^
        |
    note: for this index operation
       --> drivers/gpu/drm/drm_panic_qr.rs:411:13
        |
    411 |             self.decimals[i] = (chunk % 10) as u8;
        |             ^^^^^^^^^^^^^^^^
        = help: for further information visit https://rust-lang.github.io/rust-clippy/main/index.html#needless_range_loop
        = note: `-W clippy::needless-range-loop` implied by `-W clippy::all`
        = help: to override `-W clippy::all` add `#[allow(clippy::needless_range_loop)]`
    help: consider using an iterator
        |
    410 -         for i in 0..len {
    410 +         for <item> in self.decimals.iter_mut().take(len) {
        |

The lint did not trigger here before because it could not handle arrays
behind a field access such as `self.decimals` -- Clippy was improved to
catch those cases [1][2].

Thus clean the warning by iterating over a slice rather than using
`take()` so that an out-of-range `len` still triggers the same bounds
check as the indexed loop.

Cc: stable@vger.kernel.org # Needed in 6.18.y and later.
Link: https://github.com/rust-lang/rust-clippy/issues/16631 [1]
Link: https://github.com/rust-lang/rust-clippy/pull/16634 [2]
Assisted-by: LLM
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
One may want to keep the loop in a shape similar to e.g. the one above,
though.

 drivers/gpu/drm/drm_panic_qr.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
index ac27e86c601c..4d7eb75a3afc 100644
--- a/drivers/gpu/drm/drm_panic_qr.rs
+++ b/drivers/gpu/drm/drm_panic_qr.rs
@@ -407,8 +407,8 @@ fn push(&mut self, data: u64, len: usize) {
         for i in (0..self.len).rev() {
             self.decimals[i + len] = self.decimals[i];
         }
-        for i in 0..len {
-            self.decimals[i] = (chunk % 10) as u8;
+        for decimal in &mut self.decimals[..len] {
+            *decimal = (chunk % 10) as u8;
             chunk = div10(chunk);
         }
         self.len += len;

base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
--
2.55.0
