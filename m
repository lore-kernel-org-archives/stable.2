Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0433E8330
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 04:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792039958; cv=none; b=QsBTAAwNlNdw172sHFTDgDiYL6qIXThUkQ1cf/Hzh/13G9HB6odaD9Nun1uzmhZlB3MaZzn/FKgjhEMUQbZVsV2xCy45A5rxqRIpRG4GU5nuwfjmyFSEFyo3PZee1+tsuaFJ317RMRNX2Lzgum/10Vn8wIpxpY1SowifAIWVL5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792039958; c=relaxed/simple;
	bh=MDMjvCG2TCUAEeteskqIDIApECR9YheEmBxAhgDy9Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sat9ns46QcRje/peoAvIEMESoiP+BnBqPmGepo0RDNMQ5bIiJV7c0XODsdVLVT5NtVHxwosy2mzoDY4DyEv5LO1uA6vi7aDlYBYFKtvBP/FMxAnuIGNXXfdHn0oiJ98A1LWLitj7E55F412o6n/JIVQ51ID8o/g2cMHxfgNIz/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=fTpgSHNu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="fTpgSHNu"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e5d0ee1951so30692695ad.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 21:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792039956; x=1792644756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aEUqd/0o0iSnmGjCyVkzuHqVdm5ujeHCGbGGtInTt5o=;
        b=fTpgSHNu+k6P0KkE1k1R2GHkKwPiYwlgklWG+1r2WUmV1pAe+qf4EP9dx9OhbdHWAW
         5hL7PEwgTnXMdfDHtrkidHLco+theeS7D3eLjMa0jXmoPdRTLHeSzGxEtkOK7y/fQyOn
         OK4v7r9CEMVwxUE6Ck6cQX2iSxHmQEv4IC/W0f9jg5pqIPID52yjZEtIa5a3XjOMxRQv
         eZoI8suMNZ0mGASF6h8iFXDYIDS+JKaolGH8JuxgrmA8nFC6VxHCDd5k1ycFPueZa2gE
         /H/aMsgipD51iLKTttELUqRBxlCOsHXvpWnU5e6BbUR+piIodDD2d3CR2WZrZZIuZEva
         pJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792039956; x=1792644756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aEUqd/0o0iSnmGjCyVkzuHqVdm5ujeHCGbGGtInTt5o=;
        b=Nkfl+ZGUOV6zarqX+RSLGQCz0Xh9qtm+jgsbS0HlZubfn1QuaaK6SORo53cvUBhHyb
         ClDeyIpgczWy89dLSTwRA434gPsU7fDctPIARUW5ERP6AvaKoKYUpePKOUcvH8yxoDXW
         CbhVDBFn2Atu8cE6JhJqLnvdRNNYhhNufPdf7neEvJkOF7owj05fCkf8qyq1xTWl8V//
         pDUyFignQxWt/M23I8brHqoQMTw2ecP7F6h6yjoSQ6b13owNMoZcMkRjGuPBRpv2AkeM
         KQq07EIeXw8xPJn6CphXnHLaqwerrNL4Bn8sW7PK6T4S+2tjQK1TLJl/Cn45fdjf+nyl
         WkRA==
X-Forwarded-Encrypted: i=1; AKwUvBzTZ3PyLsQXq/IUsc72T0O4yB5A8Y5iDlecQGrL8CsyGw6ltm07xtp+xyqpSqxGMbkSlKKLjZU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLIbFMjAsK4GiBE8hqaoGMIwVf2E2IAALNT8xx5pCm/dPkLUrg3
	5iBq/7dzDQGHlzd2sZLQJbE1CyXn+RM0bmcoV5tLVDcvxvczqPM4xNP32zs1gG3h+IY=
