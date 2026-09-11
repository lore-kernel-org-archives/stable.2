Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056B246D573
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 17:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789149160; cv=none; b=jVOIO4+9Dye1izekzTELZYji2v6lOwjfhRXT6LfS3AtTyH087+Mh9KjzH0jEBFfnEpZ+piD4Rh0ZeqFr4G6NnC/731GiAFvSnx68OVsTJ+WM/4/IuByOhDmGZszBA3cAALg2Wks3RinI5UCag8kUn/QH4DcsSWh/BhizmzjX/6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789149160; c=relaxed/simple;
	bh=jOJScXaSD95cTaPYTa3+dydrgESOMYcuv8xqcdE3xkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7dOWOWPGW+UnrLFOTNfzc17GSAvDrgQEQzOSYqsPvCnr08MsFzmFB3WTG8W8ntAE2NGj8hPdNFd0yUvOMJMzswjU52v2yhu2aUzmcOb0QT2EAYvq1Rgz4QrTkFVlVwMFL2SxS0LN0zHNJVrGJ3A2c4I3+ws3OLbQpai6cwUhMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/A4V2bj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/A4V2bj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06821F000FF;
	Fri, 11 Sep 2026 17:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789149158;
	bh=PgV2BoYOCXVtoN5O1vPOy7A8VKCinLg5hr7cQa5DZ2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N/A4V2bjZoHUps6cx34t+By/7QCdh17ZzAXHiGlRSnc2JsrYAYuqgJVGM1s5DpdQO
	 ZuA1dwRx/a27MHoxDCweUsn+wy7oB5JzH8VnTMF0u+6W9OpP+2ok0pTT3PDbXxmXcE
	 vhWB8Gjic+L1EjbRhOc+kKJ6VhNX93rL3Yo8Ng5LyU7fRXWHoT2YS9IMwOCDenl5AW
	 IDsf5UByFywgz83GyLBEfgiib4r5Ba9wvOshZMAG5GkFTZC6VUvYT3iBgDp/X8rDQY
	 GjxLuN1hpzWyjF5jNX6TP2wEDJh9e0q9PzKjJi7gmj+n4U+OIbJICR69w8z5gQDBpv
	 3X3UBrUauBfqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/2] scsi: qla2xxx: Unlink NVMe unsol ctx before freeing on LS reject error
Date: Fri, 11 Sep 2026 13:52:35 -0400
Message-ID: <20260911175236.1278823-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090923-cape-equate-4cd2@gregkh>
References: <2026090923-cape-equate-4cd2@gregkh>
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
index b84fe71ea340d..ebe236f5b5d50 100644
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

