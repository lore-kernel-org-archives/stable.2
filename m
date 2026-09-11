Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2033D4AA004
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150915; cv=none; b=XzZhDeVkBufikB+1XOYmjr4MGg6U7PxGooYa41TmdGz1gJUmLVjYcQqbe9gWf5FWu+Y9Sy9FNdbQAB0q71eo8uI8CS0WxWtq60+0Ad6YhXC9lnShFob3lw/2rIrwDj5OFByJDX0WvRV+/rZTQvpl11IlE3BwbhWwO50QZie3yf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150915; c=relaxed/simple;
	bh=oSkGTK/fnfBFB1b0QSUzDJ5m0BiNvQ7ZAM+vll3c+MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlahRlJ/auxg5GMozERD95NeH18cR7pD1enbgLb7NIBRv70pYu0o3C2XUuii/t3rK0nbBJZX0ELqK51BlVE/TzQdAVFBP85m2NsNVMgqflt8mDmiZ9oy9RhuhbpZs0JSzI/gUlHNFOl5mRhansci2P9KH00KN5xgTBPDlcSL9ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmUkS3Xq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmUkS3Xq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250591F000FF;
	Fri, 11 Sep 2026 18:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789150913;
	bh=qq5Vi/LBBMkYCR3IUFSOkqLzkmHH6Echf3GQThUIUV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VmUkS3XqZEZfJDE1lCqsqQcOLBAL4EjU2H97H33ch7bWRRm8OimAbpsglKVaKEqdh
	 PuOo/2/aYWF//mFLPY3/fICfpU+rjegHIagOXmC4vg8kp/xBNYp8KxWCff+H7PqTjm
	 qH0UwhxArA5WaWen7lt88h1yst7pcQy1OZQ57NTEmwOqxW4syja2OvJB8kwvpCbYW4
	 LN/qSU6kr/ZvdNnAd3FDj/qY3j0eiST+yndiL5QPlBVzWH7qStA+PcbQtVLFQTnBza
	 +ATXaINB/WjBapur67kjr6ruZdP3kGnckafm8Qv/4cuksZSb69vp+GwjeBxmzU4ylS
	 pUZ0O87k7wj4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Hannes Reinecke <hare@kernel.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] scsi: qla2xxx: Hold qpair lock when sending NVMe LS reject
Date: Fri, 11 Sep 2026 14:21:49 -0400
Message-ID: <20260911182151.1324762-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090902-deacon-ambiguity-eafe@gregkh>
References: <2026090902-deacon-ambiguity-eafe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nilesh Javali <njavali@marvell.com>

[ Upstream commit f743488e4a203049f27ec5d8cd0caccc483af01e ]

qla_nvme_ls_reject_iocb() allocates from and advances the request ring
through __qla2x00_alloc_iocbs() (which assumes the hardware_lock is
held) and qla2x00_start_iocbs() (which advances the ring and rings the
request-in doorbell), but takes no lock itself. Two of its callers
invoke it without the producer lock held:

 - qla_nvme_xmt_ls_rsp(), the NVMe-FC .xmt_ls_rsp transport callback, on
   its error path, and

 - qla2xxx_process_purls_pkt(), run from the purex work/DPC context.

Both use ha->base_qpair, whose qp_lock_ptr is hardware_lock, so they can
run concurrently with normal I/O submission on the base ring and corrupt
the ring producer state, leading to duplicated or dropped commands. The
third caller, qla2xxx_process_purls_iocb(), runs inside
qla24xx_process_response_queue() with the qpair lock already held and is
safe; that is also why the lock cannot be taken inside the helper itself
(it would recursively re-acquire hardware_lock on the response path).

Take qp_lock_ptr around the two unlocked callers and document the helper
as caller-locked. Both run in process context, so spin_lock_irqsave() is
used and nothing in the locked region sleeps.

Fixes: 875386b98857 ("scsi: qla2xxx: Add Unsolicited LS Request and Response Support for NVMe")
Cc: stable@vger.kernel.org
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Link: https://patch.msgid.link/20260723050413.3897522-53-njavali@marvell.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
Stable-dep-of: e46160a5d4fa ("scsi: qla2xxx: Unlink NVMe unsol ctx before freeing on LS reject error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_nvme.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 38cb3281c6350..cfde62464340b 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -375,6 +375,7 @@ static int qla_nvme_xmt_ls_rsp(struct nvme_fc_local_port *lport,
 	srb_t *sp;
 	int rval = QLA_FUNCTION_FAILED;
 	uint8_t cnt = 0;
+	unsigned long flags;
 
 	if (!fcport || fcport->deleted)
 		goto out;
@@ -441,7 +442,9 @@ static int qla_nvme_xmt_ls_rsp(struct nvme_fc_local_port *lport,
 	a.vp_idx = vha->vp_idx;
 	a.nport_handle = uctx->nport_handle;
 	a.xchg_address = uctx->exchange_address;
+	spin_lock_irqsave(ha->base_qpair->qp_lock_ptr, flags);
 	qla_nvme_ls_reject_iocb(vha, ha->base_qpair, &a, true);
+	spin_unlock_irqrestore(ha->base_qpair->qp_lock_ptr, flags);
 	kfree(uctx);
 	return rval;
 }
@@ -1128,6 +1131,10 @@ static void qla_nvme_lsrjt_pt_iocb(struct scsi_qla_host *vha,
 	lsrjt_iocb->rx_byte_count = 0;
 }
 
+/*
+ * Allocates from and advances the request ring, so the caller must hold
+ * qp->qp_lock_ptr (the response-queue caller already holds it).
+ */
 static int
 qla_nvme_ls_reject_iocb(struct scsi_qla_host *vha, struct qla_qpair *qp,
 			struct qla_nvme_lsrjt_pt_arg *a, bool is_xchg_terminate)
@@ -1184,6 +1191,7 @@ qla2xxx_process_purls_pkt(struct scsi_qla_host *vha, struct purex_item *item)
 {
 	struct qla_nvme_unsol_ctx *uctx = item->purls_context;
 	struct qla_nvme_lsrjt_pt_arg a;
+	unsigned long flags;
 	int ret = 1;
 
 #if (IS_ENABLED(CONFIG_NVME_FC))
@@ -1196,7 +1204,9 @@ qla2xxx_process_purls_pkt(struct scsi_qla_host *vha, struct purex_item *item)
 		a.vp_idx = vha->vp_idx;
 		a.nport_handle = uctx->nport_handle;
 		a.xchg_address = uctx->exchange_address;
+		spin_lock_irqsave(vha->hw->base_qpair->qp_lock_ptr, flags);
 		qla_nvme_ls_reject_iocb(vha, vha->hw->base_qpair, &a, true);
+		spin_unlock_irqrestore(vha->hw->base_qpair->qp_lock_ptr, flags);
 		list_del(&uctx->elem);
 		kfree(uctx);
 	}
-- 
2.53.0

