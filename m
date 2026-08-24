Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6539A4078F2;
	Mon, 24 Aug 2026 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569970; cv=none; b=evOsEWFnZTsTBx54PpT8s7E8CkKIpMAl+MjKVoop/sC0i/oCaMrwWUKIiMF6udOQydJmBN9TZZlhWKgGyGNza9uaaHDTp2FNtTgthjak3XoWMSuLIcYHdEhIFil5wBP+M2r+uCjPnI0OxNMCQAruSzxOveBwmQo/p1Om8djt0GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569970; c=relaxed/simple;
	bh=/cDpNBI8QAo1xpq5qh/KR4JYynGqcMbb1DRR4SXXpeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RCX1wxX1pPn4EXeUfnKBvxsDFzwe58nB/FcxaLwKYSYwfN/4knq7v36nfpc9qaipVjZrty8qa1N2Rr+MTgSWo+KvPnltNMzrfK2KwQk8jr5ngbBEPqEGzO0Qbks5FiIZ6ngaqouxxlY6R8qUU0CJVdwTGPwKP88mByN02HDjAcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn; spf=pass smtp.mailfrom=stu.pku.edu.cn; dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b=XKijV0VC; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b="XKijV0VC"
Received: from localhost.localdomain (unknown [106.120.124.5])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4b1905341;
	Mon, 24 Aug 2026 19:12:28 +0800 (GMT+08:00)
From: Chunfeng Song <springbreeze@stu.pku.edu.cn>
To: rust-for-linux@vger.kernel.org
Cc: netdev@vger.kernel.org,
	fujita.tomonori@gmail.com,
	ojeda@kernel.org,
	boqun@kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net v2] rust: net: phy: fix off-by-one bit positions in device status accessors
Date: Mon, 24 Aug 2026 11:12:27 +0000
Message-ID: <20260824111227.742645-1-springbreeze@stu.pku.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa03378c60003a1kunm2529f798225b48
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDS08eVkIeHUlLThlIHhlPS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS01VSklLVUpJT1VOWVdZFhoPEhUdFFlBWU9LSFVKS0lITk
	NDVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=XKijV0VCjdZLw5rcEREbPzZXg47js6PRUbpjR9J2737ZWPfLKxIVvDxjubGclJHeALa1WKRZvjW0UKv1Fape6oSO/7dVX9ghRRYnmd95xh8I9s1WLJ9rFsGMWSGQD/yVVrzhtOduc/Njz82Mmv+3QDz+Fg53RXhrANW3SZ5CpZY=; c=relaxed/relaxed; s=default; d=stu.pku.edu.cn; v=1;
	bh=mN5iARVj62JTOu4zgqljWUW5Ok3e/Z4K8CwjCF/LObU=;
	h=date:mime-version:subject:message-id:from;

The hand-written bitfield offsets in is_link_up(), is_autoneg_enabled()
and is_autoneg_completed() were correct when the abstraction was
merged: at that time autoneg, link, and autoneg_complete were at bits
13, 14, and 15 of struct phy_device's first bitfield unit. Commit
2796ff1e3dca ("net: phy: add flag is_genphy_driven to struct
phy_device") later inserted is_genphy_driven just before autoneg,
shifting the three fields up by one, so the accessors now read:

  is_link_up()           reads bit 14 = autoneg
  is_autoneg_enabled()   reads bit 13 = is_genphy_driven
  is_autoneg_completed() reads bit 15 = link

The official ax88796b Rust driver uses all three accessors in its
link-change handling, so it inherits the bug. On genphy-driven devices
is_genphy_driven is always 1, which masks the broken
is_autoneg_enabled() check.

Hard-coded offsets will silently break again on the next layout
change, so use the bindgen-generated accessors (link(), autoneg(),
autoneg_complete()), which are always consistent with the C layout,
and drop the hand-written numbers together with the TODO comment that
marked them as a stopgap.

Found by a static equivalence audit (C2RustDrv, a C-to-Rust driver
migration tool) that compares hand-written bitfield offsets against
the bindgen layout of struct phy_device. Verified by building the
bindings and checking the generated accessors; no runtime testing was
possible without PHY hardware.

Fixes: 2796ff1e3dca ("net: phy: add flag is_genphy_driven to struct phy_device")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/netdev/20231123050412.1012252-1-fujita.tomonori@gmail.com/ # v8 cover letter
Link: https://lore.kernel.org/rust-for-linux/20260823103644.342849-1-springbreeze@stu.pku.edu.cn/ # v1
Signed-off-by: Chunfeng Song <springbreeze@stu.pku.edu.cn>
---
 rust/kernel/net/phy.rs | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 956cda573ddb..14dd1e6cb380 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -124,38 +124,30 @@ pub fn state(&self) -> DeviceState {
     ///
     /// It returns true if the link is up.
     pub fn is_link_up(&self) -> bool {
-        const LINK_IS_UP: u64 = 1;
-        // TODO: the code to access to the bit field will be replaced with automatically
-        // generated code by bindgen when it becomes possible.
+        let phydev = self.0.get();
         // SAFETY: The struct invariant ensures that we may access
         // this field without additional synchronization.
-        let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
-        bit_field.get(14, 1) == LINK_IS_UP
+        unsafe { (*phydev).link() == 1 }
     }
 
     /// Gets the current auto-negotiation configuration.
     ///
     /// It returns true if auto-negotiation is enabled.
     pub fn is_autoneg_enabled(&self) -> bool {
-        // TODO: the code to access to the bit field will be replaced with automatically
-        // generated code by bindgen when it becomes possible.
+        let phydev = self.0.get();
         // SAFETY: The struct invariant ensures that we may access
         // this field without additional synchronization.
-        let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
-        bit_field.get(13, 1) == u64::from(bindings::AUTONEG_ENABLE)
+        unsafe { (*phydev).autoneg() == bindings::AUTONEG_ENABLE }
     }
 
     /// Gets the current auto-negotiation state.
     ///
     /// It returns true if auto-negotiation is completed.
     pub fn is_autoneg_completed(&self) -> bool {
-        const AUTONEG_COMPLETED: u64 = 1;
-        // TODO: the code to access to the bit field will be replaced with automatically
-        // generated code by bindgen when it becomes possible.
+        let phydev = self.0.get();
         // SAFETY: The struct invariant ensures that we may access
         // this field without additional synchronization.
-        let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
-        bit_field.get(15, 1) == AUTONEG_COMPLETED
+        unsafe { (*phydev).autoneg_complete() == 1 }
     }
 
     /// Sets the speed of the PHY.
-- 
2.43.0

