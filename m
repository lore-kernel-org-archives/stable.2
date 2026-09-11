Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A683E44F6
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140811; cv=none; b=Ne9Ww3eblLEpCxoHAqrmdEfmhIX4vIZv2T7c8hBvx+7YWdGkwx8QMOKJW9slWQxULrmDl4FBMQ9AJJJi6FO+hmSZBdNq8+OCEuj67ndfzz4Nip6RUGBxzX/UrfXmYRzGcsqCA45+GoAeQTFVhFBzSnpfjSJ6UE9tL4IhzPqFmXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140811; c=relaxed/simple;
	bh=s4XENsozOpP0gsC5G8EknKQ0NXa92YkR4noWzSBiaWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2+8ngPhqxa1Obfsx1lRWmTkQNVHh8+YZ2ajj99Seoi9gG4NjLkHeyTRr2TJlbVmBO4iZvak7XNCfFY9f2DdtCn4CTUO7B94cr0NNHByN4Fu8WyFvBqOJLO6/gI0ovX2VFdHFr6ahnbHEGCZGorKF3IDrt620FXwcV1qa2bRNao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/pBo+44; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/pBo+44"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13CF81F00898;
	Fri, 11 Sep 2026 15:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789140809;
	bh=FmUM2kWSQRtgd6DHJwbkPtFnywLhDCu/CMlq3knxtf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n/pBo+440/vsOEiMUeQhLea1cr4PKSWEkzZDHwQy8K2OHg3/J3Vo+JooNSrletFyp
	 HiVhFpG/gOqQupftcfpN9v150jVnpyw2UpxV15ZNhzIBgUvjqEPqCDPUW6y4sW+JTw
	 L22VAukEehD/tJIZHbmLC5xBozhJBnBlZrVeg0HympFDbDKYOoYUdi2O9C8Rxzqaeg
	 tUOB869egTDtkupy9IF1kDTurNBlcZ0qBcPZ+mgN1IIvzGYah6lBP0cY70lWYOARKl
	 NEXjfGDtZN/BhKsQRyH0a67W2JvEb510o8nOVy8R7CZqYC8tsH6CXSzalk/4soW9RR
	 zg6PlqZqLG8Ug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Hannes Reinecke <hare@kernel.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] scsi: qla2xxx: Fix queue teardown NULL dma_free and bitmap locking
Date: Fri, 11 Sep 2026 11:33:26 -0400
Message-ID: <20260911153327.1096541-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090920-clear-immobile-5728@gregkh>
References: <2026090920-clear-immobile-5728@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nilesh Javali <njavali@marvell.com>

[ Upstream commit 34a40e0dff940ac5eba494a69b553ea571e24873 ]

qla25xx_free_req_que() and qla25xx_free_rsp_que() have two pre-existing
bugs exposed on the error path of qla25xx_create_{req,rsp}_que():

 1. When dma_alloc_coherent() fails during queue creation, the error
    path calls the free function with req->ring / rsp->ring still NULL
    (from kzalloc).  The unconditional dma_free_coherent() with a NULL
    cpu_addr is undefined behavior and can panic.

 2. The free functions clear req_qid_map / rsp_qid_map under vport_lock,
    but the create functions protect the same bitmaps with mq_lock.
    This provides no mutual exclusion.  Additionally, the create error
    path clears the bit and releases mq_lock before calling the free
    function, creating a window where another thread can allocate the
    same que_id and have its ha->req_q_map entry clobbered by the
    subsequent lockless NULL assignment in the free function.

Fix by:

 - Guarding dma_free_coherent() with a NULL check on the ring pointer.

 - Using mq_lock (the lock held by all creators) in the free functions
   to atomically NULL the map entry and clear the bitmap bit.

 - Removing the now-redundant clear_bit blocks from the create error
   paths since the free functions handle it atomically.

Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Link: https://patch.msgid.link/20260723050413.3897522-41-njavali@marvell.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>

Backport adaptation for the stable tree: the 29xx IOCB size-selection
helpers are absent, and queue creation still allocates fixed-size entries.
Initialize the local req_entry_size and rsp_entry_size values with
sizeof(request_t) and sizeof(response_t), respectively, so DMA freeing
continues to match allocation without adding helper functions or 29xx
support. Retain all NULL-ring guards, mq_lock protection, and removal of
the premature bitmap clears.

