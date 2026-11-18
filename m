Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795001007;
	b=5uC/P3AM8px+BsdGBrrmt2vTKgi0oxIn1weehagyOyxStPwBC/PCHMrzxl0Np8TSSMpC
	 Bfa5E2UCOd2v5bkN0g2uUR/nuSb5OOVijwZu/YbKRVXpIp9b2wN9U/K82QSDS+gaJzYt5
	 lwB4Kc0c/M0057K/Agz70ajCV0SWU3mdKDVXdGN/UY4tEY1AWMW05uvD1bk8h4LItjlsd
	 aliv5EdcJ3dDd9rtJxkfnn7i7p1u+6z/SKUBQq1X8LOOT88uTtlkz91XGhaIIS7mj5bDl
	 StciFcM6NwisFTgl92YdyE/4fY/GTGWSXM4XT/zIZksUUXsA0UASe8TFK5hFN03Obeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795001007;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Uo1t1EVVrhNV9dYy9mF5BIHiXsAItxda6Gonbb74fKg=;
	b=s4QnG97o0NthwNkx6JGtAgScM52Mh2Hvaibafd3uLzclZEG6wlv4h7Dga3Tm2RearIam
	 zhEXmmhKXV5rxHwX1OR8JvconKSc6YzDA8siD+uBv2GY3MMec+424Ex6yfU4T4OFRaHwd
	 Tn25zAq/8rWfT78GhpsrFl+SLku0/QXElCtvMtbLGE2UkTZ5+N+Fu+IKwVQw0XdnJUHae
	 ++d6BC4DWo4OAT2+g5U+rXd4nn0cmQ3FEs+vAWqypZUwKW+EqWPuPn6Z1vPchdLF71+25
	 j5mBFLQbQE5cW1DdOc4Rv6Izs/obQxhGJ9cUfMmKmUeYdbzS8Wb+pkZtoNMKHT0eCWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=aZJGhTu9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4824606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=aZJGhTu9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADFA11F000C8;
	Wed, 18 Nov 2026 11:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795001007;
	bh=Uo1t1EVVrhNV9dYy9mF5BIHiXsAItxda6Gonbb74fKg=;
	h=Subject:To:Cc:From:Date;
	b=aZJGhTu9WoJD9JXGJw0e4/Qr4ZJBm1dxAL/utXEsRax7+9dConKkkXYMVm7yv/whU
	 QT5kgT70voqX/bSJsgSu/UxNGCS9jPldaumUglr4LXQU193mL5UIOl/r6J+hCb2Hcv
	 x5Iu0ALkhrhoc3EmMTzvu412tXf7kIjLexbcIan4=
Subject: FAILED: patch "[PATCH] rust: bindings: derive Zeroable for bindgen's opaque array" failed to apply to 6.12-stable tree
To: sashal@kernel.org,acourbot@nvidia.com,aliceryhl@google.com,nathan@kernel.org,ojeda@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 18 Nov 2026 12:23:23 +0100
Message-ID: <2026111823-prelaw-chapped-13ae@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 57d916a3eb765ee0577d269bb2ac1bdf3a7a7f40
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026111823-prelaw-chapped-13ae@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

