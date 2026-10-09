Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F3D34D3A9;
	Fri,  9 Oct 2026 06:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791525820; cv=none; b=JqSpKY8x0TnB9uZFdAHvavrJfXzE+1ML9dxU3W8PMLanMgx4toPjJkgP08840RolM7EUNqeiaCu+ha5J0ZkzqRxCyFFQFk/CTMOAUe9Ym2+tbGx3Y7zL9p2jGg2wxMZByPoVxneFVRnpNf81dV+eq/sgW7WYybe0mxfPFEN1nxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791525820; c=relaxed/simple;
	bh=UPcpj0lzzZ784a1sSVDTA4YxtDPuGbq1/JtK0m1uEXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Et23jCL6sNDeuUGZIdTlYJdw75ZbeK1GI01MIwK6TfjgrkOYKeZDy25vrEvGsQwEaJrnau73V1kJUlmQEq4t5+6qbJHXsHEkh9fgP9V4XMZO49+z3TlCkpfa4IZ9i2WFINtOGAJ+pJB1+A9h7sWv1rR0j91x251buyOwaY4HGuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=I5N8O7m8; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="I5N8O7m8"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 506751e3b;
	Fri, 9 Oct 2026 14:03:31 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] wifi: ath11k: initialize CFR locks before capability checks
Date: Fri,  9 Oct 2026 14:03:26 +0800
Message-Id: <20261009060326.1162818-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa11f4276de03a1kunm636de93c439e5e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTx9CVh9NGR4eTx8dTEsYHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=I5N8O7m89N49fSkTuU1Rw3Ra8D3ISfIklA+9xG9AK+5MOEUx1izlNnKb8ZZ93cldkV7im3/Cm+vbl2u28gN6e6g2knEGrx5p6s8w5P+GP60UP8RvLGQ7+Q9XnwOpAUw3fZMxOqRGGePX+KjXjTjbHFVbm1HHxBDhq6UHwhMJD44=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=XnvNFscABF4xXX7FDvlAv4KYOnQuQ7419R+Zi6Stu/4=;
	h=date:mime-version:subject:message-id:from;

ath11k_cfr_init() returns before initializing cfr->lock when CFR
capability is absent.  However, station removal still calls
ath11k_cfr_decrement_peer_count(), which unconditionally takes this
lock.  This leaves a production path using an uninitialized spinlock.

Initialize cfr->lock for every radio before the capability check.  Keep
the CFR ring and lookup-table lock initialization conditional, since
those objects are only used after CFR capability setup.

Fixes: 9b2e3b4ebec7 ("wifi: ath11k: Add initialization and deinitialization sequence for CFR module")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/net/wireless/ath/ath11k/cfr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/cfr.c b/drivers/net/wireless/ath/ath11k/cfr.c
index a91f25fb6..0708ca28b 100644
--- a/drivers/net/wireless/ath/ath11k/cfr.c
+++ b/drivers/net/wireless/ath/ath11k/cfr.c
@@ -956,6 +956,9 @@ int ath11k_cfr_init(struct ath11k_base *ab)
 	struct ath11k *ar;
 	int i, ret;
 
+	for (i = 0; i < ab->num_radios; i++)
+		spin_lock_init(&ab->pdevs[i].ar->cfr.lock);
+
 	if (!test_bit(WMI_TLV_SERVICE_CFR_CAPTURE_SUPPORT, ab->wmi_ab.svc_map) ||
 	    !ab->hw_params.cfr_support)
 		return 0;
@@ -971,7 +974,6 @@ int ath11k_cfr_init(struct ath11k_base *ab)
 
 		idr_init(&cfr->rx_ring.bufs_idr);
 		spin_lock_init(&cfr->rx_ring.idr_lock);
-		spin_lock_init(&cfr->lock);
 		spin_lock_init(&cfr->lut_lock);
 
 		num_lut_entries = min_t(u32, CFR_MAX_LUT_ENTRIES, db_cap.min_elem);
-- 
2.34.1
