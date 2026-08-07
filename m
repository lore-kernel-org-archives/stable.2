Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15D537C927;
	Fri,  7 Aug 2026 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093849; cv=none; b=rqrSreYmQa/PBAs3/TWY1kySiV9CrmqXzrou9aFmD/Jhjf3rc1HIs2XwYidzsMI1reKCULCYyRfDlzyM29X1QtAelC4aTljP3CdgwmeF/OIv1jGsn3ZMep19OxgtHmDoT8cZXELHOlxlWJNOGMhR+FdzBmiNX+wz1YJSrnbKa4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093849; c=relaxed/simple;
	bh=PHG65cmLW2fQBEsf0LYfC5ntKhxbobGkSKZRaO8npmg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=noD1hdkKVdV+6Z+LA7kG9JPJDndqS7Oi+IBIWg//Gyxb2Z4q7kShIEd7P8e9YyWZPsOAaf8XMvyC20FqDnJm5q48R/1h08MrURt1BW7YZ0DZBvSOM9ehVssbZt7tyO5HnMS1p9YyshYU88lSNXNWaegrrWdZbripFhR6JKNC7GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: dd57f18c923f11f1aa26b74ffac11d73-20260807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:78690baf-e560-4095-b372-41e67ab37fcf,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:57719bb55d11e12a9c1dea0eef95ce32,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: dd57f18c923f11f1aa26b74ffac11d73-20260807
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 313922729; Fri, 07 Aug 2026 17:10:41 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com,
	viro@zeniv.linux.org.uk
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ntfs: fix error handling in ntfs_readdir()
Date: Fri,  7 Aug 2026 17:10:38 +0800
Message-Id: <20260807091038.101761-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_readdir() converts all non-zero errors to success before returning.
This hides real errors such as -ENOMEM or -EIO from userspace and makes
them look like end-of-directory.

Only positive return values from ntfs_filldir(), which indicate that the
user buffer is full, should be converted to 0. Negative errors should be
propagated.

Additionally, when the user buffer is full (err > 0), the iterator should
not be marked as completed since directory traversal has not ended.
This allows subsequent readdir() calls to continue from the saved position.

Fixes: 956ce2083c93 ("[readdir] convert ntfs")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs/dir.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
index 2d594cbb4ebe..ba17d9805326 100644
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -982,8 +982,10 @@ static int ntfs_readdir(struct file *file, struct dir_context *actor)
 
 	if (!err)
 		private->end_in_iterate = true;
-	else
+	else if (err > 0)
 		err = 0;
+	else
+		goto out;
 
 	private->curr_pos = actor->pos = ie_pos;
 out:
@@ -1000,12 +1002,13 @@ static int ntfs_readdir(struct file *file, struct dir_context *actor)
 		kfree(cnir);
 	}
 
-	if (err) {
+	if (err > 0) {
 		if (private) {
 			private->curr_pos = actor->pos;
-			private->end_in_iterate = true;
 		}
 		err = 0;
+	} else if (err < 0 && private) {
+		private->curr_pos = actor->pos;
 	}
 	ntfs_index_ctx_put(ictx);
 	kfree(name);
-- 
2.25.1

