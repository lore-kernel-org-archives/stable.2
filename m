Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049802;
	b=cSj6JKJy4q/Dawnp6ZuD4Vd4CEiVHyXPwFUCliXhkWf3zAtArlBukzs5xAC3wsHgwD51
	 hpYHOsOKb5Cb/UqaEYuk7+swJ8Vyl9WZkmgBpDGjrzjHyG9gWjOWq7WiWs93fUJBgwni0
	 gFKX6sMyyQqzNPRbK0kgVEKLgOB96YCaL6FWu45HJnoZAgLkZiwQ3jOTzpwt00/fxmHa5
	 O0ZGmCYed4cofjvcOI2mwFFtrRuwBfH86eb9TWcojNK7SknZlUxIzpTMXZefPt8CvoAf/
	 bEKkG8vd/nUEfsdqZez6EgMCnIRsOcimG9ILu2lz1Jb2/U7qSuGK8tSUf5eFrmw4G1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049802;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0bu+Va0KZEY8IYly8Tz6i3R8K7BNfmTpiElBDCeR8ZI=;
	b=c6mHKQlSfvRDN+FOOTskBH0vmLceEyTf21njPQIyk0twG2JpbZfS3l/Qb302YVkNNJav
	 ITdVVgSO7awGenTUS+p1HTNtWa07xHhnLQ0hUdKi8e8NQACPT3iLmvyIcFjPPsIJHnw+3
	 LnOwOnpRYPDY+tIXKm4YysrHOUNtPhUEKbODnCZrFyNaxnjDe1j4BsVEOigWpUvn4Twoe
	 1CRIHaceEVLyWuvF/6NzQ7LwcZjJLyFCC1AiNylGk02d/4ylUq539/9j13GChrGfz+6b6
	 QYG2J/oRoRyPC3BNw5O9vN4+qcPLvK6Eb2kypeK4SwvBLTROBnBLeAzuwdNi49R3GPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GWcF1oJU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2A3606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GWcF1oJU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00621F008A1;
	Sat,  7 Nov 2026 11:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049802;
	bh=0bu+Va0KZEY8IYly8Tz6i3R8K7BNfmTpiElBDCeR8ZI=;
	h=From:To:Cc:Subject:Date;
	b=GWcF1oJUmC3QkwllEfQ6KPY9m/ofdcnAUfwTXEp8qGMe81ImmnugYvH1FYlwaubcz
	 hdSGh4s99i7IejdnWhBqQyLxPJ2HYXMlUAqf+qt0Pnp/7StW0f3yobk7AEFvJuEJWj
	 APv/Y/qL3CSqT3iDqR54H1QNXNEaEbCK06hvGxOud+VxYLY57NLcPLX3ICR0KwI+IU
	 bslAiAcC8IYjBQpVcVSxe8nTnQi7turbrefYY+cNQHXdClJ9Vx/ZRleJSkbVuzck15
	 mdy3JVEt6/x6tbIPE5An+5S4D2zXeVyMaLMI9e4KwtvwCPIseErDKQAUQ33WKlgJ4w
	 JlDb9d1BQyCRA==
From: Sasha Levin <sashal@kernel.org>
To: ojeda@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] objtool/rust: add one more `noreturn` Rust function for Rust 1.101.0" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:10:00 -0500
Message-ID: <20261107061000-failed-5.15-6b704ec9007a@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 6b704ec9007a3f23ec5ded8f320825ac444f307d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061000-failed-5.15-6b704ec9007a@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




