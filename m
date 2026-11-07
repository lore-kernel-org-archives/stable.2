Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047921;
	b=MGVWg7E1iUGaO25hH5QWfUy7Fks0MbnOY6g4TwYm+7MupAifVXL2Lknh9k3d2WLIAUIf
	 IHnBHFsOy/KPQl5fVu1JdKk7OOkxDG/Xi2HqB4+rn2LcJVWuJ4lyqvrGzVA8nyjHoWppb
	 tXVuN98rXlmUcMMNLKlVKJhEv4FAMVW0eusfKNsMhmNx1HFRjH5w4d0da3gb8iR8vvcsM
	 9V8GhWs7nhVIBRpBpC1INQVq1v/LLeQVSmPHKWHSJWlB3Azd9QQt2pjwtCUnXfU6CbnHD
	 Znra7g1x2pqPQcIvhmmkXFsJkPnmJQ6h8Ke3DjmhumVtlOzX7+62HB8p9+du8MdrkYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047921;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1ISubb3C9Nr+v+HcwJh9rsUVrrtJocWrqUvhcvXfKmY=;
	b=HLbWS7iOmqDiYomvDl42+6jtNA9cg1a8iP6DIpYsspJzOCuQO60VszLUv4Gf/DvgHwjb
	 g4vqD2R/Jx3/DUEQm8NEaFXsrULmgUHyJsRygWZ2Pla1nNIdrV2mLyi25mYMR8SjqqwOE
	 zpQTnbbNZf5RLbTnafXQtet7mshg83EnRPgU5/iANrOk8xZtT61wpLYWNyFx3NISFS3+p
	 feZcsrFELgrkcT2eovp1joPYT7pj7AmjITPaJ1wGJA32uGKZHu1928XBo99DAmub1Igrt
	 z9pnsCv5PZ+h5VdkcfqWZRzVofBZJvfTji8/pm+GYX4iEEtEzb+6zLncQg1ZYTNfPCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="W9US60u/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B88B606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9US60u/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF131F008A1;
	Sat,  7 Nov 2026 10:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047921;
	bh=1ISubb3C9Nr+v+HcwJh9rsUVrrtJocWrqUvhcvXfKmY=;
	h=From:To:Cc:Subject:Date;
	b=W9US60u/RzxfBao4KCUPao3V8UKIOd+8FrficTps8NMY0KRlOPIYawIEs3eQRc6GK
	 dQ4tCPAKJEIJVcexQ6tHN/iDgQSykfqxsbwSNmelsVXnJ77aMv3Sn5QRGxsIc9yXNi
	 +LrBZ07dXatkmxP05w/Beur/CFZrYRzOaydCr+C+q+OSgkBOFGrT4V9ns3anDkh5nk
	 yStFnAz1wJdk3X2yfOTv1hctHhs/n55cewf2xNO25T3W+MMjxvHWoGduFC98oJImBO
	 x1EmnIBze8D9v7gtXbvuxlIHQALxO7meDiYeuSnLOZ0j2Kw5NzUqruNJpXgH7v5IwX
	 +nnc5Iw6aA6kw==
From: Sasha Levin <sashal@kernel.org>
To: stanleyjhu@google.com,
	peter.wang@mediatek.com,
	beanhuo@micron.com,
	bvanassche@acm.org,
	mkp@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] scsi: ufs: core: Remove completed-without-interrupt path in ufshcd_abort()" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:38:39 -0500
Message-ID: <20261107053839-failed-6.6-7cfdfdd65579@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7cfdfdd6557906fd09cf0a9a564a07012e7fb0c1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053839-failed-6.6-7cfdfdd65579@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




