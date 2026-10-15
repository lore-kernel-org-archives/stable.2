Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43883DAAC3
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 02:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792031279; cv=none; b=A7aIv9cdK6d8XrOHocdvnDn+ydoHvswhgJIuH1rdnAMfh0gDe/t9lhZgCIfiwYG4XnsneSh1jV1WMpA/l3X8l0BgTgmJL+PHDEru8bFMQjWeY3Miyj0ujicdwR5OW/JGTC7Hp/sH0btaj/8HD09u6mlOLCaTjgOevTSPmFH8bE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792031279; c=relaxed/simple;
	bh=MDMjvCG2TCUAEeteskqIDIApECR9YheEmBxAhgDy9Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7lLXuNIYOhPqoNFlkP2y5ZMlz9yfH0K5iYUm/523vmbHO3bCZSQxDVVb1M4/YdJfHqt8VhJ6m/uGSLfq6SMEvsFrFPJ7ch3mzCZ0jePTn8hDximIOncR/UJW2oH0tZHXCaxGwgEY702sWZEC1v+G6QMgOMVUBrvr5I9+KrNeMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=mBZn91Cd; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="mBZn91Cd"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so874719a91.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792031276; x=1792636076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aEUqd/0o0iSnmGjCyVkzuHqVdm5ujeHCGbGGtInTt5o=;
        b=mBZn91CdNB4osK+8+OhZYabu0Q8jrHcWLZTXe8s6F0bBlx4g3dE3JQq6JDWTqwaVHy
         B1XPRINCfLsAbNml13kgEWDNA6mhEN1GHxc8aEqfm8me1s8gSguRUhV6ICoQzFUT0a/e
         hFMI9RkCtuESyboooIFuso6WGoIqGDP84m24yljLD2qU4/Af0N+NzgnEB82/9cUmqDdg
         ik6+oLuoAFI1tDYxWc//O56CQwG2OHR0F+C5Mk79gjDQLzPbLIaCknouGueSVvkVK/qJ
         9QcdQMuDEgJvyJLEcojOqp8WxZV614EGknY/fv09EUCU0z1abFeX8XaQnSnikS2DKWaI
         xtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792031276; x=1792636076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aEUqd/0o0iSnmGjCyVkzuHqVdm5ujeHCGbGGtInTt5o=;
        b=FET0U9B/QAu6UFGDVo7qdBre+ZtHMZ+/fzgAjcHXawd/ZDyONuDipBctEI22u2THBY
         SM9VmCIr9eDYv98CFBvTDcDoStGyp2J1nOpOtna1BUdMyvZucj3mu4fx+8LtW1afauab
         KcC61a0aJAQcFmTrfC8Vw2JCeD6ZDT0kueubvXfeE4SPNzLntOqgrN0xhHyzR/Jj9rx3
         LY7H2ShfBlnEDLgWWwrkxKBcMjCALErfHxIyYWV2q99b6zZzemZl8fqxIxY0+qi2JZ+N
         1mU7YeMeJzVOKDup6MOEZP4K6DTbFPklSk4a43ufG8lZRDUcNXLL7qeEY9F5mHPpJl1d
         x+HQ==
X-Forwarded-Encrypted: i=1; AKwUvBzIP4kKB/bg2/lqLtfNLefpsvrmxS6Zk7Rb3SJ8cpdh1jc/ywkcJcRQJtkpCuNYVen1wdREjlY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjsooGOW3SFX7JrdWelE9Fu1ZexZqoEPuwUg9jFAoG8fluCugt
	7VrjCi42aXyYDYMVVw70Z672IdLqw9PDIvPCBmw2ntKrw4Aw9lrRO+r7MvBrJBvom6A=
X-Gm-Gg: AYBFou2M7CcbfwZzmyYxI3+UoRfUCY/owrb/cvuZ0Cgfos4ZbwRZpWZF8foyPhA5nyO
	a2s01k5SBHmh3hmIqgeidVbkD/zg6mR0/RrJ5V66sXYRqHNeuxLetsWmmsuEd6L2UHYJZGKVVXp
	y53tBVvD42kdtrnsbPEj7NfRe5yIYJuPuU5/cq0Axih3j5TWvlvh5zvzpVVsl0GNqKvx0E/365O
	ii1s3HLSFU63qNlFSI2bk5bt0LCnoMHovv92MUt9huctHe7dW/JBBNMVfg1IdW/9ymnIrq2Vqgx
	3Aec0sQWklAmzqANZPR2wRFxFaY/yI7NApQKkCSqUrTbAkyYUGfFH80fmapZoasKxXDJxU0WOUV
	bXFfzTCzicT05ejgoUukXCRScl+LESdp+VbjuqHYeJ2tus4ySYoghC7FMZnsZJMkw+RPZtCAV7R
	QD2RJCPLNlfXAN0BDlexnvGWqBnSW/7k13RldZXtGMjIlL4Ddw6bHkuBQB5bjN7zQm3O2hnsdnf
	KoO/A==
X-Received: by 2002:a17:90b:3145:b0:3a4:b0b9:6b3e with SMTP id 98e67ed59e1d1-3ab3ab40fa2mr14795649a91.36.1792031276325;
        Wed, 14 Oct 2026 19:27:56 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94375f3fsm1997383a91.4.2026.10.14.19.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 19:27:56 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v8 6/8] scsi: mvumi: validate the response frame tag before using it
Date: Thu, 15 Oct 2026 11:27:26 +0900
Message-ID: <20261015022728.3936714-7-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015022728.3936714-1-yhlee@isslab.korea.ac.kr>
References: <20261015022728.3936714-1-yhlee@isslab.korea.ac.kr>
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

