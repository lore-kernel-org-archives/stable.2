Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6DE3FFABF
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905488; cv=none; b=FMe3vVXlFMWTXJ4ehaLq+wqIzTlXlZYPoAnRhLGVpQSMaL1saxs1KisMdHNHmZrYrLNN5joa8DzjoqGJ5p+6V5ddJkNGQdi5YtaZbCtcPaTZp4rv5/8EPT92vZTyzjaYF9JuTI/HvgOs0OXJM2JkeAO3XMhxFlT8oB5jZs3CnrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905488; c=relaxed/simple;
	bh=vm4PVGml4b/bQqD37Z1vgD9yjlGFRmw8pUrS09ar7iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hi1ppnwQSQm6IKeDsPB1Oa0YSRUBCSJLVDg1GW17vC4p+8Wcro3P6krbYLpK5M1T6ThsTJxJ1Qscb0uS8y/G+bmyWqhWb+pI2K1WhmCOIramZQ5/Kq7573gOxJEvpORvwPO0+4+0oUETZaUKV+t44ljSiL7iMioj8wb9Uk8BQos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7m5ZOGp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7m5ZOGp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DC01F00893;
	Tue, 13 Oct 2026 15:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791905487;
	bh=mWExYb58vTFsZV58wROAAUQwHjgcclWaBwoqjosRHic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h7m5ZOGpDhZY8Qz5IbDQT1w5w79QvnZhO7QzuQ2IsyPkSpb4deTiUuzdZEMSgMn9i
	 zPjwkHXF1ZTF91w42lRyI0HNga5zG3D7B8ndcNrXMDGO0FurCtcr3TEruWK3sIHHuT
	 RmM/hKu03CtCFq0bp6U2qxJ3osQWcW0a1Uc00ZJLXW3TEn5jUtyDlsflQBgaduL9T/
	 IshKg+Gs8/4vulrkSKeQxG1A5YPoXU/YcJww86Wqw6NeLxprZa2IVBj1yFK2jbIGnb
	 8JiqxOm5aekFutXlQNgG6x7NokP77+D5HnwDzccapx0giH9TG8vhrJDcdvdBR5dn1F
	 t3Wq+B8O4vGYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Avri Altman <avri.altman@sandisk.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] scsi: ufs: core: Move an assignment in ufshcd_mcq_process_cqe()
Date: Tue, 13 Oct 2026 11:31:23 -0400
Message-ID: <20261013153027.105962-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101212-headpiece-alto-c398@gregkh>
References: <2026101212-headpiece-alto-c398@gregkh>
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
index c9bdd4140fd04..8780be79a0f84 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -307,9 +307,10 @@ static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,
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

