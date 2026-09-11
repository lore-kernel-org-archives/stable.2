Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3704AD4B8
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789149504; cv=none; b=EE25X5utV4kbKyQFiHPe6f6lja8krwnmFOy7jblBQpltagvs868hmDDZEocjTxyIs1CuVSFpzdtVIv5ZDOP0xeau9qfOTIn1obHqE8RSnYkLvNyB0a4V596MyZvIs9gkUZcMWfwz0n5KAZMWwvTWnLDFlL7tBtGpMRaUqHGIAa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789149504; c=relaxed/simple;
	bh=8rd/1i1lNrtXYWJD0sh+V0bl2V+wQO3xxr53FnsHkrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOxZFY5xst2mxqxzeHsjp5mvPPjCjUMbpaexphUv3kYtjDfKb7TBEH/NryNxvQP08R/DKEMWj45rz92z65W2HPjxfDpyHGsJPuZdO7b1CHGSa9ZXZjFoZxYrjC0EeXygZxK/Xb0tUrsBAWrHjSL8t/N1/doxilOhXVwGRP1c/ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fP97CQGg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fP97CQGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8919F1F000FF;
	Fri, 11 Sep 2026 17:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789149502;
	bh=WrFvFHZo7zM9wzVZyw6rnykFgTP2CMkNUuwQlMBa/MU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fP97CQGgT73Kv2igGv4BnACKagcHR22J8h9sUGqQZzKWFDuHyMNAgpYriTrP+ZFW6
	 9vxafIOPUn670RS4x09B8xqaVOazwhp/rjY/5OjwIohPlOXqIDmI4oxhgpdc6Uosoj
	 M1HiIKzBfr7j1liRDP+A/fd7QWmAGY2nbmLe1mFBmcu75+3opTxYgpu2jrNZjnmHgE
	 SUdTdarsP7fUeOCwwS0ggg0E+at1XHJW87F4Uriur9r6XCclZFGFeThpTy3m00neem
	 27wrX1N9MScipsqzg7ZxGOOEfZU0HyLCARzuxptvh3SkGGP+4466s67RcFet5mhTPT
	 sNQoKMTiFpw6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] scsi: qla2xxx: Unlink NVMe unsol ctx before freeing on LS reject error
Date: Fri, 11 Sep 2026 13:58:19 -0400
Message-ID: <20260911175820.1283308-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090923-extortion-uncooked-f8ff@gregkh>
References: <2026090923-extortion-uncooked-f8ff@gregkh>
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
index 3160e212fab1f..e57c071eee323 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -446,6 +446,7 @@ static int qla_nvme_xmt_ls_rsp(struct nvme_fc_local_port *lport,
 		qla_nvme_ls_reject_iocb(vha, ha->base_qpair, &a, true);
 		spin_unlock_irqrestore(ha->base_qpair->qp_lock_ptr, flags);
 	}
+	list_del(&uctx->elem);
 	kfree(uctx);
 	return rval;
 }
-- 
2.53.0

