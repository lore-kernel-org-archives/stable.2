Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D679396B96;
	Mon,  6 Jul 2026 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348517; cv=none; b=iHBOLR1KAaHtIBSo8gElu+MjZN+wDYOBhj27r4QVRc35Mg+M96UHSfkcD334KfJ8wWRDpJ3S/a5Pb/6ytuqSR2xlxJIjjF0Tq1Xz+KWh2tpEILucUZcraNIKVQf0FRUbC4aJ6kPeOinjhBISUpx2fh7dNBQqKH+akFYQSj8vjUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348517; c=relaxed/simple;
	bh=4F0t9tMEaIPGqcVTtmvenupHShLJJbuFGi7mGhK0ASA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VCP44k7w7owtRg/m/B8X9G5KnLMFB6zEBJRBEMeGIuKCwftu6wSStA0YZobxLDsaX9X23X2h8jYiPvlcNJRIQZ4dWhZ1TKKk3wqDd+dFjxRn7uSe3bd26gdUYjThm+n4i6Ef3yzK+PWJUDwEPZZHHZbzhRPS3R/qNcpMn1A4cm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=e9XCf2T/; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="e9XCf2T/"
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4517f187e;
	Mon, 6 Jul 2026 22:35:11 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zilin@seu.edu.cn,
	jianhao.xu@seu.edu.cn,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH net v3] wifi: mac80211: fix memory leak in ieee80211_register_hw()
Date: Mon,  6 Jul 2026 22:35:07 +0800
Message-Id: <20260706143507.146131-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f37dac42b03a2kunmbf09ac2e9d08
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaT01CVkxMHR9JTUoeGhkaH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=e9XCf2T/gFtnBaQdPOqw8jqNH66857WHPYq+iKYRmWwxgyG9Ylr5Excsw4s7lq99L6NGCiglbjYinqabIbCcMA+sGYjmtuKdzWRUxZWAEPHq0TRBKdrLqJGpWMggJK3IycpP/zTxmAuWjZIElrwiwpc78Xn3X3Zgh1Vi0WHDIj4=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=WdDOioI8rPhiWLQkwtaCHSf6DCVQkz/dGDGkJ/THM1w=;
	h=date:mime-version:subject:message-id:from;

If kmemdup() fails while copying supported band structures, the error
path jumps to fail_rate. This skips rate_control_deinitialize() and
leaks the initialized local->rate_ctrl.

Fix this by adding a fail_band label that shares the rate-control cleanup
path before falling through to the remaining teardown.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still present in
v7.1-rc7.

An x86_64 allyesconfig build showed no new warnings. As we do not have a
suitable mac80211 device/driver combination to test with, no runtime
testing was able to be performed.

Fixes: 09b4a4faf9d0 ("mac80211: introduce capability flags for VHT EXT NSS support")
Cc: stable@vger.kernel.org
Reviewed-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
---
Changes in v3:
- Replace Zilin Guan's Signed-off-by with Reviewed-by.

Changes in v2:
- Add a fail_band label for the band-copy failure path instead of jumping
  directly to fail_wiphy_register.

 net/mac80211/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index f47dd58770ad..dba66dd964af 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1599,7 +1599,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 		sband = kmemdup(sband, sizeof(*sband), GFP_KERNEL);
 		if (!sband) {
 			result = -ENOMEM;
-			goto fail_rate;
+			goto fail_band;
 		}
 
 		wiphy_dbg(hw->wiphy, "copying sband (band %d) due to VHT EXT NSS BW flag\n",
@@ -1675,6 +1675,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 #endif
 	wiphy_unregister(local->hw.wiphy);
  fail_wiphy_register:
+ fail_band:
 	rtnl_lock();
 	rate_control_deinitialize(local);
 	ieee80211_remove_interfaces(local);
-- 
2.34.1

