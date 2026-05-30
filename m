Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B159D81AA8
	for <stable@vger.kernel.org>; Sat, 30 May 2026 20:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780173199; cv=none; b=cIwC6QIybGz32OUCrXhmKav/pUEC70/YoYsHz8+iSRa0edo1r37IQOJDiLxmbauM7ONBvSfef/7zljZ/w15nicvD8TIkikFVX8lVrufbC/Sjxv6c1p/uCRTXvP3AViy//dRZkfc27Za6PrdZ5E5fJjPz/Hfjbf11n4tdWijmVJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780173199; c=relaxed/simple;
	bh=v5WndbHKRnAUqjwbR6xWvciL7MBSL0Pe3m9qn7kKWAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aeXOquyG1ipj2Q6QbQPJ4YSQPPV1I0tlPBlCy9XmpRLosktfu/vW9+aBnKY5aKglAdx9Y2C8m0qha/QI1Kwx1en+KuhTsgq339oG7hVDGA/fl2O6vO9PvzHfUuvOiPsQTE43EfHCEIdC+7wMuHJBVGeyTCSAbCe+T9zUxD3WocA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SokOz/3N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SokOz/3N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE0D1F00893;
	Sat, 30 May 2026 20:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780173198;
	bh=CZz5iLizJ83cuUdtld53bYm1Z1mEOgHex8fjpTlf39U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SokOz/3NQTVT1ohgqJVgSktLpQWMaNTrVXbIhpx6FZ8sql3r7LpqnzFMNJfVPEF1y
	 UFjQc73rUO1Wr7HTYdc77omFq2CJET1NHWWJFWdrJMgacXwRYPg1EaKVEPtFEGHkMf
	 p2E87Tf8YN6jthekGgroNefbYHtIyAJNic5N8KYfx6cQnyHZAZxlqELQkM4GVaWh1k
	 GDgA2pinVDVyivKMtmHR+SxuKavTHJ2oArVo9dr2Y9LXd9/PYMDuicK3zjHi/UxG33
	 lAV4PAhXXAPawxzjAHzGg0rl+p9GR701iu8+oCLgjeyz6GvPsU/5SpLSA/ptEHrsHN
	 Dqo1ifi4li1jQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dawei Feng <dawei.feng@seu.edu.cn>,
	Zilin Guan <zilin@seu.edu.cn>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] octeontx2-pf: avoid double free of pool->stack on AQ init failure
Date: Sat, 30 May 2026 16:33:16 -0400
Message-ID: <20260530203316.3338022-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052846-passion-prevail-1d9d@gregkh>
References: <2026052846-passion-prevail-1d9d@gregkh>
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
index 2b6baf0ad3f7d..fe562961b920c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1194,11 +1194,13 @@ static int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
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

