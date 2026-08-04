Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4812F37269A;
	Tue,  4 Aug 2026 00:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785804859; cv=none; b=X7myPKS7cUhHVzmrlqLZQFQGwOsjxjiQOovdT4Wr/KrDDEcPHcjQILQpLn42bpovtdLM8JCjzWJaxEUVKYZmzSQnKxCypx+DcXxTEmpDu0tgfbWwzDEgVOnXZ+2HSF1Ael+nAQP+gHJIIkN4GSKDZxvn3taNRFnlZOK07eeSKNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785804859; c=relaxed/simple;
	bh=wS3lyltWBLBdd4psZ474tesRkH+sUNZ1T7rO6X1ZT4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mgj/eZU1s8r/o8nZcfpsDNfS+OZ7znTcePvzzFfcbcr8eUFoK7pVtzwBh+9ZtB6fxiNrC7bV6i3zZ2aK9N6KyD8Es5TNu2R0tJvwgfImnq3+vfDVkbNrBd6I8osc5f90Cvhrez3AXOH3QdsSICdqno81r+lXd4RDgVnzbRnIwBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ff31c4f28f9e11f1aa26b74ffac11d73-20260804
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:ddacd5a4-cb62-4303-86ad-8fffcb5ded40,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:096f34ef334ec6474f12983b4c97942f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|850|865|898,TC:nil,Content
	:0|15|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ff31c4f28f9e11f1aa26b74ffac11d73-20260804
X-User: chenchangcheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenchangcheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1940239157; Tue, 04 Aug 2026 08:54:07 +0800
From: Chen Changcheng <chenchangcheng@kylinos.cn>
To: chao@kernel.org
Cc: ccc194101@163.com,
	jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chen Changcheng <chenchangcheng@kylinos.cn>
Subject: [PATCH v3] f2fs: fix valid block count leak on data block allocation failure
Date: Tue,  4 Aug 2026 08:54:02 +0800
Message-Id: <20260804005402.13026-1-chenchangcheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0b450e92-b9b0-4a55-bd16-ad106245d7e1@kernel.org>
References: <0b450e92-b9b0-4a55-bd16-ad106245d7e1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In __allocate_data_block(), when allocating a new data block
(dn->data_blkaddr == NULL_ADDR), inc_valid_block_count() is
called first to increment total_valid_block_count and i_blocks.
If the subsequent f2fs_allocate_data_block() fails, the function
returns the error directly without rolling back the
already-incremented block counts, causing a permanent leak.

Fix this by calling dec_valid_block_count() to undo the
increment before returning the error. The condition
old_blkaddr == NULL_ADDR precisely identifies the case where
inc_valid_block_count() was called.

Fixes: 7d009e048d7c ("f2fs: fix to handle segment allocation failure correctly")
Cc: <stable@vger.kernel.org>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
---
 fs/f2fs/data.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a765fda71536..819631bb61ae 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1532,8 +1532,11 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 	old_blkaddr = dn->data_blkaddr;
 	err = f2fs_allocate_data_block(sbi, NULL, old_blkaddr,
 				&dn->data_blkaddr, &sum, seg_type, NULL);
-	if (err)
+	if (err) {
+		if (old_blkaddr == NULL_ADDR)
+			dec_valid_block_count(sbi, dn->inode, count);
 		return err;
+	}
 
 	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO)
 		f2fs_invalidate_internal_cache(sbi, old_blkaddr, 1);
-- 
2.25.1

