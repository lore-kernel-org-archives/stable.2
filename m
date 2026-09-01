Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1DC44236B;
	Tue,  1 Sep 2026 03:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788232724; cv=none; b=jImh/MRbJBi1l3zL/cN/I11+31fY9FZw5N0tdiTTAAQJHNq3gHeTthenmsSOsR/in9+7yWN67m89W801UnQ+cOkLT3Dtgn4uATvu4tpqjBMV65+zJgyLNSQ0jS81/g15JglGuyvx9/TwkqLXnke3Jxi552BOWtA/bM6oxG04DmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788232724; c=relaxed/simple;
	bh=AlLd8VzesRJb0sPZHinVMShBq9DoqHCiOZF92vBBQxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k6nX5ijl0BS0JGz3H3Y3c3bifiSPh88/5fbqE3YWiX0Tf2lV2aHgTtCcTvNwkRKNE8MZsnL8yuBUs3vLE90bOywldC4Mb/LkrM0JtdpG9GGuQcC96WtFALSXoh6JLZaSNmGWBjYWvc3R6OD9j18fZ3zrHCCL9QTBfQmvJSWDeeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn; spf=pass smtp.mailfrom=stu.pku.edu.cn; dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b=UVl8X8Y0; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b="UVl8X8Y0"
Received: from localhost.localdomain (unknown [106.120.124.5])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c0a8eb6c;
	Tue, 1 Sep 2026 11:18:29 +0800 (GMT+08:00)
From: Chunfeng Song <springbreeze@stu.pku.edu.cn>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	fujita.tomonori@gmail.com,
	kuba@kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net v4] rust: net: phy: fix off-by-one bit positions in device status accessors
Date: Tue,  1 Sep 2026 03:18:24 +0000
Message-ID: <20260901031824.1377498-1-springbreeze@stu.pku.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa05af9b2e903a1kunm6d567a69154752
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaT0IYVkpJTR8eS0xCSk5ISlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS01VSklLVUpJT1VOWVdZFhoPEhUdFFlBWU9LSFVKS0lITk
	NDVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=UVl8X8Y0sXYhEPCBkIw/fUf2i4/abc/ythzwgdJxmQj/PzZbB3CKJNiGt+9eRwmhMLZi3YPdRLw6N2ofRfSy5tkXETa7uFReNP6cDjB44N0bLe4JxznWZJFTXMAcxCZOPzzzYPpmm1zR/QHQQI1V7/XdsSK/nd1Aq3/EQTXEELo=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=p7rrGaXT4UeoPTJFL5EF1bpXNENSKM4jFfB8RlGEIK4=;
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

Found by a static equivalence audit (C2RustDrv, a C-to-Rust driver
migration tool) that compares hand-written bitfield offsets against
the bindgen layout of struct phy_device. Verified by building the
bindings and checking the generated accessors; no runtime testing was
possible without PHY hardware.

Fixes: 2796ff1e3dca ("net: phy: add flag is_genphy_driven to struct phy_device")
Cc: stable@vger.kernel.org
Signed-off-by: Chunfeng Song <springbreeze@stu.pku.edu.cn>
---
v4:
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
 rust/kernel/net/phy.rs | 43 ++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 956cda573ddb..3f1c1637f027 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -123,39 +123,42 @@ pub fn state(&self) -> DeviceState {
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
+        unsafe { bindings::phy_device::link_raw(phydev) == 1 }
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
+        unsafe {
+            bindings::phy_device::autoneg_raw(phydev) == bindings::AUTONEG_ENABLE
+        }
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
+        unsafe { bindings::phy_device::autoneg_complete_raw(phydev) == 1 }
     }
 
     /// Sets the speed of the PHY.

base-commit: 2709dd5ae32f0828f386327c76bba9f39f63a1c6
-- 
2.43.0

