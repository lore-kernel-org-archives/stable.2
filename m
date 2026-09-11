Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFD44AD4CF
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 18:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150916; cv=none; b=EYZAk9wDkDqoXtMEyx8Bte/1VenRPCnzv6t2QdbeaZuRsXKe0APsjvF21wADxrEnpSCAIVXnLeCxi2Qjd5xRG1j9tRj4aHbEEpB18o9JmzEfiIwsz6PL5cHGHh5nWkaHJi7x/1wesarsGiVMpZHbPkwnTcYhzsMd/wFQBgQ4/5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150916; c=relaxed/simple;
	bh=R/qr0nhPMGUbuNwLl50zsk4y7T/Qp40tBzTimbDOufo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDytHxWYv4vZ8aBePtZ0PGPWNIAowqaTEmDLaas/+NdbenIFCob2pglaMAiR+F+Q16pjtNgUUZ5CRpdd9Tl0TVJty3xYtK6YY2HSWVDq67UFc2RlOovnfa84VWoHWZqbnDZ5kEtIHGPJDS00wHLjOcYywt0o8R8yR3icp3mFENw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtHyO8q8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtHyO8q8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29181F0089A;
	Fri, 11 Sep 2026 18:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789150915;
	bh=d6YnjXU9CxAzM6BEdnkSC5CXKHo7LLLLqqYfPVidO38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GtHyO8q8RZ9WZbW3B39vwgL1j+vxUtyCna+a99fcW5Y04m6MT3JIP6zgxD9DsTft3
	 Or8JLZNQTgu2oRi0pINHZa+LGDBgRgn9B1ZJ4PZbMnPAzYpU2hIrK7TP5znmPw9IP8
	 fLFcju6kDgtWsLhuRxzIiLYRCaYGoUfzYHOcNKVbEtQC8YB+ECFCbLsxypmct2d5kn
	 ZqQdxmrjrcXU5P4vJWbjrTzVKPvN1B42c2MnuMhfhqsG2WO68Dw5g+PTmk9yBXgMne
	 1LIcRpf/3PQV6MxRrqmDuxIkxzmniFtkXPSCtx3kj1703asfG8CloNcn67f5LFdWiz
	 QGSSRpSlNDoFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] scsi: qla2xxx: Unlink NVMe unsol ctx before freeing on LS reject error
Date: Fri, 11 Sep 2026 14:21:51 -0400
Message-ID: <20260911182151.1324762-3-sashal@kernel.org>
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

