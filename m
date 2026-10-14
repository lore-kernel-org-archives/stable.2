Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C81560AB2
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 16:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791995084; cv=none; b=FdKNXiM2rvSBDc0+Uhpm9dwMpxMHQZ3eqsUuz607kAkmujkMQ65MDbbDHK35qtvkz+aL8fBCA5BTGrnrLaeQAOOm7HUtyuhNZZbI7scd1RowTyz6Yhsfo3hn6XZ10f/oNtqIzRAmn3wNlDY4Lzm/37XE5kjlIuAfOUxHVbLSumw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791995084; c=relaxed/simple;
	bh=dHXBGbpNg+e+e9FaFMYv6bHvO+DnOZmKgMeiXLMgrNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cF03RHy+hfdxlsDYS/yjdG2DuL0DBoT7o+RP0cqNJHac9tQecIUyHObQMHYVx5HxTL9NgYoVQmymJmmqA4JYjeALYyFfWtuPw61HUs5ZiQc/iM93m/IwlKKqMiFHuOSlXQ6uA8YfG4jZq8rqwycaNCineZo7WOkd0CiIsrwaLK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=pUL+nA85; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="pUL+nA85"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1419d3416ceso2002049c88.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 09:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791995083; x=1792599883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9WbeT+q61Zz+Q53d2ugaJoCi43RLay4hpDLxrJKaFHQ=;
        b=pUL+nA8596yPEN3a4CwTknDBtfmnWnZlss8Cy4kiept+mX5mFZC8i6D8x9BDRNuLon
         hBd4E9ZWbTrhVtvKTGQYFhkRLWAhjlj28IivMB5co6BpWBb+tRXSgvfJadx4vU7A4uIZ
         CAGNGhkRtiiFVZVQQ2yk/er45X5ueCeC3GQ4DLxqW0G7Jrv2qQcEdR5xcxpZTK3EsMjC
         GIvFA9T6ClJxzgZ2v71BTAFfvuirw8XJK4/NrCfHsdHagaAONoBZF2v4AAhDm0uxsO87
         5xkXn80GeWBMIrVzmbrb1VKcg7Sp6vPDAVs1KDTI5Fm/u0FKbjXSAZOZpCm5+MD6SdX0
         zGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791995083; x=1792599883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9WbeT+q61Zz+Q53d2ugaJoCi43RLay4hpDLxrJKaFHQ=;
        b=WR/mg1tfX8VFLfOj5t6tv4rPYOoFjIhpa6xqDsCTD81rUDndpEW9Y7okMYZ+9MgssK
         obHaQxf5cl+T0Ltd8iuRVr5VSSz2Cw+Lw655KXJwpENUIf05DaU8Ha5fYcXfWuVbStvI
         Gix8sqKvHFjkRdOQmtKttYay5SZSbPuWcnc9HyTOgt/tZTMTJKeawDnSsFbuvqV+EFlu
         Jmf/LwL+0RSk7xLafcGzCdQOiHRQA+iZLeat6NlSx1ZL1xAW5b9GepL2Wg8mDvDaV01x
         rPAzAMk8IQuSYChxm8HAjfVhVIgu5I2XVQ/eyohKR8feKV2S2y2nnnIcNdmOfQp2fdgl
         mcHw==
X-Forwarded-Encrypted: i=1; AKwUvBy9jsJzJ1u4fbcQuRf570SBTR+ERR9YvCZWZNgJNlQ3Py6dyAs2Fxprp2mk5IvBVd+BCO+VR4Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWuELmWILb+UQl49uf1764ugTghJeC7jh24o5C5CUzdTEMFTBW
	vmmP9dcALU30m+Ls7WCoT4mGDYwqLFiXt4RlduW4YL57xf0/rwlRRfJut2e2Yr3fjno=
X-Gm-Gg: AYBFou26tjMBLeqTQrY7tRmcpZL/YhOAIWf144G6kUxrgVavmOsfkLq4zcc95Ww0/Pi
	j/VsgcwRVULbFUNrEWKnfIHcmd+WbxVe55YBlqLLVTSwqjrCwoYy8lvNvEJXHnsGc0Lbp1i2bT8
	xslGZCm2+Lq5aTYTSfQP4IjzgyRQILgTwWXheow2DC2a8Mpf5/4IFTJvD8W0htVlBFjJaMRqBy+
	jCYgaMQgp7dbz/i22P5tWzeQIPDwJEEyZRSYTVF0dhN66YrOnT7HHVpXZCTiuauFZIeR1BOm30o
	U2iAnGDDLtJLhnghurT76TsHCcYggYCfxwn/lfKCaDmaE5QeJhGGCcJ1EXpdlyPRU+CloEBrdIi
	zGq+6VEpnraEVimz4U+leVysDMGow+1nS+mydI2w88HIqMi0CC32MN2vvRS/6FDHtFxqrQ1nbop
	UcT5a6TpLQOFqq/wbVMgyBdZUk95AsstciYbKgqJKYBLoW0rwI4p6PEycOMvNhhT2xKnr5UpqfH
	GogVrSR6DkjIVFA6kC+
X-Received: by 2002:a05:701b:454b:10b0:14d:baf5:c40e with SMTP id a92af1059eb24-16a5faa76admr20281854c88.8.1791995079735;
        Wed, 14 Oct 2026 09:24:39 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:1c49:61ee:8c8:3f4c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1dd57d0sm48816685c88.8.2026.10.14.09.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 09:24:39 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v6 5/5] scsi: mvumi: validate the response frame tag before using it
Date: Thu, 15 Oct 2026 01:24:13 +0900
Message-ID: <20261014162413.3649841-6-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014162413.3649841-1-yhlee@isslab.korea.ac.kr>
References: <20261014162413.3649841-1-yhlee@isslab.korea.ac.kr>
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
anything about this one.  Make the two existing bounds checks >= so a tag
equal to the entry count is rejected there too, and read the tag into a
local in mvumi_receive_ob_list_entry() as well, so the check there and the
accesses beside it see one value instead of three fetches.  Use READ_ONCE()
for the tag and request_id both functions take out of the outbound list, so
the single fetch is guaranteed rather than left to the compiler.

Fixes: f0c568a478f0 ("[SCSI] mvumi: Add Marvell UMI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/mvumi.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index 2871b4c96f1c8..85624efcc1725 100644
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
@@ -1886,11 +1889,26 @@ static void mvumi_handle_clob(struct mvumi_hba *mhba)
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

