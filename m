Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3168329AAFA
	for <stable@vger.kernel.org>; Sat, 30 May 2026 20:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780171631; cv=none; b=oFdx900OgNV/XTlFBs+DbfAt3hPT7Q6+sjUce0Vp9/KzPWOdPmFpFa2epxppWwU4aLvrr6KtFMV4E2tGZph9JuBuEIOGsaXuXtPfAhK2K9KSisrREgn0Ug/SWNlGufve8dPQzoaW0lPqMWCwQk5X8MJnt199t/9KK6J7RNDAwJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780171631; c=relaxed/simple;
	bh=k7qYrTueet8Ot8QgnS3W/+Ti20S7QXBzIUW2awUJwYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uENyMByL9ngLe6zDbTpIVCz0g42rr7/EiQ+h3JY44QhmKKB4FcyQQa+1VBf6dzOGgSy9DxsJO4jdm43umewTCgBFqguNJ6xbhr3+OgnYa9HuKV3a8l1ZXcdUVLd4CKTFA/gJDyAb5Zq2lyz6avlJIQjDshKSQITdENsAEuooYzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyXeoHwA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyXeoHwA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAA51F00893;
	Sat, 30 May 2026 20:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780171629;
	bh=TJ8yuhn/o6hrj+jWuPOmlWfg8OCp8yD80Jso2dwQm3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RyXeoHwAuXomtWkDj7Bf9jE5Mn+MYf3ivVop1Mo6hLJdxyOTwSPoQKLws8iiyaRbu
	 MehPy0BkUtKIxwCmLzzlNo0gtU2myMJmfBRnRH5SmQUJDGynonjk4BByVPXvcosCno
	 ikU1pdBbDmafHHY0LdzVHn3EjMoqurgALrgj/wOdqpfFOiZbYMWx3c0V7QBYmRY6mK
	 0BA3TASSZUULSugpG2uoNA7TcbzcTsI8uvw5FptMyn2o93gK75jA1Wp3R4R6wOeGI+
	 PUdYGjUB9luwuAbLJZ88b8x+N3dvrDRfeXNr4KZJ94jlFI3mlTR/nW2OjttjZWraLC
	 FSuxx1oa+yYqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dawei Feng <dawei.feng@seu.edu.cn>,
	Zilin Guan <zilin@seu.edu.cn>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] octeontx2-pf: avoid double free of pool->stack on AQ init failure
Date: Sat, 30 May 2026 16:07:07 -0400
Message-ID: <20260530200707.3281847-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052845-zoology-ceremony-67cd@gregkh>
References: <2026052845-zoology-ceremony-67cd@gregkh>
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
index 4fc73ac721b05..3e1cd8af080e3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1374,11 +1374,13 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
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

