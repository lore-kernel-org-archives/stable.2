Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D5922D7B9
	for <stable@vger.kernel.org>; Sat, 30 May 2026 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780170480; cv=none; b=tfLD7GPtftSwa8moJZB9keYYZKcxPgi8IHatsp3CtTQuASk3TnAVmkzmjLOMPsI0eA9TXjOMBGoWdhbwZyfwXg3mIY34xdFE0l9LThuszJnG41I8pTH79JNZ8WovFp+BxD0ar6oZRbecOJ6o+hGWfkMj7MiHewcb5e6DdU7A0oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780170480; c=relaxed/simple;
	bh=WcFpNg1x0Z+7KUDu3auIdmmS7biDWNU1aK3D6zAYNQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQMSUf2G9ROUp3J78b/eROKuAFA0vTA/f5eS8IKrspgw1kNqV/4CAD80Fp+ghZqy5UwYvCMtQ6m8cBorc/FFikTxwc6RMkoG0hIMoSRvY+MOG6/PXeqbP4MbwACjG/CXyZ6HcvZlg0PrPp7o3oLXbKQqZPH+GhjSww0sypIJueM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3lvTbun; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3lvTbun"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1001F00893;
	Sat, 30 May 2026 19:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780170479;
	bh=MXNQNsU+GSUrjf8GsHBu1rMfu4SjCLVZzRxcJ/OFwwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E3lvTbunTN154IRP5lJrES4XIZhkmtyiakiHJqojaMQFJQK10bix3nlFrW8IBD9fE
	 Lgul9w4jt1tPMs62iVotRZRbdHCYBOUVuqSkgxA4gg23GlexpeHEv67Nn6bYCheB99
	 ymrWP0uwgsQs8AIuQHRnTIr+IjYYRIPXa+zbFOGSzo2E1LXaN0Ay9ehkXR6Z6QcfwB
	 EgJgcrpkstw4tAo+t4HjxsOxJf58aKv3S4kLGFcNOSEOmyvXlmVaV1KJW7I3DZ8gt6
	 T105XthKCtKllZ/Ycm+D9Gio1z1amUEdLRM/D6+dgSqTy577kR+bmaKfWAxQ2IH8ww
	 p5mSvClFQOaOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dawei Feng <dawei.feng@seu.edu.cn>,
	Zilin Guan <zilin@seu.edu.cn>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] octeontx2-pf: avoid double free of pool->stack on AQ init failure
Date: Sat, 30 May 2026 15:47:56 -0400
Message-ID: <20260530194756.3258783-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052843-accompany-skeletal-9d25@gregkh>
References: <2026052843-accompany-skeletal-9d25@gregkh>
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
index 1999918ca500f..62394a4ebe36e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1386,11 +1386,13 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
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

