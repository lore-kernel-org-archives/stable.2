Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3343A4A689B
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 17:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146977; cv=none; b=u5Rh7kt1f3jYya8DyiHAJyNdPH2/Omj0Sj2ADp7Nie/eUlyokDm4mFgulZD4Nx6pCco+dqIUXu3nBTtCqS0XriYQXraBNAEDjloGjLWTsCW7/DEukXDuzvZeSqYztOB1O8WUN5gr/kUYGLjC1yZkGHWg5+awApEd+62QFt+hkMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146977; c=relaxed/simple;
	bh=Ta4TcJiobvU1kr0Xj0m2ENOrLY56kQuL0ggfSbRuUKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E64aeUcVSNBWOEUyYCzZe6LBgE0ZnUyBpCGQ69qB4+k2HOmYiaWNEl9Ujqr9QeHUIumyPJklOqHMyhRCNpXZXz1rxtPuBn7qLhD9CBE6s4s+KijXD7ctG5gtVJH75Mzd5KBFWA1DAfHz9m+9Xs33cLhvk5DjnKjgb7CXLMGcI4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmPa0wKi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmPa0wKi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126371F00893;
	Fri, 11 Sep 2026 17:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789146973;
	bh=zxVJG/ufbKghUucgvuSUoF8jaN9w8nGBCUEaqcwPznw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lmPa0wKigKx9p7qDZPFWSZtsLzYwgVZ+miSrf/3EjyYLg3dqkAsVJv5O260qFTyuZ
	 HI7f6IvDYwQxIL8KVV5OUYYElYvQ0lMOe+0umh+N+fQNvy7j2ubEhpZXZDiC/M3UJy
	 Qylw6yKEZSnCuWpMekFtTKjL/lVTLQZ+EUjYeUTKj4k/PQlLYUbVpdi7ukOJMD+eJd
	 DUFryUb22Cfh6X3Sy6LpHJ4yfl3hTXDCwNOwh+GL5+qG+88LgAHTH7WR8LCa5vBqjx
	 3ylGkH1gBYFOKsvv3f7nbto0T7rEY1+SZu940DOC3Dg/oQ2gHHSH92mvQJD6ZkFg4Q
	 Kwlkt2/FQH9JA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] scsi: qla2xxx: Null out freed pointers in qla2x00_mem_alloc() error path
Date: Fri, 11 Sep 2026 13:16:11 -0400
Message-ID: <20260911171611.1214047-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090959-visitor-pessimism-b0d8@gregkh>
References: <2026090959-visitor-pessimism-b0d8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nilesh Javali <njavali@marvell.com>

[ Upstream commit 6d90f0feb929f6c0f3010f9af4747c7230b75993 ]

When qla2x00_mem_alloc() fails, qla2x00_probe_one() jumps to
probe_hw_failed and calls qla2x00_mem_free(). Several error labels in
qla2x00_mem_alloc() freed adapter members (elsrej.c, purex_dma_pool,
flt, sfp_data, loop_id_map, async_pd, sf_init_cb, ex_init_cb, npiv_info)
but left the pointers dangling. qla2x00_mem_free() then freed them a
second time. Worse, for the dma_pool members it issued
dma_pool_free(ha->s_dma_pool, ...) after s_dma_pool had already been
destroyed and set to NULL at fail_s_dma_pool, dereferencing a NULL pool.

Clear each freed pointer (and its DMA handle) in the error labels so the
subsequent qla2x00_mem_free() skips them.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-dev@google.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://patch.msgid.link/20260730155838.2119230-13-njavali@marvell.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
[ adapted cleanup changes for missing fail_lsrjt and fail_flt_data blocks. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_os.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index a373c90dfe6df..f912057c90eb6 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4464,23 +4464,36 @@ qla2x00_mem_alloc(struct qla_hw_data *ha, uint16_t req_len, uint16_t rsp_len,
 
 fail_elsrej:
 	dma_pool_destroy(ha->purex_dma_pool);
+	ha->purex_dma_pool = NULL;
 fail_flt:
 	dma_free_coherent(&ha->pdev->dev, sizeof(struct qla_flt_header) + FLT_REGIONS_SIZE,
 	    ha->flt, ha->flt_dma);
+	ha->flt = NULL;
+	ha->flt_dma = 0;
 
 fail_flt_buffer:
 	dma_free_coherent(&ha->pdev->dev, SFP_DEV_SIZE,
 	    ha->sfp_data, ha->sfp_data_dma);
+	ha->sfp_data = NULL;
+	ha->sfp_data_dma = 0;
 fail_sfp_data:
 	kfree(ha->loop_id_map);
+	ha->loop_id_map = NULL;
 fail_loop_id_map:
 	dma_pool_free(ha->s_dma_pool, ha->async_pd, ha->async_pd_dma);
+	ha->async_pd = NULL;
+	ha->async_pd_dma = 0;
 fail_async_pd:
 	dma_pool_free(ha->s_dma_pool, ha->sf_init_cb, ha->sf_init_cb_dma);
+	ha->sf_init_cb = NULL;
+	ha->sf_init_cb_dma = 0;
 fail_sf_init_cb:
 	dma_pool_free(ha->s_dma_pool, ha->ex_init_cb, ha->ex_init_cb_dma);
+	ha->ex_init_cb = NULL;
+	ha->ex_init_cb_dma = 0;
 fail_ex_init_cb:
 	kfree(ha->npiv_info);
+	ha->npiv_info = NULL;
 fail_npiv_info:
 	dma_free_coherent(&ha->pdev->dev, ((*rsp)->length + 1) *
 		sizeof(response_t), (*rsp)->ring, (*rsp)->dma);
-- 
2.53.0

