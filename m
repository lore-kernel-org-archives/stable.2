Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793950548;
	b=ehM52qLz0mDzr7kQskiPqmxexJK1r/Ya5FcUEGibBFFhjzxkS0Hqo9Bqez1siVsi8/YY
	 vG4CAkMB7NUJ81rJ7bu8OuU1AemaBUiJdd+leMfK9NV5Nklzc5OZ3705O+rnExQXpa9Lz
	 X5Voc1YPWfY7aI9IIW1qp+LwskUZMNbYgxwZfdVUTbsBdC/cE7PMVhZbHQxcjQM9rJVMs
	 gNQyQcaPtxv94XpoPxwT61nRBZ4OaJjUBdmU75cxmGcKjLdy2hFEha0sFF3Ay1fn9UMZn
	 SY3W21Tp5m1kDQxaKyEj/XIYzGOJaXB8ei71bgj1XVtur2VKtGVOxE+8GJJgD2hnnTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793950548;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MwIUYX0k8rEAZxdqhAsDcO5HsvtOgZ0kwqnsN/Pl5Mw=;
	b=JzePXqFYReAnQCg8WJOLu4CX7NpQC8PVG/u3zh7oqWnq6DQcJyNyT/EK8aPBvaf7rl6C
	 NjbDnFSae9ta6gqngZ6S6HK9iRYqx51m9O1WQhpuo0PjTbAtGQT4OcaCpz/hp0r0pN/Gs
	 +nQR/poEkClYl0EzhhovpLYSr3hzVLnO3i1H//pORBxGGp3FGZOKJyRUHxgm2CyWNVFFC
	 MxKTkbtpteU7739hbtLaO/Z629wyH8lWpwDIiKM/2Ou2GPBTNlxt0tLJ/8nKgz/y6bGAI
	 P3hwxMfWSImu0wEfUiku/E3b8aixuhE2WVyWC5xtnG2pqYDv4Z+rfY7RZHDDgU1Pnpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XWHSMAdW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F769606A330;
	Fri,  6 Nov 2026 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XWHSMAdW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B451F008A7;
	Fri,  6 Nov 2026 07:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793950547;
	bh=MwIUYX0k8rEAZxdqhAsDcO5HsvtOgZ0kwqnsN/Pl5Mw=;
	h=From:To:Cc:Subject:Date;
	b=XWHSMAdWhlYSMiz6440r7X6KQhAqOYhbkE9rMTi6NSmL/VyzHxBr/xln0pZSOrbyM
	 +q/W+CDMgxYFCYEWoT9GyulplpaYkwakZIhEeNvrPq01PQGTw+z4/j+Gqg9SOphoVq
	 TN1vcMRD9NX5ccGCCEDWGz5brGsD8pND82Y5yZNcH7qVTfo3F75q1FaB5W+CZrZpO+
	 AifBq88uRF6mf0wY6yqe/BNNTUGqCAbs5dBanA33j1lMtDNDOcdIMBhnBxLyYkqPxo
	 Jwa0FGyOLt3EYCv9WxFddIry6NXTi4WI8tR/BBe+/9Efxl9U6N4GUSy1yIQtZyy43e
	 DM77PGWo7WAlQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: Rong Xu <xur@google.com>,
	Han Shen <shenhan@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: linux-kbuild@vger.kernel.org,
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
	rust-for-linux@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] kbuild: rust: support stabilized flag `-Cprofile-sample-use` for Rust >= 1.100
Date: Fri,  6 Nov 2026 08:35:28 +0100
Message-ID: <20261106073528.93371-1-ojeda@kernel.org>
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

Starting with Rust 1.100.0 (expected 2026-11-12), the
`-Zprofile-sample-use` flag has been stabilized as
`-Cprofile-sample-use` and the former is not available anymore [1].

Without this change, when building with `CLANG_AUTOFDO_PROFILE` set, one
gets in the latest betas and nightlies:

    error: unknown unstable option: `profile-sample-use`

Thus pass the right name.

Cc: stable@vger.kernel.org # Needed in 7.3.y.
Link: https://github.com/rust-lang/rust/pull/155942 [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
I can take it via `rust-fixes` to get it in for the release, but please
let me know if you prefer to do something else. Thanks!

 scripts/Makefile.autofdo | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.autofdo b/scripts/Makefile.autofdo
index 57a3aba6ffc2..32c18df237f1 100644
--- a/scripts/Makefile.autofdo
+++ b/scripts/Makefile.autofdo
@@ -13,7 +13,7 @@ endif
 ifdef CLANG_AUTOFDO_PROFILE
   CFLAGS_AUTOFDO_CLANG += -fprofile-sample-use=$(CLANG_AUTOFDO_PROFILE) -ffunction-sections
   CFLAGS_AUTOFDO_CLANG += -fsplit-machine-functions
-  RUSTFLAGS_AUTOFDO_CLANG += -Zprofile-sample-use=$(CLANG_AUTOFDO_PROFILE) -Zfunction-sections=y
+  RUSTFLAGS_AUTOFDO_CLANG += $(if $(call rustc-min-version,110000),-Cprofile-sample-use,-Zprofile-sample-use)=$(CLANG_AUTOFDO_PROFILE) -Zfunction-sections=y
   RUSTFLAGS_AUTOFDO_CLANG += -Cllvm-args=-split-machine-functions
 endif


base-commit: 57d916a3eb765ee0577d269bb2ac1bdf3a7a7f40
--
2.56.0
