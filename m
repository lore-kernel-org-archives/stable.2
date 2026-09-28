Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C1A3F483C
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 10:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790592202; cv=none; b=BMaPRlxHtcgXxihkzc+ER9EK4v6kJkDhqvwIP70jtEqn3lw55BD+eH0VyZmI7KNGjx505f7NNRdIDrCmUDROt8j+lLGgWPFPOV7M/xO9MBwwtp9z7BhZ9t2CgqMCc5qtF4BLromabYC2nUfFf1IWna+6goyTZPzm+XiAxf9Qjhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790592202; c=relaxed/simple;
	bh=qLdvuVU5cWXqAE/f5tSEAmod7vvXA2Lq8flalGy9smg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DsCS3QzydlNHvKaOdSumBQXPEwxIPHU0Lf5EDtVn7KVom3XRWk6BlV4Ezc/lDr9zro6NdQU2d4v3h9S5ZEcsVQrMIKGroqYfDB0QMyKbglf/QPBE20dyZNUqFql0al3YmEWtqI2ZhoN1b67QtplYxYHZwV+eFcMXDVFmDqAVdYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NO7NcglY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NO7NcglY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A335F1F000FF;
	Mon, 28 Sep 2026 10:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790592200;
	bh=OQfL5DR72P2jDW3XP9rkBKsulD4VIQrhTUlgJY5Chss=;
	h=From:To:Cc:Subject:Date;
	b=NO7NcglY79kRhtqhkDySiVSmm5NECj9D4+Z9ZfC202lVEVdOW5pmRBkKUvMuvgQ5U
	 A1XtfygRuxk9x2qrel3vzmfzkjjEPoMIEBsah2v/l//Pa0IiWYVnKv+f+R1BlEjNiR
	 MR185BlDSMrBFDGO/i2eYjKSLBaxUvhTJ2U+pSkz3Xpe852tkxmivDcRHbdiEEnTjO
	 eT1C/aS4+86Ra34NrBeTR2+Zr+XB45oqCnfn/8baMrGbFuZGYm6UVumeSns25Vo5WK
	 a4o1tWl669hfYSOVbcYkusOust/lH4PXJXJoscIPsxFJsEr6r6mTug9Srqb2UZ2wsB
	 he+WShf9zfhuw==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Chunfeng Song <springbreeze@stu.pku.edu.cn>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 1/2] Revert "rust: net: phy: fix off-by-one bit positions in device status accessors"
Date: Mon, 28 Sep 2026 12:43:12 +0200
Message-ID: <20260928104313.204453-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 3267aea7cdd5d5c8851718b148cd25ff1a5374ac.

It was not meant to be backported before 7.1.y -- its tag said:

  Cc: stable@vger.kernel.org # Only 7.1.y and later (requires bindgen's raw pointer accessors).

Cc: Chunfeng Song <springbreeze@stu.pku.edu.cn>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/stable/SEWP216MB9770116738884C46F156A686FAF98D2@SEWP216MB977011.KORP216.PROD.OUTLOOK.COM/
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/net/phy.rs | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 1d17bf1ae87d..bf6272d87a7b 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -123,37 +123,39 @@ pub fn state(&self) -> DeviceState {
     /// Gets the current link state.
     ///
     /// It returns true if the link is up.
-    #[inline]
     pub fn is_link_up(&self) -> bool {
-        let phydev = self.0.get().cast_const();
-        // SAFETY: By the type invariant of `Device`, `phydev` points to a valid
-        // `struct phy_device`, and there is no concurrent write to this field.
-        let link = unsafe { bindings::phy_device::link_raw(phydev) };
-        link == 1
+        const LINK_IS_UP: u64 = 1;
+        // TODO: the code to access to the bit field will be replaced with automatically
+        // generated code by bindgen when it becomes possible.
+        // SAFETY: The struct invariant ensures that we may access
+        // this field without additional synchronization.
+        let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
+        bit_field.get(14, 1) == LINK_IS_UP
     }
 
     /// Gets the current auto-negotiation configuration.
     ///
     /// It returns true if auto-negotiation is enabled.
-    #[inline]
     pub fn is_autoneg_enabled(&self) -> bool {
-        let phydev = self.0.get().cast_const();
-        // SAFETY: By the type invariant of `Device`, `phydev` points to a valid
-        // `struct phy_device`, and there is no concurrent write to this field.
-        let autoneg = unsafe { bindings::phy_device::autoneg_raw(phydev) };
-        autoneg == bindings::AUTONEG_ENABLE
+        // TODO: the code to access to the bit field will be replaced with automatically
+        // generated code by bindgen when it becomes possible.
+        // SAFETY: The struct invariant ensures that we may access
+        // this field without additional synchronization.
+        let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
+        bit_field.get(13, 1) == u64::from(bindings::AUTONEG_ENABLE)
     }
 
     /// Gets the current auto-negotiation state.
     ///
     /// It returns true if auto-negotiation is completed.
-    #[inline]
     pub fn is_autoneg_completed(&self) -> bool {
-        let phydev = self.0.get().cast_const();
-        // SAFETY: By the type invariant of `Device`, `phydev` points to a valid
-        // `struct phy_device`, and there is no concurrent write to this field.
-        let completed = unsafe { bindings::phy_device::autoneg_complete_raw(phydev) };
-        completed == 1
+        const AUTONEG_COMPLETED: u64 = 1;
+        // TODO: the code to access to the bit field will be replaced with automatically
+        // generated code by bindgen when it becomes possible.
+        // SAFETY: The struct invariant ensures that we may access
+        // this field without additional synchronization.
+        let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
+        bit_field.get(15, 1) == AUTONEG_COMPLETED
     }
 
     /// Sets the speed of the PHY.

base-commit: 1b357ecb321392158d507b04672ffee57bfa071d
-- 
2.55.0

