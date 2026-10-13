Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21C940DB33
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907300; cv=none; b=Qi6DR0r6hqtVSVLbSVfrjM9FKvhA/rQ5fzNa1SPIrUDDgLgSRtlU2bQNFete5BNDZEMeK1Oz1/Z5W6d/1iP+xjFrwnw8P1MqFA3CAUYBzLXCncWHuNRa+n4a7nb1nM4wqa1QgEngXJ0EUlrOtGdGmUyB5lEVjp5Dy3VY0IAffQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907300; c=relaxed/simple;
	bh=2j8sDG9LRdm8FSr2oBUarVxbVOvuh+56cuBf6gSM/Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGq4c58dmTF9IehlJYWopWwBrOdX+bUdZdXESFC1y/YBZ25BtP/2eD6yeGzU6r9hY3blfLjx6LFbczO/SmUB+RWYJKDg81xtrEbW3+wPMAh1bdHDQLZIjhUtVcu887wxTpQFSFObuvwFBWx/uxxbyzDBtvJeGULJah0SDRZfKZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liytWU4Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liytWU4Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1388B1F000FF;
	Tue, 13 Oct 2026 16:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791907299;
	bh=Qc2l++1WCFEOgcwQ/9BPfAFgSdeWMoV/p50cTfybVIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=liytWU4YYBzw5irroyMT+TsKJzET29u5pICzJ0UhqLOlYMU26Zoglvlm2AtO5SArc
	 MEFNSeIoCFHhK0urTtz1FQN/w1eY9kxX08Q+VsjVaBfKNFLO4081iCuVAY3s8pYtCK
	 uci92xJGb9oegZnuORWgeu4MwMREnw/rf73hsakUKVM4lXJxJ1Mpilo5UQg3WkonOl
	 tEsmKEIRUBYF9yI+Qsof15vpaq6NB75FfM2i6HAD1PEzI0E/CdrN1rP57hswQTp6qV
	 FStZ5sAYaiXQHxPEljVQybrEOdP6NXhiQLuxBo9gi8jcBFT2wM3Sc+qppC0JsOi0oz
	 7Y/J95uGTDX9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Peter Wang <peter.wang@mediatek.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/5] scsi: ufs: core: Add a comment block above ufshcd_mcq_compl_all_cqes_lock()
Date: Tue, 13 Oct 2026 12:01:34 -0400
Message-ID: <20261013160048.356245-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013160048.356245-1-sashal@kernel.org>
References: <2026101216-sharpener-discover-cc77@gregkh>
 <20261013160048.356245-1-sashal@kernel.org>
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
index 846d4c3eb3923..121601201fcd2 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -285,6 +285,14 @@ static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,
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

