Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA3E311C36
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 00:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792025872; cv=none; b=TRF5k6YIjBFKGtw39883F+9Bvyh11gsgxJGm8/nNhNExnq/Y35A9Ase+igTKlMlhlXiWItwR6dZFRmeoXWRLqqBObFD3hQrQ2PJzjNbZ7qsdXzssfxZwdKFOS1WIcCAtudoeIcl6renCMww/kLqhT5E3zH82Rnh/r6OCfBqERnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792025872; c=relaxed/simple;
	bh=MDMjvCG2TCUAEeteskqIDIApECR9YheEmBxAhgDy9Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSt+mFqt4bEi7j0PqUcr2nbAtbDFjB9xSFX7W4M4ij8ObSfidLDaM4NjUFz9gWh85V3dt1cLoEk0u2YMgg7fOBKl2E/aUq+CIOjezZGD6CpHN9JBlrJHhJrdDT0xJqPQqtND45auWdxGd2qXSPAwypXhoih6u7tKqrclxj/Ot78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=bWYQupSl; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="bWYQupSl"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ab3260b2cdso2093258a91.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 17:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792025870; x=1792630670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aEUqd/0o0iSnmGjCyVkzuHqVdm5ujeHCGbGGtInTt5o=;
        b=bWYQupSlaGu+v35vR4d2aYMVYvLo1Kq46TFl7QVl01Ns0vbPs8BABlFP/paY10GYQv
         NumLpqhngrUM1UcidDbN6H3fEAjNOFHt5DVxI0prElDmK0fTMS/tcIJ+s683QmewH5aJ
         WICcMf+7drb2U751ceKMrYBUpV7irfFKWV2yUuD917Fxec4jIqUckNDixM0j09yzIOrT
         9QzEgIrpQX51Q4/TrjpQQe7rzLw+tlFu6EBuVwCU7sbNqYShm1SfYzqIChNaexPaneEw
         rrT//NIL5Bp8wCJ/qBdAjuWgSMGDNm1LucwwALk076+3fIPy7kIMCPbu60EtdShvzHMY
         lgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792025870; x=1792630670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aEUqd/0o0iSnmGjCyVkzuHqVdm5ujeHCGbGGtInTt5o=;
        b=SvzYzFeZoF5wv76z2kPUiOWuD2dNveWu0+b+u1J+cC2ME8IKrvEQj+smK5YU+H7hOM
         VomlDhLh26ohaMF5mlfuJqe9tBnptKzZz/lmcI+PjqYvJwK5lCRbdDBNKfGwNBcFI9JQ
         5xVz8D4tA4dSj6sVPwyLGXw+MSlmoqrpUljO+iNSWbQoSIMqDuBv0RTfVWAPDHocy6Nw
         jupM4nEdfVAbkT6HIe5nsD3f7f6vfhB3wW8yYZItQy/lZGqCRvFQUbKIExzdXDAeJcEm
         qyC1XxbRaC7AqJiTl+qD5rJa3xRwfM5dWEzYP7e8yyZJPwUSllotPIQ7tMkD0f7e3rGW
         eHUA==
X-Forwarded-Encrypted: i=1; AKwUvBw73tYWKraU+ScS3jQnewinmvD3/lwqJwW2WW+byXJpIXCCj07pM2JFFh67ZMEtux9v/El1EHo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKNoWscrY5GBwX0LvLTlbDU/k7pnMxu2I5EE6QJ9MC/E1Y1N+je
	p/P+IC0zAAoqnyaJVINuEY1vSMzJFPTCDZ2bwbnp4zOz7opoANmivRxSH/LNq7llSaKyBSfGgNr
	gGmwv
X-Gm-Gg: AYBFou1KyBoKIkM0awQL2kATop5aPyg/WJE52iLUZ3uWva1Bscwa52rCjbP8Jc+CD5c
	eQoxtvSGnKS1HTVP4QJGMN9rWWFv4CLYajN8fW0E+fEDKGQV06IHvvZm9M1ldTPpjAK0h8GQBPG
	9r8lX0yQGthPaiMOlDkt7R1iZHD7K05zMWqp0+zsjoqGqLKqYRbIbWWsRaJt056zVqR8TUVct/0
	Z+/8EPelYwix3nJbaX3e76LdSO0G5xs3L9Cc8imP3EBB0Xqhw+4OfUX7gqnlTTk+L8gI4KaYNZg
	woiTFnxrD9qFGhf2WM98fO2/rkHq6Pl2cjc9rv7lpiwKEg45GQYdWb/v97OwquJtMlPciUvmk/7
	q3biUZcqjq9OyETeSlX/PeQTcgBs8ObrF1uXDcglUv/OSbPYsexcl+YBYfloPZ/8KOYHd041v6A
	vu22hkqZKGTtqubG4uzK/gcjgkFv4UzDna/29Ptky1BubcqklyyBCiA9ay5A6FtToz9n1WnlFyw
	Gj9ZA==
X-Received: by 2002:a17:90b:134e:b0:3ac:9259:1234 with SMTP id 98e67ed59e1d1-3ac92591527mr1178419a91.39.1792025870203;
        Wed, 14 Oct 2026 17:57:50 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac92a43d98sm999198a91.0.2026.10.14.17.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 17:57:49 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v7 6/7] scsi: mvumi: validate the response frame tag before using it
Date: Thu, 15 Oct 2026 09:57:16 +0900
Message-ID: <20261015005717.3719956-7-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015005717.3719956-1-yhlee@isslab.korea.ac.kr>
References: <20261015005717.3719956-1-yhlee@isslab.korea.ac.kr>
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

