Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB958527590
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906179; cv=none; b=hVsfoPlcQIGvHFueoxfAkdrr5avmdKXHcUBrnjI9mSpOr/mbQMnjo5icIG3FUm/b1ai2wkrzWAtN5OBdk3EebRDAGdTJMVp1JdlGRTs2nV+racRQasaKo6pLQ9roecMdUq6pKs+tph6WuABrI2VVrEUGWiBlH+q2DFRTag/rD2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906179; c=relaxed/simple;
	bh=YpiBKPThnHf2LUgYU/zsTBbRkU/cEtTchFwAhRcxa+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyLRZjpdv6yTc44NoP3vo5L17WSQlcuS1LCfABKocz2qCla3wUZlW2TRw5SlrPKFAR2IcC7yPEOq1LFXXKkXrKAN8ATJkU5Ocgg+Ui0RhAjQbQSKwzWui5Cqt/WFJTnZQK7jCV82Z1QWducc0HuK5xvRFV2BTyt+twSuwSYiZlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5I2uXxK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5I2uXxK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE731F0089B;
	Tue, 13 Oct 2026 15:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906178;
	bh=DWs+DOa2dOoVpC0U1WUMrarTM4dZyMAmv96hQn2k198=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n5I2uXxKakm7/IXrR4/TR6Atd3zgRss6OodYlbdhvY012jpjmOsce5jojzoQKp38n
	 3PCY3Gm3ZiNgBzgHLGE6XuWLMynx/CnchpUKFla4KIjAwXt20rGLrz7HDYLxPanZaH
	 4LD0gPUMVO3yRK9wTVyGTvD+U6wlj7DUJaUSt9e3+M3qKMHPrpjVdzeowl5PxH390G
	 oetxHmmnYFklrOxzOe4t0TKlctFs30grIXz7B8blMy8kKumue0ilSRn+BVrwgQQAw0
	 kshyjPx7Gp1t7SHSX4brriAxf0vyYqatvM8sFUn1yBcLO6OcFlpeVu9U897rFMAnGT
	 UoKuclfaCKr2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Wang <peter.wang@mediatek.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] scsi: ufs: core: Add debug log for MCQ command timeout
Date: Tue, 13 Oct 2026 11:42:54 -0400
Message-ID: <20261013154206.300388-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013154206.300388-1-sashal@kernel.org>
References: <2026101214-tactful-snowfield-df40@gregkh>
 <20261013154206.300388-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Wang <peter.wang@mediatek.com>

[ Upstream commit 3abe4113e784b4a1135fe0e89828afecbfebf862 ]

It is difficult to debug situations where an MCQ command timeout occurs,
the corresponding CQ tag response is received, but the request is not
completed.  Add a one-line log to indicate when the CQ entry is abnormal.

Signed-off-by: Peter Wang <peter.wang@mediatek.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20260210070837.1820710-3-peter.wang@mediatek.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 375f3a5691dd ("scsi: ufs: core: Avoid unsafe MMIO reads in ufshcd_mcq_compl_all_cqes_lock()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufs-mcq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 7ce9aba6bd7d9..d4129ceaede6c 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -310,6 +310,8 @@ static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,
 		ufshcd_compl_one_cqe(hba, tag, cqe);
 		/* After processed the cqe, mark it empty (invalid) entry */
 		cqe->command_desc_base_addr = 0;
+	} else {
+		dev_err(hba->dev, "Abnormal CQ entry!\n");
 	}
 }
 
-- 
2.53.0

