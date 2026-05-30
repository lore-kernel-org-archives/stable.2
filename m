Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B10232D42B
	for <stable@vger.kernel.org>; Sat, 30 May 2026 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160604; cv=none; b=cDwCsNX+KNM88NZRgYnJWppMprmJMEqL60nSg6rOF1JiXLyBHlvtOX2/wbwLH2075ZogOxjeuLQp6sZ9W50d9W1cHltlo22ZH7Q5p7LfkEFz/kVwCWaOmL1xptpJKq4OUqZk9Eajcvp8ZFMWH8bzSGiOHVmaZfMUCXVKp+Oe44w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160604; c=relaxed/simple;
	bh=E3qP0vTfsjBJmFlyLD9+5ZV3AdafZB3ghd99ZDFv97U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3wv8C5CdRGCsJrUgBkqHj+3OQ9OMOLOTmvXCLQXzeTGZZAPpuM4JpZLLKZfHTXBWlWbIZ5c8gj4fKiLfwsB2qsyZj42Cvvxe1Knc11RZo4+spJEE/g9DImI/YcrW+DbLLtYtWa+EBPKBSop1rucvTazCxFjmHOUDtZJoldlOXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kq5RIxNJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kq5RIxNJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0BC1F00893;
	Sat, 30 May 2026 17:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780160603;
	bh=vrZFWKLN8U1RZUIIMgJpDxR+Lc/KmVHS5YgbpipfhVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kq5RIxNJR+YWScFUV4bMB4MFs/qwn9xpwr97MPO38aQpwK18GhJ+LJ27+YGQ5GIFr
	 ik5wcFLagPEvZKJNt871kxgNdpqBfygItR0oC60Pri7QfRfOz2jzSrhyUOs5YqwAhz
	 4cCYB8f6xkFYHAv2ImMiLAajQjQzVLu9d4MLy2PPluNbp0RcQA7nXdJGke4WQCL2T+
	 Bjl0qK5Z3NZcAVPZqkKbaGIDPyVCw7W76sVQc8Wl6IIU77Tdr6TZaFeMDquUmw+1kw
	 Tz++Xkm+6oIiXVTxsrCXvbf/asqIyCvyfchoA58qd2iICIvR86J0ks37at1q7smG/m
	 IZ0f56omtLi7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dawei Feng <dawei.feng@seu.edu.cn>,
	Zilin Guan <zilin@seu.edu.cn>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] octeontx2-pf: avoid double free of pool->stack on AQ init failure
Date: Sat, 30 May 2026 13:03:20 -0400
Message-ID: <20260530170320.3036620-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052841-shoplift-raving-5384@gregkh>
References: <2026052841-shoplift-raving-5384@gregkh>
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
index f75afcf5f5aef..0d5571bc8b4a8 100644
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

