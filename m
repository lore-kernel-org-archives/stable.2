Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520DA361975;
	Tue,  1 Sep 2026 14:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273184; cv=none; b=Ff7jPB9ZaVePHdOcy/wn8bM6tvRyD68kR/yVqVRSGLvZ1Qov2MmJcOqPOdFbNP10decqJTHeryOKMtu6PKWLppzv3WFK+A+skmcQTJDRwe+UCFi88rJW+VMI7Mk0kpkWC2LX/9YyZZHDHdJMDrTLZJ/laS4fCUtDISN15f/8l20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273184; c=relaxed/simple;
	bh=PEFvYa7fag7rBQlfAETyuVWXNqnhMgW9J0ztwfRCKcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZKnh58Ps0rgsvAVmepcTUP+4dMVuLhxaKM+EnSIMV35Wqp5cNoBRonAlAjM4gJGzpoVio+Sku/CKd41f821ktA3tgjTMKstvh6yVQU3l7SWivti/YiGz3QmRQx6occKTdWoOCwnH0QW3LakAyOR13Nfv5cCuBFOjAmq8ez69MWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn; spf=pass smtp.mailfrom=stu.pku.edu.cn; dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b=DqEaBJwC; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b="DqEaBJwC"
Received: from localhost.localdomain (unknown [106.120.124.5])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c2113a92;
	Tue, 1 Sep 2026 22:32:53 +0800 (GMT+08:00)
From: Chunfeng Song <springbreeze@stu.pku.edu.cn>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	stable@vger.kernel.org
Subject: [PATCH net v5] rust: net: phy: fix off-by-one bit positions in device status accessors
Date: Tue,  1 Sep 2026 14:32:51 +0000
Message-ID: <20260901143251.136378-1-springbreeze@stu.pku.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa05d63221d03a1kunm1981180e172dcb
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHxkfVk8ZGRlMSh8YQx1CHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS01VSklLVUpJT1VOWVdZFhoPEhUdFFlBWU9LSFVKS0lITk
	NDVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=DqEaBJwC5B5NnVKMAgHAJj3FX8KxPdU9GDfwg5obC1OY9dRReiXKs2Y30kVuqVPXBzc9gS281YIaCHbWXl9uXKyKtFaQycXu9/6XVO4SMWTKdP/hji61R1w+l1+sIIl0a0I8wPuYpz1fdvE18zABoDKYkceLcV3+h9cZzL6uEII=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=QNbYU1S+Yn/yW/enY2HpejcwJ0vEQEtK2O0tmYNd5/0=;
	h=date:mime-version:subject:message-id:from;

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
link-change handling, so it inherits the bug. On genphy-driven devices
is_genphy_driven is always 1, which masks the broken
is_autoneg_enabled() check.

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
---
---
v5:
  - Move the comparison out of the `unsafe` block so that only the raw
    accessor call stays inside (Gary Guo, Miguel Ojeda).
  - Scope the `Cc: stable` backport to 7.1.y and later, since the raw
    accessors require bindgen 0.71 (Miguel Ojeda).
  - Mention the bindgen 0.71 dependency in the commit message.

v4: https://lore.kernel.org/r/20260901031824.1377498-1-springbreeze@stu.pku.edu.cn/
  - Use the bindgen-generated raw accessors to avoid creating a shared
    reference to the complete C `phy_device`, as suggested by Jakub Kicinski.
  - Update the SAFETY comments to describe pointer validity and the
    callback-context preconditions.
  - Add `#[inline]` to the three small forwarding methods.

v3: https://lore.kernel.org/r/20260825111334.795732-1-springbreeze@stu.pku.edu.cn/
  - Use the bindgen-generated accessors instead of hard-coded bit numbers.
  - Update the Fixes tag and add the net tree subject prefix.

v2: https://lore.kernel.org/r/20260824111227.742645-1-springbreeze@stu.pku.edu.cn/
  - Use bindgen-generated accessors as suggested by Andrew Lunn.
  - Explain that the offsets drifted after `is_genphy_driven` was added.

v1: https://lore.kernel.org/r/20260823103644.342849-1-springbreeze@stu.pku.edu.cn/
 rust/kernel/net/phy.rs | 44 +++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 956cda573ddb..256f939c5098 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -123,39 +123,43 @@ pub fn state(&self) -> DeviceState {
     /// Gets the current link state.
     ///
     /// It returns true if the link is up.
+    #[inline]
     pub fn is_link_up(&self) -> bool {
-        const LINK_IS_UP: u64 = 1;
-        // TODO: the code to access to the bit field will be replaced with automatically
-        // generated code by bindgen when it becomes possible.
-        // SAFETY: The struct invariant ensures that we may access
-        // this field without additional synchronization.
-        let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
-        bit_field.get(14, 1) == LINK_IS_UP
+        let phydev = self.0.get().cast_const();
+        // SAFETY: By the type invariant of `Device`, `phydev` points to a valid
+        // `struct phy_device`, and the caller is in a context where this access
+        // is safe. The bindgen raw accessor does not create a Rust reference to
+        // the C struct.
+        let link = unsafe { bindings::phy_device::link_raw(phydev) };
+        link == 1
     }
 
     /// Gets the current auto-negotiation configuration.
     ///
     /// It returns true if auto-negotiation is enabled.
+    #[inline]
     pub fn is_autoneg_enabled(&self) -> bool {
-        // TODO: the code to access to the bit field will be replaced with automatically
-        // generated code by bindgen when it becomes possible.
-        // SAFETY: The struct invariant ensures that we may access
-        // this field without additional synchronization.
-        let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
-        bit_field.get(13, 1) == u64::from(bindings::AUTONEG_ENABLE)
+        let phydev = self.0.get().cast_const();
+        // SAFETY: By the type invariant of `Device`, `phydev` points to a valid
+        // `struct phy_device`, and the caller is in a context where this access
+        // is safe. The bindgen raw accessor does not create a Rust reference to
+        // the C struct.
+        let autoneg = unsafe { bindings::phy_device::autoneg_raw(phydev) };
+        autoneg == bindings::AUTONEG_ENABLE
     }
 
     /// Gets the current auto-negotiation state.
     ///
     /// It returns true if auto-negotiation is completed.
+    #[inline]
     pub fn is_autoneg_completed(&self) -> bool {
-        const AUTONEG_COMPLETED: u64 = 1;
-        // TODO: the code to access to the bit field will be replaced with automatically
-        // generated code by bindgen when it becomes possible.
-        // SAFETY: The struct invariant ensures that we may access
-        // this field without additional synchronization.
-        let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
-        bit_field.get(15, 1) == AUTONEG_COMPLETED
+        let phydev = self.0.get().cast_const();
+        // SAFETY: By the type invariant of `Device`, `phydev` points to a valid
+        // `struct phy_device`, and the caller is in a context where this access
+        // is safe. The bindgen raw accessor does not create a Rust reference to
+        // the C struct.
+        let completed = unsafe { bindings::phy_device::autoneg_complete_raw(phydev) };
+        completed == 1
     }
 
     /// Sets the speed of the PHY.

base-commit: 2709dd5ae32f0828f386327c76bba9f39f63a1c6
-- 
2.43.0

