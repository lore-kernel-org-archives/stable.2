Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795000397;
	b=H5UcN0Qf2+M1CF08hvgUgRnar1DDXiJrDX+1zju0Xqh7BuinPqA9+ZPW1/dHlq7vbEO1
	 cHNlDwbTJzpDfsN/bWyTZsF9AU+W8ONazJLTaFBKV4OyLro2kAOeRV9VbZ0yMibgBZQ74
	 80gceyGeDCp5mXNi0BdLvKqWJh9WZTY4cmEGN9eGk4KG/s5ryPHB8jB8PV75x3XYxAfRT
	 C8zJLUY7AtKs9v/Urjh7yNAdIxDBuh9xNXrN0bc3BpcSSz/q3Ock16+Vfv9zZ1ViVP+E0
	 /stV/wz3AA0tlpp2LkomApNbybfoWx3VigtLyfFqGd9gIyOEC7mLsMG5Kzcbd7OXXlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795000397;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4uPiSbgoqhzT7PRc0/Neidefg70yiK/fDtckwB5JWSA=;
	b=WE5havyD27cKV3c065tXxPG6Lo6C6t5oNe4YqOu47IInVAw8EokXQBcbNBaTYPmwT374
	 t41t5amzsZ1TSijhvvBk4EaxOrXhczPDSQyM0dXvLhDnYzOespPehKtcttJJpZvUjKVsz
	 AZqvCGyiCSrngv8OOh5Sd47O4J+CFLtxcfrCKD8f7q2T1PHk4uGBWX/3f/r7OA9euU9i5
	 w8OR77kWnhgpzHXRrlppq5BD3c4x27/ad0/j7EhOHWixURtWgbLcZ2hXqyN1ym40wT8os
	 gewTyC7iFfaav6oZWdFpH6yTas8xrUGGmAkVNtefbUrNTMrGF80h+C1HuQR2hHS7jXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jx6UFZFv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B844C606A33D
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jx6UFZFv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6051F000C8;
	Wed, 18 Nov 2026 11:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795000397;
	bh=4uPiSbgoqhzT7PRc0/Neidefg70yiK/fDtckwB5JWSA=;
	h=Subject:To:Cc:From:Date;
	b=jx6UFZFvWONOlVU4OfAWRCJzHjIRjBNbgJMsSUJYsmPu6b+6beyKFz6csa4O+31DF
	 QgQLo4zFggZIWGUx6WS45L3z0DaSfF1+vuXlCHLGI9FD9ra13AM8Eo9VQEUnVYvcfR
	 5FyfMcOPSllD4Z0sFrjVwsyzPVLYQaj9U8zU/W/4=
Subject: FAILED: patch "[PATCH] rust: bindings: derive Zeroable for bindgen's opaque array" failed to apply to 6.18-stable tree
To: sashal@kernel.org,acourbot@nvidia.com,aliceryhl@google.com,nathan@kernel.org,ojeda@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 18 Nov 2026 12:13:14 +0100
Message-ID: <2026111814-mushroom-shelving-5b17@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 57d916a3eb765ee0577d269bb2ac1bdf3a7a7f40
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026111814-mushroom-shelving-5b17@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 57d916a3eb765ee0577d269bb2ac1bdf3a7a7f40 Mon Sep 17 00:00:00 2001
From: Sasha Levin <sashal@kernel.org>
Date: Sat, 31 Oct 2026 11:28:46 -0400
Subject: [PATCH] rust: bindings: derive Zeroable for bindgen's opaque array
 wrappers

bindgen 0.73 emits the blob of some opaque types, such as ones aligned
to more than 4 bytes, as a `__BindgenOpaqueArray` or
`__BindgenOpaqueArray<align>` newtype instead of a plain array. The
newtype only derives `PartialEq`, `Eq`, `Copy`, `Clone`, `Debug` and
`Hash`, and the `MaybeZeroable` custom derive does not reach it, so a
struct that embeds such an opaque type is no longer `Zeroable`.

`spinlock` is opaque (see rust/bindgen_parameters), and with lockdep its
blob becomes a `__BindgenOpaqueArray8<[u8; 72]>`. Commit 71ec3c7d6db8
("blk-mq: quiesce a queue that joins a quiesced tag set") added a
`spinlock_t` to `struct blk_mq_tag_set`, so an allmodconfig build with
bindgen 0.73 now fails:

  error[E0277]: the trait bound `bindings::__BindgenOpaqueArray8<[u8; 72]>: pin_init::Zeroable` is not satisfied
    --> rust/kernel/block/mq/tag_set.rs:41:49

Which wrappers exist depends on the bindgen version and on the opaque
types of the configuration, so they cannot be covered by unconditional
impls in rust/bindings/lib.rs like `__BindgenBitfieldUnit` is. Derive
`Zeroable` for each wrapper in the generated bindings instead. The
pattern allows for the spacing of bindgen's output when rustfmt is not
available.

Fixes: 71ec3c7d6db8 ("blk-mq: quiesce a queue that joins a quiesced tag set")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/rust-for-linux/20261030223702.GA1673281@ax162/
Link: https://patch.msgid.link/20261031152846.746656-1-sashal@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

diff --git a/rust/Makefile b/rust/Makefile
index 0ac9ab28cc2b..0165626decbe 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -514,13 +514,20 @@ endif
 bindgen_c_flags_final = $(bindgen_c_flags_lto) -fno-builtin -D__BINDGEN__
 
 # `--rust-target` points to our minimum supported Rust version.
+#
+# `bindgen` 0.73 emits the blob of some opaque types as a
+# `__BindgenOpaqueArray[<align>]` newtype, which the custom derives do not
+# reach. Derive `Zeroable` for those wrappers, so that a struct embedding such
+# an opaque type (e.g. `spinlock_t` with lockdep) is still `Zeroable`. The
+# pattern also matches the unformatted output used when `rustfmt` is missing.
 quiet_cmd_bindgen = BINDGEN $@
       cmd_bindgen = \
 	$(BINDGEN) $< $(bindgen_target_flags) --rust-target 1.85 \
 		--use-core --with-derive-default --ctypes-prefix ffi --no-layout-tests \
 		--no-debug '.*' --enable-function-attribute-detection \
 		-o $@ -- $(bindgen_c_flags_final) -DMODULE \
-		$(bindgen_target_cflags) $(bindgen_target_extra)
+		$(bindgen_target_cflags) $(bindgen_target_extra); \
+	sed -Ei 's/pub struct __BindgenOpaqueArray[0-9]* *< *T *> *\( *pub T *\) *;/$(pound)[derive(pin_init::Zeroable)] &/g' $@
 
 $(obj)/bindings/bindings_generated.rs: private bindgen_target_flags = \
     $(shell grep -Ev '^#|^$$' $(src)/bindgen_parameters)

