Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FA226C385;
	Fri, 10 Jul 2026 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783704785; cv=none; b=GuEQToopr74Bq8wu43I6apiBbkiRBBWZdZhtsvlJ7DODYwMRDZ3eNyR/qmX2QX+YNMcEJlB9ihCpRf1h5a9vOFPr7IYkgiIp8N5/vhV+4Z3VDXBPFInRIcy0wmjI+uym0dADPIS6P41KgX1fnxKNzoLHgnBP/Pnwc4uFvYGTSCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783704785; c=relaxed/simple;
	bh=VhN10gjpHDUzNpEsoS+r1SxNaNGFlgcSq9RzqR5QQZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=roXnkW7ohU6Ct0Vx5MvDDMEUpAzXkFF3e8c2pLxTkUWfhnSJl3K5SC1AEBYbUm7t1l3YC7R7GOLevSaHE5O4jOEdOLT/JSrraELokY9ZR3TbOB22Yy5eq5ZylSUU1opTDCmIjNxt7MnZ2wRxhFIX8Zlafbn4GRyaKYemwfeXcYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpApmeya; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpApmeya"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F691F000E9;
	Fri, 10 Jul 2026 17:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783704784;
	bh=JnSVG8IaeB6qiNzQUFlK4LPTT27Hklo+Ih2I5lEYg7c=;
	h=From:To:Cc:Subject:Date;
	b=hpApmeyaskOT1QYKyRhoBZot3qIY3wyBxvjAp82S8BXdDWomxDmUlQ4v2p3bRY3E1
	 P6WW8E7uPnodcPXgwvlQAb3gDgX+4cIbPNOi4PNhgSDb21vlXcy/tvynQMrY+jsPqp
	 24yT0Lic7uBHWDyeJeJ9rBGIDb0cYJHiVPdWyNP+X/DYAkSxZEhNO6ymEMe+TzfCI9
	 4hAKi627if3IFPaehIt4HPhrXVwQSdGb+3kVQ4+irNyYz7Ltr0wtnLyr1XFT8Gsmh2
	 YntVlcKPgLTo+NcskkXXBRhuXHkLVQWwhzkCgzr+oEtL0v6ezqR1oRr3WPPoAn8Iw8
	 Ze8hk0qQmZotw==
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
	stable@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH] objtool/rust: add one more `noreturn` Rust function for Rust 1.99.0
Date: Fri, 10 Jul 2026 19:32:52 +0200
Message-ID: <20260710173252.191781-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting with Rust 1.99.0 (expected 2026-10-01), under
`CONFIG_RUST_DEBUG_ASSERTIONS=y`, `objtool` may report:

    rust/kernel.o: warning: objtool: _R..._6kernel12module_param9set_paramaEB4_()
    falls through to next function _R..._6kernel12module_param9set_paramhEB4_()

(and many others) due to calls to the `noreturn` symbol [1]:

    core::panicking::panic_null_reference_constructed

Thus add the mangled one to the list so that `objtool` knows it is
actually `noreturn`.

See commit 56d680dd23c3 ("objtool/rust: list `noreturn` Rust functions")
for more details.

Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>
Link: https://github.com/rust-lang/rust/pull/158796 [1]
Reported-by: Alice Ryhl <aliceryhl@google.com>
Link: https://lore.kernel.org/rust-for-linux/alEBInX9gD1M5NAr@google.com/
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 10b18cf9c360..f03dd59e7fca 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -206,6 +206,7 @@ static bool is_rust_noreturn(const struct symbol *func)
 	       str_ends_with(func->name, "_4core9panicking18panic_nounwind_fmt")			||
 	       str_ends_with(func->name, "_4core9panicking19assert_failed_inner")			||
 	       str_ends_with(func->name, "_4core9panicking30panic_null_pointer_dereference")		||
+	       str_ends_with(func->name, "_4core9panicking32panic_null_reference_constructed")		||
 	       str_ends_with(func->name, "_4core9panicking36panic_misaligned_pointer_dereference")	||
 	       str_ends_with(func->name, "_7___rustc17rust_begin_unwind")				||
 	       strstr(func->name, "_4core9panicking13assert_failed")					||

base-commit: 22ed4af6f0a9f55e6900b69708d3359a01d65b2d
--
2.55.0
