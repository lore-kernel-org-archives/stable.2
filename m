Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88114492E5A
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150367; cv=none; b=D3f8z0qWazZ+AXspjTDzlnUnUQPDqAxu4jA+/fL+I/qq5lyV32rEz3sG+lreEEFTGvcVbG8vqS+idxMSxo41zCaiRL1RZPT/Tcr62SB3N4AP5O7zNCl3BgI55jACoW9z6RrJhKt1PQ8pnlK20w+M8oECDwZkZEg6cAtrwwNZuZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150367; c=relaxed/simple;
	bh=bO4O9sAboODJiX9cpOH87aQnxcbKqmyjYyl9SBr9EgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTHgVv33DEm5RSwnwi9E1MQAjQA1Cxv09MbU8QOPUBQiMyMGELxGhhOnDzMoSg6Yb7rOHjw7kWnIxLUxZWllkIfdQe+ol6+Z2k/GUirxAhTvEKEzcJ9DHVRIyQ+7GJG8PGvHlirFmuMtD24mD7CEoghq//RTckI2XqhbJIFy5Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzeX5KEo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzeX5KEo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB511F00899;
	Fri, 11 Sep 2026 18:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789150366;
	bh=AXQ61Bu2+q5yTN7IGHR9DDRN7fCXsPFGnrzxU9kR5zM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FzeX5KEo2HskNZcDOuhqRIgP0oxi6D149vatIRMOAxAMirjHZPkbzX655ar/WBRpg
	 6R7lyHrvqlv8MIhGMezrVAH+7d+llJQ8U69RWfDKbUAmglCmppaTEDFAgIXW4vCPy3
	 X//fVlKDa7MGGkKtNIzh3CmBbn0HZhbPn2ivgZnLvgRKmHfV/P6eBoGWmG0E5yn/W5
	 5wGk3+hBkR/1CIolFuPmCnJCgBEa+c8AEp9B/vzwMKIUzhD6fmD99NVPPhEdjQqn9k
	 BewKtG97VeVYmU7kATfrXUM/G3rU4mAq+cNt1niNtfpvNf9JF9pi2Di4riIlFN4L/j
	 8NXSULMtHPL0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] scsi: qla2xxx: Unlink NVMe unsol ctx before freeing on LS reject error
Date: Fri, 11 Sep 2026 14:12:41 -0400
Message-ID: <20260911181242.1316158-3-sashal@kernel.org>
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

[ Upstream commit e46160a5d4fa59bf4d5f3412b6b5cb79edb967dd ]

qla_nvme_xmt_ls_rsp() obtains uctx, which was linked into
fcport->unsol_ctx_head by qla2xxx_process_purls_iocb() and is still linked
when the NVMe transport calls back to transmit the LS response. On the
error (out:) path the function frees uctx with kfree() but never removes
it from the list. This leaves a freed node in fcport->unsol_ctx_head: the
next list_add_tail() for that fcport writes through the freed node, and a
subsequent list_del() can corrupt the list or panic.

Unlink uctx with list_del() before kfree() on the error path, matching the
other free sites in qla_nvme_release_lsrsp_cmd_kref() and
qla2xxx_process_purls_pkt(). qla2x00_rel_sp() in the failure path only
returns the SRB to its pool and does not invoke sp->put_fn, so the out:
path is the sole free and uctx is always still linked there.

Fixes: 875386b98857 ("scsi: qla2xxx: Add Unsolicited LS Request and Response Support for NVMe")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-dev@google.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://patch.msgid.link/20260730155838.2119230-27-njavali@marvell.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
Stable-dep-of: 76da0c43c63e ("scsi: qla2xxx: Serialize NVMe unsol ctx list with a per-fcport lock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_nvme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 4a7cf88d46428..8b8c8bfe3c2b5 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -447,6 +447,7 @@ static int qla_nvme_xmt_ls_rsp(struct nvme_fc_local_port *lport,
 		qla_nvme_ls_reject_iocb(vha, ha->base_qpair, &a, true);
 		spin_unlock_irqrestore(ha->base_qpair->qp_lock_ptr, flags);
 	}
+	list_del(&uctx->elem);
 	kfree(uctx);
 	return rval;
 }
-- 
2.53.0

