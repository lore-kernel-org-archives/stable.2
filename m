Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7547F4B1486
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 18:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150586; cv=none; b=P32IrtMRzuunjR/XvV2Bi3+BqfbxKfKIDx8ace5PcvgWpqgLGF4rO87mGF1smOJhJMjtWh7YI9X62QiFjyzv+I+PBbAli3BKj+/sE1VYJd3mrsOUNRRX+a73oiA0lZzKC8tpoMCE2xsZRGB0A9FLGfKwkqqsWX8NA74dtSplJCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150586; c=relaxed/simple;
	bh=Uti5QnHS41tzpy+UoCJgtTD65kKl0sP9nhnZmb5A+Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIKM4kJSlGWXV+T5m8kYnqT0ZrX0xQnVFmTrJa3K9ZF/w7FLeeW8hBCgA9vm58xxfw0TTEVabZ1nPM+NZOkATfqZ6rncyJPPYHi/iPjRwi9LEBO9dePG7M/j2OTyn0D7oC7iEbjnXmHi7vLwdxNQxzyoGtxIlBJBvvZgIHXHMj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XX2c4CbO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XX2c4CbO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3832C1F000FF;
	Fri, 11 Sep 2026 18:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789150575;
	bh=Z/FW358G9t4C+08waaRkv7kXqtSGqU8YkrjXuwrnNeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XX2c4CbOOYHsMIOhK5wVVyS/oVvMggdH7fclqVI/2L/ZwWqvTrtdQx+FhtlxOMdOz
	 N27V/FozOZ/d9ZWOH06EWD4jjZ7Sk+gB0g7j2Hq9SFyauK8SBDzwdPSBKLj7pMWuSl
	 2KRBlbeywPML3Z5yq9oesL+qhVlEKYTWns5JCWszXOW2xYlCzKL1T5kR6LLFwGHLnE
	 plvnY1LYa0XaqZJa9tkGFbNknAG+ADa3zov+FD+j0mSIWJHScVqShLO5Bj4YPv1/WK
	 CDO8NXPhHm8EB4RSUZS+oA9zo9UhZi9njaSSagX0kT19I/1ZfGiOAcQW2y9A5swqHf
	 K9ag697UL8QEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] scsi: qla2xxx: Unlink NVMe unsol ctx before freeing on LS reject error
Date: Fri, 11 Sep 2026 14:16:12 -0400
Message-ID: <20260911181612.1319441-3-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_nvme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 2a31dc075936b..2c1e0db89140a 100644
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

