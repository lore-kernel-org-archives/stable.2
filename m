Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272540;
	b=yo4MUE9QqwGjfDk1e+xMcCkIMVjJN3YHE08Eazthput9+/J4GmwTx0qZ20z1jNSrEJuk
	 U+/US60k7EYRJcOBGvcxaudPUtWHXamONSziUzJ8Ycc5/TfQvNqq98au7hjqMN11HVYnE
	 fNsJ+mKZfvNHzfK31uZM5m9iWnSVqhx1PyKv/KX0lnLRNkKTsnQBzb+RFuZuPdMmLmPHG
	 QHRhnwrpdo5RhFB2AF02LFzFIF68bGybKMtF8r2NyerQiB1TKoFnfMXMmzOCLqNNZQlhu
	 4i9LdF83x/EHdoshJNqVbgB8Ho+Mtaotn+CwRMlYFD4e5qJQiEOJUzqkrrG7ZqV5F4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272540;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=GUwbdGSuk8m5kVvA8QVl0PAxt1MFEcnQnYtuZe6j+sc=;
	b=mD2/aST4KLr/tJi18CSDinPzH8ur9pLCKr/xVHnOakZKfJk/aQdPLwIbqgvbPO3QEy2F
	 1rBjPtSpUDAQdgX7fChtnLbv45tJwHg+TJzjgTGZtgg4w21PhBf/mECVdrfQ16Ubvzdkb
	 0+JMdcB3IAykVTWZvbT0B2lV3pasYw6kPMPHurkRpCSinHgSi5DEmzt1QVUcSa7ycWfaX
	 SB0B/q0Y1O4eUp9bUGXmeoE480Uq/LJHmTxmzICr+SYMs+V23PjGxN0X4h6JSLHy5RQ5F
	 GGAeIFfqLMCCkgnuM2AEHd6QC67qaX01Zg0+ZCbL1XMSPRJzx0BHK/awEIx57TZSmmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BoZRo97u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527DA606A333
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BoZRo97u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758201F008A2;
	Tue, 10 Nov 2026 01:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272540;
	bh=GUwbdGSuk8m5kVvA8QVl0PAxt1MFEcnQnYtuZe6j+sc=;
	h=From:To:Cc:Subject:Date;
	b=BoZRo97uwgq2ETAmLzgQedKjARntwctH4lJJMSgSwbo3TqsSlv+l4zsEbzS34xNgF
	 u7sGe2fUT9tUCwdIP2DfewVK8LDSUJ++XHkm639zvO51rKDLx4gsXrVXERasoekw0s
	 dLdRBHZJ6N8QIXsbx3TVeV7cyoBvfFttaq4hpQFaReQNP2cHy79GGJZGer1LWlVKUK
	 gdJL19Kni3CDhHwWD786QVFcJddedG1fZPZRiB34oUILBZurVyFZxYORJr1Lh7Sraf
	 4XBvdgDhkGvee/bzNv5AjZhkAZQ8dTQKy/Vvhj/Bj0jjXiLZrxq5D4pkJj8FvV20oU
	 OBY97gIYof9QQ==
From: Sasha Levin <sashal@kernel.org>
To: hy50.seo@samsung.com,
	stanleyjhu@google.com,
	beanhuo@micron.com,
	bvanassche@acm.org,
	mkp@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] scsi: ufs: core: Change the error check sequence for auto hibern8" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:02:18 -0500
Message-ID: <20261109200218-failed-6.18-6b2ff2b3eafa@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 6b2ff2b3eafa381db9b4c8a6ed98b353b2a09f39
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200218-failed-6.18-6b2ff2b3eafa@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6b2ff2b3eafa381db9b4c8a6ed98b353b2a09f39 Mon Sep 17 00:00:00 2001
From: HOYOUNG SEO <hy50.seo@samsung.com>
Date: Tue, 27 Oct 2026 20:03:57 +0900
Subject: [PATCH] scsi: ufs: core: Change the error check sequence for auto
 hibern8

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
---
 drivers/ufs/core/ufshcd.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index ee643830a57a2..fd52deb72d21c 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5931,18 +5931,26 @@ static irqreturn_t ufshcd_uic_cmd_compl(struct ufs_hba *hba, u32 intr_status)
 {
 	irqreturn_t retval = IRQ_NONE;
 	struct uic_command *cmd;
+	bool ah8_err;
 
 	guard(spinlock_irqsave)(&hba->host->host_lock);
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




