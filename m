Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793938386;
	b=28z/mDr6EoQKSPv7tnxns/QKFfVz8hS37CsTdwwMXoNGWP0pNGhslvpk+pVAwotNyVdL
	 KD26oJSAq0H2QFomSRPxjFXlhC+tX3B+o+cdceIrkcS3MuMfvPqE7fHIUuzJctJ46SYhz
	 pNS3rR8cCQklPPioA1OUFs4XQQHiYHDEOmmPZg9pptmPFU5hrEQy28WYVzAtvrykri2Yt
	 gRnq/tIF6TP75Lhi2GnfzI6njJtVfxAhrEKiDppqj3sKfneEmP2+vYDsHIyhpvQk+Zy8n
	 aBc5peSoOAT3FQTZ2P1qkFFD8oFXLpcb4mtkdbGXXz0ZOgNMckP6+IeEmbPV3zpRSMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793938386;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:MIME-Version:Content-Transfer-Encoding:X-CMS-MailID:
	 X-Msg-Generator:Content-Type:X-Sendblock-Type:CMS-TYPE:X-CPGSPASS:
	 cpgsPolicy:X-CFilter-Loop:X-CMS-RootMailID:References;
	bh=duuP0Pop+3aeHfM6jJi0jRzSxPHe2DXxDER+TP7Wn4Q=;
	b=G01nH4ghy5/Ox3tSd/ODLGpJGvvv1R+5rNddmbsoshAO6hzB0EU0X+I4AvwG1GSgN8w/
	 38T3GR+s6up16bRRQ0goifl+gpfm+lb3F9jKKz4ItmY91hL66JzJOsZnUAcGcQrnDPcRP
	 61WxP7C92NUKNKQ5mZUf75l9yEX+9gbmUXBW+uv8dOFDH2RXZ9nMr6wJxrsAIKrwXY42i
	 witcV1FU6g5/hSYYmP47wOzq/DnHvq0UP6QMLNlzQNmnmuCreulp8RcXZCwQyf1Ltjulb
	 WnCR2a7RxfmeUmU1RJAZqd4NCbmCrYV39ZwjYGH6FJws2/imqk0RCmhCYGjMv+ycmgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=W0sGFBE9;
	arc=none smtp.remote-ip=203.254.224.25
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3677606A31B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 04:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3677606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=W0sGFBE9
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20261106041303epoutp02bfefbe979fb6206d7058ae2fc2ad3818~lWXR0QwS60571505715epoutp02T
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 04:13:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20261106041303epoutp02bfefbe979fb6206d7058ae2fc2ad3818~lWXR0QwS60571505715epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793938383;
	bh=duuP0Pop+3aeHfM6jJi0jRzSxPHe2DXxDER+TP7Wn4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W0sGFBE9AOHkQBqwBF+eEph+XXhYPvdN+pcRkTrlqyNN5fzxBryA4RVDKezhJ2laQ
	 JQGAXI5PUZKv+/c+aNydjF1sUJrjerKrEpUkbyQfZvvFY7xt92NXO6WrAdC0iZnfXK
	 q3/3cJakhouC9zCioIUdWj1zLmFmyMsK3fWR4l78=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20261106041302epcas2p17665934f437a42bd8b8f971f71b30608~lWXRbcLuU2326223262epcas2p1m;
	Fri,  6 Nov 2026 04:13:02 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.38.211]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4jLQl23f9fz2SSKZ; Fri,  6 Nov
	2026 04:13:02 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20261106041301epcas2p39724ab936d6c1cb3b5b899f674623975~lWXQkKgGn0832708327epcas2p3u;
	Fri,  6 Nov 2026 04:13:01 +0000 (GMT)
