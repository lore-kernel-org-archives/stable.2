Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC5F3F54A4;
	Tue,  9 Jun 2026 10:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001757; cv=none; b=cgl0jO+HvVY2hIckztKo72tvn63cvJ+NHwWOO+HEn39DoOHtM/oGjnIu5FKKn2UndOCbGO8FH+FZIvqSPWRkBY51mTu/Enl9CWqaYYpiL+DU+/ljBBcAJdyvUbq1K4295j14mlvFTzB7dOxE8xoeMVi6+K+X/HaM718vBMjT8As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001757; c=relaxed/simple;
	bh=kTDhbLDnjr4n7YizAm9OLbphNTTK2CbzoXpYN1VxQFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HT6E173QKtf6a9O25kgTUKFUXGoOQV3B9JB/6xCIotew2Rxj7fQgjRp0z1Vh0t+7P3ytlc9zjwdOFdEq6HJRPA8ti5kmbQeNgoGVxx/R2RCj6qgIhHkjX7Wu0R/FlcMW3/aUEIKWYbXS18DsUFpwZP+TypvIICsrTLYvPe0mbFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAmz3fke; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAmz3fke"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746991F00898;
	Tue,  9 Jun 2026 10:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781001756;
	bh=qmg4OCQWFBMM4w1cYceQT/MrFsVG1HKgnt4N1AL3iYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eAmz3fke0Be3r9CAvsgO2SJ+OrCw9BxtmWMB5bucwy9issSd0Xfpb4FnL7ZttzSuY
	 kjOJlHzZcP4BZQzBVQJh1buOAD0EYOf9zwX2MyyZlDc3Bfb5aZweE1S3olI/CZv5ht
	 5uGX7QP1JoyeREItoUGRuYlLeecj9k+IRQ8t6ICWddt/qrFXoC5uqlemBZekqcCckw
	 h80tPqNpu80xSYP8hpS3t3TtkCNmsEgZeVoJhi+osLelyqClaVyFPZyX07fC2kEfkW
	 27hjhnga1TYnN8LGY8fQIsYQm6N9RFb7McbQ52wVNAyt1BejU7+dV85JNv2CvEwFON
	 X7t+p0+ly24xg==
From: Miguel Ojeda <ojeda@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] rust: str: clean unused import for Rust >= 1.98
Date: Tue,  9 Jun 2026 12:41:52 +0200
Message-ID: <20260609104152.261145-2-ojeda@kernel.org>
In-Reply-To: <20260609104152.261145-1-ojeda@kernel.org>
References: <20260609104152.261145-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting with Rust 1.98.0 (expected 2026-08-20), the compiler has changed
how the resolution algorithm works [1][2] in upstream commit c4d84db5f184
("Resolver: Batched import resolution."), and it now spots:

    error: unused import: `flags::*`
     --> rust/kernel/str.rs:7:9
      |
    7 |         flags::*,
      |         ^^^^^^^^
      |
      = note: `-D unused-imports` implied by `-D warnings`
      = help: to override `-D warnings` add `#[allow(unused_imports)]`

It happens to not be needed because the `prelude::*` already provides
the flags.

Thus clean it up.

Cc: stable@vger.kernel.org # Needed in 6.18.y and later (prelude added to `str`).
Link: https://github.com/rust-lang/rust/pull/145108 [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/str.rs | 1 -
 1 file changed, 1 deletion(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 4eae05e4baf9..b3caa9a1c898 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -4,7 +4,6 @@
 
 use crate::{
     alloc::{
-        flags::*,
         AllocError,
         KVec, //
     },
-- 
2.54.0

