Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047868;
	b=oSKehIwBmMaogPn+/gTNvPxl9QZDMmnLXeBoSZJmC/NPgkg8IsR9zP9fBBIntULp+A3m
	 Gz4YF73DVB4NJnmLvCNO5W28OHeBiaJHmY/J5LKx9yMN/A0n3qDClWn7dvhnRt7sXry5W
	 pPem2zQhuXEMqetBa3YLY7HlfHxBo7aOHjGmACTD62flDckoqz/PPJPu4jr4KrcW6MTIR
	 DxvMbTSFPIMSNUvcIQhTtlB0PZKIIRfaqRII/UoI9PcItKosvD6oDqg3M21HSO+28IikB
	 7sltoppeEnfrfRslZutlLFX8P9HtJY0nprChgxxkKWt89wYbhz3WDV4QK+QemNfhNww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047868;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=01ydoz9yBx7H02MxNt/vJjpT21cvzjCF0bAIOUPYYd0=;
	b=TwLZR66LZfUK0sJestvV9ZA+UNI8PQ40eDjQR7Lmw+1luE1nWQbtQbsHCiTdwd2YxNRS
	 Nq9AYLwNRVAOLE94kmZDo2hU5QXZRekhVmS7apjIUb3a+iqFQVEHwbAfBFD8scxDsslky
	 vyNqPZ+lcL9o1soApccFfJiVYQK7ubJnZZkdocb26ZjKlZ17BS24n0i7ltmfqK+dTnbVY
	 X/vUust3kOSArqepd0QTZjUSVAXQzrsSJN6uOXPXnsRit/ZxI9dzjif3B8P+yy6kqYwph
	 GHufGsCZyScGPwtoK/VhD/9Hwhi1Thj+dzg/9V8Y30/JhtmeFgbsZYpIj6AZrinGH+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dvmu1Zt8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44C8606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dvmu1Zt8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9FD1F0089F;
	Sat,  7 Nov 2026 10:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047867;
	bh=01ydoz9yBx7H02MxNt/vJjpT21cvzjCF0bAIOUPYYd0=;
	h=From:To:Cc:Subject:Date;
	b=Dvmu1Zt8Nbu3j1zDqKoPNH7VkfynnJIxO54zLSPCVgwROWsxZ0cG8IDxPZEOJ3NRP
	 JNs/kTY+U1ui6S2NG047APZdCUnvLy6BZaRlt//dIRtlDEF3h9bQLxR8KlJLr45WXz
	 FYxmeKRvdhbwW3lg48BHfEqwefJYYaircenlu6qMU6zqxroYOzZdSZbkeWDy61NnYf
	 0TTayVJsAYYn8G5/gUAtSCbODIyvYXf+jYDQHfL8V+4IE1k1VxNA4wrNymBJALM1tR
	 fByhoiyVn1Gys98CZFZCezAtXdkkvj8xh1p2eo+AGrnNZacqwfOWa+C9tglbM3VP/w
	 vDHBnNIS14i0g==
From: Sasha Levin <sashal@kernel.org>
To: ojeda@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] objtool/rust: add one more `noreturn` Rust function for Rust 1.101.0" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:37:46 -0500
Message-ID: <20261107053746-failed-6.6-6b704ec9007a@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6b704ec9007a3f23ec5ded8f320825ac444f307d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053746-failed-6.6-6b704ec9007a@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




