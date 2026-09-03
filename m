Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5B34A64DB
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439433; cv=none; b=AVMLGwFVtNNIhRpLNiLsMf36DWHXR8sf+SekI1TD06IKGegpf7QQfP1DiHVlXj1OrWtV2IxmOTiWay7qQR4iq6Uev0itka61FzZGKE544liL8fjzxQ/Cnn3XoslX234KnR3o1gtQr7Ud0q4PCHu5NJm/nMhh8EIAvBDmMZ37zq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439433; c=relaxed/simple;
	bh=d17bASrqapL+3yc481d51SrpNtS45PaqTOsF8/2AnS8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=owNfbCDEksX8YWDrdeCvn27qYVNQeHC8zzsZMAKYNSwhXRm5bjCyGWvwSaHFZj7dpF8h/bK1NZ/9JMWf5H+JyBXZayEdmsyGYNVEhp0nzwk6TJLKbxeP/VHgG+2913fKdklKROL5MIer75gvMhZTj1/7wToQesHZ3t0hohN8t4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zX9lvE+p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zX9lvE+p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150901F000E9;
	Thu,  3 Sep 2026 12:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439431;
	bh=kRQXK+VBu34hOGX6Pp1T/omzhA96y8nUC1z89honXFg=;
	h=Subject:To:Cc:From:Date;
	b=zX9lvE+pBXI7SKgaFS05ng0Gy8mx/Yg1msEyZbjDbkSnCJCiryp4vgeOAA+ZP4gY8
	 Xxzfe1HQ4eNrFywxpUlI9C7KgHnUz8xTChDWm+gE9HJ3gcXiv2o+FeDsO6TU8Kgygp
	 ApW7DnyKpbNXS1PkRN/KBDFnpX30ZMxkmn+OFoiw=
Subject: FAILED: patch "[PATCH] objtool/rust: add one more `noreturn` Rust function for Rust" failed to apply to 6.12-stable tree
To: ojeda@kernel.org,aliceryhl@google.com,jpoimboe@kernel.org,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 12:42:24 +0200
Message-ID: <2026090324-constrain-truffle-09ee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 16861ca3508e0deac70d3bcacb6dcf435b49d9ef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090324-constrain-truffle-09ee@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 16861ca3508e0deac70d3bcacb6dcf435b49d9ef Mon Sep 17 00:00:00 2001
From: Miguel Ojeda <ojeda@kernel.org>
Date: Tue, 28 Jul 2026 21:14:48 +0200
Subject: [PATCH] objtool/rust: add one more `noreturn` Rust function for Rust
 1.99.0

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
Tested-by: Alice Ryhl <aliceryhl@google.com>
Link: https://patch.msgid.link/20260728191448.349241-1-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

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

