Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1C7526A84
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906179; cv=none; b=BUOkpndKHrJltKcNv3ncn10TaR4BMp9vkiRepSJFhqgD5SDM0VaWsk8kJpZAB/+y1uJY+uAjn4LlyTHmrsOtLTMWiI8jueZNYiWuBwhwzZrl834z+zsMu5bSlLK4dUcMvxZkZuK83pbUsik7ciUC8bulkp0dZ6Mf4YxwM3ajGRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906179; c=relaxed/simple;
	bh=8bhRvueyDn0hQvYqJPtMuGyA4Muvv3sHQTPk+Wwe7hM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNW85av08LqNV4wBBdA9ADQkKatmFHBz5Fax5QHT47OBhe5fwRemMUn127EgnEn1OiaVjy5Kys0MJHRN+fnvtrVG3C4mpeXSbcYJH5g6SCFzZn7nX7O5bt5CkBtc07lPJcLlmo7KeM9L47MaPPLvsGz1BFPtOnpUmBvVTdflJVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbNG1NV1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbNG1NV1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D8D1F000FF;
	Tue, 13 Oct 2026 15:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906178;
	bh=KyfsARDety/pCDQ/GJVJFndou8rC89Gm3Kr/Pe9I9B0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IbNG1NV1cddxIHri0A4l8oIBOEa+TnPYaCndouHafqDYI+yDgS6XespUFV7EeUxeb
	 ePJd/p4ihaQ64gyQrIw287aF9N8MpAQa4rqEl19Z+AcB4oE11pe5LsgSagtJU7Si5+
	 UFe/bRVzXLYdB+HCE6SKmijYJIqy7ZYaKx0mSgRmIb33mCjwKXoMPd6kBPwQlt7zbd
	 DPXu9APpxopm4rqfW/cCJYKBjZFh4vgzfJIKprd33pZN9gmQq7AWZPuNx0NhPUIeY+
	 m6cOCL2/HWbbgfwwgnUKzrve6UWIBuOe3/hLNMyXNhFkjAh4tWHfaNbxWhmXrCk2X+
	 eKB2dZO0dhKbg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Avri Altman <avri.altman@sandisk.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] scsi: ufs: core: Move an assignment in ufshcd_mcq_process_cqe()
Date: Tue, 13 Oct 2026 11:42:53 -0400
Message-ID: <20261013154206.300388-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101214-tactful-snowfield-df40@gregkh>
References: <2026101214-tactful-snowfield-df40@gregkh>
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
index 5e6197a6af5e2..7ce9aba6bd7d9 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -303,9 +303,10 @@ static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,
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

