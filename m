Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFB6332EA7
	for <stable@vger.kernel.org>; Sat, 30 May 2026 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780159925; cv=none; b=oj5I+laPY+710pRqd4inpksNGqlc5x2eGGW/wTodF7Br5wRAweAOqcEUuBT4STo+TsxJ8fY03Mrcd+ZB7laREG/d1EIVOIlM+GkSMpuCVSIzSnsaGGK5NPyglk0s4gBLQlbYE0KwZJMGQV5VqDpiEtvAL85Kq1jrqgqrEaaMphc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780159925; c=relaxed/simple;
	bh=OhWvF8qh2mc0vvP+amlmBruNLjcNHse3CyBRliuR6B4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iz3XzwhofPTJkzhNMiB7NdW3LmP5zYkIMSk93ZfCKfpcKgEmkSG89m9TaB26a/XUN7UpPgsfI6s4osPGv4gGHkvY4RZCUqpDsTB5DHsg3Zbb62K87uSP9lqtVc048msH8Zdf9GKCdkrK60tFhCoHUyaT9VAnq9T1eNDaniqxVZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2rLwfJp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2rLwfJp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3741F00893;
	Sat, 30 May 2026 16:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780159924;
	bh=mS47IlW9zaw7mLnYGdIzvaJoiEcBZFC/QRw/cW8WpqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J2rLwfJpuZCtcw0dqO5YPs47tXmH9xVxS34Fca7YSB3pAFOrBksoqjbia81601hAw
	 QvaHLmUVGODNN1QJEA3o8bKhiIDdi82B0zXTBXr6h+gMSaPQCxN4ghlHjgjyyA9lBW
	 lZiWTHcVNOiNRAGUDUljfuLWl2lkkM/QxIMuGjdSr1jHA6qlo4Ia4idLBsgT0hd7ec
	 nRiqCikRFEwbrh7qkn5xtqCCQBOgKOYJ3+O6o7bcfio3kmVqXkBQOBKIuYOhwGnDt1
	 KBD49hHfFPO6g6TYnUd44HGt5D5saSIi4+l3x1FXYTTu2UbUc9uW/aPerPh3KsG2Wv
	 hCHSOv+ut5FjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dawei Feng <dawei.feng@seu.edu.cn>,
	Zilin Guan <zilin@seu.edu.cn>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] octeontx2-pf: avoid double free of pool->stack on AQ init failure
Date: Sat, 30 May 2026 12:52:02 -0400
Message-ID: <20260530165202.3003654-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052841-plot-polyester-9f3b@gregkh>
References: <2026052841-plot-polyester-9f3b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dawei Feng <dawei.feng@seu.edu.cn>

[ Upstream commit 9b244c242bec48b37e82b89787afd6a4c43457e1 ]

otx2_pool_aq_init() frees pool->stack when mailbox sync or retry
allocation fails, but leaves the pointer unchanged. Later,
otx2_sq_aura_pool_init() unwinds the partial setup through
otx2_aura_pool_free(), which frees pool->stack again. The CN20K-specific
cn20k_pool_aq_init() implementation has the same bug in
its corresponding error path.

Set pool->stack to NULL immediately after the local free so the shared
cleanup path does not free the same stack again while cleaning up
partially initialized pool state.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still present in
v7.1-rc3.

Runtime validation was not performed because reproducing this path
requires OcteonTX2/CN20K hardware.

Fixes: caa2da34fd25 ("octeontx2-pf: Initialize and config queues")
Fixes: d322fbd17203 ("octeontx2-pf: Initialize cn20k specific aura and pool contexts")
Cc: stable@vger.kernel.org
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260515151826.1005397-1-dawei.feng@seu.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 902d6abaa3ec1..062bc899d9550 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1468,11 +1468,13 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
 		err = otx2_sync_mbox_msg(&pfvf->mbox);
 		if (err) {
 			qmem_free(pfvf->dev, pool->stack);
+			pool->stack = NULL;
 			return err;
 		}
 		aq = otx2_mbox_alloc_msg_npa_aq_enq(&pfvf->mbox);
 		if (!aq) {
 			qmem_free(pfvf->dev, pool->stack);
+			pool->stack = NULL;
 			return -ENOMEM;
 		}
 	}
-- 
2.53.0

