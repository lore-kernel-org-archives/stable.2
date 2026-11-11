Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439345;
	b=V6ub6/cMMh5jo6dZmlUH9tiqQBHcnratmo86dDMkOZ4sfIPt9U0gM1BoPWLSZjoo6G5z
	 TVJ2IDpT11XY0zi3fnBgX2Ae2kjQ27MghXRR/ZxFRZYPG/LkPdocXKDSh1VyuzQ6FB7vn
	 Xm/uYVZUjJh/rqt8hXi2UEptLEiLEwbO7kh7VU3xrONnsRGCvKovGh94bnA1MRq4yCewU
	 HgcD7/2TQPKKZ5GyEZkJrM5+l21jfzbg4pMEYLIPpYjDasK6wUQAsZBad84MCS4LZiYE4
	 QVEhKum9sooYMH47aQEhOR+DKXsSeOW7QgpFo9dlox/yuokyjvIwQX/OLQHNofbKKdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439345;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kq+AczKr1IGTGhzb1IZvA0xxFR4T4U3283LpXFL45x0=;
	b=LS7Qk/97pTDR964Z972k+2Q3ZGhYrAlHkUM1I1Vxgh6ivrxzhPT1DotOD0eLN3kkN9OJ
	 sgc7pBfL5fyrBp6vPnE3v/SEHbjPXCVgLxaTRDcEtFbNO9uz7jnv7EGKD7WDJvDIdBFi1
	 /a9Iea338DTrjhfwy4ACdlvpdrqwpKfwubZifPcUDD7f89hn5QEh6dAhtemfpCzapycXF
	 LDJXyYkF2woS6gG33uD/Lv1k9b/PW3JiYhCsoc5cAs2yRRXBRPhv8qsfq8fo1IzboJpAB
	 c8c7jaWlJOChJzuE03VEfs2h9+yHOm3CWiJAYK30S6wfnR7ZfT+xtPpxAnPBTyZNKHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zk5xOUeT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D61D606A338
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zk5xOUeT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002851F00A05;
	Wed, 11 Nov 2026 23:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794439344;
	bh=kq+AczKr1IGTGhzb1IZvA0xxFR4T4U3283LpXFL45x0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zk5xOUeTXQpcS3RCEjcHq1v5OUGEEbtBcc+5h3GwWMq6LLSs5H7b2tb8loDaD3A/q
	 pzrh3pEKQjSdnFnuZuwuNpHUlZOKwXUJooIIeMIv4w5lVZ4Cg78vBf++Oa/RGYwupq
	 G+djdq+3F8V/pxti4DwGYjKpHUXkRXbO1UyShPuk+IOh5hWG4ZOG+SLZpFU/E+PVPa
	 kIUDaQpWB1U12wQ4fA0Tuqt0n/l0lMCNzWR0VOW3cd5rJ3vf+4nSSyCPEEVZ2zZ0HX
	 3mAR/ARytLzYWwDzy0p8W7v55esFa4mvs1ZYJygg1apUbVu4SNm1VyjcZiQ17fMW4o
	 MjRIOlB1zyMFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: HOYOUNG SEO <hy50.seo@samsung.com>,
	Stanley Jhu <stanleyjhu@google.com>,
	Bean Huo <beanhuo@micron.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] scsi: ufs: core: Change the error check sequence for auto hibern8
Date: Wed, 11 Nov 2026 18:22:22 -0500
Message-ID: <20261111232213.401495-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200057-failed-7.3-6b2ff2b3eafa@kernel.org>
References: <20261109200057-failed-7.3-6b2ff2b3eafa@kernel.org>
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

From: HOYOUNG SEO <hy50.seo@samsung.com>

[ Upstream commit 6b2ff2b3eafa381db9b4c8a6ed98b353b2a09f39 ]

Auto-hibern8 enter and exit are performed by the host controller without a
UIC command, and the auto-hibern8 idle timer only runs while no UIC command
is outstanding. An auto-hibern8 error (IS.UHES or IS.UHXS) is therefore
usually reported while hba->active_uic_cmd is NULL.

Since commit fcd8b0450a9a ("scsi: ufs: core: Make ufshcd_uic_cmd_compl()
easier to analyze"), ufshcd_uic_cmd_compl() returns early when
hba->active_uic_cmd is NULL, before ufshcd_is_auto_hibern8_error() is
called. Such auto-hibern8 errors are no longer recorded in hba->errors, so
ufshcd_check_errors() is not called for them and the error handler is not
scheduled.

Check for auto-hibern8 errors before checking for an active UIC command, as
was done before that commit, but keep returning early when there is no
active UIC command so that a NULL cmd is never dereferenced. Only report
the missing UIC command if no auto-hibern8 error was found.

Fixes: fcd8b0450a9a ("scsi: ufs: core: Make ufshcd_uic_cmd_compl() easier to analyze")
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: HOYOUNG SEO <hy50.seo@samsung.com>
Reviewed-by: Stanley Jhu <stanleyjhu@google.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20261027110357.3649301-1-hy50.seo@samsung.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
[ sashal: Retained hba->host->host_lock without the address-of operator because host_lock is a pointer. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index dfbcf036d356c..490feaeee10b2 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5876,18 +5876,26 @@ static irqreturn_t ufshcd_uic_cmd_compl(struct ufs_hba *hba, u32 intr_status)
 {
 	irqreturn_t retval = IRQ_NONE;
 	struct uic_command *cmd;
+	bool ah8_err;
 
 	guard(spinlock_irqsave)(hba->host->host_lock);
+
+	/*
+	 * Auto-hibern8 is performed without a UIC command, so check for
+	 * auto-hibern8 errors before checking for an active UIC command.
+	 */
+	ah8_err = ufshcd_is_auto_hibern8_error(hba, intr_status);
+	if (ah8_err)
+		hba->errors |= (UFSHCD_UIC_HIBERN8_MASK & intr_status);
+
 	cmd = hba->active_uic_cmd;
 	if (!cmd) {
-		dev_err(hba->dev,
-			"No active UIC command. Maybe a timeout occurred?\n");
+		if (!ah8_err)
+			dev_err(hba->dev,
+				"No active UIC command. Maybe a timeout occurred?\n");
 		return retval;
 	}
 
-	if (ufshcd_is_auto_hibern8_error(hba, intr_status))
-		hba->errors |= (UFSHCD_UIC_HIBERN8_MASK & intr_status);
-
 	if (intr_status & UIC_COMMAND_COMPL) {
 		/*
 		 * Store the UIC command result in the lowest byte of
-- 
2.53.0

