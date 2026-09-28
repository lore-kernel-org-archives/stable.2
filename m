Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB08E47ACC6
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 10:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790592204; cv=none; b=NLEfxEkaF0e7IuyxFDsWX1dEsdaCGX0BHEPALdgF4/afY0QYvaYZ1pidfD9JYPd8QLZFDSGB4eqWPOeZYZdB3EHz3GfGIeEJqSrc0ZMkgBZLL2oXKZk8Lx/EkLFieKWreVNJnR36jcRE/vcUR8IYeWweCtxulfVeu+vYPUA5WF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790592204; c=relaxed/simple;
	bh=Us176wOm+8+rz2NBzHwXZKWbjOvthf8+VT/A+foQpNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIR9tj4b9AV+uiwp38jaCUx0+iEXLWYlesZHLQcH1RV1+paGKHN4Tg76VUSrhlZjniN+yIRwE+cDJuZfnXy9kQByMJMIJgbXrvLZGHkshzY+lCWo//S21RcR6FHwofYKQ+eUfxkhq0bUf3INDuTDKmvQ77C1r3vSiQ00L5v03Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZhxnsLz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZhxnsLz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610011F00893;
	Mon, 28 Sep 2026 10:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790592202;
	bh=XG3bmLOEI8G01S8/exKbptpBhScG6uqeRlLXCCFlvyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EZhxnsLzsdGT0QfxDNB4xb7UFGFVIj208PburOQbfFuEKKzjBOwJbwJ6T4uZhd+DU
	 Sy0bStLx7lcAH6tJuVT9TrFBVx6iG2C/XPapvdDnN4UMS53vCdAVylBDJ9YwvWE4gC
	 FUkQaSqsCidpRj6Lq7FZbBRf3EjodYoUcfebrD868wXm/SXjVJbwryk90o7fMXRPlU
	 gj4IffuYPBRdJDNF5cl9Deon1Pt9hPMf7u5+PUeYffYbcYLssLQOyKxOMs3clXhZnU
	 cZoTSXTqpziE57Dqs9lCo+ScW4Yj5EnC7WzeLsy5Dj1kLJEzwEXIEheLzTLGHv0+vP
	 rAgpmfUNVvl2g==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Chunfeng Song <springbreeze@stu.pku.edu.cn>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 2/2] rust: net: phy: fix off-by-one bit positions in device status accessors
Date: Mon, 28 Sep 2026 12:43:13 +0200
Message-ID: <20260928104313.204453-2-ojeda@kernel.org>
In-Reply-To: <20260928104313.204453-1-ojeda@kernel.org>
References: <20260928104313.204453-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 6fb0a9d9071f1ff0cc5cfc0782302d9c90d642cb upstream.

The hand-written bitfield offsets in is_link_up(), is_autoneg_enabled()
and is_autoneg_completed() were correct when the abstraction was
merged: at that time autoneg, link, and autoneg_complete were at bits
13, 14, and 15 of struct phy_device's first bitfield unit. Commit
2796ff1e3dca ("net: phy: add flag is_genphy_driven to struct phy_device")
later inserted is_genphy_driven just before autoneg, shifting the three
fields up by one, so the accessors now read:

  is_link_up()           reads bit 14 = autoneg
  is_autoneg_enabled()   reads bit 13 = is_genphy_driven
  is_autoneg_completed() reads bit 15 = link

The official ax88796b Rust driver uses all three accessors in its
read_status() implementation, so it inherits the bug.
phy_attach_direct() sets is_genphy_driven only when it falls back to
the generic driver, and ax88796b has a real driver, so
is_genphy_driven stays 0. The broken is_autoneg_enabled() therefore
reads bit 13 as 0, compares it against AUTONEG_ENABLE (1), and always
returns false, so read_status() never reaches the
resolve_aneg_linkmode() call.

The ordinary bindgen accessors take &self. Calling them through
(*phydev).link() would create a shared reference to the complete
bindings::phy_device, which is not appropriate for an object wrapped in
Opaque.

Use the bindgen-generated raw accessors (link_raw(), autoneg_raw(),
and autoneg_complete_raw()) instead. They retain the bit positions and
endianness handling generated from the C layout without creating a Rust
reference to the complete phy_device. Drop the hand-written numbers
together with the TODO comment that marked them as a stopgap.

The raw accessors are only emitted by bindgen 0.71 and later, and were
added at the Rust-for-Linux project's request, so this fix can only be
backported to stable branches whose minimum bindgen version is at least
that, hence the scope on the Cc: stable line below.

Found by a static equivalence audit (C2RustDrv, a C-to-Rust driver
migration tool) that compares hand-written bitfield offsets against
the bindgen layout of struct phy_device. Verified by building the
bindings and checking the generated accessors; no runtime testing was
possible without PHY hardware.

Fixes: 2796ff1e3dca ("net: phy: add flag is_genphy_driven to struct phy_device")
Cc: stable@vger.kernel.org # Only 7.1.y and later (requires bindgen's raw pointer accessors).
Link: https://github.com/rust-lang/rust-bindgen/issues/2674
Signed-off-by: Chunfeng Song <springbreeze@stu.pku.edu.cn>
Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Link: https://patch.msgid.link/20260910055110.167110-1-springbreeze@stu.pku.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ For 6.18.y, re-do the commit manually adjusting the bit numbers to
  make it work with the `bindgen` version available there as Chunfeng
  mentions in [1]. - Miguel ]
Link: https://lore.kernel.org/stable/SEWP216MB9770116738884C46F156A686FAF98D2@SEWP216MB977011.KORP216.PROD.OUTLOOK.COM/ [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
Chunfeng: I assume you meant a patch like this instead in [1], right?

 rust/kernel/net/phy.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index bf6272d87a7b..5963dbbd54af 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -130,7 +130,7 @@ pub fn is_link_up(&self) -> bool {
         // SAFETY: The struct invariant ensures that we may access
         // this field without additional synchronization.
         let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
-        bit_field.get(14, 1) == LINK_IS_UP
+        bit_field.get(15, 1) == LINK_IS_UP
     }

     /// Gets the current auto-negotiation configuration.
@@ -142,7 +142,7 @@ pub fn is_autoneg_enabled(&self) -> bool {
         // SAFETY: The struct invariant ensures that we may access
         // this field without additional synchronization.
         let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
-        bit_field.get(13, 1) == u64::from(bindings::AUTONEG_ENABLE)
+        bit_field.get(14, 1) == u64::from(bindings::AUTONEG_ENABLE)
     }

     /// Gets the current auto-negotiation state.
@@ -155,7 +155,7 @@ pub fn is_autoneg_completed(&self) -> bool {
         // SAFETY: The struct invariant ensures that we may access
         // this field without additional synchronization.
         let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
-        bit_field.get(15, 1) == AUTONEG_COMPLETED
+        bit_field.get(16, 1) == AUTONEG_COMPLETED
     }

     /// Sets the speed of the PHY.
--
2.55.0
