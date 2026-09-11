Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74294AF9DC
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150236; cv=none; b=VgjMWmi3V7y9Wdh9U3x1qH+rMymYFkI+TJo0q3foByvPEzu7bpbiuKuXZDw+ge3Ev0ZKo8+I5OKTwJD0zQY5AKxzgPVpspraK2FEX5MF3RsispuUzWI8Ck14tz9mkSBRL8OLEaKb6vUKFzkkMuxi1NDW623qPS8onPtpf9rfHso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150236; c=relaxed/simple;
	bh=FEMBIrVEx09XWdNSV9lBj2MgxeUN/flR651Gz31Jmjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGLG0LSA7lrEvCPvn9pXMdeqLwSwOZVEulz9TlyWdT+skymofM3pwUSC4oAa352ZYkpojW86d0XuWnwtXcTWyDD8hQryaf51XIVkEhCTPf5WhOYV5PGhWWj+CqMkqBtcT+468tURsvPgOo2/IusJncg3Y6cwRmud+nv6N+/zshc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KL46k90a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KL46k90a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8EA1F00899;
	Fri, 11 Sep 2026 18:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789150230;
	bh=3jVR4OD6okUv1Md+oHNCpGKjx7Fd47nyUXoOxwZvTso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KL46k90afGaZjtE0YsNm2O+QfadxDXWenokWmZV0NkTcwE5X3cxtFVsqqMsQA332c
	 6ICXSS/DbXT/14A2a74hbw6XPIuPB167RM/ZNLWFf1T6OMh9b0lSJ58q5mPT0RK0pj
	 u7vf3icab/BrXWxNWffy9n9Vk785toRQeEDQ5PrUnjdLaWJR2hY9tG7D9uynEkcKaf
	 BEG/vRvpD6t42XIJatmBQ2zeD80qDHixztS64ng1+FLsa7OlkfaI2EPyQ87fc4uPCx
	 t5HudX6el+s8NLwmjQf7BqOeLX3Oxp+HbLlKXrYvwZ/iA5731+Oz6UOvretY4frnXb
	 ioUq8AtdrptJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] scsi: qla2xxx: Unlink NVMe unsol ctx before freeing on LS reject error
Date: Fri, 11 Sep 2026 14:10:25 -0400
Message-ID: <20260911181026.1306489-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911181026.1306489-1-sashal@kernel.org>
References: <2026090924-wildlife-washed-3972@gregkh>
 <20260911181026.1306489-1-sashal@kernel.org>
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

