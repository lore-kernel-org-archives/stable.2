Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841713CCFC4
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 19:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785181858; cv=none; b=g+QIqEf0mdrevy78dmQ5whSGZfqS2Y9SyRYKBFJMMsitYhF2iGSDLHdDKujH+H2wf9LgeaMPefeNEPsBHlqM2jen/XeD27pEg7QW762TlPiqidmocqYVH1k9GTucTv1bHoVRKAAWbqNzsXL86Tx8JYRKbNqXSIHrmbtQQcjV+xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785181858; c=relaxed/simple;
	bh=W5Cybvm3hUpA5C/afL+4uFu81ntNVkhUe/yGOg1Jr3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osAdHZdh6+4WBpeHTOgYMQzPHW8viFPFczQHGUJljoUp5P+i/1SfxPBAC7u7bSzQbpkxifxrpjYHyJ23LUj3IEm9w+r34/ueBGTXhk05XnGsTZ/4QNv0J6N41RilGmTb8az7+WAl6y2zphDHW6lW2DS55px/xhxFM8YmdZZvFzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gawmdje2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gawmdje2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DDA1F00A3D;
	Mon, 27 Jul 2026 19:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785181857;
	bh=srszY3M8Q6xJD7p3JiuX7ilOceMrUZIYNzYcTEwBcsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gawmdje2wDHAXjtGFxSb9zLtQ/d0t5GpkwH3aryz3EiKw1UY+i70kSDqdPjqJo6Xu
	 PCQrj1LLqxkojk5jiZpg1jf8+PODae3vp5TNEaXQCberXx6mgXoKV0tgvjHRCuyZrQ
	 KRKVELCxmEeUtzzOBxjJ5B9SjnS6Iqay0oXZODSQY4Ur92at1EcAV4CnesI9NyLsne
	 VbAPJtc9DAn+2lelkWaMslWRxvDwI7nb42oygwhhZJzhGHe89F1dMmAWXdQN2pNauT
	 twAUQlD8G7NiEl96A8rEr2/cR+q/+AYKe3Ge2O43FujqZTu38jaXjsNsJluu35Jgji
	 3pTczwCBIMTVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	Justin Tee <justin.tee@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] scsi: lpfc: Fix memory leak in lpfc_sli4_driver_resource_setup()
Date: Mon, 27 Jul 2026 15:50:55 -0400
Message-ID: <20260727195055.1774624-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072012-backlash-recycler-8fd8@gregkh>
References: <2026072012-backlash-recycler-8fd8@gregkh>
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
index 0f144fbf2a6cbd..e9d332a223b662 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -6811,6 +6811,7 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 			goto out_free_bsmbx;
 		}
 	}
+	mempool_free(mboxq, phba->mbox_mem_pool);
 
 	/*
 	 * 1 for cmd, 1 for rsp, NVME adds an extra one
@@ -6932,8 +6933,6 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 	if (!phba->lpfc_cmd_rsp_buf_pool)
 		goto out_free_sg_dma_buf;
 
-	mempool_free(mboxq, phba->mbox_mem_pool);
-
 	/* Verify OAS is supported */
 	lpfc_sli4_oas_verify(phba);
 
-- 
2.53.0

