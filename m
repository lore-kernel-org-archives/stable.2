Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B264A64ED
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439450; cv=none; b=LSjl9YF5eG80nSU1WIi5IjSlJq9CcN6vUUh3XTgqMGwVnjUbYSlqPkWKBu/FYG/dkrYRoAuwrfJ7BHAGQrffkQD5lwanPBtADRvXGn7CT7SnzI3RvZTXFfj022rEvit035DvHJ12YLnypP7gLWC1yNwl4eKOm+nhpCEgY+LUuz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439450; c=relaxed/simple;
	bh=uow83jLLZ08mrA9lyQYcfbbFHZWc4tlcGDVQjyoLgnY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dUh0i3y/JK/0JdPllgHDIhkwYR3L7hZKk5L/pJ/1puf2FXjZTOwFnaV1Fststl5Mj7cBToEyP4k4COoUr5QjeurbSpgCu8wF+PMwHOa4co7r0QpvgimbDhm8gC/SbpmxyObjm4CuzNhiv1FN2s2sEyueoNvx1+kL5XzxUytOpxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rdz2pCy4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rdz2pCy4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9161F000E9;
	Thu,  3 Sep 2026 12:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439448;
	bh=1TE9OML6GbflRhVh7fcm5pW0F+P4/V3u31hTZ1znx1M=;
	h=Subject:To:Cc:From:Date;
	b=Rdz2pCy4Lv5mUL30IqedHzj8UVKX8adXsQ++T8pJY5HwsHljdELfUNVuYNs+6qoel
	 Rs+OTSw2oAowEyV/cG+0ci4Pr83NpfqrHmVZlhSbQDKVDEXL7GBczSEr+WKhkqG+O2
	 EsY246ocUnI5NRFmtzVVi5pWNytP0FoyavZ7IqbE=
Subject: FAILED: patch "[PATCH] objtool/rust: add one more `noreturn` Rust function" failed to apply to 6.18-stable tree
To: ojeda@kernel.org,aliceryhl@google.com,jpoimboe@kernel.org,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 12:43:41 +0200
Message-ID: <2026090341-uncanny-legwarmer-a899@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 993f235c4af49d0e912cc28abe6d733531600237
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090341-uncanny-legwarmer-a899@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 993f235c4af49d0e912cc28abe6d733531600237 Mon Sep 17 00:00:00 2001
From: Miguel Ojeda <ojeda@kernel.org>
Date: Wed, 5 Aug 2026 16:45:24 +0200
Subject: [PATCH] objtool/rust: add one more `noreturn` Rust function

When the pointer formatting series [1] is applied and KUnit tests
are enabled, `objtool` would report an error with any of our
supported Rust versions. For instance, with Rust 1.97.1:

    rust/kernel.o: error: objtool: _R..._4core3fmt7Pointer3fmtB7_()
    falls through to next function _R..._4core7convert5AsRefNtB5_4BStrE6as_ref()

Or, with Rust 1.85.0:

    rust/kernel.o: error: objtool: _R..._4core3fmt7Pointer3fmtB7_()
    falls through to next function _R..._4core3ffi5c_str4CStrENtNtBS_3fmt7Display3fmtB7_()

This happens due to calls to the `noreturn` symbol:

    core::str::slice_error_fail

Thus add the mangled one to the list so that `objtool` knows it is
actually `noreturn`.

See commit 56d680dd23c3 ("objtool/rust: list `noreturn` Rust functions")
for more details.

[ While the series [1] mentioned above was not applied in a way
  that triggered this, Gary found another case [2]:

    I am seeing this function causing issue on my 1.85.1 -Os build, although the
    error message is different this time:

        rust/kernel.o: warning: objtool: _R..._5range9RangeFromjEE5indexCsldbe0TGTmNx_6kernel+0x1d:
        stack state mismatch: cfa1=4+8 cfa2=4+16

    Disassembly shows that the function call before the warning location
    is a call to _4core3str16slice_error_fail, and objtool thought it can
    return (which will end up with a unbalanced stack if it does return).

  Thus apply it. - Miguel ]

Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Reported-by: Alice Ryhl <aliceryhl@google.com>
Link: https://lore.kernel.org/rust-for-linux/anLxXvCKBcAVf91_@google.com/
Link: https://lore.kernel.org/rust-for-linux/20260706-hashedptr-v13-0-377a07f2f78d@kylinos.cn/ [1]
Link: https://lore.kernel.org/rust-for-linux/DKS7U9UHY6XR.2JC0EBIPCI06Z@garyguo.net/ [2]
Link: https://patch.msgid.link/20260805144524.233362-1-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 87db9f4ed9e2..3ab5b9f1c6a4 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -195,6 +195,7 @@ static bool is_rust_noreturn(const struct symbol *func)
 	return str_ends_with(func->name, "_4core3num20from_str_radix_panic")				||
 	       str_ends_with(func->name, "_4core3num22from_ascii_radix_panic")				||
 	       str_ends_with(func->name, "_4core3num28from_ascii_bytes_radix_panic")			||
+	       str_ends_with(func->name, "_4core3str16slice_error_fail")				||
 	       str_ends_with(func->name, "_4core5sliceSp15copy_from_slice17len_mismatch_fail")		||
 	       str_ends_with(func->name, "_4core6option13expect_failed")				||
 	       str_ends_with(func->name, "_4core6option13unwrap_failed")				||

