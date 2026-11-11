Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440151;
	b=mxq2nL3GwymuMkExE219U/w5u6JQ+boqN8FN2jZNH6yt9gsXeAKqiP1DuezV2Ou1dK3/
	 MAf9E9kFIraxn+ezRFpTKd92TFzD0Fmzrk2Enl6NWrV0+MOabD3CUSIKzgPnJP+JAz+gD
	 d7Sd8EoGDEFtCUY3YbsLVFff2kP/DmkJb5Z6B/qbvrzLKTPPTuu8Cg1hLo1IJ43XA6Wa5
	 SFuUafnPrnLlyNmQxF2kxfjm3++Z/IvulywnGK8fZkd9L43tJgHn3dySZMkNGldnALV8B
	 az0YwuFPn+aR8fswkwccHlBts1C1XYBgM3UMexQN+UVPmV+enXNIrkcBuyQ15R3Gc0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440151;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=y15nD3ooHqZo/hsrIbsyG7qM0GNUZ2y1/h0fzZP2n7g=;
	b=p6ngILbzEq2Jnkx9Z9W9eG1nLUzZe1EGMMOWGXPg7/rolQel5mbW2HQlgmtiWuLuow/m
	 xJ8yE2QFzrTQq88378H4pT/xZbwz8+14N+GpFOhQVi57t+HBNK4ywiVH+B7JSUmAsyCRQ
	 L5ozefDw+B6IUJpPzFyzQLx2mlYnwOY2ItVxDTwJC/PU0IHDOxuqxtBAPCXyuI+l72xMR
	 djMaAHuuHb5emjA3zFp4LmLk+R3PWnFlcmhlBTECKWBLJqy8yAwe7sj1pUfhqQd0d5GIU
	 UhwhwX/NCctOsl+Tgs9U7hKQHqEU5FQTJ359pvP0cIsZoR5W3eD7AbmV25JCbwguYOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M00+dY+E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5459606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M00+dY+E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941DF1F00A05;
	Wed, 11 Nov 2026 23:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794440151;
	bh=y15nD3ooHqZo/hsrIbsyG7qM0GNUZ2y1/h0fzZP2n7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M00+dY+Ehii9d4+FV4NkFqfb8OHL+X/S3Ple9Mo8tDz3r6wQXmMKh6fAMh1FsLjG9
	 29qHencsF8f5qJ+PWIpHhj6pk96DbVZvJEfRIKXXiX5yjS2qOjt9b1/kpv22NGlu9L
	 4ULaxJkZ2tqz1aYLzW24WsqHWaiOlbw+g5N1/xCZwFn3fXQf9E8HaAkgs1uLvvtcpy
	 8V84W+4vrthIiXWosm9YFqN5sR8C7X1pnjvwqMe7mgUNDlN7kGKdsXmSpUKqywpqFW
	 /aEn69UROvDlJzBvjMkkljetmLZW3OZaUK0anospN7v0gzncowwO4MExKMmqSfZTzk
	 ksej+3gkd8rzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: HOYOUNG SEO <hy50.seo@samsung.com>,
	Stanley Jhu <stanleyjhu@google.com>,
	Bean Huo <beanhuo@micron.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] scsi: ufs: core: Change the error check sequence for auto hibern8
Date: Wed, 11 Nov 2026 18:35:49 -0500
Message-ID: <20261111233538.617218-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200218-failed-6.18-6b2ff2b3eafa@kernel.org>
References: <20261109200218-failed-6.18-6b2ff2b3eafa@kernel.org>
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
[ sashal: used host_lock directly because it is already a pointer ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 97f86b6905b56..7fdfbc6dd413f 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5581,15 +5581,22 @@ static irqreturn_t ufshcd_uic_cmd_compl(struct ufs_hba *hba, u32 intr_status)
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
 	if (!cmd)
 		goto unlock;
 
-	if (ufshcd_is_auto_hibern8_error(hba, intr_status))
-		hba->errors |= (UFSHCD_UIC_HIBERN8_MASK & intr_status);
-
 	if (intr_status & UIC_COMMAND_COMPL) {
 		cmd->argument2 |= ufshcd_get_uic_cmd_result(hba);
 		cmd->argument3 = ufshcd_get_dme_attr_val(hba);
-- 
2.53.0

