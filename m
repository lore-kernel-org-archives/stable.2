Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1E030D3E8;
	Thu, 10 Sep 2026 05:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789019481; cv=none; b=E1Tfgt1Ch9GSc1rWhNHWWoMsq37yNe+rgpJoKlqCuJT+45my3iV58rE78tJrpdx9N8Px/NMcNLc00Am1AO0cp6a7e4pvmZhW/xUaJYxF8fNthNlkYyLflsuBgVYPw0SoUrDeqcrAa7YmA5H4eDnap1URvGlpY5FwmQNwveqiEgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789019481; c=relaxed/simple;
	bh=sthCcF/sNcApycehZxI7ySnbqcrCrh0oGJyrDEjPzBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BlE8InLY35QESJRCMZhNg6z5HnRzkYzJGm7LmXoqWMI8uqp67KqMCIsJnhkEQG97Cm/rV4UAPlnhyNGaV7xg1Jw+G/9xinl8BQcNmOo9baib6dRm+vBLkouD+i/cnncyV0CQoZ6p+83Jjn+vYcgUtXXSGjXP+C1WSvuSRFA1Qe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn; spf=pass smtp.mailfrom=stu.pku.edu.cn; dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b=Wj8YiKOP; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b="Wj8YiKOP"
Received: from localhost.localdomain (unknown [106.120.124.5])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d3b9ec9e;
	Thu, 10 Sep 2026 13:51:11 +0800 (GMT+08:00)
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
Subject: [PATCH net v6] rust: net: phy: fix off-by-one bit positions in device status accessors
Date: Thu, 10 Sep 2026 05:51:10 +0000
Message-ID: <20260910055110.167110-1-springbreeze@stu.pku.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa089debb8a03a1kunm6d76624b183ffd
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHRgfVk0ZHkpDSh5KTkwZH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS01VSklLVUpJT1VOWVdZFhoPEhUdFFlBWU9LSFVKS0hKTk
	xOVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
	b=Wj8YiKOPXqB4zVdj+jjmflh7zDwuYvbPgBycoMa610oPr2BTqunN1MX93MDinxk9VOgDMOAraNmQC031He5O3n0HE2edhQPJ4ppVBDFDftexiTCDl/hAxNgVcrvYNXfu4GrgiOzRAlWN2PQUnYKq9JEnFn8DO0UAY8dW2cxxMHg=; c=relaxed/relaxed; s=default; d=stu.pku.edu.cn; v=1;
	bh=rhEO/9fD+Arvx5VJ3IVK2ueO7ZfQCkmPusDExwKpZFQ=;
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
---
v6:
  - Name read_status() instead of the vague "link-change handling" in
    the commit message (FUJITA Tomonori).
  - Correct the impact description: on ax88796b, which has its own
    driver, is_genphy_driven stays 0, so the broken is_autoneg_enabled()
    always returns false and read_status() never reaches the
    resolve_aneg_linkmode() call (FUJITA Tomonori).
  - Rewrite the SAFETY comments to state why the raw accessors may be
    called: the pointer is valid and there is no concurrent write to the
    field (FUJITA Tomonori).

v5: https://lore.kernel.org/r/20260901143251.136378-1-springbreeze@stu.pku.edu.cn/
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
 rust/kernel/net/phy.rs | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 956cda573ddb..c4e7b1d6c6f4 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -123,39 +123,37 @@ pub fn state(&self) -> DeviceState {
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
+        // `struct phy_device`, and there is no concurrent write to this field.
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
+        // `struct phy_device`, and there is no concurrent write to this field.
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
+        // `struct phy_device`, and there is no concurrent write to this field.
+        let completed = unsafe { bindings::phy_device::autoneg_complete_raw(phydev) };
+        completed == 1
     }
 
     /// Sets the speed of the PHY.

base-commit: 2709dd5ae32f0828f386327c76bba9f39f63a1c6
-- 
2.43.0

