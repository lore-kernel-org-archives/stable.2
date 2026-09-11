Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F40C4BB269
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 21:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161338; cv=none; b=nYaDtFcL1LeSROgA5wOcQtrMVzlGjuck79usZt2QPEcak8PoMx43dTN5CWH4Kh7TSa8Tc+fjuX+2QsQhGzzmlk0NO+GNDbgOKlz8MlB8aT7D8Bqx4fw9ZEduO8eLzyS6Nktq2C9G+nARTr6/WXOq2Hw1liHP2g+HuZhXvxPEwwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161338; c=relaxed/simple;
	bh=4Tml5RkSQx/v2JlYX6bskVIOlIf+J1Itbowvuyh9RPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RM6uxmt2Ha0StOHLpFWX0+PBNX/VD6AltUnam8+VyS43dD+KNKhInZ7u46CYMkKoKt9N1q+CWWp7Ogy+HmqEZVsZbciz4R9JIk6+46hgvVOS2bAGyUYiIwoZwdL5RUAhMsVOnGlYABU4CVlq94fba2xfQKeCPvZ5nup6y3udx9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+vjQLh2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+vjQLh2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905E31F000FF;
	Fri, 11 Sep 2026 21:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789161337;
	bh=3+PhtOT8BH5qhP8AzU3e4ChzIQbIe9HQhKxqQzgJIa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b+vjQLh22O7uBGdQc5A55yIVIoy8ceL1dEiQIxN5nZAnnuVM8FazSZL23azw5H8Tr
	 KC/OZCI+lbEACLWrLbBnDf8zy7enQWSmpRT25sh8u+x58HN5OXb9XbS9dq08C5NtAI
	 BvKDNfgs8WBChfiZYGZMXzSHqn71vAvJNz0WZmHZJiJ/RQdWpc1vb8VJtmKBhQ9h55
	 53csJ/VgPgQc78NalJ4NXKr09BMiP8CAOBwvOwjwbtu93VLnk7eXDKqJxfmyJLCyan
	 7wFqhGjgVefjcWeQVlmO2LI407XTsBRwYi/9DfsC4CvFxMyl1Sib2VtpdDcCyxo+sL
	 ftOfpF87/hXmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] scsi: qla2xxx: Null out freed pointers in qla2x00_mem_alloc() error path
Date: Fri, 11 Sep 2026 17:15:35 -0400
Message-ID: <20260911211535.1531610-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090900-suitable-brute-f19c@gregkh>
References: <2026090900-suitable-brute-f19c@gregkh>
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
[ omitted the upstream cleanup block for allocation paths absent from Linux 5.10. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_os.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 552227a65855e..907b8f99505b1 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4259,16 +4259,26 @@ qla2x00_mem_alloc(struct qla_hw_data *ha, uint16_t req_len, uint16_t rsp_len,
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

