Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7743A4AF170
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150232; cv=none; b=bDevf66hX3XW47beYCt7/Ksol49AY/83Qa8G9GH6nx77JKj0Lhcv/u80tfqsXC0fTLNaZnE5yLb2JEoh4QKVwWCSX503OqgPVQe55OEXbxCIAhSdKJtObt+5fyCt0pCQyPNVX7vUFAQNXl9hSkmSY/JmIl/s/DRGeUT/nAdGPRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150232; c=relaxed/simple;
	bh=PV2K23TJ82SHUqHLB9E+4eMaNhFQBW8CkZ+jYi8EKN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbKPcugrSsJTW/UvLEYYk5UWaskNelSzKwJZOChrg0kfMKtZOA6ncPt2syeVek7a2IKV/F/wqgcPsAiYOxORXGMtapZqt0Y9oEndhbpEVbrWZeIFKY+gXSIDJ2Pv3QCZ4abmVDXjoNKnsIHIfHUwjLOj4SjPxAMZZ1tipICLLko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjlAB3Il; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjlAB3Il"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C77A1F00898;
	Fri, 11 Sep 2026 18:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789150228;
	bh=flL/Ji8Zt7lXgw+KSFafJfjabB4QEwBT1Qgh5TvJMIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MjlAB3IlL4Vs6girn6SUXXj/LdgH1EBc0fZ2rcAlz945DyNNjo1xA1/YVwcMWDnVd
	 OCroEd/yeVj4nlRQCOnQivyNuG5mfwfqEasphlv23+dvHU1IAQfKtKqnct3GI6+1Lq
	 2HUYZqgm+6lk5ED5lJ/FVGCBxGvaslq8mQ3+NC5n1ebi0fAVd93nRPGCLYbHni+crU
	 SlFIGxw7aaRtjq3ygfU2n+jB4NDZjyXnpmVUcp5jewxIRW+DWOoAnXMBIkIsoan/Jj
	 xG4d7DPiP5B+ssIDpkN62y9nZpimniLFu3yxLyqwV2ZQjiG7g4aHp4esA1oMKAax2B
	 bcs/KBiNigsIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Hannes Reinecke <hare@kernel.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] scsi: qla2xxx: Hold qpair lock when sending NVMe LS reject
Date: Fri, 11 Sep 2026 14:10:23 -0400
Message-ID: <20260911181026.1306489-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090924-wildlife-washed-3972@gregkh>
References: <2026090924-wildlife-washed-3972@gregkh>
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
Stable-dep-of: 76da0c43c63e ("scsi: qla2xxx: Serialize NVMe unsol ctx list with a per-fcport lock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_nvme.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 42eb65a62f1f3..cee7b8f4a8d9c 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -374,6 +374,7 @@ static int qla_nvme_xmt_ls_rsp(struct nvme_fc_local_port *lport,
 	srb_t *sp;
 	int rval = QLA_FUNCTION_FAILED;
 	uint8_t cnt = 0;
+	unsigned long flags;
 
 	if (!fcport || fcport->deleted)
 		goto out;
@@ -440,7 +441,9 @@ static int qla_nvme_xmt_ls_rsp(struct nvme_fc_local_port *lport,
 	a.vp_idx = vha->vp_idx;
 	a.nport_handle = uctx->nport_handle;
 	a.xchg_address = uctx->exchange_address;
+	spin_lock_irqsave(ha->base_qpair->qp_lock_ptr, flags);
 	qla_nvme_ls_reject_iocb(vha, ha->base_qpair, &a, true);
+	spin_unlock_irqrestore(ha->base_qpair->qp_lock_ptr, flags);
 	kfree(uctx);
 	return rval;
 }
@@ -1127,6 +1130,10 @@ static void qla_nvme_lsrjt_pt_iocb(struct scsi_qla_host *vha,
 	lsrjt_iocb->rx_byte_count = 0;
 }
 
+/*
+ * Allocates from and advances the request ring, so the caller must hold
+ * qp->qp_lock_ptr (the response-queue caller already holds it).
+ */
 static int
 qla_nvme_ls_reject_iocb(struct scsi_qla_host *vha, struct qla_qpair *qp,
 			struct qla_nvme_lsrjt_pt_arg *a, bool is_xchg_terminate)
@@ -1183,6 +1190,7 @@ qla2xxx_process_purls_pkt(struct scsi_qla_host *vha, struct purex_item *item)
 {
 	struct qla_nvme_unsol_ctx *uctx = item->purls_context;
 	struct qla_nvme_lsrjt_pt_arg a;
+	unsigned long flags;
 	int ret = 1;
 
 #if (IS_ENABLED(CONFIG_NVME_FC))
@@ -1195,7 +1203,9 @@ qla2xxx_process_purls_pkt(struct scsi_qla_host *vha, struct purex_item *item)
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

