Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048776;
	b=3/KTysTxQxPq+vJP2/jiPtPxBA4jpN9Wz2R66/kzyDxUC0+Jx9bG8wqPhvb31BYylDrt
	 IZVYyf9LEXzanQ76q0NgOflK+y7PB4XMRcMnt13TZib4mAxvqah7o6YOkM/lRiQR7JQkH
	 EqLpvs9byPOCPCGuuFBEewp3TKRJ9RjoOYWh+Tdrg4kIf/xl9QyiCxkxA96Kc8Czhujpo
	 olwXHa8lOdY0qE8wXEzNIsZlAPY6w41goAnP0YeqU9S3GRfETNraOk215wOvhhPu79nXS
	 OKQ7cS6vTNMNsIN2mY8y4A7YpAArgWhk4x2kW/6+MIJUQCsAnVtG5JfrAw6F+lApdvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048776;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cnC3C/5lALld0nlFcYRY/Vmh2MS368mE8mcluU1DSUQ=;
	b=Z+6FzBnhmlZca5VPZYeY/Zm/565so/6kJFWbOkN8kv/wBZEx4e7e36aQRST+pAkNC+qp
	 ggxCJP/Ikj6bmkdsSS+wZSPCzoz/5p5qEOIiCh02o3bAI4VW7HbcGMWOoVJg7YjV5dW+X
	 1nYvgSe6ACMh7u7AaRBeh6qKJQp4AqpbiDeJOiUlOVsKubMf8KuxbLlErWXHz5p/8/KYZ
	 hDy262jwioy62tMNPym2v3Pr6tWB0O3rL5jO7xHe/Uck8dkd9skY1yk97KEby0H990cNb
	 axpgn5xJZ+TsBABK1/B7wFJDHByyxkuUeMSQZiTwxqUGxgfoC+8GkqXMct/OOgF1a8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="S4/SgG4s";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB16606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S4/SgG4s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523491F0089F;
	Sat,  7 Nov 2026 10:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048775;
	bh=cnC3C/5lALld0nlFcYRY/Vmh2MS368mE8mcluU1DSUQ=;
	h=From:To:Cc:Subject:Date;
	b=S4/SgG4sYrC0MS05cxYBcE6+rh57CAHMdBez6Dh3p6mPXHliY6Jbjwn6Pblp5NQ/4
	 YH1w0WBg9DWwgMACjeLhAWxBuMWa7puaOHCwfHo8aOI0gk26RBaJfNGpPBNTuNEeld
	 gY0CFEA3+YQT0uTDKLqYdE6B77DKyDtPIurGIvMkB1YkAhSQZ/KhzTKNEpwZiidqtT
	 ehofHF3QTcu9J0tf9XE1TJNSSwvqdQEWykC4NPzPzGhSaBdL8hdbI2bpoFccDFz7w+
	 yxXIGKCu0eJuPCCYGaxEV/NL/uwTAmyVcA2Fjfvf2Zj5apjZlfRUPFkPPRENx50EqC
	 uxxUHRu7e20aA==
From: Sasha Levin <sashal@kernel.org>
To: ojeda@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] objtool/rust: add one more `noreturn` Rust function for Rust 1.101.0" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:52:54 -0500
Message-ID: <20261107055253-failed-6.1-6b704ec9007a@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6b704ec9007a3f23ec5ded8f320825ac444f307d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055253-failed-6.1-6b704ec9007a@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6b704ec9007a3f23ec5ded8f320825ac444f307d Mon Sep 17 00:00:00 2001
From: Miguel Ojeda <ojeda@kernel.org>
Date: Sun, 18 Oct 2026 15:13:13 +0200
Subject: [PATCH] objtool/rust: add one more `noreturn` Rust function for Rust
 1.101.0

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
Link: https://github.com/rust-lang/rust/pull/164059 [1]
Assisted-by: LLM
Link: https://patch.msgid.link/20261018131313.59391-1-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 464f6c9d9ff0b..931c5c412f15d 100644
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
-- 
2.53.0




