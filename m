Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9611471422;
	Tue, 28 Jul 2026 19:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266111; cv=none; b=rkcKLB/Jrl+/WouUqtvQ9gk11SUwsGS5RBYka+HQda6w73oCNRShYeWsM7N+g5loqwLATjILqKTLMqNefpXJjaQDy39MHwf6C3tnqiutIKTlHp4+KUtgA7/9plMctLLqm+nCqekHL/A1maNdg9HtE55UNORL74sSFRwF8EesjKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266111; c=relaxed/simple;
	bh=MRFNHRc/PyE7WLunB3dytaSq3QU+46dEoi0p2+ejtdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y89Ph0djXxAORxvHSC6Tv3eUz64KMJsDSinBmxH6o82bW0oo64kh1JrW11sS5M6mvbipNshhfsTGzqJ5WLYwLNAXpnSHR//Mn3b9KoJEn8Rhs3r9rsd4wBhK0a+cvmS2giVhMyGN81s4BZu5niVn/MCAOS7GBFpsAJEmztIwj7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngHVjGc0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngHVjGc0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C969A1F000E9;
	Tue, 28 Jul 2026 19:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785266109;
	bh=sg99LZLXeoExTHaUJ/dGnARCNtpBvcLJ2vM/eP0Bm0Q=;
	h=From:To:Cc:Subject:Date;
	b=ngHVjGc0oQ20v3LwE3HUuA9YjVOwPQHnu75/MvxJehZqSC2t44vkeIE+sJwiH8zig
	 vkcwuXu272ivBLSJHdIkRMXU8oVTCyqgCC1xGOGR11LQN2nN01gmUTpBmq9zaRDswp
	 4fwXaVnZ+cMFs3EGnAtsuKhn8trOu3hHCQoKreQ50MbS+0EncyoQ2anFHmdCFb8/ME
	 FcbDr2in6RmVs4XWX4oZbITqWlSmQsb0FjofAtEAsQ5K2w9KUlM/Q9MZVYT07XC3MS
	 uiy8bbmqt1rwvzAIqCQCnzwBGF0dbwH/KTLgrCAGg9/0bfIbjG74OngKdwrP5Zqiii
	 YfH4GTbU/sJ3Q==
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
Subject: [PATCH] objtool/rust: add one more `noreturn` Rust function for Rust 1.99.0
Date: Tue, 28 Jul 2026 21:14:48 +0200
Message-ID: <20260728191448.349241-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting with Rust 1.99.0 (expected 2026-10-01), `objtool` may report:

    rust/kernel.o: warning: objtool: _R..._6kernel3str9parse_intaNtNtB2_7private12FromStrRadix14from_str_radix()
    falls through to next function _R..._6kernel3str9parse_intaNtNtB2_7private12FromStrRadix16from_u64_negated()

due to calls to the `noreturn` symbol:

    core::num::from_ascii_bytes_radix_panic

The function was renamed from `from_ascii_radix_panic` [1], which is
already in the list.

Thus add the new one to the list so that `objtool` knows it is actually
`noreturn`.

See commit 56d680dd23c3 ("objtool/rust: list `noreturn` Rust functions")
for more details.

Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://github.com/rust-lang/rust/pull/159554 [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f03dd59e7fca..87db9f4ed9e2 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -194,6 +194,7 @@ static bool is_rust_noreturn(const struct symbol *func)
 	 */
 	return str_ends_with(func->name, "_4core3num20from_str_radix_panic")				||
 	       str_ends_with(func->name, "_4core3num22from_ascii_radix_panic")				||
+	       str_ends_with(func->name, "_4core3num28from_ascii_bytes_radix_panic")			||
 	       str_ends_with(func->name, "_4core5sliceSp15copy_from_slice17len_mismatch_fail")		||
 	       str_ends_with(func->name, "_4core6option13expect_failed")				||
 	       str_ends_with(func->name, "_4core6option13unwrap_failed")				||

base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
-- 
2.55.0

