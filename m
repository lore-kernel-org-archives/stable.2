Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793947097;
	b=eivGGVucpyoxOU2/CVXW+FI86ccgBu9IYXl+r7YZB5aVafzYuDFAF6QJqsefpmSxdmuL
	 +ySAq/ZAkRjT8an9oki4X8a5Dt3CYoYY8WYSe5w8nq7Gp5ypuvJbWp+oQN1dHclQrYiZr
	 ACwwn9S6Ozz5CLMYXnrz6vaiBKVks1zWzeTo4yRT4+kDz8acG5k/Kw/UEVA7VzuMj/tA9
	 /HZXSFifF2uq4ByaZcAYuXBtoUvqL1A/bYRIwqAU+88dm3mYO+0vNix/tmyoWO9lyGVkz
	 3OtaURRxbORRVjueao8sTr/bm1nRBYBFiOvf02GuGWqTatM5lla7DYEPolRiSw6a6/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793947097;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding;
	bh=auDL6BxnNx+HL2/4x68s/FCfB/+B4c4qzcBd9+5zRJw=;
	b=HyooUFXrAbWqGmDnKOswO3eVRToCLXSwnbs6XzWKMOpB8tQeB/F0rMG23tYL5X/aA2X4
	 6RMlRqSBwnA7WO4mcUaxhtfFJOPEgXDO8/QL5i51PEWK/JuvwBhK86Rf3QENOyE9VpaCS
	 S74luet6ZFAAaPrkv8ldBTaZS3wiCViY4tQlCQ1eyFVZ3zyb1e03swzCpdJhSQZ7J0M4g
	 3MbEyEEQjUdbdwp63qNws+R4AOILdbQa9O2RqHIiXUDWqopNZwoWg55SJu6Q16C96dgy8
	 C1jx6SoEVb5LhW6a/J79PHZ2IWyTAHjMh39debzZWk/EybR6UOcqv9IWjLWPaJS/n5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HhPRY6xq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BA2606A326;
	Fri,  6 Nov 2026 06:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HhPRY6xq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9861F00900;
	Fri,  6 Nov 2026 06:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793947097;
	bh=auDL6BxnNx+HL2/4x68s/FCfB/+B4c4qzcBd9+5zRJw=;
	h=From:To:Cc:Subject:Date;
	b=HhPRY6xqX0Gx4r8lq41eZxeI97FVqOtjHqeA+PGxFZwz3WmHc7IxjYYdAemenXIxy
	 ww6KC+YweQnNskOm6mgOZCH7PKxjLBd4jOgSbuWoqxNopNEbgNqxW3atw2xhnLQegS
	 KTzPgeaMiTROG8HAb9eC//ochB+2fBJlTTvfehpjs5plSTHyGOiieYXfc4XD7j97Gx
	 OUfKsTS1NEtfZAki8whCkEYFkJbXS56HjCjbqdbmR5Qp/OTvYJy9X37kgAGNDed/Vx
	 4P1W25wBkkV9AG3Zdn147nhed2cx6e6xozBAEGUM0i+VQzDMb7cy6T+AiLbjdxFZoJ
	 AbyTfyA+r1X9g==
From: Miguel Ojeda <ojeda@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Burak Emir <burak.emir@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: stable@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	rust-for-linux@vger.kernel.org
Subject: [PATCH 6.18.y] rust: bitmap: fix intra-doc link
Date: Fri,  6 Nov 2026 07:37:45 +0100
Message-ID: <20261106063745.87864-1-ojeda@kernel.org>
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

`BitmapVec::MAX_LEN` does not exist in 6.18.y, so `rustdoc` warns:

    warning: unresolved link to `BitmapVec::MAX_LEN`
      --> rust/kernel/bitmap.rs:24:25
       |
    24 | /// This also matches [`BitmapVec::MAX_LEN`].
       |                         ^^^^^^^^^^^^^^^^^^ the struct `BitmapVec` has no field or associated item named `MAX_LEN`
       |
       = note: `#[warn(rustdoc::broken_intra_doc_links)]` on by default

Thus link to `BitmapVec::new()` instead.

Fixes: 37f45fe068e0 ("rust: bitmap: restrict bitmap length to at most i32::MAX")
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
Another option (cleaner but a bigger change) is to cherry-pick:

  f5535d78e126 ("rust: bitmap: add MAX_LEN and MAX_INLINE_LEN constants")

 rust/kernel/bitmap.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
index c2634561b023..badc3eb5282b 100644
--- a/rust/kernel/bitmap.rs
+++ b/rust/kernel/bitmap.rs
@@ -21,7 +21,7 @@
 /// Must reference a `[c_ulong]` long enough to fit `data.len()` bits.
 /// Must not be longer than [`i32::MAX`] bits, so offsets and lengths used with
 /// [`Bitmap`] functions fit in the `int` and `unsigned int` arguments of the C bitmap API.
-/// This also matches [`BitmapVec::MAX_LEN`].
+/// This also matches the maximum length accepted by [`BitmapVec::new`].
 #[cfg_attr(CONFIG_64BIT, repr(align(8)))]
 #[cfg_attr(not(CONFIG_64BIT), repr(align(4)))]
 pub struct Bitmap {

base-commit: a7c80de5ffd00886e3e6b7469611536b0d481cda
--
2.56.0
