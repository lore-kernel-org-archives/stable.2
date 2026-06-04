Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D343E288C0E;
	Thu,  4 Jun 2026 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780584202; cv=none; b=Z4jWX8sG8brJ+RfD3qcHQjK0fsQ2zKyLnDqekbrDRGwHi45EURG3FpethA34aNIc/L2T2UMyTqMczJSHbAXgbPEoAQgkaF8n005f8OBHuX4AC5ZyAVocDJGr3rQdzIXUfKnOgzNYUtZxVBhtLIs9i3C5FIs6i8tTYiZon//V0Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780584202; c=relaxed/simple;
	bh=zFXKxV8PV09ukgk5AcTN+B8SLF81D1YK82zYG03BUiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mAmodZa2Zd8fC5jTYHYq3jzOliQpUy67EYUWX7QMScXRA4mI+wix1+IsSRB3DAEhFwfKAuXHqFy/HyyVLW7N0hD6UaV+zt/ZVpeHgCSgndSYEDFumnmCZKcI9LvNv65ZEyvaV06K0/jQMWGsOhWIJgM4PlZgVsK9xal5CI5tPdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=QP+UKjwU; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="QP+UKjwU"
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4118c9fb2;
	Thu, 4 Jun 2026 22:37:59 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: sgoutham@marvell.com
Cc: lcherian@marvell.com,
	gakula@marvell.com,
	hkelam@marvell.com,
	sbhatta@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	stable@vger.kernel.org,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH net] octeontx2-af: fix memory leak in rvu_setup_hw_resources()
Date: Thu,  4 Jun 2026 22:37:56 +0800
Message-Id: <20260604143756.1524482-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e9311d26403a2kunm6ee3c7d3f856
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGBkYVhlDSEJPTElOTB1CQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=QP+UKjwUFQJAhO5paIRWAr7ibrS3PQGMFfOpsZhYxSdJt3LKWvgwfnZllo4EBfXNbEiA6Ha6VWbD22S2f9eovBmFAcUvFAalIiKG622Pz/PNN1zW0s3iQTCzROuFpax2aDkV9IIzLa6lUy8mW0EpAPcn/wtwO71HWm0K+ZTkphA=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=Odj9dCusSKWao/ee6DU5EJh6KDZ8sgDM1xybewGsQwY=;
	h=date:mime-version:subject:message-id:from;

If rvu_npc_exact_init() fails in rvu_setup_hw_resources(), the function
returns directly instead of jumping to the error handling path. This
causes a resource leak for the previously initialized CGX, NPC, fwdata,
and MSI-X states.

Fix this by replacing the direct return with goto cgx_err to ensure
proper cleanup.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still present in
v7.1-rc6.

An x86_64 allyesconfig build showed no new warnings. As we do not have
access to Marvell OcteonTX2 RVU AF hardware to test with, no runtime
testing was able to be performed.

Fixes: 3571fe07a090 ("octeontx2-af: Drop rules for NPC MCAM")
Cc: stable@vger.kernel.org
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 3cf131508ecf..6e907ee19164 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -1160,7 +1160,7 @@ static int rvu_setup_hw_resources(struct rvu *rvu)
 	err = rvu_npc_exact_init(rvu);
 	if (err) {
 		dev_err(rvu->dev, "failed to initialize exact match table\n");
-		return err;
+		goto cgx_err;
 	}
 
 	/* Assign MACs for CGX mapped functions */
-- 
2.34.1
