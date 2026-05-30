Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B951C5F11
	for <stable@vger.kernel.org>; Sat, 30 May 2026 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780172010; cv=none; b=Da/Ts/y51aVHIsT7dUHxAjDMgMxMhj0YzeHhvhJ+ueETut4D9AHmXLYGYcq0Wx4uqylWW2orJIH0Z6H39a9utcEsnHfDrbC1cnEST6jk3dRM8ITD1GRdcxgbkYs1q2/VR6fDOuJoO3qlEIslEuk8j0RlC6f4G6F80KqKhXycwY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780172010; c=relaxed/simple;
	bh=TDuvwpyeBPBVb1NXPSNInYt854YhqNra3K5Qhu0bH2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcylvlGPm0o/GKwes6KXQL8rtPEeWOBk+mDBCATEV0VXWVHbUiTc2jaKSZH9rMjTy5EeZcQzTdMn834paEjWhF54+1F84/GgP77rePnl6TsAN14qMDTJZCdYpteJmmeL5F7HeWLWHVZNVd1IqqDd28V+7PMXnmDeEjD7v9xGVO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cf/Amq+r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cf/Amq+r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C631F00893;
	Sat, 30 May 2026 20:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780172009;
	bh=xVtMowaVA30Bl5TPZYyGNi9IyFfvQhhcbk3KRR3a3lA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cf/Amq+r8QGAlqo1w4AXm4vK6hN0wJwXNv0Yr7hHOKjukTP5RYQXZGHAV1/gBz4Ag
	 OJIJMkebhPD7APYZFh/V9S2IdyKKttKAc7MYQoHGm4/8jelvInd2xbZkC1kbkyjX41
	 uZWQuR8CiSwwa5TPL88Ksm8ho2v2s5M+ChMVCD21kZpHv/neKwFEvaFtqtOY/e57Lv
	 dI+fXCQHBpwC0ZMvrw6xxOWJZ/jTpaKe9RiCCcRl/NdEaTWdtAYQuDWuyUbTDNcbHt
	 whSiHQP0UdzfTa7mrbprotWZHSW4ePewxhtVRDrP8UqjcQggCZYDsF8i6kpLrY2VUf
	 4skjzIsR81F3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dawei Feng <dawei.feng@seu.edu.cn>,
	Zilin Guan <zilin@seu.edu.cn>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] octeontx2-pf: avoid double free of pool->stack on AQ init failure
Date: Sat, 30 May 2026 16:13:27 -0400
Message-ID: <20260530201327.3310899-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052845-shush-commuting-ee9c@gregkh>
References: <2026052845-shush-commuting-ee9c@gregkh>
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
index 8333340b1ea9f..502c0b87770f3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1258,11 +1258,13 @@ static int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
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

