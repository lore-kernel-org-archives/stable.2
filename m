Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049883;
	b=sz88QDayTMbYKuJsv1U7lODGzycJUjQkexxsf3Kfp5/yvkvbZhF1LaYBKJ0QP4ILnYmV
	 v/4rPcDoOmlNCj6Lmk3gGRyPru5dUXgwXtKjaVO/klF/k+gCy69jZhrzpGzXHdsqFvX5e
	 b1Ss05apUkfA7Bow8mQU62jq1o7yIB2Kqo7pfuWbw8rg6MusRGo5hLM6KmZP9frFhLmP3
	 VkudZyvE6492ncyP1jpcBut+EutvSyWbwb7iMR7Akz8cfrZKFWyoAafCcJZz/6sBRABv2
	 Nc+zzF51LU1i50FNyo3QpFWqNGkzVkYH82km/mnPY9gEY9KQFrC3q1AEOZpw2fh4fXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049883;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bg4q+14JS7R490qLNcS2osSigQIDQ2Dik5rF+ZUVAxc=;
	b=LOROulHZsmdQYHgidnJxyAqzL21mljNzatBti5RO1p63SuWxSvT749CjSdWeT2qLHpax
	 Mff4drHQth6IAECpLczH9dseYarEx/+LugBNstdDMIqnoUKPkKw8q1TLFK8mHeTELxO16
	 6ckjO5Vs3IFPJrJyg2h4+Wk4yt//nK2koZ6Lv+MPyGQOro7tR3njIibgiMRHDsdwrr78+
	 WjL9xjO8p6QvXxynje6p5tF0aPK0ByZDDfGdmDyffifhTg3VWZTqlKlLQKcupMICDD02f
	 wykXngauxG4jrh/0KGfJyTamjBB+yqDazB9KiIrval0Jg/ZvsEV1ClK7ep/MwEfto4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d89L6JUZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0974E606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d89L6JUZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319D01F008A1;
	Sat,  7 Nov 2026 11:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049882;
	bh=bg4q+14JS7R490qLNcS2osSigQIDQ2Dik5rF+ZUVAxc=;
	h=From:To:Cc:Subject:Date;
	b=d89L6JUZWUIAvOEqU2LiAdP7U/uY7djGe2LR/G0dMkJuEwsbAFzvByH3/+WqrOYkO
	 /9jGbj5qc5rlWy/qdybdCa0BO6MLkyrWl2Y3zqQZ2Msz3JsukuymjOYRjd9QTiO98c
	 SrvhslsBketqYQYSNfwTAeK17yj91QnyWOYjXzQTKpKLEbv+QN7njIMnhdsIsNG4VT
	 aYXgOMfnxYrf0ceJFg5x1o+luLuw8CBDMAL0m9EEvknOLGEBYGMsQFr4r6uUOxHpVS
	 80jLTTwW1ihcvwgtc+nmuritJIXixuzZeSr9LTJWc8VbSrz4hldy5S9UQj4tbBUzzs
	 QqKEJDFC3TEGA==
From: Sasha Levin <sashal@kernel.org>
To: stanleyjhu@google.com,
	peter.wang@mediatek.com,
	beanhuo@micron.com,
	bvanassche@acm.org,
	mkp@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] scsi: ufs: core: Remove completed-without-interrupt path in ufshcd_abort()" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:11:20 -0500
Message-ID: <20261107061120-failed-5.15-7cfdfdd65579@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7cfdfdd6557906fd09cf0a9a564a07012e7fb0c1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061120-failed-5.15-7cfdfdd65579@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7cfdfdd6557906fd09cf0a9a564a07012e7fb0c1 Mon Sep 17 00:00:00 2001
From: Stanley Jhu <stanleyjhu@google.com>
Date: Thu, 22 Oct 2026 11:44:42 +0800
Subject: [PATCH] scsi: ufs: core: Remove completed-without-interrupt path in
 ufshcd_abort()

In SDB mode, a command that times out right as the controller finishes it
can be completed twice:

 1. The command times out and scsi_timeout() schedules ufshcd_abort().

 2. The controller finishes the command and clears its doorbell bit in
    REG_UTP_TRANSFER_REQ_DOOR_BELL, while the completion handler has not
    yet cleared BIT(tag) in hba->outstanding_reqs.

 3. ufshcd_abort() sees the doorbell bit clear and calls
    __ufshcd_transfer_req_compl() without clearing BIT(tag) in
    hba->outstanding_reqs.

 4. The normal completion handler or the logical unit reset that follows
    sees BIT(tag) still set in hba->outstanding_reqs and completes the same
    command a second time.

This branch only exists for a rare corner case, a completion interrupt that
is lost or arrives late. Remove it to simplify the abort path and leave
such a command to the SCSI error handler, like any other command that
cannot be aborted. The cost is a slower recovery in this corner case, which
is acceptable since it only happens after a timeout.

Fixes: 169f5eb28869 ("scsi: ufs: Optimize SCSI command processing")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/fdb5c391-01ef-4a23-94c2-4f3853909348@acm.org
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20261022034443.3034432-6-stanleyjhu@google.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 6cb5767b69fdf..834c7f3b592e3 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8125,15 +8125,6 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	}
 	hba->req_abort_count++;
 
-	if (!hba->mcq_enabled && !(reg & (1 << tag))) {
-		/* only execute this code in single doorbell mode */
-		dev_err(hba->dev,
-		"%s: cmd was completed, but without a notifying intr, tag = %d",
-		__func__, tag);
-		__ufshcd_transfer_req_compl(hba, 1UL << tag);
-		goto release;
-	}
-
 	/*
 	 * Task abort to the device W-LUN is illegal. When this command
 	 * will fail, due to spec violation, scsi err handling next step
-- 
2.53.0




