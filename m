Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23003CBE79
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 19:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180749; cv=none; b=cmS6abiKySGK9H5H2LooLf/zlunARhn8/tkz5rZMszSHPrTD+BHEgrzn3cX007/Dt1Wqq/mHa5QOCNM4eLvK0gvx8VA1d7wEurPA5AjddiXtEKFZwmuu5A0TMkyGKFDlsoQLfj0JgrmWgbeZUE9cN3xKTDOUIGR6YXkId+Hq9Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180749; c=relaxed/simple;
	bh=SPeEDGetd04izBWSPBSAetV8kqBQi4TxdljZVfBO3XI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQNc8FXTFFfA5qzoNhYSgwCdnrO350zIOooJaSdsVD0FsgNaSAlZyl+JbgHx7OtWEfgNVPgYaMDMaBpKYhxepwueAxGlao/AO1rBBa8M9hISjXOoHlDjQjiMms/mtxzx7o3T8Kt1c2w0TA5qigTF8hw9OecwEbTfs/bWNiCsHGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/ZTRvKv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/ZTRvKv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172B11F000E9;
	Mon, 27 Jul 2026 19:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785180747;
	bh=OR4m00mVGHfZ4RqVGbLlx1yhZdgZdYaoCnVLtBXO0ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q/ZTRvKvJkCoVRTLl/V/MMD/+qarcN1QIueoqooKvmA9gzbFg1Jeisao2uSfL/Zb9
	 VwIy4ix1jiqcJ8sqLV8C3KWWZNeIjaLhBw2O4JABhuMXbNn1z6qBA/xfIH3CFkkXyV
	 MJEfsbWlKwZVmqnRC6Utpdm5jqyQa49ZTArb03t/Gn7SpxsSigIKTgfTHKjeE0at7P
	 sXqr+ZJuhBkWYv4kvAv8gU7V+RBpbRMFyDeQEb41y15ukcCvIYAWhvhbm62vtltXVB
	 5/yRSIxf0pwNFvhhz4wOy22mIxaqdsHHflW37ik2gOB9hgeVi/TnEvWwHD/34BBICa
	 Sl5tM86XcxUhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	Justin Tee <justin.tee@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] scsi: lpfc: Fix memory leak in lpfc_sli4_driver_resource_setup()
Date: Mon, 27 Jul 2026 15:32:24 -0400
Message-ID: <20260727193224.1748882-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072012-drab-ointment-66b4@gregkh>
References: <2026072012-drab-ointment-66b4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abdun Nihaal <nihaal@cse.iitm.ac.in>

[ Upstream commit 1bd28625e25be549ee7c47532e7c3ef91c682410 ]

The memory allocated for mboxq using mempool_alloc() is not freed in
some of the early exit error paths. Fix that by moving the
mempool_free() call to an earlier point after last use.

Fixes: d79c9e9d4b3d ("scsi: lpfc: Support dynamic unbounded SGL lists on G7 hardware.")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Reviewed-by: Justin Tee <justin.tee@broadcom.com>
Link: https://patch.msgid.link/20260707065304.949135-1-nihaal@cse.iitm.ac.in
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index d7a3304de305cb..3cf1fccee81275 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -8010,6 +8010,7 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 			goto out_free_bsmbx;
 		}
 	}
+	mempool_free(mboxq, phba->mbox_mem_pool);
 
 	/*
 	 * 1 for cmd, 1 for rsp, NVME adds an extra one
@@ -8131,8 +8132,6 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 	if (!phba->lpfc_cmd_rsp_buf_pool)
 		goto out_free_sg_dma_buf;
 
-	mempool_free(mboxq, phba->mbox_mem_pool);
-
 	/* Verify OAS is supported */
 	lpfc_sli4_oas_verify(phba);
 
-- 
2.53.0