X-Gm-Gg: AYBFou1uxs4Q9L4KCFlFuCiEbvgqfRFvI2XBNoXaRUPrLONXBMnQZ2K4Wyc1BP0wqnR
	Mnl9+7QBSbfBuYA4VbgJSDXm//0VLLqROExP9xBa8T+6n2qchWEK+C6fCZe6ZrXGfevYlR9vAJg
	vJWzkPhxyWU051De6Zr2HutbQQzGfsyNq4XVTyt2vZTM3xL/wUWkeQEaOfF/aKEFGH8MLaG/Y2J
	wJQTyEXHb1M5MPKR9Guxerir+AsXcQdrov728CN3oFbwG/p7lqofdMGVTJLg81NTH/wZC5GSjtZ
	XWZ/EVqvajqCEx7XsfkPbDUpejf7MaK305vofMklyGwbfM2dPF25N+ou+yXjQXnybWeRcxNoHMg
	SyOnAr0kpdJsZ4UvgCdm9IhSADf2nhpVNzrQqi1JIp+EA3ot15oyT8112/7MEn0w4xufMjEay3v
	XTE55FGFvcQzKn0nE/rpZA7o6dOCzFLjZmQ34Yp0UeBQ/TKbt0BlQS04IspGNyOUeHa604TKGYF
	W5o5w==
X-Received: by 2002:a17:903:1a0c:b0:2e9:5eee:e071 with SMTP id d9443c01a7336-2e95eeee183mr7710825ad.57.1792039956367;
        Wed, 14 Oct 2026 21:52:36 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e962a4dfbbsm1615915ad.58.2026.10.14.21.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 21:52:36 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v9 6/9] scsi: mvumi: validate the response frame tag before using it
Date: Thu, 15 Oct 2026 13:52:10 +0900
Message-ID: <20261015045213.3975845-7-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015045213.3975845-1-yhlee@isslab.korea.ac.kr>
References: <20261015045213.3975845-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mvumi_handle_clob() indexes mhba->tag_cmd[] with the tag of a response
frame the firmware DMAs into the outbound list.  The array holds
tag_pool.size entries, and the only check on that tag runs earlier, in
mvumi_receive_ob_list_entry() and mvumi_check_ob_frame(), against the frame
still sitting in the outbound list.  mvumi_receive_ob_list_entry() then
copies the frame into an ob_data buffer and mvumi_handle_clob() reads the
tag out of that copy, so the value that is checked and the value that is
used are two separate fetches of firmware-writable memory.  A firmware that
changes the tag after the check reaches tag_cmd[] with any u16, reads a
pointer past the array and dereferences it, writes NULL past the array and
pushes the tag onto the free stack for a later command to pick up.  The
check is also off by one: tag_cmd[] and tag_pool.stack[] both hold
tag_pool.size entries, so a tag equal to tag_pool.size passes a > test and
lands one entry past both.

Check the tag that mvumi_handle_clob() actually uses, against the size of
the array it indexes, and check the command it finds for NULL before
dereferencing it: with two fetches the earlier NULL check no longer says
anything about this one.  Re-check request_id against that command too,
where the controller provides one, for the same reason the earlier check
does: a tag changed between the check and the copy can land on a different
command that is also live, and then only request_id tells the two apart.
Make the two existing bounds checks >= so a tag equal to the entry count is
rejected there too, and read the tag into a local in
mvumi_receive_ob_list_entry() as well, so the check there and the accesses
beside it see one value instead of three fetches.  Use READ_ONCE() for the
tag and request_id both functions take out of the outbound list, so the
single fetch is guaranteed rather than left to the compiler.

