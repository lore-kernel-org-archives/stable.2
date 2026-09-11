Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0542231715D
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136639; cv=none; b=hEPvl17fzB9lrZ/as5AjwvnM6ETlhttq10/h3hLIBPUAa2xr5IqyHe+8ML2oeNgfdfE+NrZjD4oY80zqO9L3/PoEV3M9zOUEykDSX04CsLw8xvzTPny2M5DP5USiZPrBTvQzWzOkN35ymLXd04uuOWMVPa/105EmQWoF2WdeDl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136639; c=relaxed/simple;
	bh=IyJ3fmGo7Qr4g9ytf+wczM/xNY68rwfbBXQMcFhNiyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWEGLXUBx0HXxoRHb/rSRqvQkoxTFMzLp24Ed/DMDHbM4vL/D9R4PDH0c90SN4xfQaCiOsghJhOHqxbF0tJcl6wNDTktt32usCJChrSyYCALT07JVRppue2NUBjK/ATzNbqGNA3zssETmf4drCTAj3ex+qTaFpVZrvdAbKcGuWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOm6nekr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOm6nekr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0A41F0089A;
	Fri, 11 Sep 2026 14:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789136637;
	bh=/snMWBKOvN+FQGj9GTn4mjW9Bw4CQwUD4/PMODzqNVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FOm6nekrQ8LWQ+t9g6zRcRdXmcf2b5kYIAXuzqplXMOuWrd2cl9zzW9a5c0iAaHkj
	 CEtilSgs0RweyiO2WwBIuDr7JWJESanNym9SizWM7FuJ+7BSrDmSMa8mNdOF3jk0/N
	 TNHiWAGQFQ3TBchr1DKQziqZkMDGW1rGA7JihDGDeRFY/iO33/ptAUpRRb6f7BYCi6
	 M/hNg1TVA8/UJPBr6dtKM6R7J9n0Jm1/2HpfO/BpcWX/7f0LPLIipsEj09ij/wSfy2
	 86EUoevilbZnmN+wGG3eXrCvEWbDcwHaQW3pzLJ3vbJY8W9UIJlV8mDMlU4FaYgWxw
	 8bWB2WukqrHkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] scsi: qla2xxx: Skip NVMe LS reject IOCB when FW not started
Date: Fri, 11 Sep 2026 10:23:54 -0400
Message-ID: <20260911142354.893479-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911142354.893479-1-sashal@kernel.org>
References: <2026090921-fester-word-0fdf@gregkh>
 <20260911142354.893479-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_nvme.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index cee7b8f4a8d9c..2a31dc075936b 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -441,9 +441,11 @@ static int qla_nvme_xmt_ls_rsp(struct nvme_fc_local_port *lport,
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
@@ -1203,9 +1205,14 @@ qla2xxx_process_purls_pkt(struct scsi_qla_host *vha, struct purex_item *item)
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

