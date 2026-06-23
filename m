Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE0A3D4131;
	Tue, 23 Jun 2026 11:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782215053; cv=none; b=GJXocgIxqmMpnAov4v7fy7ZTDw036K9iaudk+Dk6urTLfdvo5OgCqEPpORZ2x3sOXA5URoA1+GLspw9Y2ECkgMocp89vNCuodrrM4JryOL82FHT+CXCKM3Y8YvzimCskUwdwk7sieKZXRWqBzkhR22ucgO9l4x9mP9pZZsFMoH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782215053; c=relaxed/simple;
	bh=KPAmj7aDGiKAZkKcPtUk6oRSaJpQQF75AYEbE9S2gDg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e9CqJiFgMoIAFtAtMZFvk8+dmcgvOBsBaM5HyFK7RotCceZYLy9YI84XgS55Vdjn37xH5gSxPxkrzxwjRHUk8pEjZkALkxHF+TG7FdTcntNW397VaPxFHbDX101eltKdGe+cAK0TrGPwrxzgrvv9G93UIFS4bcdH6loHjLxBwWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=W68ccqO2; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="W68ccqO2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=gv
	ybHwrlSJJexIpk2JiGbmml9pbb9SZAyfP6bmqjPAA=; b=W68ccqO2n/q/NT6dSU
	VM+Z9vc5DFbT/xz5agy6RTsaGwxyiarjpZ0Y8TBtbv30aajqzRbQL+ON3560lRJ9
	Ul4nf1WK7PZy+RJyzSv+e2AH27tN2jOjaqkoGjph6xzzvbDs8dHL3ZnlTmEClqLt
	3vo/7HPb4BZfdysgInMiWAEGg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDn7_JVcTpqE0LjFA--.8026S2;
	Tue, 23 Jun 2026 19:43:18 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: sgoutham@marvell.com,
	lcherian@marvell.com,
	gakula@marvell.com,
	hkelam@marvell.com,
	sbhatta@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] octeontx2-af: Free BPID bitmap on setup failure
Date: Tue, 23 Jun 2026 19:43:16 +0800
Message-Id: <20260623114316.2182271-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn7_JVcTpqE0LjFA--.8026S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFyxXF1fZFWrKw17trykAFb_yoW8WrWfpF
	4jy34rAa40qFyfuw17tw40vay5Ca9FgrWUKFyxZ3WrZ3Wftr4kuFZYkF1Fvr4FkF97Cr1j
	yF1Fy3W3CFyDArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pitCztUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxRaaCWo6cVY6mwAA3W

nix_setup_bpids() allocates bp->bpids with rvu_alloc_bitmap(), which uses
a plain kcalloc(). If any of the following devm_kcalloc() allocations for
the BPID mapping arrays fails, the function returns without freeing the
bitmap. Free the BPID bitmap before returning from those error paths.

Fixes: d6212d2e41a0 ("octeontx2-af: Create BPIDs free pool")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index d8989395e875..0297c7ab0614 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -528,19 +528,24 @@ static int nix_setup_bpids(struct rvu *rvu, struct nix_hw *hw, int blkaddr)
 	bp->fn_map = devm_kcalloc(rvu->dev, bp->bpids.max,
 				  sizeof(u16), GFP_KERNEL);
 	if (!bp->fn_map)
-		return -ENOMEM;
+		goto free_bpids;
 
 	bp->intf_map = devm_kcalloc(rvu->dev, bp->bpids.max,
 				    sizeof(u8), GFP_KERNEL);
 	if (!bp->intf_map)
-		return -ENOMEM;
+		goto free_bpids;
 
 	bp->ref_cnt = devm_kcalloc(rvu->dev, bp->bpids.max,
 				   sizeof(u8), GFP_KERNEL);
 	if (!bp->ref_cnt)
-		return -ENOMEM;
+		goto free_bpids;
 
 	return 0;
+
+free_bpids:
+	rvu_free_bitmap(&bp->bpids);
+	bp->bpids.bmap = NULL;
+	return -ENOMEM;
 }
 
 void rvu_nix_flr_free_bpids(struct rvu *rvu, u16 pcifunc)
-- 
2.25.1

