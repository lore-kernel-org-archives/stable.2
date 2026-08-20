Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4316A2D73BC;
	Thu, 20 Aug 2026 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787213665; cv=none; b=Eh/0v9H8+oOCyzBNzRHv0Cm1uid/xxSfusZhCnMCLYThRcFNvVpC9C1E2ZtRGFSbuWa9j3wksPxlZWj1cOe/DZzg7sKvxI9v80GfBlLjXbTbAnTR+IZUFn9lPi3E1GwkTJf+++j6WjmhUAUV6rypzX4AuwY0u7EC98qNWrdHVcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787213665; c=relaxed/simple;
	bh=1A5L8ijJG2tEtIq8gJzYCoIWgbA4oubX/xAZRhZJ21E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PqlQ/69kRlwQFdZVR/i4UGgF7hgUzlPcDELlJPhi9nVp1SiLUZMdDBtzKUwrrEOncUQF0SNhyFtwDfk3WcCb3FShP5BM91hB5cwe+lu/vdiIAijV7g1U4oCs7SlVkiiJxdOFYNHRDCbYrcNPZG97aUaWqhtTvbvtj8Lnu37JLLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 21e3cc209c6f11f19a56ed5b684f684d-20260820
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:2e859270-3c3e-4a3d-801b-1fb4af7d294c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:01b2380bf8adf81f379fa11415948ba6,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 21e3cc209c6f11f19a56ed5b684f684d-20260820
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1492087287; Thu, 20 Aug 2026 16:14:14 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ntfs: fix resource leak in ntfs_new_attr_flags
Date: Thu, 20 Aug 2026 16:14:10 +0800
Message-Id: <20260820081410.152325-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When handling resident attributes that don't need sparse/compressed
changes, ntfs_new_attr_flags() returns 0 directly at line 678 without
calling unmap_mft_record() or ntfs_attr_put_search_ctx(). This leaks
the MFT record mapping and attribute search context.

An unprivileged user can cause a denial of service by repeatedly
calling setxattr(2) with system.ntfs_attrib on files with resident
attributes, eventually exhausting kernel memory.

Fix by replacing the direct return with goto err_out to ensure proper
cleanup of resources via the existing cleanup code.

Fixes: e791930240a5 ("ntfs: fix resident conversion in ntfs_new_attr_flags")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs/ea.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
index 5cd5a4a02d1e..44252f2c2ca6 100644
--- a/fs/ntfs/ea.c
+++ b/fs/ntfs/ea.c
@@ -674,8 +674,10 @@ static int ntfs_new_attr_flags(struct ntfs_inode *ni, __le32 fattr)
 	}
 
 	if (!a->non_resident) {
-		if (!(new_aflags & (ATTR_IS_SPARSE | ATTR_IS_COMPRESSED)))
-			return 0;
+		if (!(new_aflags & (ATTR_IS_SPARSE | ATTR_IS_COMPRESSED))) {
+			err = 0;
+			goto err_out;
+		}
 
 		if (le32_to_cpu(a->data.resident.value_length)) {
 			pr_err("Can't change sparse/compressed for non-empty file");
-- 
2.25.1