Fixes: f0c568a478f0 ("[SCSI] mvumi: Add Marvell UMI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/mvumi.c | 45 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index 8b8e5545747e8..2410d2aa147d9 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -466,9 +466,9 @@ static char mvumi_check_ob_frame(struct mvumi_hba *mhba,
 
 	udelay(1);
 	p_outb_frame = mhba->ob_list + cur_obf * mhba->ob_max_size;
-	request_id = p_outb_frame->request_id;
-	tag = p_outb_frame->tag;
-	if (tag > mhba->tag_pool.size) {
+	request_id = READ_ONCE(p_outb_frame->request_id);
+	tag = READ_ONCE(p_outb_frame->tag);
+	if (tag >= mhba->tag_pool.size) {
 		dev_err(&mhba->pdev->dev, "ob frame data error\n");
 		return -1;
 	}
@@ -530,6 +530,7 @@ static void mvumi_receive_ob_list_entry(struct mvumi_hba *mhba)
 	struct mvumi_ob_data *ob_data;
 	struct mvumi_rsp_frame *p_outb_frame;
 	struct mvumi_hw_regs *regs = mhba->regs;
+	unsigned short tag;
 
 	if (mhba->instancet->check_ob_list(mhba, &cur_obf, &assign_obf_end))
 		return;
@@ -546,10 +547,11 @@ static void mvumi_receive_ob_list_entry(struct mvumi_hba *mhba)
 		/* Copy pointer may point to entry in outbound list
 		*  before entry has valid data
 		*/
-		if (unlikely(p_outb_frame->tag > mhba->tag_pool.size ||
-			mhba->tag_cmd[p_outb_frame->tag] == NULL ||
-			p_outb_frame->request_id !=
-				mhba->tag_cmd[p_outb_frame->tag]->request_id))
+		tag = READ_ONCE(p_outb_frame->tag);
+		if (unlikely(tag >= mhba->tag_pool.size ||
+			     !mhba->tag_cmd[tag] ||
+			     mhba->tag_cmd[tag]->request_id !=
+			     READ_ONCE(p_outb_frame->request_id)))
 			if (mvumi_check_ob_frame(mhba, cur_obf, p_outb_frame))
 				continue;
 
@@ -1878,6 +1880,7 @@ static void mvumi_handle_clob(struct mvumi_hba *mhba)
 	struct mvumi_rsp_frame *ob_frame;
 	struct mvumi_cmd *cmd;
 	struct mvumi_ob_data *pool;
+	unsigned short tag;
 
 	while (!list_empty(&mhba->free_ob_list)) {
 		pool = list_first_entry(&mhba->free_ob_list,
@@ -1886,11 +1889,33 @@ static void mvumi_handle_clob(struct mvumi_hba *mhba)
 		list_add_tail(&pool->list, &mhba->ob_data_list);
 
 		ob_frame = (struct mvumi_rsp_frame *) &pool->data[0];
-		cmd = mhba->tag_cmd[ob_frame->tag];
+		/*
+		 * The tag was checked against the frame in the outbound list.
+		 * This is the copy, so check the value that is used.
+		 */
+		tag = ob_frame->tag;
+		if (tag >= mhba->tag_pool.size) {
+			dev_err(&mhba->pdev->dev,
+				"ob frame tag[0x%x] out of range\n", tag);
+			continue;
+		}
+		cmd = mhba->tag_cmd[tag];
+		if (!cmd) {
+			dev_err(&mhba->pdev->dev,
+				"ob frame tag[0x%x] with no command\n", tag);
+			continue;
+		}
+		if (mhba->request_id_enabled &&
+		    ob_frame->request_id != cmd->request_id) {
+			dev_err(&mhba->pdev->dev,
+				"ob frame tag[0x%x] request ID 0x%x != 0x%x\n",
+				tag, ob_frame->request_id, cmd->request_id);
+			continue;
+		}
 
 		atomic_dec(&mhba->fw_outstanding);
-		mhba->tag_cmd[ob_frame->tag] = NULL;
-		tag_release_one(mhba, &mhba->tag_pool, ob_frame->tag);
+		mhba->tag_cmd[tag] = NULL;
+		tag_release_one(mhba, &mhba->tag_pool, tag);
 		if (cmd->scmd)
 			mvumi_complete_cmd(mhba, cmd, ob_frame);
 		else
-- 
2.43.0

