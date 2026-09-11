Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C3D35F8C9
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150366; cv=none; b=p4BZf/hJjCm4DnLLo3TAuKtHcMP/WUkiezDFqprgT1HCCSrtGY/ZZwzykvG9s8zKXI57HtSrh1HzR0e1KZj4BF+GqO1m1egtcPh7DfRoFTzMn1Vd4ezO1GTTf+0FEIzCjjjC+nIqWU+nokU7KNW9yWZobYk5iwXH3nthUxMuuFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150366; c=relaxed/simple;
	bh=0Bhewo5oCD4qWO/6VRZkwTGjC4otX/95vwZWcKXZPfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0fng8cq//H8PJ/fJ/VwfBuNRprTjnjYTDBJwndEUeW0H9fU1dWXzN3BNNTQrQgLF6Jx9/koJmUeTnv6NKc6AWQfPIKCG7QBdqsoyrXaSsI4ovmMTQSwXWfebRKV+iTx6l6qFFABdEHzKaCyOAlXUSMDTAdW+0Icc4aI2e/+kEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4+m71nP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4+m71nP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31651F00898;
	Fri, 11 Sep 2026 18:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789150365;
	bh=4C/wtRC4zvdXf3a2rqet9dB9PONov4ZKHEKDe3Sp6M4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h4+m71nPinfm/+Ov+dL1gWA4Ie4Zehomf0uDeR72x5xLQZr6UuuuhnSvt2H6LzoHM
	 mdTKWwjJViSA+4HWXEH/sQiSbKyr/6uOCI4Y8tWR/VBH2CdoCCDuVV23UyJlf72UG3
	 wh0bzUxIZio4O1E/ZwcxDzPyD0o9ZF23M6lX6m9hK99y++T+wcglbFa3/yqLe419x1
	 s3dRF4JMQvrvI/Sw+9rVf9kDRAQncA/nlXpTrEiDkdrSATb+pf36KCT/yjRqIHITbv
	 SNEv7A5B50gDQMPKnh59aEnrYizHSaQlnFWL6KXgmDldYCvjOZwmxzAWdcv1DC2hFN
	 rI48dZSDapS8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] scsi: qla2xxx: Skip NVMe LS reject IOCB when FW not started
Date: Fri, 11 Sep 2026 14:12:40 -0400
Message-ID: <20260911181242.1316158-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911181242.1316158-1-sashal@kernel.org>
References: <2026090924-roundup-dish-438c@gregkh>
 <20260911181242.1316158-1-sashal@kernel.org>
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
Stable-dep-of: 76da0c43c63e ("scsi: qla2xxx: Serialize NVMe unsol ctx list with a per-fcport lock")
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

