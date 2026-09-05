Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075DF175A8D;
	Sat,  5 Sep 2026 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788621421; cv=none; b=W21lliiB8FVsgf9MX25TnzZaYPw4DI6qHzOlqo1oBaIlC5Y4rQlf2/DQqUXtyxdsV94VtFJioMBg4+l687G1mLRPPZBoeUDCSL389qL08Fvtfkav8E/+RJGxmwYNXhSxB1K8ICMJXpkfF93RD5GQShX9iNkEuE6nTdd5te8U4h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788621421; c=relaxed/simple;
	bh=u3iwFNsqk/crBLizFOYRplgcb1MkG14juv5gy4R5ppE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TXdlEopK8goNE2L3bwhqCfOW/iWxrpplHvADySTu0EM2Z7GziV390FmS8/s3uFuOa9lQOT1SqBBYWbBRLFjabblvH9AP8ACj0XQKFojeAEy+6DhwKTBypvW9ZDB9E8Vzif9hBIyRtapzehlEE1UnXxtJ5i4H9KfgRCF7RA+V0Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swVC4682; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swVC4682"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C5AFC2BCB3;
	Sat,  5 Sep 2026 15:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788621420;
	bh=u3iwFNsqk/crBLizFOYRplgcb1MkG14juv5gy4R5ppE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=swVC4682H4hyEjnG36DzgOpGXyQ9kO73SBKg+eFJe4VYAax75qUEDszIXAouFlsw7
	 X97+lR3aSDlL5rWORwoLO0Uf90htRsyKHAsq/BiRdcEC9ge2wXv4SnAz+WPBll9wuW
	 TZB8xxZSP6/XBFkovbrxOQa5qqrFbWKWsA7dnUOom67+USEZCla3AdPbz2RM1ZG6kz
	 gJqQPmjhPvdWzAKXEJyX2ueBpd+0zNHyD44NQjKMopSfFfC3XpT3rAnX70agqLFVJF
	 c90Ngbt7dAlyXhR24+lENyDyRubVyiEMuutwSALziiVLenj+p8gLoCs9bHc+4/CEQh
	 SIArGVDswjBcw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58066C624D6;
	Sat,  5 Sep 2026 15:17:00 +0000 (UTC)
From: Younes Akhouayri via B4 Relay <devnull+git.younes.io@kernel.org>
Date: Sat, 05 Sep 2026 17:16:51 +0200
Subject: [PATCH v2] rust: num: seal Integer
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-feature-rust-num-seal-integer-v2-1-f1311ffbe6e7@younes.io>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOQQ6CMBBFr2K6dpQWbMSV9zAuCgwwRlsz0xIN4
 e4CxrXLN/nz8kYlyISiTptRMQ4kFPwMZrtRde98h0DNzMpkxmZllkOLLiZG4CQRfHqAoLsD+Yg
 dMrjCWNO0hSlrq2bHk7Gl1+q/XL8sqbphHRfpsqicIFTsfN0vp8DUkd+v9u/nvOlJYuD3Gjnox
 fXrOfzpGTRoOOZZabU+uMYW53dIHmVHQV2nafoAdb6TGQABAAA=
X-Change-ID: 20260903-feature-rust-num-seal-integer-a4262df429c6
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
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Younes Akhouayri <git@younes.io>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788621419; l=2338;
 i=git@younes.io; s=20260712; h=from:subject:message-id;
 bh=w3evkKPlORxFzdaoWSJdzBunzT4aj8vrZEoXJAMB0Fc=;
 b=Py2LLT2lfR1UqvYYX8yRzX2xAx+lxeA/scMrtSFI4ym+IvF9pY69MJD8KP347wRkoRscpNhR8
 cz6ZcRsmr/tCHr7nHOrs/fa9lC0Rdw0OF27lEo9+fItKTPCgp00kgYG
X-Developer-Key: i=git@younes.io; a=ed25519;
 pk=1DRfzPrQ04RQHHgGK28t+vjIAPv5oISPiAdLMU6J5dE=
X-Endpoint-Received: by B4 Relay for git@younes.io/20260712 with
 auth_id=866
X-Original-From: Younes Akhouayri <git@younes.io>
Reply-To: git@younes.io

From: Younes Akhouayri <git@younes.io>

Bounded relies on Integer implementations to describe primitive integer
semantics correctly. In particular, it uses Integer::BITS and Signedness
to justify unchecked operations.

Integer is currently safe and externally implementable, so an
implementation can violate those assumptions and make safe Bounded
operations reach undefined behavior.

For example, an Integer implementation for a u8 wrapper can report
BITS = 16. Safe code can then cast a Bounded<u16, 9> containing 256
to that wrapper. Its TryFrom<u16> implementation returns Err, and
Bounded::cast() calls unwrap_unchecked() on it, causing undefined
behavior.

Seal Integer so only the primitive implementations provided by the
kernel crate can satisfy it.

Fixes: 01e345e82ec3 ("rust: num: add Bounded integer wrapping type")
Reported-by: Miguel Ojeda <ojeda@kernel.org>
Closes: https://lore.kernel.org/rust-for-linux/CANiq72mOfR33s4y+Ueivd5NrC5yre+Pcp57ZOBz0msw9A4AP1Q@mail.gmail.com/
Cc: stable@vger.kernel.org
Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Younes Akhouayri <git@younes.io>
---
Changes in v2:
- Explain how an incorrect Integer implementation can cause undefined behavior.
- Add the missing Reported-by trailer.
- Link to v1: https://patch.msgid.link/20260905-feature-rust-num-seal-integer-v1-1-83096115ad64@younes.io
---
 rust/kernel/num.rs | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
index dbe848e30efe..de589792a77a 100644
--- a/rust/kernel/num.rs
+++ b/rust/kernel/num.rs
@@ -15,9 +15,14 @@ pub enum Unsigned {}
 /// Designates signed primitive types.
 pub enum Signed {}
 
+mod private {
+    pub trait Sealed {}
+}
+
 /// Describes core properties of integer types.
 pub trait Integer:
-    Sized
+    private::Sealed
+    + Sized
     + Copy
     + Clone
     + PartialEq
@@ -56,6 +61,8 @@ pub trait Integer:
 macro_rules! impl_integer {
     ($($type:ty: $signedness:ty), *) => {
         $(
+        impl private::Sealed for $type {}
+
         impl Integer for $type {
             type Signedness = $signedness;
 

---
base-commit: e510334fbaeaa016ac76d80b4c5f47611c5f7860
change-id: 20260903-feature-rust-num-seal-integer-a4262df429c6

Best regards,
--  
Younes Akhouayri <git@younes.io>


