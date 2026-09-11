Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3530B4AC167
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 17:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789149505; cv=none; b=cDKu8hqMKXARf6goysLusksvAPDufHaerRQePbURwhWLQN3edlgaIvpyFJ4eYzQrNU04ANZVHo5MrexLi2TB1fqnmuQwxJfQmyBotcSCKczTJy/tD56E0zDXDQyhhSppXF8eGq2eG4ZumeycjJMR720aqQGvtQN0lOdNYjfEe7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789149505; c=relaxed/simple;
	bh=X0VNCIFp0ZOsVYPfVkqjHIl8aOzAVrc4xuQlYcd80tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYYtWXwD92vtqov3Hn+Uv9x84Aorxw1sggk7mdHineVMBQPLs2KWeDarhCtTCv0R+KejpDphRot6OgVG23oNVKsZlHsV5XYx5khnbU5pGx5Y9+IsfX0auEnDFbrInkJNDfaVGRYw60IHCQahIAm0o2UI9/WwRbYymNC3R47yfTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neK3OHRp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neK3OHRp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670DA1F0089A;
	Fri, 11 Sep 2026 17:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789149503;
	bh=bv9dB5ZAeafgASuRdLpcqLp1QBO/AywtpsXXhYQZYDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=neK3OHRpMPoqjJ99RH7NxoOHndubg1ZkOOLwcq/3ioWCWBVsDzUJRBfbjVRzRwQgD
	 le9qXo9QgJxDwm+DW5kzbr4FbLhuMGWa9nlZWzUQe/UGftcLlus6cL/5oSwUurjVNz
	 +eonu3X5tTv3M/XsmAK/2jCeU3NCHKHxN3ObJv2SeecxCVJ0bdwmtF5qw4RpnRyx39
	 lVdm9zqADgnDg0HH5zSB+Ut5+O4HVYeZomf+6orvVYAi/v/M7wMPlQ1sMbzYdNySRV
	 As/UuIzalvjCLZz2wm//ilvyJT/GcDra/+YsJ0aHAnZ2mCR/QYPGGLMSPRGrrdO4Um
	 0lR3Y5D0sQYaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] scsi: qla2xxx: Serialize NVMe unsol ctx list with a per-fcport lock
Date: Fri, 11 Sep 2026 13:58:20 -0400
Message-ID: <20260911175820.1283308-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911175820.1283308-1-sashal@kernel.org>
References: <2026090923-extortion-uncooked-f8ff@gregkh>
 <20260911175820.1283308-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nilesh Javali <njavali@marvell.com>

[ Upstream commit 76da0c43c63eb0496649e372ac64466364d0fe7d ]

The fcport->unsol_ctx_head list is modified from several contexts without
a common lock. Entries are added in qla2xxx_process_purls_iocb() from the
response queue ISR (under the qpair qp_lock), while they are removed from
qla2xxx_process_purls_pkt() (DPC/purex worker), qla_nvme_xmt_ls_rsp()
(NVMe-FC transport callback) and qla_nvme_release_lsrsp_cmd_kref() (SRB
completion). The qpair qp_lock cannot serialize this per-fcport list since
multiqueue adapters add entries through different qpairs, so a concurrent
add and delete (or two concurrent deletes) can corrupt the list pointers.

Introduce a dedicated per-fcport spinlock, unsol_ctx_lock, initialized in
qla2x00_alloc_fcport(), and take it around every list_add_tail()/list_del()
on unsol_ctx_head. The add nests under the existing qp_lock; no delete path
takes qp_lock, so the lock order is consistent and deadlock free.

