Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7E54B3C95;
	Sun, 18 Oct 2026 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792329210; cv=none; b=B6y+RgZKvroR907GZB3cAfLuvml6stV535zNJenVidFdAmHhrHN8ogiD8hoDy43j8z0TeLkoW9CN0B4EyMjbg/9B2fuGJ6FVgCFuF8eDXfagN4yZk23hchG24v/74zNygumbq66awpWRsDgp+YNvCaVhBVT/4cXZkLgd9wPxniY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792329210; c=relaxed/simple;
	bh=9Tpq5TAFLAEmQSRF24x+jhpkhD3YosbnsEZV2t3jkAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CpzM7JOFVxNJiXQ2WXRKtRH/2Jb7W6JRRcl5tJYm3bIlcSh5q87QM2DFf0DNTLBO/MOMt5Pv0EGWVbOez3sTqTawzr16UKy5ikUz9ILIJIKE5/fTN2Qrynr7hquRTnUCOOnrmqgcAGeWCkRNLGifD0zZfGzs81nRu5tL7h/Tk10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/xOm2Io; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/xOm2Io"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2304F1F000C5;
	Sun, 18 Oct 2026 13:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792329209;
	bh=oiDbfPztW1L60tzOfWiWrGsBJO5bB81MR1GtkTKplZw=;
	h=From:To:Cc:Subject:Date;
	b=U/xOm2Ioztv6t3pzbQRSUJF4J9ITKuwJG9m5TmrX/4vWMz7yEq52qFsOsgLw9LLU6
	 SW68ASDXRHgGfp/WxDYN0yc3XtO7eoEb+3e2S7EQgB3e/vCtFkQBB4ob34/6/8u8Nr
	 fNSpT3kYVR6Ns2UYMh86KpXPkyeBbKZVHRELeMhPBtYIrknuINJ0TEYqIFmkFH5GrV
	 cTntuYJG2awxwLkGWmHovCPc4uOJoydNt4OBRONEnoTk9R9eWaJ0ruwA44Y6VKvo99
	 GskfYSTIM2vFj89G3MsqKDLRiqYPfGxB8/XuiGx2kRss6wJ65OZc65Ir+YmYoNXpMJ
	 DORYYNPJ2YTBw==
From: Miguel Ojeda <ojeda@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>
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
	stable@vger.kernel.org
Subject: [PATCH] objtool/rust: add one more `noreturn` Rust function for Rust 1.101.0
Date: Sun, 18 Oct 2026 15:13:13 +0200
Message-ID: <20261018131313.59391-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting with Rust 1.101.0 (expected 2026-12-24), `objtool` may report:

    rust/kernel.o: warning: objtool: _R..._4core6result13unwrap_failed...()
    falls through to next function _R..._4core6result13unwrap_failed...()

(and others) due to calls to the `noreturn` symbol:

    core::result::unwrap_failed::unwrap_failed_inner

Rust introduced this helper when making `unwrap_failed` generic [1]. The
existing entry for `unwrap_failed` does not match the new helper.

Thus add the mangled one to the list so that `objtool` knows it is
actually `noreturn`.

See commit 56d680dd23c3 ("objtool/rust: list `noreturn` Rust functions")
for more details.

Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Assisted-by: LLM
Link: https://github.com/rust-lang/rust/pull/164059 [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 464f6c9d9ff0..931c5c412f15 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -201,6 +201,7 @@ static bool is_rust_noreturn(const struct symbol *func)
 	       str_ends_with(func->name, "_4core6option13expect_failed")				||
 	       str_ends_with(func->name, "_4core6option13unwrap_failed")				||
 	       str_ends_with(func->name, "_4core6result13unwrap_failed")				||
+	       str_ends_with(func->name, "_4core6result13unwrap_failed19unwrap_failed_inner")		||
 	       str_ends_with(func->name, "_4core9panicking5panic")					||
 	       str_ends_with(func->name, "_4core9panicking9panic_fmt")					||
 	       str_ends_with(func->name, "_4core9panicking14panic_explicit")				||

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.56.0