Received: from apsw.samsungds.net (unknown [12.80.211.160]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261106041301epsmtip1026591c02ffb2a4588e103e96f823e16~lWXQV2SBH2786727867epsmtip1R;
	Fri,  6 Nov 2026 04:13:01 +0000 (GMT)
From: Kiwoong Kim <kwmad.kim@samsung.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	alim.akhtar@samsung.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
	bvanassche@acm.org, kwangwon.min@samsung.com, hy50.seo@samsung.com,
	cpgs@samsung.com, h10.kim@samsung.com
Cc: stable@vger.kernel.org, stanleyjhu@google.com, Kiwoong Kim
	<kwmad.kim@samsung.com>, Bean Huo <beanhuo@micron.com>
Subject: [PATCH v7 1/2] scsi: ufs: core: skip ABORT TASK for device
 management commands
Date: Fri,  6 Nov 2026 13:12:46 +0900
Message-ID: <ab14d2f1414fa1a0a396f160abf8c27c404b4ec4.1793938245.git.kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793938245.git.kwmad.kim@samsung.com>
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
X-CMS-MailID: 20261106041301epcas2p39724ab936d6c1cb3b5b899f674623975
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261106041301epcas2p39724ab936d6c1cb3b5b899f674623975
References: <cover.1793938245.git.kwmad.kim@samsung.com>
	<CGME20261106041301epcas2p39724ab936d6c1cb3b5b899f674623975@epcas2p3.samsung.com>

In MCQ mode, ufshcd_mcq_abort() falls through to ufshcd_try_to_abort_task()
for all timed-out commands. However, device management commands
(query, NOP) use reserved requests and are not SCSI I/O commands.
The ABORT TASK task management function is designed for SCSI I/O UPIUs
and is not applicable to device management UPIUs.

This is only reachable since device management commands were converted to
scsi_get_internal_cmd(); before that, a timed-out query was handled by
ufshcd_wait_for_dev_cmd() -> ufshcd_clear_cmd() and never reached
ufshcd_try_to_abort_task().

Fix this by checking ufshcd_is_scsi_cmd() in ufshcd_try_to_abort_task().
For a reserved (device management) command, skip the TM path and call
ufshcd_clear_cmd() directly. ufshcd_abort() now calls
ufshcd_try_to_abort_task() for every request,
so its separate reserved-request branch is removed.

Fixes: 08b12cda6c44 ("scsi: ufs: core: Switch to scsi_get_internal_cmd()")
Reported-by: Bart Van Assche <bvanassche@acm.org>
Closes: https://lore.kernel.org/r/8446dc27-9518-4b0c-b9e9-116458210616@acm.org
Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
---
 drivers/ufs/core/ufshcd.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index bcc2512bf34b..b9aa0b692fa5 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8025,11 +8025,15 @@ static void ufshcd_set_req_abort_skip(struct ufs_hba *hba, unsigned long bitmap)
  * @hba: Pointer to adapter instance
  * @tag: Tag of the task to be aborted
  *
- * Abort the pending command in device by sending UFS_ABORT_TASK task management
- * command, and in host controller by clearing the door-bell register. There can
- * be race between controller sending the command to the device while abort is
- * issued. To avoid that, first issue UFS_QUERY_TASK to check if the command is
- * really issued and then try to abort it.
+ * Abort the pending SCSI command in device by sending UFS_ABORT_TASK task
+ * management command, and in host controller by clearing the door-bell
+ * register. There can be race between controller sending the command to the
+ * device while abort is issued. To avoid that, first issue UFS_QUERY_TASK to
+ * check if the command is really issued and then try to abort it.
+ *
+ * Device management commands are not SCSI commands, so no task management
+ * function is issued for them; only the command is cleared in the host
+ * controller.
  *
  * Return: zero on success, non-zero on failure.
  */
@@ -8046,6 +8050,9 @@ int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
 
 	lrbp = scsi_cmd_priv(cmd);
 
+	if (!ufshcd_is_scsi_cmd(cmd))
+		goto clear_cmd;
+
 	for (poll_cnt = 100; poll_cnt; poll_cnt--) {
 		err = ufshcd_issue_tm_cmd(hba, lrbp->lun, tag, UFS_QUERY_TASK,
 					  &resp);
@@ -8091,6 +8098,7 @@ int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
 		return err;
 	}
 
+clear_cmd:
 	err = ufshcd_clear_cmd(hba, tag);
 	if (err)
 		dev_err(hba->dev, "%s: Failed clearing cmd at tag %d, err %d\n",
@@ -8194,10 +8202,7 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 		goto release;
 	}
 
-	if (blk_mq_is_reserved_rq(rq))
-		err = ufshcd_clear_cmd(hba, tag);
-	else
-		err = ufshcd_try_to_abort_task(hba, tag);
+	err = ufshcd_try_to_abort_task(hba, tag);
 	if (err) {
 		dev_err(hba->dev, "%s: failed with err %d\n", __func__, err);
 		ufshcd_set_req_abort_skip(hba, hba->outstanding_reqs);
-- 
2.43.0

