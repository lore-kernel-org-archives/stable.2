Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8E750B8A3
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907298; cv=none; b=WusozMqY7oB4gsI9Z0cVFEUbv90IktPZAlzpoU1OioVjgAQGgNJwI6kRYB8BFgpkgOnMkv4sVRwXnJFTiFuu7DDUietGueDowR7ShjZLjBZBIUozGekEO0Qhq5DsFabK52W+nQLQGDXB+vdP/MsAUnn6xUeOkMxQYJdhuZO5n3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907298; c=relaxed/simple;
	bh=wvd+uSU3gjEXTEGRRNUFH/lACsmfCiPoZar6kTxVmwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oedq3oPnyIM9QbbqGqT2NA5OtFfnLHbE8YnhmXBIKslVz7fO4aTI55Uk8iap7ZzTrr8CNlkKdZJcRr8CVKKkDTV6J+9iUZi7bC3S1LAFw14hQyaDlwiZUckqVZhPYnhOeyZ1QzK21QEG12kktfA0qk9h0vi65Z15oYarudxKHs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWE24NT4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWE24NT4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF281F000FF;
	Tue, 13 Oct 2026 16:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791907297;
	bh=LAFmueap+rKGYybIIy66G8QOc0x2KYzfQTE4Gt/hzBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fWE24NT47719qJ8tjxzWjcxarxGnMgSqe23i8kQe1N8oEp5AGmP7ky78eW73jQS7q
	 G0tHiVjFN0gzseGLB0blvaAx2+scCOmLvyPfvuX+ckbGRmV1paWMff+VedxDgCkUt4
	 8LnrnZ/ozkanzMDV14uQPy5jJdLdSzPixLJbTXnkdGtyQnMUnbv0X/W7vf5SwEVY52
	 13azoMQqs64GXZFbPPnrNN22fJ9AYsEs1bpN2CIpl5annbe7R1Jm/biCZSZ5rbgIXy
	 QAlA/9AQib05fGCZf0vV1mf4lD+ODaxM+stkl6PyuuyST9dWWhxx0n1dikzYRPspZ/
	 X9fWl7QCC3lLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChanWoo Lee <cw9316.lee@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/5] scsi: ufs: mcq: Remove unused parameters
Date: Tue, 13 Oct 2026 12:01:31 -0400
Message-ID: <20261013160048.356245-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101216-sharpener-discover-cc77@gregkh>
References: <2026101216-sharpener-discover-cc77@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: ChanWoo Lee <cw9316.lee@samsung.com>

[ Upstream commit 01f256228c0f89c4b48fbc7c67b64a26cdcfd740 ]

The 'hwq' parameter is not used in this function. Remove unused parameters.

Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
Link: https://lore.kernel.org/r/20240105021041.20400-3-cw9316.lee@samsung.com
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 375f3a5691dd ("scsi: ufs: core: Avoid unsafe MMIO reads in ufshcd_mcq_compl_all_cqes_lock()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufs-mcq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index cb8f0652a4bee..02e3b41694e0b 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -255,9 +255,7 @@ EXPORT_SYMBOL_GPL(ufshcd_mcq_write_cqis);
  * Current MCQ specification doesn't provide a Task Tag or its equivalent in
  * the Completion Queue Entry. Find the Task Tag using an indirect method.
  */
-static int ufshcd_mcq_get_tag(struct ufs_hba *hba,
-				     struct ufs_hw_queue *hwq,
-				     struct cq_entry *cqe)
+static int ufshcd_mcq_get_tag(struct ufs_hba *hba, struct cq_entry *cqe)
 {
 	u64 addr;
 
@@ -275,7 +273,7 @@ static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,
 				   struct ufs_hw_queue *hwq)
 {
 	struct cq_entry *cqe = ufshcd_mcq_cur_cqe(hwq);
-	int tag = ufshcd_mcq_get_tag(hba, hwq, cqe);
+	int tag = ufshcd_mcq_get_tag(hba, cqe);
 
 	if (cqe->command_desc_base_addr) {
 		ufshcd_compl_one_cqe(hba, tag, cqe);
-- 
2.53.0

