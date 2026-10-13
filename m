Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA6041441B
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907299; cv=none; b=GNkgc0ApsMP813EtDSWBzhwx9opSazU/nLjAYg5UJi+0tjrVjS5cKf1I/pNFyXeMHsKgk6A5576dhuBU8etbIX4RgKX3fyRjEqMtNM91l51C9jrjmH5VXbjckMJtIB5SWQQd9k74+VWR9fJKNrEV5z2jKEvsStQXjARngPq4ryw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907299; c=relaxed/simple;
	bh=5387NqiDLfsCUBoqIjAM1/7tTnKD4UZWT3yE0COIAnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajgUXrWtIzjrWrNFr1hi4051OMMaSJ5DkUw/xSb5lM6rSFqDuv1vCzNjuNSxRuN4+pa9kpnCnfe/Z4V8JWW6VmtjQwi1QL1rdCPKULh7xQ4bdKB8HWFljTXeKpRoyoZz/w4TUitdmcmWO+wadVXCH2zAVbqlVX+2EI94Jgj0mhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9n8/Xzd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9n8/Xzd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A4B1F00893;
	Tue, 13 Oct 2026 16:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791907298;
	bh=OjqdvMgtqfH0HkDgtujYM9XQolXz8SFvKUzjRs7VUSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h9n8/Xzd/4U7U+5xi4q+UNW0y0MfOnq6Gyx8piSLg+1CsbxFfeRRYFgMA/CNNLtUj
	 utYuYHdI6hbxkSOyf8Bm4rG9Wcey8TXsddjivQrkWB8CBj09X1rCKsrhrwKbpi3QgC
	 M0kKvNOE4pq6W9a736j5rW0gND+0+RiRKXlH5DZ0lkWrE9NANx6LRAtnUsWPLF6qe5
	 3tsd0M377FTVjnJs2shCYtHF+E2ZGbDEvoQ5nv47BUGaxchycvGfbeiZr4X21GQKnD
	 opM5WrbMszNxWsdRxNY+QMtAAkmwW/7mDgfQGvCAuHC1+d2Sa9Pj0/XYBjfdvMXZ6/
	 qMuaidA6pLYVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Avri Altman <avri.altman@sandisk.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/5] scsi: ufs: core: Move an assignment in ufshcd_mcq_process_cqe()
Date: Tue, 13 Oct 2026 12:01:32 -0400
Message-ID: <20261013160048.356245-2-sashal@kernel.org>
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

[ Upstream commit dd4299af9b049c0dcb28699327ebc1386aab4b2a ]

Since 'tag' is only used inside the if-statement, move the 'tag'
assignment into the if-statement. This patch prepares for introducing a
WARN_ON_ONCE() call in ufshcd_mcq_get_tag() if the tag lookup fails.

Reviewed-by: Avri Altman <avri.altman@sandisk.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20251031204029.2883185-9-bvanassche@acm.org
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 375f3a5691dd ("scsi: ufs: core: Avoid unsafe MMIO reads in ufshcd_mcq_compl_all_cqes_lock()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufs-mcq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 02e3b41694e0b..90314980deed1 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -273,9 +273,10 @@ static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,
 				   struct ufs_hw_queue *hwq)
 {
 	struct cq_entry *cqe = ufshcd_mcq_cur_cqe(hwq);
-	int tag = ufshcd_mcq_get_tag(hba, cqe);
 
 	if (cqe->command_desc_base_addr) {
+		int tag = ufshcd_mcq_get_tag(hba, cqe);
+
 		ufshcd_compl_one_cqe(hba, tag, cqe);
 		/* After processed the cqe, mark it empty (invalid) entry */
 		cqe->command_desc_base_addr = 0;
-- 
2.53.0

