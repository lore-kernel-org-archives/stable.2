Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF621517BA7
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905491; cv=none; b=SKI2PHnjyp5bpLCZBsUpH5bDpCblXZlMtOJoKBrSiPJ78J9ff9HB8AjRj1oFTuQxEf+gj0UAdRkPt7G0Os9YDZRgQv3Yq/Wt78ctlqhN17517Em5E+hubyOiM1SktiFiWlDAtX2bkQVNfNScvq7+oYPcZzR/fVsuwIl8kDjYe9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905491; c=relaxed/simple;
	bh=+vi5a24TEaEl1uBFtKl2caFQfOIdPhrFfCGZQ+MYIp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqWR6K5wsb/RLSJ9sLPBQ/UIYbwqlYOgDxGzpJqUh4v4iTf3gCBvoKD2C33egyuT4DtwqwWFiEWSCZpHb5wCeJ8CfbpmWFwFHBXQ/mLgdnzMM/AW7EfjwRSFyJLlqdh8NMXcEe0al+tAYkpdKQws9To7U+N2vExOrnQZfZJsGiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLGXpKZG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLGXpKZG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C896E1F00898;
	Tue, 13 Oct 2026 15:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791905489;
	bh=nC1q2olYsKRPRhZVLkefkh1b0fxgWf6VqtKKFwWmUok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aLGXpKZGFSeI3e8YDmqczUOry+cXfKu6mW/c+LIyZm83WuKdCjkD83RqxHHbYqEOL
	 fYtr5tuZpKec61FNLnG8gQBd7mlfUNPCl4+ghFVdQqIwcsALK1N1K/p/p0d7rD1jbh
	 5Bu+eGGr2FwyG34weKcGONWjRwKdFDBRmI5uA1f4ZApiFCEeX5zlpxle/0FYvN4ci9
	 RB4MfcE7knng5Z/FMzfod/PeKuDbGo9vHq89R7UW+obcSD5q8B0nFPLUJr5xl50d1e
	 +cLIBaac1EPcS7lRKovA2D8CNyQ/O7JSB2MXGGa7qunqRCUNeKHwKPQncO2M4jkPtu
	 XRq8OHzq6isjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Peter Wang <peter.wang@mediatek.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/4] scsi: ufs: core: Add a comment block above ufshcd_mcq_compl_all_cqes_lock()
Date: Tue, 13 Oct 2026 11:31:25 -0400
Message-ID: <20261013153027.105962-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013153027.105962-1-sashal@kernel.org>
References: <2026101212-headpiece-alto-c398@gregkh>
 <20261013153027.105962-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 1373df88d53594a32534fd8960c51d1d09be8ecb ]

Document the aspects of ufshcd_mcq_compl_all_cqes_lock() that are
nontrivial in a comment block above this function.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Link: https://patch.msgid.link/20260401202506.1445324-2-bvanassche@acm.org
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 375f3a5691dd ("scsi: ufs: core: Avoid unsafe MMIO reads in ufshcd_mcq_compl_all_cqes_lock()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufs-mcq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 632f4522a4d63..51e3c65ba94b1 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -319,6 +319,14 @@ static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,
 	}
 }
 
+/*
+ * This function is called from the UFS error handler with the UFS host
+ * controller disabled (HCE = 0). Reading host controller registers, e.g. the
+ * CQ tail pointer (CQTPy), may not be safe with the host controller disabled.
+ * Hence, iterate over all completion queue entries. This won't result in
+ * double completions because ufshcd_mcq_process_cqe() clears a CQE after it
+ * has been processed.
+ */
 void ufshcd_mcq_compl_all_cqes_lock(struct ufs_hba *hba,
 				    struct ufs_hw_queue *hwq)
 {
-- 
2.53.0