Keep the response-ring cleanup layout used by upstream so target commit
19788a55cab61d78e33e0914a5a31d27843e8a4a applies unchanged.

Stable-dep-of: 19788a55cab6 ("scsi: qla2xxx: Fix use-after-free of qpair work on queue teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_mid.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mid.c
index 7e1956d0435d7..4d2ce7a3de03d 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -583,16 +583,19 @@ qla25xx_free_req_que(struct scsi_qla_host *vha, struct req_que *req)
 {
 	struct qla_hw_data *ha = vha->hw;
 	uint16_t que_id = req->id;
+	size_t req_entry_size = sizeof(request_t);
 
-	dma_free_coherent(&ha->pdev->dev, (req->length + 1) *
-		sizeof(request_t), req->ring, req->dma);
+	if (req->ring)
+		dma_free_coherent(&ha->pdev->dev,
+				  (req->length + 1) * req_entry_size,
+				  req->ring, req->dma);
 	req->ring = NULL;
 	req->dma = 0;
 	if (que_id) {
+		mutex_lock(&ha->mq_lock);
 		ha->req_q_map[que_id] = NULL;
-		mutex_lock(&ha->vport_lock);
 		clear_bit(que_id, ha->req_qid_map);
-		mutex_unlock(&ha->vport_lock);
+		mutex_unlock(&ha->mq_lock);
 	}
 	kfree(req->outstanding_cmds);
 	kfree(req);
@@ -604,6 +607,7 @@ qla25xx_free_rsp_que(struct scsi_qla_host *vha, struct rsp_que *rsp)
 {
 	struct qla_hw_data *ha = vha->hw;
 	uint16_t que_id = rsp->id;
+	size_t rsp_entry_size = sizeof(response_t);
 
 	if (rsp->msix && rsp->msix->have_irq) {
 		free_irq(rsp->msix->vector, rsp->msix->handle);
@@ -611,15 +615,18 @@ qla25xx_free_rsp_que(struct scsi_qla_host *vha, struct rsp_que *rsp)
 		rsp->msix->in_use = 0;
 		rsp->msix->handle = NULL;
 	}
-	dma_free_coherent(&ha->pdev->dev, (rsp->length + 1) *
-		sizeof(response_t), rsp->ring, rsp->dma);
+
+	if (rsp->ring)
+		dma_free_coherent(&ha->pdev->dev,
+				  (rsp->length + 1) * rsp_entry_size,
+				  rsp->ring, rsp->dma);
 	rsp->ring = NULL;
 	rsp->dma = 0;
 	if (que_id) {
+		mutex_lock(&ha->mq_lock);
 		ha->rsp_q_map[que_id] = NULL;
-		mutex_lock(&ha->vport_lock);
 		clear_bit(que_id, ha->rsp_qid_map);
-		mutex_unlock(&ha->vport_lock);
+		mutex_unlock(&ha->mq_lock);
 	}
 	kfree(rsp);
 	rsp = NULL;
@@ -805,9 +812,6 @@ qla25xx_create_req_que(struct qla_hw_data *ha, uint16_t options,
 		if (ret != QLA_SUCCESS) {
 			ql_log(ql_log_fatal, base_vha, 0x00df,
 			    "%s failed.\n", __func__);
-			mutex_lock(&ha->mq_lock);
-			clear_bit(que_id, ha->req_qid_map);
-			mutex_unlock(&ha->mq_lock);
 			goto que_failed;
 		}
 		vha->flags.qpairs_req_created = 1;
@@ -919,9 +923,6 @@ qla25xx_create_rsp_que(struct qla_hw_data *ha, uint16_t options,
 		if (ret != QLA_SUCCESS) {
 			ql_log(ql_log_fatal, base_vha, 0x00e7,
 			    "%s failed.\n", __func__);
-			mutex_lock(&ha->mq_lock);
-			clear_bit(que_id, ha->rsp_qid_map);
-			mutex_unlock(&ha->mq_lock);
 			goto que_failed;
 		}
 		vha->flags.qpairs_rsp_created = 1;
-- 
2.53.0

