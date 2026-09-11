Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E664D217648
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138940; cv=none; b=AulSrQpHdIoKUtBKzBw+XhgFul8zYfzXVcg8id0MODZzqKFcbZ0g5q9E7MCt3rzyu2k7QeV+4+toLHG6FlTbzJxVkiDuPAdyhLLR+mftjKryzZiEOKBiOu1Iqqt9aeVArCl+Eo8ZJxh+a/HkJP7AfHcEdovvOGuDhBg017yZCIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138940; c=relaxed/simple;
	bh=Y+F38SJHQMgoAF/mtnzGhLwiRkI9IMKwZYxrJWMMD/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJePS+gE+gaVtfw1ugXYizV97BY4eZYsYfrYduzvqWGX5p2138wFKqMzECK/jNaG5naGZ7MSL1T6VejUPbSb03/BcUXMtye5Ing65yU6UhlBTgpt7IWg0MgFLmAZYmRbQDc8zto2sKBlaGj08AfxUwFp876R5CYZWe7N0nbzq7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vt5/6gGD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vt5/6gGD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46301F00898;
	Fri, 11 Sep 2026 15:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789138938;
	bh=mJaXH4aYXx2zI+ttid98hh8W39+lGgaMxe1Ecabumjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vt5/6gGDMZlkvarXYCvjf5eKdPxMkFhe/pCgfcePwDULMMPx03hkw+JZi1jmyvork
	 Z2D8Mq1aHbZyUxyRa/gtIElHymfb06r/VZqjCO8DTZcQPbUZblOlCLwbHBtDhxMx1Y
	 uGxD5m7YcfjBNQGzpEm5vX6S8YKtUPkEqwu1tS1ZDU1zXuJa/9FiKqWwXHdTZRvOae
	 Cr4wGi1FTH8vb2jDL12KoHH4z+a5Ly4TGzitIZZp6leGJWqWNlfkhFSvg++wYCuna8
	 O7cxXLghBhZaExJQ36qPZ9NtTcXgWL7MlcjGnfnidlYn8abDEprsWAtdys1wuRB0qO
	 TIqIhGPvRFv3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] scsi: qla2xxx: Null out freed pointers in qla2x00_mem_alloc() error path
Date: Fri, 11 Sep 2026 11:02:16 -0400
Message-ID: <20260911150216.1017754-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090958-riding-tannery-42e5@gregkh>
References: <2026090958-riding-tannery-42e5@gregkh>
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
[ adjusted cleanup context for the missing fail_flt_data block. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_os.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 01bf507470b12..3e148e4e94593 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4486,25 +4486,40 @@ qla2x00_mem_alloc(struct qla_hw_data *ha, uint16_t req_len, uint16_t rsp_len,
 fail_lsrjt:
 	dma_free_coherent(&ha->pdev->dev, ha->elsrej.size,
 			  ha->elsrej.c, ha->elsrej.cdma);
+	ha->elsrej.c = NULL;
+	ha->elsrej.cdma = 0;
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

