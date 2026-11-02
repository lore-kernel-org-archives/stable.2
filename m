Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.24
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793598805;
	b=cvCwIano3XL98Xvw+rPE80xrvAzIdOmgsla44SFoH1k3sshwChrx6gyszU8aBNtuqmod
	 o5lE0emKT/CHibJj8s335q2buqmksWRQ5JQVazmE/vmMMUbpVFk0of7lrXGevRcZv0DFs
	 NPW+thmExiobYhXUyppPvj5imJWsU4SZBr0MirClJfPrzPIN2Plmsuh9dhQlpgA5ty1iE
	 cjtvQc4jNhlVCrdUKtDynAUS/egP/NSHoq0uWjQT6bAvhdL+/wY4wbCJkxrbJU2KKHGE7
	 2/VGBAX1lAbRFc+u39aJ0JumFp1L6c7qYcmOW+bAvw3oZGhtPhQMssZCe5tt6/PqbQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793598805;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:MIME-Version:Content-Transfer-Encoding:X-CMS-MailID:
	 X-Msg-Generator:Content-Type:X-Sendblock-Type:CMS-TYPE:X-CPGSPASS:
	 cpgsPolicy:X-CFilter-Loop:X-CMS-RootMailID:References;
	bh=qcW9XAsFiuUq32PNMAmqBl4/oHi88EUsI7bp2ycUdV4=;
	b=dCCRn7uHt9elVlvUdObzoMuGqjRL2nHEVf+7MyALF5oYPrGl250GiRwfC/EmtiUX9DCy
	 dc9eI9qqNBiqf0dVWsDKqZYOs6Cm2+y2/nGWMpm3gWQ4mEf7o4ouM2IhMLDyF6V0TxfUp
	 C9tlceey7plkyO/o9rCmII2qhMjPXBwwt9V1/G3yK4yD4Q4tqq0qLWzLPriqiAkqXuc61
	 S3aLoQXKOnWs3aUqsRwnOIHt9NPAewO/MrqVWE7pbj/z1b1EYYdv7mpwY53VPIS5JiHTt
	 vEXnDKdxsaITOB25KakFhryFFvkErtW4R3Ksr0pnLfI6gry2LLoIWqzr4zTNPPaB33A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=U50LejNU;
	arc=none smtp.remote-ip=203.254.224.24
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D9860A2606
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 05:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37D9860A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=U50LejNU
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20261102055317epoutp01e089dba7d8f140f99b8a0c747aafb733~kJJp0THj22676826768epoutp01m
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 05:53:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20261102055317epoutp01e089dba7d8f140f99b8a0c747aafb733~kJJp0THj22676826768epoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793598797;
	bh=qcW9XAsFiuUq32PNMAmqBl4/oHi88EUsI7bp2ycUdV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U50LejNU84WXyKBrGetaMnJzuWS3LWcNzRbaSaxWzG6bM4ZVBAmbNhhOEsy0tYMEI
	 KT0DCGf8ppb3JTCHbzE/rcfdAYV33H7CnXPWBn2FXnp3sFVBh3uB9hAM2rzJYBGMBG
	 iA3IN8J9iGg8x7kB1KVAQf9aUMpWCz9D3UzoRrZs=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
	20261102055317epcas2p4aaba079e4e44482c52a2e430afe40f36~kJJpelUTA2911529115epcas2p4l;
	Mon,  2 Nov 2026 05:53:17 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.38.201]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4jJ18X4wPMz6B9mJ; Mon,  2 Nov
	2026 05:53:16 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20261102055315epcas2p4024322466144d1a59b4e8fdadfdbec2a~kJJoeEkH30407604076epcas2p4O;
	Mon,  2 Nov 2026 05:53:15 +0000 (GMT)
Received: from apsw.samsungds.net (unknown [12.80.211.160]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261102055315epsmtip214ab499b44572d96f6210daf03cb4712~kJJoYVTzD1621916219epsmtip2W;
	Mon,  2 Nov 2026 05:53:15 +0000 (GMT)
From: Kiwoong Kim <kwmad.kim@samsung.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	alim.akhtar@samsung.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
	bvanassche@acm.org, kwangwon.min@samsung.com, hy50.seo@samsung.com,
	cpgs@samsung.com, h10.kim@samsung.com
Cc: stable@vger.kernel.org, stanleyjhu@google.com, Kiwoong Kim
	<kwmad.kim@samsung.com>
Subject: [PATCH v4 1/2] ufs: core: skip ABORT TASK for device management
 commands
Date: Mon,  2 Nov 2026 14:52:57 +0900
Message-ID: <6e40b9a374f50616e84ce1f974da6ec27a79cbf5.1793598099.git.kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793598099.git.kwmad.kim@samsung.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261102055315epcas2p4024322466144d1a59b4e8fdadfdbec2a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261102055315epcas2p4024322466144d1a59b4e8fdadfdbec2a
References: <cover.1793598099.git.kwmad.kim@samsung.com>
	<CGME20261102055315epcas2p4024322466144d1a59b4e8fdadfdbec2a@epcas2p4.samsung.com>

In MCQ mode, ufshcd_mcq_abort() falls through to ufshcd_try_to_abort_task()
for all timed-out commands. However, device management commands (query, NOP)
use reserved requests and are not SCSI I/O commands. The ABORT TASK task
management function is designed for SCSI I/O UPIUs and is not applicable to
device management UPIUs.

This is only reachable since device management commands were converted to
scsi_get_internal_cmd(); before that, a timed-out query was handled by
ufshcd_wait_for_dev_cmd() -> ufshcd_clear_cmd() and never reached
ufshcd_try_to_abort_task().

Fix this by checking ufshcd_is_scsi_cmd() in ufshcd_try_to_abort_task(). When
the request is a reserved (device management) command, skip the TM path and
call ufshcd_clear_cmd() directly instead.

Fixes: 08b12cda6c44 ("scsi: ufs: core: Switch to scsi_get_internal_cmd()")
Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index bcc2512bf34b..7fc80926eeec 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8046,6 +8046,9 @@ int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
 
 	lrbp = scsi_cmd_priv(cmd);
 
+	if (!ufshcd_is_scsi_cmd(cmd))
+		goto clear_cmd;
+
 	for (poll_cnt = 100; poll_cnt; poll_cnt--) {
 		err = ufshcd_issue_tm_cmd(hba, lrbp->lun, tag, UFS_QUERY_TASK,
 					  &resp);
@@ -8091,6 +8094,7 @@ int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
 		return err;
 	}
 
+clear_cmd:
 	err = ufshcd_clear_cmd(hba, tag);
 	if (err)
 		dev_err(hba->dev, "%s: Failed clearing cmd at tag %d, err %d\n",
-- 
2.43.0

