Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048854;
	b=1MVyUEpXWiqkYBJDPWGKEWOQ3RvyQ5ZUU71TQMXJjnmEUdcOFGuHvy2gyM5K94RTfKbK
	 nvA9YZWqp/d80r9Ffyt8EqnqWcCSZCWhpQ+qqnmg0zR2H3hKwgEWsH1ZGJ+oes3Ghc1r/
	 Q8DfxYbz1uex1Pd57DZBa3Y9ijnSuCV3i53gCBul0LTFmfCSAH/DsHcAXRC9AbZlbfJAG
	 MqLXIneKIyCsAuLHj4sNi69JjINBukCiUKIbQeHjpVMHs0k5hhXdrt3gDBtmivI8O5PC0
	 Kkl5WyyU9hM/ntguQ1NB5I5d2Ag1ZItZW0i64Z0MviPxrYryx/toNlTT2DdvbEtuTTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048854;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=08Nf/AoWG7sPY+nJw5gl0r+zl1JawIBQ674BHdHf9no=;
	b=zmguhkgBrWsrA/c+OXFMhKIhzeVCVBi7vhogp2ljL0vyC5hbYgYZPJAXoFRJz34XmSLu
	 cYxCQ4pSZu9nHNCefj1eli+nfaKHFisBkh2k2vMoSPS8WZM5QP/2Z4RhYBJT4pBPb0JJH
	 QRbbvHvih1fwz4fA/oTeJuU8WftpmhUUiFoumURx22+xGZvtfahFEYdPySM5I3ZkNnvJx
	 D6oPkIpf5hdm+8nhalxkZ+gSo4jNGv4aRXhtMdoubGdUUwdkfCGNAfSSnnr6NhoBnq/5V
	 c96D5/PV969dTmyqbCkC/5KtQscj72iy43OBHcQ5/ljKH+oE11eaDY5/i3sfNnY42PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ngSsNcao;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDD9606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ngSsNcao
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7381F008A1;
	Sat,  7 Nov 2026 10:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048854;
	bh=08Nf/AoWG7sPY+nJw5gl0r+zl1JawIBQ674BHdHf9no=;
	h=From:To:Cc:Subject:Date;
	b=ngSsNcaoM8YhT2vk8JGM+FlEX7ZB23lOLLaRqKI9bxvwDDejmnkBWMA9CtRshHaKp
	 9o8JpJEsMYr8jZ454z2ZP7cqCftZIDVtCd6MnuzskarcLFgSRlgHK5lWz7leWZOrKa
	 lDiU6tD0gAkvPwjWkjeL3TL7xXgU5fFKewtl4+dC8j5S34/o8RYUuycySfLZdHOrJQ
	 LrkYTEJvZuSuwYFHYB7TmQ6PMdocgVB4P4END+Tjyisl7ysOvIUL/dWBFVScIr8xXY
	 fG2Qmnx+oWcnvVqwsIVnwBkXdJWrkDnUC+9XDfXSFWotXRTttvJipawnpFxSYsU3wY
	 9670lPfMdY7Qg==
From: Sasha Levin <sashal@kernel.org>
To: stanleyjhu@google.com,
	peter.wang@mediatek.com,
	beanhuo@micron.com,
	bvanassche@acm.org,
	mkp@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] scsi: ufs: core: Remove completed-without-interrupt path in ufshcd_abort()" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:54:12 -0500
Message-ID: <20261107055412-failed-6.1-7cfdfdd65579@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7cfdfdd6557906fd09cf0a9a564a07012e7fb0c1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055412-failed-6.1-7cfdfdd65579@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




