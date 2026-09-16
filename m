Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3429548CD53
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550132; cv=none; b=WZzudVDPe/4IA/uPPvhUTaaE3hJSCuya4FcPC6WNFviQ7huauQjhGbg7OxC4k5Whw3oDdj46mQTY6kyfXDiNprshGI/WI0nxY757LoqOkx3oyjYnyc42ttJ3LNBRMhVaTnPALJZKHriq240FfgTCL33wVQi+Br2WfswGg9qy5XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550132; c=relaxed/simple;
	bh=wtsaDzFbSwgCvlfTFmN+CNUGnHcKThRLkzVL1I/9nAg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pzd1i7Cb7ErGBlaad0a9nYTdbJqjAKY2gyJW3Eqb6iKveUM4yu35HBas5E7BDz3Lwz6ZIWPxolbsU5rXSDf1tyRSVNEirmGdCedDE6Aa1ds2TpciC/vijbx/8e1nAtFP9nV0BOLQ5kLiJnDTkeZugddsoX/503jEv8G2biQpZxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u6sOnaBU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u6sOnaBU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BF31F000FF;
	Wed, 16 Sep 2026 09:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789550112;
	bh=sRHqqo96oxDCdgzEPjf/LmOMFpUmIA7l+wxIqo6poCQ=;
	h=Subject:To:Cc:From:Date;
	b=u6sOnaBUfX0w+xuesbLPiLMUIccue3UcLOWEI1A9jOH93C6QIEpy3JwYwUnzQnduf
	 LcICllsVuaqiKe+084PxyKpYWD3kVhTvcpZocLmtaALtGCnXLofO+k9+qCYY485Z/8
	 XnJ7RY12H7ElU843kC79rvTi95TPJSkUMQN7BnTk=
Subject: FAILED: patch "[PATCH] rust: allow `clippy::as_underscore` in the generated bindings" failed to apply to 6.12-stable tree
To: jhubbard@nvidia.com,ojeda@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 10:13:19 +0100
Message-ID: <2026091618-barrier-dexterous-aa2d@gregkh>
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
git cherry-pick -x 2ac74c6db40adaa29c50cbb281ae9a6f63de18e1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091618-barrier-dexterous-aa2d@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2ac74c6db40adaa29c50cbb281ae9a6f63de18e1 Mon Sep 17 00:00:00 2001
From: John Hubbard <jhubbard@nvidia.com>
Date: Sun, 6 Sep 2026 14:58:22 -0700
Subject: [PATCH] rust: allow `clippy::as_underscore` in the generated bindings

A CLIPPY=1 build emitted about 15000 `as _` conversion warnings, all of
them in bindgen's generated output and none in hand-written code.

[ The lint messages look like:

    error: using `as _` conversion
         --> rust/bindings/bindings_generated.rs:18947:9
          |
    18947 |         self._bitfield_1.get_const::<0usize, 16u8>() as u32 as _
          |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^-
          |                                                                |
          |                                                                help: consider giving the type explicitly: `u32`
          |
          = help: for further information visit https://rust-lang.github.io/rust-clippy/rust-1.98.0/index.html#as_underscore
          = note: `-D clippy::as-underscore` implied by `-D warnings`
          = help: to override `-D warnings` add `#[allow(clippy::as_underscore)]`

    - Miguel ]

bindgen 0.73 returns each bitfield read through a trailing `as _`, and
0.72 returns it through a transmute, which the lint ignores. The
bindings and uapi crates allow `clippy::all` over the generated code.
That group does not cover `clippy::as_underscore`, a restriction lint.

Allow `clippy::as_underscore` by name in the bindings and uapi crates.

Assisted-by: LLM
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Link: https://patch.msgid.link/20260906215822.1201022-1-jhubbard@nvidia.com
Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
[ Removed CI sentence. - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index 812f8e5a08d5..ad24c920b919 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -22,6 +22,7 @@
 #![feature(cfi_encoding)]
 
 #[allow(dead_code)]
+#[allow(clippy::as_underscore)]
 #[allow(clippy::cast_lossless)]
 #[allow(clippy::ptr_as_ptr)]
 #[allow(clippy::ref_as_ptr)]
diff --git a/rust/uapi/lib.rs b/rust/uapi/lib.rs
index 797ead5b5626..2df0340e63d1 100644
--- a/rust/uapi/lib.rs
+++ b/rust/uapi/lib.rs
@@ -10,6 +10,7 @@
 #![no_std]
 #![allow(
     clippy::all,
+    clippy::as_underscore,
     clippy::cast_lossless,
     clippy::ptr_as_ptr,
     clippy::ref_as_ptr,

