Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794615447;
	b=GhYb0W+DdPWa8z8MliWmnLFCBCst/QUyAPCZRTatZvcmEq8r81rM2djced/fjQEMzjeX
	 MEMeY6wrruHdjG3+KZ+kWBz8ERZfz5emllVjpx6GpnqQlkF9zBFVRAP8SlFfHUBTOsTW0
	 IS13YzMM0NOw9TjWWuGDH6GfLfxyDTN19Ar5CT7Lh0XdCV2AjSMX3nL9y3iqwzH2f4vMo
	 iCbCzGlYRSSKUIMifeRtWWj0EPbT47ry90Gaq/vYY/jIhHLQ5k+r3j0E4mgsQf9P8Z1/m
	 n7pegjx7EWZhB8v8sOFLX8ABt6MaXXFGRiZHGJJ9ZX2sM4r3wsDQtsm8UyLbYGWDRbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794615447;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1wMRhrbmTEii9sWHb6CHYzvkuAeKaItkXANbq2kqpCs=;
	b=GjekHdY8ZwgR4y6U9mqfnkYn1BUSQgAm6Opaed17Xv3H3ANIek+RsarImZMQzV+VOWRr
	 gw4G3DZWFrfGQvowfSvX5bfdDzkKSrN9hOfdRJywMPCSllk9k4AXvSQMr+nmwJPE2W8IV
	 QFEnqMRouLnnC4k/aphZ9KJ0EnZWdhnqPkSu1D69lXoU/GLOBPEIO5MKDUL4gdnToUgZp
	 M9V2JE0q4X1+xsFFT8G3FlftzNcnHk3NJdHFJzC4j0r1S84kzHfAXTscA6tCj3vXJJX7z
	 fhpBi5lh/9t+u/YPrNlOuXugO3ouynr7KzHV0jxgDnyM5HIq72L/yx6qmreTb4sFISQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dai8/6zz";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C9C606A337;
	Sat, 14 Nov 2026 00:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dai8/6zz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF0E1F000C4;
	Sat, 14 Nov 2026 00:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794615446;
	bh=1wMRhrbmTEii9sWHb6CHYzvkuAeKaItkXANbq2kqpCs=;
	h=From:To:Cc:Subject:Date;
	b=dai8/6zz0cTDL1TkjO87VVScrWrM6nmnquvJWJ3p53QPTCbwsbc8NAxFu5E2u4vln
	 /hFVpL4zm0WvPhkRTraVpGkmBSqjJLSCndlEvDDjsgK28PosRpZEB3YHZQFYClToue
	 h15LFbhZb2/O8m8VDcL36VzLXQJbHqvzldg6yRjhXmQrYyKCdWouNpac8YMpa/9yUI
	 M6ielT+NAmAw9jJP+6ILn4Xdeq+WpCGE5apG0WjXY7eh9C9FVoqGt+Fjc6VjjPioY5
	 nD5nfk0kD6veVFw3x+33MmpJ5Qo7rMbpHk6JoZYKlM2Uk8g7/MRrGDJNzAUYcaal7U
	 Y0sbNpLxhGwUA==
From: Miguel Ojeda <ojeda@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
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
Subject: [PATCH] objtool/rust: add more `noreturn` Rust functions for Rust 1.101.0
Date: Sat, 14 Nov 2026 01:17:08 +0100
Message-ID: <20261114001708.80599-1-ojeda@kernel.org>
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

Starting with Rust 1.101.0 (expected 2026-12-24), `objtool` may report:

    rust/kernel.o: warning: objtool: _R..._6kernel3pci2ioINtB7_6DeviceNtNtB9_6device5BoundE8cfg_size()
    falls through to next function _R..._6kernel3oppNtB5_3OPP18from_raw_opp_owned()

(and others) due to calls to the `noreturn` symbol:

    core::panicking::unreachable_default_msg

Rust now outlines the constant messages of the panicking macros [1],
thus `unreachable!()` (i.e. without arguments) calls that new function
instead of `core::panicking::panic`, which is already in the list.

The same change introduced the equivalent `noreturn` functions for
`panic!()`, `todo!()` and `unimplemented!()`, which lead to the same
warning when those are used:

    core::panicking::panic_default_msg
    core::panicking::todo_default_msg
    core::panicking::unimplemented_default_msg

Thus add the mangled ones to the list so that `objtool` knows they are
actually `noreturn`.

See commit 56d680dd23c3 ("objtool/rust: list `noreturn` Rust functions")
for more details.

Cc: stable@vger.kernel.org # 6.12.x (Rust is pinned in older LTSs)
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://github.com/rust-lang/rust/pull/163766 [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 tools/objtool/check.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 931c5c412f15..4ef5bf97d333 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -206,9 +206,13 @@ static bool is_rust_noreturn(const struct symbol *func)
 	       str_ends_with(func->name, "_4core9panicking9panic_fmt")					||
 	       str_ends_with(func->name, "_4core9panicking14panic_explicit")				||
 	       str_ends_with(func->name, "_4core9panicking14panic_nounwind")				||
+	       str_ends_with(func->name, "_4core9panicking16todo_default_msg")				||
+	       str_ends_with(func->name, "_4core9panicking17panic_default_msg")				||
 	       str_ends_with(func->name, "_4core9panicking18panic_bounds_check")			||
 	       str_ends_with(func->name, "_4core9panicking18panic_nounwind_fmt")			||
 	       str_ends_with(func->name, "_4core9panicking19assert_failed_inner")			||
+	       str_ends_with(func->name, "_4core9panicking23unreachable_default_msg")			||
+	       str_ends_with(func->name, "_4core9panicking25unimplemented_default_msg")			||
 	       str_ends_with(func->name, "_4core9panicking30panic_null_pointer_dereference")		||
 	       str_ends_with(func->name, "_4core9panicking32panic_null_reference_constructed")		||
 	       str_ends_with(func->name, "_4core9panicking36panic_misaligned_pointer_dereference")	||

base-commit: ee83899302a0457a3ba47464a13e8682bd7ba27d
-- 
2.56.0

