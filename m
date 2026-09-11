Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2C32C21F7
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136638; cv=none; b=bhj7KjSyR3JVHmixx7cqvdWavDmFa2Phep1n5zg0g75k/mw+tOU2QuF8QTf3EdH3JztaqoWEQo0SJr32XjNsFgwr1SIfnVlvvHMg6k/BWIS61L9qAQcFocVlUPyrHR9uf164ZN8wV6Exl+K08Wk1wah6se7a5p7OaqexejaaqGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136638; c=relaxed/simple;
	bh=CLUcLwHj9z5Vquxhc3ZRQqWnPNrtdt1wPtnRXg1UJlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4xLRokojZm3mXqYvgkXsgodCxgsJGts9cZNMinp1VL3lWdaIqnaeVGXXsSq85TgKmiso5Vp3KdCYlL31MMGTasioMJjrtkLfywl72My1sFuseXIWig2BibooIlXglYLkiAwk2GZDNmJlACJb8SjmjxjbaHOEF11WohRWMS/bnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OV3NQJzh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OV3NQJzh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E691F000FF;
	Fri, 11 Sep 2026 14:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789136636;
	bh=KXGHerfzH7UiatoXtVvFoQg4nwUpC5gXMD5UmmyBj/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OV3NQJzhiuzIMHTfwFJRVm3B33YWAXfWb6wdvUL7mXe6kQTiVLzkL7itnL4tSfC8Y
	 n840xtA3JUpqHITcA6VZcbKnsOAVHpw4XCBqgNjgqyT10og1MlHwSLhRcXt87tuS3C
	 GMPiESDT8rb/8CivgmPvlZTv1Fa/kliuSbPKZrcHH54GdZguYTjCDaYPdB8tWTtgzW
	 IqEToo7EL5Aor+CJyxvP/xUb2j2o50Pss4Lg20avm2zkRqpQVLpPm7h2BHQFoLs3dZ
	 XTkeuPaiZGz1jEUQAiL4iklw1xbhtGk4zygNZN2E+QFRrMpAM+VIBxQi21Kudsnj5S
	 U20tY93Niv2Qg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Hannes Reinecke <hare@kernel.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] scsi: qla2xxx: Hold qpair lock when sending NVMe LS reject
Date: Fri, 11 Sep 2026 10:23:53 -0400
Message-ID: <20260911142354.893479-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090921-fester-word-0fdf@gregkh>
References: <2026090921-fester-word-0fdf@gregkh>
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
Stable-dep-of: f7e46ebffc57 ("scsi: qla2xxx: Skip NVMe LS reject IOCB when FW not started")
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