Fixes: 875386b98857 ("scsi: qla2xxx: Add Unsolicited LS Request and Response Support for NVMe")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-dev@google.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://patch.msgid.link/20260730155838.2119230-28-njavali@marvell.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_def.h  | 2 ++
 drivers/scsi/qla2xxx/qla_init.c | 1 +
 drivers/scsi/qla2xxx/qla_nvme.c | 9 +++++++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index b3265952c4bed..783b6c429224a 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -2570,6 +2570,8 @@ typedef struct fc_port {
 	struct list_head list;
 	struct scsi_qla_host *vha;
 	struct list_head unsol_ctx_head;
+	/* Serializes unsol_ctx_head against ISR, DPC and NVMe transport. */
+	spinlock_t unsol_ctx_lock;
 
 	unsigned int conf_compl_supported:1;
 	unsigned int deleted:2;
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 6a63eefdcadd0..d694b53fab496 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -5636,6 +5636,7 @@ qla2x00_alloc_fcport(scsi_qla_host_t *vha, gfp_t flags)
 	INIT_LIST_HEAD(&fcport->gnl_entry);
 	INIT_LIST_HEAD(&fcport->list);
 	INIT_LIST_HEAD(&fcport->unsol_ctx_head);
+	spin_lock_init(&fcport->unsol_ctx_lock);
 
 	INIT_LIST_HEAD(&fcport->sess_cmd_list);
 	spin_lock_init(&fcport->sess_cmd_lock);
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index e57c071eee323..650d6be3af97d 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -257,7 +257,9 @@ static void qla_nvme_release_lsrsp_cmd_kref(struct kref *kref)
 
 	fd_rsp = uctx->fd_rsp;
 
+	spin_lock_irqsave(&uctx->fcport->unsol_ctx_lock, flags);
 	list_del(&uctx->elem);
+	spin_unlock_irqrestore(&uctx->fcport->unsol_ctx_lock, flags);
 
 	fd_rsp->done(fd_rsp);
 	kfree(uctx);
@@ -446,7 +448,9 @@ static int qla_nvme_xmt_ls_rsp(struct nvme_fc_local_port *lport,
 		qla_nvme_ls_reject_iocb(vha, ha->base_qpair, &a, true);
 		spin_unlock_irqrestore(ha->base_qpair->qp_lock_ptr, flags);
 	}
+	spin_lock_irqsave(&uctx->fcport->unsol_ctx_lock, flags);
 	list_del(&uctx->elem);
+	spin_unlock_irqrestore(&uctx->fcport->unsol_ctx_lock, flags);
 	kfree(uctx);
 	return rval;
 }
@@ -1216,7 +1220,9 @@ qla2xxx_process_purls_pkt(struct scsi_qla_host *vha, struct purex_item *item)
 			spin_unlock_irqrestore(vha->hw->base_qpair->qp_lock_ptr,
 					       flags);
 		}
+		spin_lock_irqsave(&uctx->fcport->unsol_ctx_lock, flags);
 		list_del(&uctx->elem);
+		spin_unlock_irqrestore(&uctx->fcport->unsol_ctx_lock, flags);
 		kfree(uctx);
 	}
 }
@@ -1258,6 +1264,7 @@ void qla2xxx_process_purls_iocb(void **pkt, struct rsp_que **rsp)
 	struct purex_item *item;
 	port_id_t d_id = {0};
 	port_id_t id = {0};
+	unsigned long flags;
 	u8 *opcode;
 	bool xmt_reject = false;
 
@@ -1323,7 +1330,9 @@ void qla2xxx_process_purls_iocb(void **pkt, struct rsp_que **rsp)
 	uctx->ox_id = p->ox_id;
 	qla_rport->uctx = uctx;
 	INIT_LIST_HEAD(&uctx->elem);
+	spin_lock_irqsave(&fcport->unsol_ctx_lock, flags);
 	list_add_tail(&uctx->elem, &fcport->unsol_ctx_head);
+	spin_unlock_irqrestore(&fcport->unsol_ctx_lock, flags);
 	item->purls_context = (void *)uctx;
 
 	ql_dbg(ql_dbg_unsol, vha, 0x2121,
-- 
2.53.0

