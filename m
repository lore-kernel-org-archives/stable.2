Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722C04B1285
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 18:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150586; cv=none; b=XTixUEp+TeGG+5tkPMo4kn6S9VmsFC2ocV9w4J/OgBK7LTsPkCZ0GwWBeTUTmq63s3/IF8qXdjTAp8w756ISqZ1uARcvLv9iBQhs9CJ5zy+wbG0VggPFCyOOLHlDA3DopP7gBjHjdsSb+4R4J2inljMRX8+AP7kB+kjiYLSN/v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150586; c=relaxed/simple;
	bh=vnN8iba3tHXjRP+M4EK5BGYFuBjC4y73wN6ZcNfacFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gn+FA08GAkDODbWAU9Q/Jq9Ws5jxvDfqgJekHlCIiOmezYorPyX5L8Vw3dpBiULEyYn3B9Brb5MkXxtG95/8ZNCaNtUrCmg0eJJj3HyxLz5Fes/5PcdZfYLcTqcgnVPTdtnhNEkbI/fMqJBQ4EsWtML7uICmjIL7yden4NDvvfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOjh8/EQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOjh8/EQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A231F008BF;
	Fri, 11 Sep 2026 18:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789150575;
	bh=Tu3axmup/kFTeVCgV5LvYYyJ0Dsh/QW7v+SPF22I4kU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SOjh8/EQfoYUh3D6qso0XKFZaTKzsBbVV5okgqgvbysNCmVrQYIPYqrj6OC7yKF3G
	 4UrT03TT7POnj+Axy64cTg6YsUEm5L+FJpdwPEApFeQFS+D9xFMD/rCx/tD6xZgrmF
	 znFY8hiPrZnsKa+6gNHzCdHCI/3kG38OyB5pyH7F8BOxwvuNI+/EaOgsibe0KsLF2c
	 y1FqkyKnbiEJCy3amPahNZWRDoGeJhy52RxZqLJTmoMAi3IWCSJILuZoRXszDkkxxp
	 RgRWf4WqsRF0ugZO1Z/AYFjPsDo/WF2K3/X5BXD7CaLzc5TXXjEzH8CW3ap/0G+j3n
	 R88H0v+c4xOxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] scsi: qla2xxx: Skip NVMe LS reject IOCB when FW not started
Date: Fri, 11 Sep 2026 14:16:11 -0400
Message-ID: <20260911181612.1319441-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911181612.1319441-1-sashal@kernel.org>
References: <2026090902-vividly-swoop-b3ef@gregkh>
 <20260911181612.1319441-1-sashal@kernel.org>
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

