Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ED24AC163
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150916; cv=none; b=EK63+rIl72GP0KlRopnEDaUyDLuie5zMHAf07vGSA+iWaMtSNz3dpqtyxuP0vqgGULN5KVxNrlLUiNNurBQlYa6v+D3zr6jsclC1ya8b070bMWj6fgUBVF/0DLVCmmd3pljshjTKr7aWzIdUXrpxBIgo4o7IXqAavWYfLl7TtfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150916; c=relaxed/simple;
	bh=GEwjH9qpdpOTspgZEQd3H1Pj07/JZv4K2v2/I9ibmzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzbkDIlVKUcGyRtK+Bkuh3934ua/e6MtAcscHv0BJf6wSvVoDtCWD7ciuTvBt/ihCmGUKgXanSu6gj7eFu6xAtsH7t147i4qww3rznL6/vuRONiwSj1I1JjH0NWbBgOb5/c4xloWGWnlv8k8I2JbYHh9OEmrNRDWvEU2X82K7BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2xjXock; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2xjXock"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A3F1F0089B;
	Fri, 11 Sep 2026 18:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789150914;
	bh=utzoVYiawqriM4bZfKQc9UIu5qra0wuTmfGe9qqWJI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f2xjXock5cCQzgs3R1eHEvQbwfpunwdCK2L83mUxMc+/eON+GzbyuLPMaHlk7+7it
	 e79G7lyVUAQsxw7qnRABnIodKwaQNF8V6FzkTNzDwztF2WSn4xbTWq2dOl+in/ENa/
	 J8cRP3R227e+H+bBj6V4pY0fSRsHP4LDQIEf/jdEyDsUebIhDanYJew6vLCcHFCziN
	 MmPXMjh5dDiojbQB4bNjBFpQMR+rJLQEM49zexmRniz2fPDt2WZz1eG6HlZEb5lr6N
	 XPgWdlnODbHZaAWrJO0iWqahEKOqNfLqD3frwo23h/c6qB0aSUteUGMu8ZfJxXHjlm
	 7NS9yBByO0QpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] scsi: qla2xxx: Skip NVMe LS reject IOCB when FW not started
Date: Fri, 11 Sep 2026 14:21:50 -0400
Message-ID: <20260911182151.1324762-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911182151.1324762-1-sashal@kernel.org>
References: <2026090902-deacon-ambiguity-eafe@gregkh>
 <20260911182151.1324762-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nilesh Javali <njavali@marvell.com>

[ Upstream commit f7e46ebffc5781aab3f1f5a5d4350addbb5833f4 ]

qla_nvme_xmt_ls_rsp() bails out to the out: label when firmware is not
started (!ha->flags.fw_started), but the out: path unconditionally calls
qla_nvme_ls_reject_iocb(), which ends in qla2x00_start_iocbs() and an
unconditional doorbell write to the request queue in-pointer register.
This rings the firmware doorbell and queues an IOCB that stopped or
resetting firmware cannot consume, and touches MMIO during the reset/EEH
window where fw_started is also clear.

Only emit the LS reject IOCB (and ring the doorbell) when fw_started is
set; otherwise just clean up and return. The post-allocation failure
cases (SRB alloc / qla2x00_start_sp() failure) run with firmware started
and still send the reject. Apply the same guard to the reject emission
in qla2xxx_process_purls_pkt().

Fixes: 875386b98857 ("scsi: qla2xxx: Add Unsolicited LS Request and Response Support for NVMe")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-dev@google.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://patch.msgid.link/20260730155838.2119230-26-njavali@marvell.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
Stable-dep-of: e46160a5d4fa ("scsi: qla2xxx: Unlink NVMe unsol ctx before freeing on LS reject error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_nvme.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index cfde62464340b..4a7cf88d46428 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -442,9 +442,11 @@ static int qla_nvme_xmt_ls_rsp(struct nvme_fc_local_port *lport,
 	a.vp_idx = vha->vp_idx;
 	a.nport_handle = uctx->nport_handle;
 	a.xchg_address = uctx->exchange_address;
-	spin_lock_irqsave(ha->base_qpair->qp_lock_ptr, flags);
-	qla_nvme_ls_reject_iocb(vha, ha->base_qpair, &a, true);
-	spin_unlock_irqrestore(ha->base_qpair->qp_lock_ptr, flags);
+	if (ha->flags.fw_started) {
+		spin_lock_irqsave(ha->base_qpair->qp_lock_ptr, flags);
+		qla_nvme_ls_reject_iocb(vha, ha->base_qpair, &a, true);
+		spin_unlock_irqrestore(ha->base_qpair->qp_lock_ptr, flags);
+	}
 	kfree(uctx);
 	return rval;
 }
@@ -1204,9 +1206,14 @@ qla2xxx_process_purls_pkt(struct scsi_qla_host *vha, struct purex_item *item)
 		a.vp_idx = vha->vp_idx;
 		a.nport_handle = uctx->nport_handle;
 		a.xchg_address = uctx->exchange_address;
-		spin_lock_irqsave(vha->hw->base_qpair->qp_lock_ptr, flags);
-		qla_nvme_ls_reject_iocb(vha, vha->hw->base_qpair, &a, true);
-		spin_unlock_irqrestore(vha->hw->base_qpair->qp_lock_ptr, flags);
+		if (vha->hw->flags.fw_started) {
+			spin_lock_irqsave(vha->hw->base_qpair->qp_lock_ptr,
+					  flags);
+			qla_nvme_ls_reject_iocb(vha, vha->hw->base_qpair, &a,
+						true);
+			spin_unlock_irqrestore(vha->hw->base_qpair->qp_lock_ptr,
+					       flags);
+		}
 		list_del(&uctx->elem);
 		kfree(uctx);
 	}
-- 
2.53.0

